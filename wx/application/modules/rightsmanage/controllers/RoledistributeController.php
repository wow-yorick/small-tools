<?php

class Rightsmanage_RoledistributeController extends Zend_Controller_Action // !--- MODIFY --- //
{

	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_rights.php'; // !--- COPY --- //
	}

	public function indexAction()
	{
		$this->view->allAccountType = $this->dbAll->all_getAllAccountType();
		$this->view->allRole = $this->dbAll->all_getAllRole();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/top_data.phtml');
	}

	/**
	 * 搜索用户
	 */
	public function searchuserAction()
	{
		$roletypeId = $_POST['roletypeId'];
		$atId = $_POST['atId'];
		$roleId = $_POST['roleId'];

		$this->view->userList = $this->db->searchUser($atId, $roletypeId , $roleId);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/data_userlist_ajax.phtml');
	}

	/**
	 * 显示用户详细信息
	 */
	public function showuserdetailAction()
	{
		$atId = $_POST['atId'];
		$userId = $_POST['userId'];
		$this->view->userRoleInfo = $this->db->getUserRole($atId, $userId);
		//all_model_ousu_helper:: ousu_dump($this->view->userRoleInfo); exit();
		$this->view->allRole = $this->dbAll->all_getAllRole();
		$this->view->allDs= $this->dbAll->all_getAllDatasource();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/data_userdetail_ajax.phtml');

	}

	/**
	 * 获取节点值信息
	 */
	public function getdsvalAction()
	{
		$dsId = $_POST['dsId'];
		$this->view->allDsVal = $this->db->getAllDsVal($dsId);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/userdetail_dsval_ajax.phtml');
	}

	/**
	 * 添加用户角色对应关系
	 */
	public function adduserroleAction()
	{
		//print_r($_POST);exit();
		if ($_POST['userId'] == "undefined"){
			echo "<script>alert('请选择用户!');</script>";return;
		}
		if ($_POST['dsId'] == "undefined"){
			echo "<script>alert('请选择节点!');</script>";return;
		}
		$atId = $_POST['atId'];
		$userId = $_POST['userId'];
		$roleId = $_POST['roleId'];
		$dsId = $_POST['dsId'];
		if ($_POST['dsId'] == 4) {
			$dsVal = null;
		} else {
			$dsVal = $_POST['dsVal'];
		}
		$result = $this->db->addUserRole($atId, $userId, $roleId, $dsId, $dsVal);

		$this->view->userRoleInfo = $this->db->getUserRole($atId, $userId);
		$this->view->allRole = $this->dbAll->all_getAllRole();
		$this->view->allDs= $this->dbAll->all_getAllDatasource();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/data_userdetail_ajax.phtml');

		if ($result != -1) {
			echo "<script>alert('" . $result . "');</script>";
		}
	}

	/**
	 * 删除用户角色对应关系
	 */
	public function deleteuserroleAction()
	{
		$atId = $_POST['atId'];
		$userId = $_POST['userId'];
		$deleteId = $_POST['deleteId'];

		$this->db->deleteUserRole($deleteId);

		$this->view->userRoleInfo = $this->db->getUserRole($atId, $userId);
		$this->view->allRole = $this->dbAll->all_getAllRole();
		$this->view->allDs= $this->dbAll->all_getAllDatasource();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/data_userdetail_ajax.phtml');
	}

}