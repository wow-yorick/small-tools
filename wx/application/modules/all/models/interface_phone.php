<?php
/**
 * 手机充值接口
 * @author wuyi
 *
 */
class interface_phone
{
	//手机充值接口 
	private $phone_action = 'http://test.172.com:8080/mptopup/quicktopup/channelTopupv2.htm';
	//代理人余额查询接口
	private $balanceinquiry_action = 'http://test.172.com:8080/mptopup/agent/agentApiQuerySva.htm' ;
	//安吉回调接口
	private $anji_callback = 'http://116.247.83.122:8092/sqxcard/front/public/publicview/phone/callback';
	//安吉代理人 唯一ID标示
	private $userId = '20006221';
	
	private $password = '123456';
	
	public function __construct()
    {
        require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
    	require_once APPLICATION_PATH . '/modules/all/models/db_all.php'; // !--- COPY --- //
        //require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
        $dbAll = new db_all();
        $cofinfo = $dbAll->all_getConfData('card_phone_charge');
        foreach($cofinfo as $arr){
        	switch ($arr['id']) {
        		case 'card_phone_charge_1':
        			$this->phone_action = $arr['value'];
        		break;
        		case 'card_phone_charge_2':
        			$this->balanceinquiry_action = $arr['value'];
        		break;
        		case 'card_phone_charge_3':
        			$this->anji_callback = $arr['value'];
        		break;
        		case 'card_phone_charge_4':
        			$this->userId = $arr['value'];
        		break;
        		case 'card_phone_charge_5':
        			$this->password = $arr['value'];
        		break;
        	}
        }
    }
	/**
	 * 充值接口
	 * @param array $arg
	 */
	public function rechargeAction($arg)
	{   
		require_once APPLICATION_PATH . '/models/curl.class.php';
		$mycurl = new curl($this->phone_action);
		//这个是随机字符串
		//$userSeqNo = md5($_SERVER['REQUEST_TIME'].rand(1,100000));
		$params = array(
			'userId' => $this->userId,
			'topupMp' => $arg['topupMp'], //'15921439746',// 充值手机号码
			'delayHour' => isset($arg['delayHour'])?$arg['delayHour']:0, // '0',
			'topupAmount' => $arg['topupAmount'],// '50',
			'needSendMsg' => isset($arg['needSendMsg'])?$arg['needSendMsg']:'true',//'true',
			//充值日期
			'userDate' => $arg['userDate'], //'2013-03-21', 
			//安吉本地的订单号，唯一
			'userSeqNo' =>$arg['userSeqNo'],// $userSeqNo,
			'noticeUrl' => $this->anji_callback,
			'phoneType' => 'MP'
		);
		$signInfo  = 'userId='.$params['userId'].'&topupMp='.$params['topupMp'].'&delayHour='.$params['delayHour'];
		$signInfo .= '&topupAmount='.$params['topupAmount'].'&needSendMsg='.$params['needSendMsg'].'&userDate='.$params['userDate'];
		$signInfo .= '&userSeqNo='.$params['userSeqNo'].'&noticeUrl='.$params['noticeUrl'].'&password='.$this->password;
		$signInfo = md5($signInfo) ;
		$params['signInfo'] = $signInfo;
		$this->dbAdapter = Zend_Registry::get('dbAdapter');
		$sql = "INSERT INTO
					`tmp_rechinfo`
				(
					`id`,`userid`,`topupmp`,`topupamount`,`userdate`,`userseqno`,`noticeurl`,`signinfo`
				)
				VALUES
				(
					null,
					'".$params['userId']."',
					'".$params['topupMp']."',
					'".$params['topupAmount']."',
					'".$params['userDate']."',
					'".$params['userSeqNo']."',
					'".$params['noticeUrl']."',
					'".$params['signInfo']."'
				)";
		$this->dbAdapter->query($sql);
		
		$response = $mycurl->post($params);
		$datainfo = array();
		if(!$response)
		{
			return $mycurl->error_string;
			$datainfo['status'] = '充值失败';
			$datainfo['desc'] = '提交失败';
		}
		else
		{
			return $res = simplexml_load_string($response);
			file_put_contents('test_mobile_result.txt', Ousu::ousu_dump($params, false), FILE_APPEND);
			file_put_contents('test_mobile_resulta.txt', Ousu::ousu_dump($res, false), FILE_APPEND);

			if($res->topupResult->errcode == 1000 || $res->topupResult->errcode == 0000){
				$datainfo['status'] = '等待充值';
				if($res->topupResult->errcode == 0000){
					$datainfo['desc'] = '订单排队中';
				}elseif($res->topupResult->errcode == 1000){
					$datainfo['desc'] = '请求提交成功';
				} 
			}else{
				$datainfo['status'] = '充值失败';
				$datainfo['desc'] = '提交失败';
			}
		}
		$datainfo['Id'] = $arr['Id'];
		$table = 'card_mobile_detail';
		//self::updatafoid($datainfo,$table);
	}

	
	//每次查询间隔必须 超过5分钟
	public function balanceinquiryAction()
	{
		require_once APPLICATION_PATH . '/models/curl.class.php';
		$mycurl = new curl($this->balanceinquiry_action);
		$params = array(
			'userId'=>$this->userId
		);	
		$response = $mycurl->post($params);
		if(!$response)
		{
		//	echo $mycurl->error_code.'<br />';
		//	echo $mycurl->error_string;
			return $mycurl->error_string ;
		}
		else
		{
		//	echo '<pre>';
		//	var_dump(urldecode($response));
			return simplexml_load_string($response);
		}
	}
	
