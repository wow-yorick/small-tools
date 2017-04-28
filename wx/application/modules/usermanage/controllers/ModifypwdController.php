<?php

class Usermanage_ModifypwdController extends Zend_Controller_Action
{

	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
	}

	public function indexAction()
	{
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/top_modifypwd.phtml');
	}

	/**
	 * 修改企业密码
	 */
	public function modifycompanypwdAction()
	{
		$userId = $_SESSION[$this->view->sessionPrefix . 'userId'];
		$oldCompanyPwd = md5($_POST['oldCompanyPwd']);
		$newCompanyPwd = md5($_POST['newCompanyPwd']);
		
		$result = $this->db->checkOldCompanyPwd($userId, $oldCompanyPwd); //检查企业旧密码是否正确
		if ($result >0) {
			$flag = $this->db->modifyCompanyPwd($userId, $newCompanyPwd); //修改密码
			if ($flag) {
				echo "<script>alert('密码修改成功！');</script>";
				exit();
			} else {
				echo "<script>alert('密码修改失败，请重新尝试！');</script>";
			}
		} else {
			echo "<script>alert('旧密码错误！');</script>";
		}

		//$this->view->menuId = 'licompanymanagemodifypwd';
		echo $this->view->render('/all/views/refresh_ajax.phtml');
	}
}