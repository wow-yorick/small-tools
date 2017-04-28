<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(600, 849);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 0, 0, 0);

$text = $name;
$font = '../../zb/font/msyh.ttf';
imagecopy($im,$bg,0,0,0,0,600,849);
imagedestroy($bg);
imagettftext($im, 15, 0, 132, 356, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>