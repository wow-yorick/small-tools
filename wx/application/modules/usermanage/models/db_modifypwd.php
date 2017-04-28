<?php

class db_modifypwd // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
	}
	/**
	 * 检查企业旧密码是否正确
	 * @param int $companyId 公司id
	 * @param string $password 旧密码
	 * @return
	 */
	 public function checkOldCompanyPwd($userId, $password)
	{
		try {
			$sqlStr = "SELECT count(*) FROM admin WHERE id='$userId' AND password='$password'";
			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 修改密码
	 * @param int $companyId 公司id
	 * @param string $password 新密码
	 * @param int $userId 要修改的管理员账号id
	 * @return
	 */
	public function modifyCompanyPwd($userId, $password)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'admin';
			$set = array(
						'password' => $password
					);
			$where = "id=$userId";
			$rows_affected = $this->dbAdapter->update($table, $set, $where);

			$this->dbAdapter->commit();
			return true;
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

}