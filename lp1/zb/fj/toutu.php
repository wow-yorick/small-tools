<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(920, 690);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,920,690);
imagedestroy($bg);
$black = imagecolorallocate($im, 30, 30, 30);
$text = $name;
$font = '../../zb/font/msyh.ttf';
imagettftext($im, 18, -1, 252, 350, $black, $font, $text);

$showtime=date("Y-m-d");
imagettftext($im, 18, -1, 289, 522, $black, $font, $showtime);

imagejpeg($im);
imagedestroy($im);
?>