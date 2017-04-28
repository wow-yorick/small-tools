<?php

namespace Admin\Controller;

use Think\Page;

class AdminController extends BaseController
{

	private $Admin;
	private $Group;
	private $Group_access;
	private $Rule;
	private $Depot;

	public function _initialize()
	{
		parent::_initialize();
		$this->Admin = M('admin');
		$this->Group = M('auth_group');
		$this->Group_access = M('auth_group_access');
		$this->Rule = M('auth_rule');
		$this->Depot = M('depot');
	}

	public function roleList()
	{

		$list = $this->Group->select();
		$adminList = $this->_cache->get('adminList');
		if (empty($adminList)) {
			$adminList = $this->Admin->where(array('status' => 1))->getField('id,user_name');
			$this->_cache->set('adminList', $adminList, 1800);
		}
		$adminRules = $this->_cache->get('adminRules');
		if (empty($adminRules)) {
			$adminRules = $this->Rule->getField('id,title');
			$this->_cache->set('adminRules', $adminRules, 1800);
		}
		foreach ($list as $k => $v) {
			$list[$k]['ids'] = $this->Group_access->where(array('group_id' => $v['id']))->getField('admin_id', true);
			$list[$k]['rules'] = explode(',', $v['rules']);
		}
		$count = $this->Group->count();
		$Page = new Page($count);
		$this->assign('list', $list);
		$this->assign('adminList', $adminList);
		$this->assign('adminRules', $adminRules);
		$this->assign('page', $Page->show());
		$this->display('roleList');
	}

	public function roleAdd()
	{

		if (IS_POST) {
			$title = I('post.title');
			$rule_ids = I('post.rule_ids');
			$rule_ids = empty($rule_ids) ? array() : $rule_ids;
			if (empty($title)) $this->error('角色名称不能为空');
			$group = $this->Group->where(array('title' => $title))->find();
			if (!empty($group)) $this->error('该角色名称已存在');
			$data = array(
				'title' => $title,
				'rules' => implode(',', $rule_ids)
			);
			$this->Group->data($data)->add();
			$this->success('角色添加成功');
			die;
		}
		$rules = $this->Rule->select();
		$ruleList = array();
		foreach ($rules as $rule) {
			$ruleList[$rule['group_id']][$rule['id']] = $rule['title'];
		}
		$this->assign('groups', C('ruleGroup'));
		$this->assign('ruleList', $ruleList);
		$this->display('roleAdd');
	}

