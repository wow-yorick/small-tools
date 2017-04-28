<?php

class IndexController extends Zend_Controller_Action
{

	public function init()
	{
	}

	public function indexAction()
	{
		$this->_redirect('login'); //浏览器地址栏url会变，不会执行它之后的代码
		//echo $this->view->render('/default/views/top_default.phtml');
		//$this->_forward('index', 'index' , 'login'); //浏览器地址栏url不变，会执行它之后的代码，init()里无法用forward，只能在Action()里用
	}
}