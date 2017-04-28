<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(800, 533);
$bg = imagecreatefrompng('lal.png');
imagecopy($im,$bg,0,0,0,0,800,533);
imagedestroy($bg);
$black = imagecolorallocate($im, 250, 250, 250);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 15, 0, 65, 91, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>