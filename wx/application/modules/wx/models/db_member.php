<?php

class db_member extends baseDao // !--- MODIFY--- //
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
		parent::setTable("wx_memeber");
		parent::setKeyId("Id");
	}

}