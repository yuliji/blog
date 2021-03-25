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
* `hexo generate`生成静态文件
* 把静态文件复制到`Pages库` (https://github.com/yuliji/yuliji.github.io)
* 在`Pages库`里`commit`并`push`代码，发布。

当看到Github Actions的介绍后，我就有了用Github Actions自动发布博客的想法。



## 用GitHub Actions自动发布博客

我的设计是这样的，所有代码都在`Hexo库`里。

* `Hexo库`里创建两个Github Actions的workflow：`Build Pages`和`Publish Pages`
* `Build Pages`由`master`分支的`push`事件触发。他的主要功能就是用`hexo generate`生成静态文件，把这些静态文件打包、创建并上传到一个新的[Github Release](https://docs.github.com/en/github/administering-a-repository/about-releases)里
* 创建release的操作触发`Publish Pages`，这个workflow会clone我的`Pages库`，下载最新的release里的静态文件包，解压到`Pages库`，commit & push

具体的实现步骤如下：
1. 创建`build.sh`脚本。该脚本负责生成静态文件、打包、上传。这个脚本在本地电脑也可以运行。
1. 创建`gh_action_build.sh`脚本。该脚本在Github Action里运行。主要是调用`build.sh`，但是事先要安装一些必要的npm库。
1. 在[]https://github.com/settings/tokens）获取一个Personal access token。因为我们的`build.sh`里用到了Github CLI工具`gh`。这个命令需要用到这个token来授权。
1. 把这个Personal access token，添加到`Hexo库`的secrets里。
1. 创建YAML文件定义`Build Pages`，这边主要功能就是注入上边的那个token然后调用`gh_action_build.sh`。具体代码在[这里](https://github.com/yuliji/blog/blob/master/.github/workflows/build_page.yml)

```yaml
- name: Generate pages
  env:
    GITHUB_TOKEN: ${{ secrets.TOKEN }} # 注入token

  run: ${GITHUB_WORKSPACE}/bin/gh_action_build.sh # 调用脚本
```

这两个workflow的定义其实很简单，感兴趣的朋友可以在[这里](https://github.com/yuliji/blog/tree/master/.github/workflows)查看源代码。

Build Pages的定义文件build_page.yml主要就是注入了GITHUB_TOKEN然后调用了gh_action_build.sh这个脚本。

gh_action_build.sh安装了一些npm包，然后调用了build.sh这个脚本。

build.sh才是真正的脚本。

这里需要注意的是，build.sh用到了Github CLI工具gh。gh是需要认证的，之前注入的GITHUB_TOKEN就是用来认证的。如果没有这个GITHUB_TOKEN，运行gh之前要进行交互式的登陆操作。

这个在https://github.com/settings/tokens生成，在项目设定的Secrets里添加到项目里。

Publish Pages这个workflow会clone Github Pages代码仓库，然后调用publish脚本。

publish脚本下载最新release里的静态文件包，解压到Github Pages代码仓库，然后commit & push

由于这个workflow是在Hexo代码仓库里push pages仓库，所以需要配置相应的权限。

具体方法是在pages仓库里获取Deploy keys，这个key需要有写权限。

然后把这个key加到Hexo仓库的secrets里。

最后在Publish Pages的定义里指明用这个key来操作pages库。

这样，我只需要把最新的文章提交到Hexo库的master分支，新文章就自动发布到Github Pages了。

