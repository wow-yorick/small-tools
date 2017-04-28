<?php

class Usermanage_AdmindefineController extends Zend_Controller_Action // !--- MODIFY --- //
{

	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
	}

	public function indexAction()
	{
		$this->view->allDataList = $this->db->getDataList();
		//all_model_ousu_helper:: ousu_dump($this->view->allDataList); exit();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/top_data.phtml');
	}

	/**
	 * 搜索
	 */
	public function searchAction()
	{
		//all_model_ousu_helper:: ousu_dump($_POST); exit();
		$arrSearch = array();
		if (!empty($_POST['username'])) {
			$arrSearch['username'] = $_POST['username'];
		}
		if (!empty($_POST['fullname'])) {
			$arrSearch['fullname'] = $_POST['fullname'];
		}

		$this->view->allDataList = $this->db->searchData($arrSearch);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/list_ajax.phtml');
	}

	/**
	 * 添加
	 */
	public function addAction()
	{
		//all_model_ousu_helper:: ousu_dump($_POST); exit();

		$dataInfo = self:: getAddModifySameData();

		// !---------- BEGIN: CUSTOM ---------- //
		$dataInfo['password'] = md5('123456');
		$dataInfo['insertuserid'] = $_SESSION[$this->view->sessionPrefix . 'userId'];
		$dataInfo['inserttime'] = date('Y-m-d G:i:s');
		// !---------- END  : CUSTOM ---------- //

		$this->db->addData($dataInfo);

		$this->view->menuId = 'li' . $this->view->moduleName . $this->view->controllerName;
		echo $this->view->render('/all/views/refresh_ajax.phtml');
	}

	/**
	 * 修改
	 */
	public function modifyAction()
	{
		//all_model_ousu_helper:: ousu_dump($_POST); exit();

		$keyId = $_POST['keyId'];
		$dataInfo = self:: getAddModifySameData();
		$this->db->modifyData($keyId, $dataInfo);

		$this->view->menuId = 'li' . $this->view->moduleName . $this->view->controllerName;
		echo $this->view->render('/all/views/refresh_ajax.phtml');
	}

	/**
	 * 私有方法：获取添加和删除操作的公共数据
	 */
	private function getAddModifySameData()
	{
		$dataInfo = array();

		// !---------- BEGIN: MODIFY ---------- //
		//验证值唯一性
		if (isset($_POST['keyId'])) $keyId = $_POST['keyId'];
		$flag = $this->db->custom_authValUnique($keyId, $_POST['username']);
		if ($flag > 0) {
			echo "<script>alert('用户名已存在，请重新填写！');</script>";
			exit();
		}

		$dataInfo['username'] = $_POST['username'];
		$dataInfo['fullname'] = $_POST['fullname'];
		$dataInfo['remarks'] = $_POST['remarks'];
		$dataInfo['modifyuserid'] = $_SESSION[$this->view->sessionPrefix . 'userId'];
		$dataInfo['modifytime'] = date('Y-m-d G:i:s');
		// !---------- END: MODIFY ---------- //

		return $dataInfo;
	}

	/**
	 * 批量删除
	 */
	public function deleteAction()
	{
		$idString = $_POST['idString'];
		$this->db->deleteData($idString);

		$this->view->menuId = 'li' . $this->view->moduleName . $this->view->controllerName;
		echo $this->view->render('/all/views/refresh_ajax.phtml');
	}
}