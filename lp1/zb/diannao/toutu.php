<?php

header("content-type:image/jpeg");

$name = $_GET['name'];
$date = $_GET['date'];

$im = imagecreatetruecolor(700, 933);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,700,933);

imagedestroy($bg);

$black = imagecolorallocate($im, 60, 60, 60);

$text = $name;

$font = '../../zb/font/song.ttf';
$font1 = '../../zb/font/xjl.ttf';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

$black = imagecolorallocate($im, 122, 130, 176);
$blacka = imagecolorallocate($im, 75, 63, 63);

$moren = '：';

//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);


imagettftext($im, 10, 6, 427, 292, $black, $font, $date);
imagettftext($im, 20, -5, 428, 898, $blacka, $font1, $name);


imagejpeg($im);

imagedestroy($im);

?>