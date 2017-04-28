<?php

class db_main // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
	}

	public function getMenuList($strRoleId)
	{
		try {
			//获取登录用户权限内的所有item
			$sqlStr = "SELECT GROUP_CONCAT(DISTINCT itemId) FROM rights_role_item_rights WHERE roleId IN ($strRoleId) AND rights LIKE '1%'";
			$strItemId = $this->dbAdapter->fetchOne($sqlStr);
			
			//获取登录用户权限内的所有module
			$sqlStr = "SELECT itemName, moduleId FROM rights_items WHERE id IN ($strItemId) AND controllerId=0 AND actionId=0 ORDER BY ordered";
			$arrModule = $this->dbAdapter->fetchAll($sqlStr);
			//all_model_ousu_helper:: ousu_dump($arrModule); exit();
		
			$result = array();
			foreach ($arrModule as $arrSub) {
				//获取此module下的所有controller的itemId
				$sqlStr = "SELECT GROUP_CONCAT(DISTINCT id) FROM rights_items
							WHERE id IN ($strItemId) AND moduleId=" . $arrSub['moduleId'] . " AND controllerId!=0 AND actionId=0
							ORDER BY ordered";
				$strControllerId = $this->dbAdapter->fetchOne($sqlStr);

				if (empty($strControllerId)) continue;

				//获取此module下的所有controller信息
				$sqlStr = "SELECT r.id, itemName, moduleName, controllerName, SUM(r.ismenu) AS isMenu, isDialog
							FROM rights_role_item_rights r
							LEFT JOIN rights_items i ON r.itemId=i.id
							WHERE r. roleId IN ($strRoleId) AND r.itemId IN ($strControllerId)
							GROUP BY itemId ORDER BY ordered";
				$tempResult = $this->dbAdapter->fetchAll($sqlStr);

				if(array_key_exists($arrSub['itemName'], $result)) {
					foreach ($tempResult as $arrTemp) {
						array_push($result[$arrSub['itemName']], $arrTemp);
					}
				} else {
					$result[$arrSub['itemName']] = $tempResult;
				}
			}
			//all_model_ousu_helper:: ousu_dump($result); exit();
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
}