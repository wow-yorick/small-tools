<?php
namespace Wxmanage\Model\Entrance\Msgtype;

use Wxmanage\Model\Entrance;

class NewsMsg implements WxmsgInterface
{
	public function replyTpl() {
			$tpl = "<xml>
			 <ToUserName><![CDATA[%s]]></ToUserName>
			 <FromUserName><![CDATA[%s]]></FromUserName>
			 <CreateTime>%s</CreateTime>
			 <MsgType><![CDATA[%s]]></MsgType>
			 <ArticleCount>%s</ArticleCount>
			 <Articles>
			 <item>
			 <Title><![CDATA[%s]]></Title> 
			 <Description><![CDATA[%s]]></Description>
			 <PicUrl><![CDATA[%s]]></PicUrl>
			 <Url><![CDATA[%s]]></Url>
			 </item>
			 </Articles>
			 <FuncFlag>1</FuncFlag>
			 </xml>";
			return $tpl;
	}
	
}
