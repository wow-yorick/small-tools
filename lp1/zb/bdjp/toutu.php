<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(524, 640);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 55, 55, 55);

$text = $name;
$font = '../../zb/font/liguofu.ttf';
imagecopy($im,$bg,0,0,0,0,524,640);
imagedestroy($bg);
imagettftext($im, 22, -30, 90, 292, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>