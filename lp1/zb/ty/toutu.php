<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"极虎网络";
$im = imagecreatetruecolor(608, 332);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 255, 220, 226);

$text = $name;
$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,608,332);
imagedestroy($bg);
imagettftext($im, 23, 0, 180, 233, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>