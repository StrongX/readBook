import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class BookRack extends StatefulWidget {
  @override
  BookRackState createState() => new BookRackState();
}

class BookRackState extends State<BookRack> {
  var data = '{"code":0,"msg":{"news":{"data":[{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98642/kubernetes-1-9-10-and-1-9-11-beta0-released","id":"S3ViZXJuZXRlcyAxLjkuMTAg5ZKMIDEu","newsType":"project","summary":"Kubernetes 1.9.10 和 1.9.11-beta.0 版本发布了。Kubernetes 是一个开源的，用于管理云平台中多个主机上的容器化的应用，Kubernetes 的目标是让部署容器化...","thumb":"https://static.oschina.net/uploads/logo/kubernetes_EGYxB.png","timeStr":"2018-08-04","title":"Kubernetes 1.9.10 和 1.9.11-beta.0 版本发布"},{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98641/framework7-3-1-1-released","id":"RnJhbWV3b3JrNyAzLjEuMSDlj5HluIPv","newsType":"project","summary":"Framework7 3.1.1 发布了，Framework7 是一个开源的全功能 HTML 框架，用于构建具有 iOS 和 Android 原生外观的混合移动应用程序或 Web 应用程序。同时 Fr...","thumb":"https://static.oschina.net/uploads/logo/framework7_l62b3.png","timeStr":"2018-08-04","title":"Framework7 3.1.1 发布，全功能 HTML 框架"},{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98640/neo4j-3-5-0-alpha06-released","id":"TmVvNGogMy41LjAtYWxwaGEwNiDlj5Hl","newsType":"project","summary":"Neo4j 3.5.0-alpha06 发布了，目前暂未发现相关更新信息，您可以查看提交记录了解具体内容。 Neo4j 是世界领先的高性能图数据库，具备成熟和健壮的数据库的所有特性，如友好的查询语言和...","thumb":"https://static.oschina.net/uploads/logo/neo4j_nKsWt.png","timeStr":"2018-08-04","title":"Neo4j 3.5.0-alpha06 发布，高性能图数据库"},{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98639/opt-20-3-8-4-released","id":"T1RQIDIwLjMuOC40IOWPkeW4g++8jEVy","newsType":"project","summary":"OTP 20.3.8.4 发布了，OTP (Open Telecom Platform) 是一个用 Erlang 编写的应用服务器，它是一套 Erlang 库，由 Erlang 运行时系统、主要使用 ...","thumb":"","timeStr":"2018-08-04","title":"OTP 20.3.8.4 发布，Erlang 编写的应用服务器"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98658/tencent-opensource-sluaunreal","id":"6IW+6K6v5byA5rqQIEx1YSDlvIDlj5Hm","newsType":"industry","summary":"近日，腾讯开源了其用于游戏业务的 sluaunreal，该项目是适用于 unreal4 引擎的 Lua 开发插件，可让开发者高效地使用 Lua 进行业务开发。 项目地址：https://github....","thumb":"","timeStr":"2018-08-04","title":"腾讯开源 Lua 开发插件 sluaunreal，加速游戏业务开发"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":1,"detailUrl":"https://www.oschina.net/news/98657/miit-on-development-of-ipv6","id":"5bel5L+h6YOo77ya5Y+R5bGV5Z+65LqO","newsType":"industry","summary":"8 月 3 日，工业和信息化部信息通信发展司召开了 IPv6 规模部署及专项督查工作全国电视电话会议。 据工信部官网介绍，会议指出，发展基于 IPv6 的下一代互联网，不仅是互联网演进升级的必然趋势，...","thumb":"","timeStr":"2018-08-04","title":"工信部：发展基于 IPv6 的下一代互联网，很重要！"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98656/the-development-of-the-early-internet","id":"5LuOIE5ldHNjYXBlIOa1j+iniOWZqOiu","newsType":"industry","summary":"来源：https://www.huxiu.com/article/255119.html  作者：42章经曾翔 写这篇文章的初衷是看到“42章经”的一篇推送，讲古典互联网和区块链观，勾起了我对“互联网...","thumb":"","timeStr":"2018-08-04","title":"从 Netscape 浏览器讲起，看早期互联网的潮涨潮落"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://my.oschina.net/meituantech/blog/1922037","id":"SmVua2lucyDnmoQgUGlwZWxpbmUg6ISa","newsType":"industry","summary":"Jenkins构建也有很多种方式，现在使用比较多的是自由风格的软件项目（Jenkins构建的一种方式，会结合SCM和构建系统来构建你的项目，甚至可以构建软件以外的系统）的方式。针对单个项目的简单构建，...","thumb":"","timeStr":"2018-08-04","title":"Jenkins 的 Pipeline 脚本在美团餐饮 SaaS 中的实践"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98654/windows-10-and-google-chrome-see-a-rise-in-the-market-share","id":"5pWw5o2u5pi+56S6IFdpbmRvd3MgMTAg","newsType":"industry","summary":"互联网技术市场份额统计网站 NetMarketShare 2018 年 7 月份的数据已经公布了，其中显示 Windows 10 和 Chrome 市场份额都在上涨。 操作系统方面，Windows 1...","thumb":"https://www.oschina.net/img/logo/windows.gif?t=1532509775000","timeStr":"2018-08-04","title":"数据显示 Windows 10 和 Chrome 市场份额都在上涨"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/p/remotectrl","id":"cmVtb3RlQ3RybCDigJQg5Z+65LqOIGhl","newsType":"industry","summary":"remoteCtrl 是使用 hessian 封装做的远程调用 webservice 工具，目标是实现多种协议实现客户机对主机资源的调用。IMWS 部署于主机端，接受 IMCLIENT 发来的指令操作...","thumb":"","timeStr":"2018-08-04","title":"remoteCtrl — 基于 hessian 的远程调用工具"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://gitee.com/eric_ds/jnet","id":"56CB5LqR5o6o6I2QIHwgSm5ldCDmoYbm","newsType":"industry","summary":"Jnet框架是Java AIO接口体系中一层薄封装，仅进一步降低其编程复杂性，不提供额外的抽象。AIO 异步特性相对于NIO来说使得编程更加容易，API也更容易理解。但要构筑一个完善的网络IO层仍然需...","thumb":"","timeStr":"2018-08-04","title":"码云推荐 | Jnet 框架简化基于 AIO 的 Java 网络 IO 编程"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":1,"detailUrl":"https://www.oschina.net/translate/webassembly-and-go-a-look-to-the-future","id":"5Y2P5L2c57+76K+RIHwgV2ViQXNzZW1i","newsType":"industry","summary":"目前我关注 WebAssembly 也已经有段时间了，期望它能让我在没有典型 JavaScript 构建的情况下编写 Web 应用程序。当听到 WebAssembly(wasm) 最近支持 Go 语言...","thumb":"","timeStr":"2018-08-04","title":"协作翻译 | WebAssembly 和 Go：对未来的观望"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98649/firefox-63-linux-out-of-process-extensions","id":"TGludXgg56uvIEZpcmVmb3ggNjMg5omp","newsType":"industry","summary":"Mozilla的网页浏览器在去年经历了有史以来最大的版本更迭，并启用了Firefox Quantum全新的名字。此后Mozilla又不断为其新添了诸多新功能，例如在Nightly版本引入了阻止自动播放...","thumb":"https://static.oschina.net/uploads/logo/firefox_Il1fs.png","timeStr":"2018-08-04","title":"Linux 端 Firefox 63 扩展程序将默认独立进程"},{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98648/keycloak-4-2-1-released","id":"S2V5Y2xvYWsgNC4yLjEg5Y+R5biD77yM","newsType":"project","summary":"Keycloak 4.2.1 发布了，Keycloak 是一个针对现代应用程序和服务的开源身份和访问管理，为应用程序和安全服务添加最小化身份验证。无需处理存储用户或验证用户，开箱即用。 此版本修复了一...","thumb":"https://static.oschina.net/uploads/logo/keycloak_CcOUK.png","timeStr":"2018-08-04","title":"Keycloak 4.2.1 发布，身份和访问管理系统"},{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98647/wordpress-4-9-8-released","id":"V29yZFByZXNzIDQuOS44IOWPkeW4g++8","newsType":"project","summary":"WordPress 开发团队刚刚发布了 WordPress 4.9.8 升级版本。这一版本修复了 46 处 bug、改进，包括自带的 2017 主题；最大的亮点是「呼吁」用户使用古腾堡编辑器。 呼吁用...","thumb":"https://www.oschina.net/img/logo/wordpress.png?t=1532509775000","timeStr":"2018-08-04","title":"WordPress 4.9.8 发布，呼吁使用「古腾堡」编辑器"},{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98646/seafile-6-2-4-released","id":"U2VhZmlsZSB2Ni4yLjQg5Y+R5biD77yM","newsType":"project","summary":"Seafile v6.2.4 发布了，Seafile 是一款国产开源的网盘云存储软件。它提供更丰富的文件同步和管理功能，以及更好的数据隐私保护和群组协作功能。Seafile 支持 Mac、Linux、...","thumb":"https://static.oschina.net/uploads/logo/seafile_T8GnB.png","timeStr":"2018-08-04","title":"Seafile v6.2.4 发布，开源文件云存储"},{"author":"达尔文","authorImg":"https://static.oschina.net/uploads/user/1451/2903254_50.jpg?t=1525627279000","commCount":0,"detailUrl":"https://www.oschina.net/news/98645/yarn-1-9-3-and-1-9-4-released","id":"WWFybiAxLjkuMyDlkowgMS45LjQg5Y+R","newsType":"project","summary":"Yarn 1.9.3 和 1.9.4 发布了。Yarn 是 Facebook 推出的 JavaScript 包管理器，旨在提供 npm 之外的另一种选择方案。Yarn 具有极佳的伸缩性，可以支持成千上...","thumb":"https://static.oschina.net/uploads/logo/yarn-js_rSKLj.png","timeStr":"2018-08-04","title":"Yarn 1.9.3 和 1.9.4 发布，JavaScript 包管理器"},{"author":"snowinszut","authorImg":"https://www.oschina.net/img/portrait.gif","commCount":0,"detailUrl":"https://www.oschina.net/news/98659/cdnbye-0-2-0-released","id":"Q0ROQnllIHYwLjIuMCDlt7Llj5HluIPv","newsType":"project","summary":"本软件通过WebRTC datachannel技术，在不影响用户体验的前提下，最大化p2p率，从而为视频网站节省带宽成本。 v0.2.0更新如下： 1. 重写服务端程序，支持负载均衡，服务更加稳定可靠...","thumb":"","timeStr":"2018-08-04","title":"CDNBye v0.2.0 已发布，视频网站 P2P 解决方案"},{"author":"局长","authorImg":"https://static.oschina.net/uploads/user/1360/2720166_50.jpg?t=1470892376000","commCount":0,"detailUrl":"https://www.oschina.net/news/98614/glibc-2-28-released","id":"5qCH5YeGIEMg6K+t6KiA5bqTIEdsaWJj","newsType":"project","summary":"GNU C Library 每 6 个月发布一次版本，现在又到了新版本发布的时间。最新的 Glibc 2.28 已经发布。 更新内容 支持 statx 支持  ISO C 线程 引入 renameat...","thumb":"","timeStr":"2018-08-03","title":"标准 C 语言库 Glibc 2.28 发布，支持 Unicode 11.0.0 "},{"author":"局长","authorImg":"https://static.oschina.net/uploads/user/1360/2720166_50.jpg?t=1470892376000","commCount":0,"detailUrl":"https://www.oschina.net/news/98613/spring-cloud-finchley-sr1-released","id":"U3ByaW5nIENsb3VkIEZpbmNobGV5LlNS","newsType":"project","summary":"Spring Cloud Finchley 的 Service Release 1 (SR1) 版本已发布，本次更新主要是对其包含的一些模块进行了升级，查看发布说明以了解更多信息。Spring Clo...","thumb":"https://static.oschina.net/uploads/logo/spring-cloud_qcmeL.png","timeStr":"2018-08-03","title":"Spring Cloud Finchley.SR1 发布，修复模块的 bug"},{"author":"局长","authorImg":"https://static.oschina.net/uploads/user/1360/2720166_50.jpg?t=1470892376000","commCount":0,"detailUrl":"https://www.oschina.net/news/98611/symfony-4-1-3-and-4-0-14-released","id":"U3ltZm9ueSA0LjEuMyDlkowgNC4wLjE0","newsType":"project","summary":"日前，Symfony 为全部的分支进行了更新，包括 v4.1.3、v4.0.14 、v3.4.14 、v3.3.18 、v2.8.44  和 v2.7.49。 发布说明显示，每个版本都包含重要的变化，...","thumb":"https://static.oschina.net/uploads/logo/symfony_Qgvyz.png","timeStr":"2018-08-03","title":"Symfony 4.1.3 和 4.0.14 等全系列发布，PHP Web 框架"},{"author":"局长","authorImg":"https://static.oschina.net/uploads/user/1360/2720166_50.jpg?t=1470892376000","commCount":0,"detailUrl":"https://www.oschina.net/news/98610/spring-boot-admin-2-0-2-released","id":"U3ByaW5nIEJvb3QgQWRtaW4gMi4wLjIg","newsType":"project","summary":"Spring Boot Admin 2.0.2 已发布，官方没有提供本次的更新说明，不过我们从关闭的 issue 中看到，该版本的更新内容主要是 bug 修复和功能增强。 列举部分如下： Add vi...","thumb":"","timeStr":"2018-08-03","title":"Spring Boot Admin 2.0.2 发布，支持自定义 UI 视图"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98626/google-play-apps-infected-windows-executable-files","id":"6LC35q2M5LiL5p625LiK55m+5qy+6KKr","newsType":"industry","summary":"安全公司 Palo Alto 的一份报告指出，有 145 个 Google Play 应用程序被恶意的 Windows 可执行文件感染，在其向 Google 安全小组报告了调查结果后，谷歌从 Goog...","thumb":"https://www.oschina.net/img/logo/android.png?t=1451964198000","timeStr":"2018-08-03","title":"谷歌下架上百款被恶意 PE 感染的 APP，你中招了吗？"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/event/2283695?origin=zhzd","id":"5Lit5b+D5YyW44CB5Y675Lit5b+D5YyW","newsType":"industry","summary":"中心化游戏和去中心化游戏在策划、设计以及产品运营、用户运营方面有什么异同？如何从传统游戏领域跨向区块链游戏领域？","thumb":"","timeStr":"2018-08-03","title":"中心化、去中心化游戏？区块链与游戏怎么相结合？"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98624/db-engines-index-2018-08","id":"REItRW5naW5lcyA4IOaciOaVsOaNruW6","newsType":"industry","summary":"DB-Engines 发布了 2018 年 8 月份的数据库排名，Oracle 在保持了大幅度增长的同时持续领跑第 1。 前十名如下： 从表中可以看到，前 6 名地位岿然不动，不管是环比还是同比都没有...","thumb":"https://www.oschina.net/img/logo/oracle.gif?t=1451964198000","timeStr":"2018-08-03","title":"DB-Engines 8 月数据库榜单，Oracle 受新版本策略影响"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98623/ali-open-source-sentinel","id":"6Zi/6YeM5be05be05byA5rqQIFNlbnRp","newsType":"industry","summary":"近日，阿里巴巴中间件团队宣布开源 Sentinel，并发布了首个社区版本v0.1.0。 Sentinel 作为阿里巴巴“大中台、小前台”架构中的基础模块，覆盖了阿里的所有核心场景，因此积累了大量的流量...","thumb":"","timeStr":"2018-08-03","title":"阿里巴巴开源 Sentinel，进一步完善 Dubbo 生态"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/news/98622/reddit-breach-exposes-user-data-but-not-much","id":"UmVkZGl0IOaJv+iupOaVsOaNruazhOmc","newsType":"industry","summary":"Reddit 昨天宣布，6 月份时的一个信息安全漏洞导致攻击者入侵了该公司内部系统的某些部分，但泄露的数据并非敏感数据。值得注意的是，这次攻击绕开了 Reddit 通过短信实现的双因子认证系统。这也给...","thumb":"","timeStr":"2018-08-03","title":"Reddit 承认数据泄露，双因子认证也被攻破"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://gitee.com/panmingzhi/IdCardFaceIdentifier","id":"56CB5LqR5o6o6I2QIHwg5Z+65LqO5Lq6","newsType":"industry","summary":"IdCardFaceIdentifier 是基于虹软人脸识别与华视二代身份证阅读器的访客比对系统，使用开发包：虹软人脸识别SDK + 华视CVR100SDK + Aforge。","thumb":"","timeStr":"2018-08-03","title":"码云推荐 | 基于人脸识别与身份证的访客比对系统"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":2,"detailUrl":"https://my.oschina.net/52love/blog/1921097","id":"5q+P5pel5LiA5Y2aIHwg5LuO5p6E5bu6","newsType":"industry","summary":"上周末抽时间重读了周志明大湿的 JVM 高效并发部分，每读一遍都有不同的感悟。路漫漫，借此，把前段时间搞着玩的秒杀案例中的分布式锁深入了解一下。","thumb":"","timeStr":"2018-08-03","title":"每日一博 | 从构建分布式秒杀系统聊聊分布式锁"},{"author":"h4cd","authorImg":"https://oscimg.oschina.net/oscnet/up-fae02fc2cd727f11756f6f25e5e5d5d4.jpeg!/both/50x50?t=15220336750","commCount":0,"detailUrl":"https://www.oschina.net/p/mm-wiki","id":"TU0tV2lraSDigJQg6L276YeP57qn55qE","newsType":"industry","summary":"MM-Wiki 是一个轻量级的企业知识分享与团队协同软件，可用于快速构建企业 Wiki 和团队知识分享平台。部署方便，使用简单，帮助团队构建一个信息共享、文档管理的协作环境。","thumb":"","timeStr":"2018-08-03","title":"MM-Wiki — 轻量级的企业知识分享与团队协同软件"}],"total":2492},"slide":[{"detailUrl":"https://dc.cloud.alipay.com/index#/home","id":"4oCc5Li65LiW55WM5bim5p2l5pu05aSa","imgUrl":"https://static.oschina.net/uploads/space/2018/0511/101217_oPMi_2663968.png","summary":"ATEC蚂蚁人工智能大赛是蚂蚁金服举办的金融科技领域算法类大赛，面向全球顶尖数据算法开发者，共同探讨未来社会、经济、金融的技数问题，寻求最优解法与人才！","timeStr":"广告","title":"“为世界带来更多平等的机会，蚂蚁金服举办ATEC人工智能大赛"},{"detailUrl":"https://dc.cloud.alipay.com/index#/home","id":"IOi1m+eoi+i/h+WNiuern+WPkeeUn+mr","imgUrl":"https://static.oschina.net/uploads/space/2018/0514/100207_CVWq_2663968.png","summary":"凤凰金融量化投资大赛是第二届智慧中国杯（ICC）的第二场主题赛，参赛者需根据主办方凤凰金融提供的股票市场上千只股票的历史相关数据，预测股票未来半年的走势/挑出未来上涨幅度最大可能的若干只股票构成一个投资组合。","timeStr":"广告","title":" 赛程过半竟发生高分代码泄露事件！这场比赛到底怎么了？"},{"detailUrl":"https://www.oschina.net/news/98571/google-china-search-engine-censored-report","id":"5omO5YWL5Lyv5qC85omO5b+D77yM5Lyg","imgUrl":"https://static.oschina.net/uploads/img/201808/02140654_kZfy.png","summary":"据报道，谷歌计划在中国大陆重启其搜索引擎，然而，不同于多年前的强势，此番谷歌将会配合中国政府审查，以满足大陆网络环境要求。然而，受限的 Google Search 意义有多大呢？欢迎留言发表你的看法。","timeStr":"2018-08-02","title":"扎克伯格扎心，传谷歌搜索将接受审查重新进入中国"},{"detailUrl":"https://www.oschina.net/news/98544/microsoft-managed-desktop","id":"5b6u6L2v5oyJ5pyI5pS26LS55qGM6Z2i","imgUrl":"https://static.oschina.net/uploads/img/201808/02140933_qek5.png","summary":"微软目前正在启动一项桌面即服务计划“Microsoft Managed Desktop”，该项目将以按月付费的方式让用户使用 Windows 10 服务。该服务实际上就是一种“desktop as a service”（桌面即服务），与当下用户直接购买 Windows 10 操作系统形式不同，相反，它与当前的 Office 365 服务获取形式相同。","timeStr":"2018-08-02","title":"微软按月收费桌面计划，Win 10 将变成 Win 365？"},{"detailUrl":"https://www.oschina.net/event/2283695?origin=zxbanner","id":"5rqQ5Yib5Lya5oiQ6YO956uZ54Gr54Ot","imgUrl":"https://static.oschina.net/uploads/img/201807/30103455_H1U0.png","summary":"OSC源创会成都站报名启动，8月18日相约武侯区艺家城，来自各大企业的区块链专家将全方位剖析区块链核心技术原理与业务实践。活动依旧秉持着“自由，开放，分享”的思想，邀大家前来相聚~","timeStr":"2018-07-30","title":"源创会成都站火热报名中，区块链行业技术和机遇全解读"}]}}';
  var listData;
  var slideData;
  var curPage = 1;
  var listTotalSize = 0;

