<?php

require_once APPLICATION_PATH . '/modules/all/models/db_all.php';
require_once APPLICATION_PATH . '/modules/all/models/ousu_helper.php';

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{

}

session_start();

$view = new Zend_View();
$view->setScriptPath(APPLICATION_PATH . '/modules');
Zend_Registry::set('view', $view);

//获取数据库配置文件
$config = new Zend_Config_Ini(APPLICATION_PATH.'/configs/db_config.ini', null, true);

//初始数据库
$dbConfig = parse_ini_file(APPLICATION_PATH.'/configs/db_config.ini', true);
foreach ($dbConfig as $key=>$item) {
	$dbAdapter = Zend_Db::factory($config->$key->resources->db->adapter, $config->$key->resources->db->params->toArray());
	Zend_Registry::set($item['ZendDbAdapterName'], $dbAdapter);
}

//初始化全局配置文件
$globalConfig = parse_ini_file(APPLICATION_PATH.'/configs/global_config.ini', true);
Zend_Registry::set('globalConfig', $globalConfig);