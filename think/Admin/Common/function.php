<?php

/**
 * 检验是否有该权限
 * @param $rule
 * @param $uid
 * @param string $relation
 * @return bool
 */
function checkAuth($rule)
{
	$admin_id = $_SESSION[C('USER_AUTH_KEY')];
	if ($admin_id == C('ADMIN_AUTH_KEY')) return true;
	if (is_array($rule))
		$rule = implode(',', $rule);
	$Auth = new \Think\Auth();

	return $Auth->check($rule, $admin_id) ? true : false;
}

/**
 * auto_genera_num
 * 生成编号
 * @param mixed $tableName 表名
 * @param string $prefix 前缀
 * @param int $strPad 数字补齐到多少
 * @access public
 * @return void
 */
function auto_genera_num($tableName, $prefix = 'ANSA', $strPad = 3)
{
	$tableMode = $tableName;
	if (!is_object($tableName)) {
		$tableMode = M($tableName);
	}
	$tabId = $tableMode->max('id');
	$nextId = $tabId ? $tabId + 1 : 1;
	$flowNum = str_pad($nextId, $strPad, '0', STR_PAD_LEFT);
	return $prefix . $flowNum;
}

/**
 * 发送HTTP请求方法
 * @param  string $url    请求URL
 * @param  array  $params 请求参数
 * @param  string $method 请求方法GET/POST
 * @return array  $data   响应数据
 */
function http($url, $params, $method = 'GET', $header = array(), $multi = false){
    //JSON头:Content-Type: application/json; charset=utf-8
    //html普通头Content-type: text/html; charset=utf-8
    $opts = array(
            CURLOPT_TIMEOUT        => 30,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_SSL_VERIFYPEER => false,
            CURLOPT_SSL_VERIFYHOST => false,
            CURLOPT_HTTPHEADER     => $header
    );
    /* 根据请求类型设置特定参数 */
    switch(strtoupper($method)){
        case 'GET':
            $opts[CURLOPT_URL] = $url . '?' . http_build_query($params);
            break;
        case 'POST':
            //判断是否传输文件
            $params = $multi ? $params : http_build_query($params);
            $opts[CURLOPT_URL] = $url;
            $opts[CURLOPT_POST] = 1;
            $opts[CURLOPT_POSTFIELDS] = $params;
            break;
        default:
            throw new Exception('不支持的请求方式！');
    }
    /* 初始化并执行curl请求 */
    $ch = curl_init();
    curl_setopt_array($ch, $opts);
    $data  = curl_exec($ch);
    $error = curl_error($ch);
    curl_close($ch);
    //if($error) throw new Exception('请求发生错误：' . $error);
    if($error) return false;

    return  $data;
}

/**
 * get_domain 
 * 获取域名
 * @access public
 * @return void
 */
function get_domain() {
    return 'http://'.I('server.HTTP_HOST');
}


