<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$sc = $_GET['sc']?$_GET['sc']:"马上";
$im = imagecreatetruecolor(796, 962);
$bg = imagecreatefrompng('l.png');
imagecopy($im,$bg,0,0,0,0,796,962);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/song.ttf';
imagettftext($im, 40, 0, 310, 741, $black, $font, $text);
imagejpeg($im);
imagedestroy($im);
?>