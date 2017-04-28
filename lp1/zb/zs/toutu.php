<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(615, 934);
$bg = imagecreatefromjpeg('1.jpg');
imagecopy($im,$bg,0,0,0,0,615,934);
imagedestroy($bg);
$black = imagecolorallocate($im, 50, 50, 50);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 15, -3, 270, 350, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>