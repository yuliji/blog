---
title: TITAN币是如何一夜归零的？
date: 2021-08-08 12:26:29
tags:
---

上一篇文章我们介绍了稳定币的原理，并提到稳定币都是有风险的，尤其是算法稳定币，目前没有很成功的案例。

前不久，算法稳定币项目，IRON Finance就发生了其项目代币一夜归零的事件。今天我们就来回顾一下这次崩盘事件，希望能让大家对类似项目的风险有个直观的了解。

<iframe src="//player.bilibili.com/player.html?aid=759663912&bvid=BV1T64y1z753&cid=384722708&page=1" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/S9QC68u97cs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# IRON 稳定币和TITAN项目币

Iron Finance项目的目标是打造一个锚定美元的算法稳定币，IRON。IRON Finance在币安区块链和polygon上都有部署，polygon是一个以太坊的二层扩容方案，目的是提高以太坊的交易速度，降低交易手续费。关于polygon这里先挖个坑，以后有机会再详细介绍。

为了简单起见，我们今天只介绍polygon平台上的情况，币安链上的机制是一摸一样的。

IRON号称是一种部分抵押的算法稳定币，目标是软锚定美元，也就是IRON价格在1美元附近小幅波动。

IRON的机制是这样的，用户可以铸造或兑换IRON币。

所谓铸造就是用户向智能合约里抵押USDC和TITAN币，合约给你等价值的IRON币。这里USDC是一种法币抵押型稳定币，关于法币抵押型稳定币的原理，可以参考我们上一篇文章。这里可以简单理解USDC是比较靠谱的稳定币，是一种硬通货。而TITAN是IRON Finance自己的项目代币，我研究了半天项目文档也没搞明白TITAN除了炒作还有啥用处

铸造IRON时抵押的USDC和TITAN的比例由Target Collateral Ratio (TCR), 决定，TCR表示铸造IRON时需要USDC的比例。比如，TCR为75%时，你抵押价值75美元的USDC和25美元的TITAN，合约给你100个IRON，而这100个IRON的价值就由你抵押的价值100美元的USDC和TITAN支持。

TCR初识为100%，之后会动态调整，当IRON大于1美元时，TCR会调低，也就是说铸造时需要少一点硬通货USDC，当IRON小于1美元时，TCR会调高，铸造时会需要多一点硬通货USDC

![铸造](https://raw.githubusercontent.com/yuliji/images/main/imgtcr.png)

同时，用户也可以用IRON兑换出USDC和TITAN。获得的USDC和TITAN由Effective Collateral Ratio (ECR)决定。ECR就是当前合约中USDC和TITAN的数量比。比如ECR为70%时，你兑换100IRON将得到价值70美元的USDC和价值30美元的TITAN

![兑换](https://raw.githubusercontent.com/yuliji/images/main/imgecr.png)

IRON锚定美元的机制需要依靠用户的套利行为。

如果IRON小于一美元，比如0.9美元，那用户可以用900美元买1000个IRON，然后兑换出价值1000美元的usdc和titan，获利100美元。这种行为会减少IRON的流通和供应，从而抬高IRON币价

如果IRON大于1美元比如1.1美元，那用户可以抵押价值1000美元的usdc和titan换出1000IRON，并出售得到1100美元，获利100美元。这种行为会增加IRON的供应，从而降低币价。

由于这些套利行为的存在，理论上IRON的币价会在1美元所有浮动，这就是所谓的软性锚定

所谓部分抵押就是说，所有流通的IRON是由USDC和TITAN的价值支持的，明面上USDC加TITAN的价值和流通IRON是一样的，但是其中只有USDC是确定价值的硬通货，而TITAN的价值是不确定的，甚至到底有没有价值都不好说。所以IRON只有部分价值是由比较靠谱的抵押物支撑的。

老实说，我一直搞不明白把一个没啥用的TITAN币塞进这个稳定币的机制里到底有啥意思。不过我看不懂并不妨碍，这个项目以及TITAN币的火爆。

该项目的锁仓资金一度超过20亿美元，据说是当时Polygon平台锁仓量第二的项目。其项目比TITAN最高到60多美元一枚。

其实在当时就有有识之士警告TITAN价格严重高估，存在巨大风险。不过估计当时大家最多以为TITAN币价最多暴跌一下， 谁也没想到会归零

# 归零

![](https://raw.githubusercontent.com/yuliji/images/main/imgzero.png)

在北京时间2021年6月16日 18点左右，有大户抛售大量TITAN和IRON币，这一行为一方面导致TITAN币价格在两个小时内从65美元被腰斩到30美元，另一方面导致IRON币大跌，价值和美元脱钩。

不过，稍后TITAN价格得到支持，币价反弹回52美元，而IRON币由于触发了套利稳定机制，其币价也恢复到了1美元左右。

就在大家庆幸这个项目再一次经受了考验的时候，意想不到的事情发生了。大户再次抛售，这下导致了用户恐慌性抛售TITAN和IRON。

由于IRON再次脱钩，于是套利机制再次被触发，用户开始把IRON兑换成USDC和TITAN。

第一次下跌的时候，由于TITAN币价得到支持反弹，所以套利者兑换IRON后，很大一部分会持有TITAN，期待进一步上涨获利。但是在第二次恐慌性抛售的时候，TITAN币价一路下跌，所以套利者会立马抛售到手的TITAN

这导致TITAN进一步下跌，而由于TITAN下跌导致其支撑的IRON的内在价值下跌，同时由于恐慌中没人愿意接盘IRON。所以最好的做法还是继续用IRON兑换并抛售TITAN

![死亡螺旋](https://raw.githubusercontent.com/yuliji/images/main/imgdead.png)

TITAN下跌导致IRON脱钩，IRON脱钩导致套利产生TITAN抛售，TITAN进一步下跌导致IRON继续脱钩。就这样，TITAN在这一疯狂的死亡螺旋中迅速归零，而IRON也再也没有和美元挂钩。

这一事件导致币圈韭菜尸横遍野，惨不忍睹。

事后分析TITAN归零事件，我们不难得出结论，IRON稳定币的运作机制有着先天缺陷。IRON由硬通货USDC和几乎是空气币的TITAN共同支持价格。TITAN火的时候，币价步步高，IRON内在价值也会增加，使其更稳固，似乎这个稳定币就更靠谱，这样增加了用户的信心，又进一步推高TITAN的价格。

这一过程貌似是正反馈良性循环，其实无非是空中楼阁。毕竟拉着自己的头发是不可能上月球的。

我们仔细想想，这里的TITAN币除了炒作外几乎没有任何价值的。虽说币圈很多币都有泡沫，但是泡沫也有大有小。像比特币以太坊这种，你挤掉点泡沫还是能剩点干货的。TITAN归零就说明他就是纯泡沫。这不，只要大户一抛售，良性循环立马变成恶性循环，一直到归零为止。

当然，像我这样事后分析头头是道的人不在少数，但是在事情发生的当下，尤其当时TITAN币暴涨的情况下，能冷静识别风险的就难能可贵了。

总之币圈有风险，投资要谨慎。