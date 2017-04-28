<?php
namespace Wxmanage\Model\Entrance\Msgtype;

use Wxmanage\Model\Entrance;

class GeneraltMsg implements WxmsgInterface
{
	public function replyTpl() {
			$tpl = "<xml>
			 <ToUserName><![CDATA[%s]]></ToUserName>
			 <FromUserName><![CDATA[%s]]></FromUserName>
			 <CreateTime>%s</CreateTime>
			 <MsgType><![CDATA[%s]]></MsgType>
			 <Music>
			 <Title><![CDATA[%s]]></Title>
			 <Description><![CDATA[%s]]></Description>
			 <MusicUrl><![CDATA[%s]]></MusicUrl>
			 <HQMusicUrl><![CDATA[%s]]></HQMusicUrl>
			 </Music>
			 <FuncFlag>0</FuncFlag>
			 </xml>";
			return $tpl;
	}
	
}
