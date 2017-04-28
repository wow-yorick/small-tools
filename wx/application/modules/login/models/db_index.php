<?php

class db_index extends baseDao // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
		self::setTable("admin");
		self::setKeyId("Id");
	}
	
	/**
	 * 登录判断
	 * @param string $params 参数
	 * @return int $result
	 */
	public function login($params)
	{
		$sql = "SELECT * FROM admin WHERE username=:username AND password = :password";
		$result = parent::findWithParams($sql, $params);
		if (sizeof($result["obj"]) == 1){
			$result["msg"] = "登录成功!";
			$this->logger->info("用户:[".$params["username"]."] 登录成功!");
		}
		else {
			$result["success"] = false;
			$result["msg"] = "登录失败!";
			$this->logger->info("用户:[".$params["username"]."] 登录失败!");
		}
		return $result;
	}

}