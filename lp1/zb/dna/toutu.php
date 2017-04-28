<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
//$namea = $_GET['namea'];
$namea = $_GET['namea'];
$nameb = $_GET['nameb']?$_GET['nameb']:"恋雪科技";
if($nameb == '儿子'){ 
$nameb = "儿子。";
}
else if($nameb == '女儿'){ 
$nameb = "女儿。";
}
else{ 
 echo '条件不满足'; 
} 
$namec = $_GET['namec']?$_GET['namec']:"恋雪科技";
if($namec == '亲生'){ 
$namec = "的亲生";
$queren = "确认是";
$i=1;
}
else if($namec == '无血缘关系'){ 
$namec = "确认无血缘关系。";
$queren = "与";
$i=0;
}
else{ 
 echo '条件不满足'; 
} 

$im = imagecreatetruecolor(640, 532);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,640,532);

imagedestroy($bg);

$black = imagecolorallocate($im, 0, 0, 0);

$text = $name;

$font = '../../zb/font/wz.ttf';

$moren = "经过我中心鉴定，";

//$ida = number_format($id);

//imagettftext($im, 30, 0, 628, 363, $black, $font, $ida);

$blacka = imagecolorallocate($im, 38, 40, 37);

//$showtime=date("m/d");

//imagettftext($im, 30, 5.5, 271, 200, $blacka, $font, $showtime);



if($i==1){
	imagettftext($im, 9, 0, 72, 263, $blacka, $font, $moren.$namea.$queren.$name.$namec.$nameb);
}
else if($i==0){
	imagettftext($im, 9, 0, 72, 263, $blacka, $font, $moren.$namea.$queren.$name.$namec);
}
else{
	 echo '条件不满足'; 
}






imagejpeg($im);

imagedestroy($im);

?>