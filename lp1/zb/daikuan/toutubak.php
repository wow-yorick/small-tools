<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
//$namea = $_GET['namea'];
$nameb = $_GET['nameb'];
$namea = $_GET['namea']?$_GET['namea']:"��ѩ�Ƽ�";
if($namea == '��'){ 
$namea = "��";
}
else if($namea == 'Ů'){ 
$namea = "Ů";
}
else{ 
 echo '����������'; 
} 
$im = imagecreatetruecolor(800, 1071);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,800,1071);

imagedestroy($bg);

$black = imagecolorallocate($im, 0, 0, 0);

$text = $name;

$font = '../../zb/font/msyh.ttf';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

$blacka = imagecolorallocate($im, 38, 40, 37);

//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);


imagettftext($im, 20, 0, 400, 413, $blacka, $font, $name);
imagettftext($im, 20, 0, 638, 415, $blacka, $font, $namea);
imagettftext($im, 20, 0, 400, 485, $blacka, $font, $nameb);



imagejpeg($im);

imagedestroy($im);

?>