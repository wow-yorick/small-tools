<?php
set_time_limit(0);
header("Content-type: text/html; charset=utf-8");
/**
* 采集程序类
* @author  shooting
* @version 1.0.0
*/
class spider
{
/**
* 采集的终端页地址
*
* @var array
*/
var $pages = array();
/**
* 采集结果
*
* @var array
*/
var $result = array();
/**
* 第一层链接页面
*
* @var array
*/
var $startUrls = array();
/**
* 超时时间
*
* @var integer
*/
var $timeout;
/**
* 正在处理的文件内容
*
* @var string
*/
var $httpContent;
/**
* 正在处理的文件头
*
* @var array
*/
var $httpHead=array();
/**
* 自定义的head数组
*
* @var array
*/
var $putHead = array();
/**
* 采集字段与规则数组
*
* @var array
*/
var $field_arr = array();
/**
* 采集层次数
*
* @var interger
*/
var $deep;
/**
* 采集层次结构
*
* @var array
*/
var $layout_arr = array();
/**
* 采集限制条数
*
* @var integer
*/
var $limit = 0;
/**
* 程序运行时间
*
* @var float
*/
var $runtime = 0;
/**
* 被采集页面编码
*
* @var string
*/
var $charset = 'UTF-8';
/**
* 页面引用地址
*
* @var string
*/
var $httpreferer;
var $pagelimit = 0;
var $filepath = './';
function spider()
{
	$this->timeout = 30;
}
/**
* 运行采集
*
* @return array
*/
function run()
{
	$begintime = $this->microtime_float();
	$cnt = 1;
	foreach ($this->startUrls as $starturl){
		/**
		* 解析出起始地址中的页码区间
		*/
		if(preg_match("~\{(\d+),(\d+)\}~",$starturl,$pagenum)){
			$pagebegin = intval($pagenum[1]);
			$pageend = intval($pagenum[2]);
			for(;$pagebegin<=$pageend;$pagebegin++){
				$starturl = str_replace($pagenum[0],$pagebegin,$starturl);
				$urllists = $this->getLists($this->layout_arr[0]['pattern'],$this->getContent($starturl));
				foreach ($urllists as $url){
					if(($this->limit > 0 && $cnt <= $this->limit)||$this->limit == 0)
					{
						$this->filterContent($this->getContent($url,$starturl));
						$cnt++;
					}
				}
			}
		}else{
			$urllists = $this->getLists($this->layout_arr[0]['pattern'],$this->getContent($starturl));
			foreach ($urllists as $url){
				if(($this->limit > 0 && $cnt <= $this->limit)||$this->limit == 0)
				{
					$this->filterContent($this->getContent($url,$starturl));
					$cnt++;
				}
			}
		}
	}
	$this->runtime =  $this->microtime_float()-$begintime;
	return $this->result;
}
/**
* 从文字段中根据规则提取出url列表
*
* @param string $pattern
* @param string $content
* @return Array
*/
function getLists($pattern='',$content='')
{
	if(strpos($pattern,'{*}') === false)return array($pattern);
	$pattern = preg_quote($pattern);
	$pattern = str_replace('\{\*\}','([^\'\">]*)',$pattern);
	$pattern = "~".$pattern."~is";
	preg_match_all($pattern,$content,$preg_rs);
	return array_unique($preg_rs[0]);
}
/**
* 获取指定url的html内容包括头
*
* @param string $url
* @return string
*/
function getContent($url,$referer = '')
{
	$url = $this->urlRtoA($url,$referer);
	preg_match("/(http:\/\/)([^:\/]*):?(\d*)(\/?.*)/i",$url,$preg_rs);
	$host = $preg_rs[2];
	$port = empty($preg_rs[3])?80:$preg_rs[3];
	$innerUrl = $preg_rs[4];
	$fsp = fsockopen($host,$port,$errno,$errstr,$this->timeout);
	if(!$fsp)$this->log($errstr.'('.$errno.')');
	$output = "GET $url HTTP/1.0\r\nHost: $host\r\n";
	if(!isset($this->putHead['Accept']))$this->putHead['Accept']= "*/*";
	if(!isset($this->putHead['User-Agent']))$this->putHead['User-Agent']='Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2)';
	if(!isset($this->putHead['Refer'])){
		$this->putHead['Refer'] = ($referer == '')?'http://'.$host:$referer;
	}
	foreach ($this->putHead as $headname => $headvalue){
		$output .= trim($headname).': '.trim($headvalue)."\r\n";
	}
	$output .= "Connection: close\r\n\r\n";
	fwrite($fsp,$output);
	$content = '';
	while (!feof($fsp)) {
		$content .= fgets($fsp,256);
	}
	fclose($fsp);
	$this->getHead($content);
	$this->httpContent = $content;
	if(strtoupper($this->charset) != 'UTF-8'){
		$content = iconv($this->charset,'utf-8',$content);
	}else if(!empty($this->httpHead['charset']) && $this->httpHead['charset']!='UTF-8')
	{
		$content = iconv($this->httpHead['charset'],'utf-8',$content);
	}
	$this->httpreferer = $referer;
	return $content;
}
/**
* 按照规则从内容提取所有字段
* @param Array
* @return Array
*/
function filterContent($content='')
{
	$rs = array();
	foreach ($this->field_arr as $field => $fieldinfo){
		$rs[$field] = $this->getPregField($fieldinfo,$content);
	}
	$this->result[] = $rs;
}
/**
* 相对路径转化为绝对路径
*
* @param string $relative
* @param string $referer
* @return string
*/
function urlRtoA($relative,$referer)
{
	/**
	* 去除#后面的部分
	*/
	$pos = strpos($relative,'#');
	if($pos >0)$relative = substr($relative,0,$pos);
	/**
	* 检测路径如果是绝对地址直接返回
	*/
	if(preg_match("~^(http|ftp)://~i",$relative))
		return $relative;
	/**
	* 解析引用地址，获得协议,主机等信息
	*/
	preg_match("~((http|ftp)://([^/]*)(.*/))([^/#]*)~i", $referer, $preg_rs);
	$parentdir = $preg_rs[1];
	$petrol = $preg_rs[2].'://';
	$host = $preg_rs[3];
	/**
	* 如果以/开头的情况
	*/
	if(preg_match("~^/~i",$relative))
		return $petrol.$host.$relative;
	return $parentdir.$relative;
}
/**
* 根据规则提取一个字段
*
* @param string $pattern
* @param string $content
* @return string
*/
function getPregField($fieldinfo,$content)
{
	/**
	* 规则为固定值的情况,直接返回固定值
	*/
	if(strpos($fieldinfo['pattern'],'{'.$fieldinfo['field'].'}') === false)
		return $fieldinfo['pattern'];
	if($fieldinfo['isregular'] == 'true'){
		$pattern = $fieldinfo['pattern'];
		$pattern = str_replace('{'.$fieldinfo['field'].'}','(?P<'.$fieldinfo['field'].'>.*?)',$pattern);
	}else{
		$pattern = preg_quote($fieldinfo['pattern']);
		$pattern = str_replace('\{'.$fieldinfo['field'].'\}','(?P<'.$fieldinfo['field'].'>.*?)',$pattern);
	}
	$pattern = "~".$pattern."~is";
	preg_match($pattern,$content,$preg_rs);
	$fieldresult = $preg_rs[$fieldinfo['field']];
	/**
	* 去掉换行符
	*/
	$fieldresult = preg_replace("~[\r\n]*~is",'',$fieldresult);
	/**
	* 对采集到的结果根据规则再进行二次替换处理
	*/
	$replace_arr = $fieldinfo['replace'];
	if(is_array($replace_arr)){
		$replace_arr[0] = "~".$replace_arr[0]."~s";
		$fieldresult = preg_replace($replace_arr[0],$replace_arr[1],$fieldresult);
	}
	/**
	* 针对有下一页的字段递归采集
	*/
	if($this->pagelimit == 0){
		if($fieldinfo['nextpage'] != ''){
			$pattern = $fieldinfo['nextpage'];
			$pattern = str_replace('{nextpage}','(?P<nextpage>[^\'\">]*?)',$pattern);
			$pattern = "~".$pattern."~is";
			if(preg_match($pattern,$content,$preg_rs) && $preg_rs['nextpage'] != ''){
				$fieldresult .= $this->getPregField($fieldinfo,$this->getContent($preg_rs['nextpage'],$this->httpreferer));
			}
		}
	}
	if(!empty($fieldinfo['callback']))$fieldresult = $fieldinfo['callback']($fieldresult);
	return $fieldresult;
}
/**
* 添加一个采集字段和规则
*
* @param string $field
* @param string $pattern
*/
function addField($field,$pattern,$replace_arr='',$isregular='false',$nextpage = '',$callback='')
{
	$rs = array(
	'field' => $field,
	'pattern' => $pattern,
	'replace' => $replace_arr,
	'isregular' => $isregular,
	'nextpage' => $nextpage,
	'callback'=>$callback
	);
	$this->field_arr[$field] =$rs;
}
/**
* 输出
*
*/
function output()
{
	echo "The result is:<br/>";
	echo "runtime :$this->runtime S<br/><pre>";
	print_r($this->result);
	echo "</pre>";
}
/**
* 输出到XLS文件
*
* @param string $file
*/
function saveXls($file = 'spider_result.xls')
{
	$fp = fopen($file,'w');
	if($fp){
		foreach ($this->result as  $result)
		{
		$line = implode("\t",$result)."\n";
		fputs($fp,$line);
		}
	}
	fclose($fp);
	echo 'The result has been saved to '.$file.'.<br/>Cost time:'.$this->runtime;
}


function saveSql($table = 'spider_result',$file = 'spider_result.sql')
{
	$fp = fopen($file,'w');
	if($fp){
	foreach($this->field_arr as $fieldinfo){
	$sql_key .= ', `'.$fieldinfo['field'].'`';
	}
	$sql_key = substr($sql_key,1);
	foreach ($this->result as  $result)
	{
	$sql_value = array();
	foreach ($result as $key => $value){
	$sql_value[] = "'".$this->addslash($value)."'";
	}
	$line ="INSERT INTO `$table` ( $sql_key ) VALUES (".join(', ',$sql_value).");\r\n";
	fputs($fp,$line);
	}
	}
	fclose($fp);
	echo 'The result has been saved to '.$file.'.<br/>Cost time:'.$this->runtime;
}
/**
* 取得响应内容的头部信息
*
* @param string $content
* @return array
*/
function getHead($content)
{
	$head = explode("\r\n\r\n",$content);
	$head = $head[0];
	//  echo $head;
	if(!preg_match("~charset\=(.*)\r\n~i",$head,$preg_rs))
	preg_match('~charset=([^\"\']*)~i',$content,$preg_rs);
	$this->httpHead['charset'] = strtoupper(trim($preg_rs[1]));
	//  preg_match("~charset\=(.*)~i",$head,$preg_rs);
	return $this->httpHead;
}
/**
* 设置采集页面的编码
* 在程序不能自动识别的情况下采集前要手动调用此函数
*
* @param string $charset
*/
function setCharset($charset){
	$this->charset = strtoupper($charset);
}
/**
* 设置第一层链接页面地址
*
* @param array $url_arr
*/
function setStartUrls($url_arr)
{
	$this->startUrls = $url_arr;
}
/**
* 增加一个第一层链接页面地址
*
* @param string $url
*/
function addStartUrl($url)
{
	$this->startUrls[] = $url;
}
/**
* 添加一个采集层次
*
* @param integer $deep
* @param string $layout
* @param boolean $isSimple
* @param boolean $isPageBreak
* @param string $pattern
*/
function addLayer($deep,$layout,$pattern = '',$isSimple = 'false',$isPageBreak = 'false')
{
	$this->layout_arr[$deep] = array(
	'layout'=>$layout,
	'isSimple'=>$isSimple,
	'isPageBreak'=>$isPageBreak,
	'pattern'=>$pattern );
}
/**
* 自定义head
* @param string $namespace
* @param string $value
*/
function setHead($name,$value)
{
	$this->putHead[$name] = $value;
}

/**
* 清除html代码
*  @param string $content;
*  @param string $cleartags
*  @return string
*/
function clearHtml($content,$cleartags = 'div')
{
	$cleartags_arr = explode('|',$cleartags);
	foreach ($cleartags_arr as $cleartag){
	$pattern = '~<\/?'.$cleartag.'[^>]*>~is';
	$content = preg_replace($pattern,'',$content);
	}
	return $content;
}
/**
* 日志
*
*/
function log($str)
{
	echo $str."<br/>\n";
}

/**
* 获取采集运行时间
*
* @return float
*/
function getRuntime()
{
	return $this->runtime;
}
function microtime_float()
{
	list($usec, $sec) = explode(" ", microtime());
	return ((float)$usec + (float)$sec);
}

function addslash($string)
{
	return addslashes($string);
}


}

