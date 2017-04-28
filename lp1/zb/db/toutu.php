<?php

header("content-type:image/jpeg");

$name = $_GET['name'];
$city = $_GET['city'];

$im = imagecreatetruecolor(640, 1138);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,640,1138);

imagedestroy($bg);

$black = imagecolorallocate($im, 60, 60, 60);

$text = $name;

$font = '../../zb/font/fh.ttf';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

$blacka = imagecolorallocate($im, 153, 148, 90);

$moren = '：';

//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);


imagettftext($im, 20, 0, 31, 829, $blacka, $font, $name.$moren);
imagettftext($im, 20, 0, 489, 1089, $blacka, $font, $city);

imagejpeg($im);

imagedestroy($im);

?>