<?php

//获取全局配置
$this->globalConfig = Zend_Registry::get('globalConfig');
$this->sessionPrefix = $this->globalConfig['session']['session_prefix']; //session前缀
$this->dbAdapter = Zend_Registry::get('dbAdapter');
//配置LOG
$this->logger = new Zend_Log();
$stream = @fopen(BASE_PATH . '/log.txt', 'a', false);
if (! $stream) {
    throw new Exception('Failed to open stream');
}
$writer = new Zend_Log_Writer_Stream($stream);
$this->logger->addWriter($writer);

//LOG写入数据库
$dbAdapter = Zend_Registry::get('dbAdapter');
$columnMapping = array('logdatetime'=>'timestamp','loglevel' => 'priorityName', 'content' => 'message');
$writer = new Zend_Log_Writer_Db($dbAdapter, 'sys_log', $columnMapping);
$filter = new Zend_Log_Filter_Priority(Zend_Log::INFO);
$this->logger->addFilter($filter);
//$this->logger->addWriter($writer);
