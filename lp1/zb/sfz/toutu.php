<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼神器";
$id = $_GET['id']?$_GET['id']:"1";
$im = imagecreatetruecolor(1178, 712);
if($id == '2'){ 
$bg = imagecreatefromjpeg('toutu2.jpg');
}
else if($id == '1'){ 
$bg = imagecreatefromjpeg('toutu.jpg');
}
else{ 
 echo '条件不满足'; 
} 

$black = imagecolorallocate($im, 64, 62, 73);

$text = $name;
$font = '../../zb/font/msyh.ttf';
imagecopy($im,$bg,0,0,0,0,1178,712);
imagedestroy($bg);
imagettftext($im, 25.9, 0, 285, 165, $black, $font, $text);




imagejpeg($im);
imagedestroy($im);
?>