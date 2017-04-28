<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.at168.com";

$namea = $_GET['namea'];

//$id = $_GET['id']?$_GET['id']:"www.at168.com";

$im = imagecreatetruecolor(597, 837);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,597,837);

imagedestroy($bg);

$black = imagecolorallocate($im, 60, 60, 60);

$text = $name;

$font = '../../zb/font/msyh.ttf';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);





$blacka = imagecolorallocate($im, 37, 33, 21);



//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);



imagettftext($im, 16, 2, 271, 262, $blacka, $font, $name);

imagettftext($im, 16, 2, 410, 258, $blacka, $font, $namea);





imagejpeg($im);

imagedestroy($im);

?>