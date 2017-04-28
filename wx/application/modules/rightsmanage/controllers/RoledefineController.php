<?php

class Rightsmanage_RoledefineController extends Zend_Controller_Action // !--- MODIFY --- //
{

	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_rights.php'; // !--- COPY --- //
	}

	public function indexAction()
	{
		$this->view->allItemModule = $this->db->getAllItemModule();
		$this->view->allRole = $this->db->getAllRole();
		$this->view->allRights = $this->db->getAllRights();
		//$this->ousu_helper->dump($this->view->allGroup); exit();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/top_data.phtml'); //文件夹名要和controller名一致
	}

	/**
	 * 添加角色
	 */
	public function addroleAction()
	{
		$roleName = $_POST['roleName'];
		$this->db->addRole($roleName);
		$this->view->afterAddRole = $roleName;
		$this->view->allRole = $this->db->getAllRole();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/role_ajax.phtml');
	}

	/**
	 * 删除角色
	 */
	public function deleteroleAction()
	{
		$roleId = $_POST['roleId'];
		$this->db->deleteRole($roleId);
		$this->view->allRole = $this->db->getAllRole();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/role_ajax.phtml');
	}

	/**
	 * 获取角色的module
	 */
	public function getrolemoduleAction()
	{
		$roleId = $_POST['roleId'];
		$this->view->allItemModule = $this->db->getAllItemModule();
		$this->view->roleModule = $this->db->getRoleModule($roleId);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/module_ajax.phtml');
	}

	/**
	 * 添加角色的module
	 */
	public function addrolemoduleAction()
	{
		$roleId = $_POST['roleId'];
		$itemId = $_POST['itemId'];
		$this->db->addRoleModule($roleId, $itemId);
		$this->view->afterAddRoleModule = $itemId;

		$this->view->allItemModule = $this->db->getAllItemModule();
		$this->view->roleModule = $this->db->getRoleModule($roleId);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/module_ajax.phtml');
	}

	/**
	 * 删除角色的module
	 */
	public function deleterolemoduleAction()
	{
		$roleId = $_POST['roleId'];
		$moduleId = $_POST['moduleId'];
		$this->db->deleteRoleModule($roleId, $moduleId);

		$this->view->allItemModule = $this->db->getAllItemModule();
		$this->view->roleModule = $this->db->getRoleModule($roleId);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/module_ajax.phtml');
	}

	/**
	 * 获取module的权限
	 */
	public function getmodulerightsAction()
	{
		$roleId = $_POST['roleId'];
		$moduleId = $_POST['moduleId'];
		$this->view->allItemRights = $this->db->getItemRights($roleId, $moduleId);
		$this->view->allModuleAction = $this->db->getModuleAction($moduleId);
		$this->view->allRights = $this->db->getAllRights();
		//$this->ousu_helper->dump($this->view->allItemRights); exit();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/rights_ajax.phtml');
	}

	/**
	 * 修改module和其action的权限
	 */
	public function modifymodulerightsAction()
	{
		$roleId = $_POST['roleId'];
		$itemId = $_POST['itemId'];
		$moduleId = $_POST['moduleId'];
		$strRights = $_POST['strRights'];
		$this->db->modifyModuleRights($roleId, $itemId, $strRights);

		$this->view->allItemRights = $this->db->getItemRights($roleId, $moduleId);
		$this->view->allModuleAction = $this->db->getModuleAction($moduleId);
		$this->view->allRights = $this->db->getAllRights();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/rights_ajax.phtml');

		//echo "<script>alert('操作成功！');</script>";
	}

	/**
	 * 修改action的权限
	 */
	public function modifyactionrightsAction()
	{
		//all_model_ousu_helper:: ousu_dump($_POST); exit();
		$roleId = $_POST['roleId'];
		$moduleId = $_POST['moduleId'];
		$arrActionRights = $_POST['arrActionRights'];
		$arrIsMenu = $_POST['arrIsMenu'];
		$this->db->modifyActionRights($arrActionRights, $arrIsMenu);

		$this->view->allItemRights = $this->db->getItemRights($roleId, $moduleId);
		$this->view->allModuleAction = $this->db->getModuleAction($moduleId);
		$this->view->allRights = $this->db->getAllRights();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/rights_ajax.phtml');

		echo "<script>alert('操作成功！');</script>";
	}
}