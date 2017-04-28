<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 853);
$bg = imagecreatefrompng('zz.png');
imagecopy($im,$bg,0,0,0,0,640,853);
imagedestroy($bg);
$black = imagecolorallocate($im, 20, 20, 20);
$text = $name;
$font = '../font/msyh.ttf';
imagettftext($im, 20, 0, 110, 122, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>