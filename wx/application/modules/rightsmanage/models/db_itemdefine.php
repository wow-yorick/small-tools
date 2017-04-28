<?php

class db_itemdefine // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
	}

	/**
	 * 获取datalist数据
	 * @return array $result
	 * 注：keyId 字段名不要变
	 */
	public function getDataList()
	{
		try {
			$sqlStr = "SELECT i.id AS keyId, t.itemname AS moduleItemName, i.itemname, i.moduleId, i.controllerId, i.actionId, i.modulename, i.controllername, i.actionname, i.remarks
						FROM rights_items i
						LEFT JOIN (SELECT moduleId,itemname From rights_items WHERE controllerId=0) t ON i.moduleId=t.moduleId
						ORDER BY i.id DESC";

			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 详细
	 * @param int $keyId
	 * @return array $result
	 * 注：keyId 字段名不要变
	 */
	public function getDataDetail($keyId)
	{
		try {
			$sqlStr = "SELECT id AS itemId, itemName, moduleId, controllerId, actionId, moduleName, controllerName, actionName, remarks, isDialog
						FROM rights_items WHERE id=$keyId";
			$result = $this->dbAdapter->fetchRow($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 搜索
	 * @return array $result
	 */
	public function searchData($arrSearch)
	{
		try {
			$sqlStr = "SELECT i.id AS keyId, t.itemname AS moduleItemName, i.itemname, i.moduleId, i.controllerId, i.actionId, i.modulename, i.controllername, i.actionname, i.remarks
						FROM rights_items i
						LEFT JOIN (SELECT moduleId,itemname From rights_items WHERE controllerId=0) t ON i.moduleId=t.moduleId
						WHERE 1=1";
			if (isset($arrSearch['moduleId'])) {
				$sqlStr .= ' AND i.moduleId=\'' . $arrSearch['moduleId'] . '\'';
			}
			if (isset($arrSearch['controllerId'])) {
				$sqlStr .= ' AND i.controllerId=\'' . $arrSearch['controllerId'] . '\'';
			}

			$sqlStr .= ' ORDER BY i.id DESC';
			//all_model_ousu_helper:: ousu_dump($sqlStr); exit();
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 添加
	 * @param array $dataInfo
	 * @return
	 */
	public function addData($dataInfo, $itemType)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_items'; // !--- MODIFY--- //

			// !---------- BEGIN: CUSTOM ---------- //
			switch ($itemType) {
				case 'module':
					$sqlStr = "SELECT MAX(moduleId) FROM rights_items";
					$newModuleId = $this->dbAdapter->fetchOne($sqlStr);
					$dataInfo['moduleId'] = $newModuleId + 1;
					break;
				case 'controller':
					$sqlStr = "SELECT MAX(controllerId) FROM rights_items WHERE moduleId=" . $dataInfo['moduleId'];
					$newControllerId = $this->dbAdapter->fetchOne($sqlStr);
					$dataInfo['controllerId'] = $newControllerId + 1;
					break;
				case 'action':
					$sqlStr = "SELECT MAX(actionId) FROM rights_items WHERE moduleId=" . $dataInfo['moduleId'] . " AND controllerId=" . $dataInfo['controllerId'];
					$newActionId = $this->dbAdapter->fetchOne($sqlStr);
					$dataInfo['actionId'] = $newActionId + 1;
					break;
			}
			// !---------- END: CUSTOM ---------- //

			$row = $dataInfo;
			$rows_affected = $this->dbAdapter->insert($table, $row);

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 修改
	 * @param int $keyId
	 * @param array $dataInfo
	 * @return
	 */
	public function modifyData($keyId, $dataInfo, $itemType)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_items'; // !--- MODIFY--- //

			// !---------- BEGIN: CUSTOM ---------- //
			switch ($itemType) {
				case 'module':
					$sqlStr = "SELECT moduleName FROM rights_items WHERE id=$keyId";
					$oldModuleName = $this->dbAdapter->fetchOne($sqlStr);

					$set = array('modulename' => $dataInfo['moduleName']);
					$where = "moduleName='$oldModuleName'";
					$rows_affected = $this->dbAdapter->update($table, $set, $where);
					break;
				case 'controller':
					$sqlStr = "SELECT moduleName, controllerName FROM rights_items WHERE id=$keyId";
					$tmpRst = $this->dbAdapter->fetchRow($sqlStr);

					$set = array(
						'moduleId' => $dataInfo['moduleId'],
						'moduleName' => $dataInfo['moduleName'],
						'controllerName' => $dataInfo['controllerName'],
					);
					$where = "moduleName='" . $tmpRst['moduleName'] . "' AND controllerName='" . $tmpRst['controllerName'] . "'";
					$rows_affected = $this->dbAdapter->update($table, $set, $where);
					break;
				case 'action':
					break;
			}
			// !---------- END: CUSTOM ---------- //

			$set = $dataInfo;
			$where = "id=$keyId";
			$rows_affected = $this->dbAdapter->update($table, $set, $where);

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 批量删除
	 * @param string $idString id字符串(用逗号隔开)
	 * @return
	 */
	public function deleteData($idString)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_items'; // !--- MODIFY--- //
			$where = "id IN($idString)";
			$rows_affected = $this->dbAdapter->delete($table, $where);

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

// !------------------------------ BEGIN: CUSTOM ------------------------------ //
	/**
	 * 验证值唯一性（itemName）
	 * @param string $moduleName
	 * @return int $result
	 */
	public function custom_authValUnique_item($keyId, $itemName)
	{
		try {
			$sqlStr = "SELECT COUNT(*) FROM rights_items WHERE itemname='$itemName'";
			if (!empty($keyId)) {
				$sqlStr .= " AND id!=$keyId";
			}
			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 验证值唯一性（moduleName）
	 * @param string $moduleName
	 * @return int $result
	 */
	public function custom_authValUnique_module($keyId, $moduleName)
	{
		try {
			$sqlStr = "SELECT COUNT(*) FROM rights_items WHERE modulename='$moduleName' AND controllerId=0 AND actionId=0";
			if (!empty($keyId)) {
				$sqlStr .= " AND id!=$keyId";
			}
			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 验证值唯一性（controllerName）
	 * @param int $moduleId
	 * @param string $controllerName
	 * @return int $result
	 */
	public function custom_authValUnique_controller($keyId, $moduleId, $controllerName)
	{
		try {
			$sqlStr = "SELECT COUNT(*) FROM rights_items WHERE moduleId=$moduleId AND controllername='$controllerName' AND actionId=0";
			if (!empty($keyId)) {
				$sqlStr .= " AND id!=$keyId";
			}

			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 验证值唯一性（actionName）
	 * @param int $moduleId
	 * @param int $controllerId
	 * @param string $actionName
	 * @return int $result
	 */
	public function custom_authValUnique_action($keyId, $moduleId, $controllerId, $actionName)
	{
		try {
			if (empty($keyId)) { //添加操作
				$sqlStr = "SELECT COUNT(*) FROM rights_items WHERE moduleId=$moduleId AND controllerId=$controllerId AND actionName='$actionName'";
			} else { //修改操作
				$sqlTmp = "SELECT moduleId, controllerId FROM rights_items WHERE id=$keyId";
				$tmpRst = $this->dbAdapter->fetchRow($sqlTmp);
				$moduleId = $tmpRst['moduleId'];
				$controllerId = $tmpRst['controllerId'];

				$sqlStr = "SELECT COUNT(*) FROM rights_items WHERE moduleId=$moduleId AND controllerId=$controllerId AND actionName='$actionName' AND id!=$keyId";
			}

			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 根据key获取moduleName和controllerName
	 * @return array $result
	 */
	public function custom_getModuleControllerName($keyId, $itemType)
	{
		try {
			switch ($itemType) {
				case 'controller':
					$sqlStr = "SELECT moduleId FROM rights_items WHERE id=$keyId";
					$moduleId = $this->dbAdapter->fetchOne($sqlStr);
					$sqlStr = "SELECT moduleName FROM rights_items WHERE moduleId=$moduleId AND controllerId=0 AND actionId=0";
					break;
				case 'action':
					$sqlStr = "SELECT moduleId, controllerId FROM rights_items WHERE id=$keyId";
					$tmpRst = $this->dbAdapter->fetchRow($sqlStr);
					$sqlStr = "SELECT moduleName, controllerName FROM rights_items WHERE moduleId=" . $tmpRst['moduleId'] . " AND controllerId=" . $tmpRst['controllerId'] . " AND actionId=0";
					break;
			}
			$result = $this->dbAdapter->fetchRow($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 根据moduleId获取moduleName
	 * @return string $result
	 */
	public function custom_getModuleName($moduleId)
	{
		try {
			$sqlStr = "SELECT modulename FROM rights_items WHERE moduleId=$moduleId AND controllerId=0 AND actionId=0";
			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 根据moduleId获取moduleName
	 * @return string $result
	 */
	public function custom_getControllerName($moduleId, $controllerId)
	{
		try {
			$sqlStr = "SELECT controllername FROM rights_items WHERE moduleId=$moduleId AND controllerId=$controllerId AND actionId=0";
			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取所有module
	 * @return array $result
	 */
	public function custom_getAllModule()
	{
		try {
			$sqlStr = "SELECT DISTINCT id AS itemId, CONCAT(itemname, '：', modulename) AS displayName, moduleId
						FROM rights_items
						WHERE controllerId=0 AND actionId=0 ORDER BY ordered";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取所有controller
	 * @return array $result
	 */
	public function custom_getAllController()
	{
		try {
			$sqlStr = "SELECT moduleId, controllerId, CONCAT(itemname, '：', controllername) AS displayName
						FROM rights_items
						WHERE controllerId!=0 AND actionId=0 ORDER BY ordered";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取module下的controller
	 * @param int $moduleId
	 * @return array $result
	 */
	public function custom_getModuleController($moduleId)
	{
		try {
			$sqlStr = "SELECT id AS itemId, moduleId, controllerId, CONCAT(itemname, '：', controllername) AS displayName
						FROM rights_items
						WHERE moduleId=$moduleId AND controllerId!=0 AND actionId=0 ORDER BY ordered";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取所有controller下的action
	 * @return array $result
	 */
	public function custom_getControllerAction($moduleId, $controllerId)
	{
		try {
			$sqlStr = "SELECT DISTINCT id AS itemId, itemname FROM rights_items WHERE moduleId=$moduleId AND controllerId =$controllerId AND actionId!=0 ORDER BY ordered";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取item的类型
	 * @param int $keyId
	 * @return string $result
	 */
	public function custom_getItemType($keyId)
	{
		try {
			$sqlStr = "SELECT moduleId, controllerId, actionId FROM rights_items WHERE id=$keyId";
			$result = $this->dbAdapter->fetchRow($sqlStr);

			if ($result['controllerId'] == 0 && $result['actionId'] == 0) {
				$result = 'module';
			} else if ($result['controllerId'] != 0 && $result['actionId'] == 0) {
				$result = 'controller';
			} else {
				$result = 'action';
			}
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 排序item
	 * @return
	 */
	public function custom_sortItem($arrSortInfo)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_items';
			foreach ($arrSortInfo as $arrSub) {
				$set = array('ordered' => $arrSub[1]);
				$where = "id=$arrSub[0]";
				$rows_affected = $this->dbAdapter->update($table, $set, $where);
			}
			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}
// !------------------------------ END  : CUSTOM ------------------------------ //
}