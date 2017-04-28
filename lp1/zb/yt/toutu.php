<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(900, 630);
$bg = imagecreatefrompng('mb.png');
imagecopy($im,$bg,0,0,0,0,920,690);
imagedestroy($bg);
$black = imagecolorallocate($im, 30, 30, 30);
$text = $name;
$font = '../font/gb.ttf';
imagettftext($im, 10, -1, 229, 446, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>