<?php

class db_roledistribute // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
	}

	/**
	 * 搜索用户
	 * @param int $atId 账号类型id
	 * @param int $roletypeId 安监账号类型id
	 * @param int $roleId 角色id
	 * @return array $result
	 */
	public function searchUser($atId , $roleId)
	{
		try {
			switch ($atId) {
				case 1: //企业账号
					if (empty($roleId)) { //全部企业账号
						$sqlStr = "SELECT id AS userId, fullname, username FROM admin";
					} else { //包含此角色的企业账号
						$sqlStr = "SELECT DISTINCT r.userId, a.fullname, a.username
											FROM rights_at_user_role_ds r
											JOIN admin a ON r.userId=a.id
											WHERE atId=$atId AND roleId=$roleId";
					}
					$sqlStr .= " ORDER BY CONVERT(fullname USING gb2312)";
					$result = $this->dbAdapter->fetchAll($sqlStr);
					break;
			}
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取用户角色对应关系
	 * @param int $atId 账号类型id
	 * @param int $userId 用户id
	 * @return array $result
	 */
	public function getUserRole($atId, $userId)
	{
		try {
			$result = array();
			$sqlStr = "SELECT id, roleId, dsId, dsVal FROM rights_at_user_role_ds WHERE atId=$atId AND userId=$userId";
			$tempResult = $this->dbAdapter->fetchAll($sqlStr);

			foreach ($tempResult as $arrSub) {
				$arrTemp = array('id'=>$arrSub['id'], 'roleName'=>'', 'dsName'=>'无', 'dsVal'=>'无');

				$sqlStr = "SELECT rolename, remarks FROM rights_roles WHERE id=" . $arrSub['roleId'];
				$rs = $this->dbAdapter->fetchRow($sqlStr);
				$arrTemp['roleName'] = $rs['rolename'];
				$arrTemp['remarks'] = $rs['remarks'];

				if (!empty($arrSub['dsId'])) {
					$sqlStr = "SELECT datasourcename FROM rights_datasources WHERE id=" . $arrSub['dsId'];
					$arrTemp['dsName'] = $this->dbAdapter->fetchOne($sqlStr);
				}

				if (empty($arrSub['dsVal'])) $arrSub['dsVal'] = -1; //防止为空时，sql语句报语法错误

				array_push($result, $arrTemp);
			}
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}


	/**
	 * 添加用户角色对应关系
	 * @param int $atId 账号类型id
	 * @param int $userId 用户id
	 * @param int $roleId 角色id
	 * @param int $dsId 节点名id
	 * @param int $dsVal 节点值
	 * @return -1表示成功，否则返回errMsg
	 */
	public function addUserRole($atId, $userId, $roleId, $dsId, $dsVal)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_at_user_role_ds';
			$row = array(
					'atId' => $atId
					,'userId' => $userId
					,'roleId' => $roleId
					,'dsId' => $dsId
					,'dsVal' => $dsVal
				);

			if ($dsId == null) { //不设置节点值时
				$rows_affected = $this->dbAdapter->insert($table, $row);
			} else { //设置节点值时
				$sqlStr = "SELECT COUNT(*) FROM rights_at_user_role_ds
									WHERE atId=$atId AND userId=$userId AND roleId=$roleId AND dsId=$dsId";
				$flag = $this->dbAdapter->fetchOne($sqlStr);

				if ($flag == 0) { //数据库中未设过此dsId时，直接插入
					$rows_affected = $this->dbAdapter->insert($table, $row);
				} else { //数据库中已设过此dsId时，取出值，合并，再更新
					$sqlStr = "SELECT dsval FROM rights_at_user_role_ds
										WHERE atId=$atId AND userId=$userId AND roleId=$roleId AND dsId=$dsId";
					$tempDsVal = $this->dbAdapter->fetchOne($sqlStr);
					$newDsVal = array_unique(explode(',', $dsVal . ',' . $tempDsVal));
					sort($newDsVal, SORT_NUMERIC);
					$newDsVal = implode(',', $newDsVal);

					$set = array(
							'atId' => $atId
							,'roleId' => $roleId
							,'dsId' => $dsId
							,'dsVal' => $newDsVal
						);
					$where = "atId=$atId AND userId=$userId AND roleId=$roleId AND dsId=$dsId";
					$rows_affected = $this->dbAdapter->update($table, $set, $where);
				}
			}

			$this->dbAdapter->commit();
			return -1;
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}

	/**
	 * 删除用户角色对应关系
	 * @param int $rowId
	 * @return
	 */
	public function deleteUserRole($rowId)
	{
		$this->dbAdapter->beginTransaction();
		try {
			$table = 'rights_at_user_role_ds';
			$where = "id=$rowId";
			$rows_affected = $this->dbAdapter->delete($table, $where);

			$this->dbAdapter->commit();
		} catch (Exception $e) {
			$this->dbAdapter->rollBack();
			die($e->getMessage());
		}
	}
}