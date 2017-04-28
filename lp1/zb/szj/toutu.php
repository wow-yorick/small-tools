<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 1138);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,640,1138);
imagedestroy($bg);
$black = imagecolorallocate($im, 255, 255, 255);
$text = $name;
$font = '../../zb/font/msyh.ttf';
imagettftext($im, 19, 0, 379, 786, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>