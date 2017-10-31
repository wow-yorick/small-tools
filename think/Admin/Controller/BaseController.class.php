<?php

namespace Admin\Controller;

use Think\Auth;
use Think\Cache;
use Think\Controller;
use Think\Page;

class BaseController extends Controller
{
	protected $_cache;

	protected $selectTable;

	public function _initialize()
	{

		if (ACTION_NAME != 'login') {
			$fp = fopen(COMMON_PATH . 'term.txt', 'r');
			if (!$fp)
				$this->error('您无权使用该系统');
			$term = fread($fp, 8196);
			$decryptStr = decrypt($term);
			parse_str($decryptStr, $data);
			if ($data['user_name'] != 'admin@qeeka.com' || $data['password'] != '123456')
				$this->error('您无权使用该系统');
			if ($data['time'] - time() <= 3600 * 24 * 30*24 && $data['time'] - time() > 0) {
				$this->assign('remind', true);
				$this->assign('term_day', $data['time']);
			} elseif ($data['time'] - time() <= 0) {
				//$this->assign('remind', true);
				//$this->assign('term_day', $data['time']);
				//$this->error('您的系统已过期');
			}
		}
		if (CONTROLLER_NAME != 'Public' && !$this->checkAuth()) $this->error('没有权限，请联系管理员！！');
		$this->_cache = Cache::getInstance();
	}

	protected function checkLogin()
	{
		if (empty($_SESSION[C('USER_AUTH_KEY')])) {
			if (IS_POST) $this->error('请先登录');
			else $this->redirect('Public/login');
		}

	}

	protected function checkAuth()
	{
		$this->checkLogin();
		return true;
		if ($_SESSION[C('USER_AUTH_KEY')] == C('ADMIN_AUTH_KEY')) {
			return true;
		}
		$module_name = CONTROLLER_NAME . '/' . ACTION_NAME;
		$Auth = new Auth();
		$authRule = $_SESSION[C('USER_AUTH_KEY')];
		return $Auth->check($module_name, $authRule);
	}

	protected function _beforAct()
	{
		if (!$this->selectTable) {
			die('请配置selectTable');
		}
	}

	public function getlist()
	{
		$this->_beforAct();
		$requestGet = I('get.');

		$map = array();
		if (!empty($requestGet)) {
			foreach ($requestGet as $key => $val) {
				if (empty($val)) {
					continue;
				}
				$map[$key] = array('like', "%{$val}%");
				$this->assign($key, $val);
			}
		}

		$count = $this->selectTable->where($map)->count();
		$Page = new Page($count);

		$list = $this->selectTable->where($map)->limit($Page->firstRow, $Page->listRows)->order(array('id' => 'desc'))->select();
		$this->assign('list', $list);
		$this->assign('page', $Page->show());

		$this->display();
	}

	/**
	 * add
	 * 新增
	 * @access protected
	 * @return void
	 */
	public function add()
	{
		$this->_beforAct();
		if (IS_POST) {
			if (!$this->selectTable->create()) {
				$this->error($this->selectTable->getError());
				return false;
			}
			$this->selectTable->createdatetime = date('Y-m-d G:i:s', time());
			$this->selectTable->createuser = session(C('USER_AUTH_KEY'));
			$this->selectTable->add();
			$this->success('添加成功!');
			die;
		}
		$this->display('detail');
	}

	/**
	 * edit
	 * 修改
	 * @access protected
	 * @return void
	 */
	public function edit()
	{
		$this->_beforAct();
		if (!IS_POST) {
			$id = I('get.id');
			if (empty($id)) $this->redirect('add');
			$detail = $this->selectTable->where('id = ' . $id)->find();
			$this->assign('detail', $detail);
			$this->display('detail');
			return true;
		}
		if (!$this->selectTable->create()) {
			$this->error($this->selectTable->getError());
			return false;
		}
		$this->selectTable->modifydatetime = date('Y-m-d G:i:s', time());
		$this->selectTable->modifyuser = session(C('USER_AUTH_KEY'));
		$ret = $this->selectTable->save();
		if ($ret === false) {
			$this->error('更新失败!');
		} else {
			$this->success('更新成功!');
		}
	}

	/**
	 * del
	 * 删除
	 * @access protected
	 * @return void
	 */
	public function del()
	{
		$this->_beforAct();
		$id = I('get.id');
		if (empty($id)) $this->error('ID不能为空');;
		if ($this->selectTable->where(array('id' => $id))->delete())
			$this->success('删除成功');
		$this->error('删除失败');
	}

}
