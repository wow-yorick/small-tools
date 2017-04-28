<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 960);
$bg = imagecreatefrompng('icon.png');
imagecopy($im,$bg,0,0,0,0,640,960);
imagedestroy($bg);
$black = imagecolorallocate($im, 113, 107, 108);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 15, 0, 238, 168, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>