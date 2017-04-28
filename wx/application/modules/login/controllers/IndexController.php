<?php
class Login_IndexController extends Zend_Controller_Action
{
	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
	}
	
	public function indexAction()
	{
		$_SESSION[$this->view->sessionPrefix . 'webTitle'] = $this->globalConfig['website']['title'];
		if (empty($_SESSION[$this->view->sessionPrefix . 'username'])) {
			echo $this->view->render('/login/views/index.phtml');
		} else {
			$this->_redirect('main/main');
		}
	}

	/**
	 * 生成验证码
	 */
	public function vercodeAction()
	{
		require_once APPLICATION_PATH . '/modules/login/views/Captcha/Captcha.php';
		Captcha::$seKey = $this->view->sessionPrefix . 'seKey'; //登录验证码的session键名
		Captcha::$useImgBg = true;  //是否使用背景图片
		Captcha::$useNoise = false; //是否添加杂点
		Captcha::$useCurve = false; //是否绘制干扰线
		Captcha::$useZh = false; //是否使用中文验证码
		Captcha::$fontSize = 15; //验证码字体大小(像素)
		Captcha::$length = 4; // 验证码字符数
		Captcha::$_codeSet = '0123456789'; //验证码字符串
		Captcha::entry(); //输出图片
	}
	
	public function vercodecheckAction(){
		$vercode = $_POST['param'];
		if ($vercode != $_SESSION[$this->view->sessionPrefix . 'seKey']['code']) {
			echo '{
			"info":"验证码错误！",
			"status":"n"
		 	}';
		}else echo '{
			"info":"验证通过！",
			"status":"y"
		 	}';	
	}

	/**
	 * 登录
	 */
	public function loginAction()
	{
		//all_model_ousu_helper:: ousu_dump($_SESSION); exit();
		$params = array();
		$params["username"] = $_POST["username"];
		$params["password"] = md5($_POST["password"]);
		$vercode = strtoupper($_POST['vercode']);
		//file_put_contents('test_zh.txt', Ousu::ousu_dump($vercode, false), FILE_APPEND);exit;
			$result = $this->db->login($params);

			if ($result["success"]){
				$_SESSION[$this->view->sessionPrefix . 'userId'] = $result["obj"][0]["Id"];
				$_SESSION[$this->view->sessionPrefix . 'username'] = $params["username"];
				$_SESSION[$this->view->sessionPrefix . 'accountTypeId'] = 1;
				$_SESSION[$this->view->sessionPrefix . 'rights_userRoleId'] = $this->dbAll->all_getUserRoleId(1, $_SESSION[$this->view->sessionPrefix . 'userId']);
				echo '{
				"info":"验证通过！",
				"status":"y"
			 	}';	
			}else echo '{
			"info":"帐号或密码错误！",
			"status":"n"
		 	}';
	}
	

	/**
	 * 注销
	 */
	public function logoutAction()
	{
		//销毁本站的session
		foreach ($_SESSION as $key => $val) {
			if (strpos($key, $this->view->sessionPrefix) === 0) { //必须要用'==='
				unset($_SESSION[$key]);
			}
		}
		session_destroy();

		$this->_redirect('login');
	}
}