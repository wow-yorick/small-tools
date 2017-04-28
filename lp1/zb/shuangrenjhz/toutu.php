<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
$namea = $_GET['namea'];
$nameb = $_GET['nameb'];

$im = imagecreatetruecolor(640, 960);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,640,960);

imagedestroy($bg);

$black = imagecolorallocate($im, 60, 60, 60);

$text = $name;

$font = '../../zb/font/msyh.ttf';
$font1 = '../../zb/font/fh.ttf';


$blacka = imagecolorallocate($im, 138, 127, 107);
$blackb = imagecolorallocate($im, 246, 38, 132);

$showtime=date("Y年m月d日");


imagettftext($im, 12, 0, 127, 492, $blacka, $font, $name);
imagettftext($im, 12, -7, 379, 488, $blacka, $font, $namea);
imagettftext($im, 12, 0, 127, 567, $blacka, $font, $showtime);
imagettftext($im, 12, -5, 368, 567, $blacka, $font, $showtime);

imagettftext($im, 13, 0, 253, 844, $blackb, $font1, $nameb);


imagejpeg($im);

imagedestroy($im);

?>