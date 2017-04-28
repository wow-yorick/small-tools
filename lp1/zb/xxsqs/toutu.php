<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
$sex = $_GET['sex']?$_GET['sex']:"boy";

$im = imagecreatetruecolor(730, 837);

if($sex == 'boy')
{
	$bg = imagecreatefromjpeg('toutu.jpg');
	}
else
{
	$bg = imagecreatefromjpeg('toutu2.jpg');
	}

imagecopy($im,$bg,0,0,0,0,730,837);

imagedestroy($bg);

$black = imagecolorallocate($im, 134, 134, 134);

$text = $name;

$font = '../../zb/font/gb.ttf';

$black = imagecolorallocate($im, 84, 112, 134);



imagettftext($im, 18, 0, 264, 133, $black, $font, $name);




imagejpeg($im);

imagedestroy($im);

?>