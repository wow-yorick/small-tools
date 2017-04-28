<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(1000, 568);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 28, 28, 28);

$text = $name;
$font = '../../zb/font/msyh.ttf';
imagecopy($im,$bg,0,0,0,0,1000,568);
imagedestroy($bg);
imagettftext($im, 18, 0, 128, 361, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>