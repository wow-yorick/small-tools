<?php
namespace Admin\Controller;

use Think\Verify;

class PublicController extends BaseController
{
	private $Admin;
	private $Auth_group;
	private $Log;
	private $Depot;

	public function _initialize()
	{
		parent::_initialize();
		if (ACTION_NAME != 'login' && ACTION_NAME != 'verify') $this->checkLogin();
		$this->Admin = M('admin');
		$this->Log = M('admin_login_log');
		$this->Auth_group = M('auth_group');
		$this->Depot = M('depot');
	}

	public function index()
	{
		$depotList = $this->Depot->getField('id,depot_name');

		$this->assign('depots', session('DEPOTS'));
		$this->assign('depot', session('depot'));
		$this->assign('depotList', $depotList);
		$this->display();
	}

	public function header()
	{
		$this->display();
	}

	public function menu()
	{

		$this->display();
	}

	public function welcome()
	{
		$user_id = session(C('USER_AUTH_KEY'));

		$count = $this->Log->where(array('worker_id' => $user_id))->count();
		$log = $this->Log->where(array('worker_id' => $user_id))->order(array('id' => 'DESC'))->find();

		$depotList = $this->Depot->getField('id,depot_name');

		$this->assign('depot', session('depot'));
		$this->assign('depotList', $depotList);
		$this->assign('log', $log);
		$this->assign('count', $count);
		$this->display();
	}

	public function login()
	{
		if (IS_POST) {
			$email = I('post.email');
			$password = I('post.password');
//			$code = I('post.code');
			if (empty($email)) $this->error("请输入邮箱");
			if (empty($password)) $this->error("请输入密码");
//			if (empty($code)) $this->error("请输入验证码");
//			$Verify = new Verify(array('reset' => true));
//			if (!$Verify->check($code, 'login')) $this->error("请输入正确的验证码");

			//检查邮箱是否存在
			$admin = $this->Admin->where(array("email" => $email))->find();
			if (empty($admin))
				$this->error("用户名或者密码错误");
			//判断密码是否正确
			if ($admin['password'] != get_password($password, $admin['salt']))
				$this->error("用户名或者密码错误");
			if (!$admin['status'])
				$this->error('该用户被锁定，暂时不可登录');
			$data = array(
				'admin_id' => $admin['id'],
				'login_ip' => get_ip(),
				'login_time' => date("Y-m-d H:i:s")
			);

			cookie('email', $email, 3600 * 24 * 30);
			cookie('password', $password, 3600 * 24 * 30);
			$this->Log->add($data);
			session(C('USER_AUTH_KEY'), $admin['id']);
			$depots = explode(',', $admin['depots']);
			session('DEPOTS', $depots);
			session('depot', $depots[0]);
			session("ADMIN_NAME", $admin['user_name']);

			//获取仓库代号
			$depotInfo = $this->Depot->where('id=' . intval($depots[0]))->find();
			session('DEPOT_CODE', $depotInfo['depot_code']);
			session('DEPOT_INFO', $depotInfo);
			$this->success('登录成功', U('public/index'));
			die;
		}
		C('LAYOUT_ON', false);
		$this->assign('email', cookie('email'));
		$this->assign('password', cookie('password'));
		$this->display();
	}

	public function logout()
	{
		session_destroy();
		$this->redirect('login');
	}

	public function changePassword()
	{
		if (IS_POST) {
			$user_id = $_SESSION[C('USER_AUTH_KEY')];
			$password = I('post.password');
			$newpassword = I('post.newpassword');
			$newpassword2 = I('post.newpassword2');
			if (empty($password)) $this->error('原始密码不能为空');
			if (empty($newpassword)) $this->error('新不能为空');
			if (empty($newpassword2)) $this->error('确认密码不能为空');
			$user = $this->Admin->where(array('id' => $user_id))->find();
			if ($user['password'] != get_password($password, $user['salt'])) $this->error('原始密码不正确');
			$salt = randString(6);
			$data = array(
				'salt' => $salt,
				'password' => get_password($newpassword, $salt)
			);
			if (!$this->Admin->where(array('id' => $user_id))->data($data)->save())
				$this->error('修改密码失败');
			session_destroy();
			$this->success('修改密码成功');
			die;
		}
		$user_id = $_SESSION[C('USER_AUTH_KEY')];
		$user = $this->Admin->where(array('id' => $user_id))->find();
		$this->assign('user', $user);
		$this->display('changePassword');
	}

	public function verify()
	{
		$id = I('get.id');
		$Verify = new Verify(array(
			'expire' => 60, // 验证码过期时间（s）
			'fontSize' => 14, // 验证码字体大小(px)
			'useCurve' => false, // 是否画混淆曲线
			'useNoise' => false, // 是否添加杂点
			'imageH' => 41, // 验证码图片高度
			'imageW' => 100, // 验证码图片宽度
			'length' => 4, // 验证码位数
			'bg' => array(200, 200, 200), // 背景颜色
		));
		$Verify->entry($id);
	}

	public function changeDepot()
	{
		$id = I('post.id');
		if (empty($id)) $this->error('仓库ID不能为空');
		$admin_id = session(C('USER_AUTH_KEY'));
		$depots = session('DEPOTS');
		if (!in_array($id, $depots)) $this->error('您无法切换到该仓库');
		session('depot', $id);
		$this->success('切换成功');
	}

	public function getCustomer()
	{
		$customer = S('customer');
		if (empty($customer)) {
			$Customer = M('customer');
			$customer = $Customer->getField('name', true);
			S('customer', $customer, 1800);
		}
		$data = array();
		$keyword = I("post.keyword");
		foreach ($customer as $v) {
			if (false === strpos($v, $keyword)) continue;
			array_push($data, array('title' => $v));
		}
		$this->ajaxReturn(array('data' => $data));
	}


}
