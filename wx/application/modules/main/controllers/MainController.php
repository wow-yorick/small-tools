<?php

class Main_MainController extends Zend_Controller_Action // !--- MODIFY --- //
{
	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_rights.php'; // !--- COPY --- //
	}

	public function indexAction()
	{
		$this->view->menuList = $this->db->getMenuList($_SESSION[$this->view->sessionPrefix . 'rights_userRoleId']);
		echo $this->view->render('/main/views/index.phtml');
	}
	public function submenuserAction()
	{
		$this->view->temp = $_POST['supnav'];
		$menuList = $this->db->getMenuList($_SESSION[$this->view->sessionPrefix . 'rights_userRoleId']);
		$this->view->subarr = $menuList[$this->view->temp];
		echo $this->view->render('/main/views/menusub.phtml');
	}
}