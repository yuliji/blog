---
title: 以太坊2.0、POS、信标链和分片都是些啥？
date: 2021-05-27 20:38:14
tags:
---

现在距以太坊2的信标链上线都已经快半年了。但是很多小伙伴对于什么是以太坊2以及相关的一些概念，如：POS、分片、信标链等依然不是很理解。

不久前还有一个朋友问我，说有人叫他赶紧把手里的以太币ETH换成什么ETH2币。

今天我就来简单介绍一下以太坊2.0和相关的一些概念。

## 目前以太坊存在的问题

开始今天的介绍前，我先解答开头提出的问题。

目前并没有什么ETH2币，凡是让你把手里的ETH换成什么ETH2币的都是骗子。

以太坊2简称ETH2，也有人称为以太坊2.0，是以太坊区块链协议的一次重大升级。

以太坊2.0的目标是解决目前以太坊区块链存在的三大问题，那就是：

* 可扩展性
* 安全性
* 可持续发展

可扩展性简单来说就是性能问题。

目前以太坊每秒只能处理十几笔交易。一旦有什么热门的应用，不管是之前的加密猫还是最近的流动性挖矿都会导致交易缓慢和交易手续费高到离谱。

以太坊的愿景是成为一种去中心化的通用计算平台，但是目前这样的性能是远远不能支撑它这个愿景的。

而以太坊2的目标是至少把每秒支持的交易数提高到1000笔。

所谓安全性这里主要是指确保以太坊网络的去中心化，防止个别人控制整个网络从而进行破坏。

目前以太坊的共识机制是POW，也就是挖矿。由于挖矿需要强大的算力又消耗大量电力，导致只有能购买昂贵的设备和有路子搞到便宜电力的一小批人才有资格参与挖矿。这就导致了算力集中。这样部分人攻击甚至控制整个协议的概率就增大了。

之前比特币和BCH比特现金的分叉，据说很大一部分原因就是大矿主和社区其他人利益不一致导致的。

退一步讲，就算我不挖矿，作为普通用户想运行一个全节点来验证和记录区块链上的数据现在也变得越来越困难。

目前运行一个以太坊全节点，至少要存储800G的数据，而且数目还在不断增加。因此不但矿工算力越来越集中，就连全节点也越来越集中。这显然对整个协议的安全性是不利的。

