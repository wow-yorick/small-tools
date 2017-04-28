<?php

class Rightsmanage_ItemdefineController extends Zend_Controller_Action // !--- MODIFY --- //
{

	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_rights.php'; // !--- COPY --- //
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
		if (!empty($_POST['moduleId'])) {
			$arrSearch['moduleId'] = $_POST['moduleId'];
		}
		if (!empty($_POST['controllerId'])) {
			$arrSearch['controllerId'] = $_POST['controllerId'];
		}

		$this->view->allDataList = $this->db->searchData($arrSearch);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/list_ajax.phtml');
	}

	/**
	 * 显示详细界面
	 */
	public function showdetailAction()
	{
		$this->view->editType = 'detail';
		$this->view->keyId = $_POST['keyId'];
		$this->view->dataDetail = $this->db->getDataDetail($this->view->keyId);
		//all_model_ousu_helper:: ousu_dump($this->view->dataDetail); exit();

		// !---------- BEGIN: CUSTOM ---------- //
		$this->view->allModule = $this->db->custom_getAllModule();
		$this->view->itemType = $this->db->custom_getItemType($this->view->keyId);
		// !---------- END  : CUSTOM ---------- //

		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/detail_ajax.phtml');
	}

	/**
	 * 显示添加界面
	 */
	public function showaddAction()
	{
		$this->view->editType = 'add';

		// !---------- BEGIN: CUSTOM ---------- //
		$this->view->allModule = $this->db->custom_getAllModule();
		// !---------- END  : CUSTOM ---------- //

		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/detail_ajax.phtml');
	}

	/**
	 * 显示修改界面
	 */
	public function showmodifyAction()
	{
		$this->view->editType = 'modify';
		$this->view->keyId = $_POST['keyId'];
		$this->view->dataDetail = $this->db->getDataDetail($this->view->keyId);
		//all_model_ousu_helper:: ousu_dump($this->view->dataDetail); exit();

		// !---------- BEGIN: CUSTOM ---------- //
		$this->view->allModule = $this->db->custom_getAllModule();
		$this->view->itemType = $this->db->custom_getItemType($this->view->keyId);
		// !---------- END  : CUSTOM ---------- //

		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/detail_ajax.phtml');
	}

	/**
	 * 添加
	 */
	public function addAction()
	{
		//all_model_ousu_helper:: ousu_dump($_POST); exit();

		$dataInfo = self:: getAddModifySameData();
		//all_model_ousu_helper:: ousu_dump($dataInfo); exit();
		$this->db->addData($dataInfo, $_POST['itemType']);

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
		$this->db->modifyData($keyId, $dataInfo, $_POST['itemType']);

		$this->view->menuId = 'li' . $this->view->moduleName . $this->view->controllerName;
		echo $this->view->render('/all/views/refresh_ajax.phtml');
	}

	/**
	 * 私有方法：获取添加和修改操作的公共数据
	 */
	private function getAddModifySameData()
	{
		$dataInfo = array();

		// !---------- BEGIN: MODIFY ---------- //
		switch ($_POST['itemType']) {
			case 'module':
				//验证值唯一性（moduleName） //不要验证了
				/*if (isset($_POST['keyId'])) $keyId = $_POST['keyId'];
				$flag = $this->db->custom_authValUnique_module($keyId, $_POST['moduleName']);
				if ($flag > 0) {
					echo "<script>alert('ModuleName已存在，请重新填写！');</script>";
					exit();
				}*/

				$dataInfo['moduleName'] = $_POST['moduleName'];
				$dataInfo['controllerName'] = '';
				$dataInfo['actionName'] = '';
				break;
			case 'controller':
				//验证值唯一性（controllerName）
				if (isset($_POST['keyId'])) $keyId = $_POST['keyId'];
				$flag = $this->db->custom_authValUnique_controller($keyId, $_POST['moduleId'], $_POST['controllerName']);
				if ($flag > 0) {
					echo "<script>alert('ControllerName已存在，请重新填写！');</script>";
					exit();
				}

				$dataInfo['moduleId'] = $_POST['moduleId'];
				$dataInfo['moduleName'] = $this->db->custom_getModuleName($dataInfo['moduleId']);
				$dataInfo['controllerName'] = $_POST['controllerName'];
				$dataInfo['actionName'] = '';
				$dataInfo['isdialog'] = $_POST['isDialog'];
				break;
			case 'action':
				//验证值唯一性（actionName）
				if (isset($_POST['keyId'])) $keyId = $_POST['keyId'];
				if (isset($_POST['moduleId'])) { //添加操作
					$dataInfo['moduleId'] = $_POST['moduleId'];
					$dataInfo['moduleName'] = $this->db->custom_getModuleName($dataInfo['moduleId']);
					$dataInfo['controllerId'] = $_POST['controllerId'];
					$dataInfo['controllerName'] = $this->db->custom_getControllerName($dataInfo['moduleId'], $dataInfo['controllerId']);
				} else { //修改操作
					$result = $this->db->custom_getModuleControllerName($keyId, 'action');
					$dataInfo['moduleName'] = $result['moduleName'];
					$dataInfo['controllerName'] = $result['controllerName'];
				}

				$flag = $this->db->custom_authValUnique_action($keyId, $dataInfo['moduleId'], $dataInfo['controllerId'], $_POST['actionName']);
				if ($flag > 0) {
					echo "<script>alert('ActionName已存在，请重新填写！');</script>";
					exit();
				}

				$dataInfo['actionName'] = $_POST['actionName'];
				break;
		}

		$dataInfo['itemName'] = $_POST['itemName'];
		$dataInfo['remarks'] = $_POST['remarks'];
		// !---------- END  : MODIFY ---------- //

		return $dataInfo;
	}

	/**
	 * 批量删除
	 */
	public function deleteAction()
	{
		$idString = $_POST['idString'];
		$this->db->deleteData($idString);

		$this->view->allDataList = $this->db->getDataList();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/list_ajax.phtml');
	}

