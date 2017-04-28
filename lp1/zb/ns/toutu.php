<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"www.at168.com";
$id = $_GET['id']?$_GET['id']:"5";
$im = imagecreatetruecolor(640, 447);
if($id == '5'){ 
$bg = imagecreatefromjpeg('toutu5.jpg');
}else if($id == '4'){ 
$bg = imagecreatefromjpeg('toutu4.jpg');
}else if($id == '3'){ 
$bg = imagecreatefromjpeg('toutu3.jpg');
}else if($id == '2'){ 
$bg = imagecreatefromjpeg('toutu2.jpg');
}
else if($id == '1'){ 
$bg = imagecreatefromjpeg('toutu1.jpg');
}
else{ 
 echo '条件不满足'; 
} 
imagecopy($im,$bg,0,0,0,0,920,690);
imagedestroy($bg);
$black = imagecolorallocate($im, 90, 90, 90);
$font = '../../zb/font/msyh.ttf';

imagettftext($im, 20, 0, 265, 72, $black, $font, $name);

$blackb = imagecolorallocate($im, 80, 116, 132);
imagettftext($im, 18, 0, 119, 331, $blackb, $font, $name);

imagejpeg($im);
imagedestroy($im);
?>