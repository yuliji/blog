---
title: 用GitHub Actions自动发布hexo博客
date: 2021-03-25 19:43:38
tags:
  - GitHub
  - GitHub Actions
---

`GitHub Actions`是`GitHub`推出的持续集成服务。

我们可以把一个`Action`理解为一小段特定功能的脚本，多个`Action`能够组成一个`Workflow`，`Workflow`由各种`GitHub`的事件触发。我们可以用`GitHub Actions`来做软件的持续集成（CI）和持续部署（CD）

在这篇文章里，我向大家介绍我是如何用`GitHub Actions`来自动化发布我的`hexo`博客的。

## hexo和GitHub Pages

我的个人博客[刀十一的DevOps小站](https://yuliji.github.io/)是用hexo生成的。

hexo生成静态文件后，我会把这些文件提交到GitHub Pages的代码仓库。这样就能利用GitHub Pages拥有一个免费的个人博客了。

之前，我一直是在自己电脑上手动完成发布博客的操作，流程如下：

* 在hexo代码仓库里写博客文章
* hexo generate生成静态文件
* 把静态文件复制到GitHub Pages代码仓库
* 在GitHub Pages代码仓库commit并push代码，发布。

当看到Github Actions的介绍后，我就有了用Github Actions自动发布博客的想法。



## 用GitHub Actions自动发布博客

我的设计是这样的。

* hexo代码仓库里创建两个Github Actions的workflow：Build Pages和Publish Pages
* Build Pages由master branch的push事件触发，它运行`hexo generate`生成静态文件，把这些静态文件打包并创建并上传到一个新的release里
* 创建release的操作触发Publish Pages，这个workflow会clone我的GitHub Pages代码仓库，下载最新的release里的静态文件包，解压到GitHub Pages代码仓库，commit & push

这两个workflow的定义其实很简单，感兴趣的朋友可以在[这里](https://github.com/yuliji/blog/tree/master/.github/workflows)查看源代码。

Build Pages的定义文件build_page.yml主要就是注入了GITHUB_TOKEN然后调用了gh_action_build.sh这个脚本。

gh_action_build.sh安装了一些npm包，然后调用了build.sh这个脚本。

build.sh才是真正负责生成静态文件、打包、上传的脚本。

这里需要注意的是，build.sh用到了Github CLI工具gh。gh是需要认证的，之前注入的GITHUB_TOKEN就是用来认证的。如果没有这个GITHUB_TOKEN，运行gh之前要进行交互式的登陆操作。

这个在https://github.com/settings/tokens生成，在项目设定的Secrets里添加到项目里。

Publish Pages这个workflow会clone Github Pages代码仓库，然后调用publish脚本。

publish脚本下载最新release里的静态文件包，解压到Github Pages代码仓库，然后commit & push

由于这个workflow是在hexo代码仓库里push pages仓库，所以需要配置相应的权限。

具体方法是在pages仓库里获取Deploy keys，这个key需要有写权限。

然后把这个key加到hexo仓库的secrets里。

最后在Publish Pages的定义里指明用这个key来操作pages库。

这样，我只需要把最新的文章提交到hexo库的master分支，新文章就自动发布到Github Pages了。

