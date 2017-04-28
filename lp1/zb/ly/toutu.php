<?php
header("content-type:image/jpeg");
mb_internal_encoding("UTF-8");
$name = $_GET['name']?$_GET['name']:"马大哈";
$id = $_GET['id']?$_GET['id']:"我喜欢你";
$im = imagecreatetruecolor(640, 847);
$bg = imagecreatefromjpeg('toutu.jpg');
imagecopy($im,$bg,0,0,0,0,640,847);
imagedestroy($bg);
$black = imagecolorallocate($im, 160, 160, 119);
$blacka = imagecolorallocate($im, 10, 10, 10);

if($id == '1'){ 
$ida = "嫁给我吧";
}
else if($id == '2'){ 
$ida = "来娶我吧";
}
else if($id == '3'){ 
$ida = "我爱你！";
}
else if($id == '4'){ 
$ida = "我喜欢你";
}
else{ 
 echo '条件不满足'; 
} 

$text = $name.$ida;
$font = '../../zb/font/fh.ttf';

function autowrap($fontsize, $angle, $fontface, $string, $width) {
// 这几个变量分别 是  字体大小,   角度,   字体名称,   字符串,  预设宽度
 $content = "";

 // 将字符串拆分成一个个单字 保存到数组 letter 中
 for ($i=0;$i<mb_strlen($string);$i++) {
  $letter[] = mb_substr($string, $i, 1);
 }

 foreach ($letter as $l) {
  $teststr = $content." ".$l;
  $testbox = imagettfbbox($fontsize, $angle, $fontface, $teststr);
  // 判断拼接后的字符串是否超过预设的宽度
  if (($testbox[2] > $width) && ($content !== "")) {
   $content .= "\n";
  }
  $content .= $l;
 }
 return $content;
}

$texta = autowrap (1, 0, $font, $text, 0); 

imagettftext($im, 32, -7, 245, 170, $black, $font, $texta);

$textaa="—  —  —  —  —  —  —";
imagettftext($im, 25, -97, 246, 136, $blacka, $font, $textaa);
imagettftext($im, 25, -97, 253, 138, $blacka, $font, $textaa);
imagettftext($im, 25, -97, 262, 140, $blacka, $font, $textaa);
imagettftext($im, 25, -97, 271, 142, $blacka, $font, $textaa);

imagejpeg($im);
imagedestroy($im);
?>