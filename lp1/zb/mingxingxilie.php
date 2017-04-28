<?php
require_once "public.php";
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title>装逼神器</title>
<link type="text/css" rel="stylesheet" href="frozen.css" />
<style>
.follow{font-size:20px;line-height:30px;color:#fff;text-align:center;padding-top:30%;z-index:2000;position:fixed;top:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,.9);display:none;}
.follow span{font-size:40px;position:absolute;top:10px;left:10px;}
.follow img{width:180px;margin-top:10px;}
</style></head>
<body ontouchstart="">
<header class="ui-header ui-header-positive ui-border-b">
	<h1>明星系列</h1>
</header>
<section class="ui-container" style="padding-bottom:55px;">
<ul class="ui-list ui-list-link ui-border-tb">

<li class="ui-border-t" onClick="javascript:window.location.href='zjl/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(zjl/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">周杰伦演唱会特邀嘉宾图片器</h4>
            <p class="ui-nowrap">给你一张内订票，一定要来！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='boywuyifan/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(boywuyifan/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">(男)吴亦凡横幅生成器</h4>
            <p class="ui-nowrap">不服？不服你就来干</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='pn/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(pn/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">奔跑吧兄弟工作牌生成器</h4>
            <p class="ui-nowrap">我加入跑男了！</p>
        </div>
    </li>
	
<li class="ui-border-t" onClick="javascript:window.location.href='bdjp/'">
        <div class="ui-list-img">
            <span class="ui-tag-new" style="background-image:url(bdjp/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">波多老师举牌生成器</h4>
            <p class="ui-nowrap">波多老师为微趣网络举牌！</p>
        </div>
    </li>

<li class="ui-border-t" onClick="javascript:window.location.href='mh/'">
        <div class="ui-list-img">
            <span  style="background-image:url(mh/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">明星微信消息未读生成器</h4>
            <p class="ui-nowrap">范冰冰约我去她家了！</p>
        </div>
    </li>

	<li class="ui-border-t" onClick="javascript:window.location.href='hp/'">
        <div class="ui-list-img">
            <span  style="background-image:url(hp/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">湖畔大学上课图片生成器</h4>
            <p class="ui-nowrap">近距离接触马云，够装逼！</p>
        </div>
    </li>
	<li class="ui-border-t" onClick="javascript:window.location.href='szj/'">
        <div class="ui-list-img">
            <span style="background-image:url(szj/icon.jpg)"></span>
        </div>
        <div class="ui-list-info">
            <h4 class="ui-nowrap">宋仲基自爆恋情生成器</h4>
            <p class="ui-nowrap">宋仲基老公自爆他和你的恋情</p>
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