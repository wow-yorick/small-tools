<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
//$namea = $_GET['namea'];
$nameb = $_GET['nameb'];
$namea = $_GET['namea']?$_GET['namea']:"恋雪科技";
//if($namea == '男'){ 
//$namea = "男";
//}
//else if($namea == '女'){ 
//$namea = "女";
//}
//else{ 
// echo '条件不满足'; 
//} 

$im = imagecreatetruecolor(800, 613);

$bg = imagecreatefromjpeg('2.jpg');

imagecopy($im,$bg,0,0,0,0,800,613);

imagedestroy($bg);

$black = imagecolorallocate($im, 0, 0, 0);

$text = $name;

$font = '../../zb/font/msyh.ttf';

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

/*********************颜色参数调节*********************/
$blacka = imagecolorallocate($im, 38, 40, 37);    

//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);

//function imagettftext ($image, $size, $angle, $x, $y, $color, $fontfile, $text);

/*********************文字参数调节*********************/
imagettftext($im, 25, 2, 60, 323, $blacka, $font, '贷款找'.$name);
imagettftext($im, 25, 2, 650, 320, $blacka, $font, $name);
//imagettftext($im, 20, 0, 638, 415, $blacka, $font, $namea);
imagettftext($im, 20, 2, 61, 360, $blacka, $font, $nameb);


imagejpeg($im);

imagedestroy($im);

?>