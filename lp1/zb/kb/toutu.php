<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$sc = $_GET['sc']?$_GET['sc']:"马上";
$im = imagecreatetruecolor(960, 640);
$bg = imagecreatefrompng('kb.png');
imagecopy($im,$bg,0,0,0,0,960,640);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/gb.ttf';
imagettftext($im, 25, 0, 730, 517, $black, $font, $text);
imagejpeg($im);
imagedestroy($im);
?>