<?php
error_reporting(0); 
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title>飞行驾驶证生成器</title>
<link type="text/css" rel="stylesheet" href="../frozen.css" />
<style>
body{color:#a6a6a6; font-size:16px; padding-top:45px;}
body b{color: #00A5E3}
body>a{display:none;}
h2.title {line-height: 45px;font-size: 20px;color: #FF0000;position: fixed;top: 0;height: 45px;-webkit-box-sizing: border-box;width: 100%;z-index: 99;background-color: #f8f9fa;text-align:center;}
.pr5{padding-bottom:45px;}
.pr5 p{margin-bottom:5px;}
.ui-list{background-color:#f8f9fa;padding-bottom:5px}
#mcover{position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0, 0, 0, 0.7);display:none;z-index:20000;}
#mcover img{position:fixed;right: 18px;top:5px;width:260px;height:180px;z-index:20001;}
</style>
</head>
<body ontouchstart="">
<?php if($_GET['name']){?>

<header class="ui-header ui-header-positive ui-border-b">
	<h1>点击右上角分享给好友</h1>
</header>
<div class="wrapper">
	<img src="toutu.php?id=<?=$_GET['id']?>&name=<?=$_GET['name']?>" width="100%"/>
</div>
<div style="padding:0px 15px;"><a class="ui-btn-lg ui-btn-primary" href="index.php">生成您的驾驶证</a></div>
	<script src="http://m.leju.com/resources/scripts/wx_share.js?v1.1"></script> 
<script type="text/javascript"> 
weixinApi.share.init({ 
title:"生成您的飞行驾驶证", 
desc:"装逼神器", 
link:location.href, 
imgUrl:'http://www.at168.com/fly/toutu.jpg' 
}); 
</script>
<script type="text/javascript" src="zepto.min.js"></script>
<script type="text/javascript" src="frozen.js"></script>
<?php }else{ ?>
<?
if($_SERVER['HTTP_HOST']=='baidu.com'){
	$tiao = 'http://www.at168.com';
	header("location: $tiao");
}
?>
<header class="ui-header ui-header-positive ui-border-b">
	<h1>飞机驾照生成器</h1>
</header>
<div class="wrapper">
	<img src="icon.jpg" width="50%" style="margin:80px 25% 80px 25%;"/>
	<div class="ui-form">
    	<form action="">
        	<div class="ui-form-item ui-border-b">
            	<label for="#">姓名</label>
            	<input type="text" name="name" placeholder="输入你的姓名"/>
        	</div>
			<div class="ui-btn-wrap">
    			<button class="ui-btn-lg ui-btn-danger">确定</button>
			</div>
    	</form>
	</div>
<?php 
} 
require_once '../foot.php';
?>
</body>
</html>