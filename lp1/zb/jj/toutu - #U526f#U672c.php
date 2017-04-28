<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"马大哈";
$im = imagecreatetruecolor(640, 853);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,640,853);
imagedestroy($bg);
$black = imagecolorallocate($im, 45, 45, 45);
$text = $name;
$font = '../../zb/font/lxk.ttf';


if(strlen($name)<9){ 
imagettftext($im, 38, -2, 268, 798, $black, $font, $text);
}
else if(strlen($name)==9){ 
imagettftext($im, 35, -2, 252, 798, $black, $font, $text);
}
else if(strlen($name)>9){ 
imagettftext($im, 28, -2, 247, 798, $black, $font, $text);
}
else{ 
 echo '条件不满足'; 
} 



imagejpeg($im);
imagedestroy($im);
?>