<?php

class interface_single_backup // !--- MODIFY --- //
{
	public function getMenuDefine()
	{
		$this->dbAll = new db_all(); //用于获取select标签的datasource

		$menuinfo = array(
			'showmenuword' => 1, //显示menu菜单的下排文字 '1' 可见, '0' 不可见
			'No_colNum' => 0, //序号列，值表示第几列（与$gridinfo中的序号字段对应），0表示不显示
			'batchoperation' => 1, //批量操作，给grid首列添加checkbox '1' 使用, '0' 不使用
			'menuvisible' => array( //菜单定义
				"menuaccordion" => "0",								//菜单手风琴样式 '1' 使用, '0' 不使用
				'basemenu' => '0',									//基本菜单 '1' 可见, '0' 不可见
				'basename' => '基&nbsp;本&nbsp;操&nbsp;作',			//基本菜单名称
				'confirmmenu' => '0',								//提交菜单 '1' 可见, '0' 不可见
				'confirmname' => '提&nbsp;交',						//提交菜单名称
				'searchmenu' => '1',								//搜索菜单 '1' 可见, '0' 不可见
				'searchname' => '数&nbsp;据&nbsp;查&nbsp;询',		//查询菜单名称
				'othermenu' => '1',									//其它菜单 '1' 可见, '0' 不可见
				'othername' => '其&nbsp;它&nbsp;操&nbsp;作',		//其它菜单名称
				),
			'basemenu' => array( //基本操作按钮定义
/*				'btnAdd' => array( //添加记录
					'itemname' => 'btnAdd',						//菜单名称，应该和上面一层的一样
					'imgname' => 'item-add',					//图片名称，不需要路径、'-disable'和后缀，图片要png格式
					'dispname' => '添加',						//显示名称
					'onclick' => "data_showAdd(this);",			//点击事件
					'actionname' => 'add',						//确认添加的action名称
					'actionname_show' => 'showadd'				//显示添加的action名称
				),*/
/*				'btnModify' => array( //修改记录
					'itemname' => 'btnModify',
					'imgname' => 'item-modify',
					'dispname' => '修改',
					'onclick' => "data_showModify(this);",
					'actionname' => 'modify',
					'actionname_show' => 'showmodify',
				),
*/				'btnDetail' => array( //显示明细
					'itemname' => 'btnDetail',
					'imgname' => 'item-detail',
					'dispname' => '明细',
					'onclick' => "data_showDetail(this);",
					'actionname' => 'showdetail',				//值必须与'actionname_show'的值一样
					'actionname_show' => 'showdetail',
				),
/*				'btnDelete' => array( //删除记录
					'itemname' => 'btnDelete',
					'imgname' => 'item-delete',
					'dispname' => '删除',
					'alert' => '您将删除选中的行，删除操作无法恢复，请确认！',
					'onclick' => 'data_delete(this);',
					'actionname' => 'delete',
					'actionname_show' => 'delete',				//值必须与'actionname'的值一样
				),
*/			),
			'confirmmenu' => array( //提交操作按钮定义
				"btnSubmit" => array( //提交添加、或修改
					"itemname" => "btnSubmit",
					"imgname" => "ok",
					"dispname" => "确认",
					"onclick" => "data_confirmEdit(this);", 	//点击事件
					"actionname" => "null",
				),
				"btnCancel" => array( //取消添加、或修改
					"itemname" => "btnCancel",
					"imgname" => "cancel",
					"dispname" => "取消",
					"onclick" => "data_cancelEdit(this);", 		//点击事件
					"actionname" => "null",
				),
			),
			'searchmenu' => array( //搜索操作按钮定义
				"btnSearch" => array( //搜索图标
					"itemname" => "btnSearch",
					"imgname" => "search",
					"dispname" => "查 询",
					"onclick" => "data_search(this);", //点击事件
					"actionname" => "search",
				),
				'tdsize' => 2,
				'items' => array(
					'filename' => array(
						'name' => 'filename',
						'displayname' => '文件名：',
						'type' => 'text',
						'class' => 'wiliz-txt',
						'colspan' => '1',
					),
				),
			),
			'othermenu' => array( //其它操作按钮定义
				'btnItemBackup' => array(
					'itemname' => 'btnItemBackup',
					'imgname' => 'copy',
					'dispname' => '备份',
					'iscustomclick' => '0',
					'onclick' => 'custom_showItemBackup(this);',
					'actionname' => 'backup',
					'actionname_show' => '',
					'isalert' => '1',
					'alertval' => '是否备份当前数据!',
				),
			'btnItemRestore' => array(
					'itemname' => 'btnItemRestore',
					'imgname' => 'copy',
					'dispname' => '回复',
					'iscustomclick' => '0',
					'onclick' => 'custom_showItemRestore(this);',
					'actionname' => 'restore',
					'actionname_show' => '',
					'isalert' => '1',
					'alertval' => '是否恢复当前数据!',
				),
			),
			'menutoggle' => array( //按钮间相互enable、diable关系，自己追加othermenu中的按钮动作
				'init' => array('btnAdd', 'btnSearch','btnItemBackup'),					//页面初始化时
				'gridclick' => array('btnModify', 'btnDetail','btnItemRestore'),			//点击列表行时
				'gridcheck' => array('btnDelete'),						//点击列表前的checkbox时
				'btnAdd' => array('btnSubmit', 'btnCancel'),			//点击添加按钮时
				'btnModify' => array('btnSubmit', 'btnCancel'),			//点击修改按钮时
				'btnDetail' => array('btnModify','btnCancel'),						//点击详细按钮时
				'btnDelete' => array('btnAdd'),							//点击删除按钮时
			),
		);
		return $menuinfo;
	}

	public function getGridDefine()
	{
		$gridinfo = array(
			'table' => 'sys_backup',
			'keyid' => 'Id',
			'listfield' => array( //显示字段
				array(
					'fieldname' => 'filename',
					'dispname' => '文件名',
				),
				array(
					'fieldname' => 'desc',
					'dispname' => '备份说明',
				),
				array(
					'fieldname' => 'backupdate',			//需要和sql语句中的字段名完全一致
					'dispname' => '备份时间',			//中文字段信息
				),
				array(
					'fieldname' => 'createuser',
					'dispname' => '创建者ID',
				),
			),
		);
		return $gridinfo;
	}
}
