<?php

class All_IndexController extends Zend_Controller_Action
{

	public function init()
	{
		//获取view实例
		$this->view = Zend_Registry::get('view');
	}

	public function indexAction()
	{
		//echo $this->view->render('/all/views/top_all.phtml');
	}
}