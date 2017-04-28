<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 360);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,640,853);
imagedestroy($bg);
$black = imagecolorallocate($im, 45, 45, 45);
$text = $name;
$font = '../../zb/font/liguofu.ttf';



imagettftext($im, 13, 0, 485, 285, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>