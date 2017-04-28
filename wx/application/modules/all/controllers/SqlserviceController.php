<?php

class All_SqlserviceController extends Zend_Controller_Action
{

	public function init()
	{
		$this->view = Zend_Registry::get('view');
		$this->globalConfig = Zend_Registry::get('globalConfig');
		$this->view->sessionPrefix = $this->globalConfig['session']['session_prefix']; //session前缀

		//获取统一的数据操作方法
		$this->dbAll = new db_all();
		$this->view->moduleName = $this->_request->getModuleName();
		$this->view->controllerName = $this->_request->getControllerName();
		$this->view->actionName = $this->_request->getActionName();

		//加载model，名称格式为："db_controllerName"
		$path = realpath(APPLICATION_PATH . '/modules/' . $this->view->moduleName . '/models/db_' . $this->view->controllerName . '.php');
		if (file_exists($path)) {
			require_once $path;
			$className = 'db_' . $this->view->controllerName;
			if (class_exists($className)) {
				$this->db = new $className();
			}
		}
	}

	public function indexAction()
	{
		echo "";
	}
	
	public function getdatatableAction()
	{
		$sSql = $_POST["sql"];
		$result = $this->db->getData($sSql);
		echo json_encode($result);
	}
	
	public function getdatatableurlAction()
	{
		$sSql = $_POST["sql"];
		$result = $this->db->getData($sSql);
		foreach($reslutl as $id => $arr)
		foreach($arr as $key=>$value) {
			$result[$id][$key] = urlencode($value);
		};
		echo json_encode($result);
	}
	
	public function runsqlAction()
	{
		$sSql = $_POST["sql"];
		$this->db->runSql($sSql);
		echo "";
	}

	public function uploadfileAction()
	{
		file_put_contents("test.txt", ousu_helper::ousu_dump($_FILE,false));
		echo "";
	}
}