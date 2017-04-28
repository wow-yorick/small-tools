<?php
class basePageModel
{
	private $logger;

	public function __construct() 
	{
		$this->logger = new Zend_Log();
		$stream = @fopen(BASE_PATH . '/log.txt', 'a', false);
		if (! $stream) {
    		throw new Exception('Failed to open stream');
		}
		$writer = new Zend_Log_Writer_Stream($stream);
		$this->logger->addWriter($writer);
	}	
	
	public static function getDataGrid(){
		return array(
			"id" => "id",    //keyField名称
			"total" => 0,    //总记录数
			"page" => 0,     //当前页
			"sort" => "", 	 //排序字段
			"order" => "asc", //排什么序 asc,desc
			"rows" => null,  //每行记录
			"footer" => null, //脚部行记录
		);
	}

	public static function getTreeNode(){
		return array(
			"id" => "id",
			"text" => "name",		// 树节点名称
			"iconCls" => "iconCls",	// 前面的小图标样式
			"checked" => false,		// 是否勾选状态
			"attributes" => null,	// 其他参数
			"children" => null,		// 子节点
			"state" => "open"		// 是否展开(open,closed)
		);
	}

	public static function getSessionInfo(){
		return array(
			"isLogin" => false, 
			"userId" => "",         //用户ID
			"loginName" => "",      //用户登录名称
			"ip" => "",             //IP地址
			"authIds" => "",        //拥有的权限ID集合
			"authNames" => "",
			"authUrls" => "",
			"roleIds" => "",
			"roleNames" => ""
		);
	}
	
	public static function getDataGridInit(){
		$result = array(
			"url" => "<{baseUrl}>/<{m}>/<{c}>/datagrid",
			"fit" => true,
			"border" => false,
			"pagePosition" => "bottom",
			"pageSize" => 20,
			"pagination" => true,
			"pageList" => '[10,20,30,50]',
			"idField" => "id",
			"sortName" => "id",
			"sortOrder" => "asc",
			"CheckOnSelect" => true,
			"SelectOnCheck" => true,
			"fitColumns" => true,
			"toolbar" => array(
				array(
					"text" => "增加",
					"iconCls" => "icon-add",
					"handler" => "function(){<{m}>_<{c}>_addFun();}"
				),
				array(
					"text" => "修改",
					"iconCls" => "icon-edit",
					"handler" => "function(){<{m}>_<{c}>_editFun();}"
				),
				array(
					"text" => "删除",
					"iconCls" => "icon-remove",
					"handler" => "function(){<{m}>_<{c}>_delFun()}"
				),
				array(
					"text" => "查看",
					"iconCls" => "icon-tip",
					"handler" => "function(){<{m}>_<{c}>_viewFun()}"
				),
			),
		);
		return $result;
	}
}