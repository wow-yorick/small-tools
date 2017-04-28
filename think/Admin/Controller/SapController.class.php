<?php
namespace Admin\Controller;

use Think\Page;

class SapController extends BaseController
{

	private $SysSap;

	public function _initialize()
	{
		parent::_initialize();
		$this->SysSap = M('sys_sap');
        $fields = $this->SysSap->getDbFields();
	}

	public function sapList()
	{
		$list = $this->SysSap->select();
		$count = $this->SysSap->count();
		$Page = new Page($count);
		$this->assign('list', $list);
		$this->assign('page', $Page->show());
		$this->display('sapList');
	}


	public function sapAdd()
	{
		if (IS_POST) {
			$name = I('post.sys_sap_name');
			$url = I('post.sys_sap_url');
			$account = I('post.sys_sap_account');
			$password = I('post.sys_sap_password');
			$data = array(
				'sys_sap_name' => $name,
				'sys_sap_url' => $url,
				'sys_sap_account' => $account,
				'sys_sap_password' => $password,
			);
			$this->SysSap->data($data)->add();
			$this->success('角色添加成功');
			die;
		}
		$this->display('sapAdd');
	}

	public function sapEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$name = I('post.sys_sap_name');
			$url = I('post.sys_sap_url');
			$account = I('post.sys_sap_account');
			$password = I('post.sys_sap_password');
			$data = array(
				'sys_sap_name' => $name,
				'sys_sap_url' => $url,
				'sys_sap_account' => $account,
				'sys_sap_password' => $password,
			);
			$this->SysSap->where(array('id' => $id))->data($data)->save();
			$this->success('角色编辑成功');
			die;
		}

		$id = I('get.id');
		$sap = $this->SysSap->where(array('id' => $id))->find();
		$this->assign('sap', $sap);
		$this->display('sapEdit');
	}

	public function sapDel()
	{
		$id = I('post.id');
		if (empty($id)) $this->error('ID不能为空');;
		if ($this->SysSap->where(array('id' => $id))->delete())
			$this->success('删除成功');
		$this->error('删除失败');
	}
}
