<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";

$im = imagecreatetruecolor(640, 1116);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,640,1116);

imagedestroy($bg);

$black = imagecolorallocate($im, 134, 134, 134);

$text = $name;

$font = '../../zb/font/fh.ttf';
//$font1 = '../../zb/font/st.ttc';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

date_default_timezone_set('Asia/Shanghai');//此句用于消除时间差
$black = imagecolorallocate($im, 118, 118, 118);
$blacka = imagecolorallocate($im, 134, 134, 134);

$nowtime=date("Y-m-d H:i:s");
$cj_time=date('Y-m-d H:i:s',strtotime("$nowtime-3 hour"));
$fk_time=date('Y-m-d H:i:06',strtotime("$nowtime-1 hour"));
//$fh_time=date('Y-m-d H:i:s',strtotime("$nowtime-3 minute"));
$fh_time=date('Y-m-d H:i:s',strtotime("$nowtime-328 second"));

imagettftext($im, 15, 0, 160, 304, $black, $font, $name);
imagettftext($im, 12, 0, 116, 892, $blacka, $font, $cj_time);
imagettftext($im, 12, 0, 116, 920, $blacka, $font, $fk_time);
imagettftext($im, 12, 0, 116, 948, $blacka, $font, $fh_time);



imagejpeg($im);

imagedestroy($im);

?>