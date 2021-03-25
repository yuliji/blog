---
title: 用GitHub Actions自动发布Hexo博客
date: 2021-03-25 19:43:38
tags:
  - GitHub
  - GitHub Actions
---

GitHub Actions是GitHub推出的持续集成服务。

我们可以把一个Action理解为一小段特定功能的脚本，多个Action能够组成一个Workflow，Workflow由各种GitHub的事件触发。我们可以用GitHub Actions来做软件的持续集成（CI）和持续部署（CD）

在这篇文章里，我向大家介绍我是如何用GitHub Actions来自动化发布我的Hexo博客的。

## Hexo和GitHub Pages

我的个人博客[刀十一的DevOps小站](https://yuliji.github.io/)是用Hexo生成的。想了解Hexo的朋友可以去[Hexo官网](https://hexo.io/)。

Hexo生成静态文件后，我会把这些文件提交到[GitHub Pages](https://pages.github.com/)的代码仓库。这样就能利用GitHub Pages拥有一个免费的个人博客了。

之前，我一直是在自己电脑上手动完成发布博客的操作，流程如下：

* 在`Hexo库`里写博客文章 (https://github.com/yuliji/blog)
* 用`hexo generate`生成静态文件
* 把静态文件复制到`Pages库` (https://github.com/yuliji/yuliji.github.io)
* 在`Pages库`里`commit`并`push`代码，发布。

当看到Github Actions的介绍后，我就有了用Github Actions自动发布博客的想法。



## 用GitHub Actions自动发布博客

我的设计是这样的，所有代码都在`Hexo库`里。

* `Hexo库`里创建两个Github Actions的workflow：`Build Pages`和`Publish Pages`
* `Build Pages`由`master`分支的`push`事件触发。他的主要功能就是用`hexo generate`生成静态文件，把这些静态文件打包、创建并上传到一个新的[Github Release](https://docs.github.com/en/github/administering-a-repository/about-releases)里
* 创建release的操作触发`Publish Pages`，这个workflow会clone我的`Pages库`，下载最新的release里的静态文件包，解压到`Pages库`，commit & push

![整体思路](https://raw.githubusercontent.com/yuliji/images/main/img20210325214822.png)

具体的实现步骤如下：
1. 创建`build.sh`脚本。该脚本负责生成静态文件、打包、上传。这个脚本在本地电脑也可以运行。
1. 创建`gh_action_build.sh`脚本。该脚本在Github Action里运行。主要是调用`build.sh`，但是事先要安装一些必要的npm库。
1. 在https://github.com/settings/tokens 获取一个Personal access token。因为我们的`build.sh`里用到了Github CLI工具`gh`。这个命令需要用到这个token来授权。
1. 把这个Personal access token，添加到`Hexo库`的secrets里。
![添加secrets](https://raw.githubusercontent.com/yuliji/images/main/imgsecrets.png)
1. 创建YAML文件定义`Build Pages`，这边主要功能就是注入上边的那个token然后调用`gh_action_build.sh`。完整代码在[这里](https://github.com/yuliji/blog/blob/master/.github/workflows/build_page.yml)
```yaml
- name: Generate pages
  env:
    GITHUB_TOKEN: ${{ secrets.TOKEN }} # 注入token

  run: ${GITHUB_WORKSPACE}/bin/gh_action_build.sh # 调用脚本
```
1. 创建`publish`脚本。该脚本下载最新的release中的静态文件包，解压到`Pages库`，commit & push。
1. 用`ssh-keygen`创建一对秘钥。因为我们在`Hexo库`的actions里操作`Pages库`，所以需要授权actions的git命里来修改`Pages库`
1. 把上边生成的公钥加到`Pages库`的deploy key里，并赋予写权限。
![添加deploy key](https://raw.githubusercontent.com/yuliji/images/main/imgdeploykey.png)
1. 把上边生成的私钥加到`Hexo库`的secrets里。
1. 创建YAML文件定义`Publish Pages`。这个workflow里需要clone两个代码库，然后调用`publish`脚本。其中`Pages库`的ssh key需要用上边设置的私钥。完整代码在[这里](https://github.com/yuliji/blog/blob/master/.github/workflows/publish.yml)
```yaml
- uses: actions/checkout@v2
  with:
    repository: 'yuliji/yuliji.github.io'
    path: 'pages'
    ssh-key: ${{ secrets.PAGE_REPO_SSH_KEY }}  # 用有写权限的key操作Pages库
```

## 完成

这样，我只需要把最新的文章提交到Hexo库的master分支，新文章就自动发布到Github Pages了。

![每次push自动运行](https://raw.githubusercontent.com/yuliji/images/main/img20210325220017.png)

