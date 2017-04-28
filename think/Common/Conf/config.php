<?php

return array(
	//'配置项'=>'配置值'
	'DB_TYPE' => 'mysql', //数据库类型 mysql 3306 mongo 27017
	//'DB_HOST' => '127.0.0.1', //服务器地址
    'DB_HOST' => '115.47.57.234', //服务器地址
	'DB_NAME' => 'Think', //数据库名
	//'DB_USER' => 'root', //用户名
	//'DB_PWD' => '123456', //输入安装MySQL时设置的密码
	'DB_USER' => 'wowyorick', //用户名
	'DB_PWD' => 'yyd258', //输入安装MySQL时设置的密码
	'DB_PORT' => '3306', //端口
	'DB_PREFIX' => '', //数据库表前缀
	'DB_DSN' => '', //数据库连接DSN用于PDO方式
    //公司唯一编码配置(必须和数据库中公司编码一致)
    'DEPOT_CODE' => 'SCOMP001',
    //服务端同步地址
    'SERVER_API_URL' => 'http://think.5zyx.com/index.php/APIServer',
	//SESSION
	'SESSION_AUTO_START' => true,
	'SESSION_OPTIONS' => array(
		'expire' => 3600 * 12,   //session过期时间
	),
	//MEMCACHE
	//'DATA_CACHE_TYPE' => 'Memcache',
	'DATA_CACHE_TYPE' => 'File',
	'MEMCACHE_HOST' => '127.0.0.1:11211',
	'DATA_CACHE_TIME' => '3600', //单位秒
	'DATA_CACHE_PREFIX' => '_think',
	//时区设置
	'DEFAULT_TIMEZONE' => 'Asia/shanghai', // 设置默认时区为上海
	//URL
	'URL_MODEL' => 3,
	'URL_ROUTER_ON' => true,
	'URL_CASE_INSENSITIVE' => true, //url不区分大小写
	// 模版定义
	'LAYOUT_ON' => false,
	'LAYOUT_NAME' => 'layout',
	//错误定向页面
	'ERROR_PAGE' => '/404.html',
	'TMPL_L_DELIM' => '{{',
	'TMPL_R_DELIM' => '}}',
	//自定义
	//后台密码加密KEY
	'ADMIN_PASSWORD_KEY' => '__THINK__',
	'DEFAULT_CHARSET' => 'utf-8'

);
