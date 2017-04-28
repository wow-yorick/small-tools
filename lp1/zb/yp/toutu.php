<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$id = $_GET['id']?$_GET['id']:"1";
$im = imagecreatetruecolor(640, 853);
if($id == '1'){ 
$bg = imagecreatefromjpeg('toutu1.jpg');
}
else if($id == '2'){ 
$bg = imagecreatefromjpeg('toutu2.jpg');
}
else if($id == '3'){ 
$bg = imagecreatefromjpeg('toutu3.jpg');
}
else{ 
 echo '条件不满足'; 
} 

$black = imagecolorallocate($im, 0, 0, 0);

$text = $name;
$font = '../../zb/font/liguofu.ttf';
imagecopy($im,$bg,0,0,0,0,640,853);
imagedestroy($bg);
imagettftext($im, 16, 0, 432, 745, $black, $font, $text);




imagejpeg($im);
imagedestroy($im);
?>