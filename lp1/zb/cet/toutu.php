<?php
header("content-type:image/jpeg");
$name = $_GET['name']?$_GET['name']:"装逼助手";
$school = $_GET['school']?$_GET['school']:"www.at168.com";
$level = $_GET['level']?$_GET['level']:"英语六级";
$id = $_GET['id']?$_GET['id']:"6";
$im = imagecreatetruecolor(474, 365);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,474,365);
imagedestroy($bg);
$black = imagecolorallocate($im, 241, 160, 66);
$blacka = imagecolorallocate($im, 90, 90, 90);
$text = $name;
$font = '../../zb/font/msyh.ttf';
imagettftext($im, 12, 0, 180, 79, $black, $font, $text);
imagettftext($im, 12, 0, 180, 104, $black, $font, $school);
imagettftext($im, 12, 0, 180, 130, $black, $font, $level);




if($id == '6'){ 
$ida= "710";
$idb= "249";
$idc= "249";
$idd= "212";
imagettftext($im, 12, 0, 215, 195, $blacka, $font, $ida);
imagettftext($im, 12, 0, 215, 216, $blacka, $font, $idb);
imagettftext($im, 12, 0, 215, 241, $blacka, $font, $idc);
imagettftext($im, 12, 0, 215, 266, $blacka, $font, $idd); 
}else if($id == '5'){ 
$ida= "673";
$idb= "235";
$idc= "240";
$idd= "198";
imagettftext($im, 12, 0, 215, 195, $blacka, $font, $ida);
imagettftext($im, 12, 0, 215, 216, $blacka, $font, $idb);
imagettftext($im, 12, 0, 215, 241, $blacka, $font, $idc);
imagettftext($im, 12, 0, 215, 266, $blacka, $font, $idd); 
}else if($id == '4'){ 
$ida= "426";
$idb= "132";
$idc= "175";
$idd= "119";
imagettftext($im, 12, 0, 215, 195, $blacka, $font, $ida);
imagettftext($im, 12, 0, 215, 216, $blacka, $font, $idb);
imagettftext($im, 12, 0, 215, 241, $blacka, $font, $idc);
imagettftext($im, 12, 0, 215, 266, $blacka, $font, $idd); 
}
else if($id == '3'){ 
$ida= "425";
$idb= "127";
$idc= "166";
$idd= "132";
imagettftext($im, 12, 0, 215, 195, $blacka, $font, $ida);
imagettftext($im, 12, 0, 215, 216, $blacka, $font, $idb);
imagettftext($im, 12, 0, 215, 241, $blacka, $font, $idc);
imagettftext($im, 12, 0, 215, 266, $blacka, $font, $idd); 
}
else if($id == '2'){ 
$ida= "209";
$idb= "63";
$idc= "76";
$idd= "70";
imagettftext($im, 12, 0, 215, 195, $blacka, $font, $ida);
imagettftext($im, 12, 0, 215, 216, $blacka, $font, $idb);
imagettftext($im, 12, 0, 215, 241, $blacka, $font, $idc);
imagettftext($im, 12, 0, 215, 266, $blacka, $font, $idd); 
}
else if($id == '1'){ 
$ida= "0";
$idb= "0";
$idc= "0";
$idd= "0";
imagettftext($im, 12, 0, 215, 195, $blacka, $font, $ida);
imagettftext($im, 12, 0, 215, 216, $blacka, $font, $idb);
imagettftext($im, 12, 0, 215, 241, $blacka, $font, $idc);
imagettftext($im, 12, 0, 215, 266, $blacka, $font, $idd); 
}else{ 
 echo '条件不满足'; 
} 


imagejpeg($im);
imagedestroy($im);
?>