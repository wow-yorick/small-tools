<?php
class Ousu{

	private $controller;
	
	public function __construct() 
	{
	}	
	
	public function setController($controller){
		$this->controller = $controller;
	}
	
	public static function idsChange($ids){
		$ex=split(',',$ids);
		foreach ($ex as $key=>$value)
			$ex[$key] = "'".$value."'";
		return implode(',', $ex);
	}
	
	public function changeToJscode($params,$except=""){
		$ex=split(',',$except);
		$result = array();
		foreach($params as $key => $value) {
			if ($value == null){}
			elseif (is_array($value)){ $result[$key] = $this->changeToJscode($value,$except);}
			elseif (is_bool($value)){
				if ($value) $result[$key] = 'true';
				else $result[$key] = 'false'; 
			}
			elseif (is_string($value)){
				$value = str_replace("<{m}>", $this->controller->view->moduleName, $value);
				$value = str_replace("<{c}>", $this->controller->view->controllerName, $value);
				$value = str_replace("<{baseUrl}>", $this->controller->view->baseUrl(), $value);
				if (!in_array($key,$ex)){
					$result[$key] = "'".$value."'";
				}
				else {
					$result[$key] = $value;
				}
			}
			else {
				$result[$key] = $value;
			}
		}
		return $result;
	}
	
	public static function copyProperty($source, $target){
		foreach ($target as $key=>$value){
			if (isset($source[$key]))
				$target[$key] = $source[$key];
		}
		return $target;
	}
	
	public static function getJsonResult(){
		return array(
			"success" => false, //是否成功
			"msg" => "", //提示信息
			"obj" => null //其他信息
		);
	}
	
	public function getSessionInfo(){
		$sessioninfo = basePageModel::getSessionInfo();
		//判断用户是否登录
		$prefix = $this->controller->view->sessionPrefix . '_sesioninfo_';
		if (isset($_SESSION[$prefix])){
			$sessioninfo = $_SESSION[$prefix];
		};
		return $sessioninfo;
	}
	
	//设置session
	public function setSessionInfo($sessioninfo){
		$prefix = $this->controller->view->sessionPrefix . '_sesioninfo_';
		$_SESSION[$prefix] = array();
		foreach ($sessioninfo as $key => $value) {
			$_SESSION[$prefix][$key] = $value;
		}
	}
	
	/**
	 * 二维数字,转换为 key => value 的一维数组
	 * @return array $result
	 */
	public static function all_mArr_KeyValue($mArr,$key,$value)
	{
		$result = array();
		foreach($mArr as $arr){
			$result[$arr[$key]] = $arr[$value];
		}
		return $result;
	}
	
	/**
	 * 将二维数组,字典数据转换为option
	 * @return String $result
	 */
	public static function all_html_option($mArr,$key="typeName",$value="typeName",$selected ="")
	{
		$result = "";
		foreach($mArr as $arr){
			if ($selected == $arr[$key]){
				$result .="<option selected value=\"".$arr[$key]."\">".$arr[$value]."</option>";
			}
			else {
				$result .="<option value=\"".$arr[$key]."\">".$arr[$value]."</option>";
			}
		}
		return $result;
	}
	
	/**
	 * 查询条件中将首字符去除
	 * @return String $result
	 */
	public static function nofirst($params){
		$result = array();
		foreach ($params as $key => $value){
			$result[substr($key,1)] = substr($value,1);
		}
		return $result;
	}
	
	/**
	 * 根据二维数组的第二维的key和值,删除对应第二维元素,并重建
	 * @return String $result
	 */
	public static function all_delrecord($params,$key,$value){
		$result = array();
   		foreach($params as $arr){
    		if (!strpos($value,$arr[$key]))
   				array_push($result,$arr);
    		}
		return $result;		
	}
	
	
	/**
	 * 根据分页计算分页栏显示
	 * @return String $result
	 */
	public static function calcpager($pager){
		if ($pager["page"] > 1) {
			$pager["pre"] = true;
		}
		else{
			$pager["pre"] = false;
		}
		if ($pager["page"] < $pager["pages"]) {
			$pager["next"] = true;
		}
		else{
			$pager["next"] = false;
		}
		if ($pager["pages"] <= 5) {
			for ($i = 1;$i <=$pager["pages"];$i++){
				$pager["b".$i] = $i;
			}
			return $pager;
		}
		if ($pager["page"] <= 3) {
			$pager["b1"] = 1;
			$pager["b2"] = 2;
			$pager["b3"] = 3;
			$pager["b4"] = 0;
			$pager["b5"] = $pager["pages"];
			return $pager;
		}
		if ($pager["page"] >= ($pager["pages"]-2)) {
			$pager["b1"] = 1;
			$pager["b2"] = 0;
			$pager["b3"] = $pager["pages"]-2;
			$pager["b4"] = $pager["pages"]-1;
			$pager["b5"] = $pager["pages"];
			return $pager;
		}
		$pager["b1"] = 1;
		$pager["b2"] = 0;
		$pager["b3"] = $pager["page"];
		$pager["b4"] = 0;
		$pager["b5"] = $pager["pages"];
		return $pager;
	}
	
	public static function getSessionArray($name){
		$prefix = 'sqxcard_sesionarray_'.$name;
		if (isset($_SESSION[$prefix])){
			$sessioninfo = $_SESSION[$prefix];
		}
		else 
			$sessioninfo = array();
		return $sessioninfo;
	}
	
	
	public static function setSessionArray($name,$sessioninfo){
		$prefix = 'sqxcard_sesionarray_'.$name;
		$_SESSION[$prefix] = array();
		foreach ($sessioninfo as $key => $value) {
			$_SESSION[$prefix][$key] = $value;
		}
	}
	
	public static function posttoarray($postvalue) {
		$list = explode("&", $postvalue);
		$result = array();
		foreach($list as $value) {
			$ll = explode("=",$value);
			$result[$ll[0]] = $ll[1];
		}
		return $result;
	}
		
	/**
	 * 静态方法，echo出参数的内容
	 * @param object $vars 要打印的参数
	 * @param bool $output 为true，则返回要打印的字符串
	 * @return
	 */
	public static function ousu_dump($vars, $output = true)
	{
		header("Content-type: text/html; charset=utf-8");
		if ($output) {
			$content = "<div align=left><pre>\n" . htmlspecialchars(print_r($vars, true)) . "\n</pre></div>\n";
			$content .= " -------------------------------------------------------------------------- \n";
			echo $content;
		} else {
			$content = htmlspecialchars(print_r($vars, true)) ;
			$content .= "\n-------------------------------------------------------------------------- \n";
			return $content;
		}
	}
	// 讯联金额转换
	public static function changeamount($amount){
		$result = number_format($amount,2,"","");
		$result = str_pad($result,12,'0',STR_PAD_LEFT);
		return $result;
	}	
}