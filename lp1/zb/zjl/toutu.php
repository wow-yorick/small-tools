<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";

$im = imagecreatetruecolor(920, 690);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,920,690);

imagedestroy($bg);

$black = imagecolorallocate($im, 134, 134, 134);

$text = $name;

$font = '../../zb/font/fh.ttf';


$black = imagecolorallocate($im, 1, 2, 6);

//date_default_timezone_set('Asia/Shanghai');//此句用于消除时间差

$nowtime=date("Y-m-d");
$time_y=date('Y');
$time_m=date('m');
$time_d=date('d',strtotime("$nowtime+3 day"));
$time="19:30";

imagettftext($im, 17, 1, 562, 385, $black, $font, $name);
imagettftext($im, 15, 0, 186, 356, $black, $font, $time_y);
imagettftext($im, 15, 0, 289, 356, $black, $font, $time_m);
imagettftext($im, 15, 0, 387, 356, $black, $font, $time_d);
imagettftext($im, 15, 0, 460, 356, $black, $font, $time);

imagejpeg($im);

imagedestroy($im);

?>