<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(954, 635);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 10, 10, 10);

$text = $name;
$font = '../../zb/font/lxk.ttf';
imagecopy($im,$bg,0,0,0,0,954,635);
imagedestroy($bg);
imagettftext($im, 18, 0, 725, 510, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>