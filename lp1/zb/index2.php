<?php
require_once "public.php";
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title><?php echo "$title";?></title>
<link type="text/css" rel="stylesheet" href="frozen.css" />
<style>
.follow{font-size:20px;line-height:30px;color:#fff;text-align:center;padding-top:30%;z-index:2000;position:fixed;top:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,.9);display:none;}
.follow span{font-size:40px;position:absolute;top:10px;left:10px;}
.follow img{width:180px;margin-top:10px;}
</style></head>
<body ontouchstart="">
<header class="ui-header ui-header-positive ui-border-b">
	<h1><?php echo "$h1";?></h1>
</header>
<section class="ui-container" style="padding-bottom:55px;">
<ul class="ui-list ui-list-link ui-border-tb">

<li class="ui-border-t" onClick="javascript:window.location.href='new.php'">
<div class="ui-list-img">
<span class="ui-tag-new" style="background-image:url(img/1.png)"></span>
</div>
<div class="ui-list-info">
<h4 class="ui-nowrap"><font color="#ff0000">最新装逼神器</font></h4>
<p class="ui-nowrap"><font color="#f47607">点击查看每日都更新了什么</font></p>
</div>
</li>


<li class="ui-border-t" onClick="javascript:window.location.href='./mingxingxilie.php'">
<div class="ui-list-img">
<span class="ui-tag-hot" style="background-image:url(img/2.png)"></span>
</div>
<div class="ui-list-info">
<h4 class="ui-nowrap"><font color="#f47607">明星系列</font></h4>
<p class="ui-nowrap">明星表白、新闻、花边</p>
</div>
</li>

<li class="ui-border-t" onClick="javascript:window.location.href='./aiqingxilie.php'">
<div class="ui-list-img">
<span class="ui-tag-hot" style="background-image:url(img/3.png)"></span>
</div>
<div class="ui-list-info">
<h4 class="ui-nowrap"><font color="#ff0000">爱情系列</font></h4>
<p class="ui-nowrap">结婚证、表白、情书等</p>
</div>
</li>	

<li class="ui-border-t" onClick="javascript:window.location.href='./buchaqianxilie.php'">
<div class="ui-list-img">
<span class="ui-tag-hot" style="background-image:url(img/4.png)"></span>
</div>
<div class="ui-list-info">
<h4 class="ui-nowrap"><font color="#ca04ac">不差钱系列</font></h4>
<p class="ui-nowrap">豪车、游艇、房产都得有</p>
</div>
</li>
<li class="ui-border-t" onClick="javascript:window.location.href='./gaoguaixilie.php'">
<div class="ui-list-img">
<span class="ui-tag-hot" style="background-image:url(img/5.png)"></span>
</div>
<div class="ui-list-info">
<h4 class="ui-nowrap"><font color="#f47607">搞怪系列</font></h4>
<p class="ui-nowrap">搞怪/搞笑我们是认真的</p>
</div>
</li>

<li class="ui-border-t" onClick="javascript:window.location.href='./zhengguxilie.php'">
<div class="ui-list-img">
<span class="ui-tag-hot" style="background-image:url(img/6.png)"></span>
</div>
<div class="ui-list-info">
<h4 class="ui-nowrap"><font color="#ff0000">整蛊系列</font></h4>
<p class="ui-nowrap">整人于无形之中--星爷</p>
</div>
</li>


<li class="ui-border-t" onClick="javascript:window.location.href='./index.php'">
<div class="ui-list-img">
<span class="ui-tag-hot" style="background-image:url(img/7.png)"></span>
</div>
<div class="ui-list-info">
<h4 class="ui-nowrap"><font color="#ff0000">全部系列</font></h4>
<p class="ui-nowrap">大大小小归这里了</p>
</div>
</li>


</ul>
</section>
<footer class="ui-footer ui-footer-btn">
	<ul class="ui-tiled ui-border-t">
		<li class="ui-border-r"><a onClick="show()"><div>关注<?php echo "$gz";?></div></a></li>
	</ul>
</footer>
<div id="follow" class="follow">
	<span class="close" onClick="hide()">×</span>
	<p>长按下方二维码图片</p>
	<p>点选识别图中二维码</p>	<img src="images/ew.jpg">
</div>
<script type="text/javascript">
function show(){
	document.getElementById("follow").style.display = "block"; 
}
function hide(){
	document.getElementById("follow").style.display = "none"; 
}
</div>
</body>
</html>