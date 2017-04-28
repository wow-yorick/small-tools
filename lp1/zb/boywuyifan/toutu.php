<?php

header("content-type:image/jpeg");

$name = $_GET['name']?$_GET['name']:"www.lianxue.site";
$id = $_GET['id']?$_GET['id']:"www.lianxue.site";

$im = imagecreatetruecolor(690, 460);

$bg = imagecreatefromjpeg('toutu.jpg');

imagecopy($im,$bg,0,0,0,0,690, 460);

imagedestroy($bg);

if($id == '咱们永远是兄弟'){ 
$ida = "，咱们永远是兄弟!";
}
else if($id == '我要跟你单挑!'){ 
$ida = "，我要跟你单挑!";
}
else if($id == '不服气你就来!'){ 
$ida = "，不服气你就来!";
}
else if($id == '敢不敢来一场!'){ 
$ida = "，敢不敢来一场!";
}
else if($id == '谁输谁是小弟!'){ 
$ida = "，谁输谁是小弟!";
}
else{ 
 echo '条件不满足'; 
} 

$black = imagecolorallocate($im, 221, 219, 224);

$text = $name;

$font = '../../zb/font/msyh.ttf';


imagettftext($im, 30, 0, 33, 382, $black, $font, $name.$ida);



imagejpeg($im);

imagedestroy($im);

?>