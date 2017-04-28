<?php
header("content-type:image/jpeg");
mb_internal_encoding("UTF-8");
$name = $_GET['name']?$_GET['name']:"恋雪科技";
$id = $_GET['id']?$_GET['id']:"恋雪科技";
$im = imagecreatetruecolor(894, 641);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,894,641);
imagedestroy($bg);

if($id == '鉴黄师'){ 
$ida = "鉴黄师";
}
else if($id == '催乳师'){ 
$ida = "催乳师";
}
else if($id == '月嫂'){ 
$ida = "月嫂";
}
else if($id == '安全套试用员'){ 
$ida = "安全套试用员";
}
else if($id == '狗粮品尝师'){ 
$ida = "狗粮品尝师";
}
else{ 
 echo '条件不满足'; 
} 

$text = $name;
$showtime=date("20y年m月d日");
$font = '../../zb/font/fh.ttf';

$blacka = imagecolorallocate($im, 95, 104, 101);

imagettftext($im, 16, 0, 164, 234, $blacka, $font, $name);
imagettftext($im, 16, 0, 300, 234, $blacka, $font, $showtime);
imagettftext($im, 16, 0, 523, 278, $blacka, $font, $ida);


imagejpeg($im);
imagedestroy($im);
?>