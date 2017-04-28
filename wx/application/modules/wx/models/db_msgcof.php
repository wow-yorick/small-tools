<?php

class db_msgcof extends baseDao // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
		parent::setTable("wx_newsmsgcof");
		parent::setKeyId("Id");
	}

}