<?php

class db_typeset extends baseDao // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
		parent::setTable("sys_dictdata");
		parent::setKeyId("Id");
	}

}