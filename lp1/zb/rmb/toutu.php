<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$sc = $_GET['sc']?$_GET['sc']:"马上";
$im = imagecreatetruecolor(601, 800);
$bg = imagecreatefrompng('rmb.png');
imagecopy($im,$bg,0,0,0,0,601,800);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/xjl.ttf';
imagettftext($im, 25, 0, 85, 369, $black, $font, $text);
imagejpeg($im);
imagedestroy($im);
?>