<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(626, 843);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 10, 10, 10);

$text = $name;
$font = '../../zb/font/st.ttc';
imagecopy($im,$bg,0,0,0,0,626,843);
imagedestroy($bg);
imagettftext($im, 24, 0, 105, 115, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>