![以太坊全节点数据量](https://raw.githubusercontent.com/yuliji/images/main/imgnodesize.png)

以太坊2的一个目标就是让更多普通人能参与共识机制也让更多的人能更容易地运行一个以太坊的节点。

可持续发展也就是环保问题。

目前以太坊挖矿消耗大量的电力，这种高耗能的算法受到了很多人的批评。要知道气候问题是现在全人类面临的一个巨大挑战。

所以以太坊2计划用一种新的不消耗大量电力的共识算法来支持以太坊的运行。

为实现这三大目标，以太坊2引入了两大机制：
* POS
* shard

## Proof of Stake

所谓POS就是proof of stake，权益证明。它是一种区块链的共识算法。

目前以太坊、比特币和许多成熟的区块链用的共识算法是POW，Proof of work，工作量证明。参与POW就是我们常说的挖矿。

POW的具体原理这里不做详细展开，简单来说参与者投入大量资金来购买硬件，并持续消耗电力来竞争生成区块并获得奖励。

POW的缺点我们之前已经讲过，一个是耗能，另一个是容易导致算力向专业矿工集中。

POS的参与者叫validator——验证者。

validator不需要购买特殊的硬件以及消耗大量电力，它只需要在一台普通的电脑上运行一个程序，并质押一部分虚拟资产。在以太坊上就是32个ETH。

整个网络根据参与者质押资产的数量和参与时间长短按比例随机选择参与者来生成新的区块并得到奖励。

显然由于不需要消耗大量电力POS直接解决了环保问题。

参与以太坊的POS需要质押32个ETH，这个门槛其实也不低。但是就像挖矿有矿池，POS也有质押池。拿不出32个ETH人也可以大家凑份子加入质押池，参与POS并获得收益。

总的来说，虽然POS也有一定门槛，但至少大家不要去抢显卡。你有钱买几个币质押一下还是很方便的，所以应该会有更多的人参与进来。当然至于实际效果怎么样，还是只能靠时间来验证了。

## Shard

其实POS对于解决性能问题也是很重要的，因为它使得shard分片机制成为可能。

目前以太坊只有一条公链，区块是一个一个顺序生成的。那么区块生成的速度和每个区块能记录的交易数量，就决定了以太坊每秒能处理的交易数。

要想提高以太坊的性能，一种方法是区块扩容，让每个区块包含更多的数据。但是这会要求存储区块的节点有更大的硬盘和更好的网络带宽。这样会进一步增加挖矿和运行节点的成本。

之前我们说了一大堆，就是为了说明挖矿和节点成本越高去中心化程度就会越低，也就越不安全。所以以太坊社区一早就放弃了这种方案。

以太坊想要采取的方案叫做分片链shard chain。

简单说就是一条链不够用，我们就跑多条链。就好像一核CPU跑不动了，我们就换多核CPU。这就是shard的原理。

以太坊2里会有多条区块链同时运行，每一条分片链只负责处理部分的交易。

按目前的计划，一开始会有64条区块链同时运行，以后还可能增加。

shard除了可以提高性能，还有另一个好处就是shard上的node只需要验证和保存当前这个shard的数据，而不需要验证和保存整个以太坊的数据。这样可以使得node更小更轻量级，减少对硬件算力和存储的需求，使得更多人能参与进来，增加整个以太坊的去中心化和安全程度。

有小伙伴问，可不可以在POW机制下实现shard呢？

答案是不行。因为shard之后，破坏单条shard链的难度其实是降低了。

POS解决这个问题的方法，一是让验证者质押以太币，如果发现你搞破坏就罚钱，甚至可以把你质押的所有币都罚掉。

但是POW的惩罚方法，是让搞破坏的人挖不到块。他损失的只是挖这些块时消耗的电力，我一看苗头不对，可以金盆洗手，继续扮好人。要想在POW上达到POS没收质押物的效果，就必须连坏人的矿机都没收，这显然是做不到的。

另一方面，以太坊的POS机制会随机分配验证者的shard。这一机制也让破坏者无法盯着某一条链进行破坏，从而增加它的攻击难度。

## 以太坊2升级的各个阶段

由于shard和POS的技术方案很复杂，所以为了避免步子迈得太大而扯到蛋，以太坊2的升级将分成多个阶段进行，也就是会走一步看一步。

首先是第0阶段——信标链。

![信标链](https://raw.githubusercontent.com/yuliji/images/main/imgbeaconchain.png)

信标链是以太坊2的核心。它主要功能是实现POS机制以及协调同步之后的各个shard链。有一链驭众链的意思。

信标链已经在2020年12月1日上线，用户已经可以利用以太坊上的智能合约质押ETH参与POS获得奖励。

需要说明的是虽然信标链已经上线，但它目前的功能只是在实战环境中验证POS等以太坊2的各种基础功能，并没有处理交易和执行智能合约的能力。而且目前质押的ETH和获得的奖励是锁定主无法提取出来的。预计要等到一两年左右才能提取。

信标链和目前的以太坊区块链是平行运行的，也就是目前的以太坊运行基本不受信标链影响。

然后是第1阶段——shard chain 分片链。

这个时候会有64个分片链上线，并与信标链连接，从而构成一个可以相互协作的整体。

这一阶段最重要的一个事件就是现在的以太坊区块链接入信标链。官方叫法叫the docking。

现在的以太坊区块链会变成64个shard链中的一条，这也标志着POW挖矿正式退出以太坊的舞台。

通过这种方式，目前以太坊区块链上的所有数据都会得到完整的保存。这一步也有人称为1.5阶段。

![The Docking](https://raw.githubusercontent.com/yuliji/images/main/imgdocking.png)

按最初的计划，目前的以太坊区块链是作为最后一个shard加入，但是为了加速以太坊向POS的迁移核心团队现在决定把当前的以太坊区块链作为第一个shard加入。预计完成时间也从2022年提前到了今年2021年。

这一阶段的主要目标是把以太坊切换到POS，并实现和验证shard机制。

除了原始以太坊这根链以外，其他的shard链一开始只提供数据存储而不提供执行智能合约的能力。

要让整个以太坊2实现以太坊虚拟机，从而提供通用的计算能力则需要等到第2阶段。

但是按照官方的说法，仅仅提供数据存储，再加上一些二层方案就已经能够大大提高以太坊的处理能力。有人甚至认为这样已经足够了，所以可能根本没必要进行后面的第二阶段。

简单说第二阶段的具体细节还没确定，这些细节甚至有没有这个阶段，都要等到之前的阶段逐步实现后才会确定。

# 总结

最后总结一下：

以太坊2是以太坊的一次重大升级，目的是通过实现POS和shard来解决目前以太坊的三大问题：性能、安全性和可持续发展。

目前信标链已经上线，以太坊开发团队正努力把目前的以太坊链接到信标链上，从而完成从POW挖矿向POS的过渡。

如果你持有ETH目前并不，需要做任何的转换操作。任何要求你进行ETH到其他币的转换都是骗子，千万不要上当了。

当然你也可以质押32个ETH来参与POS并获得收益，但是你的ETH本金和收益会被锁定，锁定期限不确定。大家一定要掌握好风险。
