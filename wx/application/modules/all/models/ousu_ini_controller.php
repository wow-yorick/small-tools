<?php

//获取view实例
$this->view = Zend_Registry::get('view');

//获取全局配置
$this->globalConfig = Zend_Registry::get('globalConfig');
$this->view->sessionPrefix = $this->globalConfig['session']['session_prefix']; //session前缀

//配置LOG
$this->logger = new Zend_Log();
$stream = @fopen(BASE_PATH . '/log.txt', 'a', false);
if (! $stream) {
    throw new Exception('Failed to open stream');
}
$writer = new Zend_Log_Writer_Stream($stream);
$this->logger->addWriter($writer);


//获取统一的数据操作方法
$this->dbAll = new db_all();
$this->ousu_helper = new all_model_ousu_helper();
$this->view->moduleName = $this->_request->getModuleName();
$this->view->controllerName = $this->_request->getControllerName();
$this->view->actionName = $this->_request->getActionName();
//获取action权限
$this->view->allActionRights = $this->dbAll->all_getControllerActionRights($this->view->moduleName, $this->view->controllerName); //获取controller下所有action的权限
//LOG写入数据库
$dbAdapter = Zend_Registry::get('dbAdapter');
$columnMapping = array('logdatetime'=>'timestamp','loglevel' => 'priorityName', 'content' => 'message');
$writer = new Zend_Log_Writer_Db($dbAdapter, 'sys_log', $columnMapping);
$filter = new Zend_Log_Filter_Priority(Zend_Log::INFO);
$this->logger->addFilter($filter);
$this->logger->addWriter($writer);


//注册models目录的类
require_once APPLICATION_PATH . '/models/guid.class.php';
require_once APPLICATION_PATH . '/models/baseDao.class.php';
require_once APPLICATION_PATH . '/models/basePageModel.class.php';
require_once APPLICATION_PATH . '/models/ousu.class.php';



//加载model，名称格式为："db_controllerName"
$path = realpath(APPLICATION_PATH . '/modules/' . $this->view->moduleName . '/models/db_' . $this->view->controllerName . '.php');
if (file_exists($path)) {
	require_once $path;
	$className = 'db_' . $this->view->controllerName;
	if (class_exists($className)) {
		$this->db = new $className();
		$this->dbType = "real";
	}
}
else {
	$this->db = new baseDao();
	$this->dbType = "base";
}

//加载model的interface，名称格式为"interface_controllerName"
$path = realpath(APPLICATION_PATH . '/modules/' . $this->view->moduleName . '/models/interface_' . $this->view->controllerName . '.php');
if (file_exists($path)) {
	require_once $path;
	if (class_exists($className = 'interface_' . $this->view->controllerName)) { //单表模板
		$this->interfaceDefine = new $className();
		$this->view->menuinfo = $this->interfaceDefine->getMenuDefine();
		$this->view->gridinfo = $this->interfaceDefine->getGridDefine();
	} else if (class_exists($className = 'interface_single_' . $this->view->controllerName)) { //单表模板(新)
		$this->interfaceDefine = new $className();
		$this->view->dataMenuInfo = $this->interfaceDefine->getMenuDefine();
		$this->view->dataGridInfo = $this->interfaceDefine->getGridDefine();
		//设置数据库
		if ($this->dbType == "base"){
			if (isset($this->view->dataGridInfo["table"])) $this->db->setTable($this->view->dataGridInfo["table"]);
			$this->db->setKeyId($this->view->dataGridInfo["keyid"]);	
		}
		//生成菜单按钮
		$HTMLHelper["basemenu"] = $this->ousu_helper->getMenuListHtmlWithRightsBaseMenu($this->view->dataMenuInfo);
		$HTMLHelper["confirmmenu"] = $this->ousu_helper->getMenuListHtmlConfirmMenu($this->view->dataMenuInfo);
		$HTMLHelper["searchmenu"] = $this->ousu_helper->getMenuSearchHtml($this->view->dataMenuInfo);
		$HTMLHelper["othermenu"] = $this->ousu_helper->getMenuListHtmlWithRightsOhterMenu($this->view->dataMenuInfo);
		$this->view->dataHTMLhelper = $HTMLHelper;
	} else if (class_exists($className = 'interface_multitab_' . $this->view->controllerName)) { //多表模板
		$this->interfaceDefine = new $className();
		$this->view->rootMenuInfo = $this->interfaceDefine->root_getMenuDefine();
		$this->view->rootGridInfo = $this->interfaceDefine->root_getGridDefine();
		$this->view->subMenuInfo = $this->interfaceDefine->sub_getMenuDefine();
		$this->view->subGridInfo = $this->interfaceDefine->sub_getGridDefine();
		//生成主表菜单按钮
		$HTMLHelper["basemenu"] = $this->ousu_helper->getMenuListHtmlWithRightsBaseMenu($this->view->rootMenuInfo);
		$HTMLHelper["confirmmenu"] = $this->ousu_helper->getMenuListHtmlConfirmMenu($this->view->rootMenuInfo);
		$HTMLHelper["searchmenu"] = $this->ousu_helper->getMenuSearchHtml($this->view->rootMenuInfo);
		$HTMLHelper["othermenu"] = $this->ousu_helper->getMenuListHtmlWithRightsOhterMenu($this->view->rootMenuInfo);
		$this->view->rootHTMLhelper = $HTMLHelper;
		//生成从表菜单按钮
		$HTMLHelper["basemenu"] = $this->ousu_helper->getMenuListHtmlWithRightsBaseMenu($this->view->subMenuInfo);
		$HTMLHelper["confirmmenu"] = $this->ousu_helper->getMenuListHtmlConfirmMenu($this->view->subMenuInfo);
		$HTMLHelper["othermenu"] = $this->ousu_helper->getMenuListHtmlWithRightsOhterMenu($this->view->subMenuInfo);
		$this->view->subHTMLhelper = $HTMLHelper;
	} else if (class_exists($className = 'interface_tiny_' . $this->view->controllerName)) { //tiny表模板
		$this->interfaceDefine = new $className();
		$this->view->dataMenuInfo = $this->interfaceDefine->getMenuDefine();
		$this->view->dataGridInfo = $this->interfaceDefine->getGridDefine();
		$HTMLHelper["basemenu"] = $this->ousu_helper->getMenuListHtmlWithRightsBaseMenu($this->view->dataMenuInfo);
		$HTMLHelper["confirmmenu"] = $this->ousu_helper->getMenuListHtmlConfirmMenu($this->view->dataMenuInfo);
		$HTMLHelper["searchmenu"] = $this->ousu_helper->getMenuSearchHtml($this->view->dataMenuInfo);
		$HTMLHelper["othermenu"] = $this->ousu_helper->getMenuListHtmlWithRightsOhterMenu($this->view->dataMenuInfo);
		$HTMLHelper["trTemplate"] = $this->ousu_helper->normal_getDataListTrTemplate($this->view->dataMenuInfo, $this->view->dataGridInfo);
		$this->view->dataHTMLhelper = $HTMLHelper;
	}
}



