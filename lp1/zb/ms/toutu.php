<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 1116);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,640,1116);
imagedestroy($bg);
$black = imagecolorallocate($im, 118, 118, 118);
$blacka = imagecolorallocate($im, 158, 158, 158);
$text = $name;
$font = '../../zb/font/msyh.ttf';
imagettftext($im, 16, 0, 159, 305, $black, $font, $text);

$showtime=date("Y-m-d h:m:s");
$fonta = '../../zb/font/msyh.ttf';
imagettftext($im, 13, 0, 115, 892, $blacka, $fonta, $showtime);
imagettftext($im, 13, 0, 115, 920, $blacka, $fonta, $showtime);
imagettftext($im, 13, 0, 115, 948, $blacka, $fonta, $showtime);
imagejpeg($im);
imagedestroy($im);
?>