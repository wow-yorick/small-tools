<?php

class Wx_StuffController extends Zend_Controller_Action
{

    public function init()
    {
        require_once APPLICATION_PATH . '/modules/all/models/wx_init_all.php'; // !--- COPY --- //
        $this->db = new baseDao();
        $this->db->setKeyId('Id');
        require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_rights.php'; // !--- COPY --- //
    }
    

    public function indexAction()
    {
        echo $this->view->render('/' . $this->view->moduleName . '/views/scripts/' . $this->view->controllerName . '/index.phtml');
    }
    
    public function imgtextmsgAction(){
    	echo $this->view->render('/' . $this->view->moduleName . '/views/scripts/' . $this->view->controllerName . '/'.$this->view->actionName.'.phtml');
    }
    
    
	public function imgmsgAction(){
    	$form = new Zend_Form;
    	$form->setAction($this->view->baseUrl().'/'.$this->view->moduleName.'/'.$this->view->controllerName.'/addimgmsg')
    		->setMethod('post')
    		->setAttrib('id','imgform')
    		->addElement('file', 'image', array(
		    'required' => true,
    		'label'=>'图片'
		))
			->addElement('hidden','type',array(
			'required' =>true
			,'value'=>'image')
			)
		->addElement('submit', 'submit', array('label' => '提交'));
		$this->form  = $form;
		//echo $form->render($this->view);
    		//echo $this->view->render('/' . $this->view->moduleName . '/views/scripts/' . $this->view->controllerName . '/'.$this->view->actionName.'.phtml');
    	echo $form;
    }
    
	public function voiceAction(){
    	$form = new Zend_Form;
    	$form->setAction($this->view->baseUrl().'/'.$this->view->moduleName.'/'.$this->view->controllerName.'/addimgmsg')
    		->setMethod('post')
    		->setAttrib('id','voiceform')
    		->addElement('file', 'voice', array(
		    'required' => true,
    		'label'=>'声音'
		))
			->addElement('hidden','type',array(
			'required' =>true
			,'value'=>'voice')
			)
		->addElement('submit', 'submit', array('label' => '提交'));
		$this->form  = $form;
		//echo $form->render($this->view);
    		//echo $this->view->render('/' . $this->view->moduleName . '/views/scripts/' . $this->view->controllerName . '/'.$this->view->actionName.'.phtml');
    	echo $form;
    }
    
	public function videoAction(){
    	$form = new Zend_Form;
    	$form->setAction($this->view->baseUrl().'/'.$this->view->moduleName.'/'.$this->view->controllerName.'/addimgmsg')
    		->setMethod('post')
    		->setAttrib('id','videoform')
    		->addElement('file', 'video', array(
		    'required' => true,
    		'label'=>'视频'
		))
			->addElement('hidden','type',array(
			'required' =>true
			,'value'=>'video')
			)
		->addElement('submit', 'submit', array('label' => '提交'));
		$this->form  = $form;
		//echo $form->render($this->view);
    		//echo $this->view->render('/' . $this->view->moduleName . '/views/scripts/' . $this->view->controllerName . '/'.$this->view->actionName.'.phtml');
    	echo $form;
    }
    
    public function addimgmsgAction(){
    	
    	$type=$this->_request->getPost('type');
    	$Destination = FILE_PREFIX_PATH.'/'.$type.'msg';
    	if(!is_dir($Destination)){
    		mkdir($Destination);
    	}
    	$adapter = new Zend_File_Transfer_Adapter_Http();
    	
		$adapter->setDestination($Destination);
		
		$upload = new Zend_File_Transfer();
		
		// Set a file size with 20 bytes minimum and 20000 bytes maximum and
		// a file count in one step
		$upload->setValidators(array(
		    'Size'  => array('min' => 1, 'max' => 20000),
		    'Count' => array('min' => 1, 'max' => 3)
			//'ExcludeMimeType' =>array('image/gif','image/jpeg')
		    
		));
		switch($type){
			case 'image':
				$upload->addValidator('IsImage', false);
			break;
			case 'voice':
				$upload->addValidator('MimeType', false, 'mp3');
            break;
			case 'video':
				$upload->addValidator('MimeType', false, 'flv');
            break;
            default:echo '未支持的格式！';exit;
				
				
		}
		
		if ($upload->isValid()) {
		    print "Validation failure";
		    return;
		}
		//重命名配置
		$fileInfo = $adapter->getFileInfo();//获取基本配置
		$extName=$this->getExtension($fileInfo);//获取扩展名
		$filename=md5(time()+$fileInfo[$type]['name']).'.'.$extName;//重命名
		$adapter->addFilter('Rename', array('target' => $filename, 'overwrite' => true));//执行重命名
		
		if (!$adapter->receive()) {
		    $messages = $adapter->getMessages();
		    echo implode("\n", $messages);
		}
		
		//$developer = $this->dbAll->all_getConfData('配置','开发者账号');
		$dataInfo = array(
			'type' =>$type
			,'url' =>'/upload/'.$type.'msg/'.$filename
			,'createtime' =>date('Y-m-d H:i:s')
		);
		$this->db->setTable('wx_material');
		$result = $this->db->addData($dataInfo);
		if($result['success']){
			echo "上传成功！";
			sleep(3);
			//$this->_redirect('/'.$this->view->moduleName.'/'.$this->view->controllerName);
			$this->_redirect('/');
		}
		    	
    }

	/**
	 * 获取文件扩展名
	 * @param String $name 	文件名词
	 * @author 
	 */
	public function getExtension ($name)
	{
		$fname='';
		if($name)
		{
			foreach ($name as $val)
			{
				$fname=$val['name'];
			}
			$exts = @split("[/\\.]", $fname) ;
			$n = count($exts)-1;
			$exts = $exts[$n];
			return $exts;
		}
	}
    
}

