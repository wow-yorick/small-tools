<?php
return array(
	//URL 模式
	'URL_MODEL' => 1,
	'URL_ROUTER_ON' => true,
	'URL_CASE_INSENSITIVE' => true, //url不区分大小写
	//模版变量定义
	'TMPL_PARSE_STRING' => array(
		'__PUBLIC__' => __ROOT__ . '/' . APP_NAME . '/Public',
		'__JS__' => __ROOT__ . '/' . APP_NAME . '/Public/js',
		'__IMG__' => __ROOT__ . '/' . APP_NAME . '/Public/images',
		'__CSS__' => __ROOT__ . '/' . APP_NAME . '/Public/css',
		'__SKIN__' => __ROOT__ . '/' . APP_NAME . '/Public/skin',
	),
	//权限设置
	'AUTH_CONFIG' => array(
		'AUTH_ON' => true, //认证开关
		'AUTH_TYPE' => 1, // 认证方式，1为时时认证；2为登录认证。
		'AUTH_GROUP' => 'auth_group', //用户组数据表名
		'AUTH_GROUP_ACCESS' => 'auth_group_access', //用户组明细表
		'AUTH_RULE' => 'auth_rule', //权限规则表
		'AUTH_USER' => 'admin'//用户信息表
	),
	'ADMIN_AUTH_KEY' => 1,
	'USER_AUTH_KEY' => 'id',
	// 模版定义
	'LAYOUT_ON' => true,
	'LAYOUT_NAME' => 'layout',
	'ruleGroup' => require('ruleGroup.php'),
	'DEFAULT_CONTROLLER' => 'public'
	
);
