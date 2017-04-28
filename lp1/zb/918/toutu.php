<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(800, 499);
$bg = imagecreatefromjpeg('w.jpg');
imagecopy($im,$bg,0,0,0,0,920,690);
imagedestroy($bg);
$black = imagecolorallocate($im, 30, 30, 30);
$text = $name;
$font = '../font/gb.ttf';
imagettftext($im, 18, -1, 560, 477, $black, $font, $text);

$showtime=date("Y-m-d");
imagettftext($im, 18, -1, 289, 522, $black, $font, $showtime);

imagejpeg($im);
imagedestroy($im);
?>