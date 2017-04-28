<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(400, 288);
$bg = imagecreatefromjpeg('toutu321.jpg');

$black = imagecolorallocate($im, 255, 255, 255);

$text = $name;
$font = '../../zb/font/msyh.ttf';
imagecopy($im,$bg,0,0,0,0,400,288);
imagedestroy($bg);
imagettftext($im, 12, 0, 360, 177, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>