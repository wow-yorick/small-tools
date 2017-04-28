<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"www.at168.com";
$namea = $_GET['namea'];
$id = $_GET['id']?$_GET['id']:"www.at168.com";
$im = imagecreatetruecolor(1280, 1280);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,1280,1280);
imagedestroy($bg);
$black = imagecolorallocate($im, 60, 60, 60);
$text = $name;
$font = '../../zb/font/song.ttf';
$ida = number_format($id);
imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);


$blacka = imagecolorallocate($im, 108, 115, 96);

$showtime=date("m/d");
imagettftext($im, 30, 5.5, 370, 864, $blacka, $font, $showtime);

imagettftext($im, 20, 5.5, 350, 905, $blacka, $font, $name);
imagettftext($im, 20, 5.5, 416, 898, $blacka, $font, $namea);


imagejpeg($im);
imagedestroy($im);
?>