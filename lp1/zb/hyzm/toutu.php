<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(500, 333);
$bg = imagecreatefrompng('hz.png');
imagecopy($im,$bg,0,0,0,0,1008,750);
imagedestroy($bg);
$black = imagecolorallocate($im, 30, 30, 30);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 10, -1, 258, 278, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>