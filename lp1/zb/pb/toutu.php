<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 788);
$bg = imagecreatefrompng('b.png');
imagecopy($im,$bg,0,0,0,0,640,788);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 50);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 10, 0, 300, 210, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>