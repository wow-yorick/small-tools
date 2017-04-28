<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(894, 625);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 123, 123, 123);

$text = $name;
$font = '../../zb/font/song.ttf';
imagecopy($im,$bg,0,0,0,0,894,625);
imagedestroy($bg);
imagettftext($im, 7.5, 0, 230, 444, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>