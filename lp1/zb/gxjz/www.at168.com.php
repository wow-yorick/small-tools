<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$id = $_GET['id']?$_GET['id']:"6";
$im = imagecreatetruecolor(400, 281);

$black = imagecolorallocate($im, 20, 20, 20);

$text = $name;
$font = '../../zb/font/msyh.ttf';
if($id == '1'){ 
$bg = imagecreatefromjpeg('toutu1.jpg');
}else if($id == '2'){ 
$bg = imagecreatefromjpeg('toutu2.jpg');
}else if($id == '3'){ 
$bg = imagecreatefromjpeg('toutu3.jpg');
}else if($id == '4'){ 
$bg = imagecreatefromjpeg('toutu4.jpg');
}else if($id == '5'){ 
$bg = imagecreatefromjpeg('toutu5.jpg');
}else if($id == '6'){ 
$bg = imagecreatefromjpeg('toutu6.jpg');
}else{ 
 echo '条件不满足'; 
} 
imagecopy($im,$bg,0,0,0,0,400,281);
imagedestroy($bg);
imagettftext($im, 16, 0, 65, 113, $black, $font, $text);


$showtime=date("Y    m   d");
imagettftext($im, 10, -1, 219, 210, $black, $font, $showtime);


imagejpeg($im);
imagedestroy($im);
?>