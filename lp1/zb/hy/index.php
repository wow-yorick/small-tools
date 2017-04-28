<?php 
$id=$_GET['id'];
$name=$_GET['name'];
if($id!=null)
	{
	$html='<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title>装逼手册</title>
<link type="text/css" rel="stylesheet" href="http://i.gtimg.cn/vipstyle/frozenui/1.3.0/css/frozen.css" />
<style>
.follow{font-size:20px;line-height:30px;color:#fff;text-align:center;padding-top:30%;z-index:2000;position:fixed;top:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,.9);display:none;}
.follow span{font-size:40px;position:absolute;top:10px;left:10px;}
.follow img{width:180px;margin-top:10px;}
</style></head>
<body ontouchstart="">
<header class="ui-header ui-header-positive ui-border-b">
	<h1>长按下方图片点选保存图片</h1>
</header>
<section class="ui-container">
	<img src="http://odkah.com/zb/hy/toutu.php?id='.$id.'&name='.$name.'" width="100%">
</section>
</body>
</html>';
echo $html;
	exit;
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title>装逼手册</title>
<link type="text/css" rel="stylesheet" href="http://i.gtimg.cn/vipstyle/frozenui/1.3.0/css/frozen.css" />
<style>
.follow{font-size:20px;line-height:30px;color:#fff;text-align:center;padding-top:30%;z-index:2000;position:fixed;top:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,.9);display:none;}
.follow span{font-size:40px;position:absolute;top:10px;left:10px;}
.follow img{width:180px;margin-top:10px;}
</style></head>
<body ontouchstart="">
<header class="ui-header ui-header-positive ui-border-b">
	<h1>婚姻证书生成器</h1>
</header>
<section class="ui-container" style="padding-bottom:55px;">
	<img src="http://cdn.luoyangpai.com/zb/hy/icon.jpg" width="50%" style="margin:40px 25%">
	<div class="ui-form ui-border-t">
    	<form action="">
        	<div class="ui-form-item ui-border-b">
            	<label>姓名</label>
            	<input type="text" name="name" placeholder="输入你的姓名">
        	</div>
        	<div class="ui-form-item ui-border-b">
            	<label>证书</label>
            	<div class="ui-select">
                	<select name="id">
                    	<option value ="1">结婚证</option>
                    	<option value ="2">离婚证</option>
                	</select>
            	</div>
        	</div>
			<div class="ui-btn-wrap">
    			<button class="ui-btn-lg ui-btn-primary">确定</button>
			</div>
    	</form>
	</div>
</section>
<?php 
} 
require_once '../foot.php';
?>
</body>
</html>