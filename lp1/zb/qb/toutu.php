<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(750, 1334);
$bg = imagecreatefrompng('qb.png');
imagecopy($im,$bg,0,0,0,0,750,1334);
imagedestroy($bg);
$black = imagecolorallocate($im, 250, 250, 250);
$text = $name;
$font = '../font/song.ttf';
imagettftext($im, 28, 0, 520, 370, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>