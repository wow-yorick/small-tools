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


	//获取统一的数据操作方
	$this->dbAll = new db_all();
	$this->ousu_helper = new all_model_ousu_helper();
	$this->view->moduleName = $this->_request->getModuleName();
	$this->view->controllerName = $this->_request->getControllerName();
	$this->view->actionName = $this->_request->getActionName();

	//LOG写入数据
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
	require_once APPLICATION_PATH . '/models/collect.class.php';
	require_once APPLICATION_PATH . '/modules/all/models/wx_totall.php'; // !--- COPY --- //
