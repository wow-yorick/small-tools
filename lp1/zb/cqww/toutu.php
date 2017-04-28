<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 1116);
$bg = imagecreatefrompng('7.png');
imagecopy($im,$bg,0,0,0,0,640,1116);
imagedestroy($bg);
$black = imagecolorallocate($im, 118, 118, 118);
$blacka = imagecolorallocate($im, 158, 158, 158);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 16, 0, 159, 305, $black, $font, $text);

$fonta = '../font/msyh.ttf';
imagettftext($im, 13, 0, 115, 892, $blacka, $fonta, $showtime);
imagettftext($im, 13, 0, 115, 920, $blacka, $fonta, $showtime);
imagettftext($im, 13, 0, 115, 948, $blacka, $fonta, $showtime);
imagejpeg($im);
imagedestroy($im);
?>