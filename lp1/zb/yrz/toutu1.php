<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 448);
$bg = imagecreatefromjpeg('yrz1.jpg');
imagecopy($im,$bg,0,0,0,0,640,448);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 10, 0, 410, 55, $black, $font, $text);
imagettftext($im, 10, 0, 479, 189, $black, $font, $text);




imagejpeg($im);
imagedestroy($im);
?>