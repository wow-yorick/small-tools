<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 960);
$bg = imagecreatefrompng('qs.png');
imagecopy($im,$bg,0,0,0,0,640,960);
imagedestroy($bg);
$black = imagecolorallocate($im, 30, 30, 30);
$text = $name;
$font = '../font/gb.ttf';
imagettftext($im, 40, -1, 480, 735, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>