<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神�&#65533;";
$im = imagecreatetruecolor(640,806);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 55, 55, 55);

$text = $name;
$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,640,806);
imagedestroy($bg);
imagettftext($im, 13, 0, 190, 580, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>