<?php
header("content-type:image/png");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(631, 397);
$bg = imagecreatefrompng('9.png');
imagecopy($im,$bg,0,0,0,0,631,397);
imagedestroy($bg);
$black = imagecolorallocate($im, 249, 249, 249);
$text = $name;
$font = '../font/song.ttf';
imagettftext($im, 10, 0, 425, 91, $black, $font, $text);



imagejpeg($im);
imagedestroy($im);
?>