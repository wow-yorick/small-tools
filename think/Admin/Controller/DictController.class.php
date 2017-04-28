<?php

namespace Admin\Controller;

use Think\Page;

class DictController extends BaseController
{
    private $SysDictdata;
    protected $selectTable;

    public function _initialize()
    {
        parent::_initialize();

        $this->selectTable = $this->SysDictdata = D('SysDictdata');
    }

	public function getList()
	{
        $this->_beforAct();
        $type = I('get.type');
        $name = I('get.name');
        $map = array();
        $map['type'] = array("neq","字典类型");
		if (!empty($type)) $map['type'] = array('like', "%{$type}%");
		if (!empty($name)) $map['name'] = array('like', "%{$name}%");
        $num = auto_genera_num('sys_dictdata');

		$count = $this->SysDictdata->where($map)->count();
		$Page = new Page($count);

		$list = $this->SysDictdata->where($map)->limit($Page->firstRow, $Page->listRows)->order(array('id' => 'desc'))->select();
		$this->assign('list', $list);
		$this->assign('page', $Page->show());

		$this->assign('type', $type);
		$this->assign('name', $name);
		$this->display('getList');
	}

    public function _beforAct() {
        parent::_beforAct();
        $typeGroup = $this->SysDictdata->where("type='字典类型'")->field('name')->select();
		$this->assign('typeGroup', $typeGroup);
    }

}
