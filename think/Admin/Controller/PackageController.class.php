<?php

namespace Admin\Controller;

use Think\Page;

class PackageController extends BaseController
{
    protected $selectTable;

    public function _initialize()
    {
        parent::_initialize();

        $this->selectTable = D('PackageBatch');

        $this->tableDetail = D('PackageBatchDetail');

		$this->Product = M('product');
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
            if(!$this->selectTable->create()) {
                $this->error($this->selectTable->getError());
            }
            $depotCode = session('DEPOT_CODE');
            $this->selectTable->batch_num = auto_genera_num($this->selectTable, $depotCode, 9);
            $this->selectTable->createdatetime = date('Y-m-d G:i:s', time());
            $this->selectTable->createuser = session(C('USER_AUTH_KEY'));
            $this->selectTable->add();
			$this->success('添加成功!');
			die;
		}
        $productList = $this->Product->field(array('id','product_name','product_code'))->select();
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
        $inActBatchList = $this->selectTable->where(array('status'=>array('neq','完成')))->order(array('id'=>'desc'))->select();
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
        $upRet = $this->selectTable->where($search)->save(array('current_batch' =>1,'status'=>'处理'));
        if(!$upRet) {
            $retMap['msg'] = '设置当前批次失败!';
            $this->ajaxReturn($retMap);
        }
        $searchOther = array(
            'status' => array('neq' , '完成'),
            'id' => array('neq', $batchId),
        );
        $upOtherRet = $this->selectTable->where($searchOther)->save(array('current_batch' =>0,'status'=>'进行中'));
        if(!$upOtherRet) {
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
        $detailCount  = $this->tableDetail->where('batch_id='.$batchId)->count();

        $staArr = array();
        $staArr['proCount'] = $currentData['number'] * $currentData['specification'];
        $staArr['detailCount'] = $detailCount;
        $staArr['packCount'] = $currentData['number'];
        $staArr['specification'] = $currentData['specification'];
        $staArr['hasPack'] = floor($detailCount/$currentData['specification']);
        $staArr['subCount'] = $detailCount - $staArr['hasPack']* $currentData['specification'];
        $staArr['currentBatchData'] = $currentData;
        $staArr['batchId'] = $batchId;
        if($detailCount) {
            $staArr['printFlag'] = (0 == $detailCount%$staArr['specification']) ? 1 : 0;
        } else {
            $staArr['printFlag'] = 0;
        }
        $staArr['currentBoxNum'] = $this->tableDetail->where('batch_id='.$batchId)->max('package_code');
        session('currentBoxNum', $staArr['currentBoxNum']);
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
        $tableDetail = $this->tableDetail;
        $masterBatch = $this->selectTable->where('id='.intval($masterId))->find();
        $detailCount = $tableDetail->where('batch_id='.intval($masterId))->count();

        $countPro = $masterBatch['number'] * $masterBatch['specification'];
        if($detailCount == $countPro) {
            $finishData = array(
                'has_packed'=>$countPro,
                'status'=>'完成',
            );
            $this->selectTable->where('id='.intval($masterId))->save($finishData);
            $this->error('当前批次已满!');
            return false;
        }
        if(!$tableDetail->create()) {
            $this->error($tableDetail->getError());
            return false;
        }
        //判断是否重复
        $hasProduct = $tableDetail->where(array('shape_code'=>trim($tableDetail->shape_code)))->count();
        if($hasProduct) {
            $this->error("已包装此产品");
            return false;
        }
        //判断第几箱(生成箱号)
        $packageNum = ceil(($detailCount+1)/$masterBatch['specification']);
        if(0 == $packageNum) {
            $packageNum = 1;
        } elseif($packageNum >= $masterBatch['number']) {
            $packageNum = $masterBatch['number'];
        }
        $packageCode = $masterBatch['batch_num'].str_pad($packageNum, 3, '0',STR_PAD_LEFT);

        $tableDetail->package_code = $packageCode;
        $tableDetail->createdatetime = date('Y-m-d G:i:s', time());
        $tableDetail->createuser = session(C('USER_AUTH_KEY'));
        $tableDetail->add();


        $detailCount = $tableDetail->where('batch_id='.intval($masterId))->count();
        if($detailCount == $countPro) {
            $finishData = array(
                'has_packed'=>$countPro,
                'status'=>'完成',
            );
            $this->selectTable->where('id='.intval($masterId))->save($finishData);

            $this->error('当前批次已满!');
            return false;

        } else {
            $this->selectTable->where('id='.intval($masterId))->setInc('has_packed');
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
        $batchDetail = M('package_batch_detail');
        $ret = $batchDetail->where("batch_id = {$batch_id}")->order(array('id'=>'desc'))->select();
        $this->assign('list', $ret);
        $this->display();

    }

	public function getList()
	{
		$product_name = I('get.product_name');
		$product_num = I('get.product_num');
		$map = array();
		if (!empty($product_name)) $map['product_name'] = array('like', "%{$product_name}%");
		if (!empty($product_num)) $map['product_num'] = array('like', "%{$product_num}%");
		$count = $this->selectTable->where($map)->count();
		$Page = new Page($count);
		$list = $this->selectTable->where($map)->limit($Page->firstRow, $Page->listRows)->select();

		$admins = M('admin')->getField('id,user_name');
		$this->assign('admins', $admins);
		$this->assign('product_name', $product_name);
		$this->assign('product_num', $product_num);
		$this->assign('list', $list);
		$this->assign('page', $Page->show());
		$this->display('getList');
	}

	public function detail()
	{
		$id = I('get.id');
		$count = $this->tableDetail->where(array('batch_id' => $id))->count();
		$Page = new Page($count);
		$list = $this->tableDetail->where(array('batch_id' => $id))->limit($Page->firstRow, $Page->listRows)->select();
		$admins = M('admin')->getField('id,user_name');
		$this->assign('admins', $admins);
		$this->assign('page', $Page->show());
		$this->assign('list', $list);
		$this->display('batchDetail');
	}

    /**
     * batchDetailDel 
     * 扫码错误移出产品
     * @access public
     * @return void
     */
    public function batchDetailDel()
    {
        $id = I('get.id');
		if (empty($id)) $this->error('ID不能为空');;
        $delData = $this->tableDetail->where(array('id' => $id))->find();
        if(!$delData) {
            $this->error('数据不存在!');
            return false;
        }
        if (!$this->tableDetail->where(array('id' => $id))->delete()) {
            $this->error('删除失败');
            return false;
        } 
        $this->selectTable->where(array('id'=>$delData['batch_id']))->setDec('has_packed', 1);
        $this->success('删除成功');
    }
}
