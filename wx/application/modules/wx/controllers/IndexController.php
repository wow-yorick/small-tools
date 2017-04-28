<?php

class Wx_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        require_once APPLICATION_PATH . '/modules/all/models/wx_init_all.php'; // !--- COPY --- //
        $this->db = new baseDao();
        $this->db->setKeyId('Id');
    }
    
    private $postObj='';

    public function indexAction()
    {
    	$wechatObj = new wechatCallbackapi();
    	if(!empty($_GET["echostr"])){//身份验证
			$wechatObj->valid();
    	}else{//获取返回的信息
    		$this->postObj = $wechatObj->responseMsg();
    		if(!$this->postObj){
    			echo $this->view->render('/'.$this->view->moduleName.'/views/scripts/'.$this->view->controllerName.'/'.$this->view->actionName.'.phtml');exit;
    		}
    		if($this->postObj){//正确识别返回的信息
    			switch ($this->postObj->MsgType){
    				case 'text':
    					echo $this->txtmessage();
    					break;
    				case 'image':
    					echo $this->imagemessage();
    					break;
    				case 'location':
    					echo $this->locationmessage();
    					break;
    				case 'link':
    					echo $this->linkmessage();
    					break;
    				case 'event':
    					echo $this->eventmessage();
    					break;
    				default:
    					echo $this->txtmessage();
    			}
    		}
    	}
        
    }

    private  function txtmessage(){	
    	    $dataInfo = array();
			$dataInfo['fromUsername'] = trim($this->postObj->FromUserName);
            $dataInfo['toUsername'] = trim($this->postObj->ToUserName);
            $dataInfo['createTime'] = date('Y-m-d H:i:s',trim($this->postObj->CreateTime));
            $dataInfo['msgType'] = trim($this->postObj->MsgType);
            $dataInfo['content'] = trim($this->postObj->Content);
            $dataInfo['msgId'] = trim($this->postObj->MsgId);
            //file_put_contents('wx_dea.txt',Ousu::ousu_dump($dataInfo,false),FILE_APPEND);
            $this->db->setTable('wx_msg_text');
            $this->db->addData($dataInfo,false);          
                      
			if(!empty($dataInfo['content'])){
				$option = $this->dbAll->all_getGlobalType('信息分类');
				//file_put_contents('wx_dea.txt', Zend_Debug::dump($option,'OPTION:',false),FILE_APPEND);
				$newarr = array();
				$opStr = '';
            	foreach ($option as $key =>$val){
            		$contV = explode('|', $val['value']);
            		$newarr[$val['name'].'|'.$contV[1]] = $contV[0];
            		$opStr .= $contV[0].':'.$val['name'].';';
            	}
            	//file_put_contents('wx_dea.txt', Zend_Debug::dump($newarr,'newarr:',false),FILE_APPEND);
            	//file_put_contents('wx_dea.txt', Zend_Debug::dump($opStr,'opStr:',false),FILE_APPEND);
            	if(in_array($dataInfo['content'], $newarr)){
            		$flip = array_flip($newarr);
            		$type = explode('|', $flip[$dataInfo['content']]);
            		if(!empty($flip[$dataInfo['content']]) && !empty($type[1])){
            			$msgType = $type[1];
            		}else{
            			$defu = $this->dbAll->all_getConfData('配置','默认回复消息类型');
            			$msgType = $defu[0]['value'];
            			//file_put_contents('wx_dea.txt', Zend_Debug::dump(123,'type['.date('Y-m-d H:i:s'.']:'),false),FILE_APPEND);
            		}
            		$time = time();
            		$sql ="SELECT * FROM wx_".$msgType."msgcof WHERE TYPE='".$type['0']."' ORDER BY modifytime DESC";
            		//file_put_contents('wx_dea.txt', $sql,FILE_APPEND);
            		$dataMsg = $this->db->find($sql);
            		//file_put_contents('wx_dea.txt', Zend_Debug::dump($dataMsg,'dataMsg:',false),FILE_APPEND);
            		switch ($msgType){
            			case 'news':
            				$tpl = $this->getReplyTpl('news');
            				//file_put_contents('wx_dea.txt', Zend_Debug::dump($tpl,'tpl['.date('Y-m-d H:i:s'.']:'),false),FILE_APPEND);
            				$articleCount =$dataMsg['obj'][0]['articlecount'];
            				//file_put_contents('wx_dea.txt', Zend_Debug::dump($articleCount,'count['.date('Y-m-d H:i:s').']:',false),FILE_APPEND);
			              	$title_1=$dataMsg['obj'][0]['title'];
			              	//file_put_contents('wx_dea.txt', Zend_Debug::dump($title_1,'title['.date('Y-m-d H:i:s').']:',false),FILE_APPEND);
			              	$description_1 = $dataMsg['obj'][0]['description'];
			              	//file_put_contents('wx_dea.txt', Zend_Debug::dump($description_1,'description_1['.date('Y-m-d H:i:s').']:',false),FILE_APPEND);
			              	$picUrl_1 = $this->view->baseUrl().'/'.$dataMsg['obj'][0]['picurl'];
			              	
			              	//file_put_contents('wx_dea.txt', Zend_Debug::dump($picUrl_1,'picUrl_1['.date('Y-m-d H:i:s').']:',false),FILE_APPEND);
			              	$url_1 = $dataMsg['obj'][0]['url'];
			              	
			              	//file_put_contents('wx_dea.txt', Zend_Debug::dump($url_1,'url_1['.date('Y-m-d H:i:s').']:',false),FILE_APPEND);
            				$resultStr = sprintf($tpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1);
            				//file_put_contents('wx_dea.txt', Zend_Debug::dump($resultStr,'result['.date('Y-m-d H:i:s').']:',false),FILE_APPEND);
                		break;
                		//TODO:其他消息类型支持
            		}

            	}else{
            		$msgType = "text";
	                $contentStr = "回复数字查看相应页面:".$opStr;
			set_time_limit(0);
			//$p = new Collect("http://www.qiushibaike.com",'<div class="content" title="2013-12-31 12:49:54">','</div>');
			//$s = $p->cutHtml();
			//$contentStr = $p->filterStr($s[0],array('<div class="content" title="2013-12-31 12:49:54">','</div>');
	                $tpl = $this->getReplyTpl('text');
	                $resultStr = sprintf($tpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType, $contentStr);
            	}
            	return $resultStr;
				
				/*测试数据
				 * 
				 * switch ($dataInfo['content']){
					case 1:
						$msgType = "news";
		              	$articleCount =1;
		              	$title_1='注册成功';
		              	$description_1 = '注册成功';
		              	$picUrl_1 = 'http://www.frame.pw/wx/public/wechat/success.png';
		              	$url_1 = 'http://www.frame.pw/wx/public/wechat/login-succeed.html';
		              	$resultStr = sprintf($imgtxtTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1);
                		return $resultStr;
		              break;
					case 2:
						$msgType = "news";
		              	$articleCount =1;
		              	$title_1='会员中心登录界面';
		              	$description_1 = '会员中心登录界面';
		              	$picUrl_1 = 'http://www.frame.pw/wx/public/wechat/login.png';
		              	$url_1 = 'http://www.frame.pw/wx/public/wechat/member-login.html';
		              	$resultStr = sprintf($imgtxtTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1);
                		return $resultStr;
		              break;
					case 3:
						$msgType = "news";
		              	$articleCount =1;
		              	$title_1='主界面';
		              	$description_1 = '主界面';
		              	$picUrl_1 = 'http://www.frame.pw/wx/public/wechat/desktop.png';
		              	$url_1 = 'http://www.frame.pw/wx/public/wechat/phone-desktop.html';
		              	$resultStr = sprintf($imgtxtTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1);
                		return $resultStr;
		              break;
		            case 4:
						$msgType = "news";
		              	$articleCount =1;
		              	$title_1='注册界面';
		              	$description_1 = '注册界面';
		              	$picUrl_1 = 'http://www.frame.pw/wx/public/wechat/loginjem.png';
		              	$url_1 = 'http://www.frame.pw/wx/public/wechat/phone-login.html';
		              	$resultStr = sprintf($imgtxtTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1);
                		return $resultStr;
		              break;
		              case 5:
						$msgType = "news";
		              	$articleCount =1;
		              	$title_1='M-center';
		              	$description_1 = 'M-center';
		              	$picUrl_1 = 'http://www.frame.pw/wx/public/wechat/m-center.png';
		              	$url_1 = 'http://www.frame.pw/wx/public/wechat/phone-m-center.html';
		              	$resultStr = sprintf($imgtxtTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1);
                		return $resultStr;
		              break;
		            case 6:
						$msgType = "news";
		              	$articleCount =1;
		              	$title_1='phone-register';
		              	$description_1 = 'phone-register';
		              	$picUrl_1 = 'http://www.frame.pw/wx/public/wechat/register.png';
		              	$url_1 = 'http://www.frame.pw/wx/public/wechat/phone-register.html';
		              	$resultStr = sprintf($imgtxtTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1);
                		return $resultStr;
		              break;
		            default:
		            	$msgType = "text";
		                $contentStr = "回复数字查看相应页面:".$opStr;
		                $resultStr = sprintf($textTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType, $contentStr);
		                return $resultStr;
				}*/
            }else{
                return false;
            }    			
    }
    
    private  function imagemessage(){	
    	    $dataInfo = array();
			$dataInfo['fromUsername'] = trim($this->postObj->FromUserName);
            $dataInfo['toUsername'] = trim($this->postObj->ToUserName);
            $dataInfo['createTime'] = date('Y-m-d H:i:s',trim($this->postObj->CreateTime));
            $dataInfo['msgType'] = trim($this->postObj->MsgType);
            $dataInfo['picUrl'] = trim($this->postObj->PicUrl);
            $dataInfo['msgId'] = trim($this->postObj->MsgId);
            $this->db->setTable('wx_msg_image');
            $this->db->addData($dataInfo,false);          
            $imgtxtTpl = "<xml>
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
			 <item>
			 <Title><![CDATA[%s]]></Title>
			 <Description><![CDATA[%s]]></Description>
			 <PicUrl><![CDATA[%s]]></PicUrl>
			 <Url><![CDATA[%s]]></Url>
			 </item>
			 </Articles>
			 <FuncFlag>1</FuncFlag>
			 </xml>";           
			if(!empty( $dataInfo['picUrl'] )){
	            $time = time();
              	$msgType = "news";
              	$articleCount =2;
              	$title_1='javascript教程';
              	$description_1 = 'javascript教程学习哦，大家一起交流';
              	$picUrl_1 = 'http://img1.51cto.com/attachment/201106/125246705.jpg';
              	$url_1 = 'http://www.hatbug.com';
              	$title_2='小游戏';
              	$description_2 = '小游戏';
              	$picUrl_2 = 'http://img1.51cto.com/attachment/201106/125246705.jpg';
              	$url_2 = 'http://www.yybright.com';
                $resultStr = sprintf($imgtxtTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$articleCount,$title_1,$description_1,$picUrl_1,$url_1,$title_2,$description_2,$picUrl_2,$url_2);
                return $resultStr;
            }else{
                return false;
            }    			    	
    }
    
    private  function locationmessage(){	
    	    $dataInfo = array();
			$dataInfo['fromUsername'] = trim($this->postObj->FromUserName);
            $dataInfo['toUsername'] = trim($this->postObj->ToUserName);
            $dataInfo['createTime'] = date('Y-m-d H:i:s',trim($this->postObj->CreateTime));
            $dataInfo['msgType'] = trim($this->postObj->MsgType);
            $dataInfo['location_x'] = trim($this->postObj->Location_X);
            $dataInfo['location_y'] = trim($this->postObj->Location_Y);
            $dataInfo['scale'] = trim($this->postObj->Scale);
            $dataInfo['label'] = trim($this->postObj->Label);
            $dataInfo['msgId'] = trim($this->postObj->MsgId);
            //file_put_contents('wx_dea.txt',Ousu::ousu_dump($this->postObj,false),FILE_APPEND);
            $this->db->setTable('wx_msg_location');
            $this->db->addData($dataInfo,false);          
            $time = time();
            $textTpl = "<xml>
				<ToUserName><![CDATA[%s]]></ToUserName>
				<FromUserName><![CDATA[%s]]></FromUserName>
				<CreateTime>%s</CreateTime>
				<MsgType><![CDATA[%s]]></MsgType>
				<Content><![CDATA[%s]]></Content>
				<FuncFlag>0</FuncFlag>
				</xml>";           
			if(!empty( $dataInfo['msgId'] )){
              	$msgType = "text";
                $contentStr = "你给我发的是地理位置消息哦！";
                $resultStr = sprintf($textTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType, $contentStr);
                return $resultStr;
            }else{
                return false;
            }    			    	
    }

    
    private  function linkmessage(){	
    	    $dataInfo = array();
			$dataInfo['fromUsername'] = trim($this->postObj->FromUserName);
            $dataInfo['toUsername'] = trim($this->postObj->ToUserName);
            $dataInfo['createTime'] = date('Y-m-d H:i:s',trim($this->postObj->CreateTime));
            $dataInfo['msgType'] = trim($this->postObj->MsgType);
            $dataInfo['title'] = trim($this->postObj->Title);
            $dataInfo['Description'] = trim($this->postObj->Description);
            $dataInfo['url'] = trim($this->postObj->Url);
            $dataInfo['msgId'] = trim($this->postObj->MsgId);
            //file_put_contents('wx_dea.txt','link:'.Ousu::ousu_dump($dataInfo,false),FILE_APPEND);
            $this->db->setTable('wx_msg_link');
            $this->db->addData($dataInfo,false);          
            $time = time();
            $musicTpl = "<xml>
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
			if(!empty( $dataInfo['url'] )){
              	$msgType = "music";
              	$title = '我的音乐';
              	$description = '想不想听';
                $musicUrl = "http://www.frame.pw/wx/public/music/wxid_hmqry0244stn21_20130628_233350.mp3";
                $HQMusicUrl = "http://www.frame.pw/wx/public/music/wxid_hmqry0244stn21_20130628_233350.mp3";
                $resultStr = sprintf($musicTpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType,$title,$description,$musicUrl,$HQMusicUrl);
                return $resultStr;
            }else{
                return false;
            }    			    	
    }    
    
    private  function eventmessage(){	
    	    $dataInfo = array();
			$dataInfo['fromUsername'] = trim($this->postObj->FromUserName);
            $dataInfo['toUsername'] = trim($this->postObj->ToUserName);
            $dataInfo['createTime'] = date('Y-m-d H:i:s',trim($this->postObj->CreateTime));
            $dataInfo['msgType'] = trim($this->postObj->MsgType);
            $dataInfo['event'] = trim($this->postObj->Event);
            $dataInfo['eventKey'] = trim($this->postObj->EventKey);
            file_put_contents('wx_dea.txt','event:'.Ousu::ousu_dump($this->postObj,false),FILE_APPEND);
            $this->db->setTable('wx_msg_event');
            $this->db->addData($dataInfo,false);  
            $tpl = $this->getReplyTpl('text');        
            $time = time();    
			if(!empty( $dataInfo['event'] )){
              	$msgType = "text";
				$option = $this->dbAll->all_getGlobalType('信息分类');
				//file_put_contents('wx_dea.txt', Zend_Debug::dump($option,'OPTION:',false),FILE_APPEND);
				$opStr = '';
            	foreach ($option as $key =>$val){
            		$contV = explode('|', $val['value']);
            		$opStr .= $contV[0].':'.$val['name'].';';
            	}
                $contentStr = "感谢您的关注，您可以通过以下操作获取您需要的信息：".$opStr;
                $resultStr = sprintf($tpl, $dataInfo['fromUsername'], $dataInfo['toUsername'], $time, $msgType, $contentStr);
                return $resultStr;
            }else{
                return false;
            }    			    	
    }
    
    private function getReplyTpl($type='news'){
    	switch ($type){
    		case 'text':
    			$tpl = "<xml>
				<ToUserName><![CDATA[%s]]></ToUserName>
				<FromUserName><![CDATA[%s]]></FromUserName>
				<CreateTime>%s</CreateTime>
				<MsgType><![CDATA[%s]]></MsgType>
				<Content><![CDATA[%s]]></Content>
				<FuncFlag>0</FuncFlag>
				</xml>";
    			break;
    		case 'news':
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
    			break;
    		case '':
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
    			break;
    	}
    	return $tpl;
    }
    
}

