---
title: 2021年DevOps工程师的必备技能
date: 2021-05-19 20:20:39
tags: DevOps
---

DevOps即涉及到Dev开发，又涉及到Ops运维，所以DevOps工程师的技能树很宽，涉及到很多个领域，而且每个领域又会有多个相似的工具。别说新人了，就连很多老鸟都会觉得东西太多，学不过来。

我的策略是，在每个领域学习和掌握一个工具。掌握一个工具后，其它工具往往能够触类旁通。如果你已经在单位里从事DevOps工作，那自然是掌握单位里使用的工具。如果是初学者，我这里推荐几个我认为最主流的工具。

## 版本管理：Git

不管是支持开发工程师，还是DevOps本身的Infrastructure as code都离不开代码的版本管理工具。目前最主流的版本管理攻击自然是Git，而最主流的Git代码库平台就是GitHub。

建议DevOps工程师掌握基本的Git操作，学习常见的Git Flow，并熟悉GitHub的相关配置。

我认为GitHub里最有用的功能是web hook，用web hook可以整合其它工具实现一些很酷的功能。

## 操作系统： Linux

目前大多数的应用都是部署在Linux系统上，所以DevOps工程师要掌握基础的Linux概念，学会用基本的Linux命令行操作。

最好还能掌握一点Bash脚本。不过我没有花太多时间学习Bash脚本，因为我倾向于用Python写复杂的脚本。

此外，还建议DevOps工程师掌握基本的网络知识，如：IP、DNS、HTTP、HTTPS等，以及一些基本的系统安全知识，比如如何配置用户、用户组、基于秘钥的ssh、防火墙等。

## 云平台：AWS或阿里云

代码自然要部署到服务器上，现在基本都用云服务器了。

现在主流云平台除了提供云服务器，还提供各种其它服务，比如数据库、消息队列、对象存储等。所以掌握一个云平台的基本操作就很重要。

我认为公有云平台做的最好的依然是AWS，但是国内用的最多的还是阿里云，我建议从这两个里面选一个开始学习。

## 代码构建和自动测试：根据你需要支持的编程语言

把Dev的代码部署到Ops的平台上离不开代码构建、包管理和自动测试。

这里就要根据你需要支持的语言选择不同技术，比如Java的Maven、Javascript的npm或yarn。

## CI/CD：Jenkins

当然我们不希望所有的构建和测试都是手动执行的，而是能够自动地、持续不断地执行，最好还能持续部署到生产环境。

这就涉及到CI/CD平台。

最老牌最成熟的CI/CD平台自然是Jenkins。不过我认为它有点太老旧和繁琐了，所以大家也可以看看GitLab或者GitHub Actions。

## 容器引擎：Docker

容器技术现在越来越火，它不仅可以把一台服务器拆成几台来用，还改变了软件开发的模式。而目前最主流的容器引擎自然就是Docker。

## 容器编排：Kubernetes

如果你只在一台服务器上部署少量容器，那直接用Docker或者Docker compose就好了。但是如果你有多台服务器，部署成百上千个容器，那你就需要一个容器编排系统了。

Kubernetes基本已经成为容器编排系统的业界标准了，强烈建议DevOps工程师学习一下。

## 监控：Prometheus

系统越来越复杂，要掌握系统的运行状态就越难。我们当然不想把用户的投诉来当报警，所以监控系统就很重要。

目前比较先进的监控系统就是Prometheus，和传统的监控系统比，它更适合容器环境。

## 基础架构即代码：Terraform、Ansible

我们已经讲了么多系统了，没错，DevOps就是要管那么多东西。

我们不希望所有这些系统都是手工配置的，我们希望通过代码来自动配置这些系统，一方面自动配置不容易出错。另一方面，我们可以用Git管理配置文件，这样方便追溯配置的改变。

基础设施配置方面最好用的工具是Terraform。我们公司所有云资源、GitHub和CICD pipeline都是用Terraform配置的。

操作系统和应用配置方面我推荐Ansible，它比较轻量级，上手快。

## 脚本语言：Python

即使有了那么多工具，还是免不了要自己写脚本实现某些功能，或者把各个系统联系起来。所以掌握一个脚本工具就很重要。
我推荐Python，简单易学，各种库也很完备。

以上就是我推荐的DevOps相关工具，难免有些主观。如果你有好的工具，可以留言讨论。