/*
* 采集博克*/
$spider  = new spider();
$spider->addStartUrl('http://hi.baidu.com/578696763/blog/index/{0,5}');
$spider->setCharset('gb2312');
$spider->addLayer(0,'xxxxx','/578696763/blog/item/{*}.html');
$spider->addField('title','<title>{title}</title>',array('海洋的天空-shooting&#39;s sky      ',''));
$spider->addField('body','<td><div id="blog_text" class="cnt"  >{body}</div></td>');
$spider->addField('author','shooting');
$spider->addField('date','<div class="date">{date}</div>');
$spider->run();
$spider->output();
$spider->saveSql();



/*EXPAMPLE: 采集华军软件一周下载
* 
$spider  = new spider();
$spider->addStartUrl('http://www.onlinedown.net/hits/week_{2,3}.htm');
//$spider->setCharset('gb2312');
$spider->addLayer(0,'lists','../soft/{*}.htm');
$spider->addField('title','<h4>{title}</h4>',array('海洋的天空      ',''));
$spider->addField('body','<td><div id="blog_text" class="cnt"  >{body}</div></td>');
$spider->addField('author','shooting');
$spider->addField('date','<span class="fB cBlue">更新时间：</span>');
$spider->run();
$spider->output();
$spider->saveXls(); //这个得到的结果是乱码,望大家能帮助 解决
$spider->saveSql(); //这个可以保存到数据库中,以便我们提取数据
*/
