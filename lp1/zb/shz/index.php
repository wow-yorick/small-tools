<?php
error_reporting(0); 
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/> 
<title>丑男丑女身份证生成器</title>
<link type="text/css" rel="stylesheet" href="../css/frozen.css" />
<style>
.ui-header-positive, .ui-footer-positive {
background-color: #f05557;
color: #fff;
}
a {
color: #f05557;
}
</style>
</head>
<body ontouchstart="">
<?php if($_GET['name']){?>
	<header class="ui-header ui-header-positive ui-border-b">
	<h1>长按下方图片点选保存图片</h1>
</header>
<div class="wrapper"><br><br>
	<img src="toutu<?=$_GET['id']?>.php?name=<?=$_GET['name']?>" width="100%"/>
</div>

<?php }else{ ?>

<header class="ui-header ui-header-positive ui-border-b">
	<h1>丑男丑女身份证生成器</h1>
</header>
<div class="wrapper"><br>
	<img src="icon.jpg" width="50%" style="margin:30px 25%;"/>
	<div class="ui-form">
    	<form action="">
        	<div class="ui-form-item ui-border-b">
            	<label for="#">姓名</label>
            	<input type="text" name="name" placeholder="输入你的姓名"/>
        	</div>
			<div class="ui-form-item ui-border-b">
            	<label>选证</label>
            	<div class="ui-select">
                	<select name="id">
                    	<option value ="1">丑女证</option>
                    	<option value ="2">丑男证</option>
			
                	</select>
            	</div>
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