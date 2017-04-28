<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(580, 400);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 245, 246, 241);

$text = $name;
$moren = "色狼";
$moren1 = "伸出咸猪手 被抓竟犯癫痫";

$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,580,400);
imagedestroy($bg);
imagettftext($im, 15, 0, 100, 385, $black, $font, $moren.$text.$moren1);

imagejpeg($im);
imagedestroy($im);
?>