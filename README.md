# bowlScoring  棒球计分(带单元测试)
# jsFrameTest 基于bootstrap2 抽象的前端后台界面 
> 按钮事件脚本 jsFrameTest/assets/scripts/page-define.js 
# kuayu js跨域的运用
> proxytest.html 获取iframe中网页的高度 外层自适应高度（需要在iframe域中使用本地域的js文件 所以需要来源信任）
> ad 目录中脚本实现广告注入(一种非法拦截网站打广告的操作)木马
1. 提供一个js插件的cdn地址如(http://xx/jquery.min.js) 伪造成正常插件，正常提供功能
2. 被感染网站使用以上地址的脚本
3. 用户通过搜索引擎搜索被感染的网站(显示当前网站的广告信息)
4. 用户正常输入网址访问没有任何问题
# phpFrameTest 基于zend1 抽象的后台管理常用功能(淘汰)
# think 基于think3.2做的后台管理系统（产品追溯系统）
> 用完整的源码及数据库表结构 经过测试 可生产环境用，不带打印功能
> 基本增删改查功能 权限系统  菜单系统都抽象好了 如果做简单管理系统可以参考
# video-Enhanced 播放视频展示
1. 支持flv，swf两种格式的视频（若允许，视频格式尽量转为flv格式，各浏览器支持的最好）；
2. 视频放在video目录下
3. 对应的图片放在images目录下。
4. videoList.xml 文件说明：
    1. 一个<item>标签表示一个视频信息，<type>内填写视频类型，支持两种（flv,swf），填写对应的视频类型。
    2. <videourl>视频地址：格式为video/视频名称（video/视频名称）；
    3. <tempimg> 视频对应的小图片地址，写法：images/图片名称（尺寸为120*90 ）；
    4. <title> 视频列表的标题文字。

# wx 基于zend1 
> 框架做的微信消息管理 微信消息功能未完善,基础权限 ui 是完整的 可以做后台管理系统

交流
> qq群: 196063962 码聊
