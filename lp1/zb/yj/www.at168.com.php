<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(600, 411);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 55, 55, 55);

$text = $name;
$font = '../../zb/font/wz.ttf';
imagecopy($im,$bg,0,0,0,0,600,411);
imagedestroy($bg);
imagettftext($im, 12, 0, 105, 344, $black, $font, $text);

$showtime=date("Y.m.d");
imagettftext($im, 9, 0, 105, 361, $black, $font, $showtime);
imagettftext($im, 9, 0, 292, 361, $black, $font, $showtime);
imagettftext($im, 9, 0, 474, 361, $black, $font, $showtime);

imagejpeg($im);
imagedestroy($im);
?>