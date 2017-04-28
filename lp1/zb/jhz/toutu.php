<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(580, 742);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,580,742);
imagedestroy($bg);
$black = imagecolorallocate($im, 131, 117, 108);
$text = $name;
$font = '../../zb/font/msyh.ttf';
imagettftext($im, 16, 0, 214, 195, $black, $font, $text);

$showtime=date("Y年m月d日");
imagettftext($im, 16, 0, 214, 288, $black, $font, $showtime);

imagejpeg($im);
imagedestroy($im);
?>