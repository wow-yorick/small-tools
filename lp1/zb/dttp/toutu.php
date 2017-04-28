<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$im = imagecreatetruecolor(586, 440);
$bg = imagecreatefromjpeg('toutu.jpg');

$black = imagecolorallocate($im, 245, 246, 241);

$text = $name;
$moren = "日本：地铁偷拍女士裙底 色狼";
$moren1 = "被捕";

$font = '../../zb/font/fh.ttf';
imagecopy($im,$bg,0,0,0,0,586,440);
imagedestroy($bg);
imagettftext($im, 18, 0, 40, 383, $black, $font, $moren.$text.$moren1);

imagejpeg($im);
imagedestroy($im);
?>