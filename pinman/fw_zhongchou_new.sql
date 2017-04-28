-- MySQL dump 10.13  Distrib 5.6.35, for Linux (i686)
--
-- Host: localhost    Database: fw_zhongchou_new
-- ------------------------------------------------------
-- Server version	5.6.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fanwe_admin`
--

DROP TABLE IF EXISTS `fanwe_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adm_name` varchar(255) NOT NULL,
  `adm_password` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `role_id` int(11) NOT NULL,
  `login_time` int(11) NOT NULL,
  `login_ip` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_adm_name` (`adm_name`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_admin`
--

LOCK TABLES `fanwe_admin` WRITE;
/*!40000 ALTER TABLE `fanwe_admin` DISABLE KEYS */;
INSERT INTO `fanwe_admin` VALUES (1,'admin','e10adc3949ba59abbe56e057f20f883e',1,0,4,1441778690,'180.175.239.186'),(5,'大王','e10adc3949ba59abbe56e057f20f883e',1,0,6,1440382294,'222.44.84.34');
/*!40000 ALTER TABLE `fanwe_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_adv`
--

DROP TABLE IF EXISTS `fanwe_adv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_adv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tmpl` varchar(255) NOT NULL,
  `adv_id` varchar(255) NOT NULL,
  `code` text NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rel_table` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tmpl` (`tmpl`),
  KEY `adv_id` (`adv_id`),
  KEY `rel_id` (`rel_id`),
  KEY `rel_table` (`rel_table`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_adv`
--

LOCK TABLES `fanwe_adv` WRITE;
/*!40000 ALTER TABLE `fanwe_adv` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_adv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_api_login`
--

DROP TABLE IF EXISTS `fanwe_api_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_api_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `config` text NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `bicon` varchar(255) NOT NULL,
  `is_weibo` tinyint(1) NOT NULL,
  `dispname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_api_login`
--

LOCK TABLES `fanwe_api_login` WRITE;
/*!40000 ALTER TABLE `fanwe_api_login` DISABLE KEYS */;
INSERT INTO `fanwe_api_login` VALUES (13,'新浪api登录接口','a:3:{s:7:\"app_key\";s:1:\"1\";s:10:\"app_secret\";s:1:\"2\";s:7:\"app_url\";s:44:\"http://www.qmct8.com/api_callback.php?c=Sina\";}','Sina','./public/attachment/201210/13/17/50792e5bbc901.gif','./public/attachment/201210/13/16/5079277a72c9d.gif',1,'新浪微博'),(14,'腾讯微博登录插件','a:3:{s:7:\"app_key\";s:1:\"1\";s:10:\"app_secret\";s:1:\"2\";s:7:\"app_url\";s:47:\"http://www.qmct8.com/api_callback.php?c=Tencent\";}','Tencent','./public/attachment/201211/06/11/509882825c183.png','./public/attachment/201211/06/11/50988287b1890.png',1,'腾讯微博'),(15,'微信登录','N;','Weixin','/public/images/api_login/Weixin_api.png','/public/images/api_login/Weixin_api.png',0,'微信登录');
/*!40000 ALTER TABLE `fanwe_api_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_article`
--

DROP TABLE IF EXISTS `fanwe_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT ' 文章内容',
  `cate_id` int(11) NOT NULL COMMENT '文章分类ID',
  `create_time` int(11) NOT NULL COMMENT '发表时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `add_admin_id` int(11) NOT NULL COMMENT '发布人(管理员ID)',
  `is_effect` tinyint(4) NOT NULL COMMENT '有效性标识',
  `rel_url` varchar(255) NOT NULL COMMENT '自动跳转的外链',
  `update_admin_id` int(11) NOT NULL COMMENT '更新人(管理员ID)',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除标识',
  `click_count` int(11) NOT NULL COMMENT '点击数',
  `sort` int(11) NOT NULL COMMENT '排序 由大到小',
  `seo_title` text NOT NULL COMMENT '自定义seo页面标题',
  `seo_keyword` text NOT NULL COMMENT '自定义seo页面keyword',
  `seo_description` text NOT NULL COMMENT '自定义seo页面标述',
  `uname` varchar(255) NOT NULL,
  `sub_title` varchar(255) NOT NULL,
  `brief` text NOT NULL,
  `is_week` tinyint(1) NOT NULL,
  `is_hot` tinyint(1) NOT NULL,
  `icon` varchar(255) NOT NULL COMMENT '展示图表',
  `writer` varchar(255) NOT NULL COMMENT '发布者',
  `tags` varchar(255) NOT NULL COMMENT '标签',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`),
  KEY `create_time` (`create_time`),
  KEY `update_time` (`update_time`),
  KEY `click_count` (`click_count`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=5306 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_article`
--

LOCK TABLES `fanwe_article` WRITE;
/*!40000 ALTER TABLE `fanwe_article` DISABLE KEYS */;
INSERT INTO `fanwe_article` VALUES (68,'关于我们','<p>\r\n	关于DPIN众创平台：\r\n</p>\r\n<p>\r\n	Dream&nbsp; 梦想 &nbsp;<span style=\"line-height:1.5;\">Design 设计&nbsp;</span> \r\n</p>\r\n<p>\r\n	<span style=\"line-height:1.5;\"><br />\r\n</span>\r\n</p>\r\n<p>\r\n	<span style=\"line-height:1.5;\"><span>以“为设计众筹、为创意助力”为服务宗旨，以”唤醒众创时代，人人都是品牌“为己任</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"line-height:1.5;\"><span><br />\r\n</span></span>\r\n</p>\r\n<div>\r\n	通过优质资源整合与对接，<span style=\"line-height:1.5;\">给予供应链、营销推广、渠道分销等强力支持，</span><span style=\"line-height:1.5;\">帮助和陪伴设计师早日实现创造更多价值的创意梦想孵化平台；</span> \r\n</div>\r\n<p>\r\n	同时也是一个邀请设计师<span style=\"line-height:1.5;\">与助梦人（消费者、工厂、投资人、渠道商等）共同打造创新产品的众创平台。</span> \r\n</p>',22,1413251192,1440373494,0,1,'',0,0,0,1,'','','','','','',1,1,'','DPIN众创平台','众筹网'),(72,'常见问题','<div style=\"text-align:center;\">\r\n	<!--[if gte mso 9]>MicrosoftInternetExplorer402DocumentNotSpecified7.8Normal0<![endif]-->\r\n	<p class=\"p0\" align=\"center\">\r\n		<b><span style=\"font-size:18px;font-family:\" 宋体\";\"=\"\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于<b><span 宋体\";\"=\"\" style=\"font-size: 18px;\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">DPIN众创平台</span></span></b>&nbsp;</span><br />\r\n<br />\r\n</span></b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。</b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b><br />\r\n</b>\r\n	</p>\r\n<b><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span><br />\r\n</b> \r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p class=\"p0\" style=\"margin-left:18.0000pt;\" align=\"left\">\r\n		<span style=\"font-size:14px;\" 宋体\";\"=\"\"><span><span style=\"font-size:14px;\"></span></span></span> \r\n	</p>\r\n<!--[if gte mso 9]><![endif]-->\r\n</div>',24,1413338371,1440441325,0,1,'',0,0,0,5,'','','','','','',1,1,'','DPIN众创平台','众筹网'),(77,'项目规范','<div style=\"text-align:center;\">\r\n	<!--[if gte mso 9]>MicrosoftInternetExplorer402DocumentNotSpecified7.8Normal0<![endif]-->\r\n	<p class=\"p0\" align=\"center\">\r\n		<b><span style=\"font-size:18px;font-family:\" 宋体\";\"=\"\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于DPIN众创平台</span><br />\r\n<br />\r\n</span></b> \r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。</b> \r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b><br />\r\n</b> \r\n	</p>\r\n<b><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span><br />\r\n</b> \r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p class=\"p0\" style=\"margin-left:18.0000pt;\" align=\"left\">\r\n		<span style=\"font-size:14px;\" 宋体\";\"=\"\"><span><span style=\"font-size:14px;\"></span></span></span> \r\n	</p>\r\n<!--[if gte mso 9]><![endif]-->\r\n</div>',28,1413588165,1440441372,0,1,'',0,0,0,9,'','','','','','',1,1,'','DPIN众创平台','DPIN众创平台'),(75,'使用条款','<div style=\"text-align:center;\">\r\n	<!--[if gte mso 9]>MicrosoftInternetExplorer402DocumentNotSpecified7.8Normal0<![endif]-->\r\n	<p class=\"p0\" align=\"center\">\r\n		<b><span style=\"font-size:18px;font-family:\" 宋体\";\"=\"\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于<b><span 宋体\";\"=\"\" style=\"font-size: 18px;\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">DPIN众创平台</span></span></b></span><br />\r\n<br />\r\n</span></b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。</b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b><br />\r\n</b>\r\n	</p>\r\n<b><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span><br />\r\n</b> \r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p class=\"p0\" style=\"margin-left:18.0000pt;\" align=\"left\">\r\n		<span style=\"font-size:14px;\" 宋体\";\"=\"\"><span><span style=\"font-size:14px;\"></span></span></span> \r\n	</p>\r\n<!--[if gte mso 9]><![endif]-->\r\n</div>',21,1413586458,1440441360,0,1,'',0,0,0,7,'','','','','','',1,1,'','DPIN众创平台','DPIN众创平台'),(78,'版权申明','<div style=\"text-align:center;\">\r\n	<!--[if gte mso 9]>MicrosoftInternetExplorer402DocumentNotSpecified7.8Normal0<![endif]-->\r\n	<p class=\"p0\" align=\"center\">\r\n		<b><span style=\"font-size:18px;font-family:\" 宋体\";\"=\"\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于DPIN众创平台</span><br />\r\n<br />\r\n</span></b> \r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。</b> \r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b><br />\r\n</b> \r\n	</p>\r\n<b><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span><br />\r\n</b> \r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p class=\"p0\" style=\"margin-left:18.0000pt;\" align=\"left\">\r\n		<span style=\"font-size:14px;\" 宋体\";\"=\"\"><span><span style=\"font-size:14px;\"></span></span></span> \r\n	</p>\r\n<!--[if gte mso 9]><![endif]-->\r\n</div>',21,1413588553,1440373474,0,1,'',0,0,0,10,'','','','','','',1,1,'','DPIN众创平台','众筹网'),(79,'风险提示','<div style=\"text-align:center;\">\r\n	<!--[if gte mso 9]>MicrosoftInternetExplorer402DocumentNotSpecified7.8Normal0<![endif]-->\r\n	<p class=\"p0\" align=\"center\">\r\n		<b><span style=\"font-size:18px;font-family:\" 宋体\";\"=\"\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于<b><span 宋体\";\"=\"\" style=\"font-size: 18px;\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">DPIN众创平台</span></span></b>&nbsp;</span><br />\r\n<br />\r\n</span></b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。</b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b><br />\r\n</b>\r\n	</p>\r\n<b><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span><br />\r\n</b> \r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p class=\"p0\" style=\"margin-left:18.0000pt;\" align=\"left\">\r\n		<span style=\"font-size:14px;\" 宋体\";\"=\"\"><span><span style=\"font-size:14px;\"></span></span></span> \r\n	</p>\r\n<!--[if gte mso 9]><![endif]-->\r\n</div>',28,1413588976,1440441388,0,1,'',0,0,0,11,'','','','/fxts','','',1,1,'','DPIN众创平台','众筹网'),(85,'业务流程','<div style=\"text-align:center;\">\r\n	<!--[if gte mso 9]>MicrosoftInternetExplorer402DocumentNotSpecified7.8Normal0<![endif]-->\r\n	<p class=\"p0\" align=\"center\">\r\n		<b><span style=\"font-size:18px;font-family:\" 宋体\";\"=\"\"><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于DPIN众创平台&nbsp;</span><br />\r\n<br />\r\n</span></b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。</b>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<b><br />\r\n</b>\r\n	</p>\r\n<b><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span><br />\r\n</b> \r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p class=\"p0\" style=\"margin-left:18.0000pt;\" align=\"left\">\r\n		<span style=\"font-size:14px;\" 宋体\";\"=\"\"><span><span style=\"font-size:14px;\"></span></span></span> \r\n	</p>\r\n<!--[if gte mso 9]><![endif]-->\r\n</div>',24,1415744764,1440441262,0,1,'',0,0,0,1,'','','','/ywlc/','','',1,1,'','DPIN众创平台','众筹网'),(5305,'渠道合作','渠道合作',27,1440441718,1440441718,0,1,'',0,0,0,12,'','','','','','渠道合作',1,1,'','DPIN众创平台','渠道合作');
/*!40000 ALTER TABLE `fanwe_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_article_cate`
--

DROP TABLE IF EXISTS `fanwe_article_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_article_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '分类名称',
  `brief` varchar(255) NOT NULL COMMENT '分类简介(备用字段)',
  `pid` int(11) NOT NULL COMMENT '父ID，程序分类可分二级',
  `is_effect` tinyint(4) NOT NULL COMMENT '有效性标识',
  `is_delete` tinyint(4) NOT NULL COMMENT '删除标识',
  `type_id` tinyint(1) NOT NULL COMMENT '型 0:普通文章（可通前台分类列表查找到） 1.帮助文章（用于前台页面底部的站点帮助） 2.公告文章（用于前台页面公告模块的调用） 3.系统文章（自定义的一些文章，需要前台自定义一些入口链接到该文章） 所属该分类的所有文章类型与分类一致',
  `sort` int(11) NOT NULL,
  `seo_title` varchar(255) NOT NULL COMMENT 'SEO标题',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `type_id` (`type_id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_article_cate`
--

LOCK TABLES `fanwe_article_cate` WRITE;
/*!40000 ALTER TABLE `fanwe_article_cate` DISABLE KEYS */;
INSERT INTO `fanwe_article_cate` VALUES (21,'站点申明','',0,1,0,1,10,'zdsm'),(22,'关于我们','',0,1,0,1,0,'gywm'),(29,'行业新闻','',0,1,0,0,20,'hyxw'),(24,'新手帮助','',0,1,0,1,1,'xsbz'),(25,'活动报名','',0,1,0,0,5,'hdbm'),(26,'站内新闻','',0,1,0,0,21,'znxw'),(27,'欢迎合作','',0,1,0,1,7,'hzfs'),(28,'法律条款','',0,1,0,1,8,'fltk'),(44,'众创学院','',0,1,0,0,22,'zcxy');
/*!40000 ALTER TABLE `fanwe_article_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_auto_cache`
--

DROP TABLE IF EXISTS `fanwe_auto_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_auto_cache` (
  `cache_key` varchar(100) NOT NULL,
  `cache_type` varchar(100) NOT NULL,
  `cache_data` text NOT NULL,
  `cache_time` int(11) NOT NULL,
  PRIMARY KEY (`cache_key`,`cache_type`),
  KEY `cache_type` (`cache_type`),
  KEY `cache_key` (`cache_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_auto_cache`
--

LOCK TABLES `fanwe_auto_cache` WRITE;
/*!40000 ALTER TABLE `fanwe_auto_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_auto_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_bank`
--

DROP TABLE IF EXISTS `fanwe_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '银行名称',
  `is_rec` tinyint(1) NOT NULL COMMENT '是否推荐',
  `day` int(11) NOT NULL COMMENT '处理时间',
  `sort` int(11) NOT NULL COMMENT '银行排序',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_bank`
--

LOCK TABLES `fanwe_bank` WRITE;
/*!40000 ALTER TABLE `fanwe_bank` DISABLE KEYS */;
INSERT INTO `fanwe_bank` VALUES (1,'中国工商银行',1,3,0,'./public/bank/1.jpg'),(2,'中国农业银行',1,3,0,'./public/bank/2.jpg'),(3,'中国建设银行',1,3,0,'./public/bank/3.jpg'),(4,'招商银行',1,3,0,'./public/bank/4.jpg'),(5,'中国光大银行',1,3,0,'./public/bank/5.jpg'),(6,'中国邮政储蓄银行',1,3,0,'./public/bank/6.jpg'),(7,'兴业银行',1,3,0,'./public/bank/7.jpg'),(8,'中国银行',0,3,0,'./public/bank/8.jpg'),(9,'交通银行',0,3,3,'./public/bank/9.jpg'),(10,'中信银行',0,3,0,'./public/bank/10.jpg'),(11,'华夏银行',0,3,0,'./public/bank/11.jpg'),(12,'上海浦东发展银行',0,3,1,'./public/bank/12.jpg'),(13,'城市信用社',0,3,0,'./public/bank/13.jpg'),(14,'恒丰银行',0,3,0,'./public/bank/14.jpg'),(15,'广东发展银行',0,3,0,'./public/bank/15.jpg'),(16,'深圳发展银行',0,3,2,'./public/bank/16.jpg'),(17,'中国民生银行',0,3,0,'./public/bank/17.jpg'),(18,'中国农业发展银行',0,3,0,'./public/bank/18.jpg'),(19,'农村商业银行',0,3,0,'./public/bank/19.jpg'),(20,'农村信用社',0,3,0,'./public/bank/20.jpg'),(21,'城市商业银行',0,3,0,'./public/bank/21.jpg'),(22,'农村合作银行',0,3,0,'./public/bank/22.jpg'),(23,'浙商银行',0,3,0,'./public/bank/23.jpg'),(24,'上海农商银行',0,3,0,'./public/bank/24.jpg'),(25,'中国进出口银行',0,3,0,'./public/bank/25.jpg'),(26,'渤海银行',0,3,0,'./public/bank/26.jpg'),(27,'国家开发银行',0,3,0,'./public/bank/27.jpg'),(28,'村镇银行',0,3,0,'./public/bank/28.jpg'),(29,'徽商银行股份有限公司',0,3,0,'./public/bank/29.jpg'),(30,'南洋商业银行',0,3,0,'./public/bank/30.jpg'),(31,'韩亚银行',0,3,0,'./public/bank/31.jpg'),(32,'花旗银行',0,3,0,'./public/bank/32.jpg'),(33,'渣打银行',0,3,0,'./public/bank/33.jpg'),(34,'华一银行',0,3,0,'./public/bank/34.jpg'),(35,'东亚银行',1,3,0,'./public/bank/35.jpg'),(36,'苏格兰皇家银行',1,1,26,'./public/bank/36.jpg');
/*!40000 ALTER TABLE `fanwe_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_collocation`
--

DROP TABLE IF EXISTS `fanwe_collocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_collocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `config` text NOT NULL,
  `fee_type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_collocation`
--

LOCK TABLES `fanwe_collocation` WRITE;
/*!40000 ALTER TABLE `fanwe_collocation` DISABLE KEYS */;
INSERT INTO `fanwe_collocation` VALUES (30,'Yeepay',0,'易宝资金托管','a:5:{s:11:\"platform_no\";s:0:\"\";s:9:\"check_url\";s:0:\"\";s:8:\"is_debug\";s:1:\"0\";s:7:\"feeMode\";s:4:\"USER\";s:9:\"TXfeeMode\";s:4:\"USER\";}',0);
/*!40000 ALTER TABLE `fanwe_collocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_conf`
--

DROP TABLE IF EXISTS `fanwe_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `group_id` int(11) NOT NULL,
  `input_type` tinyint(1) NOT NULL COMMENT '配置输入的类型 0:文本输入 1:下拉框输入 2:图片上传 3:编辑器',
  `value_scope` text NOT NULL COMMENT '取值范围',
  `is_effect` tinyint(1) NOT NULL,
  `is_conf` tinyint(1) NOT NULL COMMENT '是否可配置 0: 可配置  1:不可配置',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=313 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_conf`
--

LOCK TABLES `fanwe_conf` WRITE;
/*!40000 ALTER TABLE `fanwe_conf` DISABLE KEYS */;
INSERT INTO `fanwe_conf` VALUES (1,'DEFAULT_ADMIN','admin',1,0,'',1,0,0),(2,'URL_MODEL','1',1,1,'0,1',1,1,3),(3,'AUTH_KEY','fanwe',1,0,'',1,1,4),(4,'TIME_ZONE','8',1,1,'0,8',1,1,1),(5,'ADMIN_LOG','1',1,1,'0,1',0,1,0),(6,'DB_VERSION','1.6',0,0,'',1,0,0),(7,'DB_VOL_MAXSIZE','8000000',1,0,'',1,1,11),(8,'WATER_MARK','',2,2,'',1,1,48),(10,'BIG_WIDTH','500',2,0,'',0,0,49),(11,'BIG_HEIGHT','500',2,0,'',0,0,50),(12,'SMALL_WIDTH','200',2,0,'',0,0,51),(13,'SMALL_HEIGHT','200',2,0,'',0,0,52),(14,'WATER_ALPHA','50',2,0,'',1,1,53),(15,'WATER_POSITION','4',2,1,'1,2,3,4,5',1,1,54),(16,'MAX_IMAGE_SIZE','3000000',2,0,'',1,1,55),(17,'ALLOW_IMAGE_EXT','jpg,gif,png',2,0,'',1,1,56),(18,'BG_COLOR','#ffffff',2,0,'',0,0,57),(19,'IS_WATER_MARK','0',2,1,'0,1',1,1,58),(20,'TEMPLATE','fanwe_1',1,0,'',1,1,17),(21,'SITE_LOGO','./public/attachment/201508/24/13/55daa4f6526b2.png',1,2,'',1,1,19),(23,'MAIL_ON','1',3,1,'0,1',1,1,72),(24,'SMS_ON','1',5,1,'0,1',1,1,78),(26,'PUBLIC_DOMAIN_ROOT','',2,0,'',0,1,59),(27,'APP_MSG_SENDER_OPEN','1',1,1,'0,1',1,1,9),(28,'ADMIN_MSG_SENDER_OPEN','1',1,1,'0,1',1,1,10),(29,'GZIP_ON','1',1,1,'0,1',1,1,2),(30,'CACHE_ON','1',1,1,'0,1',1,1,7),(31,'EXPIRED_TIME','0',1,0,'',1,1,5),(32,'TMPL_DOMAIN_ROOT','',2,0,'0',0,0,62),(33,'CACHE_TYPE','File',1,1,'File,Xcache,Memcached',1,1,7),(34,'MEMCACHE_HOST','127.0.0.1:11211',1,0,'',1,1,8),(35,'IMAGE_USERNAME','admin',2,0,'',0,1,60),(36,'IMAGE_PASSWORD','admin',2,4,'',0,1,61),(37,'DEAL_MSG_LOCK','0',0,0,'',0,0,0),(38,'SEND_SPAN','2',1,0,'',1,1,85),(39,'TMPL_CACHE_ON','1',1,1,'0,1',1,1,6),(40,'DOMAIN_ROOT','',1,0,'',1,0,10),(41,'COOKIE_PATH','/',1,0,'',0,1,10),(42,'SITE_NAME','DPIN众创平台',1,0,'',1,1,1),(43,'INTEGRATE_CFG','',0,0,'',1,0,0),(44,'INTEGRATE_CODE','',0,0,'',1,0,0),(172,'PAY_RADIO','5',3,0,'',1,1,10),(173,'SEO_TITLE','支持设计的力量，助力创意的梦想',1,0,'',1,1,20),(174,'SEO_KEYWORD','创意产品众筹，创意礼品,创意产品，智能设备,创意定制',1,0,'',1,1,21),(175,'SEO_DESCRIPTION','DPIN众创平台，以“为设计众筹、为创意助力”为服务宗旨，以”唤醒众创时代，人人都是品牌“为己任，力争打造中国最专业的创意产品众创平台！',1,0,'',1,1,22),(176,'SITE_LICENSE','DPIN众创平台 版权所有',1,0,'',1,1,22),(177,'PROMOTE_MSG_LOCK','1',0,0,'',0,0,0),(178,'PROMOTE_MSG_PAGE','0',0,0,'0',0,0,0),(179,'STATE_CDOE','',1,0,'',1,1,23),(180,'USER_VERIFY','0',4,1,'0,1,2,3,4',1,1,63),(181,'INVITE_REFERRALS','10',4,0,'',1,1,67),(182,'INVITE_REFERRALS_TYPE','1',4,1,'0,1',0,1,68),(183,'USER_MESSAGE_AUTO_EFFECT','1',4,1,'0,1',1,1,64),(184,'BUY_INVITE_REFERRALS','20',4,0,'',1,1,67),(185,'REFERRAL_IP_LIMI','1',4,1,'0,1',1,1,71),(186,'REFERRAL_LIMIT','999',4,0,'',1,1,69),(190,'MAIL_SEND_PAYMENT','1',5,1,'0,1',1,1,75),(191,'REPLY_ADDRESS','',5,0,'',1,1,77),(192,'MAIL_SEND_DELIVERY','1',5,1,'0,1',1,1,76),(193,'MAIL_ON','1',5,1,'0,1',1,1,72),(262,'NETWORK_FOR_RECORD','沪ICP备11025229号-9',1,0,'',1,1,201),(263,'QR_CODE','./public/attachment/201508/22/20/55d871c96fe84.jpg',3,2,'',1,1,202),(264,'REPAY_MAKE','7',1,0,'',1,1,264),(265,'SQL_CHECK','0',1,1,'0,1',1,1,265),(266,'MORTGAGE_MONEY','0.01',6,0,'',1,1,1),(267,'ENQUIER_NUM','6',6,0,'',1,1,2),(268,'INVEST_PAY_SEND_STATUS','1',6,1,'0,1,2',1,1,3),(269,'INVEST_STATUS_SEND_STATUS','1',6,1,'0,1,2',1,1,4),(270,'INVEST_PAID_SEND_STATUS','1',6,1,'0,1,2',1,1,5),(271,'INVEST_STATUS','1',6,1,'0,1,2',1,1,0),(272,'AVERAGE_USER_STATUS','1',6,1,'0,1',1,1,6),(275,'SCORE_TRADE_NUMBER','100',4,0,'',1,1,72),(276,'BUY_PRESEND_SCORE_MULTIPLE','0.5',4,0,'',1,1,72),(277,'BUY_PRESEND_POINT_MULTIPLE','0.5',4,0,'',1,1,72),(279,'KF_PHONE','400-885-8983',3,0,'',1,1,279),(280,'KF_QQ','461225265',3,0,'',1,1,280),(281,'PROJECT_HIDE','0',3,1,'0,1',1,1,69),(282,'WORK_TIME','09:00-18:30',3,0,'',1,1,69),(283,'IDENTIFY_POSITIVE','0',4,1,'0,1',1,1,283),(284,'IDENTIFY_NAGATIVE','0',4,1,'0,1',1,1,284),(285,'BUSINESS_LICENCE','0',4,1,'0,1',1,1,285),(286,'BUSINESS_CODE','0',4,1,'0,1',1,1,286),(287,'BUSINESS_TAX','0',4,1,'0,1',1,1,287),(288,'VIRSUAL_NUM','2000',4,0,'',1,1,288),(289,'MORTGAGE_MONEY_UNFREEZE','12',6,0,'',1,1,500),(290,'WX_MSG_LOCK','0',0,0,'',0,0,0);
/*!40000 ALTER TABLE `fanwe_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal`
--

DROP TABLE IF EXISTS `fanwe_deal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_match` text NOT NULL,
  `name_match_row` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `source_vedio` varchar(255) NOT NULL,
  `vedio` varchar(255) NOT NULL,
  `deal_days` int(11) NOT NULL COMMENT '上线天数，仅提供管理员审核参考',
  `begin_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `limit_price` decimal(20,2) NOT NULL COMMENT '项目金额',
  `brief` text NOT NULL,
  `description` text NOT NULL,
  `comment_count` int(11) NOT NULL,
  `support_count` int(11) NOT NULL COMMENT '支持人数',
  `focus_count` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `log_count` int(11) NOT NULL,
  `support_amount` decimal(20,2) NOT NULL COMMENT '支持总金额，需大等于limit_price(不含运费)',
  `pay_amount` decimal(20,2) NOT NULL COMMENT '可发放金额，抽完佣金的可领金额（含运费，运费不抽佣金）\r\n即support_amount*佣金比率+delivery_fee_amount',
  `delivery_fee_amount` decimal(20,2) NOT NULL COMMENT '交付费用金额',
  `create_time` int(11) NOT NULL,
  `seo_title` text NOT NULL,
  `seo_keyword` text NOT NULL,
  `seo_description` text NOT NULL,
  `tags` text NOT NULL,
  `tags_match` text NOT NULL,
  `tags_match_row` text NOT NULL,
  `success_time` int(11) NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `cate_id` int(11) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `is_recommend` tinyint(1) NOT NULL COMMENT '推荐项目',
  `is_classic` tinyint(1) NOT NULL COMMENT '经典项目',
  `is_delete` tinyint(1) NOT NULL,
  `deal_extra_cache` text NOT NULL,
  `is_edit` tinyint(1) NOT NULL,
  `description_1` text NOT NULL,
  `is_support_print` int(11) NOT NULL,
  `user_level` int(11) NOT NULL,
  `is_has_send_success` tinyint(1) NOT NULL,
  `pay_radio` decimal(20,2) NOT NULL,
  `adv_image` varchar(255) NOT NULL COMMENT '广告图片',
  `status` tinyint(1) NOT NULL,
  `deal_background_image` varchar(255) NOT NULL COMMENT '项目背景图片',
  `deal_backgroundColor_image` varchar(255) NOT NULL COMMENT '项目底色图片',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示普通众筹，1表示股权众筹,2表示众筹买房',
  `description_2` text NOT NULL COMMENT '目标用户或客户群体定位',
  `description_3` text NOT NULL COMMENT '目标用户或客户群体目前困扰或需求定位',
  `description_4` text NOT NULL COMMENT '满足目标用户或客户需求的产品或服务模式说明',
  `description_5` text NOT NULL COMMENT '项目赢利模式说明',
  `description_6` text NOT NULL COMMENT '市场主要同行或竞争对手概述',
  `description_7` text NOT NULL COMMENT '项目主要核心竞争力说明',
  `stock` text NOT NULL COMMENT '股东信息',
  `unstock` text NOT NULL COMMENT '非股东成员',
  `history` text NOT NULL COMMENT '三年信息',
  `plan` text NOT NULL COMMENT '三年计划',
  `attach` text NOT NULL COMMENT '附件信息',
  `investor_authority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0表示只有投资人可以，1表所有人都可以看',
  `project_step` tinyint(1) NOT NULL COMMENT '项目阶段 0表示未启动 1表示在开发中 2产品已上市或上线，3已经有收入，4已经盈利',
  `business_create_time` int(11) NOT NULL COMMENT '企业成立时间',
  `business_employee_num` int(11) NOT NULL COMMENT '企业员工数量',
  `business_is_exist` tinyint(1) NOT NULL COMMENT '公司是否成立',
  `has_another_project` tinyint(1) NOT NULL COMMENT '是否有其他项目 0表示么有  1表示有',
  `business_name` varchar(255) NOT NULL COMMENT '公司名称',
  `business_address` varchar(255) NOT NULL COMMENT '办公地址',
  `business_stock_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '入股方式  0直接入股原公司 1 创建新公司入股',
  `business_pay_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '付款方式 0表示一次性付款',
  `business_descripe` text NOT NULL COMMENT '企业简介',
  `pay_end_time` int(11) NOT NULL COMMENT '支付结算时间',
  `investor_edit` int(1) NOT NULL COMMENT '0表示显示下一步按钮，1表示显示不错和返回按钮',
  `mine_stock` decimal(10,2) DEFAULT NULL COMMENT '投资人占有的股份',
  `transfer_share` decimal(10,2) NOT NULL,
  `virtual_num` int(11) NOT NULL COMMENT '虚拟人数',
  `virtual_price` decimal(20,2) NOT NULL COMMENT '虚拟金额',
  `gen_num` int(11) NOT NULL COMMENT '跟投人数',
  `xun_num` int(11) NOT NULL COMMENT '询价人数',
  `invote_money` decimal(20,2) NOT NULL COMMENT '预购金额',
  `invote_num` int(11) NOT NULL COMMENT '投资人数',
  `invote_mini_money` decimal(10,2) NOT NULL COMMENT '最低支付金额',
  `refuse_reason` text COMMENT '拒绝理由',
  `audit_data` text NOT NULL COMMENT '发起人资料',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热门',
  `ips_bill_no` varchar(255) NOT NULL COMMENT '托管项目',
  `share_fee_amount` decimal(20,2) NOT NULL COMMENT '分红总金额',
  `is_special` tinyint(1) NOT NULL COMMENT '专题',
  `invest_status` tinyint(1) NOT NULL COMMENT '融资状态：0未确认，1成功，2失败',
  `left_money` decimal(20,2) NOT NULL COMMENT '剩余筹款',
  PRIMARY KEY (`id`),
  KEY `begin_time` (`begin_time`),
  KEY `end_time` (`end_time`),
  KEY `is_effect` (`is_effect`),
  KEY `limit_price` (`limit_price`),
  KEY `comment_count` (`comment_count`),
  KEY `support_count` (`support_count`),
  KEY `focus_count` (`focus_count`),
  KEY `view_count` (`view_count`),
  KEY `log_count` (`log_count`),
  KEY `support_amount` (`support_amount`),
  KEY `create_time` (`create_time`),
  KEY `is_success` (`is_success`),
  KEY `cate_id` (`cate_id`),
  KEY `sort` (`sort`),
  KEY `is_recommend` (`is_recommend`),
  KEY `is_classic` (`is_classic`),
  KEY `is_delete` (`is_delete`),
  FULLTEXT KEY `tags_match` (`tags_match`),
  FULLTEXT KEY `name_match` (`name_match`)
) ENGINE=MyISAM AUTO_INCREMENT=167 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal`
--

LOCK TABLES `fanwe_deal` WRITE;
/*!40000 ALTER TABLE `fanwe_deal` DISABLE KEYS */;
INSERT INTO `fanwe_deal` VALUES (155,'项目名称：泡温泉','ux28201ux27849,ux21517ux31216,ux39033ux30446,ux39033ux30446ux21517ux31216ux65306ux27873ux28201ux27849','温泉,名称,项目,项目名称：泡温泉','./public/attachment/201508/24/20/55db144e355d4.jpg','http://player.youku.com/embed/XMjgxNjMzNjI4','http://v.youku.com/v_show/id_XMjgxNjMzNjI4.html',20,1439760386,1441747560,1,11000.00,'简要说明','<h3>\r\n	关于我\r\n</h3>\r\n<p>\r\n	向支持者介绍一下你自己，以及你与所发起的项目之间的背景。这样有助于拉近你与支持者之间的距离。建议不超过100字。\r\n</p>\r\n<h3>\r\n	我想要做什么\r\n</h3>\r\n<p>\r\n	以图文并茂的方式简洁生动地说明你的项目，让大家一目了然，这会决定是否将你的项目描述继续看下去。建议不超过300字。\r\n</p>\r\n<h3>\r\n	为什么我需要你的支持\r\n</h3>\r\n<p>\r\n	这是加分项。说说你的项目不同寻常的特色、资金用途、以及大家支持你的理由。这会让更多人能够支持你，不超过200个汉字。\r\n</p>\r\n<h3>\r\n	我的承诺与回报\r\n</h3>\r\n让大家感到你对待项目的认真程度，鞭策你将项目执行最终成功。同时向大家展示一下你为支持者准备的回报，来吸引更多人支持你。',0,0,0,110,0,0.00,0.00,0.00,1439760313,'','','','温泉 名称 项目','ux28201ux27849,ux21517ux31216,ux39033ux30446','温泉,名称,项目',0,0,10,'安徽','宿州',20,0,'',1,1,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:2:{i:0;a:17:{s:2:\"id\";s:3:\"247\";s:7:\"deal_id\";s:3:\"155\";s:5:\"price\";s:6:\"100.00\";s:13:\"support_count\";s:1:\"0\";s:14:\"support_amount\";s:4:\"0.00\";s:11:\"description\";s:63:\"获得回报优惠券获得回报优惠券获得回报优惠券\";s:11:\"is_delivery\";s:1:\"0\";s:12:\"delivery_fee\";s:4:\"0.00\";s:13:\"is_limit_user\";s:1:\"0\";s:10:\"limit_user\";s:1:\"0\";s:10:\"repaid_day\";s:2:\"10\";s:14:\"virtual_person\";s:1:\"0\";s:8:\"is_share\";s:1:\"0\";s:9:\"share_fee\";s:4:\"0.00\";s:4:\"type\";s:1:\"0\";s:6:\"images\";a:1:{i:0;a:4:{s:2:\"id\";s:3:\"187\";s:7:\"deal_id\";s:3:\"155\";s:12:\"deal_item_id\";s:3:\"247\";s:5:\"image\";s:50:\"./public/attachment/201508/17/13/55d17052970d3.jpg\";}}s:12:\"price_format\";s:3:\"100\";}i:1;a:17:{s:2:\"id\";s:3:\"248\";s:7:\"deal_id\";s:3:\"155\";s:5:\"price\";s:6:\"200.00\";s:13:\"support_count\";s:1:\"1\";s:14:\"support_amount\";s:6:\"200.00\";s:11:\"description\";s:147:\"获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券\";s:11:\"is_delivery\";s:1:\"0\";s:12:\"delivery_fee\";s:4:\"0.00\";s:13:\"is_limit_user\";s:1:\"0\";s:10:\"limit_user\";s:1:\"0\";s:10:\"repaid_day\";s:1:\"0\";s:14:\"virtual_person\";s:1:\"0\";s:8:\"is_share\";s:1:\"0\";s:9:\"share_fee\";s:4:\"0.00\";s:4:\"type\";s:1:\"0\";s:6:\"images\";a:1:{i:0;a:4:{s:2:\"id\";s:3:\"188\";s:7:\"deal_id\";s:3:\"155\";s:12:\"deal_item_id\";s:3:\"248\";s:5:\"image\";s:50:\"./public/attachment/201508/17/13/55d17065f2414.png\";}}s:12:\"price_format\";s:3:\"200\";}}}',0,'',1,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',1,'',0.00,0,0,0.00),(157,'【时光文具】一套能慢慢陪你到老的文具系列','ux25991ux20855,ux24930ux24930,ux26102ux20809,ux31995ux21015,ux12304ux26102ux20809ux25991ux20855ux12305ux19968ux22871ux33021ux24930ux24930ux38506ux20320ux21040ux32769ux30340ux25991ux20855ux31995ux21015,ux12304ux26102ux20809ux25991ux20855ux12305ux19968ux22871ux33021ux24930ux24930ux38506ux20320ux21040ux32769ux30340ux25991ux20855ux31995ux21015','文具,慢慢,时光,系列,【时光文具】一套能慢慢陪你到老的文具系列,【时光文具】一套能慢慢陪你到老的文具系列','./public/attachment/201508/24/20/55db101e03972.jpg','','',0,1435725545,1440391151,1,20000.00,'我希望能以简约的设计，扎实的材料，精湛的工艺，打造一套适合现代人使用的文具，可以使用一辈子的文具。','<p>\r\n	<span style=\"color:#2A2A2A;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;font-size:14px;line-height:22px;\">我希望能以简约的设计，扎实的材料，精湛的工艺，打造一套适合现代人使用的文具，可以使用一辈子的文具。</span>\r\n</p>\r\n<p>\r\n	<img src=\"https://img.alicdn.com/tfscom/TB1u1S_IpXXXXXQXVXXXXXXXXXX\" />\r\n	<h2 style=\"font-size:18px;color:#2A2A2A;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n		<img src=\"https://img.alicdn.com/tfscom/TB1gDm1IpXXXXavaXXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1TAq9IpXXXXahXVXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1qq55IpXXXXcGXVXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1WN2kIpXXXXbsXpXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1hQrmIpXXXXX5XpXXXXXXXXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB10KvaIpXXXXcuXFXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1t1HkIpXXXXbBXpXXXXXXXXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1fGS6IpXXXXcCXVXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB18fHiIpXXXXXkXFXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1Dr2sIpXXXXaVXXXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB10wPsIpXXXXaKXXXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1KE2hIpXXXXXLXFXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1yTLiIpXXXXXaXFXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1hQ6uIpXXXXXEXXXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1gvrkIpXXXXbzXpXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1DrzhIpXXXXXPXFXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1t9ntIpXXXXX6XXXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1qiDnIpXXXXcNXXXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1m.DrIpXXXXa4XXXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1uibkIpXXXXbwXpXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB11B59IpXXXXX_XVXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1bEe7IpXXXXa9XVXXSutbFXXX\" /><img src=\"https://img.alicdn.com/tfscom/TB1E9TdIpXXXXXOXFXXSutbFXXX\" />\r\n	</h2>\r\n</p>',0,0,0,74,0,0.00,0.00,0.00,1440391383,'','','','','','',0,0,9,'广东','广州',4292,1,'圈圈',0,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'0',0.00,0,0,0.00),(156,'度假酒店','ux24230ux20551,ux37202ux24215,ux24230ux20551ux37202ux24215','度假,酒店,度假酒店','./public/attachment/201508/17/13/55d17188b7a6f.jpg','http://player.youku.com/embed/XMjgxNjMzNjI4','http://v.youku.com/v_show/id_XMjgxNjMzNjI4.html',0,1439760866,1460756070,1,2000000.00,'','',0,0,0,41,0,0.00,0.00,0.00,1439760691,'','','','酒店','ux37202ux24215','酒店',1441755076,1,2,'广东','广州',20,0,'myname',1,1,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,1,0.00,'',0,'','',1,'<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体定位</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体定位</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体定位</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体定位</span>','<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体目前困扰或需求定位</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体目前困扰或需求定位</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体目前困扰或需求定位</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体目前困扰或需求定位</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">目标用户或客户群体目前困扰或需求定位</span>','<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">满足目标用户或客户需求的产品或服务模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">满足目标用户或客户需求的产品或服务模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">满足目标用户或客户需求的产品或服务模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">满足目标用户或客户需求的产品或服务模式说明</span>','<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目赢利模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目赢利模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目赢利模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目赢利模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目赢利模式说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目赢利模式说明</span>','<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">市场主要同行或竞争对手概述</span>','<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span>','a:1:{i:0;a:7:{s:4:\"name\";s:9:\"读懂人\";s:3:\"job\";s:6:\"职位\";s:12:\"is_full_time\";s:6:\"全职\";s:5:\"share\";d:100;s:12:\"invest_money\";s:3:\"200\";s:8:\"relation\";s:0:\"\";s:8:\"describe\";s:615:\"<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">项目主要核心竞争力说明</span>\";}}','a:0:{}','a:1:{i:0;a:1:{s:4:\"info\";a:11:{s:4:\"name\";s:10:\"第1阶段\";s:10:\"begin_time\";s:8:\"2015-8-4\";s:8:\"end_time\";s:9:\"2015-8-31\";s:8:\"describe\";s:1080:\"<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">第</span><span class=\"daxie\" style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">1</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">阶段</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">第</span><span class=\"daxie\" style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">1</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">阶段</span>\";s:11:\"do_describe\";s:1620:\"<span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">第</span><span class=\"daxie\" style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">1</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">阶段</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">第</span><span class=\"daxie\" style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">1</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">阶段</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">第</span><span class=\"daxie\" style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">1</span><span style=\"color:#3D9EEB;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:18px;line-height:40px;background-color:#FFFFFF;\">阶段</span>\";s:9:\"is_income\";s:1:\"0\";s:11:\"item_income\";s:1:\"0\";s:6:\"is_out\";s:1:\"0\";s:8:\"item_out\";s:1:\"0\";s:10:\"income_num\";i:1;s:7:\"out_num\";i:1;}}}','a:0:{}','a:1:{i:0;a:2:{s:5:\"title\";s:6:\"附件\";s:4:\"file\";s:71:\"http://ext4.ihancc.com/public/attachment/201508/17/13/55d172389c50d.txt\";}}',0,3,1438588800,200,1,1,'度假酒店','度假酒店度假酒店',0,0,'度假酒店度假酒店度假酒店度假酒店度假酒店度假酒店度假酒店度假酒店度假酒店',1471037675,1,0.00,10.00,0,0.00,1,0,10000000.00,1,10000.00,'','a:7:{s:8:\"legal_id\";a:4:{s:5:\"image\";a:1:{i:0;s:50:\"./public/attachment/201508/17/13/55d1719d2ebc4.jpg\";}s:6:\"status\";s:1:\"1\";s:6:\"reason\";s:0:\"\";s:12:\"display_type\";s:1:\"0\";}s:12:\"legal_credit\";a:4:{s:5:\"image\";a:1:{i:0;s:50:\"./public/attachment/201508/17/13/55d1719f458b9.jpg\";}s:6:\"status\";s:1:\"1\";s:6:\"reason\";s:0:\"\";s:12:\"display_type\";s:1:\"0\";}s:16:\"business_license\";a:4:{s:5:\"image\";a:1:{i:0;s:50:\"./public/attachment/201508/17/13/55d171a186616.jpg\";}s:6:\"status\";s:1:\"1\";s:6:\"reason\";s:0:\"\";s:12:\"display_type\";s:1:\"0\";}s:28:\"tax_registration_certificate\";a:4:{s:5:\"image\";a:1:{i:0;s:50:\"./public/attachment/201508/17/13/55d171a3bf205.jpg\";}s:6:\"status\";s:1:\"1\";s:6:\"reason\";s:0:\"\";s:12:\"display_type\";s:1:\"0\";}s:17:\"organization_code\";a:4:{s:5:\"image\";a:1:{i:0;s:50:\"./public/attachment/201508/17/13/55d171a5bb8ef.jpg\";}s:6:\"status\";s:1:\"1\";s:6:\"reason\";s:0:\"\";s:12:\"display_type\";s:1:\"0\";}s:13:\"company_photo\";a:4:{s:5:\"image\";a:1:{i:0;s:50:\"./public/attachment/201508/17/13/55d171a772efe.jpg\";}s:6:\"status\";s:1:\"1\";s:6:\"reason\";s:0:\"\";s:12:\"display_type\";s:1:\"0\";}s:13:\"site_contract\";a:4:{s:5:\"image\";a:1:{i:0;s:50:\"./public/attachment/201508/17/13/55d171a973470.jpg\";}s:6:\"status\";s:1:\"1\";s:6:\"reason\";s:0:\"\";s:12:\"display_type\";s:1:\"0\";}}',1,'',0.00,1,0,0.00),(158,'《不一样的烟火》—2015春季WEIS烟火系列台灯','ux28895ux28779,ux21488ux28783,ux26149ux23395,ux19968ux26679,ux31995ux21015,ux50ux48ux49ux53,ux87ux69ux73ux83,ux12298ux19981ux19968ux26679ux30340ux28895ux28779ux12299ux8212ux50ux48ux49ux53ux26149ux23395ux87ux69ux73ux83ux28895ux28779ux31995ux21015ux21488ux28783,ux12298ux19981ux19968ux26679ux30340ux28895ux28779ux12299ux8212ux50ux48ux49ux53ux26149ux23395ux87ux69ux73ux83ux28895ux28779ux31995ux21015ux21488ux28783,ux12298ux19981ux19968ux26679ux30340ux28895ux28779ux12299ux8212ux50ux48ux49ux53ux26149ux23395ux87ux69ux73ux83ux28895ux28779ux31995ux21015ux21488ux28783,ux12298ux19981ux19968ux26679ux30340ux28895ux28779ux12299ux8212ux50ux48ux49ux53ux26149ux23395ux87ux69ux73ux83ux28895ux28779ux31995ux21015ux21488ux28783,ux12298ux19981ux19968ux26679ux30340ux28895ux28779ux12299ux8212ux50ux48ux49ux53ux26149ux23395ux87ux69ux73ux83ux28895ux28779ux31995ux21015ux21488ux28783','烟火,台灯,春季,一样,系列,2015,WEIS,《不一样的烟火》—2015春季WEIS烟火系列台灯,《不一样的烟火》—2015春季WEIS烟火系列台灯,《不一样的烟火》—2015春季WEIS烟火系列台灯,《不一样的烟火》—2015春季WEIS烟火系列台灯,《不一样的烟火》—2015春季WEIS烟火系列台灯','./public/attachment/201508/24/20/55db12e38a80f.jpg','','',0,1436244449,1440391653,1,1000.00,'有这样一种灯，散发出的光芒犹如星空中绽放的烟火。WEIS烟火台灯，带给你2015春日“不一样的烟火”','<div style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	有这样一种灯，散发出的光芒犹如星空中绽放的烟火。WEIS烟火台灯，带给你2015春日“不一样的烟火”\r\n</div>\r\n<div id=\"J_Desc\" style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<h2 style=\"font-size:18px;\">\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1BPWcHpXXXXbxXVXXSutbFXXX\" /> \r\n	</h2>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1kQWeHpXXXXXmXVXXSutbFXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1zvamHpXXXXXEXXXXSutbFXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB14X5iHpXXXXcSXpXXSutbFXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1iVB.HpXXXXXOapXXSutbFXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1xRikHpXXXXctXXXXSutbFXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1eguXHpXXXXcSaXXXXXXXXXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1wp9dHpXXXXbuXVXXSutbFXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB113acHpXXXXXYaXXXXXXXXXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1pGmmHpXXXXbTXXXXXXXXXXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1JdKkHpXXXXX8XpXXSutbFXXX\" /> \r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB14eKnHpXXXXXCXXXXSutbFXXX\" /> \r\n	</p>\r\n</div>',0,0,0,85,0,0.00,0.00,0.00,1440391713,'','','','设计众筹','ux35774ux35745ux20247ux31609','设计众筹',0,0,9,'江苏','南京',4291,2,'大王',1,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'',0.00,0,0,0.00),(159,'XL储物水壶，史上最贴心的水壶','ux27700ux22774,ux36148ux24515,ux21490ux19978ux26368,ux20648ux29289,ux88ux76ux20648ux29289ux27700ux22774ux65292ux21490ux19978ux26368ux36148ux24515ux30340ux27700ux22774,ux88ux76ux20648ux29289ux27700ux22774ux65292ux21490ux19978ux26368ux36148ux24515ux30340ux27700ux22774,ux88ux76ux20648ux29289ux27700ux22774ux65292ux21490ux19978ux26368ux36148ux24515ux30340ux27700ux22774','水壶,贴心,史上最,储物,XL储物水壶，史上最贴心的水壶,XL储物水壶，史上最贴心的水壶,XL储物水壶，史上最贴心的水壶','./public/attachment/201508/24/20/55db14ddec662.jpg','','',30,1435726609,1440737760,1,10000.00,'史上最懂你的保温水壶，暖胃更暖心！','<div style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	史上最懂你的保温水壶，暖胃更暖心！\r\n</div>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1z8WdHXXXXXaRXFXXSutbFXXX\" /><img src=\"http://img04.taobaocdn.com/tfscom/TB1BqCaHXXXXXarXVXXSutbFXXX\" /><img src=\"http://img04.taobaocdn.com/tfscom/TB1ItacHXXXXXcBXFXXSutbFXXX\" /><img src=\"http://img04.taobaocdn.com/tfscom/TB1uLSfHXXXXXaeXpXXSutbFXXX\" /> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>',0,0,0,110,0,0.00,0.00,0.00,1440392409,'','','','','','',0,0,9,'上海','宝山区',4290,3,'李书福子',0,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'',0.00,1,0,0.00),(165,'鸭鸭乐防近视智能笔','ux36817ux35270,ux26234ux33021,ux20048ux38450,ux40493ux40493ux20048ux38450ux36817ux35270ux26234ux33021ux31508','近视,智能,乐防,鸭鸭乐防近视智能笔','./public/attachment/201509/09/18/55f0039ca6dbf.jpg','','',30,1441764266,1446170669,1,10000.00,'','<h3>\r\n	<div class=\"item-detail-nav\" style=\"margin:0px;padding:0px;font-size:14px;color:#666666;font-family:\'microsoft yahei\';\">\r\n		<span class=\"first\" style=\"font-size:16px;font-weight:700;color:#333333;\">项目详情</span>&nbsp;\r\n	</div>\r\n	<div class=\"item-detail-info\" style=\"margin:0px;padding:0px;color:#333333;font-family:\'microsoft yahei\';\">\r\n		<div class=\"item-detail-intro-pic\" style=\"margin:0px 0px 30px;padding:0px;\">\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144109616100148883.jpg\" width=\"740\" height=\"455\" alt=\"鸭鸭乐防近视智能笔\" /> \r\n		</div>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100665391700539.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100666808662318.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100671658946774.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100672779631828.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100673236441788.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100673650878856.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100674733819458.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100677133967671.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144100682690671155.png\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144109624952413569.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144109628787902823.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144109633663070055.jpg\" /> \r\n		</p>\r\n		<p>\r\n			<img src=\"http://image.suning.cn/uimg/cfs/project/144109634611711441.jpg\" /> \r\n		</p>\r\n	</div>\r\n</h3>',0,0,2,99,0,0.00,0.00,0.00,1441764170,'','','','近视 智能 乐防','ux36817ux35270,ux26234ux33021,ux20048ux38450','近视,智能,乐防',0,0,6,'上海','静安区',4290,0,'李书福子',0,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:1:{i:0;a:17:{s:2:\"id\";s:3:\"250\";s:7:\"deal_id\";s:3:\"165\";s:5:\"price\";s:4:\"1.00\";s:13:\"support_count\";s:1:\"0\";s:14:\"support_amount\";s:4:\"0.00\";s:11:\"description\";s:172:\"感谢您的支持，1元有惊喜，每满100人，将由DPIN众创平台官方抽取1名幸运用户，获得”鸭鸭乐防近视智能笔“1套（颜色随机发货）\";s:11:\"is_delivery\";s:1:\"0\";s:12:\"delivery_fee\";s:4:\"0.00\";s:13:\"is_limit_user\";s:1:\"0\";s:10:\"limit_user\";s:1:\"0\";s:10:\"repaid_day\";s:2:\"60\";s:14:\"virtual_person\";s:1:\"0\";s:8:\"is_share\";s:1:\"0\";s:9:\"share_fee\";s:4:\"0.00\";s:4:\"type\";s:1:\"0\";s:6:\"images\";a:0:{}s:12:\"price_format\";s:1:\"1\";}}}',1,'',0,0,1,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'',0.00,0,0,0.00),(160,'【微山水】东方美感的极致小物，方寸之间尽显山河气魄','ux26041ux23544,ux27668ux39748,ux23665ux27827,ux32654ux24863,ux26497ux33268,ux23665ux27700,ux20043ux38388,ux19996ux26041,ux12304ux24494ux23665ux27700ux12305ux19996ux26041ux32654ux24863ux30340ux26497ux33268ux23567ux29289ux65292ux26041ux23544ux20043ux38388ux23613ux26174ux23665ux27827ux27668ux39748,ux12304ux24494ux23665ux27700ux12305ux19996ux26041ux32654ux24863ux30340ux26497ux33268ux23567ux29289ux65292ux26041ux23544ux20043ux38388ux23613ux26174ux23665ux27827ux27668ux39748','方寸,气魄,山河,美感,极致,山水,之间,东方,【微山水】东方美感的极致小物，方寸之间尽显山河气魄,【微山水】东方美感的极致小物，方寸之间尽显山河气魄','./public/attachment/201508/24/21/55db177c3ce79.jpg','','',0,1438578535,1440392937,1,18600.00,'这是一个极具东方气质的设计系列，由名贵的黑檀木和树脂制成，在今年日本东京设计周亮相后便受到热烈追捧。\r\n','<div style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	这是一个极具东方气质的设计系列，由名贵的黑檀木和树脂制成，在今年日本东京设计周亮相后便受到热烈追捧。\r\n</div>\r\n<div id=\"J_Desc\" style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<h4 style=\"font-size:18px;\">\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1ShkiGVXXXXcMXXXXSutbFXXX\" />\r\n	</h4>\r\n	<h2 style=\"font-size:18px;\">\r\n		造物者说\r\n	</h2>\r\n	<p>\r\n		意外设计是由两位设计师（黄国栋与周慧)于2010年创立的原创设计品牌，作品范围涉及家具，家居用品及礼品。在创立意外设计之前，我们做过一段时间的室内设计，设计行业很大程度上是个服务行业，设计作品的水平往往取决于甲方的审美，而且甲方经常会提出很多让你哭笑不得的要求...渐渐地，在每天不断地妥协中，我发现我渐渐地失去了做设计的动力，甚至有点厌倦做设计这件事情。\r\n	</p>\r\n	<p>\r\n		就在2010年底，我决定了做一件事情，做自己的一个独立品牌，设计的好坏交给市场去评价！于是我们拿着有限的资金，慢慢探索，慢慢进步，说实话，我们因为市场做过很多的妥协，但是唯一不变的，就是回归初心，回归对设计最初的热情，做自己最满意的作品。\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB16C2QGVXXXXa.XVXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		<span style=\"line-height:1.5;\">说实话，我们不是一个会偏执于某种风格的设计团队，对这种东方风格的设计探索，其实是来源于一位客人的启发，他对我说：“我们因为生意上的需要经常需要送礼给老外，但是市面上都没有很有品味，又能代表中国文化的礼品，你们能不能给设计一个...\"</span>\r\n	</p>\r\n	<p>\r\n		一提到“中国风格”的设计，我们多数能想到的是非常符号化的设计，中国结，大红色的元素，中华图腾，青花瓷...\r\n	</p>\r\n	<p>\r\n		虽然最后没能与那位先生达成生意上的合作，但意外设计在2013年的“墨”系列开始，对中国风格的设计便开始有了一定的探索，我们更希望在实用的产品中融入东方的气质，是环保的，有品味的，大家乐于使用的。今年偶然间接触到了黑檀木这种材料，便一见钟情，我们利用黑檀木的木纹特质，设计了这个极具东方气质的“微山水”商务小系列，纯手工制作，希望大家能喜欢。\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1HD3bGVXXXXbwXVXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		上图所述不足以完整地体现整个复杂的制作过程，从选材料，粗打磨，裁切木料，调试树脂（树脂的制作过程尤为漫长，从液态到干透成固态需要耗时12个小时），等待树脂变硬还需要裁切，数控机床制作成型，反复的砂纸打磨，布轮抛光.....才能做出一个完整的成品。\r\n	</p>\r\n	<p>\r\n		啰里吧嗦那么一堆，并不是在诉苦，有多么的不易，恰恰相反，作为一个匠人，一个设计师，我非常乐于把时间浪费在那么美好的事情上，一个个产品的诞生，售出，被大家使用，被喜爱。对于我来说都是那么幸福的事情。\r\n	</p>\r\n	<h2 style=\"font-size:18px;\">\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1eXzOGVXXXXXBaXXXSutbFXXX\" />\r\n	</h2>\r\n	<p>\r\n		【回报一】山水.名片盒\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB15_2QGVXXXXaZXVXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB18xPNGVXXXXaEapXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		关于限量，虽然我们已经花了不少时间搜集了一定数量的木材，应该能满足这次众筹的数量需求，但是项目结束以后这个系列不一定会在市面上有销售（视乎还有没有剩下木材料），所以你买到的，很可能是绝版的设计，而且每一个名片夹都是独一无二，绝对是不可复制的限量版！\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1_h_WGVXXXXciXpXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB14G6UGVXXXXaEXFXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		檀木有“十檀九空”的说法，正是说明了檀木取材率低，我们的这个系列正是利用了木头的天然特质。虫眼，孔洞，结疤，矿物纹...这些在我看来都是大自然的杰作！名片盒是100%手作，所以会有手工的痕迹，（如上图名片盒的木料上面有一个天然的洞，我们用树脂将其封上，再打磨，使之成为设计的一部分）这些都不属于品质的问题，完美主义者请慎重考虑购买。\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB11W61GVXXXXbKXXXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		【回报二】山水.直尺\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1DUjSGVXXXXciXFXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		因为木头的天然性，和设计师取材的主观性，使得每一把尺子都是独一无二。（因为尺子是100%手作，所以会有手工的痕迹，也正是这种手作的温度给力这把尺子迷人生命力，追求完美的朋友谨慎考虑购买）\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1bPHWGVXXXXcdXpXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		【回报三】山水.名片座\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1_i_0GVXXXXbDXXXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		名片座是接待客人的第一印象，支持一个让你客人印象深刻的名片座设计吧！\r\n	</p>\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB10jDUGVXXXXaFXpXXSutbFXXX\" />\r\n	</p>\r\n	<p>\r\n		上图是我们今年参加日本东京设计周的图片，去日本的时候只设计了一款尺子，却没想到非常受大家的欢迎，于是我们回国以后重新扩充了这个小系列。\r\n	</p>\r\n	<p>\r\n		&nbsp;\r\n	</p>\r\n	<p>\r\n		&nbsp;\r\n	</p>\r\n	<h2 style=\"font-size:18px;\">\r\n		为什么需要您的支持\r\n	</h2>\r\n	<p>\r\n		这个系列曾经被朋友戏称为“自杀性项目”，一方面是因为制作过程繁琐，耗时长，而且最要命的是很多的环节由于对美学要求高，必须我们亲自来做，不能假手于人。\r\n	</p>\r\n	<p>\r\n		虽然做这个项目的成本非常高，但是由于我们对这些精致的小物实在忍不住的喜欢，即便是做一小批限量，我也希望能把它们以非常合理的价格分享给大家。\r\n	</p>\r\n</div>',0,0,0,70,0,0.00,0.00,0.00,1440393013,'','','','','','',0,0,9,'广东','广州',4288,4,'yorick',0,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'0',0.00,0,0,0.00),(161,'WEIS 中国文化意境产品之独立设计师签名收藏版','ux25910ux34255ux29256,ux20013ux22269,ux24847ux22659,ux35774ux35745ux24072,ux29420ux31435,ux31614ux21517,ux25991ux21270,ux20135ux21697,ux87ux69ux73ux83,ux87ux69ux73ux83ux20013ux22269ux25991ux21270ux24847ux22659ux20135ux21697ux20043ux29420ux31435ux35774ux35745ux24072ux31614ux21517ux25910ux34255ux29256,ux87ux69ux73ux83ux20013ux22269ux25991ux21270ux24847ux22659ux20135ux21697ux20043ux29420ux31435ux35774ux35745ux24072ux31614ux21517ux25910ux34255ux29256','收藏版,中国,意境,设计师,独立,签名,文化,产品,WEIS,WEIS 中国文化意境产品之独立设计师签名收藏版,WEIS 中国文化意境产品之独立设计师签名收藏版','./public/attachment/201508/24/21/55db1a3d42b90.jpg','','',30,1438578906,1439788508,1,22255.00,'WEIS是由魏杭帅先生设计创办的品牌，专注感官创意东方美学设计，此次将推出独立设计师签名版收藏系列。','<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<span style=\"font-size:18px;\"><span style=\"line-height:27px;\"><b>\r\n	<div style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n		WEIS是由魏杭帅先生设计创办的品牌，专注感官创意东方美学设计，此次将推出独立设计师签名版收藏系列。\r\n	</div>\r\n	<div id=\"J_Desc\" style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n		<p>\r\n			<img src=\"http://img04.taobaocdn.com/tfscom/TB1yYIiGVXXXXb.XpXXSutbFXXX\" />\r\n		</p>\r\n		<p>\r\n			<img src=\"http://img04.taobaocdn.com/tfscom/TB1CeUeGVXXXXbYXVXXSutbFXXX\" />\r\n		</p>\r\n		<p>\r\n			<img src=\"http://img04.taobaocdn.com/tfscom/TB1hbnyGFXXXXXFaXXXSutbFXXX\" />\r\n		</p>\r\n		<p>\r\n			<span style=\"font-size:18px;\"><span style=\"line-height:27px;\"><b>作品介绍</b></span></span>\r\n		</p>\r\n		<p>\r\n			<span style=\"font-size:18px;\"><span style=\"line-height:27px;\"><b><img src=\"http://img04.taobaocdn.com/tfscom/TB1mFG8HXXXXXcxaXXXSutbFXXX\" /></b></span></span>\r\n		</p>\r\n		<p>\r\n			<span style=\"font-size:18px;\"><span style=\"line-height:27px;\"><b>?</b></span></span>\r\n		</p>\r\n	</div>\r\n<img src=\"http://img04.taobaocdn.com/tfscom/TB1NSndHXXXXXXAXVXXSutbFXXX\" /></b></span></span>\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1O_.fGVXXXXXFXVXXXXXXXXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1WDzeGVXXXXcsaXXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1ERodGVXXXXbYXVXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1ANQiGVXXXXbvXpXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	&nbsp;\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1xJgfGVXXXXXmXVXXXXXXXXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1uUYMGFXXXXX8aXXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1zAwcGVXXXXXyXVXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1ScchGVXXXXaiXFXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1mBG3GVXXXXbdaXXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB15IIEGpXXXXcAapXXSutbFXXX\" />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1.FUcGVXXXXcYXFXXSutbFXXX\" />\r\n</p>',0,0,0,75,0,0.00,0.00,0.00,1440393666,'','','','','','',0,0,9,'江苏','南京',4288,5,'yorick',1,1,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',1,'0',0.00,0,0,0.00),(162,'给最好的自己——萌奇小可乐移动电源','ux21487ux20048,ux30005ux28304,ux31227ux21160,ux26368ux22909,ux33258ux24049,ux32473ux26368ux22909ux30340ux33258ux24049ux8212ux8212ux33804ux22855ux23567ux21487ux20048ux31227ux21160ux30005ux28304,ux32473ux26368ux22909ux30340ux33258ux24049ux8212ux8212ux33804ux22855ux23567ux21487ux20048ux31227ux21160ux30005ux28304,ux32473ux26368ux22909ux30340ux33258ux24049ux8212ux8212ux33804ux22855ux23567ux21487ux20048ux31227ux21160ux30005ux28304','可乐,电源,移动,最好,自己,给最好的自己——萌奇小可乐移动电源,给最好的自己——萌奇小可乐移动电源,给最好的自己——萌奇小可乐移动电源','./public/attachment/201508/24/21/55db1ed169599.jpg','','',3,1438580465,1439790068,1,1.00,'我们不生产电源，我们只做电源的搬运工！','<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<span style=\"line-height:1.5;\">我们不生产电源，我们只做电源的搬运工！</span> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<br />\r\n</p>\r\n<div id=\"J_Desc\" style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<p>\r\n		<img src=\"http://img04.taobaocdn.com/tfscom/TB1q1YDGVXXXXcIXXXXSutbFXXX\" /> \r\n	</p>\r\n</div>\r\n<p>\r\n	<br />\r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1RijCGVXXXXc1XXXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1scHtGVXXXXbSaXXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB14fftGVXXXXbgaXXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB12WDDGVXXXXc8XXXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1VurzGVXXXXX9XFXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1q8zxGVXXXXcHXFXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1pvzDGVXXXXcwXXXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1CXjDGVXXXXXmXpXXSutbFXXX\" /> \r\n</p>\r\n<p style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1dBrvGVXXXXbIXVXXSutbFXXX\" /> \r\n</p>\r\n<div>\r\n	<br />\r\n</div>',0,0,0,89,0,0.00,0.00,0.00,1440394881,'','','','','','',0,0,4,'广东','深圳',4288,6,'yorick',1,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'',0.00,1,0,0.00),(163,'为梦想点灯——跟大触LIKE一起学矢量插画','ux28857ux28783,ux30690ux37327,ux25554ux30011,ux26790ux24819,ux19968ux36215,ux76ux73ux75ux69,ux20026ux26790ux24819ux28857ux28783ux8212ux8212ux36319ux22823ux35302ux76ux73ux75ux69ux19968ux36215ux23398ux30690ux37327ux25554ux30011,ux20026ux26790ux24819ux28857ux28783ux8212ux8212ux36319ux22823ux35302ux76ux73ux75ux69ux19968ux36215ux23398ux30690ux37327ux25554ux30011,ux20026ux26790ux24819ux28857ux28783ux8212ux8212ux36319ux22823ux35302ux76ux73ux75ux69ux19968ux36215ux23398ux30690ux37327ux25554ux30011,ux20026ux26790ux24819ux28857ux28783ux8212ux8212ux36319ux22823ux35302ux76ux73ux75ux69ux19968ux36215ux23398ux30690ux37327ux25554ux30011','点灯,矢量,插画,梦想,一起,LIKE,为梦想点灯——跟大触LIKE一起学矢量插画,为梦想点灯——跟大触LIKE一起学矢量插画,为梦想点灯——跟大触LIKE一起学矢量插画,为梦想点灯——跟大触LIKE一起学矢量插画','./public/attachment/201508/24/21/55db201494bf0.jpg','','',20,1438580752,1440481554,1,11.00,'漫画师LIKE细细讲述绘画的奥秘！','<h2 style=\"font-size:18px;color:#2A2A2A;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<div style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n		漫画师LIKE细细讲述绘画的奥秘！\r\n	</div>\r\n	<div id=\"J_Desc\" style=\"color:#2A2A2A;font-size:14px;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n		<h2 style=\"font-size:18px;\">\r\n			<img src=\"http://img04.taobaocdn.com/tfscom/TB1Rmc4HpXXXXbVXpXXSutbFXXX\" /><img src=\"http://img04.taobaocdn.com/tfscom/TB1sLo8HpXXXXadXXXXSutbFXXX\" /> \r\n		</h2>\r\n	</div>\r\n<br />\r\n</h2>\r\n<h2 style=\"font-size:18px;color:#2A2A2A;font-family:tahoma, arial, \'Hiragino Sans GB\', \'microsoft yahei\', 宋体, sans-serif;\">\r\n	<img src=\"http://img04.taobaocdn.com/tfscom/TB1T0c3HpXXXXaaXFXXSutbFXXX\" /><img src=\"http://img04.taobaocdn.com/tfscom/TB1oOs2HpXXXXa8XFXXSutbFXXX\" /><img src=\"http://img04.taobaocdn.com/tfscom/TB18QI1HpXXXXaeXpXXSutbFXXX\" /><img src=\"http://img04.taobaocdn.com/tfscom/TB1BrA9HpXXXXXwXXXXSutbFXXX\" /> \r\n</h2>',0,0,0,95,0,0.00,0.00,0.00,1440395248,'','','','','','',0,0,4,'广东','广州',4288,7,'yorick',0,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:0:{}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'',0.00,0,0,0.00),(164,'问问','ux38382ux38382','问问','./public/attachment/201509/09/17/55effdfe1c711.jpg','','',21,1441762772,1441849140,1,21.00,'123','<h3>\r\n	关于我\r\n</h3>\r\n<p>\r\n	向支持者介绍一下你自己，以及你与所发起的项目之间的背景。这样有助于拉近你与支持者之间的距离。建议不超过100字。\r\n</p>\r\n<h3>\r\n	我想要做什么\r\n</h3>\r\n<p>\r\n	以图文并茂的方式简洁生动地说明你的项目，让大家一目了然，这会决定是否将你的项目描述继续看下去。建议不超过300字。\r\n</p>\r\n<h3>\r\n	为什么我需要你的支持\r\n</h3>\r\n<p>\r\n	这是加分项。说说你的项目不同寻常的特色、资金用途、以及大家支持你的理由。这会让更多人能够支持你，不超过200个汉字。\r\n</p>\r\n<h3>\r\n	我的承诺与回报\r\n</h3>\r\n让大家感到你对待项目的认真程度，鞭策你将项目执行最终成功。同时向大家展示一下你为支持者准备的回报，来吸引更多人支持你。',0,0,0,1,0,0.00,0.00,0.00,1441762692,'','','','问问','ux38382ux38382','问问',0,0,9,'安徽','安庆',4290,0,'李书福子',0,0,1,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:1:{i:0;a:17:{s:2:\"id\";s:3:\"249\";s:7:\"deal_id\";s:3:\"164\";s:5:\"price\";s:4:\"1.00\";s:13:\"support_count\";s:1:\"0\";s:14:\"support_amount\";s:4:\"0.00\";s:11:\"description\";s:2:\"22\";s:11:\"is_delivery\";s:1:\"0\";s:12:\"delivery_fee\";s:4:\"0.00\";s:13:\"is_limit_user\";s:1:\"0\";s:10:\"limit_user\";s:1:\"0\";s:10:\"repaid_day\";s:1:\"1\";s:14:\"virtual_person\";s:1:\"0\";s:8:\"is_share\";s:1:\"0\";s:9:\"share_fee\";s:4:\"0.00\";s:4:\"type\";s:1:\"0\";s:6:\"images\";a:0:{}s:12:\"price_format\";s:1:\"1\";}}}',0,'',0,0,1,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,0.00,0.00,0,0.00,0,0,0.00,0,0.00,'','',0,'',0.00,0,0,0.00),(166,'动物曼陀罗','','','./public/attachment/201511/30/12/565bc9f3c8966.jpg','','',30,0,0,0,20000.00,'','<h3>关于我</h3>\n<p>向支持者介绍一下你自己，以及你与所发起的项目之间的背景。这样有助于拉近你与支持者之间的距离。建议不超过100字。<br />\n<br />\n</p>\n<h3>我想要做什么</h3>\n<p>以图文并茂的方式简洁生动地说明你的项目，让大家一目了然，这会决定是否将你的项目描述继续看下去。建议不超过300字。<br />\n<br />\n</p>\n<h3>为什么我需要你的支持</h3>\n<p>这是加分项。说说你的项目不同寻常的特色、资金用途、以及大家支持你的理由。这会让更多人能够支持你，不超过200个汉字。<br />\n<br />\n</p>\n<h3>我的承诺与回报</h3>\n让大家感到你对待项目的认真程度，鞭策你将项目执行最终成功。同时向大家展示一下你为支持者准备的回报，来吸引更多人支持你。',0,0,0,0,0,0.00,0.00,0.00,1448827267,'','','','曼陀罗 动物','','',0,0,9,'上海','闸北区',4291,0,'大王',0,0,0,'a:2:{s:13:\"deal_faq_list\";a:0:{}s:14:\"deal_item_list\";a:1:{i:0;a:17:{s:2:\"id\";s:3:\"251\";s:7:\"deal_id\";s:3:\"166\";s:5:\"price\";s:4:\"9.90\";s:13:\"support_count\";s:1:\"0\";s:14:\"support_amount\";s:4:\"0.00\";s:11:\"description\";s:12:\"一本台历\";s:11:\"is_delivery\";s:1:\"0\";s:12:\"delivery_fee\";s:4:\"0.00\";s:13:\"is_limit_user\";s:1:\"0\";s:10:\"limit_user\";s:1:\"0\";s:10:\"repaid_day\";s:2:\"30\";s:14:\"virtual_person\";s:1:\"0\";s:8:\"is_share\";s:1:\"0\";s:9:\"share_fee\";s:4:\"0.00\";s:4:\"type\";s:1:\"0\";s:6:\"images\";a:0:{}s:12:\"price_format\";s:4:\"9.90\";}}}',0,'',0,0,0,0.00,'',0,'','',0,'','','','','','','','','','','',0,0,0,0,0,0,'','',0,0,'',0,0,NULL,0.00,0,0.00,0,0,0.00,0,0.00,NULL,'',0,'',0.00,0,0,0.00);
/*!40000 ALTER TABLE `fanwe_deal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_cate`
--

DROP TABLE IF EXISTS `fanwe_deal_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_cate`
--

LOCK TABLES `fanwe_deal_cate` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_cate` DISABLE KEYS */;
INSERT INTO `fanwe_deal_cate` VALUES (2,'文化',3,0,0),(3,'教育',4,0,0),(4,'动漫',2,0,0),(6,'科技',6,0,0),(7,'娱乐',5,0,0),(8,'艺术',7,0,0),(9,'设计',1,0,0),(10,'其他',10,0,0);
/*!40000 ALTER TABLE `fanwe_deal_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_comment`
--

DROP TABLE IF EXISTS `fanwe_deal_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL COMMENT '回复的评论ID',
  `deal_user_id` int(11) NOT NULL COMMENT '项目发起人的ID',
  `reply_user_id` int(11) NOT NULL COMMENT '回复的评论的评论人ID',
  `deal_user_name` varchar(255) NOT NULL,
  `reply_user_name` varchar(255) NOT NULL,
  `deal_info_cache` text NOT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '状态0 表示隐藏 ，1 表示 显示',
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`),
  KEY `log_id` (`log_id`),
  KEY `pid` (`pid`),
  KEY `deal_user_id` (`deal_user_id`),
  KEY `reply_user_id` (`reply_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_comment`
--

LOCK TABLES `fanwe_deal_comment` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_faq`
--

DROP TABLE IF EXISTS `fanwe_deal_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_faq`
--

LOCK TABLES `fanwe_deal_faq` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_focus_log`
--

DROP TABLE IF EXISTS `fanwe_deal_focus_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_focus_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_focus_log`
--

LOCK TABLES `fanwe_deal_focus_log` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_focus_log` DISABLE KEYS */;
INSERT INTO `fanwe_deal_focus_log` VALUES (58,165,4290,1441764397),(61,165,4296,1441765777);
/*!40000 ALTER TABLE `fanwe_deal_focus_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_info_list`
--

DROP TABLE IF EXISTS `fanwe_deal_info_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_info_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL COMMENT '项目ID',
  `type` tinyint(1) NOT NULL COMMENT '类型 0 非股权团队 1 股权团队 2 项目历史 3 计划  4 项目附件',
  `name_list` text NOT NULL,
  `descrip_list` text NOT NULL,
  `pay_list` text NOT NULL COMMENT '支出列表',
  `income_list` text NOT NULL COMMENT '收入列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_info_list`
--

LOCK TABLES `fanwe_deal_info_list` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_info_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_info_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_item`
--

DROP TABLE IF EXISTS `fanwe_deal_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `price` decimal(20,2) NOT NULL COMMENT '金额',
  `support_count` int(11) NOT NULL,
  `support_amount` decimal(20,2) NOT NULL COMMENT '支持量',
  `description` text NOT NULL,
  `is_delivery` tinyint(1) NOT NULL,
  `delivery_fee` decimal(20,2) NOT NULL COMMENT '支付金额',
  `is_limit_user` tinyint(1) NOT NULL COMMENT '是否限',
  `limit_user` int(11) NOT NULL COMMENT '限额数量',
  `repaid_day` int(11) NOT NULL COMMENT '项目成功后的回报时间',
  `virtual_person` int(11) NOT NULL,
  `is_share` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否分红',
  `share_fee` decimal(20,2) NOT NULL COMMENT '分红金额',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示回报类型 1表示无私奉献',
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `price` (`price`)
) ENGINE=MyISAM AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_item`
--

LOCK TABLES `fanwe_deal_item` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_item` DISABLE KEYS */;
INSERT INTO `fanwe_deal_item` VALUES (248,155,200.00,1,200.00,'获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券获得回报优惠券',0,0.00,0,0,0,0,0,0.00,0),(247,155,100.00,0,0.00,'获得回报优惠券获得回报优惠券获得回报优惠券',0,0.00,0,0,10,0,0,0.00,0),(249,164,1.00,0,0.00,'22',0,0.00,0,0,1,0,0,0.00,0),(250,165,1.00,0,0.00,'感谢您的支持，1元有惊喜，每满100人，将由DPIN众创平台官方抽取1名幸运用户，获得”鸭鸭乐防近视智能笔“1套（颜色随机发货）',0,0.00,0,0,60,0,0,0.00,0),(251,166,9.90,0,0.00,'一本台历',0,0.00,0,0,30,0,0,0.00,0);
/*!40000 ALTER TABLE `fanwe_deal_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_item_image`
--

DROP TABLE IF EXISTS `fanwe_deal_item_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_item_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `deal_item_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `deal_item_id` (`deal_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_item_image`
--

LOCK TABLES `fanwe_deal_item_image` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_item_image` DISABLE KEYS */;
INSERT INTO `fanwe_deal_item_image` VALUES (188,155,248,'./public/attachment/201508/17/13/55d17065f2414.png'),(187,155,247,'./public/attachment/201508/17/13/55d17052970d3.jpg');
/*!40000 ALTER TABLE `fanwe_deal_item_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_level`
--

DROP TABLE IF EXISTS `fanwe_deal_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '等级名',
  `level` int(11) DEFAULT NULL COMMENT '等级大小   大->小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_level`
--

LOCK TABLES `fanwe_deal_level` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_level` DISABLE KEYS */;
INSERT INTO `fanwe_deal_level` VALUES (5,'1级',1);
/*!40000 ALTER TABLE `fanwe_deal_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_log`
--

DROP TABLE IF EXISTS `fanwe_deal_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `deal_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `vedio` varchar(255) NOT NULL,
  `source_vedio` varchar(255) NOT NULL,
  `comment_data_cache` text NOT NULL,
  `deal_info_cache` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='项目的动态，主要由发起人更新动态进度';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_log`
--

LOCK TABLES `fanwe_deal_log` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_msg_list`
--

DROP TABLE IF EXISTS `fanwe_deal_msg_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_msg_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dest` varchar(255) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `content` text NOT NULL,
  `send_time` int(11) NOT NULL,
  `is_send` tinyint(1) NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `result` text NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  `title` text NOT NULL,
  `is_youhui` tinyint(1) NOT NULL,
  `youhui_id` int(11) NOT NULL,
  `code` varchar(60) NOT NULL COMMENT '发送的验证码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9640 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_msg_list`
--

LOCK TABLES `fanwe_deal_msg_list` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_msg_list` DISABLE KEYS */;
INSERT INTO `fanwe_deal_msg_list` VALUES (9625,'4008858983@b.qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 14时55分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：520883</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441752956,1,1441752954,0,'发件失败的发件人地址sun@pinman.cn',0,1,'邮件验证码',0,0,'520883'),(9624,'4008858983@b.qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 14时54分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：501927</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441752844,1,1441752844,0,'发件失败的发件人地址sun@pinman.cn',0,1,'邮件验证码',0,0,'501927'),(9623,'4008858983@b.qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 14时50分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：989675</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441752616,1,1441752616,0,'无法连接SMTP服务器',0,1,'邮件验证码',0,0,'989675'),(9622,'4008858983@b.qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 14时41分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：679217</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441752101,1,1441752101,0,'无法连接SMTP服务器',0,1,'邮件验证码',0,0,'679217'),(9621,'4008858983@b.qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 14时35分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：178040</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441751709,1,1441751708,0,'无法连接SMTP服务器',0,1,'邮件验证码',0,0,'178040'),(9620,'13611778605',0,'您的短信校验码为 392152 请勿泄漏，需要您进行身份校验.',1441751211,1,1441751210,0,'发送成功!',1,0,'短信验证码',0,0,'392152'),(9619,'15692162219',0,'您的短信校验码为 982077 请勿泄漏，需要您进行身份校验.',1441745247,1,1441745247,4297,'发送成功!',1,0,'短信验证码',0,0,'982077'),(9617,'15692162219',0,'您的短信校验码为 231326 请勿泄漏，需要您进行身份校验.',1441696026,1,1441696025,4297,'短信内容与备案模板不一致',0,0,'短信验证码',0,0,'231326'),(9618,'15692162219',0,'您的短信校验码为 425570 请勿泄漏，需要您进行身份校验.',1441696239,1,1441696238,4297,'短信内容与备案模板不一致',0,0,'短信验证码',0,0,'425570'),(9614,'15692162219',0,'您的短信校验码为 149114 请勿泄漏，需要您进行身份校验.',1441695478,1,1441695478,4297,'未知错误',0,0,'短信验证码',0,0,'149114'),(9616,'15692162219',0,'您的短信校验码为 358411 请勿泄漏，需要您进行身份校验.',1441695940,1,1441695938,4297,'余额不足',0,0,'短信验证码',0,0,'358411'),(9615,'15692162219',0,'您的短信校验码为 714427 请勿泄漏，需要您进行身份校验.',1441695848,1,1441695846,4297,'未知错误',0,0,'短信验证码',0,0,'714427'),(9613,'15692162219',0,'您的短信校验码为 735589 请勿泄漏，需要您进行身份校验.',1441695138,1,1441695137,4297,'未知错误',0,0,'短信验证码',0,0,'735589'),(9610,'15692162219',0,'您的短信校验码为 897819 请勿泄漏，需要您进行身份校验.',1441233598,1,1441233405,4297,'发送成功!',1,0,'短信验证码',0,0,'897819'),(9611,'15692162219',0,'您的短信校验码为 375606 请勿泄漏，需要您进行身份校验.',1441233527,1,1441233526,4297,'发送成功!',1,0,'短信验证码',0,0,'375606'),(9612,'13611778605',0,'您的短信校验码为 694851 请勿泄漏，需要您进行身份校验.',1441648357,1,1441648356,0,'未知错误',0,0,'短信验证码',0,0,'694851'),(9626,'4008858983@b.qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 14时58分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：984663</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441753103,1,1441753102,0,'发件失败的发件人地址sun@pinman.cn',0,1,'邮件验证码',0,0,'984663'),(9627,'4008858983@b.qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 15时30分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：734414</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441755047,1,1441755046,0,'',1,1,'邮件验证码',0,0,'734414'),(9628,'18021013443',0,'您的短信校验码为 485763 请勿泄漏，需要您进行身份校验.',1441755450,1,1441755450,4290,'发送成功!',1,0,'短信验证码',0,0,'485763'),(9629,'18964673443',0,'您的短信校验码为 526286 请勿泄漏，需要您进行身份校验.',1441755516,1,1441755516,4290,'发送成功!',1,0,'短信验证码',0,0,'526286'),(9630,'18964673443',0,'您的短信校验码为 605901 请勿泄漏，需要您进行身份校验.',1441755622,1,1441755622,4290,'发送成功!',1,0,'短信验证码',0,0,'605901'),(9631,'461225265@qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年09月09日 16时57分 进行投资人申请，很高兴您审核通过,点击以下链接，即可进行下一步操作：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"http://www.dpin.cn/settings-invest_info.html\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">http://www.dpin.cn/settings-invest_info.html</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n 				<div style=\"line-height:80px;height:80px;\"></div>\r\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1441760269,1,1441760269,0,'',1,1,'DPIN众创平台帐号-投资人审核通过',0,0,''),(9632,'18964673443',0,'李书福子，您发起的问问项目失败!',1441762795,1,1441762795,4290,'发送成功!',1,0,'项目问问众筹失败-项目ID-164',0,0,''),(9633,'sun@pinman.cn',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\n<tbody>\n	<tr>\n		<td>\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n        <tbody>\n		<tr>\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\n		</tr>\n        </tbody>\n		</table>\n		</td>\n	</tr>\n	<tr>\n		<td>\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n        <tbody>\n		<tr>\n			<td width=\"25px;\" style=\"width:25px;\"></td>\n			<td align=\"\">\n				<div style=\"line-height:40px;height:40px;\"></div>\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">恭喜您的项目问问审核通过！</p>\n				<p style=\"margin:0px;padding:0px;\"><a href=\"\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\"></a></p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\n 				<div style=\"line-height:80px;height:80px;\"></div>\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\n			</td>\n		</tr>\n		</tbody>\n		</table>\n		</td>\n	</tr>\n	<tr>\n		<td>\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\n			<tbody>\n			<tr>\n				<td width=\"25px;\" style=\"width:25px;\"></td>\n				<td align=\"\">\n					<div style=\"line-height:40px;height:40px;\"></div>\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\n				</td>\n			</tr>\n			</tbody>\n			</table>\n		</td>\n	</tr>\n</tbody>\n</table>',1441762821,1,1441762821,4290,'',1,1,'众筹通知-项目审核通过',0,0,''),(9634,'sun@pinman.cn',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\n<tbody>\n	<tr>\n		<td>\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n        <tbody>\n		<tr>\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\n		</tr>\n        </tbody>\n		</table>\n		</td>\n	</tr>\n	<tr>\n		<td>\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n        <tbody>\n		<tr>\n			<td width=\"25px;\" style=\"width:25px;\"></td>\n			<td align=\"\">\n				<div style=\"line-height:40px;height:40px;\"></div>\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">恭喜您的项目鸭鸭乐防近视智能笔审核通过！</p>\n				<p style=\"margin:0px;padding:0px;\"><a href=\"\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\"></a></p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\n 				<div style=\"line-height:80px;height:80px;\"></div>\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年09月09日</span></p>\n			</td>\n		</tr>\n		</tbody>\n		</table>\n		</td>\n	</tr>\n	<tr>\n		<td>\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\n			<tbody>\n			<tr>\n				<td width=\"25px;\" style=\"width:25px;\"></td>\n				<td align=\"\">\n					<div style=\"line-height:40px;height:40px;\"></div>\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\n				</td>\n			</tr>\n			</tbody>\n			</table>\n		</td>\n	</tr>\n</tbody>\n</table>',1441764277,1,1441764277,4290,'',1,1,'众筹通知-项目审核通过',0,0,''),(9635,'13817306425',0,'您的短信校验码为 950040 请勿泄漏，需要您进行身份校验.',1441768739,1,1441766841,4291,'发送成功!',1,0,'短信验证码',0,0,'950040'),(9636,'13817306425',0,'您的短信校验码为 452782 请勿泄漏，需要您进行身份校验.',1441768744,1,1441766934,4291,'发送成功!',1,0,'短信验证码',0,0,'452782'),(9637,'13817306425',0,'您的短信校验码为 167606 请勿泄漏，需要您进行身份校验.',1441826850,1,1441826848,4291,'发送成功!',1,0,'短信验证码',0,0,'167606'),(9638,'18964673443',0,'李书福子，您发起的鸭鸭乐防近视智能笔项目失败!',1446202620,1,1446172668,4290,'未知错误',0,0,'项目鸭鸭乐防近视智能笔众筹失败-项目ID-165',0,0,''),(9639,'461225265@qq.com',1,'<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"http://www.dpin.cn/public/attachment/201508/24/13/55daa4f6526b2.png\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 2015年11月30日 12时04分 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：380607</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">DPIN众创平台帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">2015年11月30日</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过DPIN众创平台帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1448827494,1,1448827492,4296,'发件失败的发件人地址hyz12580@163.com',0,1,'邮件验证码',0,0,'380607');
/*!40000 ALTER TABLE `fanwe_deal_msg_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_notify`
--

DROP TABLE IF EXISTS `fanwe_deal_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=596 DEFAULT CHARSET=utf8 COMMENT='准备发送通知的项目ID';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_notify`
--

LOCK TABLES `fanwe_deal_notify` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_notify` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_order`
--

DROP TABLE IF EXISTS `fanwe_deal_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `deal_item_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `pay_time` int(11) NOT NULL,
  `total_price` decimal(20,2) NOT NULL COMMENT '总价',
  `delivery_fee` decimal(20,2) NOT NULL COMMENT '运费',
  `deal_price` decimal(20,2) NOT NULL COMMENT '项目费用',
  `support_memo` text NOT NULL,
  `payment_id` int(11) NOT NULL,
  `bank_id` varchar(255) NOT NULL,
  `credit_pay` decimal(20,2) NOT NULL COMMENT '信贷付款',
  `online_pay` decimal(20,2) NOT NULL COMMENT '在线付款',
  `deal_name` varchar(255) NOT NULL,
  `order_status` tinyint(1) NOT NULL COMMENT '0:未支付 1:已支付(过期) 2:已支付(无库存) 3:成功',
  `create_time` int(11) NOT NULL,
  `consignee` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `repay_time` int(11) NOT NULL COMMENT '回报更新时间',
  `repay_memo` text NOT NULL COMMENT '回报备注，由发起人更新',
  `is_refund` tinyint(1) NOT NULL COMMENT '已退款 0:未 1:已',
  `is_has_send_success` tinyint(1) NOT NULL,
  `repay_make_time` int(11) NOT NULL DEFAULT '0' COMMENT '回报确认时间',
  `share_fee` decimal(20,2) NOT NULL COMMENT '分红金额',
  `share_status` tinyint(1) NOT NULL COMMENT '分红是否发放：0未发放，1已发',
  `is_tg` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是第三方托管',
  `score` int(11) NOT NULL COMMENT '付款积分',
  `score_money` decimal(20,2) NOT NULL COMMENT '积分对换的余额,对换的余额已加到余额支付里，这里记录是用在查看，退款时用',
  `sp_multiple` varchar(255) NOT NULL COMMENT '记录"购买送支付金额的几倍信用/积分"的倍数的反序列数组array("score_multiple"=>''倍数'',"point_multiple"=>''倍数''）,退款时用',
  `logistics_company` varchar(255) NOT NULL COMMENT '物流公司',
  `logistics_links` varchar(255) NOT NULL COMMENT '物流链接',
  `logistics_number` varchar(255) NOT NULL COMMENT '物流单号',
  `invest_id` int(11) NOT NULL COMMENT '投资id',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单类型 0表示普通众筹 1表示股权众筹 2表示无私奉献',
  `requestNo` varchar(255) NOT NULL COMMENT 'yeepay_log.id',
  `is_complete_transaction` tinyint(1) NOT NULL COMMENT '0 表示未放款 1表示放款  2表示退款',
  `fee` decimal(20,2) NOT NULL COMMENT '手续费',
  `targetAmount` decimal(20,2) NOT NULL COMMENT '获取的目标金额',
  `progress` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目进度 0 表示未支付 2表示已支付定金 3表示支付首付 4表示退款处理 5放款处理',
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `deal_item_id` (`deal_item_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2147 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_order`
--

LOCK TABLES `fanwe_deal_order` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_pay_log`
--

DROP TABLE IF EXISTS `fanwe_deal_pay_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_pay_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `money` decimal(20,2) NOT NULL,
  `create_time` int(11) NOT NULL,
  `log_info` text NOT NULL,
  `comissions` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '佣金',
  `share_fee` decimal(20,2) NOT NULL,
  `delivery_fee` decimal(20,2) NOT NULL,
  `requestNo` varchar(255) NOT NULL COMMENT '是第三方支付的请求号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `no` (`requestNo`) USING BTREE,
  KEY `deal_id` (`deal_id`),
  KEY `create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='项目支持金额发放记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_pay_log`
--

LOCK TABLES `fanwe_deal_pay_log` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_pay_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_pay_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_support_log`
--

DROP TABLE IF EXISTS `fanwe_deal_support_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_support_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `price` decimal(20,2) NOT NULL COMMENT '金额',
  `deal_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `create_time` (`create_time`),
  KEY `deal_item_id` (`deal_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1779 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_support_log`
--

LOCK TABLES `fanwe_deal_support_log` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_support_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_support_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_visit_log`
--

DROP TABLE IF EXISTS `fanwe_deal_visit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_visit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deal_id` int(11) NOT NULL,
  `client_ip` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24864 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_visit_log`
--

LOCK TABLES `fanwe_deal_visit_log` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_visit_log` DISABLE KEYS */;
INSERT INTO `fanwe_deal_visit_log` VALUES (24020,155,'123.14.81.83',1439762124),(24019,155,'220.181.132.15',1439761843),(24018,155,'101.199.112.54',1439761214),(24017,155,'220.181.132.215',1439761119),(24016,156,'123.14.81.83',1439760892),(24015,155,'123.14.81.83',1439760399),(24021,156,'180.175.239.186',1440304628),(24022,155,'42.81.45.112',1440313255),(24023,155,'222.44.84.34',1440363063),(24024,155,'222.44.84.34',1440363718),(24025,155,'180.175.106.51',1440364078),(24026,155,'180.153.206.32',1440364443),(24027,155,'222.44.84.34',1440364832),(24028,155,'220.181.132.215',1440365332),(24029,155,'222.44.84.34',1440365481),(24030,155,'180.175.106.51',1440365694),(24031,155,'101.199.108.58',1440365921),(24032,155,'101.226.33.238',1440366434),(24033,155,'223.104.5.194',1440366767),(24034,155,'222.44.84.34',1440366991),(24035,155,'180.153.206.13',1440366991),(24036,155,'180.170.154.212',1440367138),(24037,157,'115.231.225.9',1440391404),(24038,155,'115.231.225.9',1440391915),(24039,157,'101.226.65.107',1440392214),(24040,159,'115.231.225.9',1440392422),(24041,159,'180.153.163.191',1440393233),(24042,162,'115.231.225.9',1440394925),(24043,163,'115.231.225.9',1440395268),(24044,162,'180.153.163.208',1440395731),(24045,162,'115.231.225.9',1440396078),(24046,162,'180.170.154.212',1440396547),(24047,163,'180.158.163.86',1440397017),(24048,162,'101.226.51.230',1440397372),(24049,162,'180.170.154.212',1440399506),(24050,162,'101.226.69.108',1440399507),(24051,163,'101.254.17.164',1440400007),(24052,162,'101.226.33.216',1440400249),(24053,162,'49.75.74.166',1440404234),(24054,159,'222.44.84.34',1440439062),(24055,158,'222.44.84.34',1440439368),(24056,159,'222.44.84.34',1440439671),(24057,159,'116.231.110.199',1440439853),(24058,159,'180.153.201.15',1440440663),(24059,161,'222.44.84.34',1440440881),(24060,159,'116.231.110.199',1440441340),(24061,155,'222.44.84.34',1440442126),(24062,159,'58.246.135.226',1440446488),(24063,159,'223.104.5.234',1440446504),(24064,159,'220.152.138.73',1440451500),(24065,157,'220.152.138.73',1440451533),(24066,155,'42.81.42.47',1440485421),(24067,159,'66.249.69.9',1440491132),(24068,158,'66.249.69.17',1440491140),(24069,161,'66.249.69.9',1440491149),(24070,160,'66.249.69.25',1440491157),(24071,156,'66.249.69.9',1440491398),(24072,163,'66.249.69.25',1440491399),(24073,155,'66.249.69.17',1440491401),(24074,162,'66.249.69.9',1440491402),(24075,157,'66.249.69.9',1440491404),(24076,162,'66.249.64.32',1440566004),(24077,155,'182.118.22.211',1440566226),(24078,159,'66.249.64.87',1440575299),(24079,163,'66.249.64.97',1440605412),(24080,159,'66.249.64.22',1440609474),(24081,163,'66.249.64.92',1440611682),(24082,163,'66.249.64.87',1440620931),(24083,163,'66.249.69.17',1440632334),(24084,159,'66.249.64.92',1440647595),(24085,163,'182.118.22.211',1440647750),(24086,160,'101.226.168.205',1440647758),(24087,162,'101.226.168.222',1440647872),(24088,161,'101.226.168.222',1440647922),(24089,159,'101.226.166.199',1440647933),(24090,157,'182.118.25.209',1440648406),(24091,159,'180.175.106.51',1440652836),(24092,155,'180.175.106.51',1440652871),(24093,155,'180.175.106.51',1440653620),(24094,155,'180.175.106.51',1440654779),(24095,155,'118.144.80.16',1440659154),(24096,159,'66.249.64.87',1440662151),(24097,163,'66.249.64.92',1440666142),(24098,159,'66.249.64.87',1440666707),(24099,163,'66.249.64.92',1440687524),(24100,160,'66.249.64.92',1440692797),(24101,163,'118.144.80.16',1440697175),(24102,161,'182.118.21.220',1440864813),(24103,159,'116.234.205.134',1440916426),(24104,158,'101.226.167.217',1440948846),(24105,156,'182.118.20.254',1441003752),(24106,155,'180.175.106.51',1441047613),(24107,155,'180.175.106.51',1441059633),(24108,159,'66.249.79.230',1441248836),(24109,163,'66.249.79.230',1441265127),(24110,158,'182.118.22.230',1441346331),(24111,159,'222.44.84.34',1441479228),(24112,159,'101.226.65.104',1441479229),(24113,159,'182.118.20.203',1441480730),(24114,156,'101.226.168.195',1441582534),(24115,163,'140.206.71.122',1441682447),(24116,157,'182.118.25.219',1441719025),(24117,155,'220.181.108.107',1441737815),(24118,157,'123.125.71.39',1441738647),(24119,161,'123.125.71.23',1441739201),(24120,158,'123.125.71.107',1441739755),(24121,159,'220.181.108.148',1441740033),(24122,163,'220.181.108.180',1441740863),(24123,160,'220.181.108.160',1441741694),(24124,162,'220.181.108.154',1441741972),(24125,155,'222.44.84.34',1441751458),(24126,155,'123.125.106.97',1441751532),(24127,155,'180.149.135.15',1441751532),(24128,155,'180.153.163.191',1441752268),(24129,162,'222.44.84.34',1441756374),(24130,157,'222.44.84.34',1441756858),(24131,163,'222.44.84.34',1441756891),(24132,162,'101.226.33.202',1441757183),(24133,162,'222.44.84.34',1441760100),(24134,155,'222.44.84.34',1441760108),(24135,155,'222.44.84.34',1441761913),(24136,162,'222.44.84.34',1441762487),(24137,164,'222.44.84.34',1441762905),(24138,165,'222.44.84.34',1441764302),(24139,155,'222.44.84.34',1441764337),(24140,165,'123.125.106.97',1441764400),(24141,165,'180.149.135.15',1441764400),(24142,165,'112.65.193.14',1441765119),(24143,165,'101.226.51.228',1441765267),(24144,165,'222.44.84.34',1441765278),(24145,163,'222.44.84.34',1441765738),(24146,165,'110.75.105.199',1441765844),(24147,165,'180.158.163.86',1441766284),(24148,165,'223.104.5.239',1441766309),(24149,165,'223.104.5.199',1441766312),(24150,165,'180.158.163.86',1441772701),(24151,160,'182.118.21.215',1441773692),(24152,165,'118.144.80.16',1441773783),(24153,165,'42.81.42.47',1441777025),(24154,165,'42.81.42.47',1441779661),(24155,159,'220.181.108.158',1441793533),(24156,165,'222.44.84.34',1441826821),(24157,165,'222.44.84.34',1441827921),(24158,165,'66.249.67.11',1441838136),(24159,155,'123.125.71.83',1441838458),(24160,165,'123.125.71.15',1441861453),(24161,158,'101.226.168.230',1441985392),(24162,165,'182.118.25.231',1441985641),(24163,161,'123.125.71.78',1442057121),(24164,161,'182.118.22.204',1442076784),(24165,163,'182.118.22.241',1442201355),(24166,165,'182.118.20.169',1442287708),(24167,163,'123.125.71.54',1442368301),(24168,160,'68.180.228.168',1442373366),(24169,162,'68.180.228.168',1442373375),(24170,165,'68.180.228.168',1442373584),(24171,155,'68.180.228.168',1442373703),(24172,163,'68.180.228.168',1442373874),(24173,159,'68.180.228.168',1442374648),(24174,158,'68.180.228.168',1442399545),(24175,165,'14.18.29.137',1442419418),(24176,159,'101.226.168.244',1442421885),(24177,163,'222.211.175.206',1442432962),(24178,163,'180.153.214.176',1442433778),(24179,157,'68.180.228.168',1442444448),(24180,161,'68.180.228.168',1442477295),(24181,162,'101.226.167.250',1442517019),(24182,156,'101.226.167.239',1442877244),(24183,165,'101.226.168.216',1442902310),(24184,157,'101.226.166.229',1442933384),(24185,165,'66.249.75.154',1443025740),(24186,160,'101.226.167.213',1443033579),(24187,158,'101.226.169.223',1443199925),(24188,159,'66.249.64.97',1443231873),(24189,157,'222.44.84.34',1443376039),(24190,159,'101.231.205.185',1443379157),(24191,159,'222.44.84.34',1443390316),(24192,163,'222.44.84.34',1443560054),(24193,163,'101.226.65.107',1443560055),(24194,161,'182.118.22.141',1443726946),(24195,163,'203.208.60.30',1443871956),(24196,163,'182.118.20.222',1443900098),(24197,160,'123.125.71.14',1444003073),(24198,158,'222.44.84.34',1444182669),(24199,158,'180.153.206.27',1444182669),(24200,165,'101.226.167.211',1444218674),(24201,161,'123.125.71.86',1444246219),(24202,165,'101.231.205.185',1444256398),(24203,158,'123.125.71.15',1444433070),(24204,165,'66.249.75.145',1444511767),(24205,162,'101.226.168.237',1444538654),(24206,159,'182.118.25.203',1444565468),(24207,158,'106.120.123.213',1444587304),(24208,165,'123.125.71.39',1444607608),(24209,165,'66.249.65.223',1444737591),(24210,165,'66.249.65.230',1444750172),(24211,165,'66.249.65.237',1444779896),(24212,165,'66.249.74.96',1444811151),(24213,165,'66.249.74.96',1444892631),(24214,163,'220.181.108.86',1445115443),(24215,159,'66.249.74.100',1445168945),(24216,163,'66.249.74.100',1445200125),(24217,155,'180.153.205.253',1445380761),(24218,155,'221.226.22.211',1445380762),(24219,157,'101.226.168.199',1445478822),(24220,158,'66.249.69.9',1445500565),(24221,160,'101.226.168.243',1445535992),(24222,159,'66.249.69.17',1445573316),(24223,165,'203.208.60.41',1445596050),(24224,156,'203.208.60.34',1445600597),(24225,160,'203.208.60.36',1445605144),(24226,157,'203.208.60.31',1445612833),(24227,158,'101.226.167.208',1445665271),(24228,163,'66.249.67.154',1445676283),(24229,157,'157.55.39.118',1445692299),(24230,159,'123.125.71.111',1445802605),(24231,157,'68.180.228.168',1445963248),(24232,159,'211.161.247.121',1446009446),(24233,159,'211.161.247.121',1446010162),(24234,165,'66.249.64.92',1446112006),(24235,160,'211.161.248.130',1446141712),(24236,158,'211.161.248.130',1446141951),(24237,159,'211.161.248.130',1446142010),(24238,157,'211.161.248.130',1446142058),(24239,158,'157.55.39.195',1446148832),(24240,159,'66.249.65.9',1446209886),(24241,159,'207.46.13.4',1446240805),(24242,165,'66.249.65.13',1446340777),(24243,155,'207.46.13.104',1446367404),(24244,161,'182.118.22.142',1446475468),(24245,165,'101.226.166.249',1446540794),(24246,163,'182.118.21.243',1446631005),(24247,160,'68.180.228.168',1446671233),(24248,162,'123.125.71.34',1446875105),(24249,163,'68.180.228.168',1446944850),(24250,157,'123.125.71.42',1447043097),(24251,161,'68.180.228.168',1447088921),(24252,157,'220.181.108.153',1447157132),(24253,163,'66.249.69.25',1447201572),(24254,159,'101.226.167.241',1447248502),(24255,162,'68.180.228.168',1447261848),(24256,162,'182.118.25.205',1447306890),(24257,156,'220.181.108.181',1447337372),(24258,157,'123.125.71.89',1447372660),(24259,165,'68.180.228.168',1447393952),(24260,156,'182.118.22.242',1447424418),(24261,159,'68.180.228.168',1447444420),(24262,160,'123.125.71.45',1447465399),(24263,155,'40.77.167.9',1447471507),(24264,159,'207.46.13.46',1447575538),(24265,157,'157.55.39.64',1447580884),(24266,158,'68.180.228.168',1447583577),(24267,155,'68.180.228.168',1447592222),(24268,165,'58.246.97.82',1447609626),(24269,156,'101.226.166.207',1447662239),(24270,165,'66.249.66.100',1447712628),(24271,158,'40.77.167.43',1447755706),(24272,159,'66.249.66.100',1447841349),(24273,158,'157.55.39.130',1448043928),(24274,158,'123.125.71.107',1448142069),(24275,157,'101.226.167.243',1448217503),(24276,160,'101.226.167.204',1448278689),(24277,163,'123.125.71.43',1448293912),(24278,158,'101.226.166.225',1448357119),(24279,156,'182.118.25.210',1448357291),(24280,163,'66.249.69.25',1448597971),(24281,159,'220.181.108.102',1448764424),(24282,165,'180.153.236.41',1448822983),(24283,165,'101.81.55.163',1448833664),(24284,160,'123.125.71.33',1449066759),(24285,157,'157.55.39.80',1449141556),(24286,165,'157.55.39.161',1449173672),(24287,163,'220.181.108.83',1449174474),(24288,157,'220.181.108.121',1449176474),(24289,162,'220.181.108.154',1449217482),(24290,155,'123.125.71.82',1449220490),(24291,161,'182.118.22.243',1449228130),(24292,159,'66.249.66.100',1449302829),(24293,163,'101.226.169.221',1449334179),(24294,160,'220.181.108.151',1449428557),(24295,165,'182.118.22.212',1449432684),(24296,156,'220.181.108.140',1449485560),(24297,158,'157.55.39.116',1449539180),(24298,155,'180.173.1.108',1449627954),(24299,163,'180.173.1.108',1449628012),(24300,159,'180.173.1.108',1449628045),(24301,159,'157.55.39.168',1449685377),(24302,165,'123.125.71.27',1449780105),(24303,155,'40.77.167.65',1449782904),(24304,161,'220.181.108.99',1449864684),(24305,163,'110.75.145.1',1449946343),(24306,159,'110.75.145.1',1449946353),(24307,160,'110.75.145.1',1449946358),(24308,155,'110.75.145.2',1449946385),(24309,162,'110.75.145.1',1449946412),(24310,158,'110.75.145.2',1449946438),(24311,157,'110.75.145.1',1449946448),(24312,165,'110.75.145.2',1449946466),(24313,161,'110.75.145.1',1449949234),(24314,156,'110.75.145.2',1450040580),(24315,159,'68.180.228.168',1450045438),(24316,165,'68.180.228.168',1450069603),(24317,160,'68.180.228.168',1450099333),(24318,156,'68.180.228.168',1450156946),(24319,159,'101.226.169.227',1450181979),(24320,161,'123.125.71.29',1450249036),(24321,157,'68.180.228.168',1450292700),(24322,163,'115.236.52.106',1450296866),(24323,163,'101.226.89.123',1450296866),(24324,161,'68.180.228.168',1450339716),(24325,163,'27.156.7.14',1450415432),(24326,158,'123.125.71.107',1450423364),(24327,160,'220.181.108.186',1450428404),(24328,158,'68.180.228.168',1450475666),(24329,161,'123.125.71.23',1450539785),(24330,162,'101.226.166.196',1450549877),(24331,160,'110.75.145.2',1450600865),(24332,155,'110.75.145.1',1450600903),(24333,163,'110.75.145.2',1450600962),(24334,159,'110.75.145.1',1450600987),(24335,165,'110.75.145.2',1450600998),(24336,161,'110.75.145.1',1450601043),(24337,162,'110.75.145.1',1450601060),(24338,158,'110.75.145.2',1450601104),(24339,157,'110.75.145.1',1450601139),(24340,156,'182.118.20.224',1450640292),(24341,155,'68.180.228.168',1450703161),(24342,165,'207.46.13.101',1450735471),(24343,159,'66.249.69.9',1450756206),(24344,162,'68.180.228.168',1450764700),(24345,156,'110.75.145.1',1450797009),(24346,160,'40.77.167.20',1450838919),(24347,163,'66.249.64.87',1450841968),(24348,161,'157.55.39.166',1450843991),(24349,162,'123.125.71.38',1450949348),(24350,158,'123.125.71.33',1450950835),(24351,163,'207.46.13.163',1450971194),(24352,157,'123.125.71.117',1450972176),(24353,157,'207.46.13.163',1451006250),(24354,155,'220.181.108.155',1451008936),(24355,163,'66.249.66.102',1451012194),(24356,159,'123.125.71.22',1451038357),(24357,163,'68.180.228.168',1451050816),(24358,161,'123.125.71.91',1451063109),(24359,158,'110.75.145.2',1451216309),(24360,162,'110.75.145.2',1451216322),(24361,157,'110.75.145.2',1451216327),(24362,165,'110.75.145.1',1451216380),(24363,161,'110.75.145.1',1451216395),(24364,159,'110.75.145.1',1451216432),(24365,163,'110.75.145.2',1451216442),(24366,160,'110.75.145.1',1451216452),(24367,155,'110.75.145.2',1451216488),(24368,156,'110.75.145.2',1451386355),(24369,157,'182.118.22.210',1451501400),(24370,163,'123.125.71.21',1451557299),(24371,160,'182.118.20.164',1451590657),(24372,155,'123.125.71.69',1451619831),(24373,165,'123.125.71.55',1451769649),(24374,155,'106.38.241.108',1452041418),(24375,159,'106.38.241.108',1452041543),(24376,160,'106.38.241.108',1452041590),(24377,161,'106.38.241.108',1452041682),(24378,165,'106.38.241.108',1452041862),(24379,157,'106.38.241.108',1452041915),(24380,163,'106.38.241.108',1452041968),(24381,158,'106.38.241.108',1452042028),(24382,162,'106.38.241.108',1452042055),(24383,158,'106.38.241.108',1452059107),(24384,157,'106.38.241.108',1452059162),(24385,165,'106.38.241.108',1452059248),(24386,157,'106.38.241.108',1452066710),(24387,162,'106.38.241.108',1452066819),(24388,155,'110.75.145.1',1452094712),(24389,160,'110.75.145.1',1452096378),(24390,163,'110.75.145.1',1452123881),(24391,159,'110.75.145.1',1452124500),(24392,161,'110.75.145.2',1452124570),(24393,165,'110.75.145.2',1452124650),(24394,157,'110.75.145.2',1452125974),(24395,162,'110.75.145.1',1452126023),(24396,158,'110.75.145.1',1452126072),(24397,156,'110.75.145.1',1452171895),(24398,165,'40.77.167.75',1452241718),(24399,163,'101.226.168.253',1452339129),(24400,159,'66.249.66.102',1452420370),(24401,155,'106.38.241.108',1452429459),(24402,163,'66.249.66.104',1452435744),(24403,159,'207.46.13.27',1452481709),(24404,155,'110.75.145.2',1452514159),(24405,160,'110.75.145.2',1452514194),(24406,163,'110.75.145.2',1452514199),(24407,159,'110.75.145.2',1452514204),(24408,161,'110.75.145.1',1452514271),(24409,165,'110.75.145.1',1452514276),(24410,157,'110.75.145.2',1452514325),(24411,162,'110.75.145.1',1452514335),(24412,158,'110.75.145.2',1452515764),(24413,159,'106.38.241.108',1452602827),(24414,160,'106.38.241.108',1452602878),(24415,165,'180.173.17.205',1452632719),(24416,156,'110.75.145.2',1452640578),(24417,161,'106.38.241.108',1452660728),(24418,163,'106.38.241.108',1452660772),(24419,158,'106.38.241.108',1452718073),(24420,165,'106.38.241.108',1452775343),(24421,162,'157.55.39.98',1452783069),(24422,155,'42.62.36.201',1452796818),(24423,158,'42.62.36.195',1452796818),(24424,160,'42.62.36.201',1452796821),(24425,162,'42.62.36.231',1452796823),(24426,159,'42.62.36.201',1452796823),(24427,161,'42.62.36.231',1452796828),(24428,157,'42.62.36.231',1452796831),(24429,163,'42.62.36.201',1452796835),(24430,159,'66.249.65.13',1452816801),(24431,159,'66.249.65.9',1452832780),(24432,157,'110.75.145.2',1452981803),(24433,158,'110.75.145.1',1452988073),(24434,162,'110.75.145.2',1452988298),(24435,161,'110.75.145.2',1452988306),(24436,165,'110.75.145.2',1452990229),(24437,159,'110.75.145.2',1452990246),(24438,163,'110.75.145.1',1452990422),(24439,155,'110.75.145.2',1452991919),(24440,160,'110.75.145.1',1452991940),(24441,156,'110.75.145.1',1453049254),(24442,158,'207.46.13.166',1453129440),(24443,162,'42.62.37.64',1453148831),(24444,162,'106.38.241.108',1453193300),(24445,162,'101.226.166.202',1453265471),(24446,159,'40.77.167.45',1453311144),(24447,156,'115.236.52.106',1453331687),(24448,165,'203.208.60.31',1453401326),(24449,159,'118.124.34.47',1453419062),(24450,162,'118.124.34.47',1453419062),(24451,155,'118.124.34.47',1453419063),(24452,158,'118.124.34.47',1453419063),(24453,161,'118.124.34.47',1453419063),(24454,165,'118.124.34.47',1453419064),(24455,163,'118.124.34.47',1453419065),(24456,160,'118.124.34.47',1453419065),(24457,157,'118.124.34.47',1453419066),(24458,159,'139.201.247.176',1453430435),(24459,162,'139.201.247.176',1453430435),(24460,155,'139.201.247.176',1453430436),(24461,158,'139.201.247.176',1453430436),(24462,161,'139.201.247.176',1453430437),(24463,165,'139.201.247.176',1453430438),(24464,163,'139.201.247.176',1453430439),(24465,160,'139.201.247.176',1453430439),(24466,157,'139.201.247.176',1453430440),(24467,162,'101.226.166.231',1453457474),(24468,163,'157.55.39.143',1453484702),(24469,162,'182.118.20.211',1453613916),(24470,158,'68.180.228.168',1453614976),(24471,159,'106.38.241.108',1453754513),(24472,160,'106.38.241.108',1453754559),(24473,163,'66.249.64.87',1453757069),(24474,155,'203.208.60.25',1453798178),(24475,161,'106.38.241.108',1453812451),(24476,163,'106.38.241.108',1453812468),(24477,161,'68.180.228.168',1453817937),(24478,161,'203.208.60.35',1453820664),(24479,158,'42.62.36.195',1453833663),(24480,155,'42.62.36.201',1453833664),(24481,160,'42.62.36.201',1453833670),(24482,161,'42.62.36.231',1453833674),(24483,162,'42.62.36.231',1453833676),(24484,157,'42.62.36.231',1453833678),(24485,163,'42.62.36.201',1453833690),(24486,155,'182.118.20.211',1453851866),(24487,162,'203.208.60.29',1453879370),(24488,159,'42.62.37.17',1453936291),(24489,162,'38.99.82.191',1453963715),(24490,157,'38.99.82.191',1453965732),(24491,161,'38.99.82.191',1453971863),(24492,158,'38.99.82.191',1453975718),(24493,163,'38.99.82.248',1453980863),(24494,156,'42.62.36.71',1454007131),(24495,159,'203.208.60.27',1454076063),(24496,165,'203.208.60.36',1454076077),(24497,160,'203.208.60.27',1454135383),(24498,157,'203.208.60.40',1454135612),(24499,163,'68.180.228.168',1454151717),(24500,160,'110.75.145.1',1454154260),(24501,155,'110.75.145.2',1454154267),(24502,163,'110.75.145.1',1454154303),(24503,159,'110.75.145.1',1454154320),(24504,165,'110.75.145.1',1454154330),(24505,161,'110.75.145.1',1454154345),(24506,162,'110.75.145.2',1454154361),(24507,158,'110.75.145.2',1454154387),(24508,157,'110.75.145.2',1454154412),(24509,158,'203.208.60.27',1454162072),(24510,156,'110.75.145.2',1454176463),(24511,157,'38.99.82.212',1454194591),(24512,160,'38.99.82.212',1454195060),(24513,163,'38.99.82.212',1454195105),(24514,159,'38.99.82.212',1454195115),(24515,155,'38.99.82.212',1454195333),(24516,158,'38.99.82.212',1454195546),(24517,165,'38.99.82.212',1454195597),(24518,161,'38.99.82.212',1454195642),(24519,162,'38.99.82.212',1454195733),(24520,156,'66.249.65.5',1454269922),(24521,162,'182.118.20.224',1454344138),(24522,160,'40.77.167.9',1454354918),(24523,162,'42.62.37.64',1454374095),(24524,155,'123.125.71.39',1454380930),(24525,162,'220.181.108.179',1454457063),(24526,163,'192.243.55.134',1454487677),(24527,161,'157.55.39.122',1454487889),(24528,157,'192.243.55.137',1454489851),(24529,162,'192.243.55.129',1454489989),(24530,159,'192.243.55.136',1454490406),(24531,155,'192.243.55.129',1454490950),(24532,160,'192.243.55.131',1454491053),(24533,165,'192.243.55.136',1454491886),(24534,161,'192.243.55.134',1454491998),(24535,158,'192.243.55.136',1454492643),(24536,158,'123.125.71.91',1454529704),(24537,163,'191.232.136.132',1454559031),(24538,157,'123.125.71.44',1454620136),(24539,157,'68.180.228.168',1454656829),(24540,159,'123.125.71.42',1454743957),(24541,165,'68.180.228.168',1454755329),(24542,161,'123.125.71.90',1454771149),(24543,158,'123.125.71.116',1454812893),(24544,165,'66.249.69.25',1454892013),(24545,161,'42.62.37.19',1454966632),(24546,160,'68.180.228.168',1455023450),(24547,159,'68.180.228.168',1455158606),(24548,159,'42.62.37.17',1455170013),(24549,158,'157.55.39.148',1455176072),(24550,155,'68.180.228.168',1455287294),(24551,157,'110.75.145.2',1455361618),(24552,162,'110.75.145.2',1455361632),(24553,158,'110.75.145.2',1455361671),(24554,161,'110.75.145.1',1455361725),(24555,165,'110.75.145.2',1455361731),(24556,163,'110.75.145.2',1455361768),(24557,159,'110.75.145.1',1455361779),(24558,155,'110.75.145.1',1455361805),(24559,160,'110.75.145.2',1455361831),(24560,156,'110.75.145.1',1455365626),(24561,162,'68.180.228.168',1455439973),(24562,162,'42.62.37.64',1455499451),(24563,165,'110.75.145.2',1455518974),(24564,156,'110.75.145.2',1455519221),(24565,159,'110.75.145.2',1455519520),(24566,162,'110.75.145.1',1455519672),(24567,157,'110.75.145.2',1455520790),(24568,161,'110.75.145.1',1455521248),(24569,160,'110.75.145.1',1455521557),(24570,155,'110.75.145.1',1455521699),(24571,163,'110.75.145.2',1455526804),(24572,158,'110.75.145.1',1455527311),(24573,165,'207.46.13.115',1455531515),(24574,156,'68.180.228.168',1455599118),(24575,155,'101.226.169.211',1456004425),(24576,163,'66.249.74.30',1456259484),(24577,165,'218.82.53.108',1456292778),(24578,163,'218.82.53.108',1456293038),(24579,159,'66.249.64.87',1456307599),(24580,165,'220.181.108.120',1456375014),(24581,165,'66.249.65.9',1456389579),(24582,163,'123.125.71.71',1456429014),(24583,160,'220.181.108.118',1456461413),(24584,162,'182.118.25.231',1456481650),(24585,158,'101.226.168.195',1456481722),(24586,163,'66.249.65.13',1456514372),(24587,157,'207.46.13.150',1456556665),(24588,159,'157.55.39.221',1456577040),(24589,165,'110.75.145.1',1456600916),(24590,161,'110.75.145.1',1456602787),(24591,162,'110.75.145.2',1456603046),(24592,158,'110.75.145.2',1456604616),(24593,157,'110.75.145.2',1456606857),(24594,162,'40.77.167.9',1456609084),(24595,160,'110.75.145.1',1456628421),(24596,155,'110.75.145.2',1456628631),(24597,163,'110.75.145.2',1456629020),(24598,159,'110.75.145.1',1456629120),(24599,155,'106.38.241.108',1456645237),(24600,156,'110.75.145.1',1456657512),(24601,158,'182.118.20.223',1456677665),(24602,160,'110.75.145.1',1456743470),(24603,165,'110.75.145.2',1456743505),(24604,155,'110.75.145.1',1456743771),(24605,158,'110.75.145.1',1456744729),(24606,161,'110.75.145.1',1456745146),(24607,159,'110.75.145.2',1456747714),(24608,162,'110.75.145.2',1456747860),(24609,163,'110.75.145.1',1456751831),(24610,157,'110.75.145.2',1456752070),(24611,163,'68.180.228.168',1456798093),(24612,156,'110.75.145.2',1456803424),(24613,158,'123.125.71.81',1457056186),(24614,157,'123.125.71.54',1457061485),(24615,161,'182.118.22.220',1457087203),(24616,158,'101.226.167.205',1457087290),(24617,162,'220.181.108.75',1457118662),(24618,159,'220.181.108.185',1457122262),(24619,161,'220.181.108.117',1457125862),(24620,158,'68.180.228.168',1457132513),(24621,156,'123.125.71.72',1457147377),(24622,156,'203.208.60.32',1457172978),(24623,158,'203.208.60.40',1457173101),(24624,162,'203.208.60.37',1457173129),(24625,155,'220.181.108.187',1457179500),(24626,157,'203.208.60.25',1457218160),(24627,161,'203.208.60.26',1457218220),(24628,160,'203.208.60.37',1457218226),(24629,155,'203.208.60.29',1457218676),(24630,158,'42.62.36.195',1457229867),(24631,155,'42.62.36.201',1457229869),(24632,161,'42.62.36.231',1457229876),(24633,157,'42.62.36.231',1457229878),(24634,162,'42.62.36.231',1457229879),(24635,160,'42.62.36.201',1457229882),(24636,163,'42.62.36.201',1457229896),(24637,165,'42.62.36.201',1457229898),(24638,157,'106.38.241.108',1457278523),(24639,162,'203.208.60.33',1457290165),(24640,165,'182.118.22.203',1457326290),(24641,160,'203.208.60.24',1457362725),(24642,162,'220.181.108.107',1457385973),(24643,159,'42.62.37.17',1457430054),(24644,161,'68.180.228.168',1457431371),(24645,165,'157.55.39.24',1457450785),(24646,160,'203.208.60.30',1457467659),(24647,156,'182.118.22.203',1457475132),(24648,158,'203.208.60.29',1457478220),(24649,162,'203.208.60.29',1457481479),(24650,155,'42.62.36.201',1457489079),(24651,161,'42.62.36.231',1457489080),(24652,158,'42.62.36.195',1457489080),(24653,162,'42.62.36.231',1457489080),(24654,160,'42.62.36.201',1457489082),(24655,159,'42.62.36.201',1457489095),(24656,165,'42.62.36.201',1457489105),(24657,163,'42.62.36.201',1457489106),(24658,160,'66.249.65.5',1457508983),(24659,159,'42.62.37.17',1457513020),(24660,162,'66.249.65.5',1457516963),(24661,160,'42.62.37.19',1457542525),(24662,165,'66.249.64.97',1457583128),(24663,160,'110.75.145.1',1457803950),(24664,155,'110.75.145.2',1457809442),(24665,159,'110.75.145.1',1457809489),(24666,163,'110.75.145.2',1457809494),(24667,165,'110.75.145.1',1457809517),(24668,161,'110.75.145.1',1457809543),(24669,158,'110.75.145.1',1457809593),(24670,162,'110.75.145.2',1457809635),(24671,157,'110.75.145.1',1457809647),(24672,157,'66.249.69.17',1457814978),(24673,158,'182.118.22.142',1457819418),(24674,157,'66.249.69.25',1457822256),(24675,157,'66.249.69.9',1457831371),(24676,161,'66.249.69.9',1457833517),(24677,162,'203.208.60.25',1457841537),(24678,156,'110.75.145.2',1457855411),(24679,161,'203.208.60.32',1457862264),(24680,162,'203.208.60.26',1457920773),(24681,160,'203.208.60.30',1457929134),(24682,157,'203.208.60.24',1458087971),(24683,155,'42.62.37.184',1458114925),(24684,158,'42.62.37.180',1458172868),(24685,161,'66.249.74.24',1458214758),(24686,159,'182.118.20.168',1458315457),(24687,158,'106.38.241.108',1458345376),(24688,161,'42.62.37.181',1458351687),(24689,162,'203.208.60.33',1458376112),(24690,160,'203.208.60.33',1458392799),(24691,163,'203.208.60.36',1458440387),(24692,158,'203.208.60.38',1458443594),(24693,165,'106.38.241.108',1458474590),(24694,162,'203.208.60.38',1458532210),(24695,163,'123.125.71.90',1458584303),(24696,162,'106.38.241.108',1458718818),(24697,159,'42.62.37.180',1458745397),(24698,159,'66.249.69.17',1458824469),(24699,165,'123.125.71.80',1458857138),(24700,158,'110.75.145.2',1458925061),(24701,162,'110.75.145.1',1458925091),(24702,157,'110.75.145.2',1458925106),(24703,165,'110.75.145.2',1458925133),(24704,161,'110.75.145.1',1458925143),(24705,159,'110.75.145.2',1458925194),(24706,163,'110.75.145.1',1458925204),(24707,160,'110.75.145.2',1458925225),(24708,155,'110.75.145.2',1458925240),(24709,165,'203.208.60.166',1458979543),(24710,156,'110.75.145.2',1458981598),(24711,160,'220.181.108.179',1459020997),(24712,158,'207.46.13.92',1459030378),(24713,155,'203.208.60.155',1459112453),(24714,160,'68.180.230.231',1459209463),(24715,163,'203.208.60.165',1459219787),(24716,158,'182.118.25.231',1459222599),(24717,159,'106.38.241.108',1459223196),(24718,160,'106.38.241.108',1459338016),(24719,161,'106.38.241.108',1459338026),(24720,155,'203.208.60.162',1459379176),(24721,157,'182.118.25.203',1459420708),(24722,155,'207.46.13.64',1459463597),(24723,163,'106.38.241.108',1459467625),(24724,160,'101.226.167.217',1459484861),(24725,158,'123.125.71.41',1459492990),(24726,156,'68.180.230.231',1459510268),(24727,162,'220.181.108.177',1459514354),(24728,155,'119.57.159.184',1459534178),(24729,155,'88.198.230.79',1459545641),(24730,157,'88.198.230.79',1459545643),(24731,158,'88.198.230.79',1459545646),(24732,159,'88.198.230.79',1459545648),(24733,160,'88.198.230.79',1459545651),(24734,161,'88.198.230.79',1459545653),(24735,162,'88.198.230.79',1459545655),(24736,163,'88.198.230.79',1459545658),(24737,165,'88.198.230.79',1459545684),(24738,155,'182.118.20.225',1459581428),(24739,158,'119.57.159.180',1459594352),(24740,155,'220.181.108.114',1459617587),(24741,161,'220.181.108.100',1459619253),(24742,159,'113.140.11.3',1459717229),(24743,159,'180.153.206.27',1459717229),(24744,165,'180.153.163.189',1459717243),(24745,165,'113.140.11.3',1459717244),(24746,157,'68.180.230.231',1459734325),(24747,161,'119.57.159.181',1459790104),(24748,160,'66.249.66.102',1459819247),(24749,162,'119.57.158.231',1459823625),(24750,161,'119.57.158.231',1459823625),(24751,160,'119.57.158.201',1459823625),(24752,158,'119.57.158.195',1459823625),(24753,155,'119.57.158.201',1459823625),(24754,157,'119.57.158.231',1459823628),(24755,159,'119.57.158.201',1459823633),(24756,165,'119.57.158.201',1459823641),(24757,163,'119.57.158.201',1459823645),(24758,157,'66.249.66.100',1459834356),(24759,161,'66.249.66.104',1459843745),(24760,159,'66.249.66.102',1459844208),(24761,165,'203.208.60.154',1460070246),(24762,155,'119.57.159.184',1460093467),(24763,158,'203.208.60.150',1460129642),(24764,160,'207.46.13.29',1460147041),(24765,162,'203.208.60.156',1460157703),(24766,155,'68.180.230.231',1460165661),(24767,161,'110.75.145.2',1460219266),(24768,165,'110.75.145.2',1460221728),(24769,157,'110.75.145.2',1460221807),(24770,158,'110.75.145.1',1460221844),(24771,162,'110.75.145.1',1460221895),(24772,155,'110.75.145.1',1460223923),(24773,160,'110.75.145.1',1460224140),(24774,159,'110.75.145.1',1460225417),(24775,163,'110.75.145.2',1460225612),(24776,163,'182.118.20.201',1460227716),(24777,156,'110.75.145.1',1460280289),(24778,155,'69.30.198.202',1460288623),(24779,157,'69.30.198.202',1460288651),(24780,158,'69.30.198.202',1460288667),(24781,159,'69.30.198.202',1460288686),(24782,160,'69.30.198.202',1460288688),(24783,161,'69.30.198.202',1460288750),(24784,162,'69.30.198.202',1460288794),(24785,163,'69.30.198.202',1460288841),(24786,165,'69.30.198.202',1460288851),(24787,155,'203.208.60.152',1460309384),(24788,163,'157.55.39.196',1460338775),(24789,155,'203.208.60.168',1460339164),(24790,156,'113.140.11.3',1460416013),(24791,156,'180.153.201.212',1460416014),(24792,155,'119.57.159.184',1460419963),(24793,162,'119.57.159.182',1460422360),(24794,159,'119.57.159.180',1460425785),(24795,161,'119.57.159.181',1460427747),(24796,158,'119.57.159.180',1460429341),(24797,155,'119.57.159.184',1460429791),(24798,161,'207.46.13.22',1460481385),(24799,159,'123.125.71.52',1460488631),(24800,155,'203.208.60.163',1460489012),(24801,155,'203.208.60.161',1460574414),(24802,157,'106.38.241.108',1460576402),(24803,162,'68.180.230.231',1460578197),(24804,155,'203.208.60.158',1460617562),(24805,160,'119.57.158.201',1460621632),(24806,158,'119.57.158.195',1460621632),(24807,162,'119.57.158.231',1460621633),(24808,161,'119.57.158.231',1460621633),(24809,155,'119.57.158.201',1460621633),(24810,157,'119.57.158.231',1460621635),(24811,159,'119.57.158.201',1460621639),(24812,165,'119.57.158.201',1460621647),(24813,163,'119.57.158.201',1460621651),(24814,158,'68.180.230.231',1460659640),(24815,155,'66.249.66.100',1460788054),(24816,155,'144.76.12.75',1460871336),(24817,157,'144.76.12.75',1460871339),(24818,158,'144.76.12.75',1460871342),(24819,159,'144.76.12.75',1460871344),(24820,160,'144.76.12.75',1460871347),(24821,161,'144.76.12.75',1460871350),(24822,162,'144.76.12.75',1460871352),(24823,163,'144.76.12.75',1460871359),(24824,165,'144.76.12.75',1460871369),(24825,155,'66.249.69.9',1460937252),(24826,161,'119.57.159.181',1460938785),(24827,165,'123.125.71.44',1460996318),(24828,159,'66.249.65.13',1461023213),(24829,155,'51.255.162.166',1461056951),(24830,157,'51.255.162.166',1461056968),(24831,158,'51.255.162.166',1461057017),(24832,159,'51.255.162.166',1461057045),(24833,160,'51.255.162.166',1461057089),(24834,161,'51.255.162.166',1461057095),(24835,162,'51.255.162.166',1461057105),(24836,163,'51.255.162.166',1461057123),(24837,165,'51.255.162.166',1461057135),(24838,158,'106.38.241.108',1461123602),(24839,156,'213.239.205.207',1461125543),(24840,155,'119.57.159.184',1461147703),(24841,161,'66.249.65.230',1461171246),(24842,158,'119.57.159.180',1461197102),(24843,165,'106.38.241.108',1461253206),(24844,161,'119.57.159.181',1461410873),(24845,158,'110.75.145.1',1461412983),(24846,162,'110.75.145.1',1461414323),(24847,157,'110.75.145.2',1461414373),(24848,165,'110.75.145.1',1461414422),(24849,161,'110.75.145.2',1461414433),(24850,159,'110.75.145.2',1461414478),(24851,163,'110.75.145.1',1461414494),(24852,160,'110.75.145.1',1461414504),(24853,155,'110.75.145.2',1461414524),(24854,156,'68.180.230.231',1461491750),(24855,156,'110.75.145.1',1461552887),(24856,162,'106.38.241.108',1461555630),(24857,159,'119.57.159.180',1461645697),(24858,159,'66.249.66.100',1461688929),(24859,161,'66.249.66.102',1461692307),(24860,160,'66.249.66.102',1461715948),(24861,158,'66.249.66.102',1461717078),(24862,159,'66.249.66.100',1461734990),(24863,159,'157.55.39.213',1461833787);
/*!40000 ALTER TABLE `fanwe_deal_visit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_vote`
--

DROP TABLE IF EXISTS `fanwe_deal_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `deal_id` int(11) NOT NULL COMMENT '项目id',
  `create_time` int(11) NOT NULL COMMENT '投票创建时间',
  `begin_time` int(11) NOT NULL COMMENT '投票开始时间',
  `end_time` int(11) NOT NULL COMMENT '投票结束时间',
  `money` decimal(20,2) NOT NULL COMMENT '卖出金额',
  `status` tinyint(1) NOT NULL COMMENT '0表示未同意 1表示同意 2表示投票失败',
  `yes_num` int(11) NOT NULL COMMENT '同意的总票数',
  `no_num` int(11) NOT NULL COMMENT '不同意的总票数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_vote`
--

LOCK TABLES `fanwe_deal_vote` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_deal_vote_log`
--

DROP TABLE IF EXISTS `fanwe_deal_vote_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_deal_vote_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `deal_vote_id` int(11) NOT NULL COMMENT '投票id',
  `vote_status` tinyint(1) NOT NULL COMMENT '0表示不同意 1表示同意',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_deal_vote_log`
--

LOCK TABLES `fanwe_deal_vote_log` WRITE;
/*!40000 ALTER TABLE `fanwe_deal_vote_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_deal_vote_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_faq`
--

DROP TABLE IF EXISTS `fanwe_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_faq`
--

LOCK TABLES `fanwe_faq` WRITE;
/*!40000 ALTER TABLE `fanwe_faq` DISABLE KEYS */;
INSERT INTO `fanwe_faq` VALUES (1,'基本问题','这是一个什么样的网站？','我们是一个让你可以发起和支持创业项目的平台。如果你有一个创业的想法(想开一个咖啡馆？)，我们欢迎你到我们的平台上发起项目，向公众推广，并得到资金的支持去完成你的想法。',1),(2,'基本问题','我们都支持哪些项目','我们主要支持服务性行业的相关项目，比如开一家饭店、咖啡馆、西餐厅、美容店、健身房等等，因为这些店铺现金流充裕，项目比较容易获得成功，支持者支持了这些项目后在这些店铺消费时可以享受更多的折扣优惠，对双方都有利。',2),(3,'基本问题','这种模式有非法集资的风险吗？','不会，项目的回报首先是店铺的服务，支持者支持项目之后，会得到相应价值的储值卡，将来店铺开业后可以到相应的店铺去消费。支持者对一个项目的支持属于购买行为，而不是投资行为。项目发起人不能向支持者许诺任何资金上的收益。\r\n',3),(4,'基本问题','这个平台接受慈善项目类的提案么?','我们可接受慈善类项目。',4),(5,'项目发起人相关问题','是否会要求产品或作品的知识产权?','不会。我们只是提供一个宣传和支持的平台，知识产权由项目发起人所有。',5),(6,'项目发起人相关问题','什么人可以发起项目?','目前任何在两岸三地(中国大陆，台湾，港澳)的有创意的人都可以发起项目。你可以是一个从事创意行业的自由职业者，也可以是公司职员。只要你有个点子，我们都希望收到你的项目提案。',6),(7,'项目发起人相关问题','我怎么发起项目呢?','请到我们的网站并注册用户后，在我们网站上提交所需要的基本项目信息，包括项目的内容，目前进行的阶段等等。我们会有专人跟进，与你联系。',7),(8,'项目发起人相关问题','我想发起项目，但是我担心我的知识产权被人抄袭?','作为项目发起人，你可以选择公布更多的信息。知识产权敏感的信息，你可以选择不公开。同时，我们平台是一个面对公众的平台。你所提供的信息越丰富，越翔实，就越容易打动和说服别人的支持。',8),(9,'项目发起人相关问题','项目目标金额是否有上下限制?','我们对目标金额的下限是1000元人民币。原则上没有上限。但是资金的要求越高，成功的概率就越低。目前常见的目标金额从几千到几万不等。',9),(10,'项目发起人相关问题','没有达到目标金额，是否就不能得到支持?','是的。如果在项目截至日期到达时，没有达到预期，那么已经收到的资金会退还给支持者。这么做的原因是为了给支持者提供风险保护。只有当项目有足够多的人支持足够多的资金时，他们的支持才生效。',10),(11,'项目发起人相关问题','我的项目成功了，然后呢?','我们会分两次把资金打入你所提供的银行账户。两次汇款的时间和金额因项目而异，在项目上线之前，由我们平台与项目发起人确定。在资金的支持下，你就可以开始进行你的项目，给你的支持者以邮件或者其他形式的更新，并如期实现你承诺的回报。',11),(12,'项目发起人相关问题','如何设定项目截止日期?','一般来说，时间设置在一个月或以内比较合适。数据显示，绝大部分的支持发生在项目上线开始和结束前的一个星期中。',12),(13,'项目发起人相关问题','收到的金额能够超过预设的目标?','可以。在截至日期之前，项目可以一直接受资金支持。',13),(14,'项目发起人相关问题','大家支持的动机是什么?','大家对项目支持的动机是多样的，当然以获得企业的股权为主，在支持项目的同时实现自己的创业梦想。也有些是因为希望获得相应的产品或服务。还有一些是因为认可项目的发起人，希望助他一臂之力。',14),(15,'项目发起人相关问题','什么样的回报比较合适?','除了与投资人约定的股权回报，其他的回报因项目而异。可以是实物，比如普通商品，也可以是非实物。我们欢迎项目发起人展开想象，设计出各式各样的回报。',15),(16,'项目发起人相关问题','如何能够吸引更多的人来支持我的项目?','对此，我们会另外详细介绍。简短来说，有以下要点\r\n- 拍摄一个有趣，吸引人的视频。讲述这个项目背后的故事。\r\n- 提供有吸引力，物有所值的回报。\r\n- 项目刚上线时，要发动你的亲朋好友来支持你。让你的项目有一个基本的人气。\r\n- 充分运用微博，人人等社交网站来推广。\r\n- 在项目上线期间，经常性的在你的项目页上提供项目的更新，与支持者，询问者的互动。\r\n- 项目宣传视频是必须的么?\r\n宣传视频是项目页上的重要内容。是公众了解你和你的项目的第一步。一个好的宣传视频，能够比文字和图片起到更好的宣传效果。基于这个原因，我们要求每个项目都提供一个视频。有必要的话，我们平台可以提供视频拍摄的支持。',16),(17,'项目发起人相关问题','项目宣传视频有什么要求?','我们要求宣传视频在两分钟之内。内容上，强烈建议包括以下内容\r\n发起人姓名\r\n项目简短描述(特别说明其吸引人的地方)，目前进展\r\n为什么需要支持\r\n谢谢大家',17),(18,'项目支持者相关问题','如果项目没有达到目标金额，我支持的资金会还给我么?','是的。如果项目在截止日期没有达到目标，你所支持的金额会返还给你。',18),(19,'项目支持者相关问题','如何支持一个项目?','每个项目页的右侧有可选择的支持额度和相应的回报介绍。想支持的话，选择你想支持的金额，鼠标点击绿色的按钮，即可。你可以选择支付宝或者财付通来完成付款。',19),(20,'项目支持者相关问题','如何保证项目发起人能够实现他们的承诺呢?','项目本身存在无法规避的各种风险，每个项目都有最终走向失败的可能。项目支持者一方面要了解项目本身是有风险的，另一方面，我们要求项目发起人提供联系方式，并且鼓励有意支持者直接联系他们，在与项目发起人的沟通和互动中对项目的价值，风险，项目发起人的执行力等等有所判断。网站作为风险监控的一方也将严格实施相应的风险控制措施，具体请看《风险控制措施》。',20),(22,'基本问题','我们是如何收费的？','1、按照融资金额5%的标准向项目发起人一次性收取服务费；\r\n2、按照支持者支持金额的5%收取管理费，不提提取现金，直接投入到项目中。',5);
/*!40000 ALTER TABLE `fanwe_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_help`
--

DROP TABLE IF EXISTS `fanwe_help`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_help` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_fix` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_help`
--

LOCK TABLES `fanwe_help` WRITE;
/*!40000 ALTER TABLE `fanwe_help` DISABLE KEYS */;
INSERT INTO `fanwe_help` VALUES (1,'服务条款','<div class=\"layout960\">\r\n	<p>\r\n		<strong><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于DPIN众创平台&nbsp;</span><br />\r\n<br />\r\n</strong>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<strong>众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。</strong>\r\n	</p>\r\n	<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n		<strong><br />\r\n</strong>\r\n	</p>\r\n<strong><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span><br />\r\n</strong> \r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p>\r\n		<br />\r\n	</p>\r\n</div>','term','',1,1),(2,'服务介绍','<p>\r\n	<span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\"><strong><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于DPIN众创平台&nbsp;</span></strong></span><br />\r\n</p>\r\n<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n	众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。\r\n</p>\r\n<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span> \r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>','intro','',1,1),(3,'隐私策略','<p>\r\n	<span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\"><strong><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于DPIN众创平台&nbsp;</span></strong></span> \r\n</p>\r\n<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n	众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。\r\n</p>\r\n<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span> \r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>','privacy','',1,1),(4,'关于我们','<p class=\"p0\" style=\"text-align:left;\">\r\n	<span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于<strong><span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#E56600;\">关于DPIN众创平台&nbsp;</span></strong></span><br />\r\n</p>\r\n<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n	众筹，译自国外crowdfunding一词，即大众筹资或群众筹资。是指用团购+预购的形式，向网友募集项目资金的模式。众筹利用互联网和SNS传播的特性，让许多有梦想的人可以向公众展示自己的创意，发起项目争取别人的支持与帮助，进而获得所需要的援助，支持者则会获得实物、服务等不同形式的回报。\r\n</p>\r\n<p style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<span style=\"color:#404040;font-family:\'Microsoft Yahei\', 微软雅黑, Arial, \'Hiragino Sans GB\', 宋体;font-size:14px;line-height:21px;background-color:#FFFFFF;\">众筹是一个协助亲们发起创意、梦想的平台，不论你是学生、白领、艺术家、明星，如果你有一个想完成的计划（例如：电影、音乐、动漫、设计、公益等），你可以在此发起项目向大家展示你的计划，并邀请喜欢你的计划的人以资金支持你。如果你愿意帮助别人，支持别人的梦想，你可以在众筹浏览到各行各业的人发起的项目计划，也可以成为发起人的梦想合伙人，当你们一起见证项目成功后，你还会获得发起人感谢你支持的回报。</span> \r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>','about','',1,1),(5,'官方微博','<p>\r\n	<br />\r\n</p>','','http://weibo.com/u/5684797491',0,1);
/*!40000 ALTER TABLE `fanwe_help` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_index_image`
--

DROP TABLE IF EXISTS `fanwe_index_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_index_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示首页轮播 1表示产品页轮播 2表示股权轮播',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_index_image`
--

LOCK TABLES `fanwe_index_image` WRITE;
/*!40000 ALTER TABLE `fanwe_index_image` DISABLE KEYS */;
INSERT INTO `fanwe_index_image` VALUES (30,'./public/attachment/201508/17/12/55d16265716d2.jpg','',2,'3',0),(29,'./public/attachment/201508/24/12/55da9b7e06338.JPG','',3,'2',0),(28,'./public/attachment/201508/24/13/55daa89bb87bc.jpg','',1,'1',3);
/*!40000 ALTER TABLE `fanwe_index_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_investment_list`
--

DROP TABLE IF EXISTS `fanwe_investment_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_investment_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(11) NOT NULL DEFAULT '0' COMMENT '投资的类型 0 表示 询价，1表示领投，2表示跟投,3表示追加的金额',
  `money` decimal(20,2) NOT NULL COMMENT '投资的金额',
  `stock_value` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '估指',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0表示 未来审核，1表示同意，2表示不同意',
  `introduce` text NOT NULL COMMENT '领投人的个人简介',
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `deal_id` int(11) NOT NULL COMMENT '股权众筹ID',
  `cates` text NOT NULL COMMENT '分类信息',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `investment_reason` text NOT NULL COMMENT '投资请求',
  `funding_to_help` text NOT NULL COMMENT '资金帮助',
  `investor_money_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '投资金额0 表示未审核 1表示审核通过 2表示审核拒绝 3表示已支付投资成功 4表示未按时间支付，违约',
  `order_id` int(11) NOT NULL COMMENT '订单号',
  `is_partner` tinyint(11) NOT NULL COMMENT '0表示无状态 1表示愿意承担企业合伙人 2表示不愿意承担企业合伙人',
  `leader_moban` text NOT NULL COMMENT '尽职调查和条款清单模板',
  `leader_help` text NOT NULL COMMENT '他为创业者还能提供的其它帮助',
  `leader_for_team` text NOT NULL COMMENT '对创业团队评价',
  `leader_for_project` text NOT NULL COMMENT '对创业项目评价',
  `send_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示未发送 1发送成功',
  `detailed_information` text NOT NULL COMMENT '详细资料',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_investment_list`
--

LOCK TABLES `fanwe_investment_list` WRITE;
/*!40000 ALTER TABLE `fanwe_investment_list` DISABLE KEYS */;
INSERT INTO `fanwe_investment_list` VALUES (2,2,10000000.00,0.00,0,'',21,156,'',1439761513,'','',3,2146,1,'','','','',0,'');
/*!40000 ALTER TABLE `fanwe_investment_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai`
--

DROP TABLE IF EXISTS `fanwe_licai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '产品名称',
  `licai_sn` varchar(50) NOT NULL COMMENT '编号',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '发起人【发起机构】',
  `img` varchar(255) NOT NULL COMMENT '项目图片',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `re_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0元;1新品上架;2当月畅销;3:本周畅销;4:限时抢购;',
  `begin_buy_date` date NOT NULL COMMENT '购买开始时间',
  `end_buy_date` date NOT NULL COMMENT '购买结束时间',
  `end_date` date NOT NULL COMMENT '项目结束时间',
  `min_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '起购金额',
  `max_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单笔最大购买限额',
  `begin_interest_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '【0:当日生效，1:次日生效，2:下个工作日生效,3下二个工作日】',
  `product_size` varchar(255) DEFAULT NULL COMMENT '产品规模',
  `risk_rank` tinyint(1) NOT NULL DEFAULT '0' COMMENT '风险等级（2高、1中、0低）',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1有效、0无效',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '理财类型（0余额宝、1固定定存、2浮动定存;3票据、4基金）',
  `description` text NOT NULL COMMENT '理财详情',
  `purchasing_time` varchar(255) DEFAULT NULL COMMENT '赎回到账时间描述',
  `rule_info` text COMMENT '规则',
  `is_trusteeship` tinyint(1) DEFAULT NULL COMMENT '是否托管 0是 1否',
  `average_income_rate` decimal(8,4) NOT NULL DEFAULT '0.0000' COMMENT 'type=0七日平均(年)收益率;type=1近三个月收益率【动态计算】',
  `per_million_revenue` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '每万元收益【动态计算】',
  `subscribing_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计成交总额',
  `redeming_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '累计被赎回',
  `is_deposit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否托管;1:托管;0:非托管',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `brief` varchar(255) DEFAULT NULL COMMENT '简介',
  `net_value` decimal(10,2) DEFAULT '0.00' COMMENT '最新净值',
  `fund_key` varchar(50) DEFAULT NULL COMMENT '关连的基金编号',
  `fund_type_id` int(10) NOT NULL DEFAULT '0' COMMENT '基金种类',
  `fund_brand_id` int(10) NOT NULL DEFAULT '0' COMMENT '基金品牌',
  `bank_id` int(10) NOT NULL DEFAULT '0' COMMENT '银行',
  `begin_interest_date` date DEFAULT NULL COMMENT '起息时间',
  `time_limit` int(10) DEFAULT NULL COMMENT '理财期限',
  `review_type` tinyint(1) DEFAULT NULL COMMENT '赎回到账方式: 0,发起人审核   1,网站和发起人审核 2，自动审核',
  `total_people` int(10) DEFAULT NULL COMMENT '参与人数',
  `service_fee_rate` decimal(10,4) DEFAULT NULL COMMENT '成交服务费',
  `licai_status` tinyint(1) DEFAULT NULL COMMENT '理财状态 0：预热期 1：理财期 2：提前结束 3已到期',
  `send_type` tinyint(1) DEFAULT NULL COMMENT '发放款项类型  0：自动  1：手动',
  `is_send` tinyint(1) DEFAULT NULL COMMENT '是否发放 0：否 1：是',
  `investment_adviser` varchar(255) DEFAULT NULL,
  `profit_way` varchar(255) DEFAULT NULL COMMENT '获取收益方式',
  `scope` varchar(255) DEFAULT NULL COMMENT '利率范围',
  `platform_rate` decimal(10,4) DEFAULT NULL COMMENT '平台收益(余额宝)',
  `site_buy_fee_rate` decimal(10,4) DEFAULT NULL COMMENT '购买手续费(余额宝)',
  `redemption_fee_rate` decimal(10,4) DEFAULT NULL COMMENT '赎回手续费(余额宝)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai`
--

LOCK TABLES `fanwe_licai` WRITE;
/*!40000 ALTER TABLE `fanwe_licai` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_advance`
--

DROP TABLE IF EXISTS `fanwe_licai_advance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_advance` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `redempte_id` int(11) NOT NULL COMMENT '赎回ID',
  `user_id` int(11) NOT NULL COMMENT '申请人ID',
  `user_name` varchar(255) NOT NULL COMMENT '申请用户名',
  `money` decimal(10,2) NOT NULL DEFAULT '1.00' COMMENT '赎回本金',
  `earn_money` decimal(10,2) NOT NULL COMMENT '收益金额',
  `fee` decimal(10,2) NOT NULL COMMENT '赎回手续费',
  `organiser_fee` decimal(10,2) NOT NULL,
  `advance_money` decimal(10,2) NOT NULL COMMENT '垫付金额',
  `real_money` decimal(10,2) NOT NULL COMMENT '发起人账户金额和冻结资金被扣的金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0表示未处理 1表示通过',
  `type` tinyint(1) NOT NULL COMMENT '0 预热期赎回 1.起息时间违约赎回 2.正常到期赎回',
  `create_date` date NOT NULL COMMENT '申请时间',
  `update_date` date NOT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_advance`
--

LOCK TABLES `fanwe_licai_advance` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_advance` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_advance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_bank`
--

DROP TABLE IF EXISTS `fanwe_licai_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_bank` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '产品名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1:有效;0无效',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='基金种类：\r\n全部 货币型 股票型 债券型 混合型 理财型 指数型 QDII 其他型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_bank`
--

LOCK TABLES `fanwe_licai_bank` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_dealshow`
--

DROP TABLE IF EXISTS `fanwe_licai_dealshow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_dealshow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `licai_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_dealshow`
--

LOCK TABLES `fanwe_licai_dealshow` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_dealshow` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_dealshow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_fund_brand`
--

DROP TABLE IF EXISTS `fanwe_licai_fund_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_fund_brand` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '产品名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1:有效;0无效',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='基金品牌：\r\n全部 嘉实 鹏华 易方达 国泰 南方 建信 招商 工银瑞信 海富通 华商 中邮创业 长盛 东方\r\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_fund_brand`
--

LOCK TABLES `fanwe_licai_fund_brand` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_fund_brand` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_fund_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_fund_type`
--

DROP TABLE IF EXISTS `fanwe_licai_fund_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_fund_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '产品名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1:有效;0无效',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='基金种类：\r\n全部 货币型 股票型 债券型 混合型 理财型 指数型 QDII 其他型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_fund_type`
--

LOCK TABLES `fanwe_licai_fund_type` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_fund_type` DISABLE KEYS */;
INSERT INTO `fanwe_licai_fund_type` VALUES (1,'货币型',1,0),(2,'股票型',1,0),(3,'债券型',1,0),(4,'混合型',1,0),(5,'理财型',1,0),(6,'标准',1,0),(7,'QDII',1,0),(8,'其他型',1,0),(9,'中欧',1,0);
/*!40000 ALTER TABLE `fanwe_licai_fund_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_history`
--

DROP TABLE IF EXISTS `fanwe_licai_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `licai_id` varchar(50) NOT NULL COMMENT '编号',
  `history_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '购买金额起',
  `net_value` decimal(10,2) NOT NULL COMMENT '当日净利',
  `rate` decimal(7,4) NOT NULL COMMENT '利率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='基金净值列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_history`
--

LOCK TABLES `fanwe_licai_history` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_holiday`
--

DROP TABLE IF EXISTS `fanwe_licai_holiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_holiday` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `year` int(4) NOT NULL COMMENT '年',
  `holiday` date NOT NULL COMMENT '假日',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_holiday`
--

LOCK TABLES `fanwe_licai_holiday` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_holiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_holiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_interest`
--

DROP TABLE IF EXISTS `fanwe_licai_interest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_interest` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `licai_id` varchar(50) NOT NULL COMMENT '编号',
  `min_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '购买金额起',
  `max_money` decimal(10,2) NOT NULL COMMENT '购买金额起',
  `interest_rate` decimal(7,4) NOT NULL COMMENT '利息率',
  `buy_fee_rate` decimal(10,4) DEFAULT NULL COMMENT '原购买手续费',
  `site_buy_fee_rate` decimal(10,4) DEFAULT NULL COMMENT '网站购买手续费',
  `redemption_fee_rate` decimal(10,4) DEFAULT NULL COMMENT '赎回手续费',
  `before_rate` decimal(10,4) DEFAULT NULL COMMENT '预热期利率',
  `before_breach_rate` decimal(10,4) DEFAULT NULL COMMENT '预热期违约利率',
  `breach_rate` decimal(10,4) DEFAULT NULL COMMENT '正常利息 违约收益率',
  `platform_rate` decimal(10,4) DEFAULT NULL COMMENT '平台收益率',
  `freeze_bond_rate` decimal(10,4) DEFAULT NULL,
  `platform_breach_rate` decimal(10,4) DEFAULT NULL COMMENT '用户违约网站收益',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='利率列表【不同投资金额，可以获得不同的利率】';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_interest`
--

LOCK TABLES `fanwe_licai_interest` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_interest` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_interest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_order`
--

DROP TABLE IF EXISTS `fanwe_licai_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `licai_id` int(11) NOT NULL COMMENT '理财产品ID',
  `user_id` int(11) NOT NULL COMMENT '购买用户的id',
  `user_name` varchar(50) NOT NULL,
  `money` decimal(10,2) NOT NULL COMMENT '购买金额',
  `status` tinyint(1) NOT NULL COMMENT '0：未支付 1：已支付 2、部分赎回 3、已完结',
  `freeze_bond_rate` decimal(10,4) NOT NULL COMMENT '冻结保证金费率',
  `freeze_bond` decimal(10,2) NOT NULL COMMENT '冻结保证金',
  `pay_money` decimal(10,2) NOT NULL COMMENT '发放金额',
  `status_time` datetime NOT NULL COMMENT '处理时间',
  `create_time` datetime NOT NULL COMMENT '购买时间',
  `create_date` date NOT NULL COMMENT '购买年月日',
  `site_buy_fee_rate` decimal(10,4) NOT NULL COMMENT '实际申购费率',
  `site_buy_fee` decimal(10,2) NOT NULL COMMENT '实际申购费',
  `redemption_fee_rate` decimal(10,4) NOT NULL COMMENT '赎回手续费',
  `before_interest_date` date NOT NULL COMMENT '预热开始时间',
  `before_interest_enddate` date NOT NULL COMMENT '预热结束时间',
  `before_rate` decimal(10,4) NOT NULL COMMENT '预热利率',
  `before_interest` decimal(10,2) NOT NULL COMMENT '预热利息',
  `is_before_pay` tinyint(1) NOT NULL COMMENT '是否已经支付预热期手续费',
  `before_breach_rate` decimal(10,4) NOT NULL COMMENT '预热期违约利率',
  `begin_interest_type` tinyint(1) NOT NULL COMMENT '【0:当日生效，1:次日生效，2:下个工作日生效,3下二个工作日】',
  `begin_interest_date` date NOT NULL COMMENT '起息时间YMD',
  `interest_rate` decimal(10,4) NOT NULL COMMENT '利息率',
  `breach_rate` decimal(10,4) NOT NULL COMMENT '正常利息 违约收益率',
  `end_interest_date` date NOT NULL COMMENT '结束时间YMD',
  `service_fee_rate` decimal(10,4) NOT NULL COMMENT '成交服务费率',
  `service_fee` decimal(10,2) NOT NULL COMMENT '成交服务费',
  `redempte_money` decimal(10,2) DEFAULT '0.00' COMMENT '赎回金额',
  `gross` decimal(10,2) DEFAULT '0.00' COMMENT '毛利',
  `gross_margins` decimal(10,4) DEFAULT '0.0000' COMMENT '毛利率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 COMMENT='理财订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_order`
--

LOCK TABLES `fanwe_licai_order` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_recommend`
--

DROP TABLE IF EXISTS `fanwe_licai_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_recommend` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `licai_id` varchar(50) NOT NULL COMMENT '编号',
  `name` varchar(255) NOT NULL COMMENT '产品名称',
  `img` varchar(255) NOT NULL COMMENT '项目图片',
  `brief` varchar(255) DEFAULT NULL COMMENT '简介',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1:有效;0无效',
  `sort` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='个性推荐';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_recommend`
--

LOCK TABLES `fanwe_licai_recommend` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_recommend` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_licai_redempte`
--

DROP TABLE IF EXISTS `fanwe_licai_redempte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_licai_redempte` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `user_id` int(11) NOT NULL COMMENT '申请人ID',
  `user_name` varchar(255) NOT NULL COMMENT '申请用户名',
  `money` decimal(10,2) NOT NULL DEFAULT '1.00' COMMENT '赎回本金',
  `earn_money` decimal(10,2) NOT NULL COMMENT '收益金额',
  `fee` decimal(10,2) NOT NULL COMMENT '赎回手续费',
  `organiser_fee` decimal(10,2) NOT NULL COMMENT '平台收益',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0表示未赎回 1表示已赎回 2表示拒绝 3表示取消赎回',
  `type` tinyint(1) NOT NULL COMMENT '0 预热期赎回 1.起息时间违约赎回 2.正常到期赎回',
  `create_date` date NOT NULL COMMENT '申请时间',
  `update_date` date NOT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_licai_redempte`
--

LOCK TABLES `fanwe_licai_redempte` WRITE;
/*!40000 ALTER TABLE `fanwe_licai_redempte` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_licai_redempte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_link`
--

DROP TABLE IF EXISTS `fanwe_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `count` int(11) NOT NULL,
  `show_index` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_link`
--

LOCK TABLES `fanwe_link` WRITE;
/*!40000 ALTER TABLE `fanwe_link` DISABLE KEYS */;
INSERT INTO `fanwe_link` VALUES (157,'必酷赛博',14,'http://www.dpin.cn/',1,6,'./public/attachment/201508/24/14/55dab984368aa.jpg','',0,1),(153,'PINMAN DESIGN',14,'http://www.pinman.cn/',1,2,'','',0,1),(154,'淘宝众筹',14,'http://www.dpin.cn/',1,3,'./public/attachment/201508/24/13/55daafb3d9ab1.jpg','',0,1),(155,'京东众筹',14,'http://www.dpin.cn/',1,4,'./public/attachment/201508/24/13/55dab0731c71e.jpg','',0,1),(156,'苏宁众筹',14,'http://www.dpin.cn/',1,5,'./public/attachment/201508/24/13/55dab2a5be17f.jpg','',0,1),(158,'视觉中国',14,'http://www.dpin.cn/',1,7,'./public/attachment/201508/24/14/55dabdfc20fd1.jpg','',0,1),(159,'富曼欧资本',14,'http://www.dpin.cn/',1,8,'./public/attachment/201508/24/15/55dac3bbd15c1.jpg','',0,1),(160,'中同资本',14,'http://www.dpin.cn/',1,9,'./public/attachment/201508/24/15/55dac40b81751.jpg','',0,1);
/*!40000 ALTER TABLE `fanwe_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_link_group`
--

DROP TABLE IF EXISTS `fanwe_link_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_link_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '友情链接分组名称',
  `sort` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 文字描述 1图片描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_link_group`
--

LOCK TABLES `fanwe_link_group` WRITE;
/*!40000 ALTER TABLE `fanwe_link_group` DISABLE KEYS */;
INSERT INTO `fanwe_link_group` VALUES (14,'合作机构',1,1,1),(19,'设计机构',2,1,0),(20,'合作媒体',3,1,0);
/*!40000 ALTER TABLE `fanwe_link_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_log`
--

DROP TABLE IF EXISTS `fanwe_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL,
  `log_time` int(11) NOT NULL,
  `log_admin` int(11) NOT NULL,
  `log_ip` varchar(255) NOT NULL,
  `log_status` tinyint(1) NOT NULL,
  `module` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12189 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_log`
--

LOCK TABLES `fanwe_log` WRITE;
/*!40000 ALTER TABLE `fanwe_log` DISABLE KEYS */;
INSERT INTO `fanwe_log` VALUES (11962,'',0,0,'',0,'',''),(11963,'更新系统配置',1440218688,1,'180.175.239.186',1,'Conf','update'),(11964,'更新系统配置',1440218759,1,'180.175.239.186',1,'Conf','update'),(11965,'admin登录成功',1440219039,1,'61.164.211.13',1,'Public','do_login'),(11966,'更新系统配置',1440219224,1,'58.215.133.93',1,'Conf','update'),(11967,'更新系统配置',1440219255,1,'61.164.211.13',1,'Conf','update'),(11968,'更新系统配置',1440219281,1,'61.164.211.13',1,'Conf','update'),(11969,'更新系统配置',1440219326,1,'58.215.133.93',1,'Conf','update'),(11970,'更新系统配置',1440219469,1,'61.164.211.13',1,'Conf','update'),(11971,'更新系统配置',1440219489,1,'61.164.211.13',1,'Conf','update'),(11972,'更新系统配置',1440226811,1,'61.164.211.13',1,'Conf','update'),(11973,'更新系统配置',1440227150,1,'61.164.211.13',1,'Conf','update'),(11974,'健身更新成功',1440227410,1,'61.164.211.13',1,'DealCate','update'),(11975,'股权众筹彻底删除成功',1440227596,1,'61.164.211.13',1,'Nav','foreverdelete'),(11976,'回报众筹更新成功',1440227616,1,'61.164.211.13',1,'Nav','update'),(11977,'投资人更新成功',1440227639,1,'61.164.211.13',1,'Nav','update'),(11978,'更新系统配置',1440227842,1,'58.215.133.93',1,'Conf','update'),(11979,'支付宝银行直连支付安装成功',1440259751,1,'61.164.211.13',1,'Payment','insert'),(11980,'微信支付(WAP版本)安装成功',1440259781,1,'61.164.211.13',1,'Payment','insert'),(11981,'易宝资金托管安装成功',1440259808,1,'61.164.211.13',1,'Collocation','insert'),(11982,'更新系统配置',1440260060,1,'61.164.211.13',1,'Conf','update'),(11983,'更新系统配置',1440260207,1,'61.164.211.13',1,'Conf','update'),(11984,'神父添加成功',1440260684,1,'61.164.211.13',1,'User','insert'),(11985,'神父添加成功',1440260757,1,'61.164.211.13',1,'User','insert'),(11986,'admin登录成功',1440304278,1,'180.175.239.186',1,'Public','do_login'),(11987,'更新系统配置',1440304661,1,'180.175.239.186',1,'Conf','update'),(11988,'yorick更新成功',1440304745,1,'180.175.239.186',1,'User','update'),(11989,'神父彻底删除成功',1440310296,1,'122.225.36.61',1,'User','delete'),(11990,'支付宝即时到帐支付更新成功',1440310548,1,'115.231.225.13',1,'Payment','update'),(11991,'商品更新成功',1440312756,1,'42.81.45.112',1,'DealCate','update'),(11992,'餐饮彻底删除成功',1440312999,1,'42.81.45.112',1,'DealCate','foreverdelete'),(11993,'农业彻底删除成功',1440313128,1,'42.81.45.112',1,'DealCate','foreverdelete'),(11994,'2更新成功',1440361215,1,'222.44.84.34',1,'IndexImage','update'),(11995,'度假酒店更新成功',1440361510,1,'222.44.84.34',1,'Deal','update_investor'),(11996,'[度假酒店10000000.00支持人:myname1状态:3]成功删除',1440361576,1,'222.44.84.34',1,'DealOrder','delete'),(11997,'myname1彻底删除成功',1440361614,1,'222.44.84.34',1,'User','delete'),(11998,'myname彻底删除成功',1440361628,1,'222.44.84.34',1,'User','delete'),(11999,'助梦人更新成功',1440361829,1,'222.44.84.34',1,'Nav','update'),(12000,'更新系统配置',1440362007,1,'222.44.84.34',1,'Conf','update'),(12001,'更新系统配置',1440362603,1,'222.44.84.34',1,'Conf','update'),(12002,'更新系统配置',1440362752,1,'222.44.84.34',1,'Conf','update'),(12003,'更新系统配置',1440362883,1,'222.44.84.34',1,'Conf','update'),(12004,'更新系统配置',1440363224,1,'222.44.84.34',1,'Conf','update'),(12005,'更新系统配置',1440363462,1,'222.44.84.34',1,'Conf','update'),(12006,'更新系统配置',1440363641,1,'222.44.84.34',1,'Conf','update'),(12007,'众创项目更新成功',1440363699,1,'222.44.84.34',1,'Nav','update'),(12008,'1更新成功',1440364573,1,'222.44.84.34',1,'IndexImage','update'),(12009,'1更新成功',1440364626,1,'222.44.84.34',1,'IndexImage','update'),(12010,'2更新成功',1440364636,1,'222.44.84.34',1,'IndexImage','update'),(12011,'3更新成功',1440364646,1,'222.44.84.34',1,'IndexImage','update'),(12012,'1更新成功',1440364669,1,'222.44.84.34',1,'IndexImage','update'),(12013,'2更新成功',1440364677,1,'222.44.84.34',1,'IndexImage','update'),(12014,'更新系统配置',1440365238,1,'222.44.84.34',1,'Conf','update'),(12015,'友情链接更新成功',1440365859,1,'222.44.84.34',1,'LinkGroup','update'),(12016,'合作机构更新成功',1440365869,1,'222.44.84.34',1,'LinkGroup','update'),(12017,'合作媒体添加成功',1440365893,1,'222.44.84.34',1,'LinkGroup','insert'),(12018,'PINMAN DESIGN添加成功',1440365949,1,'222.44.84.34',1,'Link','insert'),(12019,'合作媒体彻底删除成功',1440365974,1,'222.44.84.34',1,'LinkGroup','foreverdelete'),(12020,'合作机构更新成功',1440365998,1,'222.44.84.34',1,'LinkGroup','update'),(12021,'淘宝众筹添加成功',1440366448,1,'222.44.84.34',1,'Link','insert'),(12022,'京东众筹添加成功',1440366580,1,'222.44.84.34',1,'Link','insert'),(12023,'设计机构添加成功',1440366610,1,'222.44.84.34',1,'LinkGroup','insert'),(12024,'admin登录成功',1440366759,1,'114.80.241.146',1,'Public','do_login'),(12025,'苏宁众筹添加成功',1440367164,1,'222.44.84.34',1,'Link','insert'),(12026,'百度彻底删除成功',1440367203,1,'222.44.84.34',1,'Link','foreverdelete'),(12027,'合作媒体添加成功',1440367238,1,'222.44.84.34',1,'LinkGroup','insert'),(12028,'更新系统配置',1440368002,1,'222.44.84.34',1,'Conf','update'),(12029,'众创学院添加成功',1440368448,1,'222.44.84.34',1,'ArticleCate','insert'),(12030,'DPIN众创学院添加成功',1440368518,1,'222.44.84.34',1,'Nav','insert'),(12031,'DPIN众创学院更新成功',1440368541,1,'222.44.84.34',1,'Nav','update'),(12032,'必酷赛博添加成功',1440368931,1,'222.44.84.34',1,'Link','insert'),(12033,'必酷赛博更新成功',1440368975,1,'222.44.84.34',1,'Link','update'),(12034,'京东众筹更新成功',1440368991,1,'222.44.84.34',1,'Link','update'),(12035,'淘宝众筹更新成功',1440369003,1,'222.44.84.34',1,'Link','update'),(12036,'必酷赛博更新成功',1440369082,1,'222.44.84.34',1,'Link','update'),(12037,'苏宁众筹更新成功',1440369092,1,'222.44.84.34',1,'Link','update'),(12038,'京东众筹更新成功',1440369101,1,'222.44.84.34',1,'Link','update'),(12039,'淘宝众筹更新成功',1440369110,1,'222.44.84.34',1,'Link','update'),(12040,'版权申明更新成功',1440369562,1,'222.44.84.34',1,'Article','update'),(12041,'视觉中国添加成功',1440370083,1,'222.44.84.34',1,'Link','insert'),(12042,'富曼欧资本添加成功',1440371519,1,'222.44.84.34',1,'Link','insert'),(12043,'中同资本添加成功',1440371597,1,'222.44.84.34',1,'Link','insert'),(12044,'关于我们更新成功',1440373420,1,'222.44.84.34',1,'Article','update'),(12045,'版权申明更新成功',1440373474,1,'222.44.84.34',1,'Article','update'),(12046,'关于我们更新成功',1440373494,1,'222.44.84.34',1,'Article','update'),(12047,'DPIN实验室添加成功',1440378491,1,'222.44.84.34',1,'Nav','insert'),(12048,'DPIN实验室更新成功',1440378513,1,'222.44.84.34',1,'Nav','update'),(12049,'DPIN实验室更新成功',1440378555,1,'222.44.84.34',1,'Nav','update'),(12050,'DPIN众创学院更新成功',1440378567,1,'222.44.84.34',1,'Nav','update'),(12051,'大王添加成功',1440379768,1,'222.44.84.34',1,'Role','insert'),(12052,'大王添加成功',1440379801,1,'222.44.84.34',1,'Admin','insert'),(12053,'大王登录成功',1440379915,5,'222.44.84.34',1,'Public','do_login'),(12054,'大王登录成功',1440382294,5,'222.44.84.34',1,'Public','do_login'),(12055,'更新系统配置',1440382698,1,'222.44.84.34',1,'Conf','update'),(12056,'更新系统配置',1440382747,1,'222.44.84.34',1,'Conf','update'),(12057,'【时光文具】一套能慢慢陪你到老的文具系列添加成功',1440391383,1,'115.231.225.9',1,'Deal','insert'),(12058,'《不一样的烟火》—2015春季WEIS烟火系列台灯添加成功',1440391713,1,'115.231.225.9',1,'Deal','insert'),(12059,'《不一样的烟火》—2015春季WEIS烟火系列台灯更新成功',1440391782,1,'115.231.225.9',1,'Deal','update'),(12060,'项目名称：泡温泉更新成功',1440392161,1,'115.231.225.9',1,'Deal','update'),(12061,'XL储物水壶，史上最贴心的水壶添加成功',1440392409,1,'115.231.225.9',1,'Deal','insert'),(12062,'XL储物水壶，史上最贴心的水壶更新成功',1440392571,1,'115.231.225.9',1,'Deal','update'),(12063,'【微山水】东方美感的极致小物，方寸之间尽显山河气魄添加成功',1440393013,1,'115.231.225.9',1,'Deal','insert'),(12064,'159_is_special启用成功',1440393097,1,'115.231.225.9',1,'Deal','toogle_status'),(12065,'160_is_recommend启用成功',1440393115,1,'115.231.225.9',1,'Deal','toogle_status'),(12066,'160_is_recommend禁用成功',1440393131,1,'115.231.225.9',1,'Deal','toogle_status'),(12067,'158_is_recommend启用成功',1440393135,1,'115.231.225.9',1,'Deal','toogle_status'),(12068,'155_is_special禁用成功',1440393155,1,'115.231.225.9',1,'Deal','toogle_status'),(12069,'WEIS 中国文化意境产品之独立设计师签名收藏版添加成功',1440393667,1,'115.231.225.9',1,'Deal','insert'),(12070,'161_is_classic启用成功',1440393675,1,'115.231.225.9',1,'Deal','toogle_status'),(12071,'161_is_hot启用成功',1440393677,1,'115.231.225.9',1,'Deal','toogle_status'),(12072,'161_is_recommend启用成功',1440393677,1,'115.231.225.9',1,'Deal','toogle_status'),(12073,'给最好的自己——萌奇小可乐移动电源添加成功',1440394882,1,'115.231.225.9',1,'Deal','insert'),(12074,'162_is_special启用成功',1440394909,1,'115.231.225.9',1,'Deal','toogle_status'),(12075,'162_is_recommend启用成功',1440394910,1,'115.231.225.9',1,'Deal','toogle_status'),(12076,'为梦想点灯——跟大触LIKE一起学矢量插画添加成功',1440395248,1,'115.231.225.9',1,'Deal','insert'),(12077,'为梦想点灯——跟大触LIKE一起学矢量插画更新成功',1440395322,1,'115.231.225.9',1,'Deal','update'),(12078,'为梦想点灯——跟大触LIKE一起学矢量插画更新成功',1440396010,1,'115.231.225.9',1,'Deal','update'),(12079,'给最好的自己——萌奇小可乐移动电源更新成功',1440396024,1,'115.231.225.9',1,'Deal','update'),(12080,'《不一样的烟火》—2015春季WEIS烟火系列台灯更新成功',1440396050,1,'115.231.225.9',1,'Deal','update'),(12081,'《不一样的烟火》—2015春季WEIS烟火系列台灯更新成功',1440396095,1,'115.231.225.9',1,'Deal','update'),(12082,'官方微博更新成功',1440439766,1,'222.44.84.34',1,'Help','update'),(12083,'官方微博更新成功',1440441053,1,'222.44.84.34',1,'Help','update'),(12084,'业务流程更新成功',1440441262,1,'222.44.84.34',1,'Article','update'),(12085,'项目规范更新成功',1440441306,1,'222.44.84.34',1,'Article','update'),(12086,'常见问题更新成功',1440441325,1,'222.44.84.34',1,'Article','update'),(12087,'使用条款更新成功',1440441360,1,'222.44.84.34',1,'Article','update'),(12088,'项目规范更新成功',1440441372,1,'222.44.84.34',1,'Article','update'),(12089,'风险提示更新成功',1440441388,1,'222.44.84.34',1,'Article','update'),(12090,'众创学院更新成功',1440441440,1,'222.44.84.34',1,'ArticleCate','update'),(12091,'合作方式更新成功',1440441574,1,'222.44.84.34',1,'ArticleCate','update'),(12092,'渠道合作添加成功',1440441718,1,'222.44.84.34',1,'Article','insert'),(12093,'活动报名启用成功',1440441806,1,'222.44.84.34',1,'ArticleCate','set_effect'),(12094,'管理员操作',1440442047,1,'222.44.84.34',1,'User','modify_account'),(12095,'grace更新成功',1440442088,1,'222.44.84.34',1,'User','update'),(12096,'服务条款更新成功',1440442672,1,'222.44.84.34',1,'Help','update'),(12097,'关于我们更新成功',1440442684,1,'222.44.84.34',1,'Help','update'),(12098,'隐私策略更新成功',1440442693,1,'222.44.84.34',1,'Help','update'),(12099,'服务介绍更新成功',1440442699,1,'222.44.84.34',1,'Help','update'),(12100,'服务更新成功',1440486679,1,'42.81.42.47',1,'DealCate','update'),(12101,'设计更新成功',1440486705,1,'42.81.42.47',1,'DealCate','update'),(12102,'动漫更新成功',1440486721,1,'42.81.42.47',1,'DealCate','update'),(12103,'文化更新成功',1440486732,1,'42.81.42.47',1,'DealCate','update'),(12104,'赛事添加成功',1440486835,1,'122.225.36.68',1,'Nav','insert'),(12105,'赛事更新成功',1440486892,1,'115.231.225.4',1,'Nav','update'),(12106,'赛事活动更新成功',1440486902,1,'42.81.42.47',1,'Nav','update'),(12107,'1更新成功',1440487077,1,'122.225.36.68',1,'IndexImage','update'),(12108,'1更新成功',1440487124,1,'122.225.36.68',1,'IndexImage','update'),(12109,'admin登录成功',1440655633,1,'180.175.106.51',1,'Public','do_login'),(12110,'更新系统配置',1440655732,1,'180.175.106.51',1,'Conf','update'),(12111,'短信宝增值平台 (<a href=\'http://www.smsbao.com/reg?r=5001\' target=\'_blank\'><font color=\'red\'>还没账号？点击这免费注册</font></a>)安装成功',1440656869,1,'180.175.106.51',1,'Sms','insert'),(12112,'admin登录成功',1440715898,1,'180.175.106.51',1,'Public','do_login'),(12113,'云信留客安装成功',1440715972,1,'180.175.106.51',1,'Sms','insert'),(12114,'云信留客启用成功',1440715979,1,'180.175.106.51',1,'Sms','set_effect'),(12115,'方维短信平台安装成功',1440716001,1,'180.175.106.51',1,'Sms','insert'),(12116,'admin登录成功',1441046695,1,'180.175.106.51',1,'Public','do_login'),(12117,'更新系统配置',1441046713,1,'180.175.106.51',1,'Conf','update'),(12118,'admin登录成功',1441048466,1,'180.175.106.51',1,'Public','do_login'),(12119,'admin登录成功',1441053753,1,'222.44.84.34',1,'Public','do_login'),(12120,'更新系统配置',1441053779,1,'222.44.84.34',1,'Conf','update'),(12121,'admin管理员密码错误',1441057585,0,'180.175.106.51',0,'Public','do_login'),(12122,'admin登录成功',1441057592,1,'180.175.106.51',1,'Public','do_login'),(12123,'禁用成功',1441057643,1,'180.175.106.51',1,'MailServer','set_effect'),(12124,'admin登录成功',1441132493,1,'180.175.106.51',1,'Public','do_login'),(12125,'9590彻底删除成功',1441138407,1,'180.175.106.51',1,'DealMsgList','foreverdelete'),(12126,'更新系统配置',1441138574,1,'180.175.106.51',1,'Conf','update'),(12127,'admin登录成功',1441178462,1,'127.0.0.1',1,'Public','do_login'),(12128,'9605,9604,9603,9602,9600,9601,9599,9597,9598,9596彻底删除成功',1441178503,1,'127.0.0.1',1,'DealMsgList','foreverdelete'),(12129,'admin登录成功',1441181176,1,'::1',1,'Public','do_login'),(12130,'admin登录成功',1441182336,1,'127.0.0.1',1,'Public','do_login'),(12131,'9606彻底删除成功',1441182719,1,'127.0.0.1',1,'DealMsgList','foreverdelete'),(12132,'更新系统配置',1441182780,1,'127.0.0.1',1,'Conf','update'),(12133,'admin登录成功',1441231921,1,'180.175.239.186',1,'Public','do_login'),(12134,'admin登录成功',1441232266,1,'127.0.0.1',1,'Public','do_login'),(12135,'9607,9608彻底删除成功',1441233215,1,'180.175.239.186',1,'DealMsgList','foreverdelete'),(12136,'9609彻底删除成功',1441233394,1,'180.175.239.186',1,'DealMsgList','foreverdelete'),(12137,'微信登录更新成功',1441234506,1,'180.175.239.186',1,'ApiLogin','update'),(12138,'admin登录成功',1441565864,1,'180.175.1.93',1,'Public','do_login'),(12139,'admin登录成功',1441593440,1,'127.0.0.1',1,'Public','do_login'),(12140,'admin登录成功',1441654556,1,'127.0.0.1',1,'Public','do_login'),(12141,'admin登录成功',1441656045,1,'180.175.1.93',1,'Public','do_login'),(12142,'admin登录成功',1441688657,1,'180.175.239.186',1,'Public','do_login'),(12143,'admin登录成功',1441692223,1,'180.175.239.186',1,'Public','do_login'),(12144,'admin登录成功',1441696264,1,'180.175.239.186',1,'Public','do_login'),(12145,'admin登录成功',1441734376,1,'180.175.1.93',1,'Public','do_login'),(12146,'TPL_SMS_ZC_STATUS更新成功',1441734805,1,'180.175.1.93',1,'MsgTemplate','update'),(12147,'admin登录成功',1441744990,1,'127.0.0.1',1,'Public','do_login'),(12148,'admin登录成功',1441745055,1,'127.0.0.1',1,'Public','do_login'),(12149,'TPL_SMS_ZC_STATUS更新成功',1441745125,1,'127.0.0.1',1,'MsgTemplate','update'),(12150,'TPL_SMS_DEAL_SUCCESS更新成功',1441745148,1,'127.0.0.1',1,'MsgTemplate','update'),(12151,'TPL_SMS_DEAL_FAIL更新成功',1441745162,1,'127.0.0.1',1,'MsgTemplate','update'),(12152,'TPL_SMS_USER_S更新成功',1441745173,1,'127.0.0.1',1,'MsgTemplate','update'),(12153,'TPL_SMS_USER_F更新成功',1441745182,1,'127.0.0.1',1,'MsgTemplate','update'),(12154,'admin登录成功',1441751634,1,'222.44.84.34',1,'Public','do_login'),(12155,'更新成功',1441752095,1,'222.44.84.34',1,'MailServer','update'),(12156,'更新成功',1441752599,1,'222.44.84.34',1,'MailServer','update'),(12157,'更新成功',1441752685,1,'222.44.84.34',1,'MailServer','update'),(12158,'禁用成功',1441752905,1,'222.44.84.34',1,'MailServer','set_effect'),(12159,'启用成功',1441752906,1,'222.44.84.34',1,'MailServer','set_effect'),(12160,'更新成功',1441752943,1,'222.44.84.34',1,'MailServer','update'),(12161,'更新成功',1441753096,1,'222.44.84.34',1,'MailServer','update'),(12162,'更新成功',1441753406,1,'222.44.84.34',1,'MailServer','update'),(12163,'更新成功',1441753929,1,'222.44.84.34',1,'MailServer','update'),(12164,'更新成功',1441754043,1,'222.44.84.34',1,'MailServer','update'),(12165,'更新成功',1441754105,1,'222.44.84.34',1,'MailServer','update'),(12166,'smtp.163.com添加成功',1441754254,1,'222.44.84.34',1,'MailServer','insert'),(12167,'smtp.exmail.qq.com彻底删除成功',1441754282,1,'222.44.84.34',1,'MailServer','foreverdelete'),(12168,'更新成功',1441754544,1,'222.44.84.34',1,'MailServer','update'),(12169,'更新成功',1441754583,1,'222.44.84.34',1,'MailServer','update'),(12170,'更新成功',1441754831,1,'222.44.84.34',1,'MailServer','update'),(12171,'神父更新成功',1441755378,1,'222.44.84.34',1,'User','update'),(12172,'李书福子更新成功',1441755897,1,'222.44.84.34',1,'User','update'),(12173,'微信支付(WAP版本)更新成功',1441757475,1,'222.44.84.34',1,'Payment','update'),(12174,'微信支付(WAP版本)更新成功',1441759715,1,'222.44.84.34',1,'Payment','update'),(12175,'微信支付(WAP版本)更新成功',1441761758,1,'222.44.84.34',1,'Payment','update'),(12176,'微信支付(WAP版本)更新成功',1441761995,1,'222.44.84.34',1,'Payment','update'),(12177,'易宝资金托管卸载成功',1441762584,1,'222.44.84.34',1,'Collocation','uninstall'),(12178,'问问更新成功',1441762790,1,'222.44.84.34',1,'Deal','update'),(12179,'问问更新成功',1441762821,1,'222.44.84.34',1,'Deal','update'),(12180,'问问更新成功',1441762899,1,'222.44.84.34',1,'Deal','update'),(12181,'问问成功移到回收站',1441763048,1,'222.44.84.34',1,'Deal','delete'),(12182,'项目名称：泡温泉更新成功',1441763992,1,'222.44.84.34',1,'Deal','update'),(12183,'鸭鸭乐防近视智能笔更新成功',1441764277,1,'222.44.84.34',1,'Deal','update'),(12184,'微信支付(WAP版本)更新成功',1441764999,1,'222.44.84.34',1,'Payment','update'),(12185,'微信支付(WAP版本)更新成功',1441765141,1,'222.44.84.34',1,'Payment','update'),(12186,'鸭鸭乐防近视智能笔更新成功',1441777096,1,'42.81.42.47',1,'Deal','update'),(12187,'admin登录成功',1441778690,1,'180.175.239.186',1,'Public','do_login'),(12188,'admin管理员密码错误',1460092974,0,'180.173.15.220',0,'Public','do_login');
/*!40000 ALTER TABLE `fanwe_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_m_adv`
--

DROP TABLE IF EXISTS `fanwe_m_adv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_m_adv` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `img` varchar(255) DEFAULT '',
  `page` varchar(20) DEFAULT '',
  `type` tinyint(1) DEFAULT '0' COMMENT '1.标签集,2.url地址,3.分类排行,4.最亮达人,5.搜索发现,6.一起拍,7.热门单品排行,8.直接显示某个分享',
  `data` text,
  `sort` smallint(5) DEFAULT '10',
  `status` tinyint(1) DEFAULT '1',
  `open_url_type` int(11) DEFAULT '0' COMMENT '0:使用内置浏览器打开url;1:使用外置浏览器打开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_m_adv`
--

LOCK TABLES `fanwe_m_adv` WRITE;
/*!40000 ALTER TABLE `fanwe_m_adv` DISABLE KEYS */;
INSERT INTO `fanwe_m_adv` VALUES (36,'2','./public/attachment/201508/17/12/55d162f6d23e1.jpg','top',1,'',2,1,0),(35,'1','./public/attachment/201508/17/12/55d162e68fb4f.jpg','top',1,'',1,1,0);
/*!40000 ALTER TABLE `fanwe_m_adv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_m_config`
--

DROP TABLE IF EXISTS `fanwe_m_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_m_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `val` text,
  `type` tinyint(1) NOT NULL,
  `sort` int(11) DEFAULT '0',
  `value_scope` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_m_config`
--

LOCK TABLES `fanwe_m_config` WRITE;
/*!40000 ALTER TABLE `fanwe_m_config` DISABLE KEYS */;
INSERT INTO `fanwe_m_config` VALUES (10,'kf_phone','客服电话','400-885-8983',0,1,NULL),(11,'kf_email','客服邮箱','',0,2,NULL),(29,'ios_upgrade','ios版本升级内容','',3,9,NULL),(16,'page_size','分页大小','10',0,10,NULL),(17,'about_info','关于我们(填文章ID)','66',0,3,NULL),(18,'program_title','程序标题名称','DPIN众创平台',0,0,NULL),(22,'android_version','android版本号(yyyymmddnn)','2014082101',0,4,NULL),(23,'android_filename','android下载包名(放程序根目录下)','fanwe_P2P.apk',0,5,NULL),(24,'ios_version','ios版本号(yyyymmddnn)','2014082009',0,7,NULL),(25,'ios_down_url','ios下载地址(appstore连接地址)','',0,8,NULL),(28,'android_upgrade','android版本升级内容','修复bug',3,6,NULL),(30,'article_cate_id','文章分类ID','15',0,11,NULL),(31,'android_forced_upgrade','android是否强制升级(0:否;1:是)','1',0,0,NULL),(32,'ios_forced_upgrade','ios是否强制升级(0:否;1:是)','1',0,0,NULL),(35,'logo','系统LOGO','./public/attachment/201508/24/12/55daa26707564.png',2,1,NULL),(33,'index_adv_num','首页广告数','5',0,33,NULL),(34,'index_pro_num','首页推荐商品数','5',0,34,NULL),(36,'wx_appid','微信APPID','wxebb93e936947833f',0,36,NULL),(37,'wx_secrit','微信SECRIT','cc75e9ef113b93afaa3ac9f39ae382d8 ',0,37,NULL),(38,'sina_app_key','新浪APP_KEY','1131274763',0,38,NULL),(39,'sina_app_secret','新浪APP_SECRET','01b4d38c850d4d7d98923d07c2eca6ea',0,39,NULL),(40,'sina_bind_url','新浪回调地址','http://open.weibo.com/apps/',0,40,NULL),(41,'qq_app_key','QQ登录APP_KEY','udFh2obcNkc5Tz0C',0,41,NULL),(42,'qq_app_secret','QQ登录APP_SECRET','',0,42,NULL),(43,'wx_app_key','微信(分享)appkey','wxebb93e936947833f',0,43,NULL),(44,'wx_app_secret','微信(分享)appSecret','cc75e9ef113b93afaa3ac9f39ae382d8',0,44,NULL),(45,'wx_controll','一站式登录方式','0',4,45,'0,1');
/*!40000 ALTER TABLE `fanwe_m_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_mail_list`
--

DROP TABLE IF EXISTS `fanwe_mail_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_mail_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_address` varchar(255) NOT NULL,
  `city_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mail_address_idx` (`mail_address`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_mail_list`
--

LOCK TABLES `fanwe_mail_list` WRITE;
/*!40000 ALTER TABLE `fanwe_mail_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_mail_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_mail_server`
--

DROP TABLE IF EXISTS `fanwe_mail_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_mail_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smtp_server` varchar(255) NOT NULL,
  `smtp_name` varchar(255) NOT NULL,
  `smtp_pwd` varchar(255) NOT NULL,
  `is_ssl` tinyint(1) NOT NULL,
  `smtp_port` varchar(255) NOT NULL,
  `use_limit` int(11) NOT NULL,
  `is_reset` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `total_use` int(11) NOT NULL,
  `is_verify` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_mail_server`
--

LOCK TABLES `fanwe_mail_server` WRITE;
/*!40000 ALTER TABLE `fanwe_mail_server` DISABLE KEYS */;
INSERT INTO `fanwe_mail_server` VALUES (9,'smtp.163.com','hyz12580@163.com','13512143253',1,'465',0,1,1,11,1);
/*!40000 ALTER TABLE `fanwe_mail_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_message`
--

DROP TABLE IF EXISTS `fanwe_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '该留言所属人ID',
  `user_name` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `cate_id` int(11) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COMMENT='// 用户留言';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_message`
--

LOCK TABLES `fanwe_message` WRITE;
/*!40000 ALTER TABLE `fanwe_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_message_cate`
--

DROP TABLE IF EXISTS `fanwe_message_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_message_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(255) NOT NULL,
  `is_project` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目发起的分类 0表示否 1表示 是',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='// 用户留言分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_message_cate`
--

LOCK TABLES `fanwe_message_cate` WRITE;
/*!40000 ALTER TABLE `fanwe_message_cate` DISABLE KEYS */;
INSERT INTO `fanwe_message_cate` VALUES (1,'项目登记',1),(2,'建议留言',0);
/*!40000 ALTER TABLE `fanwe_message_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_mobile_verify_code`
--

DROP TABLE IF EXISTS `fanwe_mobile_verify_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_mobile_verify_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `verify_code` varchar(10) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `create_time` int(11) NOT NULL,
  `client_ip` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL COMMENT '邮件',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6339 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_mobile_verify_code`
--

LOCK TABLES `fanwe_mobile_verify_code` WRITE;
/*!40000 ALTER TABLE `fanwe_mobile_verify_code` DISABLE KEYS */;
INSERT INTO `fanwe_mobile_verify_code` VALUES (6338,'380607','',1448827492,'101.81.55.163','461225265@qq.com');
/*!40000 ALTER TABLE `fanwe_mobile_verify_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_money_freeze`
--

DROP TABLE IF EXISTS `fanwe_money_freeze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_money_freeze` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestNo` int(10) NOT NULL DEFAULT '0' COMMENT '请求流水号',
  `platformUserNo` int(11) NOT NULL DEFAULT '0' COMMENT '平台会员编号',
  `platformNo` varchar(20) NOT NULL COMMENT '商户编号',
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '冻结金额',
  `expired` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '到期自劢解冻时间',
  `is_callback` tinyint(1) NOT NULL DEFAULT '0',
  `code` varchar(50) DEFAULT NULL COMMENT '返回码;1 成功 0 失败 2 xml参数格式错误 3 签名验证失败 101 引用了不存在的对象（例如错误的订单号） 102 业务状态不正确 103 由于业务限制导致业务不能执行 104 实名认证失败',
  `description` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `deal_id` int(10) NOT NULL COMMENT '项目id',
  `pay_type` tinyint(1) DEFAULT '0' COMMENT '0 表示第三方托管 1表示第三方支付',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1表示冻结诚意金，2表示解冻诚意金,3表示申请解冻',
  `create_time` int(11) DEFAULT NULL COMMENT '冻结时间',
  PRIMARY KEY (`id`,`requestNo`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_money_freeze`
--

LOCK TABLES `fanwe_money_freeze` WRITE;
/*!40000 ALTER TABLE `fanwe_money_freeze` DISABLE KEYS */;
INSERT INTO `fanwe_money_freeze` VALUES (118,0,21,'0',0.01,'0000-00-00 00:00:00',1,NULL,NULL,156,1,2,1441759732);
/*!40000 ALTER TABLE `fanwe_money_freeze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_money_type`
--

DROP TABLE IF EXISTS `fanwe_money_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_money_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'type类型 0 ~ ？',
  `class` varchar(100) NOT NULL DEFAULT '' COMMENT '所属分类 money  lock_money site_money  point  score',
  `sort` int(11) NOT NULL DEFAULT '0',
  `is_effect` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_money_type`
--

LOCK TABLES `fanwe_money_type` WRITE;
/*!40000 ALTER TABLE `fanwe_money_type` DISABLE KEYS */;
INSERT INTO `fanwe_money_type` VALUES (1,'普通的',0,'money',0,1),(2,'加入诚意金',1,'money',0,1),(3,'违约扣除诚意金',2,'money',0,1),(4,'分红',3,'money',0,1),(5,'订金',4,'money',0,1),(6,'首付',5,'money',0,1),(7,'众筹买房',6,'money',0,1),(8,'买房卖出回报',7,'money',0,1),(9,'理财赎回本金',8,'money',0,1),(10,'理财赎回收益',9,'money',0,1),(11,'理财赎回手续费',10,'money',0,1),(12,'理财本金',11,'money',0,1),(13,'理财购买手续费',12,'money',0,1),(14,'理财冻结资金',13,'money',0,1),(15,'理财服务费',14,'money',0,1),(16,'理财发放资金',15,'money',0,1);
/*!40000 ALTER TABLE `fanwe_money_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_mortgate`
--

DROP TABLE IF EXISTS `fanwe_mortgate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_mortgate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `notice_id` int(11) NOT NULL COMMENT '0 表示为余额支付 大于0表示在线支付',
  `money` int(11) NOT NULL COMMENT '诚意金 金额',
  `status` tinyint(1) NOT NULL COMMENT '状态 1表示诚意金支付 2表示扣除诚意金 3表示诚意金解冻到余额',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_mortgate`
--

LOCK TABLES `fanwe_mortgate` WRITE;
/*!40000 ALTER TABLE `fanwe_mortgate` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_mortgate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_msg_template`
--

DROP TABLE IF EXISTS `fanwe_msg_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_msg_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `type` tinyint(1) NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_msg_template`
--

LOCK TABLES `fanwe_msg_template` WRITE;
/*!40000 ALTER TABLE `fanwe_msg_template` DISABLE KEYS */;
INSERT INTO `fanwe_msg_template` VALUES (1,'TPL_MAIL_USER_PASSWORD','<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}你好，请点击以下链接修改您的密码：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.password_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.password_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.site_name}团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n \r\n</tbody>\r\n</table>',1,1),(3,'TPL_MAIL_USER_VERIFY','<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 {$user.send_time_ms} 帐号 发送验证码：</p>\r\n				<p style=\"margin:0px;padding:0px;\">验证码：{$user.send_code}</p>\r\n 				 \r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.site_name}帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1,1),(29,'TPL_SMS_ZC_STATUS','DPIN众创平台：{$user.control_content}',0,0),(30,'TPL_MAIL_ZC_STATUS','<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\n<tbody>\n	<tr>\n		<td>\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n        <tbody>\n		<tr>\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\n		</tr>\n        </tbody>\n		</table>\n		</td>\n	</tr>\n	<tr>\n		<td>\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n        <tbody>\n		<tr>\n			<td width=\"25px;\" style=\"width:25px;\"></td>\n			<td align=\"\">\n				<div style=\"line-height:40px;height:40px;\"></div>\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.control_content}</p>\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.verify_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.verify_url}</a></p>\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\n 				<div style=\"line-height:80px;height:80px;\"></div>\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\n			</td>\n		</tr>\n		</tbody>\n		</table>\n		</td>\n	</tr>\n	<tr>\n		<td>\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\n			<tbody>\n			<tr>\n				<td width=\"25px;\" style=\"width:25px;\"></td>\n				<td align=\"\">\n					<div style=\"line-height:40px;height:40px;\"></div>\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\n				</td>\n			</tr>\n			</tbody>\n			</table>\n		</td>\n	</tr>\n</tbody>\n</table>',1,1),(17,'TPL_SMS_DEAL_SUCCESS','{$success_user_info.user_name}，您所支持的 \"{$success_user_info.deal_name}\" 项目成功!',0,0),(18,'TPL_SMS_DEAL_FAIL','{$fail_user_info.user_name}，您所支持的 \"{$fail_user_info.deal_name}\"项目失败!',0,0),(19,'TPL_SMS_DEAL_RECEPROCATION','{$success_user_info_hui.user_name}，您投资的 \"{$success_user_info_hui.deal_name}项目\"，近期将会发放回报。',0,0),(20,'TPL_SMS_USER_VERIFY','{$success_user_info.user_name}：会员名,注册验证成功!',0,0),(21,'TPL_SMS_USER_S','{$user_s_msg.user_name},您发起的{$user_s_msg.deal_name}项目成功!',0,0),(22,'TPL_SMS_USER_F','{$user_f_msg.user_name}，您发起的{$user_f_msg.deal_name}项目失败!',0,0),(23,'TPL_SMS_VERIFY_CODE','您的短信校验码为 {$verify.code} 请勿泄漏，需要您进行身份校验.',0,0),(4,'TPL_MAIL_CHANGE_USER_VERIFY','<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 {$user.send_time_ms} 进行邮件修改 <a href=\"mailto:{$user.email}\" target=\"_blank\">{$user.email}<wbr>.com</a> ，点击以下链接，即可进行下一步操作：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.verify_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.verify_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">1、为了保障您帐号的安全性，请在 48小时内完成激活，此链接将在您激活过一次后失效！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">2、注册的帐号可以畅行{$user.site_name}产品</p>\r\n				<div style=\"line-height:80px;height:80px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.site_name}帐号团队</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1,1),(5,'TPL_MAIL_INVESTOR_STATUS','<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您于 {$user.send_time_ms} 进行{$user.is_investor_name}申请，{if $user.investor_status eq 1}很高兴您审核通过,点击以下链接，即可进行下一步操作{else}很遗憾您的申请未通过,理由是：{$user.investor_send_info};点击以下链接，即可重新申请{/if}：</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.verify_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.verify_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n 				<div style=\"line-height:80px;height:80px;\"></div>\r\n 				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，此帐号将不会被激活，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1,1),(25,'TPL_MAIL_INVESTOR_PAY_STATUS','<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}您好，您的投资申请已通过，请在{$user.pay_end_time}前进行支付{$user.money}元;点击以下链接</p>\r\n				<p style=\"margin:0px;padding:0px;\"><a href=\"{$user.note_url}\" style=\"line-height:24px;font-size:12px;font-family:arial,sans-serif;color:#0000cc\" target=\"_blank\">{$user.note_url}</a></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:arial,sans-serif;\">(如果您无法点击此链接，请将它复制到浏览器地址栏后访问)</p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1,1),(26,'TPL_SMS_INVESTOR_PAY_STATUS','{$user.user_name}您好，您的投资申请已通过，请在{$user.pay_end_time}前进行支付{$user.money}元',0,0),(6,'TPL_SMS_INVESTOR_STATUS','{$user.user_name}您好，{if $user.investor_status eq 1}恭喜您{else}很遗憾,{$user.investor_send_info}{/if},您申请的{$user.is_investor_name}{$user.investor_status_name}',0,0),(27,'TPL_SMS_INVESTOR_PAID_STATUS','恭喜您，已经支付{$user.paid_money}元,支付单号为{$user.notice_sn}',0,0),(28,'TPL_MAIL_INVESTOR_PAID_STATUS','<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"\" width=\"100%\" style=\"background:#ffffff;\" class=\"baidu_pass\">\r\n<tbody>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;width:15px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;width:137px;\"><img src=\"{$user.logo}\" class=\"logo\" ellpadding=\"0\" cellspacing=\"0\"></td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #ffffff;width:10px;\">&nbsp;</td>\r\n			<td style=\"background:#ffffff;border-bottom:2px solid #dfdfdf;\">&nbsp;</td>\r\n		</tr>\r\n        </tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n		<tr>\r\n			<td width=\"25px;\" style=\"width:25px;\"></td>\r\n			<td align=\"\">\r\n				<div style=\"line-height:40px;height:40px;\"></div>\r\n				<p style=\"margin:0px;padding:0px;\"><strong style=\"font-size:14px;line-height:24px;color:#333333;font-family:arial,sans-serif;\">亲爱的用户：</strong></p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">您好！</p>\r\n				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\">{$user.user_name}您好，恭喜您，已经支付{$user.paid_money}元,支付单号为{$user.notice_sn}</p>\r\n				\r\n  				<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#333333;font-family:\'宋体\',arial,sans-serif;\"><span style=\"border-bottom:1px dashed #ccc;\" t=\"5\" times=\"\">{$user.send_time}</span></p>\r\n			</td>\r\n		</tr>\r\n		</tbody>\r\n		</table>\r\n		</td>\r\n	</tr>\r\n	<tr>\r\n		<td>\r\n			<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-top:1px solid #dfdfdf\">\r\n			<tbody>\r\n			<tr>\r\n				<td width=\"25px;\" style=\"width:25px;\"></td>\r\n				<td align=\"\">\r\n					<div style=\"line-height:40px;height:40px;\"></div>\r\n					<p style=\"margin:0px;padding:0px;line-height:24px;font-size:12px;color:#979797;font-family:\'宋体\',arial,sans-serif;\">若您没有注册过{$user.site_name}帐号，请忽略此邮件，由此给您带来的不便请谅解。</p>\r\n				</td>\r\n			</tr>\r\n			</tbody>\r\n			</table>\r\n		</td>\r\n	</tr>\r\n</tbody>\r\n</table>',1,1);
/*!40000 ALTER TABLE `fanwe_msg_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_nav`
--

DROP TABLE IF EXISTS `fanwe_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `blank` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `u_module` varchar(255) NOT NULL,
  `u_action` varchar(255) NOT NULL,
  `u_id` int(11) NOT NULL,
  `u_param` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_nav`
--

LOCK TABLES `fanwe_nav` WRITE;
/*!40000 ALTER TABLE `fanwe_nav` DISABLE KEYS */;
INSERT INTO `fanwe_nav` VALUES (42,'首页','',0,1,1,'index','',0,''),(47,'项目','deals.html',0,3,1,'','',0,''),(52,'众创学院','',0,7,1,'article_cate','',0,''),(48,'最新动态','',0,4,1,'news','index',0,''),(49,'天使团','',0,5,1,'investor','invester_list',0,''),(51,'路演快讯','',0,6,1,'article_cate','',0,''),(53,'造梦空间','',0,8,1,'deals','index',0,''),(54,'赛事活动','',0,9,1,'article_cate','',0,'');
/*!40000 ALTER TABLE `fanwe_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_payment`
--

DROP TABLE IF EXISTS `fanwe_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `online_pay` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `total_amount` decimal(20,2) NOT NULL COMMENT '总金额',
  `config` text NOT NULL,
  `logo` varchar(255) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_payment`
--

LOCK TABLES `fanwe_payment` WRITE;
/*!40000 ALTER TABLE `fanwe_payment` DISABLE KEYS */;
INSERT INTO `fanwe_payment` VALUES (29,'Alipay',1,1,'支付宝即时到帐支付','',0.12,'a:3:{s:14:\"alipay_partner\";s:16:\"2088511154160291\";s:14:\"alipay_account\";s:14:\"king@pinman.cn\";s:10:\"alipay_key\";s:32:\"ufl11cd0mv1666t8lin31ybrg9x8evp5\";}','',1),(30,'AlipayBank',1,1,'支付宝银行直连支付','',0.00,'a:4:{s:14:\"alipay_partner\";s:16:\"2088511154160291\";s:14:\"alipay_account\";s:13:\"100@pinman.cn\";s:10:\"alipay_key\";s:32:\"ufl11cd0mv1666t8lin31ybrg9x8evp5\";s:14:\"alipay_gateway\";a:17:{s:7:\"ICBCB2C\";s:1:\"1\";s:3:\"CMB\";s:1:\"1\";s:3:\"CCB\";s:1:\"1\";s:3:\"ABC\";s:1:\"1\";s:4:\"SPDB\";s:1:\"1\";s:3:\"SDB\";s:1:\"1\";s:3:\"CIB\";s:1:\"1\";s:6:\"BJBANK\";s:1:\"1\";s:7:\"CEBBANK\";s:1:\"1\";s:4:\"CMBC\";s:1:\"1\";s:5:\"CITIC\";s:1:\"1\";s:3:\"GDB\";s:1:\"1\";s:7:\"SPABANK\";s:1:\"1\";s:6:\"BOCB2C\";s:1:\"1\";s:4:\"COMM\";s:1:\"1\";s:7:\"ICBCBTB\";s:1:\"1\";s:10:\"PSBC-DEBIT\";s:1:\"1\";}}','',2),(31,'Wwxjspay',1,2,'微信支付(WAP版本)','',0.00,'a:5:{s:5:\"appid\";s:18:\"wxebb93e936947833f\";s:9:\"appsecret\";s:33:\"cc75e9ef113b93afaa3ac9f39ae382d8 \";s:5:\"mchid\";s:10:\"1259142801\";s:3:\"key\";s:32:\"41100219860519401X41100219860519\";s:4:\"type\";s:2:\"v4\";}','',3);
/*!40000 ALTER TABLE `fanwe_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_payment_notice`
--

DROP TABLE IF EXISTS `fanwe_payment_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_payment_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_sn` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `pay_time` int(11) NOT NULL,
  `order_id` int(11) NOT NULL COMMENT 'order_id为0时为充值',
  `is_paid` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `bank_id` varchar(255) NOT NULL,
  `memo` text NOT NULL,
  `money` decimal(20,2) NOT NULL COMMENT '金额',
  `outer_notice_sn` varchar(255) NOT NULL,
  `deal_id` int(11) NOT NULL COMMENT '0为充值',
  `deal_item_id` int(11) NOT NULL COMMENT '0为充值',
  `deal_name` varchar(255) NOT NULL COMMENT '空为充值',
  `is_has_send_success` tinyint(1) NOT NULL COMMENT '（0表示发送不成功，1表示发送成功）',
  `is_mortgate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是诚意金 0表示否 1表示 是 2表示诚意金已经冻结（从余额中取出）',
  `paid_send` tinyint(1) NOT NULL COMMENT '支付成功后是否发送',
  PRIMARY KEY (`id`),
  UNIQUE KEY `notice_sn_unk` (`notice_sn`),
  KEY `order_id` (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `payment_id` (`payment_id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2320 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_payment_notice`
--

LOCK TABLES `fanwe_payment_notice` WRITE;
/*!40000 ALTER TABLE `fanwe_payment_notice` DISABLE KEYS */;
INSERT INTO `fanwe_payment_notice` VALUES (2319,'20150827494',1440653170,0,0,0,4297,29,'','',13.00,'',0,0,'',0,0,0),(2318,'20150824264',1440382958,1440382997,0,1,4294,29,'','',0.12,'2015082400001000680059940511',0,0,'',0,0,0);
/*!40000 ALTER TABLE `fanwe_payment_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_promote_msg`
--

DROP TABLE IF EXISTS `fanwe_promote_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_promote_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '0:短信 1:邮件',
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `send_time` int(11) NOT NULL,
  `send_status` tinyint(1) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `send_type_id` int(11) NOT NULL,
  `send_define_data` text NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `send_type` (`send_type`),
  KEY `send_type_id` (`send_type_id`),
  KEY `send_status` (`send_status`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_promote_msg`
--

LOCK TABLES `fanwe_promote_msg` WRITE;
/*!40000 ALTER TABLE `fanwe_promote_msg` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_promote_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_promote_msg_list`
--

DROP TABLE IF EXISTS `fanwe_promote_msg_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_promote_msg_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dest` varchar(255) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `content` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `send_time` int(11) NOT NULL,
  `is_send` tinyint(1) NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `result` text NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  `msg_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dest_idx` (`dest`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_promote_msg_list`
--

LOCK TABLES `fanwe_promote_msg_list` WRITE;
/*!40000 ALTER TABLE `fanwe_promote_msg_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_promote_msg_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_recommend`
--

DROP TABLE IF EXISTS `fanwe_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_recommend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memo` text NOT NULL COMMENT '推荐理由',
  `deal_id` int(11) NOT NULL COMMENT '项目编号',
  `user_id` int(11) NOT NULL COMMENT '推送给哪个会员',
  `recommend_user_id` int(11) NOT NULL COMMENT '推送人ID',
  `create_time` int(11) NOT NULL COMMENT '推荐时间',
  `deal_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型 0表示普通项目 1表示股权项目',
  `deal_name` varchar(255) NOT NULL COMMENT '项目名称',
  `deal_image` varchar(255) NOT NULL COMMENT '推荐项目图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_recommend`
--

LOCK TABLES `fanwe_recommend` WRITE;
/*!40000 ALTER TABLE `fanwe_recommend` DISABLE KEYS */;
INSERT INTO `fanwe_recommend` VALUES (1,'(｡･∀･)ﾉﾞ嗨',164,4296,4290,1441762933,0,'问问','./public/attachment/201509/09/17/55effdfe1c711.jpg'),(2,'s',165,95,4290,1441776985,0,'鸭鸭乐防近视智能笔','./public/attachment/201509/09/18/55f0039ca6dbf.jpg');
/*!40000 ALTER TABLE `fanwe_recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_referrals`
--

DROP TABLE IF EXISTS `fanwe_referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_referrals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '邀请人ID（即需要返利的会员ID）',
  `user_name` varchar(50) NOT NULL COMMENT '邀请人名称（即需要返利的会员名称）',
  `rel_user_id` int(11) NOT NULL COMMENT '被邀请人ID',
  `rel_user_name` varchar(50) NOT NULL COMMENT '被邀请人名称',
  `money` double(20,4) NOT NULL COMMENT '返利的现金',
  `create_time` int(11) NOT NULL COMMENT '返利生成的时间',
  `pay_time` int(11) NOT NULL COMMENT '返利发放的时间',
  `score` int(11) NOT NULL COMMENT '返利的积分',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `type` tinyint(1) NOT NULL COMMENT '类型：1表示注册奖励，2购买奖励',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=282 DEFAULT CHARSET=utf8 COMMENT='邀请返利记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_referrals`
--

LOCK TABLES `fanwe_referrals` WRITE;
/*!40000 ALTER TABLE `fanwe_referrals` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_referrals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_region_conf`
--

DROP TABLE IF EXISTS `fanwe_region_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_region_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '地区名称',
  `region_level` tinyint(4) NOT NULL COMMENT '1:国 2:省 3:市(县) 4:区(镇)',
  `py` varchar(50) NOT NULL,
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为热门地区',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3401 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_region_conf`
--

LOCK TABLES `fanwe_region_conf` WRITE;
/*!40000 ALTER TABLE `fanwe_region_conf` DISABLE KEYS */;
INSERT INTO `fanwe_region_conf` VALUES (3,1,'安徽',2,'anhui',0),(4,1,'福建',2,'fujian',0),(5,1,'甘肃',2,'gansu',0),(6,1,'广东',2,'guangdong',0),(7,1,'广西',2,'guangxi',0),(8,1,'贵州',2,'guizhou',0),(9,1,'海南',2,'hainan',0),(10,1,'河北',2,'hebei',0),(11,1,'河南',2,'henan',0),(12,1,'黑龙江',2,'heilongjiang',0),(13,1,'湖北',2,'hubei',0),(14,1,'湖南',2,'hunan',0),(15,1,'吉林',2,'jilin',0),(16,1,'江苏',2,'jiangsu',0),(17,1,'江西',2,'jiangxi',0),(18,1,'辽宁',2,'liaoning',0),(19,1,'内蒙古',2,'neimenggu',0),(20,1,'宁夏',2,'ningxia',0),(21,1,'青海',2,'qinghai',0),(22,1,'山东',2,'shandong',0),(23,1,'山西',2,'shanxi',0),(24,1,'陕西',2,'shanxi',0),(26,1,'四川',2,'sichuan',0),(28,1,'西藏',2,'xicang',0),(29,1,'新疆',2,'xinjiang',0),(30,1,'云南',2,'yunnan',0),(31,1,'浙江',2,'zhejiang',0),(36,3,'安庆',3,'anqing',0),(37,3,'蚌埠',3,'bangbu',0),(38,3,'巢湖',3,'chaohu',0),(39,3,'池州',3,'chizhou',0),(40,3,'滁州',3,'chuzhou',0),(41,3,'阜阳',3,'fuyang',0),(42,3,'淮北',3,'huaibei',0),(43,3,'淮南',3,'huainan',0),(44,3,'黄山',3,'huangshan',0),(45,3,'六安',3,'liuan',0),(46,3,'马鞍山',3,'maanshan',0),(47,3,'宿州',3,'suzhou',0),(48,3,'铜陵',3,'tongling',0),(49,3,'芜湖',3,'wuhu',0),(50,3,'宣城',3,'xuancheng',0),(51,3,'亳州',3,'zhou',0),(52,2,'北京',2,'beijing',1),(53,4,'福州',3,'fuzhou',0),(54,4,'龙岩',3,'longyan',0),(55,4,'南平',3,'nanping',0),(56,4,'宁德',3,'ningde',0),(57,4,'莆田',3,'putian',0),(58,4,'泉州',3,'quanzhou',0),(59,4,'三明',3,'sanming',0),(60,4,'厦门',3,'xiamen',0),(61,4,'漳州',3,'zhangzhou',0),(62,5,'兰州',3,'lanzhou',0),(63,5,'白银',3,'baiyin',0),(64,5,'定西',3,'dingxi',0),(65,5,'甘南',3,'gannan',0),(66,5,'嘉峪关',3,'jiayuguan',0),(67,5,'金昌',3,'jinchang',0),(68,5,'酒泉',3,'jiuquan',0),(69,5,'临夏',3,'linxia',0),(70,5,'陇南',3,'longnan',0),(71,5,'平凉',3,'pingliang',0),(72,5,'庆阳',3,'qingyang',0),(73,5,'天水',3,'tianshui',0),(74,5,'武威',3,'wuwei',0),(75,5,'张掖',3,'zhangye',0),(76,6,'广州',3,'guangzhou',0),(77,6,'深圳',3,'shen',0),(78,6,'潮州',3,'chaozhou',0),(79,6,'东莞',3,'dong',0),(80,6,'佛山',3,'foshan',0),(81,6,'河源',3,'heyuan',0),(82,6,'惠州',3,'huizhou',0),(83,6,'江门',3,'jiangmen',0),(84,6,'揭阳',3,'jieyang',0),(85,6,'茂名',3,'maoming',0),(86,6,'梅州',3,'meizhou',0),(87,6,'清远',3,'qingyuan',0),(88,6,'汕头',3,'shantou',0),(89,6,'汕尾',3,'shanwei',0),(90,6,'韶关',3,'shaoguan',0),(91,6,'阳江',3,'yangjiang',0),(92,6,'云浮',3,'yunfu',0),(93,6,'湛江',3,'zhanjiang',0),(94,6,'肇庆',3,'zhaoqing',0),(95,6,'中山',3,'zhongshan',0),(96,6,'珠海',3,'zhuhai',0),(97,7,'南宁',3,'nanning',0),(98,7,'桂林',3,'guilin',0),(99,7,'百色',3,'baise',0),(100,7,'北海',3,'beihai',0),(101,7,'崇左',3,'chongzuo',0),(102,7,'防城港',3,'fangchenggang',0),(103,7,'贵港',3,'guigang',0),(104,7,'河池',3,'hechi',0),(105,7,'贺州',3,'hezhou',0),(106,7,'来宾',3,'laibin',0),(107,7,'柳州',3,'liuzhou',0),(108,7,'钦州',3,'qinzhou',0),(109,7,'梧州',3,'wuzhou',0),(110,7,'玉林',3,'yulin',0),(111,8,'贵阳',3,'guiyang',0),(112,8,'安顺',3,'anshun',0),(113,8,'毕节',3,'bijie',0),(114,8,'六盘水',3,'liupanshui',0),(115,8,'黔东南',3,'qiandongnan',0),(116,8,'黔南',3,'qiannan',0),(117,8,'黔西南',3,'qianxinan',0),(118,8,'铜仁',3,'tongren',0),(119,8,'遵义',3,'zunyi',0),(120,9,'海口',3,'haikou',0),(121,9,'三亚',3,'sanya',0),(122,9,'白沙',3,'baisha',0),(123,9,'保亭',3,'baoting',0),(124,9,'昌江',3,'changjiang',0),(125,9,'澄迈县',3,'chengmaixian',0),(126,9,'定安县',3,'dinganxian',0),(127,9,'东方',3,'dongfang',0),(128,9,'乐东',3,'ledong',0),(129,9,'临高县',3,'lingaoxian',0),(130,9,'陵水',3,'lingshui',0),(131,9,'琼海',3,'qionghai',0),(132,9,'琼中',3,'qiongzhong',0),(133,9,'屯昌县',3,'tunchangxian',0),(134,9,'万宁',3,'wanning',0),(135,9,'文昌',3,'wenchang',0),(136,9,'五指山',3,'wuzhishan',0),(137,9,'儋州',3,'zhou',0),(138,10,'石家庄',3,'shijiazhuang',0),(139,10,'保定',3,'baoding',0),(140,10,'沧州',3,'cangzhou',0),(141,10,'承德',3,'chengde',0),(142,10,'邯郸',3,'handan',0),(143,10,'衡水',3,'hengshui',0),(144,10,'廊坊',3,'langfang',0),(145,10,'秦皇岛',3,'qinhuangdao',0),(146,10,'唐山',3,'tangshan',0),(147,10,'邢台',3,'xingtai',0),(148,10,'张家口',3,'zhangjiakou',0),(149,11,'郑州',3,'zhengzhou',0),(150,11,'洛阳',3,'luoyang',0),(151,11,'开封',3,'kaifeng',0),(152,11,'安阳',3,'anyang',0),(153,11,'鹤壁',3,'hebi',0),(154,11,'济源',3,'jiyuan',0),(155,11,'焦作',3,'jiaozuo',0),(156,11,'南阳',3,'nanyang',0),(157,11,'平顶山',3,'pingdingshan',0),(158,11,'三门峡',3,'sanmenxia',0),(159,11,'商丘',3,'shangqiu',0),(160,11,'新乡',3,'xinxiang',0),(161,11,'信阳',3,'xinyang',0),(162,11,'许昌',3,'xuchang',0),(163,11,'周口',3,'zhoukou',0),(164,11,'驻马店',3,'zhumadian',0),(165,11,'漯河',3,'he',0),(166,11,'濮阳',3,'yang',0),(167,12,'哈尔滨',3,'haerbin',0),(168,12,'大庆',3,'daqing',0),(169,12,'大兴安岭',3,'daxinganling',0),(170,12,'鹤岗',3,'hegang',0),(171,12,'黑河',3,'heihe',0),(172,12,'鸡西',3,'jixi',0),(173,12,'佳木斯',3,'jiamusi',0),(174,12,'牡丹江',3,'mudanjiang',0),(175,12,'七台河',3,'qitaihe',0),(176,12,'齐齐哈尔',3,'qiqihaer',0),(177,12,'双鸭山',3,'shuangyashan',0),(178,12,'绥化',3,'suihua',0),(179,12,'伊春',3,'yichun',0),(180,13,'武汉',3,'wuhan',0),(181,13,'仙桃',3,'xiantao',0),(182,13,'鄂州',3,'ezhou',0),(183,13,'黄冈',3,'huanggang',0),(184,13,'黄石',3,'huangshi',0),(185,13,'荆门',3,'jingmen',0),(186,13,'荆州',3,'jingzhou',0),(187,13,'潜江',3,'qianjiang',0),(188,13,'神农架林区',3,'shennongjialinqu',0),(189,13,'十堰',3,'shiyan',0),(190,13,'随州',3,'suizhou',0),(191,13,'天门',3,'tianmen',0),(192,13,'咸宁',3,'xianning',0),(193,13,'襄樊',3,'xiangfan',0),(194,13,'孝感',3,'xiaogan',0),(195,13,'宜昌',3,'yichang',0),(196,13,'恩施',3,'enshi',0),(197,14,'长沙',3,'changsha',0),(198,14,'张家界',3,'zhangjiajie',0),(199,14,'常德',3,'changde',0),(200,14,'郴州',3,'chenzhou',0),(201,14,'衡阳',3,'hengyang',0),(202,14,'怀化',3,'huaihua',0),(203,14,'娄底',3,'loudi',0),(204,14,'邵阳',3,'shaoyang',0),(205,14,'湘潭',3,'xiangtan',0),(206,14,'湘西',3,'xiangxi',0),(207,14,'益阳',3,'yiyang',0),(208,14,'永州',3,'yongzhou',0),(209,14,'岳阳',3,'yueyang',0),(210,14,'株洲',3,'zhuzhou',0),(211,15,'长春',3,'changchun',0),(212,15,'吉林',3,'jilin',0),(213,15,'白城',3,'baicheng',0),(214,15,'白山',3,'baishan',0),(215,15,'辽源',3,'liaoyuan',0),(216,15,'四平',3,'siping',0),(217,15,'松原',3,'songyuan',0),(218,15,'通化',3,'tonghua',0),(219,15,'延边',3,'yanbian',0),(220,16,'南京',3,'nanjing',0),(221,16,'苏州',3,'suzhou',0),(222,16,'无锡',3,'wuxi',0),(223,16,'常州',3,'changzhou',0),(224,16,'淮安',3,'huaian',0),(225,16,'连云港',3,'lianyungang',0),(226,16,'南通',3,'nantong',0),(227,16,'宿迁',3,'suqian',0),(228,16,'泰州',3,'taizhou',0),(229,16,'徐州',3,'xuzhou',0),(230,16,'盐城',3,'yancheng',0),(231,16,'扬州',3,'yangzhou',0),(232,16,'镇江',3,'zhenjiang',0),(233,17,'南昌',3,'nanchang',0),(234,17,'抚州',3,'fuzhou',0),(235,17,'赣州',3,'ganzhou',0),(236,17,'吉安',3,'jian',0),(237,17,'景德镇',3,'jingdezhen',0),(238,17,'九江',3,'jiujiang',0),(239,17,'萍乡',3,'pingxiang',0),(240,17,'上饶',3,'shangrao',0),(241,17,'新余',3,'xinyu',0),(242,17,'宜春',3,'yichun',0),(243,17,'鹰潭',3,'yingtan',0),(244,18,'沈阳',3,'shenyang',0),(245,18,'大连',3,'dalian',0),(246,18,'鞍山',3,'anshan',0),(247,18,'本溪',3,'benxi',0),(248,18,'朝阳',3,'chaoyang',0),(249,18,'丹东',3,'dandong',0),(250,18,'抚顺',3,'fushun',0),(251,18,'阜新',3,'fuxin',0),(252,18,'葫芦岛',3,'huludao',0),(253,18,'锦州',3,'jinzhou',0),(254,18,'辽阳',3,'liaoyang',0),(255,18,'盘锦',3,'panjin',0),(256,18,'铁岭',3,'tieling',0),(257,18,'营口',3,'yingkou',0),(258,19,'呼和浩特',3,'huhehaote',0),(259,19,'阿拉善盟',3,'alashanmeng',0),(260,19,'巴彦淖尔盟',3,'bayannaoermeng',0),(261,19,'包头',3,'baotou',0),(262,19,'赤峰',3,'chifeng',0),(263,19,'鄂尔多斯',3,'eerduosi',0),(264,19,'呼伦贝尔',3,'hulunbeier',0),(265,19,'通辽',3,'tongliao',0),(266,19,'乌海',3,'wuhai',0),(267,19,'乌兰察布市',3,'wulanchabushi',0),(268,19,'锡林郭勒盟',3,'xilinguolemeng',0),(269,19,'兴安盟',3,'xinganmeng',0),(270,20,'银川',3,'yinchuan',0),(271,20,'固原',3,'guyuan',0),(272,20,'石嘴山',3,'shizuishan',0),(273,20,'吴忠',3,'wuzhong',0),(274,20,'中卫',3,'zhongwei',0),(275,21,'西宁',3,'xining',0),(276,21,'果洛',3,'guoluo',0),(277,21,'海北',3,'haibei',0),(278,21,'海东',3,'haidong',0),(279,21,'海南',3,'hainan',0),(280,21,'海西',3,'haixi',0),(281,21,'黄南',3,'huangnan',0),(282,21,'玉树',3,'yushu',0),(283,22,'济南',3,'jinan',0),(284,22,'青岛',3,'qingdao',0),(285,22,'滨州',3,'binzhou',0),(286,22,'德州',3,'dezhou',0),(287,22,'东营',3,'dongying',0),(288,22,'菏泽',3,'heze',0),(289,22,'济宁',3,'jining',0),(290,22,'莱芜',3,'laiwu',0),(291,22,'聊城',3,'liaocheng',0),(292,22,'临沂',3,'linyi',0),(293,22,'日照',3,'rizhao',0),(294,22,'泰安',3,'taian',0),(295,22,'威海',3,'weihai',0),(296,22,'潍坊',3,'weifang',0),(297,22,'烟台',3,'yantai',0),(298,22,'枣庄',3,'zaozhuang',0),(299,22,'淄博',3,'zibo',0),(300,23,'太原',3,'taiyuan',0),(301,23,'长治',3,'changzhi',0),(302,23,'大同',3,'datong',0),(303,23,'晋城',3,'jincheng',0),(304,23,'晋中',3,'jinzhong',0),(305,23,'临汾',3,'linfen',0),(306,23,'吕梁',3,'lvliang',0),(307,23,'朔州',3,'shuozhou',0),(308,23,'忻州',3,'xinzhou',0),(309,23,'阳泉',3,'yangquan',0),(310,23,'运城',3,'yuncheng',0),(311,24,'西安',3,'xian',0),(312,24,'安康',3,'ankang',0),(313,24,'宝鸡',3,'baoji',0),(314,24,'汉中',3,'hanzhong',0),(315,24,'商洛',3,'shangluo',0),(316,24,'铜川',3,'tongchuan',0),(317,24,'渭南',3,'weinan',0),(318,24,'咸阳',3,'xianyang',0),(319,24,'延安',3,'yanan',0),(320,24,'榆林',3,'yulin',0),(321,25,'上海',2,'shanghai',0),(322,26,'成都',3,'chengdu',0),(323,26,'绵阳',3,'mianyang',0),(324,26,'阿坝',3,'aba',0),(325,26,'巴中',3,'bazhong',0),(326,26,'达州',3,'dazhou',0),(327,26,'德阳',3,'deyang',0),(328,26,'甘孜',3,'ganzi',0),(329,26,'广安',3,'guangan',0),(330,26,'广元',3,'guangyuan',0),(331,26,'乐山',3,'leshan',0),(332,26,'凉山',3,'liangshan',0),(333,26,'眉山',3,'meishan',0),(334,26,'南充',3,'nanchong',0),(335,26,'内江',3,'neijiang',0),(336,26,'攀枝花',3,'panzhihua',0),(337,26,'遂宁',3,'suining',0),(338,26,'雅安',3,'yaan',0),(339,26,'宜宾',3,'yibin',0),(340,26,'资阳',3,'ziyang',0),(341,26,'自贡',3,'zigong',0),(342,26,'泸州',3,'zhou',0),(343,27,'天津',2,'tianjin',0),(344,28,'拉萨',3,'lasa',0),(345,28,'阿里',3,'ali',0),(346,28,'昌都',3,'changdu',0),(347,28,'林芝',3,'linzhi',0),(348,28,'那曲',3,'naqu',0),(349,28,'日喀则',3,'rikaze',0),(350,28,'山南',3,'shannan',0),(351,29,'乌鲁木齐',3,'wulumuqi',0),(352,29,'阿克苏',3,'akesu',0),(353,29,'阿拉尔',3,'alaer',0),(354,29,'巴音郭楞',3,'bayinguoleng',0),(355,29,'博尔塔拉',3,'boertala',0),(356,29,'昌吉',3,'changji',0),(357,29,'哈密',3,'hami',0),(358,29,'和田',3,'hetian',0),(359,29,'喀什',3,'kashi',0),(360,29,'克拉玛依',3,'kelamayi',0),(361,29,'克孜勒苏',3,'kezilesu',0),(362,29,'石河子',3,'shihezi',0),(363,29,'图木舒克',3,'tumushuke',0),(364,29,'吐鲁番',3,'tulufan',0),(365,29,'五家渠',3,'wujiaqu',0),(366,29,'伊犁',3,'yili',0),(367,30,'昆明',3,'kunming',0),(368,30,'怒江',3,'nujiang',0),(369,30,'普洱',3,'puer',0),(370,30,'丽江',3,'lijiang',0),(371,30,'保山',3,'baoshan',0),(372,30,'楚雄',3,'chuxiong',0),(373,30,'大理',3,'dali',0),(374,30,'德宏',3,'dehong',0),(375,30,'迪庆',3,'diqing',0),(376,30,'红河',3,'honghe',0),(377,30,'临沧',3,'lincang',0),(378,30,'曲靖',3,'qujing',0),(379,30,'文山',3,'wenshan',0),(380,30,'西双版纳',3,'xishuangbanna',0),(381,30,'玉溪',3,'yuxi',0),(382,30,'昭通',3,'zhaotong',0),(383,31,'杭州',3,'hangzhou',0),(384,31,'湖州',3,'huzhou',0),(385,31,'嘉兴',3,'jiaxing',0),(386,31,'金华',3,'jinhua',0),(387,31,'丽水',3,'lishui',0),(388,31,'宁波',3,'ningbo',0),(389,31,'绍兴',3,'shaoxing',0),(390,31,'台州',3,'taizhou',0),(391,31,'温州',3,'wenzhou',0),(392,31,'舟山',3,'zhoushan',0),(393,31,'衢州',3,'zhou',0),(394,32,'重庆',2,'zhongqing',0),(395,33,'香港',2,'xianggang',0),(396,34,'澳门',2,'aomen',0),(397,35,'台湾',2,'taiwan',0),(500,52,'东城区',3,'dongchengqu',0),(501,52,'西城区',3,'xichengqu',0),(502,52,'海淀区',3,'haidianqu',0),(503,52,'朝阳区',3,'chaoyangqu',0),(504,52,'崇文区',3,'chongwenqu',0),(505,52,'宣武区',3,'xuanwuqu',0),(506,52,'丰台区',3,'fengtaiqu',0),(507,52,'石景山区',3,'shijingshanqu',0),(508,52,'房山区',3,'fangshanqu',0),(509,52,'门头沟区',3,'mentougouqu',0),(510,52,'通州区',3,'tongzhouqu',0),(511,52,'顺义区',3,'shunyiqu',0),(512,52,'昌平区',3,'changpingqu',0),(513,52,'怀柔区',3,'huairouqu',0),(514,52,'平谷区',3,'pingguqu',0),(515,52,'大兴区',3,'daxingqu',0),(516,52,'密云县',3,'miyunxian',0),(517,52,'延庆县',3,'yanqingxian',0),(2703,321,'长宁区',3,'changningqu',0),(2704,321,'闸北区',3,'zhabeiqu',0),(2705,321,'闵行区',3,'xingqu',0),(2706,321,'徐汇区',3,'xuhuiqu',0),(2707,321,'浦东新区',3,'pudongxinqu',0),(2708,321,'杨浦区',3,'yangpuqu',0),(2709,321,'普陀区',3,'putuoqu',0),(2710,321,'静安区',3,'jinganqu',0),(2711,321,'卢湾区',3,'luwanqu',0),(2712,321,'虹口区',3,'hongkouqu',0),(2713,321,'黄浦区',3,'huangpuqu',0),(2714,321,'南汇区',3,'nanhuiqu',0),(2715,321,'松江区',3,'songjiangqu',0),(2716,321,'嘉定区',3,'jiadingqu',0),(2717,321,'宝山区',3,'baoshanqu',0),(2718,321,'青浦区',3,'qingpuqu',0),(2719,321,'金山区',3,'jinshanqu',0),(2720,321,'奉贤区',3,'fengxianqu',0),(2721,321,'崇明县',3,'chongmingxian',0),(2912,343,'和平区',3,'hepingqu',0),(2913,343,'河西区',3,'hexiqu',0),(2914,343,'南开区',3,'nankaiqu',0),(2915,343,'河北区',3,'hebeiqu',0),(2916,343,'河东区',3,'hedongqu',0),(2917,343,'红桥区',3,'hongqiaoqu',0),(2918,343,'东丽区',3,'dongliqu',0),(2919,343,'津南区',3,'jinnanqu',0),(2920,343,'西青区',3,'xiqingqu',0),(2921,343,'北辰区',3,'beichenqu',0),(2922,343,'塘沽区',3,'tangguqu',0),(2923,343,'汉沽区',3,'hanguqu',0),(2924,343,'大港区',3,'dagangqu',0),(2925,343,'武清区',3,'wuqingqu',0),(2926,343,'宝坻区',3,'baoqu',0),(2927,343,'经济开发区',3,'jingjikaifaqu',0),(2928,343,'宁河县',3,'ninghexian',0),(2929,343,'静海县',3,'jinghaixian',0),(2930,343,'蓟县',3,'jixian',0),(3325,394,'合川区',3,'hechuanqu',0),(3326,394,'江津区',3,'jiangjinqu',0),(3327,394,'南川区',3,'nanchuanqu',0),(3328,394,'永川区',3,'yongchuanqu',0),(3329,394,'南岸区',3,'nananqu',0),(3330,394,'渝北区',3,'yubeiqu',0),(3331,394,'万盛区',3,'wanshengqu',0),(3332,394,'大渡口区',3,'dadukouqu',0),(3333,394,'万州区',3,'wanzhouqu',0),(3334,394,'北碚区',3,'beiqu',0),(3335,394,'沙坪坝区',3,'shapingbaqu',0),(3336,394,'巴南区',3,'bananqu',0),(3337,394,'涪陵区',3,'fulingqu',0),(3338,394,'江北区',3,'jiangbeiqu',0),(3339,394,'九龙坡区',3,'jiulongpoqu',0),(3340,394,'渝中区',3,'yuzhongqu',0),(3341,394,'黔江开发区',3,'qianjiangkaifaqu',0),(3342,394,'长寿区',3,'changshouqu',0),(3343,394,'双桥区',3,'shuangqiaoqu',0),(3344,394,'綦江县',3,'jiangxian',0),(3345,394,'潼南县',3,'nanxian',0),(3346,394,'铜梁县',3,'tongliangxian',0),(3347,394,'大足县',3,'dazuxian',0),(3348,394,'荣昌县',3,'rongchangxian',0),(3349,394,'璧山县',3,'shanxian',0),(3350,394,'垫江县',3,'dianjiangxian',0),(3351,394,'武隆县',3,'wulongxian',0),(3352,394,'丰都县',3,'fengduxian',0),(3353,394,'城口县',3,'chengkouxian',0),(3354,394,'梁平县',3,'liangpingxian',0),(3355,394,'开县',3,'kaixian',0),(3356,394,'巫溪县',3,'wuxixian',0),(3357,394,'巫山县',3,'wushanxian',0),(3358,394,'奉节县',3,'fengjiexian',0),(3359,394,'云阳县',3,'yunyangxian',0),(3360,394,'忠县',3,'zhongxian',0),(3361,394,'石柱',3,'shizhu',0),(3362,394,'彭水',3,'pengshui',0),(3363,394,'酉阳',3,'youyang',0),(3364,394,'秀山',3,'xiushan',0),(3365,395,'沙田区',3,'shatianqu',0),(3366,395,'东区',3,'dongqu',0),(3367,395,'观塘区',3,'guantangqu',0),(3368,395,'黄大仙区',3,'huangdaxianqu',0),(3369,395,'九龙城区',3,'jiulongchengqu',0),(3370,395,'屯门区',3,'tunmenqu',0),(3371,395,'葵青区',3,'kuiqingqu',0),(3372,395,'元朗区',3,'yuanlangqu',0),(3373,395,'深水埗区',3,'shenshui',0),(3374,395,'西贡区',3,'xigongqu',0),(3375,395,'大埔区',3,'dapuqu',0),(3376,395,'湾仔区',3,'wanziqu',0),(3377,395,'油尖旺区',3,'youjianwangqu',0),(3378,395,'北区',3,'beiqu',0),(3379,395,'南区',3,'nanqu',0),(3380,395,'荃湾区',3,'wanqu',0),(3381,395,'中西区',3,'zhongxiqu',0),(3382,395,'离岛区',3,'lidaoqu',0),(3383,396,'澳门',3,'aomen',0),(3384,397,'台北',3,'taibei',0),(3385,397,'高雄',3,'gaoxiong',0),(3386,397,'基隆',3,'jilong',0),(3387,397,'台中',3,'taizhong',0),(3388,397,'台南',3,'tainan',0),(3389,397,'新竹',3,'xinzhu',0),(3390,397,'嘉义',3,'jiayi',0),(3391,397,'宜兰县',3,'yilanxian',0),(3392,397,'桃园县',3,'taoyuanxian',0),(3393,397,'苗栗县',3,'miaolixian',0),(3394,397,'彰化县',3,'zhanghuaxian',0),(3395,397,'南投县',3,'nantouxian',0),(3396,397,'云林县',3,'yunlinxian',0),(3397,397,'屏东县',3,'pingdongxian',0),(3398,397,'台东县',3,'taidongxian',0),(3399,397,'花莲县',3,'hualianxian',0),(3400,397,'澎湖县',3,'penghuxian',0),(1,0,'全国',1,'quanguo',0);
/*!40000 ALTER TABLE `fanwe_region_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_role`
--

DROP TABLE IF EXISTS `fanwe_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_role`
--

LOCK TABLES `fanwe_role` WRITE;
/*!40000 ALTER TABLE `fanwe_role` DISABLE KEYS */;
INSERT INTO `fanwe_role` VALUES (4,'管理员',1,0),(5,'信息发布',1,1),(6,'大王',1,0);
/*!40000 ALTER TABLE `fanwe_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_role_access`
--

DROP TABLE IF EXISTS `fanwe_role_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_role_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `node_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_role_access`
--

LOCK TABLES `fanwe_role_access` WRITE;
/*!40000 ALTER TABLE `fanwe_role_access` DISABLE KEYS */;
INSERT INTO `fanwe_role_access` VALUES (87,5,0,133),(88,5,0,134),(89,5,0,92),(90,5,0,118),(91,5,0,117),(92,5,0,124),(93,5,0,132),(94,5,0,123),(95,5,0,127),(96,5,0,128),(97,6,0,6),(98,6,0,133),(99,6,0,134),(100,6,0,92),(101,6,0,118),(102,6,0,117),(103,6,0,124),(104,6,0,47),(105,6,0,144),(106,6,0,145),(107,6,0,114),(108,6,0,119),(109,6,0,125),(110,6,0,127),(111,6,0,128),(112,6,0,142),(113,6,0,135),(114,6,0,5),(115,6,0,113),(116,6,0,137),(117,6,0,131),(118,6,0,139);
/*!40000 ALTER TABLE `fanwe_role_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_role_group`
--

DROP TABLE IF EXISTS `fanwe_role_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_role_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `nav_id` int(11) NOT NULL COMMENT '后台导航分组ID',
  `is_delete` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_role_group`
--

LOCK TABLES `fanwe_role_group` WRITE;
/*!40000 ALTER TABLE `fanwe_role_group` DISABLE KEYS */;
INSERT INTO `fanwe_role_group` VALUES (1,'首页',1,0,1,1),(5,'系统设置',3,0,1,1),(7,'管理员',3,0,1,2),(8,'数据库操作',3,0,1,6),(9,'系统日志',3,0,1,7),(19,'菜单设置',11,0,1,17),(28,'邮件管理',10,0,1,26),(29,'短信管理',10,0,1,27),(31,'广告设置',11,0,1,29),(33,'队列管理',10,0,1,31),(69,'会员管理',5,0,1,31),(70,'会员整合',5,0,1,32),(71,'同步登录',5,0,1,33),(72,'项目管理',13,0,1,33),(73,'项目支持',13,0,1,34),(74,'项目点评',13,0,1,35),(75,'支付接口',14,0,1,1),(76,'付款记录',14,0,1,2),(77,'消息模板',10,0,1,1),(78,'提现记录',14,0,1,3),(79,'友情链接',11,0,1,36),(80,'文章管理',11,0,1,37),(81,'文章分类管理',11,0,1,38),(82,'地区管理',13,0,1,39),(83,'系统监测',3,0,1,83),(62,'手机端设置',3,0,1,1),(84,'问卷调查设置',11,0,1,84),(85,'会员邀请',5,0,1,31),(86,'回报项目统计',15,0,1,86),(87,'股权项目统计',15,0,1,87),(88,'平台统计',15,0,1,88),(89,'留言列表',5,0,1,89);
/*!40000 ALTER TABLE `fanwe_role_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_role_module`
--

DROP TABLE IF EXISTS `fanwe_role_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_role_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_role_module`
--

LOCK TABLES `fanwe_role_module` WRITE;
/*!40000 ALTER TABLE `fanwe_role_module` DISABLE KEYS */;
INSERT INTO `fanwe_role_module` VALUES (5,'Role','权限组别',1,0),(6,'Admin','管理员',1,0),(12,'Conf','系统配置',1,0),(13,'Database','数据库',1,0),(15,'Log','系统日志',1,0),(19,'File','文件管理',1,0),(58,'Index','首页',1,0),(36,'Nav','导航菜单',1,0),(47,'MailServer','邮件服务器',1,0),(48,'Sms','短信接口',1,0),(53,'Adv','广告模块',1,0),(56,'DealMsgList','业务群发队列',1,0),(92,'Cache','缓存处理',1,0),(113,'User','会员管理',1,0),(114,'MsgTemplate','消息模板管理',1,0),(115,'Integrate','会员整合',1,0),(116,'ApiLogin','同步登录',1,0),(117,'DealCate','项目分类',1,0),(118,'Deal','项目管理',1,0),(119,'Payment','支付接口',1,0),(120,'IndexImage','轮播广告图',1,0),(121,'Help','站点帮助',1,0),(122,'Faq','常见问题',1,0),(123,'DealOrder','项目支持',1,0),(124,'DealComment','项目点评',1,0),(125,'PaymentNotice','付款记录',1,0),(126,'UserRefund','用户提现',1,0),(127,'PromoteMsg','推广模块',1,0),(128,'PromoteMsgList','推广队列',1,0),(129,'Link','友情链接',1,0),(130,'LinkGroup','友情链接分组',1,0),(131,'UserLevel','会员等级',1,0),(132,'DealLevel','项目等级',0,0),(133,'Article','文章',1,0),(134,'ArticleCate','文章分类',1,0),(135,'RegionConf','地区',1,0),(136,'SqlCheck','系统监测',1,0),(93,'MAdv','手机端广告',1,0),(137,'UserInvestor','投资人申请管理',1,0),(138,'Bank','提现银行设置',1,0),(139,'Vote','问卷调查',1,0),(141,'Collocation','资金托管',1,0),(140,'UserCarry','提现手续费',1,0),(142,'Referrals','会员邀请',1,0),(143,'Statistics','统计',1,0),(144,'Message','留言列表',1,0),(145,'MessageCate','留言分类列表',1,0);
/*!40000 ALTER TABLE `fanwe_role_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_role_nav`
--

DROP TABLE IF EXISTS `fanwe_role_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_role_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_role_nav`
--

LOCK TABLES `fanwe_role_nav` WRITE;
/*!40000 ALTER TABLE `fanwe_role_nav` DISABLE KEYS */;
INSERT INTO `fanwe_role_nav` VALUES (1,'首页',0,1,1),(3,'系统设置',0,1,10),(5,'会员管理',0,1,3),(10,'短信邮件',0,1,7),(13,'项目管理',0,1,4),(14,'支付管理',0,1,5),(11,'前端设置',0,1,6),(15,'统计模块',0,1,8);
/*!40000 ALTER TABLE `fanwe_role_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_role_node`
--

DROP TABLE IF EXISTS `fanwe_role_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_role_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `group_id` int(11) NOT NULL COMMENT '后台分组菜单分组ID',
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6888 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_role_node`
--

LOCK TABLES `fanwe_role_node` WRITE;
/*!40000 ALTER TABLE `fanwe_role_node` DISABLE KEYS */;
INSERT INTO `fanwe_role_node` VALUES (334,'main','首页',1,0,1,58),(11,'index','管理员分组列表',1,0,7,5),(13,'trash','管理员分组回收站',1,0,7,5),(14,'index','管理员列表',1,0,7,6),(15,'trash','管理员回收站',1,0,7,6),(16,'index','系统配置',1,0,5,12),(17,'index','数据库备份列表',1,0,8,13),(18,'sql','SQL操作',1,0,8,13),(19,'index','系统日志列表',1,0,9,15),(24,'do_upload','编辑器图片上传',1,0,0,19),(43,'index','导航菜单列表',1,0,19,36),(57,'index','邮件服务器列表',1,0,28,47),(58,'index','短信接口列表',1,0,29,48),(63,'index','广告列表',1,0,31,53),(66,'index','业务队列列表',1,0,33,56),(68,'add','添加页面',1,0,0,6),(69,'edit','编辑页面',1,0,0,6),(70,'set_effect','设置生效',1,0,0,6),(71,'add','添加执行',1,0,0,6),(72,'update','编辑执行',1,0,0,6),(73,'delete','删除',1,0,0,6),(74,'restore','恢复',1,0,0,6),(75,'foreverdelete','永久删除',1,0,0,6),(76,'set_default','设置默认管理员',1,0,0,6),(77,'add','添加页面',1,0,0,53),(78,'edit','编辑页面',1,0,0,53),(79,'update','编辑执行',1,0,0,53),(80,'foreverdelete','永久删除',1,0,0,53),(81,'set_effect','设置生效',1,0,0,53),(99,'update','更新配置',1,0,0,12),(100,'dump','备份数据',1,0,0,13),(101,'delete','删除备份',1,0,0,13),(102,'restore','恢复备份',1,0,0,13),(103,'load_file','读取页面',1,0,0,53),(104,'load_adv_id','读取广告位',1,0,0,53),(105,'execute','执行SQL语句',1,0,0,13),(147,'show_content','显示内容',1,0,0,56),(148,'send','手动发送',1,0,0,56),(149,'foreverdelete','永久删除',1,0,0,56),(181,'do_upload_img','图片控件上传',1,0,0,19),(182,'deleteImg','删除图片',1,0,0,19),(198,'foreverdelete','永久删除',1,0,0,15),(205,'add','添加页面',1,0,0,47),(206,'insert','添加执行',1,0,0,47),(207,'edit','编辑页面',1,0,0,47),(208,'update','编辑执行',1,0,0,47),(209,'set_effect','设置生效',1,0,0,47),(210,'foreverdelete','永久删除',1,0,0,47),(211,'send_demo','发送测试邮件',1,0,0,47),(229,'edit','编辑页面',1,0,0,36),(230,'update','编辑执行',1,0,0,36),(231,'set_effect','设置生效',1,0,0,36),(232,'set_sort','排序',1,0,0,36),(257,'add','添加页面',1,0,0,5),(258,'insert','添加执行',1,0,0,5),(259,'edit','编辑页面',1,0,0,5),(260,'update','编辑执行',1,0,0,5),(261,'set_effect','设置生效',1,0,0,5),(262,'delete','删除',1,0,0,5),(263,'restore','恢复',1,0,0,5),(264,'foreverdelete','永久删除',1,0,0,5),(265,'insert','安装页面',1,0,0,48),(266,'insert','安装保存',1,0,0,48),(267,'edit','编辑页面',1,0,0,48),(268,'update','编辑执行',1,0,0,48),(269,'uninstall','卸载',1,0,0,48),(270,'set_effect','设置生效',1,0,0,48),(271,'send_demo','发送测试短信',1,0,0,48),(474,'index','缓存处理',1,0,0,92),(475,'clear_parse_file','清空脚本样式缓存',1,0,0,92),(477,'clear_data','清空数据缓存',1,0,0,92),(480,'syn_data','同步数据',1,0,0,92),(481,'clear_image','清空图片缓存',1,0,0,92),(482,'clear_admin','清空后台缓存',1,0,0,92),(605,'index','消息模板',1,0,77,114),(606,'update','更新模板',1,0,0,114),(607,'index','会员列表',1,0,69,113),(608,'add','添加会员',1,0,0,113),(609,'insert','添提执行',1,0,0,113),(610,'edit','编辑会员',1,0,0,113),(611,'update','编辑执行',1,0,0,113),(612,'delete','删除会员',1,0,0,113),(613,'modify_account','会员资金变更',1,0,0,113),(614,'account_detail','帐户日志',1,0,0,113),(615,'foreverdelete_account_detail','删除帐户日志',1,0,0,113),(616,'consignee','配送地址',1,0,0,113),(617,'foreverdelete_consignee','删除配送地址',1,0,0,113),(618,'weibo','微博列表',1,0,0,113),(619,'foreverdelete_weibo','删除微博',1,0,0,113),(620,'index','会员整合',1,0,70,115),(621,'save','执行整合',1,0,0,115),(622,'uninstall','卸载整合',1,0,0,115),(623,'index','同步登录接口',1,0,71,116),(624,'insert','安装接口',1,0,0,116),(625,'update','更新配置',1,0,0,116),(626,'uninstall','卸载接口',1,0,0,116),(627,'index','分类列表',1,0,72,117),(628,'insert','添加分类',1,0,0,117),(629,'update','更新分类',1,0,0,117),(630,'foreverdelete','删除分类',1,0,0,117),(631,'online_index','上线项目列表',1,0,72,118),(632,'submit_index','未审核项目',1,0,72,118),(633,'index','支付接口列表',1,0,75,119),(634,'insert','安装支付接口',1,0,0,119),(635,'update','更新支付接口',1,0,0,119),(636,'uninstall','卸载接口',1,0,0,119),(637,'index','轮播广告设置',1,0,5,120),(638,'insert','添加广告',1,0,0,120),(639,'update','修改广告',1,0,0,120),(640,'foreverdelete','删除广告',1,0,0,120),(641,'delete_index','回收站',1,0,72,118),(642,'index','帮助列表',1,0,5,121),(643,'insert','添加帮助',1,0,0,121),(644,'update','修改帮助',1,0,0,121),(645,'foreverdelete','删除帮助',1,0,0,121),(646,'index','常见问题',1,0,5,122),(647,'insert','添加问题',1,0,0,122),(648,'update','更新问题',1,0,0,122),(649,'foreverdelete','删除问题',1,0,0,122),(650,'pay_log','筹款发放',1,0,0,118),(651,'save_pay_log','发放',1,0,0,118),(652,'del_pay_log','删除发放',1,0,0,118),(653,'deal_log','项目日志',1,0,0,118),(654,'del_deal_log','删除日志',1,0,0,118),(655,'batch_refund','批量退款',1,0,0,118),(656,'index','项目支持',1,0,73,123),(657,'view','查看详情',1,0,0,123),(658,'refund','项目退款',1,0,0,123),(659,'delete','删除支持',1,0,0,123),(660,'incharge','项目收款',1,0,0,123),(661,'index','项目点评',1,0,74,124),(662,'index','付款记录',1,0,76,125),(663,'delete','删除记录',1,0,0,125),(664,'index','提现记录',1,0,78,126),(665,'delete','删除记录',1,0,0,126),(666,'confirm','确认提现',1,0,0,126),(667,'mail_index','邮件列表',1,0,28,127),(668,'sms_index','短信列表',1,0,29,127),(669,'insert_mail','新增邮件',1,0,0,127),(670,'insert_sms','新增短信',1,0,0,127),(671,'update_mail','更新邮件',1,0,0,127),(672,'update_sms','更新短信',1,0,0,127),(673,'foreverdelete','删除',1,0,0,127),(674,'index','推广队列列表',1,0,33,128),(675,'send','发送',1,0,0,128),(676,'foreverdelete','删除',1,0,0,128),(677,'index','友情链接列表',1,0,79,129),(678,'insert','添加链接',1,0,0,129),(679,'update','更新链接',1,0,0,129),(680,'index','友情链接分组列表',1,0,79,130),(681,'index','会员等级',1,0,69,131),(682,'index','项目等级',0,0,72,132),(684,'index','文章列表',1,0,80,133),(685,'trash','文章回收站',1,0,80,133),(686,'index','文章分类列表',1,0,81,134),(687,'trash','文章分类回收站',1,0,81,134),(688,'index','地区列表',1,0,82,135),(689,'index','系统监测列表',1,0,83,136),(483,'mobile','手机端配置',1,0,62,12),(484,'index','手机端广告列表',1,0,62,93),(485,'savemobile','保存手机端配置',1,0,0,12),(6867,'index','投资申请列表',1,0,69,137),(6868,'index','提现银行设置',1,0,5,138),(6869,'index','问卷调查列表',1,0,84,139),(6871,'index','资金托管',1,0,75,141),(692,'index','会员银行列表',1,0,0,139),(693,'edit','编辑页面',1,0,0,139),(694,'update','编辑执行',1,0,0,139),(695,'add','增加页面',1,0,0,139),(696,'insert','增加执行',1,0,0,139),(697,'delete','删除',1,0,0,139),(6870,'config','提现手续费',1,0,5,140),(698,'sharefee_list','查看分红列表',1,0,0,118),(700,'referrals_count','会员邀请统计',1,0,85,142),(701,'index','会员邀请返利列表',1,0,85,142),(6872,'project','项目统计',1,0,86,143),(6874,'usernum_total','人数统计',1,0,86,143),(6875,'investe_total','项目统计',1,0,87,143),(6876,'money_total','金额统计',1,0,86,143),(6877,'hasback_total','回报统计',1,0,86,143),(6878,'overdue_total','逾期统计',1,0,86,143),(6879,'investors_total','投资人统计',1,0,87,143),(6880,'financing_amount_total','融资金额',1,0,87,143),(6881,'breach_convention_total','违约统计',1,0,87,143),(6882,'money_inchange_total','充值统计',1,0,88,143),(6883,'money_carry_bank_total','提现统计',1,0,88,143),(6884,'user_total','用户统计',1,0,88,143),(6885,'site_costs_total','网站费用统计',1,0,88,143),(6886,'index','留言分类列表',1,0,89,145),(6887,'index','留言列表',1,0,89,144);
/*!40000 ALTER TABLE `fanwe_role_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_sms`
--

DROP TABLE IF EXISTS `fanwe_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `server_url` text NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `config` text NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_sms`
--

LOCK TABLES `fanwe_sms` WRITE;
/*!40000 ALTER TABLE `fanwe_sms` DISABLE KEYS */;
INSERT INTO `fanwe_sms` VALUES (10,'短信宝增值平台 (<a href=\'http://www.smsbao.com/reg?r=5001\' target=\'_blank\'><font color=\'red\'>还没账号？点击这免费注册</font></a>)','123','smsbao','http://www.smsbao.com/sms','go_across','123','N;',0),(11,'云信留客','云信留客短信接口','winnerlook','http://h.1069106.com:1210','ZCCF','ZCCF2015','N;',1),(12,'方维短信平台','','FW','http://sms.fanwe.com/','ZCCF','ZCCF2015','N;',0);
/*!40000 ALTER TABLE `fanwe_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_sql_check`
--

DROP TABLE IF EXISTS `fanwe_sql_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_sql_check` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `module_action` varchar(255) NOT NULL,
  `para` varchar(255) NOT NULL COMMENT '参数',
  `module_action_para` varchar(255) NOT NULL,
  `sql_num` int(11) NOT NULL,
  `sql_str` text NOT NULL,
  `query_time` float(11,6) NOT NULL DEFAULT '0.000000' COMMENT 'SQL运行时间',
  `run_time` float(11,6) NOT NULL DEFAULT '0.000000' COMMENT '运行时间',
  `memory_usage` float(11,4) NOT NULL DEFAULT '0.0000' COMMENT '内存占用情况',
  `gzip_on` tinyint(1) NOT NULL COMMENT '是否开启gzip_on',
  `url` varchar(255) NOT NULL COMMENT '请求地址',
  `file_name` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=279264 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_sql_check`
--

LOCK TABLES `fanwe_sql_check` WRITE;
/*!40000 ALTER TABLE `fanwe_sql_check` DISABLE KEYS */;
INSERT INTO `fanwe_sql_check` VALUES (279256,'deals','index','deals-index','type-id','deals-index-type-id',11,'a:12:{i:0;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439763943 - create_time > 259200\";i:1;s:38:\"select count(*) from fanwe_deal_notify\";i:2;s:52:\"select * from  fanwe_link_group where is_effect = 1 \";i:3;s:100:\"select * from fanwe_link where is_effect = 1 and show_index = 1 and group_id = 14 order by sort desc\";i:4;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:5;s:98:\"select province from fanwe_deal where type=1 and is_effect =1 group by province  order by sort asc\";i:6;s:152:\"select rc.* from fanwe_region_conf as rc where rc.name in (select province from fanwe_deal) or  rc.name in (select city from fanwe_deal) or rc.is_hot=1 \";i:7;s:167:\"select count(*)  from fanwe_deal as d  where  1=1 AND d.is_delete = 0 AND d.is_effect = 1  AND  d.is_delete = 0 and d.is_effect = 1  and d.cate_id in (8) and d.type=1 \";i:8;s:31:\"select * from fanwe_deal_level \";i:9;s:85:\"select * from fanwe_adv where tmpl=\'fanwe_1\' and adv_id=\'deals_top\' and is_effect = 1\";i:10;s:88:\"select * from fanwe_adv where tmpl=\'fanwe_1\' and adv_id=\'deals_bottom\' and is_effect = 1\";i:11;s:100:\"select sql_num from fanwe_sql_check where module_action_para=\'deals-index-type-id\' order by id desc \";}',0.010474,0.104115,5.3500,1,'http://ext4.ihancc.com/deals/id-8-type-1.html','index.php',1439763943),(279257,'settings','index','settings-index','','settings-index',7,'a:8:{i:0;s:56:\"select * from fanwe_user where id = 20 and is_effect = 1\";i:1;s:45:\"select level from fanwe_user_level where id=0\";i:2;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439764327 - create_time > 259200\";i:3;s:38:\"select count(*) from fanwe_deal_notify\";i:4;s:35:\"select code,val from fanwe_m_config\";i:5;s:47:\"select * from fanwe_deal_cate order by sort asc\";i:6;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:7;s:95:\"select sql_num from fanwe_sql_check where module_action_para=\'settings-index\' order by id desc \";}',0.002194,0.064038,4.4900,1,'http://ext4.ihancc.com/wap/index.php?ctl=settings','index.php',1439764327),(279258,'settings','modify','settings-modify','','settings-modify',10,'a:11:{i:0;s:56:\"select * from fanwe_user where id = 20 and is_effect = 1\";i:1;s:45:\"select level from fanwe_user_level where id=0\";i:2;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439764331 - create_time > 259200\";i:3;s:38:\"select count(*) from fanwe_deal_notify\";i:4;s:35:\"select code,val from fanwe_m_config\";i:5;s:47:\"select * from fanwe_deal_cate order by sort asc\";i:6;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:7;s:70:\"select * from fanwe_region_conf where region_level = 2 order by py asc\";i:8;s:62:\"select * from fanwe_region_conf where pid = 11 order by py asc\";i:9;s:49:\"select * from fanwe_user_weibo where user_id = 20\";i:10;s:96:\"select sql_num from fanwe_sql_check where module_action_para=\'settings-modify\' order by id desc \";}',0.002683,0.104287,4.6800,1,'http://ext4.ihancc.com/wap/index.php?ctl=settings&act=modify','index.php',1439764331),(279259,'settings','consignee','settings-consignee','','settings-consignee',8,'a:9:{i:0;s:56:\"select * from fanwe_user where id = 20 and is_effect = 1\";i:1;s:45:\"select level from fanwe_user_level where id=0\";i:2;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439764334 - create_time > 259200\";i:3;s:38:\"select count(*) from fanwe_deal_notify\";i:4;s:35:\"select code,val from fanwe_m_config\";i:5;s:47:\"select * from fanwe_deal_cate order by sort asc\";i:6;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:7;s:53:\"select * from fanwe_user_consignee where user_id = 20\";i:8;s:99:\"select sql_num from fanwe_sql_check where module_action_para=\'settings-consignee\' order by id desc \";}',0.002417,0.047022,4.4600,1,'http://ext4.ihancc.com/wap/index.php?ctl=settings&act=consignee','index.php',1439764334),(279260,'settings','add_consignee','settings-add_consignee','','settings-add_consignee',8,'a:9:{i:0;s:56:\"select * from fanwe_user where id = 20 and is_effect = 1\";i:1;s:45:\"select level from fanwe_user_level where id=0\";i:2;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439764336 - create_time > 259200\";i:3;s:38:\"select count(*) from fanwe_deal_notify\";i:4;s:35:\"select code,val from fanwe_m_config\";i:5;s:47:\"select * from fanwe_deal_cate order by sort asc\";i:6;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:7;s:70:\"select * from fanwe_region_conf where region_level = 2 order by py asc\";i:8;s:103:\"select sql_num from fanwe_sql_check where module_action_para=\'settings-add_consignee\' order by id desc \";}',0.002070,0.048058,4.5000,1,'http://ext4.ihancc.com/wap/index.php?ctl=settings&act=add_consignee','index.php',1439764336),(279261,'settings','add_consignee','settings-add_consignee','id','settings-add_consignee-id',10,'a:11:{i:0;s:56:\"select * from fanwe_user where id = 20 and is_effect = 1\";i:1;s:45:\"select level from fanwe_user_level where id=0\";i:2;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439764358 - create_time > 259200\";i:3;s:38:\"select count(*) from fanwe_deal_notify\";i:4;s:35:\"select code,val from fanwe_m_config\";i:5;s:47:\"select * from fanwe_deal_cate order by sort asc\";i:6;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:7;s:65:\"select * from fanwe_user_consignee where id = 38 and user_id = 20\";i:8;s:70:\"select * from fanwe_region_conf where region_level = 2 order by py asc\";i:9;s:63:\"select * from fanwe_region_conf where pid = 396 order by py asc\";i:10;s:106:\"select sql_num from fanwe_sql_check where module_action_para=\'settings-add_consignee-id\' order by id desc \";}',0.002717,0.048017,4.5000,1,'http://ext4.ihancc.com/wap/index.php?ctl=settings&act=add_consignee&id=38','index.php',1439764358),(279262,'account','point','account-point','','account-point',9,'a:10:{i:0;s:56:\"select * from fanwe_user where id = 20 and is_effect = 1\";i:1;s:45:\"select level from fanwe_user_level where id=0\";i:2;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439764438 - create_time > 259200\";i:3;s:38:\"select count(*) from fanwe_deal_notify\";i:4;s:35:\"select code,val from fanwe_m_config\";i:5;s:47:\"select * from fanwe_deal_cate order by sort asc\";i:6;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:7;s:104:\"select * from fanwe_user_log where user_id = 20 and point <>0  order by log_time desc,id desc limit 0,10\";i:8;s:68:\"select count(*) from fanwe_user_log where user_id = 20 and point <>0\";i:9;s:94:\"select sql_num from fanwe_sql_check where module_action_para=\'account-point\' order by id desc \";}',0.002093,0.054553,4.9100,1,'http://ext4.ihancc.com/wap/index.php?ctl=account&act=point','index.php',1439764438),(279263,'user','login','user-login','','user-login',5,'a:6:{i:0;s:109:\"delete from fanwe_deal_order where order_status = 0 and credit_pay = 0 and  1439764438 - create_time > 259200\";i:1;s:38:\"select count(*) from fanwe_deal_notify\";i:2;s:35:\"select code,val from fanwe_m_config\";i:3;s:47:\"select * from fanwe_deal_cate order by sort asc\";i:4;s:51:\"select * from  fanwe_collocation where is_effect=1 \";i:5;s:91:\"select sql_num from fanwe_sql_check where module_action_para=\'user-login\' order by id desc \";}',0.001040,0.045119,4.3600,1,'http://ext4.ihancc.com/wap/index.php?ctl=user&act=login','index.php',1439764438);
/*!40000 ALTER TABLE `fanwe_sql_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user`
--

DROP TABLE IF EXISTS `fanwe_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_pwd` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `money` decimal(20,2) NOT NULL COMMENT '金额',
  `login_time` int(11) NOT NULL,
  `login_ip` varchar(50) NOT NULL,
  `province` varchar(10) NOT NULL,
  `city` varchar(10) NOT NULL,
  `password_verify` varchar(255) NOT NULL COMMENT '找回密码的验证号',
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `build_count` int(11) NOT NULL COMMENT '发起的项目数',
  `support_count` int(11) NOT NULL COMMENT '支持的项目数',
  `focus_count` int(11) NOT NULL COMMENT '关注的项目数',
  `integrate_id` int(11) NOT NULL,
  `intro` text NOT NULL COMMENT '个人简介',
  `ex_real_name` varchar(255) NOT NULL COMMENT '发布者真实姓名',
  `ex_account_bank` text NOT NULL,
  `ex_account_info` text NOT NULL COMMENT '银行帐号等信息',
  `ex_contact` text NOT NULL COMMENT '联系方式',
  `ex_qq` text NOT NULL,
  `code` varchar(255) NOT NULL,
  `sina_id` varchar(255) NOT NULL,
  `sina_token` varchar(255) NOT NULL,
  `sina_secret` varchar(255) NOT NULL,
  `sina_url` varchar(255) NOT NULL,
  `tencent_id` varchar(255) NOT NULL,
  `tencent_token` varchar(255) NOT NULL,
  `tencent_secret` varchar(255) NOT NULL,
  `tencent_url` varchar(255) NOT NULL,
  `verify` varchar(255) NOT NULL,
  `user_level` int(11) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `user_type` int(11) NOT NULL,
  `is_has_send_success` tinyint(1) NOT NULL,
  `is_bank` tinyint(1) NOT NULL COMMENT '（0表示银行账户信息未提交，1表示银行账户信息提交）',
  `verify_time` int(11) DEFAULT NULL COMMENT '验证发送时间',
  `verify_setting` varchar(255) DEFAULT NULL COMMENT '设置时候的验证码',
  `verify_setting_time` int(11) NOT NULL COMMENT '设置时间',
  `identify_name` varchar(255) NOT NULL COMMENT '身份证名称',
  `identify_number` varchar(255) NOT NULL COMMENT '身份证号码',
  `identify_positive_image` varchar(255) NOT NULL COMMENT '身份证正面',
  `identify_nagative_image` varchar(255) NOT NULL COMMENT '身份证反面',
  `identify_business_licence` varchar(255) NOT NULL COMMENT '营业执照',
  `identify_business_code` varchar(255) NOT NULL COMMENT '组织机构代码证',
  `identify_business_tax` varchar(255) NOT NULL COMMENT '税务登记证',
  `identify_business_name` varchar(255) NOT NULL COMMENT '机构名称',
  `is_investor` tinyint(1) NOT NULL DEFAULT '0' COMMENT '判断是否为投资者，默认0表示非投资者，1表示投资者,2 表示机构投资者',
  `mortgage_money` decimal(20,2) NOT NULL COMMENT '诚意金',
  `investor_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '投资认证是否通过 0 表示未通过，1表示通过审核',
  `investor_status_send` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核结果通知用户，0表示未发送，1表示已发送',
  `break_num` tinyint(1) NOT NULL DEFAULT '0' COMMENT '毁约次数',
  `wx_openid` varchar(255) NOT NULL COMMENT '微信openid',
  `investor_send_info` varchar(255) NOT NULL COMMENT '审核信息',
  `paypassword` varchar(255) NOT NULL COMMENT '提现和支付密码',
  `source_url` varchar(255) NOT NULL COMMENT '来源url',
  `ips_mer_code` varchar(10) NOT NULL COMMENT '由IPS颁发的商户号 is_investor = 2',
  `ips_acct_no` varchar(255) DEFAULT NULL COMMENT '托管平台账户号',
  `pid` int(11) NOT NULL COMMENT '推荐人id',
  `score` int(11) NOT NULL COMMENT '积分',
  `is_send_referrals` tinyint(1) NOT NULL COMMENT '是否发放推荐返利给推存人，0：没有推荐人,不用发放返利，1：未发，2.已发',
  `referral_count` int(11) NOT NULL COMMENT '返利数量',
  `point` int(11) NOT NULL COMMENT '信用值',
  `cate_name` varchar(255) NOT NULL COMMENT '投资领域',
  `company` varchar(255) NOT NULL COMMENT '公司',
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '职位',
  `qq_id` varchar(255) NOT NULL,
  `qq_token` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `is_effect` (`is_effect`)
) ENGINE=MyISAM AUTO_INCREMENT=4299 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user`
--

LOCK TABLES `fanwe_user` WRITE;
/*!40000 ALTER TABLE `fanwe_user` DISABLE KEYS */;
INSERT INTO `fanwe_user` VALUES (4291,'大王','82ec24dfa284d3deeb18bdded401a130',1440365054,1440365054,1,'1554543905@qq.com',0.00,1448827098,'101.81.55.163','','','',0,1,0,0,0,'','','','','','','','','','','','','','','','',0,'13817306425',0,0,0,0,'',0,'张露','320911199205225726','','','','','','',1,0.00,1,1,0,'','','','','','',0,0,0,0,0,'','','','',''),(4292,'圈圈','6d7fff117d76bcc23a4b57c91a686a5a',1440365387,1440365387,1,'285512005@qq.com',0.00,1441752490,'222.44.84.34','','','',0,1,0,0,0,'','','','','','','','','','','','','','','','',0,'',0,0,0,0,'',0,'卢','331023198401071829','','','','','','',1,0.00,1,1,0,'','','','','','',0,0,0,0,0,'N;','','','',''),(4293,'过儿','f1e40a06b8d07c081cdb67ccc0052a48',1440365406,1440365406,1,'905440084@qq.com',0.00,1440365406,'222.44.84.34','','','',0,0,0,0,0,'','','','','','','','','','','','','','','','',0,'',0,0,0,0,'',0,'杨朝生','440882199111065757','','','','','','',1,0.00,1,1,0,'','','','','','',0,0,0,0,0,'','','','',''),(4288,'yorick','e10adc3949ba59abbe56e057f20f883e',1440304745,1440304745,1,'qq271645773@126.com',0.00,1440304409,'180.175.239.186','','','',0,4,0,0,0,'','','','','','','','','','','','','','','','',0,'',0,0,0,0,'',0,'420526198912301013','420526198912301013','','','','','','',1,0.00,1,0,0,'','','','','','',0,0,0,0,0,'','','','',''),(4290,'李书福子','e10adc3949ba59abbe56e057f20f883e',1441755897,1441755897,1,'sun@pinman.cn',0.00,1446261318,'223.104.5.237','','','',0,2,0,1,0,'','','','','','','','','','','','','','','','',0,'18964673443',0,0,0,NULL,NULL,0,'张仲礼','370205197405213513','./public/attachment/201509/09/15/55efe25bbddc7.jpg','./public/attachment/201509/09/15/55efe2616678d.jpg','','','','',2,0.00,1,0,0,'','','','','',NULL,0,0,0,0,0,'','','','',''),(4294,'jason','e10adc3949ba59abbe56e057f20f883e',1440382870,1440382870,1,'286203455@qq.com',0.12,1440382870,'222.44.84.34','','','',1,0,0,0,0,'','','','','','','','','','','','','','','','',0,'',0,0,0,0,'',0,'sun','41100219860519401X','','','','','','',1,0.00,1,1,0,'','','','','','',0,0,0,0,0,'N;','','','',''),(4295,'grace','e10adc3949ba59abbe56e057f20f883e',1440442088,1440442088,1,'happyzhan_1231@126.com',1000000.00,1440659670,'61.164.211.130','上海','闸北区','',0,0,0,0,0,'','','','','','','','','','','','','','','','',0,'',0,0,0,NULL,NULL,0,'','','','','','','','',1,0.00,1,0,0,'','','','','',NULL,0,0,0,0,0,'a:3:{i:3;s:6:\"教育\";i:4;s:6:\"动漫\";i:6;s:6:\"科技\";}','软银中国','投资经理','',''),(4296,'Clark','4c854b3ecedb396ff35222d76a3fe27b',1440439707,1440439707,1,'461225265@qq.com',0.00,1448828129,'101.81.55.163','','','',0,0,0,1,0,'','','','','','','','','','','','','','','','',0,'',0,0,0,0,'',0,'员外','430722199011025375','','','','','','',1,0.00,1,1,0,'','','','','','',0,0,0,0,0,'','','','',''),(4297,'wowyorick','68dc18ee0192bef5b872472571266688',1440652667,1440652667,1,'271645773@qq.com',0.00,1451865115,'180.162.210.154','','','',0,0,0,0,0,'','','','','','','','','','','','','','','','',0,'15692162219',0,0,0,NULL,NULL,0,'','','','','','','','',0,0.00,0,0,0,'','','','','',NULL,0,0,0,0,0,'a:1:{i:2;s:6:\"文化\";}','','','',''),(4298,'神父','f2f278a257d94359f9bae4ee2bfef4de',1441755378,1441755378,1,'',0.00,1441751250,'222.44.84.34','','','',0,0,0,0,0,'','','','','','','','','','','','','','','','',0,'13611778605',0,0,0,0,'',0,'孙志华','411002198605194001','','','','','','',1,0.00,1,0,0,'','','','','','',0,0,0,0,0,'','','','','');
/*!40000 ALTER TABLE `fanwe_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_bank`
--

DROP TABLE IF EXISTS `fanwe_user_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '体现人（标识ID）',
  `bank_id` int(11) NOT NULL COMMENT '银行(标识ID)',
  `bank_name` varchar(255) NOT NULL,
  `bankcard` varchar(30) NOT NULL COMMENT '卡号',
  `real_name` varchar(20) NOT NULL COMMENT '姓名',
  `region_lv1` varchar(50) NOT NULL,
  `region_lv2` varchar(50) NOT NULL,
  `region_lv3` varchar(50) NOT NULL,
  `region_lv4` varchar(50) NOT NULL,
  `bankzone` varchar(255) NOT NULL COMMENT '开户网点',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `bank_id` (`bank_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_bank`
--

LOCK TABLES `fanwe_user_bank` WRITE;
/*!40000 ALTER TABLE `fanwe_user_bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_user_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_carry_config`
--

DROP TABLE IF EXISTS `fanwe_user_carry_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_carry_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '简称',
  `min_price` decimal(20,0) NOT NULL COMMENT '最低额度',
  `max_price` decimal(20,0) NOT NULL COMMENT '最高额度',
  `fee` decimal(20,2) NOT NULL COMMENT '费率',
  `fee_type` tinyint(1) NOT NULL COMMENT '费率类型 0 是固定值 1是百分比',
  `vip_id` int(11) NOT NULL COMMENT 'VIP等级     0默认配置  否则就是对应VIP等级设置',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_carry_config`
--

LOCK TABLES `fanwe_user_carry_config` WRITE;
/*!40000 ALTER TABLE `fanwe_user_carry_config` DISABLE KEYS */;
INSERT INTO `fanwe_user_carry_config` VALUES (2,'5万以内',10001,50000,20.00,0,0),(1,'1万以内',0,10000,10.00,0,0);
/*!40000 ALTER TABLE `fanwe_user_carry_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_consignee`
--

DROP TABLE IF EXISTS `fanwe_user_consignee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_consignee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `province` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `consignee` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_consignee`
--

LOCK TABLES `fanwe_user_consignee` WRITE;
/*!40000 ALTER TABLE `fanwe_user_consignee` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_user_consignee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_copy`
--

DROP TABLE IF EXISTS `fanwe_user_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_pwd` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `money` double(20,4) NOT NULL,
  `login_time` int(11) NOT NULL,
  `login_ip` varchar(50) NOT NULL,
  `province` varchar(10) NOT NULL,
  `city` varchar(10) NOT NULL,
  `password_verify` varchar(255) NOT NULL COMMENT '找回密码的验证号',
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `build_count` int(11) NOT NULL COMMENT '发起的项目数',
  `support_count` int(11) NOT NULL COMMENT '支持的项目数',
  `focus_count` int(11) NOT NULL COMMENT '关注的项目数',
  `integrate_id` int(11) NOT NULL,
  `intro` text NOT NULL COMMENT '个人简介',
  `ex_real_name` varchar(255) NOT NULL COMMENT '发布者真实姓名',
  `ex_account_bank` text NOT NULL,
  `ex_account_info` text NOT NULL COMMENT '银行帐号等信息',
  `ex_contact` text NOT NULL COMMENT '联系方式',
  `ex_qq` text NOT NULL,
  `code` varchar(255) NOT NULL,
  `sina_id` varchar(255) NOT NULL,
  `sina_token` varchar(255) NOT NULL,
  `sina_secret` varchar(255) NOT NULL,
  `sina_url` varchar(255) NOT NULL,
  `tencent_id` varchar(255) NOT NULL,
  `tencent_token` varchar(255) NOT NULL,
  `tencent_secret` varchar(255) NOT NULL,
  `tencent_url` varchar(255) NOT NULL,
  `verify` varchar(255) NOT NULL,
  `user_level` int(11) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `user_type` int(11) NOT NULL,
  `is_has_send_success` tinyint(1) NOT NULL,
  `is_bank` tinyint(1) NOT NULL COMMENT '（0表示银行账户信息未提交，1表示银行账户信息提交）',
  `verify_time` int(11) DEFAULT NULL COMMENT '验证发送时间',
  `verify_setting` varchar(255) DEFAULT NULL COMMENT '设置时候的验证码',
  `verify_setting_time` int(11) NOT NULL COMMENT '设置时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `is_effect` (`is_effect`)
) ENGINE=MyISAM AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_copy`
--

LOCK TABLES `fanwe_user_copy` WRITE;
/*!40000 ALTER TABLE `fanwe_user_copy` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_user_copy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_copy1`
--

DROP TABLE IF EXISTS `fanwe_user_copy1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_copy1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `money` double(20,4) NOT NULL,
  `province` varchar(10) NOT NULL,
  `city` varchar(10) NOT NULL,
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `ex_real_name` varchar(255) NOT NULL COMMENT '发布者真实姓名',
  `ex_account_bank` text NOT NULL,
  `ex_account_info` text NOT NULL COMMENT '银行帐号等信息',
  `ex_contact` text NOT NULL COMMENT '联系方式',
  `ex_qq` text NOT NULL,
  `sina_url` varchar(255) NOT NULL,
  `tencent_url` varchar(255) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=MyISAM AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_copy1`
--

LOCK TABLES `fanwe_user_copy1` WRITE;
/*!40000 ALTER TABLE `fanwe_user_copy1` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_user_copy1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_deal_notify`
--

DROP TABLE IF EXISTS `fanwe_user_deal_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_deal_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `deal_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deal_id_user_id` (`user_id`,`deal_id`),
  KEY `user_id` (`user_id`),
  KEY `deal_id` (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='用于发送下单成功的用户与关注用户的项目成功准备队列';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_deal_notify`
--

LOCK TABLES `fanwe_user_deal_notify` WRITE;
/*!40000 ALTER TABLE `fanwe_user_deal_notify` DISABLE KEYS */;
INSERT INTO `fanwe_user_deal_notify` VALUES (58,20,155,1439760547),(60,4290,165,1441764397),(63,4296,165,1441765777);
/*!40000 ALTER TABLE `fanwe_user_deal_notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_level`
--

DROP TABLE IF EXISTS `fanwe_user_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '等级名',
  `level` int(11) DEFAULT NULL COMMENT '等级大小   大->小',
  `point` int(11) NOT NULL COMMENT '所需信用值',
  `icon` varchar(255) NOT NULL COMMENT '等级图标',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_level`
--

LOCK TABLES `fanwe_user_level` WRITE;
/*!40000 ALTER TABLE `fanwe_user_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_user_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_log`
--

DROP TABLE IF EXISTS `fanwe_user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_info` text NOT NULL,
  `log_time` int(11) NOT NULL,
  `log_admin_id` int(11) NOT NULL,
  `money` double(20,4) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型 0表示充值 1表示 加入诚意金 2表示违约扣除诚意金 3表示分红  4提现 5购买回报 6购买股权 7积分购买 8积分消费 9退款',
  `deal_id` int(11) NOT NULL COMMENT '商品ID号',
  `score` int(11) NOT NULL COMMENT '积分',
  `point` int(11) NOT NULL COMMENT '信用值',
  `money_type` tinyint(1) DEFAULT NULL COMMENT '资金类型',
  `order_id` int(11) DEFAULT NULL COMMENT '订单编号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=693 DEFAULT CHARSET=utf8 COMMENT='帐户资金变动日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_log`
--

LOCK TABLES `fanwe_user_log` WRITE;
/*!40000 ALTER TABLE `fanwe_user_log` DISABLE KEYS */;
INSERT INTO `fanwe_user_log` VALUES (692,'冻结资金解冻-冻结号码：118',1441759732,1,0.0100,21,0,0,0,0,NULL,NULL),(691,'管理员操作',1440442047,1,1000000.0000,4295,0,0,0,0,NULL,NULL),(690,'通过支付宝即时到帐支付充值，单号2015082400001000680059940511',1440382997,0,0.1200,4294,0,0,0,0,17,NULL);
/*!40000 ALTER TABLE `fanwe_user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_message`
--

DROP TABLE IF EXISTS `fanwe_user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `message` text NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '该私信所属人ID',
  `dest_user_id` int(11) NOT NULL COMMENT '对方的用户ID（如果user_id是发件人，该ID为收件，反之为发件人ID）',
  `send_user_id` int(11) NOT NULL COMMENT '发件人ID',
  `receive_user_id` int(11) NOT NULL COMMENT '收件人ID',
  `user_name` varchar(255) NOT NULL,
  `dest_user_name` varchar(255) NOT NULL,
  `send_user_name` varchar(255) NOT NULL,
  `receive_user_name` varchar(255) NOT NULL,
  `message_type` enum('inbox','outbox') NOT NULL COMMENT '类型：inbox(收件) outbox(发件)',
  `is_read` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_message`
--

LOCK TABLES `fanwe_user_message` WRITE;
/*!40000 ALTER TABLE `fanwe_user_message` DISABLE KEYS */;
INSERT INTO `fanwe_user_message` VALUES (77,1440383273,'你好',4295,4291,4295,4291,'grace','大王','grace','大王','outbox',1),(78,1440383273,'你好',4291,4295,4295,4291,'大王','grace','grace','大王','inbox',1);
/*!40000 ALTER TABLE `fanwe_user_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_notify`
--

DROP TABLE IF EXISTS `fanwe_user_notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `log_info` text NOT NULL,
  `log_time` int(11) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `url_route` varchar(255) NOT NULL,
  `url_param` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=644 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_notify`
--

LOCK TABLES `fanwe_user_notify` WRITE;
/*!40000 ALTER TABLE `fanwe_user_notify` DISABLE KEYS */;
INSERT INTO `fanwe_user_notify` VALUES (639,4293,'您的投资人申请已经通过',1440365796,0,'account#index',''),(640,4292,'您的投资人申请已经通过',1440365804,1,'account#index',''),(641,4291,'您的投资人申请已经通过',1440365810,0,'account#index',''),(642,4294,'您的投资人申请已经通过',1440390783,0,'account#index',''),(643,4296,'您的投资人申请已经通过',1441760269,0,'account#index','');
/*!40000 ALTER TABLE `fanwe_user_notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_refund`
--

DROP TABLE IF EXISTS `fanwe_user_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_refund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` double(20,4) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL COMMENT '提现申请时间',
  `reply` text NOT NULL COMMENT '提现审核回复',
  `is_pay` tinyint(1) NOT NULL,
  `pay_time` int(11) NOT NULL,
  `memo` text NOT NULL COMMENT '提现的备注',
  `pay_log` text NOT NULL COMMENT '支付说明',
  `user_bank_id` int(11) NOT NULL COMMENT '银行ID',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_refund`
--

LOCK TABLES `fanwe_user_refund` WRITE;
/*!40000 ALTER TABLE `fanwe_user_refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_user_refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_user_weibo`
--

DROP TABLE IF EXISTS `fanwe_user_weibo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_user_weibo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `weibo_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_user_weibo`
--

LOCK TABLES `fanwe_user_weibo` WRITE;
/*!40000 ALTER TABLE `fanwe_user_weibo` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_user_weibo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_vote`
--

DROP TABLE IF EXISTS `fanwe_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '调查的项目名称',
  `begin_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  `is_effect` tinyint(1) NOT NULL COMMENT '有效性',
  `sort` int(11) NOT NULL,
  `description` text NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_vote`
--

LOCK TABLES `fanwe_vote` WRITE;
/*!40000 ALTER TABLE `fanwe_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_vote_ask`
--

DROP TABLE IF EXISTS `fanwe_vote_ask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_vote_ask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '投票项名称',
  `type` tinyint(1) NOT NULL COMMENT '投票类型，单选多选/自定义可叠加 1:单选 2:多选 3:自定义',
  `sort` int(11) NOT NULL COMMENT ' 排序 大到小',
  `vote_id` int(11) NOT NULL COMMENT '调查ID',
  `val_scope` text NOT NULL COMMENT '预选范围 逗号分开',
  `is_fill` tinyint(1) NOT NULL COMMENT '1表示该项必填，0表示可以不填',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_vote_ask`
--

LOCK TABLES `fanwe_vote_ask` WRITE;
/*!40000 ALTER TABLE `fanwe_vote_ask` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_vote_ask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_vote_list`
--

DROP TABLE IF EXISTS `fanwe_vote_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_vote_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vote_id` int(11) NOT NULL COMMENT '调查项ID',
  `value` text NOT NULL COMMENT '问题答案',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_vote_list`
--

LOCK TABLES `fanwe_vote_list` WRITE;
/*!40000 ALTER TABLE `fanwe_vote_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_vote_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_vote_result`
--

DROP TABLE IF EXISTS `fanwe_vote_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_vote_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '投票的名称',
  `count` int(11) NOT NULL COMMENT '计数',
  `vote_id` int(11) NOT NULL COMMENT '调查项ID',
  `vote_ask_id` int(11) NOT NULL COMMENT '投票项（问题）ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_vote_result`
--

LOCK TABLES `fanwe_vote_result` WRITE;
/*!40000 ALTER TABLE `fanwe_vote_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_vote_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_account`
--

DROP TABLE IF EXISTS `fanwe_weixin_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(255) NOT NULL COMMENT 'AppID(应用ID)-第三方平台指 授权方appid',
  `appsecret` varchar(255) NOT NULL COMMENT 'AppSecret(应用密钥)-第三方平台无用',
  `app_url` varchar(255) NOT NULL COMMENT 'URL(服务器地址)-第三方平台无用',
  `app_token` varchar(255) NOT NULL COMMENT 'Token(令牌)-第三方平台无用',
  `app_encodingAESKey` varchar(255) NOT NULL COMMENT 'EncodingAESKey(消息加解密密钥)-第三方平台无用',
  `authorizer_appid` varchar(255) NOT NULL COMMENT '授权方appid',
  `authorizer_access_token` varchar(255) NOT NULL COMMENT '授权方令牌-第三方平台无用',
  `expires_in` int(11) NOT NULL COMMENT '授权方令牌 有效时间-第三方平台无用',
  `authorizer_refresh_token` varchar(255) NOT NULL COMMENT '刷新令牌-第三方平台',
  `func_info` text NOT NULL COMMENT '公众号授权给开发者的权限集列表',
  `verify_type_info` tinyint(1) NOT NULL COMMENT '授权方认证类型，-1代表未认证，0代表微信认证，1代表新浪微博认证，2代表腾讯微博认证，3代表已资质认证通过但还未通过名称认证，4代表已资质认证通过、还未通过名称认证，但通过了新浪微博认证，5代表已资质认证通过、还未通过名称认证，但通过了腾讯微博认证',
  `service_type_info` tinyint(1) NOT NULL COMMENT '授权方公众号类型，0代表订阅号，1代表由历史老帐号升级后的订阅号，2代表服务号',
  `nick_name` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL COMMENT '授权方公众号的原始ID',
  `authorizer_info` varchar(255) NOT NULL COMMENT '授权方昵称',
  `head_img` varchar(255) NOT NULL COMMENT '授权方头像',
  `alias` varchar(255) NOT NULL COMMENT '授权方公众号所设置的微信号，可能为空',
  `qrcode_url` varchar(255) NOT NULL COMMENT '二维码图片的URL，开发者最好自行也进行保存',
  `location_report` tinyint(1) NOT NULL COMMENT '地理位置上报选项 0 无上报 1 进入会话时上报 2 每5s上报',
  `voice_recognize` tinyint(1) NOT NULL COMMENT '语音识别开关选项 0 关闭语音识别 1 开启语音识别',
  `customer_service` tinyint(1) NOT NULL COMMENT '客服开关选项 0 关闭多客服 1 开启多客服',
  `is_authorized` tinyint(1) NOT NULL DEFAULT '0' COMMENT '授权方是否取消授权 0表示取消授权 1表示授权',
  `user_id` int(11) NOT NULL COMMENT '会员ID ，诺type为1，user_id 为空',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 表示前台会员 1 表示后台管理员',
  `industry_1` int(11) NOT NULL,
  `industry_1_status` tinyint(1) NOT NULL,
  `industry_2` int(11) NOT NULL,
  `industry_2_status` tinyint(1) NOT NULL,
  `test_user` varchar(255) DEFAULT NULL COMMENT '测试微信号',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `au_app_id` (`authorizer_appid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='//微信公众号列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_account`
--

LOCK TABLES `fanwe_weixin_account` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_api_get_record`
--

DROP TABLE IF EXISTS `fanwe_weixin_api_get_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_api_get_record` (
  `openid` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`openid`),
  KEY `account_id` (`account_id`) USING BTREE,
  KEY `idx_0` (`account_id`,`create_time`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='请求的用户记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_api_get_record`
--

LOCK TABLES `fanwe_weixin_api_get_record` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_api_get_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_api_get_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_conf`
--

DROP TABLE IF EXISTS `fanwe_weixin_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `group_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '配置输入的类型 0:文本输入 1:下拉框输入 2:图片上传 3:编辑器',
  `value_scope` text NOT NULL COMMENT '取值范围',
  `is_require` tinyint(1) NOT NULL,
  `is_effect` tinyint(1) NOT NULL,
  `is_conf` tinyint(1) NOT NULL COMMENT '是否可配置 0: 可配置  1:不可配置',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='//微信配置选项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_conf`
--

LOCK TABLES `fanwe_weixin_conf` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_conf` DISABLE KEYS */;
INSERT INTO `fanwe_weixin_conf` VALUES (1,'第三方平台appid','platform_appid','appid',0,0,'',0,1,1,1),(2,'第三方平台token','platform_token','token',0,0,'',0,1,1,2),(3,'第三方平台symmetric_key','platform_encodingAesKey','symmetric_key',0,0,'',0,1,1,3),(4,'是否开启第三方平台','platform_status','0',0,4,'0,1',0,1,1,4),(5,'第三方平台AppSecret','platform_appsecret','0',0,0,'',0,1,1,1),(6,'component_verify_ticket','platform_component_verify_ticket','0',0,0,'',0,1,0,6),(7,'第三方平台access_token','platform_component_access_token','0',0,0,'',0,1,0,7),(8,'第三方平台预授权码','platform_pre_auth_code','0',0,0,'',0,1,0,8),(9,'第三方平台access_token有效期','platform_component_access_token_expire','0',0,0,'',0,1,0,9),(10,'第三方平台预授权码有效期','platform_pre_auth_code_expire','0',0,0,'',0,1,0,10);
/*!40000 ALTER TABLE `fanwe_weixin_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_group`
--

DROP TABLE IF EXISTS `fanwe_weixin_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `groupid` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(60) NOT NULL DEFAULT '',
  `intro` varchar(200) NOT NULL DEFAULT '',
  `account_id` varchar(30) NOT NULL DEFAULT '',
  `fanscount` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `groupid` (`groupid`,`account_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_group`
--

LOCK TABLES `fanwe_weixin_group` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_msg_list`
--

DROP TABLE IF EXISTS `fanwe_weixin_msg_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_msg_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dest` varchar(255) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `content` text NOT NULL,
  `send_time` int(11) NOT NULL,
  `is_send` tinyint(1) NOT NULL,
  `create_time` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `result` text NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  `title` text NOT NULL,
  `is_youhui` tinyint(1) NOT NULL,
  `youhui_id` int(11) NOT NULL,
  `code` varchar(60) NOT NULL COMMENT '发送的验证码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='//微信消息列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_msg_list`
--

LOCK TABLES `fanwe_weixin_msg_list` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_msg_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_msg_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_nav`
--

DROP TABLE IF EXISTS `fanwe_weixin_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '菜单名称',
  `sort` int(11) DEFAULT '0' COMMENT '菜单排序 大->小',
  `key_or_url` varchar(255) DEFAULT '' COMMENT '用于推送到微信平台的key或url(所有以http://开头的表示url，其余一率为key)',
  `event_type` enum('click') DEFAULT 'click' COMMENT '按钮的事件，目前微信只支持click',
  `account_id` int(11) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0' COMMENT '是否已推送到微信(0:未推送或失败 1:成功)，该列同一个商家全部相同，菜单为一次性推送,对菜单本地修改时，批量更新该值为0',
  `u_id` int(11) DEFAULT NULL,
  `u_module` varchar(255) DEFAULT NULL,
  `u_action` varchar(255) DEFAULT NULL,
  `u_param` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sort` (`sort`),
  KEY `event_type` (`event_type`),
  KEY `account_id` (`account_id`,`key_or_url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='为微信自定义的菜单设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_nav`
--

LOCK TABLES `fanwe_weixin_nav` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_nav` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_reply`
--

DROP TABLE IF EXISTS `fanwe_weixin_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `i_msg_type` enum('event','link','location','image','text') DEFAULT 'text' COMMENT '接收到的微信的推送到本系统api中的MsgType',
  `o_msg_type` enum('news','music','text') DEFAULT 'text' COMMENT '用于响应并回复给微信推送的消息类型 news:图文 music:音乐 text:纯文本',
  `keywords` varchar(300) DEFAULT NULL COMMENT '用于响应文本(i_msg_type:text或者i_event:click时对key的响应)类型的回复时进行匹配的关键词',
  `keywords_match` text COMMENT 'keywords的全文索引列',
  `keywords_match_row` text COMMENT 'keywords全文索引的未作unicode编码的原文，用于开发者查看',
  `address` text COMMENT '用于显示的地理地址',
  `api_address` text COMMENT '用于地理定位的API地址',
  `x_point` varchar(100) DEFAULT '' COMMENT '用于lbs消息,i_msg_type:location 匹配的经度',
  `y_point` varchar(100) DEFAULT '' COMMENT '用于lbs消息,i_msg_type:location 匹配的纬度',
  `scale_meter` int(11) DEFAULT '0' COMMENT '用于lbs消息,i_msg_type:location 匹配的距离范围(米)',
  `i_event` enum('subscribe','unsubscribe','click','empty') DEFAULT 'empty' COMMENT '用于响应i_msg_type为event时的对应事件',
  `reply_content` text COMMENT '回复的文本消息',
  `reply_music` varchar(255) DEFAULT '' COMMENT '回复的音乐链接',
  `reply_news_title` text COMMENT '图文回复的标题',
  `reply_news_description` text COMMENT '图文回复的描述',
  `reply_news_picurl` varchar(255) DEFAULT '' COMMENT '图文回复的图片链接',
  `reply_news_url` varchar(255) DEFAULT '' COMMENT '图文回复的跳转链接',
  `reply_news_content` text,
  `type` tinyint(1) DEFAULT '0' COMMENT '回复归类 \r\n0:普通的回复 \r\n1:默认回复(只能一条文本或图文) \r\n2:官网回复(只能有一条图文)\r\n3.业务数据(图文)\r\n4.关注时回复(只能有一条文本或图文) \r\n5.取消关注时回复(只能有一条文本或图文) ',
  `relate_data` varchar(255) DEFAULT '' COMMENT '关联的业务数据源(如youhui,vote)等',
  `relate_id` int(11) DEFAULT '0' COMMENT '所关联的relate_data的id，用于判断数据关联的删除(指定url)',
  `account_id` int(11) DEFAULT '0' COMMENT '所属的商家ID',
  `default_close` tinyint(1) DEFAULT '1' COMMENT '默认回复是否关闭 0：关闭 1：开启',
  `relate_type` tinyint(1) DEFAULT NULL COMMENT '与关联数据的关系 0:回复数据由关联数据源获取 1:只url跳转数据来源于关联数据',
  `match_type` tinyint(1) NOT NULL DEFAULT '0',
  `u_id` int(11) DEFAULT NULL,
  `u_module` varchar(255) DEFAULT NULL,
  `u_action` varchar(255) DEFAULT NULL,
  `u_param` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_msg_type` (`i_msg_type`),
  KEY `o_msg_type` (`o_msg_type`),
  KEY `i_event` (`i_event`),
  KEY `type` (`type`),
  KEY `relate_data` (`relate_data`),
  KEY `relate_id` (`relate_id`),
  KEY `account_id` (`account_id`),
  KEY `match_type` (`account_id`,`match_type`,`keywords`),
  FULLTEXT KEY `keywords_match` (`keywords_match`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商家回复设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_reply`
--

LOCK TABLES `fanwe_weixin_reply` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_reply_relate`
--

DROP TABLE IF EXISTS `fanwe_weixin_reply_relate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_reply_relate` (
  `main_reply_id` int(11) DEFAULT '0' COMMENT '主回复ID',
  `relate_reply_id` int(11) DEFAULT '0' COMMENT '关联的多图文用的子回复ID',
  `sort` tinyint(1) DEFAULT '0',
  KEY `main_reply_id` (`main_reply_id`),
  KEY `relate_reply_id` (`relate_reply_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='多图文回复的关联配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_reply_relate`
--

LOCK TABLES `fanwe_weixin_reply_relate` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_reply_relate` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_reply_relate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_send`
--

DROP TABLE IF EXISTS `fanwe_weixin_send`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `author` varchar(100) NOT NULL COMMENT '作者件',
  `media_file` varchar(255) NOT NULL COMMENT '多媒体文件',
  `content` text NOT NULL COMMENT '图文消息页面的内容，支持HTML标签',
  `send_type` tinyint(4) NOT NULL COMMENT '0普通群发，1高级群发',
  `user_type` tinyint(4) NOT NULL COMMENT '发送对 0所有 1会员组 2会员等级',
  `user_type_id` int(11) NOT NULL COMMENT '组ID或者等级ID',
  `msgtype` enum('news','music','video','voice','image','text') NOT NULL COMMENT '消息类型',
  `relate_type` tinyint(4) NOT NULL COMMENT '与关联数据的关系 0:回复数据由关联数据源获取 1:只url跳转数据来源于关联数据',
  `relate_data` varchar(255) NOT NULL,
  `relate_id` int(255) NOT NULL,
  `url` varchar(255) NOT NULL COMMENT '连接地址',
  `digest` text NOT NULL COMMENT '简介',
  `account_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `create_time` int(11) NOT NULL,
  `send_time` int(11) NOT NULL COMMENT '推送时间',
  `media_id` varchar(255) NOT NULL COMMENT '微信服务器的关联多媒体ID',
  `u_id` int(11) NOT NULL,
  `u_module` varchar(255) NOT NULL,
  `u_action` varchar(255) NOT NULL,
  `u_param` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_send`
--

LOCK TABLES `fanwe_weixin_send` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_send` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_send` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_send_relate`
--

DROP TABLE IF EXISTS `fanwe_weixin_send_relate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_send_relate` (
  `relate_id` int(11) NOT NULL,
  `send_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_send_relate`
--

LOCK TABLES `fanwe_weixin_send_relate` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_send_relate` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_send_relate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_tmpl`
--

DROP TABLE IF EXISTS `fanwe_weixin_tmpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_tmpl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '菜单名称',
  `sort` int(11) DEFAULT '0' COMMENT '菜单排序 大->小',
  `account_id` int(11) DEFAULT '0' COMMENT '所属的商家ID',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_tmpl`
--

LOCK TABLES `fanwe_weixin_tmpl` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_tmpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_tmpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_weixin_user`
--

DROP TABLE IF EXISTS `fanwe_weixin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_weixin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '会员ID',
  `account_id` int(11) NOT NULL,
  `subscribe` tinyint(1) NOT NULL COMMENT '用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号，拉取不到其余信息。',
  `openid` varchar(255) NOT NULL COMMENT '用户的标识，对当前公众号唯一',
  `nickname` varchar(255) NOT NULL,
  `sex` tinyint(1) NOT NULL COMMENT '用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `city` varchar(255) NOT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `headimgurl` varchar(255) DEFAULT NULL,
  `subscribe_time` varchar(255) DEFAULT NULL COMMENT '用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间',
  `unionid` varchar(255) DEFAULT NULL COMMENT '只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。',
  `remark` varchar(255) DEFAULT NULL COMMENT '公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注',
  `groupid` int(11) DEFAULT NULL COMMENT '用户所在的分组ID',
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `only` (`account_id`,`openid`)
) ENGINE=MyISAM AUTO_INCREMENT=733 DEFAULT CHARSET=utf8 COMMENT='//微信公众号会员列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_weixin_user`
--

LOCK TABLES `fanwe_weixin_user` WRITE;
/*!40000 ALTER TABLE `fanwe_weixin_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_weixin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_bind_bank_card`
--

DROP TABLE IF EXISTS `fanwe_yeepay_bind_bank_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_bind_bank_card` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestNo` int(10) NOT NULL DEFAULT '0' COMMENT 'yeepay_log.id',
  `platformUserNo` int(11) NOT NULL DEFAULT '0' COMMENT 'fanwe_user.id',
  `platformNo` varchar(20) NOT NULL,
  `bankCardNo` varchar(50) NOT NULL DEFAULT '' COMMENT '绑定的卡号',
  `bank` varchar(20) NOT NULL DEFAULT '' COMMENT '卡的开户行',
  `cardStatus` varchar(20) NOT NULL COMMENT '卡的状态VERIFYING 认证中 VERIFIED 已认证',
  `is_callback` tinyint(1) NOT NULL DEFAULT '0',
  `bizType` varchar(50) DEFAULT NULL COMMENT '业务名称',
  `code` varchar(50) DEFAULT NULL COMMENT '返回码;1 成功 0 失败 2 xml参数格式错误 3 签名验证失败 101 引用了不存在的对象（例如错误的订单号） 102 业务状态不正确 103 由于业务限制导致业务不能执行 104 实名认证失败',
  `message` varchar(255) DEFAULT NULL COMMENT '描述异常信息',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`requestNo`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_bind_bank_card`
--

LOCK TABLES `fanwe_yeepay_bind_bank_card` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_bind_bank_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_yeepay_bind_bank_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_cp_transaction`
--

DROP TABLE IF EXISTS `fanwe_yeepay_cp_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_cp_transaction` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestNo` int(10) NOT NULL DEFAULT '0' COMMENT 'yeepay_log.id',
  `platformNo` varchar(20) NOT NULL,
  `platformUserNo` int(11) NOT NULL DEFAULT '0' COMMENT 'fanwe_user.id',
  `userType` varchar(20) NOT NULL DEFAULT 'MEMBER' COMMENT '出款人用户类型，目前只支持传入 MEMBER\r\nMEMBER 个人会员 MERCHANT 商户 ',
  `bizType` varchar(50) NOT NULL COMMENT 'TENDER 投标 REPAYMENT 还款 CREDIT_ASSIGNMENT 债权转让 TRANSFER 转账 COMMISSION 分润，仅在资金转账明细中使用',
  `expired` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '超过此时间即不允许提交订单',
  `tenderOrderNo` int(11) DEFAULT '0' COMMENT '项目编号',
  `tenderName` varchar(255) DEFAULT NULL COMMENT '项目名称 ',
  `tenderAmount` decimal(20,2) DEFAULT '0.00' COMMENT '项目金额',
  `tenderDescription` varchar(255) DEFAULT NULL COMMENT '项目描述信息',
  `borrowerPlatformUserNo` int(11) DEFAULT NULL COMMENT '项目的借款人平台用户编号',
  `originalRequestNo` int(11) DEFAULT NULL COMMENT '需要转让的投资记录流水号',
  `paymentAmount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '实际支付金额',
  `details` text COMMENT '资金明细记录',
  `extend` text COMMENT '业务扩展属性，根据业务类型的不同，需要传入不同的参数。',
  `transfer_id` int(11) NOT NULL DEFAULT '0' COMMENT '债权转让id fanwe_deal_load_transfer.id',
  `is_callback` tinyint(1) NOT NULL DEFAULT '0',
  `is_complete_transaction` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is_callback=1时，才生效;判断是否已经完成转帐',
  `code` varchar(50) DEFAULT NULL COMMENT '返回码;1 成功 0 失败 2 xml参数格式错误 3 签名验证失败 101 引用了不存在的对象（例如错误的订单号） 102 业务状态不正确 103 由于业务限制导致业务不能执行 104 实名认证失败',
  `message` varchar(255) DEFAULT NULL COMMENT '描述异常信息',
  `description` varchar(255) DEFAULT NULL,
  `deal_repay_id` int(11) DEFAULT NULL COMMENT '还款计划ID',
  `fee` decimal(20,2) DEFAULT '0.00' COMMENT '手续费',
  `repay_start_time` varchar(50) DEFAULT NULL COMMENT '记录还款时间',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL COMMENT '易宝处理时间',
  `share_fee` decimal(20,2) DEFAULT '0.00' COMMENT '分红',
  `delivery_fee` decimal(20,2) DEFAULT NULL COMMENT '快递费用',
  `targetAmount` decimal(20,2) DEFAULT NULL COMMENT '用户实际收到金额',
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`id`,`requestNo`)
) ENGINE=MyISAM AUTO_INCREMENT=226 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_cp_transaction`
--

LOCK TABLES `fanwe_yeepay_cp_transaction` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_cp_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_yeepay_cp_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_cp_transaction_detail`
--

DROP TABLE IF EXISTS `fanwe_yeepay_cp_transaction_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_cp_transaction_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL DEFAULT '0' COMMENT 'fanwe_yeepay_repayment.id',
  `deal_load_repay_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户回款计划表',
  `targetUserType` int(11) NOT NULL DEFAULT '0' COMMENT '用户类型',
  `targetPlatformUserNo` int(11) NOT NULL DEFAULT '0' COMMENT '平台用户编号',
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '转入金额',
  `bizType` varchar(20) NOT NULL DEFAULT '' COMMENT '资金明细业务类型。根据业务的不同，需要传入不同的值，见【业务类型',
  `repay_manage_impose_money` decimal(20,2) DEFAULT NULL COMMENT '平台收取借款者的管理费逾期罚息',
  `impose_money` decimal(20,2) DEFAULT NULL COMMENT '投资者收取借款者的逾期罚息',
  `repay_status` int(11) DEFAULT NULL COMMENT '还款状态',
  `true_repay_time` int(11) DEFAULT NULL COMMENT '还款时间',
  `fee` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_cp_transaction_detail`
--

LOCK TABLES `fanwe_yeepay_cp_transaction_detail` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_cp_transaction_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_yeepay_cp_transaction_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_enterprise_register`
--

DROP TABLE IF EXISTS `fanwe_yeepay_enterprise_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_enterprise_register` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestNo` int(10) NOT NULL DEFAULT '0' COMMENT 'yeepay_log.id',
  `platformUserNo` int(11) DEFAULT '0' COMMENT 'fanwe_user.id',
  `platformNo` varchar(20) DEFAULT NULL,
  `enterpriseName` varchar(50) DEFAULT NULL COMMENT '企业名称',
  `bankLicense` varchar(50) DEFAULT NULL COMMENT '开户银行许可证',
  `orgNo` varchar(50) DEFAULT NULL COMMENT '组织机构代码',
  `businessLicense` varchar(50) DEFAULT NULL COMMENT '营业执照编号',
  `taxNo` varchar(20) DEFAULT NULL COMMENT '税务登记号',
  `legal` varchar(50) DEFAULT NULL COMMENT '法人姓名',
  `legalIdNo` varchar(20) DEFAULT NULL COMMENT '法人身份证号',
  `contact` varchar(20) DEFAULT NULL COMMENT '企业联系人',
  `contactPhone` varchar(20) DEFAULT NULL COMMENT '联系人手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '联系人邮箱',
  `memberClassType` varchar(255) DEFAULT NULL COMMENT '会员类型ENTERPRISE：企业借款人;GUARANTEE_CORP：担保公司',
  `is_callback` tinyint(1) NOT NULL DEFAULT '0',
  `bizType` varchar(50) DEFAULT NULL COMMENT '业务名称',
  `code` varchar(50) DEFAULT NULL COMMENT '返回码;1 成功 0 失败 2 xml参数格式错误 3 签名验证失败 101 引用了不存在的对象（例如错误的订单号） 102 业务状态不正确 103 由于业务限制导致业务不能执行 104 实名认证失败',
  `message` varchar(255) DEFAULT NULL COMMENT '描述异常信息',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`requestNo`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_enterprise_register`
--

LOCK TABLES `fanwe_yeepay_enterprise_register` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_enterprise_register` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_yeepay_enterprise_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_log`
--

DROP TABLE IF EXISTS `fanwe_yeepay_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL,
  `strxml` text,
  `html` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=71611 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_log`
--

LOCK TABLES `fanwe_yeepay_log` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_log` DISABLE KEYS */;
INSERT INTO `fanwe_yeepay_log` VALUES (71606,'toRegister','2015-09-09 15:43:23','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71606</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request>','<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head><body>\r\n		<form name=\"form1\" id=\"form1\" method=\"post\" action=\"https://member.yeepay.com/member/bha/toRegister\" target=\"_self\">		\r\n		<input type=\"hidden\" name=\"sign\" value=\"\" />		\r\n		<textarea name=\"req\" cols=\"100\" rows=\"5\" style=\"display:none\"><?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71606</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request></textarea>\r\n		<input type=\"hidden\" value=\"提交\" />\r\n		<div style=\"width:100%;text-align:center;padding:50px 0;\"><img src=\"/app/Tpl/fanwe_1/images/loading.gif\" />页面正在跳转，请稍后...</div>\r\n		</form>\r\n		</body></html>\r\n		<script language=\"javascript\">document.form1.submit();</script>'),(71607,'toRegister','2015-09-09 15:43:42','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71607</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request>','<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head><body>\r\n		<form name=\"form1\" id=\"form1\" method=\"post\" action=\"https://member.yeepay.com/member/bha/toRegister\" target=\"_self\">		\r\n		<input type=\"hidden\" name=\"sign\" value=\"\" />		\r\n		<textarea name=\"req\" cols=\"100\" rows=\"5\" style=\"display:none\"><?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71607</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request></textarea>\r\n		<input type=\"hidden\" value=\"提交\" />\r\n		<div style=\"width:100%;text-align:center;padding:50px 0;\"><img src=\"/app/Tpl/fanwe_1/images/loading.gif\" />页面正在跳转，请稍后...</div>\r\n		</form>\r\n		</body></html>\r\n		<script language=\"javascript\">document.form1.submit();</script>'),(71608,'toRegister','2015-09-09 15:48:11','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71608</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request>','<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head><body>\r\n		<form name=\"form1\" id=\"form1\" method=\"post\" action=\"https://member.yeepay.com/member/bha/toRegister\" target=\"_self\">		\r\n		<input type=\"hidden\" name=\"sign\" value=\"\" />		\r\n		<textarea name=\"req\" cols=\"100\" rows=\"5\" style=\"display:none\"><?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71608</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request></textarea>\r\n		<input type=\"hidden\" value=\"提交\" />\r\n		<div style=\"width:100%;text-align:center;padding:50px 0;\"><img src=\"/app/Tpl/fanwe_1/images/loading.gif\" />页面正在跳转，请稍后...</div>\r\n		</form>\r\n		</body></html>\r\n		<script language=\"javascript\">document.form1.submit();</script>'),(71609,'toRegister','2015-09-09 17:25:39','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71609</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request>','<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head><body>\r\n		<form name=\"form1\" id=\"form1\" method=\"post\" action=\"https://member.yeepay.com/member/bha/toRegister\" target=\"_self\">		\r\n		<input type=\"hidden\" name=\"sign\" value=\"\" />		\r\n		<textarea name=\"req\" cols=\"100\" rows=\"5\" style=\"display:none\"><?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71609</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request></textarea>\r\n		<input type=\"hidden\" value=\"提交\" />\r\n		<div style=\"width:100%;text-align:center;padding:50px 0;\"><img src=\"/app/Tpl/fanwe_1/images/loading.gif\" />页面正在跳转，请稍后...</div>\r\n		</form>\r\n		</body></html>\r\n		<script language=\"javascript\">document.form1.submit();</script>'),(71610,'toRegister','2015-09-09 17:35:46','<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71610</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request>','<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\" /></head><body>\r\n		<form name=\"form1\" id=\"form1\" method=\"post\" action=\"https://member.yeepay.com/member/bha/toRegister\" target=\"_self\">		\r\n		<input type=\"hidden\" name=\"sign\" value=\"\" />		\r\n		<textarea name=\"req\" cols=\"100\" rows=\"5\" style=\"display:none\"><?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><request platformNo=\'\'><platformUserNo>4290</platformUserNo><requestNo>71610</requestNo><nickName>李书福子</nickName><realName>张仲礼</realName><idCardType>G2_IDCARD</idCardType><idCardNo>370205197405213513</idCardNo><mobile>18964673443</mobile><email>sun@pinman.cn</email><callbackUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=response&class_name=Yeepay&class_act=CreateNewAcct&from=]]></callbackUrl><notifyUrl><![CDATA[http://www.dpin.cn/index.php?ctl=collocation&act=notify&class_name=Yeepay&class_act=CreateNewAcct&from=]]></notifyUrl></request></textarea>\r\n		<input type=\"hidden\" value=\"提交\" />\r\n		<div style=\"width:100%;text-align:center;padding:50px 0;\"><img src=\"/app/Tpl/fanwe_1/images/loading.gif\" />页面正在跳转，请稍后...</div>\r\n		</form>\r\n		</body></html>\r\n		<script language=\"javascript\">document.form1.submit();</script>');
/*!40000 ALTER TABLE `fanwe_yeepay_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_recharge`
--

DROP TABLE IF EXISTS `fanwe_yeepay_recharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_recharge` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestNo` int(10) NOT NULL DEFAULT '0' COMMENT 'yeepay_log.id',
  `platformUserNo` int(11) NOT NULL DEFAULT '0' COMMENT 'fanwe_user.id',
  `platformNo` varchar(20) NOT NULL,
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `feeMode` varchar(50) NOT NULL DEFAULT 'PLATFORM' COMMENT '费率模式PLATFORM',
  `is_callback` tinyint(1) NOT NULL DEFAULT '0',
  `bizType` varchar(50) DEFAULT NULL COMMENT '业务名称',
  `code` varchar(50) DEFAULT NULL COMMENT '返回码;1 成功 0 失败 2 xml参数格式错误 3 签名验证失败 101 引用了不存在的对象（例如错误的订单号） 102 业务状态不正确 103 由于业务限制导致业务不能执行 104 实名认证失败',
  `message` varchar(255) DEFAULT NULL COMMENT '描述异常信息',
  `description` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `fee` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '手续费',
  PRIMARY KEY (`id`,`requestNo`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_recharge`
--

LOCK TABLES `fanwe_yeepay_recharge` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_recharge` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_yeepay_recharge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_register`
--

DROP TABLE IF EXISTS `fanwe_yeepay_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_register` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestNo` int(10) NOT NULL DEFAULT '0' COMMENT 'yeepay_log.id',
  `platformUserNo` int(11) DEFAULT '0' COMMENT 'fanwe_user.id',
  `platformNo` varchar(20) DEFAULT NULL,
  `nickName` varchar(50) DEFAULT NULL,
  `realName` varchar(50) DEFAULT NULL,
  `idCardNo` varchar(50) DEFAULT NULL,
  `idCardType` varchar(50) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `is_callback` tinyint(1) NOT NULL DEFAULT '0',
  `bizType` varchar(50) DEFAULT NULL COMMENT '业务名称',
  `code` varchar(50) DEFAULT NULL COMMENT '返回码;1 成功 0 失败 2 xml参数格式错误 3 签名验证失败 101 引用了不存在的对象（例如错误的订单号） 102 业务状态不正确 103 由于业务限制导致业务不能执行 104 实名认证失败',
  `message` varchar(255) DEFAULT NULL COMMENT '描述异常信息',
  `description` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`requestNo`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_register`
--

LOCK TABLES `fanwe_yeepay_register` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_register` DISABLE KEYS */;
INSERT INTO `fanwe_yeepay_register` VALUES (50,71606,4290,'','李书福子','张仲礼','370205197405213513','G2_IDCARD','18964673443','sun@pinman.cn',0,NULL,NULL,NULL,NULL,NULL),(51,71607,4290,'','李书福子','张仲礼','370205197405213513','G2_IDCARD','18964673443','sun@pinman.cn',0,NULL,NULL,NULL,NULL,NULL),(52,71608,4290,'','李书福子','张仲礼','370205197405213513','G2_IDCARD','18964673443','sun@pinman.cn',0,NULL,NULL,NULL,NULL,NULL),(53,71609,4290,'','李书福子','张仲礼','370205197405213513','G2_IDCARD','18964673443','sun@pinman.cn',0,NULL,NULL,NULL,NULL,NULL),(54,71610,4290,'','李书福子','张仲礼','370205197405213513','G2_IDCARD','18964673443','sun@pinman.cn',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `fanwe_yeepay_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fanwe_yeepay_withdraw`
--

DROP TABLE IF EXISTS `fanwe_yeepay_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fanwe_yeepay_withdraw` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestNo` int(10) NOT NULL DEFAULT '0' COMMENT 'yeepay_log.id',
  `platformUserNo` int(11) NOT NULL DEFAULT '0' COMMENT 'fanwe_user.id',
  `platformNo` varchar(20) NOT NULL,
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `feeMode` varchar(50) NOT NULL DEFAULT '' COMMENT 'PLATFORM 收取商户手续费 USER 收取用户手续费',
  `is_callback` tinyint(1) NOT NULL DEFAULT '0',
  `bizType` varchar(50) DEFAULT NULL COMMENT '业务名称',
  `code` varchar(50) DEFAULT NULL COMMENT '返回码;1 成功 0 失败 2 xml参数格式错误 3 签名验证失败 101 引用了不存在的对象（例如错误的订单号） 102 业务状态不正确 103 由于业务限制导致业务不能执行 104 实名认证失败',
  `message` varchar(255) DEFAULT NULL COMMENT '描述异常信息',
  `description` varchar(255) DEFAULT NULL,
  `cardNo` varchar(50) DEFAULT NULL COMMENT '绑定的卡号',
  `bank` varchar(20) DEFAULT NULL COMMENT '卡的开户行',
  `create_time` int(11) DEFAULT NULL,
  `fee` decimal(20,2) DEFAULT NULL COMMENT '手续费',
  PRIMARY KEY (`id`,`requestNo`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fanwe_yeepay_withdraw`
--

LOCK TABLES `fanwe_yeepay_withdraw` WRITE;
/*!40000 ALTER TABLE `fanwe_yeepay_withdraw` DISABLE KEYS */;
/*!40000 ALTER TABLE `fanwe_yeepay_withdraw` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-19 12:08:08
