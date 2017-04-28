<?php

class db_casdict extends baseDao // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
		parent::setTable("sys_casdictdata");
		parent::setKeyId("Id");
	}

}