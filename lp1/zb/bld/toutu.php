<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
$time = $_GET['time'];

$im = imagecreatetruecolor(597, 837);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,597,837);

imagedestroy($bg);

$black = imagecolorallocate($im, 60, 60, 60);

$text = $name;

$font = '../../zb/font/fh.ttf';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

$blacka = imagecolorallocate($im, 45, 40, 44);

//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);


imagettftext($im, 11, 2, 65, 729, $blacka, $font, $name);
imagettftext($im, 11, 0, 251, 730, $blacka, $font, $time);
imagettftext($im, 10, 0, 518, 689, $blacka, $font, $time);


imagejpeg($im);

imagedestroy($im);

?>