<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(440, 628);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 55, 55, 55);

$text = $name;
$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,440,628);
imagedestroy($bg);
imagettftext($im, 12, -6, 185, 449, $black, $font, $text);

imagejpeg($im);
imagedestroy($im);
?>