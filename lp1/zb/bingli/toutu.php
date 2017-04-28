<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(700, 933);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 55, 55, 55);

$text = $name;
$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,700,933);
imagedestroy($bg);
imagettftext($im, 17, 0, 235, 680, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>