<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 426);
$bg = imagecreatefromjpeg('bw.jpg');
imagecopy($im,$bg,0,0,0,0,640,426);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 10, 0, 145, 75, $black, $font, $text);
imagettftext($im, 10, 0, 116, 94, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>