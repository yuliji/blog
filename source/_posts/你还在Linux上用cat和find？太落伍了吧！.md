---
title: 你还在Linux上用cat和find？太落伍了吧！
date: 2021-04-06 20:20:43
tags: tools
---
> 除了把Linux上已有的命令行工具重写一遍，Rust还能干啥呢？

以上是Rust社区里流传的一个梗。Rust号称是适合系统级编程的语言，但是Rust社区里有些人自嘲，说除了能用Rust把Linux上已经有的命令行工具重写一遍，似乎也没啥其它用处。

不过我在Github上还真的找到了几个用Rust实现的好用的Linux命令的增强版替代品，今天先介绍同一个大牛写的三个命令行工具：

* bat：增强版cat
* fd：增强版find
* hexyl： 二进制文件查看器

## bat：增强版cat

Github地址：https://github.com/sharkdp/bat

Linux命令行里，大家都习惯用`cat`查看文件内容，`bat`是一个增强版的`cat`，它主要功能也是查看文件内容，不过它还有其它一些高级功能。

比如：

它支持多种编程语言的语法高亮。

![语法高亮](https://camo.githubusercontent.com/7b7c397acc5b91b4c4cf7756015185fe3c5f700f70d256a212de51294a0cf673/68747470733a2f2f696d6775722e636f6d2f724773646e44652e706e67)

还可以显示`git`管理下的文件的修改状况

![git整合](https://camo.githubusercontent.com/c436c206f2c86605ab2f9fb632dd485afc05fccbf14af472770b0c59d876c9cc/68747470733a2f2f692e696d6775722e636f6d2f326c53573452452e706e67)

用`-A`高亮显示不可打印的字符

![高亮显示特殊字符](https://camo.githubusercontent.com/643244c46834769e0ea2802e15518c49e0c7cf10aa82d00c7c69a406f2aa161d/68747470733a2f2f692e696d6775722e636f6d2f576e64477039482e706e67)

## fd：增强版find

Github地址：https://github.com/sharkdp/fd

Linux命令行里，`find`命令是用来查找文件的，不过`find`命令的各种参数有点复杂难记。

`fd`是一个`find`命令的替代品，除了用法更直观，性能也比`find`高不少。

主要特性有

* `fd app`直接找文件名包含app的文件，用法比`find`直观
* `fd '^[A-Z]'`直接用正则表达式
* `fd sh --type f`查找包含`sh`的普通文件
* `fd -e md`查找扩展名为`md`的文件

![演示](https://github.com/sharkdp/fd/raw/master/doc/screencast.svg)

## hexyl：二进制查看工具

Github地址：https://github.com/sharkdp/hexyl

废话不说，直接上图

![演示](https://camo.githubusercontent.com/585a9f1ed1828f21ba1d4faa2720627c649c73b0ba75cb98aacdf0ca300957eb/68747470733a2f2f692e696d6775722e636f6d2f4d574f3975534c2e706e67)