  ScrollController _controller = new ScrollController();
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleStyle = new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);


//  @override
//  Widget build(BuildContext context) {
//    if (data != null) {
//      Map<String, dynamic> map = json.decode(data);
//      if (map['code'] == 0) {
//        var msg = map['msg'];
//        listTotalSize = msg['news']['total'];
//        var _listData = msg['news']['data'];
//        var _slideData = msg['slide'];
//        setState(() {
//          listData = _listData;
//          slideData = _slideData;
//        });
//      }
//    }
//
//    Widget listView = new ListView.builder(
//      itemCount: listData.length * 2,
//      itemBuilder: (context, i) => renderRow(i),
//      controller: _controller,
//    );
//    return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
//  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      Map<String, dynamic> map = json.decode(data);
      if (map['code'] == 0) {
        var msg = map['msg'];
        listTotalSize = msg['news']['total'];
        var _listData = msg['news']['data'];
        var _slideData = msg['slide'];
        setState(() {
          listData = _listData;
          slideData = _slideData;
        });
      }
    }

    Widget listView = new ListView.builder(
      itemCount: listData.length * 2,
      itemBuilder: (context, i) => renderRow(i),
      controller: _controller,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("书架"),
        backgroundColor: Color.fromRGBO(224, 90, 85, 1.0),
      ),
      body:new RefreshIndicator(child: listView, onRefresh: _pullToRefresh),
    );
  }




  Future<Null> _pullToRefresh() async {
    print('fresh');
    return null;
  }


  Widget renderRow(i) {

    if (i.isOdd) {
      return new Divider(height: 1.0);
    }
    i = i ~/ 2;
    var itemData = listData[i];
    var titleRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text('对方乏味', style: titleTextStyle),
        )
      ],
    );
    var timeRow = new Row(
      children: <Widget>[
//        new Container(
//          width: 20.0,
//          height: 20.0,
//          decoration: new BoxDecoration(
//            shape: BoxShape.circle,
//            color: const Color(0xFFECECEC),
//            image: new DecorationImage(
//                image: new NetworkImage(itemData['authorImg']), fit: BoxFit.cover),
//            border: new Border.all(
//              color: const Color(0xFFECECEC),
//              width: 2.0,
//            ),
//          ),
//        ),
        new Expanded(
//          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            '最新章节：第1009张 哈哈哈哈哈哈哈哈哈哈少时诵诗书所所所',
            style: subtitleStyle,
          ),
        ),
//        new Expanded(
//          flex: 1,
//          child: new Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              new Text("${itemData['commCount']}", style: subtitleStyle),
//              new Image.asset('./images/ic_comment.png', width: 16.0, height: 16.0),
//            ],
//          ),
//        )
      ],
    );
    var thumbImgUrl = itemData['thumb'];
    var thumbImg = new Container(
      margin: const EdgeInsets.all(0.0),
      width: 100.0,
      height: 80.0,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xFFECECEC),
        image: new DecorationImage(
            image: new ExactAssetImage('./images/ic_img_default.jpg'),
            fit: BoxFit.cover),
        border: new Border.all(
          color: const Color(0xFFECECEC),
          width: 2.0,
        ),
      ),
    );
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      thumbImg = new Container(
        margin: const EdgeInsets.all(0.0),
        width: 100.0,
        height: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(thumbImgUrl), fit: BoxFit.cover),
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0,
          ),
        ),
      );
    }
    var row = new Row(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Container(
            width: 100.0,
            height: 80.0,
            color: const Color(0xFFECECEC),
            child: new Center(
              child: thumbImg,
            ),
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                titleRow,
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: timeRow,
                )
              ],
            ),
          ),
        ),

      ],
    );
    return new InkWell(
      child: row,
      onTap: () {
        print(i);
      },
    );
  }
}
