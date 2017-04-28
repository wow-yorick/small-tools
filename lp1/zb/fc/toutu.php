<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$id = $_GET['id']?$_GET['id']:"4";
$im = imagecreatetruecolor(920, 690);
if($id == '4'){ 
$bg = imagecreatefromjpeg('toutu4.jpg');
}else if($id == '3'){ 
$bg = imagecreatefromjpeg('toutu3.jpg');
}else if($id == '2'){ 
$bg = imagecreatefromjpeg('toutu2.jpg');
}else if($id == '1'){ 
$bg = imagecreatefromjpeg('toutu1.jpg');
}else{ 
 echo '条件不满足'; 
} 
imagecopy($im,$bg,0,0,0,0,920, 690);
imagedestroy($bg);
$black = imagecolorallocate($im, 90, 90, 90);
$text = $name;
$font = '../../zb/font/msyh.ttf';
imagettftext($im, 12, -1, 290, 201, $black, $font, $name);



imagejpeg($im);
imagedestroy($im);
?>