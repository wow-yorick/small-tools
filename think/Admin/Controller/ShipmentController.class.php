<?php

namespace Admin\Controller;

use Think\Page;

class ShipmentController extends BaseController
{
	protected $selectTable;
	protected $tableDetail;
	protected $Product;
	protected $Customer;

	public function _initialize()
	{
		parent::_initialize();

		$this->selectTable = D('Shipment');

		$this->tableDetail = D('ShipmentDetail');
		$this->packageDetailTable = D('PackageBatchDetail');
		$this->Product = M('product');
		$this->Customer = M('customer');
	}

	/**
	 * add
	 * 新增
	 * @access protected
	 * @return void
	 */
	public function add()
	{
		$this->_beforAct();
		if (IS_POST) {
			if (!$this->selectTable->create()) {
				$this->error($this->selectTable->getError());
			}
			$depotCode = session('DEPOT_CODE');
			$this->selectTable->shipment_code = auto_genera_num($this->selectTable, 'OUT_' . $depotCode, 9);
			$this->selectTable->createdatetime = date('Y-m-d G:i:s', time());
			$this->selectTable->createuser = session(C('USER_AUTH_KEY'));
			$this->selectTable->customer_id = M('customer')->where(array('name'=>I('post.customer_name')))->getField('id');
			$this->selectTable->add();
			$this->success('添加成功!');
			die;
		}

		$customerList = M('customer')->select();
		$productList = $this->Product->field(array('id', 'product_name', 'product_code'))->select();
		$this->assign('customerList', $customerList);
		$this->assign('productList', $productList);
		$this->display('detail');
	}

	/**
	 * ajaxInActBatch
	 * 异步显示进行中的批次
	 * @access public
	 * @return void
	 */
	public function ajaxInActBatch()
	{
		$inActBatchList = $this->selectTable->where(array('status' => array('neq', '完成')))->order(array('id' => 'desc'))->select();
		$this->assign('list', $inActBatchList);
		$this->display();
	}

	/**
	 * ajaxSetCurrentPatch
	 * 设置当前批次
	 * @access public
	 * @return void
	 */
	public function ajaxSetCurrentPatch()
	{
		$retMap = array();
		$retMap['code'] = 400;
		$retMap['msg'] = '请求失败!';

		$batchId = I('post.id');
		$batchId = $retMap['id'] = intval($batchId);

		$search = array(
			//'status' => '进行中',
			'id' => $batchId,

		);
		$upRet = $this->selectTable->where($search)->save(array('current_batch' => 1, 'status' => '处理'));
		if (!$upRet) {
			$retMap['msg'] = '设置当前批次失败!';
			$this->ajaxReturn($retMap);
		}
		$searchOther = array(
			'status' => array('neq', '完成'),
			'id' => array('neq', $batchId),
		);
		$upOtherRet = $this->selectTable->where($searchOther)->save(array('current_batch' => 0, 'status' => '进行中'));
		if (!$upOtherRet) {
			$retMap['msg'] = '复原其他批次状态失败!';
			$this->ajaxReturn($retMap);
		}
		//$currentData = $this->selectTable->find($batchId);
		$retMap['code'] = 200;
		$retMap['msg'] = '获取成功!';
		//$retMap['result'] = $currentData;
		$this->ajaxReturn($retMap);
	}

	/**
	 * ajaxDatCollect
	 * 小包装数据采集
	 * @access public
	 * @return void
	 */
	public function ajaxDatCollect()
	{
		$batchSt = $this->getBatchStatics();
		$this->assign('detail', $batchSt['currentBatchData']);
		$this->assign('staArr', $batchSt);
		$this->display();
	}

	public function ajaxBatchStatics()
	{
		$staArr = $this->getBatchStatics();
		$this->ajaxReturn($staArr);
	}

	/**
	 * getBatchStatics
	 * 获取批次的包装统计
	 * @access public
	 * @return void
	 */
	private function getBatchStatics()
	{
		$batchId = I('get.id');
		$batchId = intval($batchId);
		$currentData = $this->selectTable->find($batchId);
		$detailCount = $this->tableDetail->where('batch_id=' . $batchId)->count();

		$staArr = array();
		$staArr['detailCount'] = $detailCount;
		$staArr['packCount'] = $currentData['number'];
		$staArr['currentBatchData'] = $currentData;
		$staArr['depotInfo'] = session('DEPOT_INFO');
		return $staArr;
	}


