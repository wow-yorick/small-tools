<?php  
class Collect { 
	private $_url;//要采集的目标地址
	private $_start;//匹配开始标签，唯一
	private $_end;//匹配的结束标签，唯一

function __construct($_url, $_start, $_end) { 
	$this->_url = $_url; 
	$this->_start = $_start; 
	$this->_end = $_end; 
} 

/* 
判断是否可以与目标正常链接
*/ 
function isConnect() { 
	$status = get_headers($this->_url); 
	if (false != stripos($status[0], '200')) { 
		return true; 
	} else { 
		return false; 
	} 
} 
/* 
获取原始
html
代码
检测原始代码编码，不是
utf-8
则转为
utf-8 
*/ 
function getHtml() { 
	if (self::isConnect()) { 
		$html = file_get_contents($this->_url); 
		$encode = mb_detect_encoding($html, array('utf-8','gb2312','gbk')); 
		if ($encode != 'urf-8') { 
			$html = iconv('GB2312', 'UTF-8', $html); 
		} 
		return $html; 
	} else { 
		return false; 
	} 
} 

/* 
$html 
通过
getHtml()
得到
去除空白
历史老照片不能说的秘密
慈禧军阀明末清初文革晚清 
转义可能引起正则混乱的标签
*/  
function cutHtml() { 
	$html = self::getHtml(); 
	if($html == false || empty($html)) return false; 
	$start = trim($this->_start); 
	$start = preg_quote($start); 
	$end = trim($this->_end); 
	$end = preg_quote($end); 
	$rule = '@'.$start.".*".$end.'@'; 
	preg_match_all($rule, $html, $result); 
	return $result[0]; 
} 

/*  
过滤结果
$str string 
$rule array  
$rule = null
则直接返回结果
*/  
function filterStr($str, $rule) { 
	if(empty($rule)) return $str; 
	$limit = count($rule); 
	for($i=0; $i<$limit; $i++) { 
		$str = str_replace($rule[$i], '', $str); 
	} 
	return $str; 
} 

/*  
url
地址检查
$url 
待转化
url string 
绝对
url
则直接返回
相对
url
则转化为绝对
url
并返回
$baseurl 
基准
url,
绝对路径形式，结尾不加
'/' 
*/  
function checkUrl($url, $baseurl) { 
	if (empty($baseurl)) return false; 
	if (substr($url, 0, 1) == '/') { 
		return $baseurl.$url; 
	} else if(substr($url, 0, 2) == './') { 
		return $baseurl.'/'.substr($url, 1); 
	} else if(substr($url, 0, 7) == 'http://') { 
		return $baseurl.'/'.$url; 
	} else { 
		return $url;  
	} 
} 



}  
