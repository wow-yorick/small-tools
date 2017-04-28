<?php
header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"MOS社团";
$sex = $_GET['sex']?$_GET['sex']:"男";
$shen = $_GET['shen']?$_GET['shen']:"男";


$im = imagecreatetruecolor(1241, 1754);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,1241,1754);
imagedestroy($bg);
$black = imagecolorallocate($im, 40, 40, 40);
$text = $name;
$date = date("Y-m-d");
$font = '../../zb/font/fh.ttf';
imagettftext($im, 20, 0, 280, 565, $black, $font, $text);
imagettftext($im, 20, 0, 280, 605, $black, $font, $sex);
imagettftext($im, 20, 0, 280, 735, $black, $font, $shen);
imagettftext($im, 17, 0, 929, 528, $black, $font, $date);


imagejpeg($im);
imagedestroy($im);
?>