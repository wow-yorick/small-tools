<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 960);
$bg = imagecreatefrompng('h.png');
imagecopy($im,$bg,0,0,0,0,640,960);
imagedestroy($bg);
$black = imagecolorallocate($im, 249, 249, 249);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 10, 0, 145, 80, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>