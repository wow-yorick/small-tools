将 jiekou.utf-8.php 或 jiekou.gbk.php 文件放至网站根目录下

概述: ECShop_V2.7.3_release1106 文章免登陆发布接口
时间: 2013/9/25 17:13:02
作者: 清顽于世(QQ: 345738904)
详述: 参见概述 PS: 强烈建议修改默认接口密码!!!
使用: 将本文件放在网站根目录下, 存放路径示例: D:\Htdoc\ECShop_V2.7.3_UTF8_release1106\jiekou.php

必填字段: title
附件字段: file
默认使用字段: title  content author add_time
欲使用其它字段信息, 请参考以下示例数据

示例数据
$_POST = array(
	'title' => '测试文章-'. date('Y-m-d H:i:s'), //标题
	'article_cat' => 2, //文章分类ID
	'article_type' => 1, //文章重要性 0普通 1置顶
	'is_open' => '1', //是否显示 0不显示 1显示
	'author' => '清顽于世', //文章作者
	'author_email' => 'qingwanyushi@gmail.com', //作者email
	'keywords' => '关键字1,关键字2,关键字3', //SEO-关键字
	'content' => '测试文章内容-'. date('Y-m-d H:i:s'), //文章内容
	'file_url' => 'http://baidu.com/demo.jpg', //文件网址
	'link_url' => 'http://locoy.com/', //外部链接
	'description' => 'SEO-描述', //网页描述
	'add_time' => '2013/9/25 16:55:08', //添加时间
);

分类下拉菜单获取地址示例: http://your-domain.com/jiekou.php?cattree=true