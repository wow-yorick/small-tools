﻿<?php
error_reporting(0); 
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title>最牛X的信用卡生成器</title>
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
	<h1>长按下方图片点选保存图片</h1>
</header>
<div class="wrapper">

	<img src="toutu.php?id=<?=$_GET['id']?>&name=<?=$_GET['name']?>&namea=<?=$_GET['namea']?>" width="100%"/>
</div>


<?php }else{ ?>
<?
if($_SERVER['HTTP_HOST']=='baidu.com'){
	$tiao = 'http://www.at168.com';
	header("location: $tiao");
}
?>
<header class="ui-header ui-header-positive ui-border-b">
	<h1>最牛X的信用卡生成器</h1>
</header>
<div class="wrapper">
	<img src="icon.jpg" width="50%" style="margin:80px 25% 80px 25%;"/>
	<div class="ui-form">
    	<form action="">
        	<div class="ui-form-item ui-border-b">
            	<label for="#">姓</label>
            	<input type="text" name="name" placeholder="输入你的姓(大写拼音)"/>
        	</div>
			<div class="ui-form-item ui-border-b">
            	<label for="#">名</label>
            	<input type="text" name="namea" placeholder="输入你的名(大写拼音)"/>
        	</div>
			<div class="ui-form-item ui-border-b">
            	<label>额度</label>
            	<div class="ui-select">
                	<select name="id">
                    	<option value ="1000000">一百万</option>
                    	<option value ="2000000">二百万</option>
						<option value ="5000000">五百万</option>
						<option value ="8000000">八百万</option>
						<option value ="10000000">一千万</option>
						<option value ="20000000">二千万</option>
						<option value ="50000000">五千万</option>
						<option value ="80000000">八千万</option>
						<option value ="100000000">一个亿</option>
                	</select>
            	</div></div>
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