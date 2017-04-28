<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(815, 519);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 111, 111, 111);

$text = $name;
$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,815,519);
imagedestroy($bg);
imagettftext($im, 9, 0, 495, 154, $black, $font, $text);

$showtime=date("Y.m.d");
imagettftext($im, 14, 0, 535, 427, $black, $font, $showtime);

imagejpeg($im);
imagedestroy($im);
?>