	/**
	 * addBatchDetail
	 * 批次中增加产品
	 * @access public
	 * @return void
	 */
	public function addBatchDetail()
	{
		$masterId = I('post.batch_id');
        $packageCode = I('post.package_code');
        //箱号是否存在
        $hasBox = $this->packageDetailTable->where(array('package_code'=>$packageCode))->find();
        if(empty($hasBox)) {
			$this->error('不存在的箱号!');
			return false;
        }

		$tableDetail = $this->tableDetail;
		$masterBatch = $this->selectTable->where('id=' . intval($masterId))->find();
		$detailCount = $tableDetail->where('batch_id=' . intval($masterId))->count();

		$countPro = $masterBatch['number'];
		if ($detailCount == $countPro) {
			$finishData = array(
				'has_packed' => $countPro,
				'status' => '完成',
			);
			$this->selectTable->where('id=' . intval($masterId))->save($finishData);
			$this->error('当前批次已满!');
			return false;
		}
		if (!$tableDetail->create()) {
			$this->error($tableDetail->getError());
			return false;
		}
		//判断是否重复
		$hasPackage = $tableDetail->where(array('package_code' => trim($tableDetail->package_code)))->count();
		if ($hasPackage) {
			$this->error("已出库的箱号");
			return false;
		}
		$tableDetail->createdatetime = date('Y-m-d G:i:s', time());
		$tableDetail->createuser = session(C('USER_AUTH_KEY'));
		$tableDetail->add();


		$detailCount = $tableDetail->where('batch_id=' . intval($masterId))->count();
		if ($detailCount == $countPro) {
			$finishData = array(
				'has_packed' => $countPro,
				'status' => '完成',
			);
			$this->selectTable->where('id=' . intval($masterId))->save($finishData);

			$this->error('当前批次已满!');
			return false;

		} else {
			$this->selectTable->where('id=' . intval($masterId))->setInc('has_packed');
		}

		$this->success('添加成功!');
	}

	/**
	 * ajaxBatchDetail
	 * 获取批次详情
	 * @access public
	 * @return void
	 */
	public function ajaxBatchDetail()
	{
		$batch_id = I('post.batch_id');
		$batchDetail = $this->tableDetail;
		$ret = $batchDetail->where("batch_id = {$batch_id}")->order(array('id' => 'desc'))->select();
		$this->assign('list', $ret);
		$this->display();

	}


	public function getList()
	{

		$product_code = I('get.product_code');
		$customer_id = I('get.customer_id');
		$map = array();
		if (!empty($product_code)) $map['product_num'] = $product_code;
		if (!empty($customer_id)) $map['customer_id'] = $customer_id;
		$count = $this->selectTable->where($map)->count();
		$Page = new Page($count);
		$list = $this->selectTable->where($map)->limit($Page->firstRow, $Page->listRows)->select();
//		echo $this->selectTable->_sql();
		$products = $this->Product->getField('product_code,product_name');
		$customers = $this->Customer->getField('id,name');
		$this->assign('products', $products);
		$this->assign('customers', $customers);
		$this->assign('product_code', $product_code);
		$this->assign('customer_id', $customer_id);
		$this->assign('list', $list);
		$this->assign('page', $Page->show());
		$this->display('list');
	}

	public function detail()
	{
		$id = I('get.id');
		$count = M()->table('package_batch_detail as p')->join('shipment_detail as s on s.package_code=p.package_code')->where(array('s.batch_id' => $id))->count();
		$Page = new Page($count);
		$list = M()->field('p.shape_code,s.*')->table('package_batch_detail as p')->join('shipment_detail as s on s.package_code=p.package_code')->where(array('s.batch_id' => $id))->limit($Page->firstRow, $Page->listRows)->select();
		$admins = M('admin')->getField('id,user_name');
		$this->assign('admins', $admins);
		$this->assign('page', $Page->show());
		$this->assign('list', $list);
		$this->display('shipmentDetail');
	}
}
