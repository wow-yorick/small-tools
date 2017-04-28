<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
$namea = $_GET['namea'];
$nameb = $_GET['nameb'];

$im = imagecreatetruecolor(800, 500);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,900,539);

imagedestroy($bg);

$black = imagecolorallocate($im, 60, 60, 60);

$text = $name;

$font = '../../zb/font/fh.ttf';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

$blacka = imagecolorallocate($im, 0, 0, 0);

//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);


imagettftext($im, 14, 0, 285, 217, $blacka, $font, $name);
imagettftext($im, 14, 0, 500, 250, $blacka, $font, $namea);
imagettftext($im, 14, 0, 391, 280, $blacka, $font, $nameb);
//imagettftext($im, 15, 0, 730, 191, $blacka, $font, $name);
//imagettftext($im, 15, 0, 730, 229, $blacka, $font, $namea);


imagejpeg($im);

imagedestroy($im);

?>