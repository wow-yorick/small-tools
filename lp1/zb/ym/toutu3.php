<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(400, 288);
$bg = imagecreatefromjpeg('toutu1.jpg');

$black = imagecolorallocate($im, 80, 80, 80);

$text = $name;
$font = '../../zb/font/msyh.ttf';
imagecopy($im,$bg,0,0,0,0,400,288);
imagedestroy($bg);
imagettftext($im, 22, -5, 248, 152, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>