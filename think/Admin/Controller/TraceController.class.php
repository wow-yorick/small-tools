<?php

namespace Admin\Controller;

use Think\Page;

/**
 * TraceController
 * 追溯查询
 * @uses BaseController
 * @package
 * @version $id$
 * @copyright 2015-2016 The JIA Group
 * @author yorick <v@5zyx.com>
 * @license Copyright © 2005-2015 www.jia.com All rights reserved
 */
class TraceController extends BaseController
{

	private $Trace;

	public function _initialize()
	{
		parent::_initialize();
		$this->package_batch = M('package_batch');
		$this->package_batch_detail = M('package_batch_detail');
		$this->shipment_detail = M('shipment_detail');
		$this->shipment = M('shipment');
		$this->admin = M('admin');
	}

	public function getList()
	{

		$shape_code = trim(I('get.shape_code'));
		if (!empty($shape_code)) {
			$map = array('shape_code' => array('like', "%{$shape_code}%"));
			$count = $this->package_batch_detail->where($map)->count();
			$Page = new Page($count);
			$lists = $this->package_batch_detail->where($map)->limit($Page->firstRow, $Page->listRows)->select();

			foreach ($lists as $k => $info) {
				$lists[$k] = array(
					'info' => $info,
					'inInfo' => $this->getInInfo($info['package_code']),
					'outInfo' => $this->getOutInfo($info['package_code']),
				);
			}
			$this->assign('list', $lists);
			$this->assign('page', $Page->show());
		}
		$user = $this->admin->getField('id,user_name');

		$this->assign('user',$user);
		$this->assign('shape_code', $shape_code);
		$this->display('getList');
	}

	private function getInInfo($package_code)
	{
		$batch_num = $this->package_batch_detail->where(array('package_code' => $package_code))->getField('batch_num');
		if (!empty($batch_num)) {
			return $this->package_batch->where(array('batch_num' => $batch_num))->find();
		}

	}

	private function getOutInfo($package_code)
	{

		$batch_num = $this->shipment_detail->where(array('package_code' => $package_code))->getField('batch_num');
		if (!empty($batch_num)) {
			$detail = $this->shipment->where(array('shipment_code' => $batch_num))->find();
		}
		return $detail;
	}
}
