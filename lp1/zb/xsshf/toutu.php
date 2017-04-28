<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(550, 686);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 11, 9, 4);

$text = $name;
$moren = "这个月的";
$moren1 = "两万元生活费快";
$moren2 = "转给我哦";
$date = date("Y-m-d");
$love = "I LOVE YOU";
$font = '../../zb/font/gb.ttf';
imagecopy($im,$bg,0,0,0,0,550,686);
imagedestroy($bg);
imagettftext($im, 20, -26, 345, 253, $black, $font, $text.$moren);
imagettftext($im, 20, -26, 332, 282, $black, $font, $moren1);
imagettftext($im, 20, -26, 319, 309, $black, $font, $moren2);
imagettftext($im, 20, -26, 349, 385, $black, $font, $love);
imagettftext($im, 20, -26, 345, 419, $black, $font, $date);

imagejpeg($im);
imagedestroy($im);
?>