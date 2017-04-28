<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$sc = $_GET['sc']?$_GET['sc']:"马上";
$im = imagecreatetruecolor(636, 741);
$bg = imagecreatefromjpeg('ck.jpg');
imagecopy($im,$bg,0,0,0,0,636,741);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 16, 0, 105, 151, $black, $font, $text);
imagejpeg($im);
imagedestroy($im);
?>