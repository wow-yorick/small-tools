<?php

class interface_all
{
    public function __construct()
    {
    	require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
    }
 /*
     *     函数: SendReceiveSocket       socket发送接收数据
     *     参数: String $str     	发送的字符串
     *     返回: String $buff,      接收的字符串     
     *             
     * */
	public function SendReceiveSocket($str){
    	$server = $this->dbAdapter->fetchAll("select * from sys_configdata where type='card_server_config' order by seq");
    	$server = Ousu::all_mArr_KeyValue($server, "name", "value");
    	set_time_limit(0);
    	$host = $server["服务器地址"];
    	$port = $server["端口"];
    	$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)or $this->logger->err("Could not create  socket"); // 创建一个Socket
		$connection = socket_connect($socket, $host, $port) or $this->logger->err("Could not connet server");    //  连接  
		socket_write($socket, $str) or $this->logger->err("Write failed"); // 数据传送 向服务器发送消息
		$bufflen = socket_read($socket, 4, PHP_BINARY_READ );
		if ($bufflen === "") $this->logger->err("receive zero length data!");
		$this->logger->debug("need receive data length :".$bufflen);
		$buff = socket_read($socket, $bufflen, PHP_BINARY_READ );
		for($i=0;$i<9;$i++) { 
			if (strlen($buff)<$bufflen) {
				$buff .= socket_read($socket, $bufflen - strlen($buff), PHP_BINARY_READ );
			}
		}
		$this->logger->debug("receive data length :".strlen($buff));
		socket_close($socket);
		return $buff;
    }

    /*
     *     函数: applyConfig
     *     参数: String $outtype     发送类型
     *           String $replytype   接收类型
     *           Array  $params      替换参数   $params["交易类型"]="5012"
     *     返回: Array $list,        数组形结果        
     *             
     * */
    public function applyConfig($outtype,$replytype,$params){
    	$reply = $this->dbAdapter->fetchAll("select * from sys_configdata where type='".$replytype."' order by seq");
    	for ($i = 0; $i < sizeof($reply); $i++) {
    		$ll = explode("|",$reply[$i]["value"]);
    		$j=$i;
    		if (sizeof($ll) == 4) {
    			if (!isset($circle)){                          //第一次循环, 第一个循环体
    				$circle=array();
    				$circle["start"] = $i;
    				$circle["end"] = $i;
    				$circle["loop"] = 0;
    				$circle["length"] = $ll[2];
    			}
    			else {
    				if ($circle["loop"] == 0)
    					$circle["end"] = $i;                      // 第一次循环, 后续循环体
    			}
    		}
    		else {
    			if (isset($circle)){
    				if ($circle["loop"] < $circle["length"]-1){
    					$j = $circle["start"];
    					$circle["loop"] ++;
    				}
    				else {
    					unset($circle);
    				}
    			}
    		}
    		if (sizeof($ll) > 1){
    			if ((isset($circle)) && (sizeof($ll) == 4))
   					$list[$reply[$i]["name"]."_".$circle["loop"]] = str_pad($ll[0],$ll[1]);
   				else
 	    			$list[$reply[$i]["name"]] = str_pad($ll[0],$ll[1]);
    		}
       		else {
    			$list[$reply[$i]["name"]] = $reply[$i]["value"];
       		}
       		$i = $j;
       		if ((($i+1) == sizeof($reply))&&(isset($circle))&& ($circle["loop"]<$circle["length"]-1)){
       			$i = $circle["start"]-1;
       			$circle["loop"]++;
       		}
     	}
     	$result = Ousu::getJsonResult();
   		$result["success"] = true;
   		$result["msg"] = "查询成功";
   		$result["obj"] = $list;
   		return $result;
    }
    
    public function applyConfig_bb($outtype,$replytype,$params){  
    	$config = $this->dbAdapter->fetchAll("select * from sys_configdata where type='".$outtype."' order by seq");
    	$reply = $this->dbAdapter->fetchAll("select * from sys_configdata where type='".$replytype."' order by seq");
		$params["端末流水号"] = rand(100000,999999);
    	$str = "";
    	//print_r($config);
    	foreach($config as $arr){
    		$list =explode("|",$arr["value"]);
    		if (sizeof($list) > 1){
    			$tmp = $list[0];
    			if(isset($params[$arr["name"]])) $tmp = iconv('utf-8','gbk//TRANSLIT',$params[$arr["name"]]);
    			$str .= str_pad($tmp, $list[1]);
    		}
    		else {
    			$str .= $arr["value"];
    		}
    	}
    	
    	$str .= strtoupper(md5($str."123"));
    	$len = strlen($str);
    	$send = str_pad($len,4,'0',STR_PAD_LEFT).$str;
    	$this->logger->debug("socket send str :".$send);
    	
    	$result = $this->SendReceiveSocket($send);
    	$this->logger->debug("socket receive str :".$result);
    	$list = array();
    	$circle = array();
    	for ($i = 0; $i < sizeof($reply); $i++) {
    		$ll = explode("|",$reply[$i]["value"]);
    		$j=$i;
    		if (sizeof($ll) == 4) {
    			if (!isset($circle)){                          //第一次循环, 第一个循环体
    				$circle=array();
    				$circle["start"] = $i;
    				$circle["end"] = $i;
    				$circle["loop"] = 0;
    				$circle["length"] = $ll[2];
    			}
    			else {
    				if ($circle["loop"] == 0)
    					$circle["end"] = $i;                      // 第一次循环, 后续循环体
    			}
    		}
    		else {
    			if (isset($circle)){
    				if ($circle["loop"] < $circle["length"]-1){
    					$j = $circle["start"];
    					$circle["loop"] ++;
    				}
    				else {
    					unset($circle);
    				}
    			}
    		}
    		if (sizeof($ll) > 1){
    			if ((isset($circle)) && (sizeof($ll) == 4))
   					$list[$reply[$i]["name"]."_".$circle["loop"]] = iconv('gbk','utf-8',substr($result,0,$ll[1]));
   				else
 	    			$list[$reply[$i]["name"]] = iconv('gbk','utf-8',substr($result,0,$ll[1]));
   				$result = substr($result,$ll[1]);
       		}
       		else {
    			$list[$reply[$i]["name"]] = iconv('gbk','utf-8',substr($result,0,strlen($reply[$i]["value"])));
    			$result = substr($result,strlen($reply[$i]["value"]));
       		}
       		$i = $j;
       		if ((($i+1) == sizeof($reply))&&(isset($circle))&&($circle["loop"]<$circle["length"]-1)){
       			$i = $circle["start"]-1;
       			$circle["loop"]++;
       		}
     	}
    	$result = Ousu::getJsonResult();
    	if ($list["返回代码"] == "000000"){
    		if (isset($list["端末流水号"])){
    			if ($list["端末流水号"] != $params["端末流水号"]){
	   				$result["success"] = false;
    				$result["msg"] = "端末流水号不正确!";
    				$result["obj"] = $list;
    				return $result;
    			}
    			else {
		    		$result["success"] = true;
		    		$result["msg"] = "查询成功";
		    		$result["obj"] = $list;
		    		return $result;
   				}
    		}else {
    			$result["success"] = true;
    			$result["msg"] = "查询成功";
    			$result["obj"] = $list;
    			return $result;
    		}
    	}
    	else {
    		$rows=$this->dbAdapter->fetchRow("select * from sys_configdata where type='card_response_code' and name='".$list["返回代码"]."'");
    		$result["success"] = false;
    		$result["msg"] = $rows["value"];
    		$result["obj"] = $list;
    		return $result;
    	}
    }

    /*
     *     函数: get_cardCertify       安吉卡(祥运卡 )验证接口                  3030
     *     参数: Array $params         卡号,验证方式,密码,姓名,手机号
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardCertify($params){ 
    	$result = self::applyConfig("card_certify", "card_certify_reply", $params);
    	return $result;
    }
    
    /*
     *     函数: get_cardMsg          会员信息维护接口  3038
     *     参数: Array $params         动作代码(0,1)
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardMsg($params){ 
    	$result = self::applyConfig("card_msg", "card_msg_reply", $params);
    	return $result;
    }

    /*     函数: get_cardActive        卡片激活接口   3020
     *     参数: Array $params         卡号,密码
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardActive($params){ 
    	$result = self::applyConfig("card_active", "card_active_reply", $params);
    	return $result;
    }
        
   /*
     *     函数: get_cardInfo       安吉卡(祥运卡 )基本信息查询接口   3009
     *     参数: String $cardno     卡号
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardInfo($params){ 
    	$result = self::applyConfig("card_info", "card_info_reply", $params);
    	//调整储值余额为储值余额-冻结金额
    	if ($result["success"]) {
    		$result["obj"]["储值余额"] = $result["obj"]["储值余额"] - $result["obj"]["冻结金额"]; 
    	}
    	return $result;
    }
    /*
     *     函数: get_cardPwd       安吉卡(祥运卡 )密码修改接口  3006
     *     参数: Array $params         卡号,验证方式,密码,姓名,手机号
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardPwd($params){ 
    	$result = self::applyConfig("card_pwd", "card_pwd_reply", $params);
    	return $result;
    }

    /*     函数: get_cardTrade        安吉卡(祥运卡 )交易查询接口    3063
     *     参数: Array $params         卡号,交易类型,商户号,起止日期,交易流水号
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardTrade($params){ 
    	$result = self::applyConfig("card_trade", "card_trade_reply", $params);
    	return $result;
    }
    
   /*
     *     函数: get_cardLost        安吉卡(祥运卡 )挂失接口         3023
     *     参数: Array $params         卡号,密码
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardLost($params){ 
    	$result = self::applyConfig("card_lost", "card_lost_reply", $params);
    	return $result;
    }
    
   /*
     *     函数: get_cardCharge        安吉卡(祥运卡 )网上转帐接口            3064
     *     参数: Array $params         卡号,不记名卡卡号,不记名卡密码,交易金额,网上订单号
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardCharge($params){ 
    	$result = self::applyConfig("card_charge", "card_charge_reply", $params);
    	return $result;
    }
        
    /*     函数: get_cardSale          安吉卡(祥运卡 )网上销售接口            5104
     *     参数: Array $params         
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_cardSale($params){ 
    	$result = self::applyConfig("card_sale", "card_sale_reply", $params);
    	return $result;
    }
    
	/*     函数: get_venderInfo        商户验证接口       5105
     *     参数: Array $params         商户号,密码
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_venderInfo($params){ 
    	$result = self::applyConfig("vender_info", "vender_info_reply", $params);
    	return $result;
    }

 	/*     函数: get_venderCertify        商户验证接口       5107
     *     参数: Array $params         商户号,密码
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_venderCertify($params){ 
    	$result = self::applyConfig("vender_certify", "vender_certify_reply", $params);
    	return $result;
    }
    
 	/*     函数: get_cardOrder        网上订单充值接口       5108
     *     参数: Array $params         
     *     返回: Array $list,                
     *             
     * */
	public function get_cardOrder($params){ 
    	$result = self::applyConfig("card_order", "card_order_reply", $params);
    	return $result;
    }

	/*     函数: get_compCertify        公司验证接口      3065
     *     参数: Array $params         
     *     返回: Array $list,                
     *             
     * */
	public function get_compCertify($params){ 
    	$result = self::applyConfig("comp_certify", "comp_certify_reply", $params);
    	return $result;
    }

    /*     函数: get_orderStatus        查询订单状态接口     5106
     *     参数: Array $params         
     *     返回: Array $list,                
     *             
     * */
	public function get_orderStatus($params){ 
    	$result = self::applyConfig("order_status", "order_status_reply", $params);
    	return $result;
    }
        
 	/*     函数: pinpan              加密PIN
     *     参数: String $password    密码
     *     参数: String $cardno      卡号
     *     返回: Stirng $pin,        结果        
     *             
     * */
    public function pinpan($password,$cardno){
    	require APPLICATION_PATH . '/models/des.class.php'; // !--- COPY --- //
    	$reply = $this->dbAdapter->fetchAll("select * from sys_configdata where type='pik'");
    	$pik = $reply[0]["name"];
		$des = new Des();
    	$card = strrev(substr(strrev($cardno),1,12));
    	$cc = chr(0).chr(0);
    	$cc .=chr(base_convert((int)substr($card,0,2), 16, 10));
    	$cc .=chr(base_convert((int)substr($card,2,2), 16, 10));
    	$cc .=chr(base_convert((int)substr($card,4,2), 16, 10));
    	$cc .=chr(base_convert((int)substr($card,6,2), 16, 10));
    	$cc .=chr(base_convert((int)substr($card,8,2), 16, 10));
    	$cc .=chr(base_convert((int)substr($card,10,2), 16, 10));
    	$pwd = $password;
    	$pin = chr(base_convert(strlen($pwd), 16, 10));
    	$pin .= chr(base_convert((int)substr($pwd,0,2), 16, 10)); 
    	$pin .= chr(base_convert((int)substr($pwd,2,2), 16, 10)); 
    	$pin .= chr(base_convert((int)substr($pwd,4,2), 16, 10)); 
    	$pin .= chr(255).chr(255).chr(255).chr(255);
    	$pin;
    	for ($i = 0;$i < strlen($cc);$i++){
    		$pin[$i] = $pin[$i]^$cc[$i];
    	}
    	$pp = "";
    	for ($i = 0;$i < 8;$i++){
    		$pp .= chr(base_convert((int)substr($pik,$i*2,2), 16, 10)); 
    	}
    	$pin= strtoupper(bin2hex($des->encrypt($pin, $pp, false)));
    	return $pin;
    }
    
    public function sendSMS($msg){
  	 	$this->dbAdapter_sms = Zend_Registry::get('dbAdapter_sms');
    	$result = $this->dbAdapter_sms->fetchAll("show tables;");
    	return $result;
    }

    public function insurance($cardnum){ //太保订单显示接口
    	$result=array();
    	$result["cpic_ordernum"] = 'xxxxxx';
    	$result['cpic_orderstates'] = '完成';
    	$result['cpic_ordermoney'] = '1250';
    	$result['cpic_orderdate'] = '2013-01-12';
    	$result['cpic_list'] = array(
    		0=>array(
    			'coverage'=>'车辆损失险',
    			'baoe'=>'10000',
    			'baojin'=>'1200',
    		),
    		1=>array(
    			'coverage'=>'车辆损失险',
    			'baoe'=>'10000',
    			'baojin'=>'1200',
    		),
    	
    	);
    	$result['framenumber'] = 'badd88';
    	$result['mastername'] = '东';
    	$result['platenumber'] = '沪E12789';
    	$result['cardtype'] = '沪E12789';
    	$result['enginenum'] = '1231231';
    	$result['idcardnum'] ='123123123123';
    	$result['startdate'] = '2012-03-12';
    	$result['mobile'] = '13916901354';
    	$result['paycardtype'] = '无记名卡';
    	$result['cardnum'] = '12312314';
    	$result['tradenum'] = '12312314';
    	$result['figure'] = '1200.00';
    	$result['paydate'] = '2013-01-23';
    	return $result;
    }
    
	public function insurancesearch($cardnum){ //太保订单查询接口
    	$result=array();
    	$result[0]["ordernum"] = 'xxxxxx';
    	$result[0]["comfirmdate"] = '2012-12-12';
    	$result[0]["orderstates"] = '未支付';
    	$result[0]["baodanmoney"] = '9000.00';
    	$result[0]["paymoney"] = '00.00';
    	$result[0]["finishtime"] = '2012-12-11 12:22:11';
        $result[1]["ordernum"] = 'xxxxxx';
    	$result[1]["comfirmdate"] = '2012-12-12';
    	$result[1]["orderstates"] = '已支付';
    	$result[1]["baodanmoney"] = '9000.00';
    	$result[1]["paymoney"] = '00.00';
    	$result[1]["finishtime"] = '2012-12-11 12:22:11';
    	$result[2]["ordernum"] = 'xxxxxx';
    	$result[2]["comfirmdate"] = '2012-12-12';
    	$result[2]["orderstates"] = '完成';
    	$result[2]["baodanmoney"] = '9000.00';
    	$result[2]["paymoney"] = '00.00';
    	$result[2]["finishtime"] = '2012-12-11 12:22:11';
    	$result[3]["ordernum"] = 'xxxxxx';
    	$result[3]["comfirmdate"] = '2012-12-12';
    	$result[3]["orderstates"] = '未支付';
    	$result[3]["baodanmoney"] = '9000.00';
    	$result[3]["paymoney"] = '00.00';
    	$result[3]["finishtime"] = '2012-12-11 12:22:11';
    	$result[4]["ordernum"] = 'xxxxxx';
    	$result[4]["comfirmdate"] = '2012-12-12';
    	$result[4]["orderstates"] = '未支付';
    	$result[4]["baodanmoney"] = '9000.00';
    	$result[4]["paymoney"] = '00.00';
    	$result[4]["finishtime"] = '2012-12-11 12:22:11';
    	return $result;
    }
 
     /*     函数: get_venderInfo        商户验证接口       3066
     *     参数: Array $params         商户号,开始日期,结束日期
     *     返回: Array $list,        数组形结果        
     *             
     * */
	public function get_venderTrade($params){ 
    	$result = self::applyConfig("vender_trade", "vender_trade_reply", $params);
    	return $result;
    }
}