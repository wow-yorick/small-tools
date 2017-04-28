<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(1178, 721);
$bg = imagecreatefromjpeg('shz2.png');
imagecopy($im,$bg,0,0,0,0,1178,721);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 22, 0, 270, 162, $black, $font, $text);


imagejpeg($im);
imagedestroy($im);
?>