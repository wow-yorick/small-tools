<?php

class db_roledefine // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
	}

	/**
	 * 获取所有module
	 * @return array $result
	 */
	public function getAllItemModule()
	{
		try {
			$sqlStr = "SELECT DISTINCT id AS itemId, itemname, CONCAT(itemname, '（', modulename, '）') AS displayName FROM rights_items WHERE controllerId=0 AND actionId=0 ORDER BY ordered";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取所能使用的所有角色
	 * @return array $result
	 */
	public function getAllRole()
	{
		try {
			$sqlStr = "SELECT id AS roleId, rolename FROM rights_roles ORDER BY CONVERT(rolename USING gb2312)";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取所有权限
	 * @return array $result
	 */
	public function getAllRights()
	{
		try {
			$sqlStr = "SELECT id AS rightsId, rightsname FROM rights_rights ORDER BY id";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 添加角色
	 * @param string $roleName
	 * @return
	 */
	public function addRole($roleName)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_roles';
			$row = array('rolename' => $roleName);
			$rows_affected = $this->dbAdapter->insert($table, $row);
			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 删除角色
	 * @param int $roleId
	 * @return
	 */
	public function deleteRole($roleId)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_roles';
			$where = "id=$roleId";
			$rows_affected = $this->dbAdapter->delete($table, $where);

			$table = 'rights_role_item_rights';
			$where = "roleId=$roleId";
			$rows_affected = $this->dbAdapter->delete($table, $where);

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 获取角色的module
	 * @param int $roleId
	 * @return array $result
	 */
	public function getRoleModule($roleId)
	{
		try {
			$sqlStr = "SELECT i.id AS itemId, moduleId, i.itemname, CONCAT(itemname, '（', modulename, '）') AS displayName
								FROM rights_role_item_rights rir
								JOIN ". "rights_items i ON rir.itemId=i.id
								WHERE rir.roleId=$roleId AND controllerId=0 AND actionId=0
								ORDER BY ordered";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	* 添加角色的module
	* @param int $roleId
	* @param int $itemId
	* @return
	*/
	public function addRoleModule($roleId, $itemId)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_role_item_rights';
			$row = array(
				'roleId' => $roleId
				,'itemId' => $itemId
				,'rights' => '11'
			);
			$rows_affected = $this->dbAdapter->insert($table, $row);
			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 删除角色的module
	 * @param int $roleId
	 * @param int $moduleId
	 * @return
	 */
	public function deleteRoleModule($roleId, $moduleId) {
		$this->dbAdapter->beginTransaction();
		try {
			$sqlStr = "SELECT GROUP_CONCAT(id) FROM rights_items WHERE moduleId=$moduleId GROUP BY moduleId";
			$strItemId = $this->dbAdapter->fetchOne($sqlStr);

			$table = 'rights_role_item_rights';
			$where = "roleId=$roleId AND itemId IN ($strItemId)";
			$rows_affected = $this->dbAdapter->delete($table, $where);

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 获取module下的action
	 * @param int $moduleId
	 * @return array $result
	 */
	public function getModuleAction($moduleId)
	{
		try {
			$sqlStr = "SELECT id AS itemId, itemname, modulename, controllername, actionname
						FROM rights_items
						WHERE moduleId=$moduleId AND controllerId!=0
						ORDER BY controllername,actionname";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取module的权限
	 * @param int $roleId
	 * @param int $moduleId
	 * @return array $result
	 */
	public function getItemRights($roleId, $moduleId)
	{
		try {
			$sqlStr = "SELECT GROUP_CONCAT(DISTINCT id) FROM rights_items WHERE moduleId=$moduleId";
			$strItemId = $this->dbAdapter->fetchOne($sqlStr);

			$sqlStr = "SELECT itemId, rights, isMenu FROM rights_role_item_rights WHERE roleId=$roleId AND itemId IN ($strItemId)";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 修改module权限
	 * @param int $roleId
	 * @param int $itemId
	 * @param string $strRights
	 * @return
	 */
	public function modifyModuleRights($roleId, $itemId, $rights)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$sqlStr = "SELECT COUNT(*) FROM rights_role_item_rights WHERE roleId=$roleId AND itemId=$itemId";
			$flag = $this->dbAdapter->fetchOne($sqlStr);

			$table = 'rights_role_item_rights';
			if ($flag > 0) {
				$set = array('rights' => $rights);
				$where = "roleId=$roleId AND itemId=$itemId";
				$rows_affected = $this->dbAdapter->update($table, $set, $where);
			} else {
				$row = array(
						'roleId' => $roleId
						,'itemId' => $itemId
						,'rights' => $rights
				);
				$rows_affected = $this->dbAdapter->insert($table, $row);
			}

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 修改action的权限
	 * @param array $arrActionRights
	 * @param array $arrIsMenu
	 * @return array $result
	 */
	public function modifyActionRights($arrActionRights, $arrIsMenu)
	{
		$this->dbAdapter->beginTransaction();
		try {
			for ($i=0; $i<sizeof($arrActionRights); $i++) {
				$roleId = $arrActionRights[$i][0];
				$itemId = $arrActionRights[$i][1];
				$rights = $arrActionRights[$i][2];
				$sqlStr = "SELECT COUNT(*) FROM rights_role_item_rights WHERE roleId=$roleId AND itemId=$itemId";
				$flag = $this->dbAdapter->fetchOne($sqlStr);

				$table = 'rights_role_item_rights';
				if ($flag > 0) {
					$set = array(
						'rights' => $rights
						,'ismenu' => $arrIsMenu[$i]
					);
					$where = "roleId=$roleId AND itemId=$itemId";
					$rows_affected = $this->dbAdapter->update($table, $set, $where);
				} else {
					if ($rights == '00') continue; //'00'权限时不插入
					$row = array(
							'roleId' => $roleId
							,'itemId' => $itemId
							,'rights' => $rights
							,'ismenu' => $arrIsMenu[$i]
					);
					$rows_affected = $this->dbAdapter->insert($table, $row);
				}
			}

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}
}