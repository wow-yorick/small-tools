<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";

$im = imagecreatetruecolor(800, 1110);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,800,1110);

imagedestroy($bg);

$black = imagecolorallocate($im, 134, 134, 134);

$text = $name;

$font = '../../zb/font/xjl.ttf';

//date_default_timezone_set('Asia/Shanghai');//此句用于消除时间差
$black = imagecolorallocate($im, 76, 78, 91);


$nowtime=date("Y年m月d日");
$cj_time=date('Y-m-d H:i:s',strtotime("$nowtime-3 hour"));
$fk_time=date('Y-m-d H:i:06',strtotime("$nowtime-1 hour"));
$fh_time=date('Y-m-d H:i:s',strtotime("$nowtime-328 second"));

imagettftext($im, 29, 0, 511, 836, $black, $font, $name);
imagettftext($im, 29, 0, 491, 885, $black, $font, $nowtime);

imagejpeg($im);

imagedestroy($im);

?>