<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(1178, 712);
$bg = imagecreatefromjpeg('shz1.png');
imagecopy($im,$bg,0,0,0,0,1178,712);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 22, 0, 270, 160, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>