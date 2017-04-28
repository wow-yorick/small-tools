<?php

namespace Admin\Controller;

use Think\Page;

class CustomerController extends BaseController
{
	protected $selectTable;

	public function _initialize()
	{
		parent::_initialize();

		$this->selectTable = D('Customer');
	}

}
