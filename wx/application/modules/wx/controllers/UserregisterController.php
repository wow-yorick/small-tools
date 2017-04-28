<?php
class Wx_UserregisterController extends Zend_Controller_Action
{    
    public function init()
    {
        require_once APPLICATION_PATH . '/modules/all/models/wx_init_all.php'; // !--- COPY --- //
        $this->db = new baseDao();
        $this->db->setKeyId('Id');
        $this->db->setTable('wx_memeber');
    }
    
    
    public function indexAction(){
    	echo $this->view->render('/'.$this->view->moduleName.'/views/wechat/phone-login.phtml');
    }
    
    public function registerAction(){
    	if(!isset($_POST) && empty($_POST))
    		return;
    	$dataInfo = array();
    	$dataPhone = array();
    	$dataEmail = array();
    	foreach($_POST as $key => $value){
    		if(!empty($value)){
	    		$dataInfo[$key] = $value;
    		}
    	}
    	//手机注册
    	if($_POST['type'] == 1){
    			$dataPhone['name'] = $_POST['mobile'];
    			$dataPhone['mobile'] = $_POST['mobile'];
    			$dataPhone['password'] = $_POST['password'];
    			$dataPhone['type'] = $_POST['type'];
    			$dataPhone['rgtime'] = date('Y-m-d H:i:s');
    			$result = $this->db->addData($dataPhone,true);
    	}else if($_POST['type'] == 0){
    			$dataEmail['name'] = $_POST['email'];
    			$dataEmail['email'] = $_POST['email'];
    			$dataEmail['password'] = $_POST['password'];
    			$dataEmail['type'] = $_POST['type'];
    			$dataEmail['rgtime'] = date('Y-m-d H:i:s');
    			$result = $this->db->addData($dataEmail,true);
    	}
    	
    	if($result['success']){
			//$this->view->loginsession = new Zend_Session_Namespace('loginsession');
			//$this->view->loginsession->isLogin = 1;
			echo $this->view->render('/'.$this->view->moduleName.'/views/wechat/member-login.phtml');
    	}else{
    		echo "注册失败！";
    	}
    	
    }
    
    public function centerAction(){
    	echo $this->view->render('/'.$this->view->moduleName.'/views/wechat/phone-desktop.phtml');
    }
    
}

