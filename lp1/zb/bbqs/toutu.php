<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(564, 819);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 55, 55, 55);

$text = $name;
$font = '../../zb/font/liguofu.ttf';
imagecopy($im,$bg,0,0,0,0,564,819);
imagedestroy($bg);
imagettftext($im, 23, 0, 406, 624, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>