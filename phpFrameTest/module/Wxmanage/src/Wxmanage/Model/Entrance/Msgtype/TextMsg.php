<?php
namespace Wxmanage\Model\Entrance\Msgtype;

use Wxmanage\Model\Entrance;

class TextMsg implements WxmsgInterface
{
	private $postObj;

	public function __construct($request){
		$this->postObj = $request;
	}

	public function replyTpl() {
			$tpl = "<xml>
			<ToUserName><![CDATA[%s]]></ToUserName>
			<FromUserName><![CDATA[%s]]></FromUserName>
			<CreateTime>%s</CreateTime>
			<MsgType><![CDATA[%s]]></MsgType>
			<Content><![CDATA[%s]]></Content>
			<FuncFlag>0</FuncFlag>
			</xml>";
			return $tpl;
	}

	public function responseMsg() {
		$dataInfo = array();
		$dataInfo['fromUsername'] = trim($this->postObj->FromUserName);
		$dataInfo['toUsername'] = trim($this->postObj->ToUserName);
		$dataInfo['createTime'] = date('Y-m-d H:i:s',trim($this->postObj->CreateTime));
		$dataInfo['msgType'] = trim($this->postObj->MsgType);
		$dataInfo['content'] = trim($this->postObj->Content);
		$dataInfo['msgId'] = trim($this->postObj->MsgId);
		$time = time();

		$tpl = $this->replyTpl();
		$response = sprintf($tpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType, $contentStr);
	}
	
}
