<?php
// +----------------------------------------------------------------------
// | Fanwe 方维o2o商业系统
// +----------------------------------------------------------------------
// | Copyright (c) 2010 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------

/* 模块的基本信息 */
if (isset($read_modules) && $read_modules == true)
{
    //$module['server_url'] = 'http://yes.itissm.com';
    $module['server_url'] = 'http://h.1069106.com:1210';
    
    $module['class_name']    = 'winnerlook';
    /* 名称 */
    $module['name']    = "云信留客";
    $module['lang']  = array();
    $module['config'] = array();	
    return $module;
}

// 企信通短信平台
require_once APP_ROOT_PATH."system/libs/sms.php";  //引入接口
require_once APP_ROOT_PATH."system/sms/winnerlook/transport.php";
class winnerlook_sms implements sms
{
	public $sms;
	public $message = "";
	
	private $statusStr = array(
		"-1" => "运用程序异常",
		"-3" => "用户无效",
		"-4" => "短信内容与备案模板不一致",
		"-5" => "签名不正确",
		"-6" => "敏感词",
		"-7" => "余额不足",
		"-20" => "包含非法字符",
	);
	
    public function __construct($smsInfo = '')
    { 	    	
		if(!empty($smsInfo))
		{			
			$this->sms = $smsInfo;
		}
    }
	
	public function sendSMS($mobile_number,$content)
	{
		$sms = new transport(-1, -1, -1, true);
		if(is_array($mobile_number)){
			$mobile_number = implode(",",$mobile_number);
		}
		
		$this->sms['mobile'] = $mobile_number;
		$this->sms['content'] = urlencode($content);
		
		//$params = json_encode($this->sms);
		
		//$result_info = $sms->request($this->sms['server_url']."post",$params);
		
		//$return = json_decode($result_info['body'],1);

        $params = array(
            "userCode"=>$this->sms['user_name'],
            "userPass"=>$this->sms['password'],
            "DesNo"=>$mobile_number,
            "Msg"=> urlencode($content.'【DPIN众创平台】'),
            //"Msg"=> urlencode('您本次的验证码是52167【众筹】'),
            "Channel"=> 1,
        );
        file_put_contents('./log.txt',var_export($params, true).PHP_EOL,FILE_APPEND);
        file_put_contents('./log.txt',$this->sms['server_url'].'/services/msgsend.asmx/SendMsg'.PHP_EOL,FILE_APPEND);

        //$reqData = $sms->request($this->sms['server_url'].'/services/msgsend.asmx/SendMsg', $params, 'GET');
        //$result['status'] = 0;
        //$result['msg'] = '发送失败!';

        //$code = 0;
        //if($reqData && $reqData['body'] && strpos($reqData['body'], '<?xml') > -1) {
            //try {
                //$xml = simplexml_load_string($reqData['body']);
                //$code = json_decode($xml, true);
            //} catch(Exception $e) {
            //}
        //}

        header("Content-Type: text/html;charset=utf-8");
        $url=$this->sms['server_url'].'/services/msgsend.asmx/SendMsg?userCode='.$params['userCode'].'&userPass='.$params['userPass'].'&DesNo='.$params['DesNo'].'&Msg='.$params['Msg'].'&Channel='.$params['Channel'];
        $reqData = $this->file_get_content($url);

        file_put_contents('./log.txt','url:'.$url.PHP_EOL,FILE_APPEND);

        $result['status'] = 0;
        $result['msg'] = '发送失败!';

        $code = 0;
        if($reqData && strpos($reqData, '<?xml') > -1) {
            try {
                $xml = simplexml_load_string($reqData);
                $code = json_decode($xml, true);
            } catch(Exception $e) {
            }
        }
        
        
        if(strlen($code) > 5)
        {
            $result['status'] = 1;
            $result['msg'] = '发送成功!';
        }
        else
        {
            $result['status'] = 0;
            $result['msg'] = isset($this->statusStr[$code]) ? $this->statusStr[$code] : '未知错误';
        }

        file_put_contents('./log.txt','reqData:'.var_export($reqData, true).'code:'.$code.PHP_EOL,FILE_APPEND);
        file_put_contents('./log.txt',var_export($result, true).PHP_EOL,FILE_APPEND);
        return $result;
        //header("Content-type: text/html; charset=utf-8");
        //$url=$this->sms['server_url'].'/services/msgsend.asmx/SendMsg?userCode='.$params['userCode'].'&userPass='.$params['userPass'].'&DesNo='.$params['DesNo'].'&Msg='.$params['Msg'].'&Channel='.$params['Channel'];
        //file_put_contents('./log.txt',$url.PHP_EOL,FILE_APPEND);
        //$smsRet = file_get_contents($url);
        //$result = array();
        //$result['status'] = 1;
        //$result['msg'] = '发送失败';

        //if(strpos($smsRet, '-') === false) {
            //$result['status'] = 1;
        //} else {
            //$result['status'] = 0;
            //$result['msg'] = isset($this->statusStr[$smsRet]) ? $this->statusStr[$smsRet] : '未知错误';
        //}
        //$client = new SoapClient($this->sms['server_url']."/Services/MsgSend.asmx?WSDL");
        //$client->soap_defencoding = 'UTF-8';
        //$client->xml_encoding = 'UTF-8';
        //$p = $client->__soapCall('SendMsg',array('parameters' => $params));
        //$smsRet = $p->sendMesResult;
        
        //if(strpos($smsRet, '-') === false) {
            //$result['status'] = 1;
        //} else {
            //$result['status'] = 0;
            //$result['msg'] = isset($this->statusStr[$code]) ? $this->statusStr[$code] : '未知错误';
        //}
		
	}
	
	public function getSmsInfo()
	{	

		return "云信留客";	
		
	}
	
	public function check_fee()
	{
		//$sms = new transport();
					
		//$url = $this->sms['server_url']."get";
		
		//$params = json_encode($this->sms);
		
		//$result = $sms->request($url,$params);
		//$result = json_decode($result['body'],1);
		
		//$str = $result['info'];	

		return 'is ok';

	}
    function file_get_content($url) {
        if (function_exists('file_get_contents')) {
            $file_contents = @file_get_contents($url);
    }
    if ($file_contents =='' ) {
        $ch = curl_init();
        $timeout = 30;
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        $file_contents = curl_exec($ch);
        curl_close($ch);
    }
    return $file_contents;
    }
}
?>
