<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"www.at168.com";
$id = $_GET['id']?$_GET['id']:"4";
$im = imagecreatetruecolor(640, 734);
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
imagecopy($im,$bg,0,0,0,0,640,734);
imagedestroy($bg);
$black = imagecolorallocate($im, 30, 30, 30);
$font = '../../zb/font/xjl.ttf';
$txt = $name.":";
imagettftext($im, 23, 0, 82, 230, $black, $font, $txt);



imagejpeg($im);
imagedestroy($im);
?>