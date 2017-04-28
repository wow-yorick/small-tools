<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"17wap.cn";
$id = $_GET['id']?$_GET['id']:"5";
$im = imagecreatetruecolor(639, 1136);
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
imagecopy($im,$bg,0,0,0,0,630,1136);
imagedestroy($bg);
$black = imagecolorallocate($im, 250, 250, 250);
$font = '../font/fh.ttf';

$showtime=date("h:m");
imagettftext($im, 80, 0, 180, 220, $black, $font, $showtime);

$showtime=date("m月d日");
imagettftext($im, 20, 0, 255, 260, $black, $font, $showtime);

$blackb = imagecolorallocate($im, 240, 240, 240);
imagettftext($im, 18, 0, 250, 895, $blackb, $font, $name);

imagejpeg($im);
imagedestroy($im);
?>