	public function roleEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$title = I('post.title');
			$rule_ids = I('post.rule_ids');
			$rule_ids = empty($rule_ids) ? array() : $rule_ids;
			if (empty($title)) $this->error('角色名称不能为空');
			$group = $this->Group->where(array('title' => $title, 'id' => array('neq', $id)))->find();
			if (!empty($group)) $this->error('该角色名称已存在');
			$data = array(
				'title' => $title,
				'rules' => implode(',', $rule_ids)
			);
			$this->Group->where(array('id' => $id))->data($data)->save();
			$this->success('角色编辑成功');
			die;
		}

		$id = I('get.id');
		$role = $this->Group->where(array('id' => $id))->find();
		$rules = $this->Rule->select();
		$ruleList = array();
		foreach ($rules as $rule) {
			$ruleList[$rule['group_id']][$rule['id']] = $rule['title'];
		}
		$this->assign('role', $role);
		$this->assign('groups', C('ruleGroup'));
		$this->assign('ruleList', $ruleList);
		$this->display('roleEdit');
	}

	public function roleDel()
	{
		$id = I('post.id');
		if (empty($id)) $this->error('角色ID不能为空');;
		if ($this->Group->where(array('id' => $id))->delete())
			$this->success('删除成功');
		$this->error('删除失败');
	}

	public function ruleList()
	{
		$title = I('get.title');
		$group_id = I('get.group_id');
		$controller_name = I('get.controller_name');
		$action_name = I('get.action_name');
		$map = array();
		if (!empty($group_id)) $map['group_id'] = $group_id;
		if (!empty($title)) $map['title'] = array('like', "%{$title}%");
		if (!empty($controller_name)) $map['controller_name'] = array('like', "%{$controller_name}%");
		if (!empty($action_name)) $map['action_name'] = array('like', "%{$action_name}%");
		$count = $this->Rule->where($map)->count();
		$Page = new Page($count);
		$list = $this->Rule->where($map)->limit($Page->firstRow, $Page->listRows)->order(array('id' => 'desc'))->select();
		$this->assign('list', $list);
		$this->assign('groups', C('ruleGroup'));
		$this->assign('group_id', $group_id);
		$this->assign('title', $title);
		$this->assign('controller_name', $controller_name);
		$this->assign('action_name', $action_name);
		$this->assign('page', $Page->show());
		$this->display('ruleList');
	}

	public function ruleAdd()
	{
		if (IS_POST) {
			$title = I('post.title');
			$controller_name = strtolower(trim(I('post.controller_name')));
			$action_name = strtolower(trim(I('post.action_name')));
			$group_id = I('post.group_id');
			$is_menu = I('post.is_menu');
			if (empty($title)) $this->error('权限名称不能为空');
			if (empty($controller_name)) $this->error('控制器不能为空');
			if (empty($action_name)) $this->error('方法不能为空');
			if (empty($group_id)) $this->error('权限组不能为空');
			//检验权限是否存在
			$rule = $this->Rule->where(array(array('title' => $title), array('controller_name' => $controller_name, 'action_name' => $action_name), '_logic' => 'or'))->find();
			if (!empty($rule)) $this->error('权限已存在');

			$data = array(
				'title' => $title,
				'controller_name' => $controller_name,
				'action_name' => $action_name,
				'group_id' => $group_id,
				'is_menu' => intval($is_menu),
			);
			$this->Rule->data($data)->add();
			$this->success('权限添加成功');
			die;
		}

		$this->assign('groups', C('ruleGroup'));
		$this->display('ruleAdd');
	}

	public function ruleEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$title = I('post.title');
			$controller_name = strtolower(I('post.controller_name'));
			$action_name = strtolower(I('post.action_name'));
			$group_id = I('post.group_id');
			$is_menu = I('post.is_menu');
			if (empty($id)) $this->error('ID 不能为空');
			if (empty($title)) $this->error('权限名称不能为空');
			if (empty($controller_name)) $this->error('控制器不能为空');
			if (empty($action_name)) $this->error('方法不能为空');
			if (empty($group_id)) $this->error('权限组不能为空');

			$rule = $this->Rule->where(array(array('title' => $title, 'id' => array('neq', $id)), array('controller_name' => $controller_name, 'action_name' => $action_name, 'id' => array('neq', $id)), '_logic' => 'or'))->find();
			if (!empty($rule)) $this->error('权限已存在');
			$data = array(
				'title' => $title,
				'controller_name' => $controller_name,
				'action_name' => $action_name,
				'group_id' => $group_id,
				'is_menu' => intval($is_menu),
			);
			$this->Rule->data($data)->where(array('id' => $id))->save();
			$this->success('权限修改成功');
			die;
		}

		$id = I('get.id');
		if (empty($id)) $this->redirect('ruleAdd');
		$rule = $this->Rule->where(array('id' => $id))->find();
		$this->assign('rule', $rule);
		$this->assign('groups', C('ruleGroup'));
		$this->display('ruleEdit');
	}

	public function adminList()
	{

		$email = I('get.email');
		$user_name = I('get.user_name');
		$map = array();
		if (!empty($email)) $map['email'] = array('like', "%{$email}%");
		if (!empty($user_name)) $map['user_name'] = array('like', "%{$user_name}%");
		$count = $this->Admin->where($map)->count();
		$Page = new Page($count);
		$list = $this->Admin->where($map)->limit($Page->firstRow, $Page->listRows)->order(array('id' => 'DESC'))->select();
		foreach ($list as $key => $admin) {
			$list[$key]['depots'] = explode(',', $admin['depots']);
		}

		$depotList = $this->Depot->getField('id,depot_name');

		$this->assign('email', $email);
		$this->assign('user_name', $user_name);
		$this->assign('list', $list);
		$this->assign('depotList', $depotList);
		$this->assign('page', $Page->show());
		$this->display('adminList');
	}

	public function adminAdd()
	{
		if (IS_POST) {
			$user_name = I('post.user_name');
			$email = I('post.email');
			$password = I('post.password');
			$password2 = I('post.password2');
			$groups = I('post.groups');
			$depots = I('post.depots');
			$remark = I('post.remark');
			if (empty($user_name)) $this->error('用户名称不能为空');
			if (empty($email)) $this->error('邮箱不能为空');
			if (is_email($email)) $this->error('请输入正确的邮箱地址');
			if (empty($password)) $this->error('初始密码不能为空');
			if (empty($password2)) $this->error('确认密码不能为空');
			if (empty($depots)) $this->error('请选择管理员管理的仓库');
			//检验邮箱、用户名是否存在
			$user = $this->Admin->where(array('email' => $email, 'user_name' => $user_name, '_logic' => 'or'))->find();
			if (!empty($user)) $this->error("邮箱或用户名已存在，不可重复添加");
			$salt = randString(6);
			$data = array(
				'user_name' => $user_name,
				'email' => $email,
				'password' => get_password($password, $salt),
				'salt' => $salt,
				'remark' => $remark,
				'depots' => implode(',', $depots),
				'create_time' => date("Y-m-d H:i:s"),
				'status' => 1
			);
			$id = $this->Admin->data($data)->add();
			if (empty($id)) $this->error('添加用户失败');
			if (!empty($groups)) {
				$accessData = array();
				foreach ($groups as $group) {
					$accessData[] = array(
						'admin_id' => $id,
						'group_id' => $group
					);
				}
				$this->Group_access->data($accessData)->addAll();
			}
			$this->success('添加成功', U('adminList'));
			die;
		}
		$groups = $this->Group->getField('id,title');

		$depotList = $this->Depot->getField('id,depot_name');

		$this->assign('depotList', $depotList);
		$this->assign('groups', $groups);
		$this->display('adminAdd');
	}

	public function adminEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$user_name = I('post.user_name');
			$groups = I('post.groups');
			$remark = I('post.remark');
			$depots = I('post.depots');
			if (empty($id)) $this->error('用户ID不能为空');
			if (empty($user_name)) $this->error('用户名称不能为空');
			if (empty($depots)) $this->error('请选择用户管理的仓库');
			//检验用户名是否存在
			$admin = $this->Admin->where(array('user_name' => $user_name, 'id' => array('neq', $id)))->find();
			if (!empty($admin)) $this->error('用户名称已存在');
			$data = array(
				'user_name' => $user_name,
				'remark' => $remark,
				'depots' => implode(',', $depots),
			);
			$this->Admin->data($data)->where(array('id' => $id))->save();
			$this->_changeGroups($id, $groups);
			$this->success('跟新成功');
			die;
		}
		$id = I('get.id');
		if (empty($id)) $this->redirect('adminAdd');
		$admin = $this->Admin->where(array('id' => $id))->find();
		$groups = $this->Group->getField('id,title');
		$currentGroup = $this->Group_access->where(array('admin_id' => $id))->getField('group_id', true);

		$depotList = $this->Depot->getField('id,depot_name');

		$this->assign('depotList', $depotList);
		$this->assign('admin', $admin);
		$this->assign('groups', $groups);
		$this->assign('currentGroup', $currentGroup);
		$this->display('adminEdit');
	}

	public function changePassword()
	{
		if (IS_POST) {
			$id = I('post.id');
			$password = I('post.password');
			$password2 = I('post.password2');
			if ($id == 1) $this->error('该用户无法操作');
			if (empty($id)) $this->error('用户ID不能为空');
			if (empty($password)) $this->error('密码不能为空');
			if (empty($password2)) $this->error('确认密码不能为空');
			if ($password != $password2) $this->error('两次密码输入不一致');
			$salt = randString(6);
			$data = array(
				'salt' => $salt,
				'password' => get_password($password, $salt),
			);
			if ($this->Admin->where(array('id' => $id))->data($data)->save()) $this->success('更新密码成功');
			$this->error('更新密码失败');
			die;
		}
		$id = I('get.id');
		$admin = $this->Admin->where(array('id' => $id))->find();
		$this->assign('admin', $admin);
		$this->display('changePassword');
	}

	public function adminToggleStatus()
	{
		$id = I('post.id');
		$status = I('post.status');
		if (empty($id)) $this->error('ID 不能为空');
		if ($id == 1) $this->error('该用户无法操作');
		$status = intval($status) ? 1 : 0;
		if ($this->Admin->data(array('status' => $status))->where(array('id' => $id))->save())
			$this->success("成功");
		$this->error("失败");
	}

	private function _changeGroups($admin_id, $groups)
	{
		$currentGroups = $this->Group_access->where(array('admin_id' => $admin_id))->getField('group_id', true);
		$currentGroups = empty($currentGroups) ? array() : $currentGroups;
		$groups = empty($groups) ? array() : $groups;
		$addGroups = array_diff($groups, $currentGroups);
		$delGroups = array_diff($currentGroups, $groups);
		if (!empty($delGroups))
			$this->Group_access->where(array('admin_id' => $admin_id, 'group_id' => array('in', $delGroups)))->delete();
		if (!empty($addGroups)) {
			$data = array();
			foreach ($addGroups as $group_id) {
				$data[] = array(
					'admin_id' => $admin_id,
					'group_id' => $group_id
				);
			}
			$this->Group_access->addAll($data);
		}
	}

}
