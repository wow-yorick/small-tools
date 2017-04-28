<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 640);
$bg = imagecreatefromjpeg('yjx.jpg');
imagecopy($im,$bg,0,0,0,0,640,640);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 16, 0, 90, 116, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>