	/**
	 * 更新操作
	 * Enter description here ...
	 * @param unknown_type $orderData
	 * @param unknown_type $id
	 */
	private  function updatafoid($datainfo,$table){
		$this->dbAdapter->beginTransaction();
		try {
			$where = "Id='".$datainfo['Id']."'";
			$rows_affected = $this->dbAdapter->update($table, $datainfo, $where);
			$this->dbAdapter->commit();
		}catch (Exception $e){
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}
	
	/*// ------------------- recycle ----------------- */
	/**
	 * 更新手机订单主表
	 */
	/*private  function mobile_co($orderData,$id){
		$this->dbAdapter->beginTransaction();
		try {
			//更新card_insurance_co表
			$table = 'card_mobile_co';
			$where = "Id='$id'";
			$rows_affected = $this->dbAdapter->update($table, $orderData, $where);
			$this->dbAdapter->commit();
		}catch (Exception $e){
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}*/
	
	/*public function callbackAction()
	{
		$this->dbAdapter = Zend_Registry::get('dbAdapter');
		$topupRequestAmount = $_POST['topupRequestAmount'];
		$topupSuccAmount = $_POST['topupSuccAmount'];
		$topupUnknowAmount = $_POST['topupUnknowAmount'];
		$topupMp = $_POST['topupMp'];
		$transactionStatus = $_POST['transactionStatus'];
		$topupDelay = $_POST['topupDelay'];
		$transactionId = $_POST['transactionId'];
		$userDate = $_POST['userDate'];
		$userSeqNo = $_POST['userSeqNo'];
		$errorCode = $_POST['errorCode'];
		$signInfo = $_POST['signInfo'];
		//file_put_contents('test_sucess.txt', Ousu::ousu_dump($_POST, false), FILE_APPEND);
		$this->dbAdapter->beginTransaction();
		try {
			$sql = "INSERT INTO
						`tmp_callbackdata`
					(
						`id`,`topupRequestAmount`,`topupSuccAmount`,`topupUnknowAmount`,`topupMp`,
						`transactionStatus`,`topupDelay`,`transactionId`,`userDate`,`userSeqNo`,
						`errorCode`,`signInfo` 
					)
					VALUES
					(
						null,
						'".$topupRequestAmount."',
						'".$topupSuccAmount."',
						'".$topupUnknowAmount."',
						'".$topupMp."',
						'".$transactionStatus."',
						'".$topupDelay."',
						'".$transactionId."',
						'".$userDate."',
						'".$userSeqNo."',
						'".$errorCode."',
						'".$signInfo."'
					)";
			$this->dbAdapter->query($sql);
			$code = array();
			$code = str_split($transactionStatus);
			$datainfo = array();
			if(($code[0].$code[1]) == 10 || ($code[0].$code[1]) == 13 || $code[0] == 0 || ($code[0].$code[1]) == 11 || ($code[0].$code[1]) == 26 ){
				$datainfo['chargeamount'] = $topupSuccAmount;
				$datainfo['status'] = '完成';
				$datainfo['chargedatetime']	= date('Y-m-d H:i:s');
			}else{
				$datainfo['status'] = '充值失败';
			}
			
			if(($code[0].$code[1]) == 10 || ($code[0].$code[1]) == 13){
				$datainfo['desc'] = '全额成功';
			}elseif($code[0] == 0){
				$datainfo['desc'] = '处理中';
			}elseif(($code[0].$code[1]) == 11 || ($code[0].$code[1]) == 26){
				$datainfo['desc'] = '部分成功';
			}else{
				$datainfo['desc'] = '充值失败';
			}
			$table = 'card_mobile_detail';
			$where = "phone = '".$topupMp."'";
			$this->dbAdapter->update($table,$datainfo,$where);
			
			//file_put_contents('test_sucess.txt', Ousu::ousu_dump($datainfo, false), FILE_APPEND);
			
			$sqlre = "SELECT status FROM card_mobile_detail WHERE cmcoid = '".$arg['userSeqNo']."' AND status != '完成' AND info = '通过'" ;
			$dataRes = $this->dbAdapter->fetchAll($sqlre);
			
			//file_put_contents('test_sucess.txt', Ousu::ousu_dump($datainfo, false), FILE_APPEND);
			
			//更新手机主表
			$datainfo = array();
			if(sizeof($dataRes == 0)){
				$datainfo['status'] = '完成';
				$datainfo['modifydatetime'] = date('Y-m-d H:i:s');
			}
			//else{
				//$datainfo['status'] = '订单失败';
			//}
			$sql = "SELECT * FROM card_mobile_co AS c WHERE Id ='".$id."'";
			$res = $this->dbAdapter->fetchRow($sql);
			
			//file_put_contents('test_sucess.txt', Ousu::ousu_dump($res), FILE_APPEND);
			
			if($res['status'] == '已支付'){
				self::mobile_co($datainfo,$dataRes['cmcoid']);
			}
			$this->dbAdapter->commit();
		}
		catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
		echo 'success';		
	}*/
	
	
}