<?php

namespace Admin\Controller;

use Think\Page;

class FrontController extends BaseController
{

	public function _initialize()
	{

		$this->selectTable = D('Ad');
	}

	public function index(){
		if($_GET['code']){
			$ad = $this->selectTable->where(array('is_show' => '是'))->find();
			$code = !empty($_GET['code'])?$_GET['code']:'';
			$depot_code = M('depot')->getField('depot_code', true);
			$code_4 = substr($code, 0, 4);
			if (in_array($code_4, $depot_code)) {
				$data = M()
					->field('p.product_name , product_code,b.batch_num,b.create_time,d.product_date,d.bill_num')
					->table('product_batch b')
					->join('product_batch_detail d on d.batch_id = b.id')
					->join('product p on p.id = b.product_id')
					->where(array('d.bill_num' => $code))
					->find();
					// echo M()->getLastSql();
				$type = 1;
			} else {
				$data = M()->field('p.batch_num,p.product_name,p.product_num,p.createdatetime,d.package_code')->table('package_batch p')->join('package_batch_detail d on d.batch_id = p.id')->where(array('d.shape_code' => $code))->find();
				//echo M()->getLastSql();
				if (!empty($batch)) {
					$data['shipment_date'] = M('shipment_detail')->where(array('package_code' => $batch['package_code']))->getField('createdatetime');
				}
				$type = 2;
			}
			$this->assign('data', $data);
			$this->assign('type', $type);
			$this->assign('code', $code);
			$this->assign('ad', $ad);

			$this->display('message');
			exit();
		}
		$this->display();
	}
	public function message()
	{
		$ad = $this->selectTable->where(array('is_show' => '是'))->find();
		$this->assign('title', '追溯查询');
		 $code = !empty($_GET['code'])?$_GET['code']:I('code');
		// $code = substr($code,0,7);
		
		$depot_code = M('depot')->getField('depot_code', true);
		$code_4 = substr($code, 0, 4);
		if (in_array($code_4, $depot_code)) {
			$data = M()
				->field('p.product_name , product_code,b.batch_num,b.create_time,d.product_date,d.bill_num')
				->table('product_batch b')
				->join('product_batch_detail d on d.batch_id = b.id')
				->join('product p on p.id = b.product_id')
				->where(array('d.bill_num' => $code))
				->find();
				// echo M()->getLastSql();
			$type = 1;
		} else {
			$data = M()->field('p.batch_num,p.product_name,p.product_num,p.createdatetime,d.package_code')->table('package_batch p')->join('package_batch_detail d on d.batch_id = p.id')->where(array('d.shape_code' => $code))->find();
			echo M()->getLastSql();
			if (!empty($batch)) {
				$data['shipment_date'] = M('shipment_detail')->where(array('package_code' => $batch['package_code']))->getField('createdatetime');
			}
			$type = 2;
		}
		$this->assign('data', $data);
		$this->assign('type', $type);
		$this->assign('code', $code);
		$this->assign('ad', $ad);

		$this->display('message');
	}
}
