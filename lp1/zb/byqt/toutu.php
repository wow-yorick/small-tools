<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(767, 1000);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 0, 4, 2);

$text = $name;

$date = date("Y-m-d");

$font = '../../zb/font/liguofu.ttf';
imagecopy($im,$bg,0,0,0,0,767,1000);
imagedestroy($bg);
imagettftext($im, 18, 0, 413, 612, $black, $font, $text);
imagettftext($im, 18, 0, 414, 634, $black, $font, $date);

imagejpeg($im);
imagedestroy($im);
?>