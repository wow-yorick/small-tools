<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(700, 530);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 0, 0, 0);

$text = $name;
$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,700,530);
imagedestroy($bg);
imagettftext($im, 20, 0, 195, 237, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>