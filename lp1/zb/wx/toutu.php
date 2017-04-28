<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(597, 799);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 10, 10, 10);

$text = $name;
$font = '../../zb/font/lxk.ttf';
imagecopy($im,$bg,0,0,0,0,597,799);
imagedestroy($bg);
imagettftext($im, 20, -12, 95, 354, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>