<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(400, 288);
$bg = imagecreatefromjpeg('hdsl.jpg');
imagecopy($im,$bg,0,0,0,0,400,288);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/fh.ttf';
imagettftext($im, 9, -19, 210, 84, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>