// !------------------------------ BEGIN: CUSTOM ------------------------------ //
	/**
	 * 获取module下的controller
	 */
	public function getmodulecontrollerAction()
	{
		$moduleId = $_POST['moduleId'];
		$this->view->allModuleController = $this->db->custom_getModuleController($moduleId);
		//all_model_ousu_helper:: ousu_dump($this->view->allModuleController); exit();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/custom_modulecontroller_ajax.phtml');
	}

	/**
	 * 显示模块排序tab
	 */
	public function showitemsorttabAction()
	{
		$keyId = $_POST['idString'];
		$this->view->allModule = $this->db->custom_getAllModule();
		//all_model_ousu_helper:: ousu_dump($this->view->allModule); exit();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/ordered_showitemsorttab.phtml');
	}

	/**
	 * 获取module下的controller
	 */
	public function getmodulecontroller2Action()
	{
		$moduleId = $_POST['moduleId'];
		$this->view->allModuleController = $this->db->custom_getModuleController($moduleId);
		//all_model_ousu_helper:: ousu_dump($this->view->allModuleController); exit();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/ordered_controller_ajax.phtml');
	}

	/**
	 * 获取所有controller下的action
	 */
	public function getcontrolleractionAction()
	{
		$moduleId = $_POST['moduleId'];
		$controllerId = $_POST['controllerId'];
		$this->view->allControllerAction = $this->db->custom_getControllerAction($moduleId, $controllerId);
		//all_model_ousu_helper:: ousu_dump($this->view->allModuleController); exit();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/ordered_action_ajax.phtml');
	}

	/**
	 * 排序module
	 */
	public function confirmsortmoduleAction()
	{
		$arrSortInfo = $_POST['arrSortInfo'];
		//all_model_ousu_helper:: ousu_dump($arrSortInfo); exit();
		$this->db->custom_sortItem($arrSortInfo);

		$this->view->allModule = $this->db->custom_getAllModule();
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/ordered_module_ajax.phtml');
		echo "<script>alert('操作成功！');</script>";
	}

	/**
	 * 排序controller
	 */
	public function confirmsortcontrollerAction()
	{
		$arrSortInfo = $_POST['arrSortInfo'];
		$this->db->custom_sortItem($arrSortInfo);

		$moduleId = $_POST['moduleId'];
		$this->view->allModuleController = $this->db->custom_getModuleController($moduleId);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/ordered_controller_ajax.phtml');
		echo "<script>alert('操作成功！');</script>";
	}
// !------------------------------ END  : CUSTOM ------------------------------ //
}