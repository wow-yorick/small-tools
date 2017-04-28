<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(720, 978);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,640,853);
imagedestroy($bg);
$black = imagecolorallocate($im, 45, 45, 45);
$text = $name;
$font = '../../zb/font/song.ttf';


if(strlen($name)<9){ 
imagettftext($im, 14, 0, 365, 418, $black, $font, $text);
}
else if(strlen($name)==9){ 
imagettftext($im, 14, 0, 365, 418, $black, $font, $text);
}
else if(strlen($name)>9){ 
imagettftext($im, 14, 0, 365, 418, $black, $font, $text);
}
else{ 
 echo '条件不满足'; 
} 



imagejpeg($im);
imagedestroy($im);
?>