<?php
if(!empty($_GET['key']))
{
	$img_path = './bfc.jpg';
	list($imgW,$imgH) = getimagesize($img_path);
	//创建图片的实例
	$oldImg = imagecreatefromjpeg($img_path);
	//创建一张与原图一样的大小的图片
	$img = imagecreatetruecolor($imgW, $imgH);
	//拷贝图片
	imagecopyresampled($img, $oldImg, 0, 0, 0, 0, $imgW, $imgH, $imgW, $imgH);
	
	//打上文字
	$font = './DFPShaoNvW5-GB.ttf';//字体
	$black = imagecolorallocate($img, 0x00, 0x00, 0x00);//字体颜色
	
	imagefttext($img, 13, 0, 20, 20, $black, $font, $_GET['text1']);
	$n = $imgW - strlen($_GET['text2']) * 13 - 20;
	imagefttext($img, 13, 0, $n, 20, $black, $font, $_GET['text2']);
	
	imagefttext($img, 13, 0, 20, 280, $black, $font, $_GET['text3']);
	imagefttext($img, 13, 0, $n, 280, $black, $font, $_GET['text4']);
	
	imagefttext($img, 13, 0, 20, 870, $black, $font, $_GET['text5']);
	
	//将图片保存
	$new_path = "./img/".time().".jpg";
	imagejpeg($img,$new_path);
	imagedestroy($img);
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--禁止浏览器缩放-->
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type" />
<!--清除浏览器缓存-->
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT">
<!--iPhone 手机上设置手机号码不被显示为拨号链接）-->
<meta content="telephone=no, address=no" name="format-detection" />
<!--IOS私有属性，可以添加到主屏幕-->
<meta name="apple-mobile-web-app-capable" content="yes" />
<!--屏幕顶部条的颜色-->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="./js/jquery-2.1.4.min.js" type="text/javascript"></script>
<title>不翻船版小船说翻就翻生成器</title>
</head>
<style>
	body{ margin:0px; padding:0px; background-color:#dedede; font-size:1rem;}
	.quan{ width:100%; background-color:#fff;}
	.ceng{ padding-bottom:0.7rem; padding-top:0.7rem; border-bottom:1px solid #dedede; border-top:1px solid #dedede; width:100%;}
	.left{ float:left; width:20%; margin-left:5%; color:#989898;}
	.right{ float:left; margin-left:5%; width:70%}
	.queding{ width:90%; margin:0px auto; height:3rem; line-height:3rem; text-align:center; color:#fff; background-color:#18B4ED; border-radius:5px; }
	.ca{ width:100%; padding-top:0.8rem; padding-bottom:0.8rem; color:#fff; text-align:center; background-color:#09F;}
	.cc{height:3rem; line-height:3rem; background-color:#000;filter:alpha(opacity=90);-moz-opacity:0.9;-khtml-opacity: 0.9;opacity: 0.9; 
		font-size:1.5rem; font-weight:800; color:#fff; z-index:950; position:fixed; top:0px; display:none; width:100%;}
	.show{ display:none; width:100%; background-color:#000;filter:alpha(opacity=80);-moz-opacity:0.8;-khtml-opacity: 0.8;opacity: 0.8; position:absolute; top:0px; left:0px;}
</style>
<body>
<?php if(empty($_GET['key'])){?>
<header style="padding:1rem 1rem 1rem 1rem;">
	<img src="./2.jpg" width="100%" style=""/>
</header>
<div style="height:1rem;"></div>
<div class="quan">
	<div class="ceng">
        <div class="right" style="width:95%;" id="go">
        	<span style="color:blue">返回翻船版>></span>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="ceng" style="border-top:none;">
        <div class="left">第一句左</div>
        <div class="right">
        	<input type="text" id="text1" name="text1" placeholder="第一句左！" style="background:none; border:none;font-size:1rem;"/>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="ceng" style="border-top:none;">
        <div class="left">第一句右</div>
        <div class="right">
        	<input type="text" id="text2" name="text2" placeholder="第一句右！" style="background:none; border:none;font-size:1rem;"/>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="ceng" style="border-top:none;">
        <div class="left">第二句左</div>
        <div class="right">
        	<input type="text" id="text3" name="text3" placeholder="第二句左！" style="background:none; border:none;font-size:1rem;"/>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="ceng" style="border-top:none;">
        <div class="left">第二句右</div>
        <div class="right">
        	<input type="text" id="text4" name="text4" placeholder="第二句右！" style="background:none; border:none;font-size:1rem;"/>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="ceng" style="border-top:none;">
        <div class="left">结尾语</div>
        <div class="right">
        	<input type="text" id="text5" name="text5" placeholder="结尾语！" style="background:none; border:none;font-size:1rem;"/>
        </div>
        <div style="clear:both"></div>
    </div>
    <div style="height:0.7rem;"></div>
    <div class="queding" id="queding">确定</div>
    <div style="height:0.7rem;"></div>
    
    <div style="height:4rem;"></div>
    <div class="bum" style="width:100%; height:56px; line-height:56px; color:#00a5e0; position:fixed; bottom:0px; text-align:center; background-image:url(./bj.png);">
    	<div style=" float:left; width:49.5%; border-right:1px solid #aeaeae;"><a href="../" style="color:#00a5e0;">更多装逼功能</a></div>
        <div style=" float:left; width:49.5%;" id="gz">关注三益健康汇</div>
        <div style="clear:both"></div>
    </div>
</div>
<?Php }else{?>
	<div class="ca">长按下方图片点选保存图片</div>
    <div style="padding-top:0.7rem; background-color:#fff; width:100%;">
		<img src="<?php echo $new_path;?>" width="100%" style=""/>
	</div>
    <div style="height:0.7rem;"></div>
    <div class="queding" id="scq">不翻船版小船说翻就翻生成器</div>
    <div style="height:0.7rem;"></div>
<?php }?>

	<div class="show" id="show">
    	<div class="cc" id="close">&nbsp;&nbsp;&nbsp;X</div>
    </div>
    <div style=" display:none;z-index:1000; font-size:1.2rem; position:fixed; top:10rem; width:50%; left:25%; color:#fff;" id="ewm">
        <div style=" padding-top:0.2rem; padding-bottom:0.2rem;">长按下方二维码图片</div>
        <div style=" padding-top:0.2rem; padding-bottom:0.2rem;">点选识别图中二维码</div>
        <div><img src="./ewm.jpg" width="100%;"/></div>
    </div>
</body>

<script>
	$("#go").click(function(){
		window.location.href = "./yfc.php";	
	});
</script>

<script>

	$("#scq").click(function(){
		window.location.href = "./bfc.php";	
	});
	$("#queding").click(function(){
		var text1 = $("#text1").val();
		var text2 = $("#text2").val();
		var text3 = $("#text3").val();
		var text4 = $("#text4").val();
		var text5 = $("#text5").val();
		if(!text1)
		{
			return;
		}
		if(!text2)
		{
			return;
		}
		if(!text3)
		{
			return;
		}
		if(!text4)
		{
			return;
		}
		if(!text5)
		{
			return;
		}
		window.location.href = "./bfc.php?key=1&text1="+text1+"&text2="+text2+"&text3="+text3+"&text4="+text4+"&text5="+text5;
	});
	
	function closeceng()
	{
		$("#show").css("display","none");
		$("#ewm").css("display","none");
		$("#close").css("display","none");
	}
	
	$("#gz").click(function(){
		var w = $(document).width();
		var h = $(document).height();
		
		$("#show").css("display","block");
		$("#show").css("width",w);
		$("#show").css("height",h);
		
		$("#close").css("display","block");
		
		$("#ewm").css("display","block");
	});
	$("#close").click(closeceng);
</script>

</html>