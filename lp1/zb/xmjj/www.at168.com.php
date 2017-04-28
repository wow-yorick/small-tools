<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$id = $_GET['id']?$_GET['id']:"6";
$im = imagecreatetruecolor(640, 480);
if($id == '6'){ 
$bg = imagecreatefromjpeg('toutu6.jpg');
}
else if($id == '5'){ 
$bg = imagecreatefromjpeg('toutu5.jpg');
}
else if($id == '4'){ 
$bg = imagecreatefromjpeg('toutu4.jpg');
}
else if($id == '3'){ 
$bg = imagecreatefromjpeg('toutu3.jpg');
}
else if($id == '2'){ 
$bg = imagecreatefromjpeg('toutu2.jpg');
}
else if($id == '1'){ 
$bg = imagecreatefromjpeg('toutu1.jpg');
}
else{ 
 echo '条件不满足'; 
} 

$black = imagecolorallocate($im, 100, 100, 100);

$text = $name;
$font = '../../zb/font/lxk.ttf';
$fonta = '../../zb/font/wz.ttf';
imagecopy($im,$bg,0,0,0,0,640,480);
imagedestroy($bg);
imagettftext($im, 10, 0, 220, 182, $black, $font, $text);


$showtime=date("Y      m       d");
imagettftext($im, 7, 0, 60, 246, $black, $fonta, $showtime);
$blacka = imagecolorallocate($im, 80, 80, 80);



$showtimea=date("Y                    m               d");

imagettftext($im, 7, 0, 273, 166, $blacka, $fonta, $showtimea);



imagejpeg($im);
imagedestroy($im);
?>