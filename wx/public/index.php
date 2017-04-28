<?php

//define('DS', DIRECTORY_SEPARATOR); //正反斜杠
//define('PS', PATH_SEPARATOR); //分号

//缓存文件存放路径前缀
defined('FILE_PREFIX_TEMP') || define('FILE_PREFIX_TEMP', $_SERVER['DOCUMENT_ROOT'] . '/upload/temp'); //定义文件系统路径前缀
defined('HTTP_PREFIX_TEMP') || define('HTTP_PREFIX_TEMP', 'http://' . $_SERVER['HTTP_HOST']); //定义网站http路径前缀

//上传文件存放目录
defined('FILE_PREFIX_PATH') || define('FILE_PREFIX_PATH', $_SERVER['DOCUMENT_ROOT'] . '/upload'); //定义文件系统路径前缀
defined('HTTP_PREFIX_PATH') || define('HTTP_PREFIX_PATH', 'http://' . $_SERVER['HTTP_HOST'] . '/upload'); //定义文件系统路径前缀

// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

defined('BASE_PATH')
    || define('BASE_PATH', realpath(dirname(__FILE__)));

// Ensure library/ is on include_path
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../library'),
    get_include_path(),
)));
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/models'),
    get_include_path(),
)));

/** Zend_Application */
require_once 'Zend/Application.php';

// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);
$application->bootstrap()
            ->run();
