<?php

class db_admindefine // !--- MODIFY--- //
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
			$sqlStr = "SELECT id AS keyId, username, fullname, remarks
						FROM admin
						ORDER BY inserttime DESC";
			$result = $this->dbAdapter->fetchAll($sqlStr);
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
			$sqlStr = "SELECT id AS keyId, username, fullname, remarks
						FROM admin
						WHERE 1=1";
			
			// !---------- BEGIN: CUSTOM ---------- //
			if (isset($arrSearch['username'])) {
				$sqlStr .= ' AND username LIKE (\'%' . $arrSearch['username'] . '%\')';
			}
			if (isset($arrSearch['fullname'])) {
				$sqlStr .= ' AND fullname LIKE (\'%' . $arrSearch['fullname'] . '%\')';
			}
			// !---------- END  : CUSTOM ---------- //

			$sqlStr .= ' ORDER BY inserttime DESC';
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
	public function addData($dataInfo)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'admin'; // !--- MODIFY--- //
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
	public function modifyData($keyId, $dataInfo)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'admin'; // !--- MODIFY--- //
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
			$table = 'admin'; // !--- MODIFY--- //
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
	 * 验证值唯一性
	 * @param string $value
	 * @return int $result
	 */
	public function custom_authValUnique($keyId, $value)
	{
		try {
			$sqlStr = "SELECT COUNT(*) FROM admin WHERE username='$value'";
			if (!empty($keyId)) $sqlStr .= " AND id!=$keyId";
			
			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
// !------------------------------ END  : CUSTOM ------------------------------ //
}