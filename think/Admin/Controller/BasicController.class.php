<?php

namespace Admin\Controller;


use Think\Page;

class BasicController extends BaseController
{

	private $Depot;

	public function _initialize()
	{
		parent::_initialize();
		$this->Depot = M('depot');
	}

	public function depotList()
	{
		$depot_name = I('get.depot_name');
		$depot_code = I('get.depot_code');
		$map = array();
		if (!empty($depot_name)) $map['depot_name'] = array('like', "%{$depot_name}%");
		if (!empty($depot_code)) $map['depot_code'] = array('like', "%{$depot_code}%");
		$count = $this->Depot->where($map)->count();
		$Page = new Page($count);
		$list = $this->Depot->where($map)->limit($Page->firstRow, $Page->listRows)->select();
		$this->assign('page', $Page->show());
		$this->assign('list', $list);
		$this->assign('depot_name', $depot_name);
		$this->display('depotList');
	}

	public function depotAdd()
	{
		if (IS_POST) {
			$depot_name = trim(I('post.depot_name'));
			$depot_address = I('post.depot_address');
			$depot_code = strtoupper(trim(I('post.depot_code')));
			$depot_ip = trim(I('post.depot_ip'));
			if (empty($depot_name)) $this->error('请填写仓库名称');
			if (empty($depot_code)) $this->error('请填写仓库代码名称');
			if (empty($depot_address)) $this->error('请填写仓库地址');
			//检验仓库是否存在
			$depot = $this->Depot->where(array('depot_name' => $depot_name, 'depot_code' => $depot_code, '_logic' => 'or'))->find();
			if (!empty($depot)) $this->error('该仓库名称或仓库代码已存在');
			$data = array(
				'depot_name' => $depot_name,
				'depot_code' => $depot_code,
				'depot_address'=>$depot_address,
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY')),
				'ip' => $depot_ip
			);
			$this->Depot->data($data)->add();
			$this->success('添加成功');
			die;
		}
		$this->display('depotAdd');
	}

	public function depotEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$depot_name = trim(I('post.depot_name'));
			$depot_address = trim(I('post.depot_address'));
			$depot_ip = trim(I('post.depot_ip'));
			if (empty($depot_name)) $this->error('请填写公司名称');
			//检验仓库是否存在
			$depot = $this->Depot->where(
				array(
					'depot_name' => $depot_name,
					'id' => array('neq', $id)
				)
			)->find();
			if (!empty($depot)) $this->error('该仓库名称或者仓库代码已存在');
			if (empty($depot_address)) $this->error('请填写公司地址');
			$data = array(
				'depot_name' => $depot_name,
				'depot_address' => $depot_address,
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY')),
				'ip' => $depot_ip
			);
			$this->Depot->data($data)->where(array('id' => $id))->save();
			$this->success('更新成功');
			die;
		}
		$id = I('get.id');
		$depot = $this->Depot->where(array('id' => $id))->find();
		$this->assign('depot', $depot);
		$this->display('depotEdit');
	}

	public function depotToggleStatus()
	{
		$id = I('post.id');
		$status = I('post.status');
		if (empty($id)) $this->error('ID 不能为空');
		$this->Depot->where(array('id' => $id))->data(array('status', $status))->save();
		$this->success('成功');
	}
}