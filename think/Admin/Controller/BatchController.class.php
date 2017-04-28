<?php

namespace Admin\Controller;

use Think\Log;
use Think\Page;

class BatchController extends BaseController
{

	private $_Batch;
	private $_Tag;
	private $_Depot;
	private $_BatchDetail;
	private $_depotId;

	public function _initialize()
	{
		parent::_initialize();
		$this->_Batch = M('product_batch');
		$this->_Tag = M('tag');
		$this->_Depot = M('depot');
		$this->_BatchDetail = M('product_batch_detail');
		$this->_depotId = session('depot');
	}

	public function index()
	{
		$map = array('depot_id' => $this->_depotId);
		$count = $this->_Batch->where($map)->count();
		$Page = new Page($count);
		$list = M()->table('product_batch as b')->join('tag as t on t.id = b.tag_id')->where(array('b.depot_id' => $this->_depotId))->limit($Page->firstRow, $Page->listRows)->field('b.id as bid,t.id as tid, batch_num,product_name, tag_name, product_place, product_date,number,print_number')->order('b.id desc')->select();
		$this->assign('page', $Page->show());
		$this->assign('list', $list);
//		dump($list);
		$this->display();
	}

	public function add()
	{
		if (IS_AJAX) {
			set_time_limit(0);
			$tag_num = I('post.tag_num');
			$number = I('post.number');
            $product_date = I('post.product_date');
			if (empty($tag_num))
				$this->error('请选择标签模板');
			if (empty($tag_num))
				$this->error('请填写生产日期');
			if (empty($number))
				$this->error('请填写打印数量');
			//获取模板ID
			$tag = $this->_Tag->where(array('tag_num' => $tag_num))->find();
			if (empty($tag))
				$this->error("对应模板不存在");
			if ($tag['depot_id'] != $this->_depotId)
				$this->error("该模板您无法使用");

			$depot = $this->_Depot->where(array('id' => $this->_depotId))->find();
			$this->_Depot->where(array('id' => $this->_depotId))->setInc('batch_num');
			$this->_Depot->where(array('id' => $this->_depotId))->setInc('bill_num', $number);
			$next_id = empty($depot['batch_num']) ? 1 : $depot['batch_num'] + 1;
			$data = array(
				'batch_num' => $depot['depot_code'] . str_pad($next_id, 9, '0', STR_PAD_LEFT),
				'tag_id' => $tag['id'],
				'depot_id' => $this->_depotId,
				'product_id' => $tag['product_id'],
				'number' => $number,
				'print_number' => 0,
                'printstatus' =>0,
				'create_time' => date("Y-m-d H:i:s"),
				'admin_id' => session('id'),
			);
			$batch_id = $this->_Batch->data($data)->add();
			for ($i = 1; $i <= $number; $i++) {
				$next_id = $depot['bill_num'] + $i;
                $bill_num = $depot['depot_code'] . str_pad($next_id, 9, '0', STR_PAD_LEFT);

				$detail_data[] = array(
					'batch_id' => $batch_id,
                    'product_date' => $product_date,
					'create_time' => date('Y-m-d H:i:s'),
					'admin_id' => session('id'),
					'bill_num' => $bill_num,
                    'qrcode' => U('Front/index',array('code'=>$bill_num), false,true),
				);
				if ($i % 500 == 0 || $i == $number) {
					$this->_BatchDetail->addAll($detail_data);
					$detail_data = array();
				}
			}
			$this->success('添加成功');
			die;
		}
		$tags = $this->_Tag->where(array('depot_id' => $this->_depotId))->select();
		$this->assign('tags', $tags);
		$this->display();
	}

	public function detail()
	{
		$batch_num = I('get.batch_num');
		$batch_id = $this->_Batch->where(array('batch_num' => $batch_num))->getField('id');
		$count = $this->_BatchDetail->where(array('batch_id'=>$batch_id))->count();
		$Page = new Page($count);
		$list =  $this->_BatchDetail->where(array('batch_id'=>$batch_id))->limit($Page->firstRow,$Page->listRows)->select();
		$this->assign('page', $Page->show());
		$this->assign('list', $list);
//		dump($list);
		$this->display();
	}

    public function printb()
    {
        $batchId = I('get.id');
        $batchId = intval($batchId);
        $batch = M('product_batch')->where(array('id' =>$batchId))->find();
        $tag = M('tag')->where(array('id' =>$batch['tag_id']))->find();

        $detail = array();
        $detail['tag_num'] = $tag['tag_num'];
        $detail['batch_id'] = $batchId;
        $this->assign('detail', $detail);
		$this->display();
    }

    /**
     * ajaxUpdatePrintStatus 
     * 打印状态更新
     * @access public
     * @return void
     */
    public function ajaxUpdatePrintStatus()
    {
        $batchId = I('post.batchId');
        $batchId = intval($batchId);
        if(!$batchId) {
            $this->error('未获取到批次号!');
            return false;
        }
        try {
            $batchDetailCount = $this->_BatchDetail->where(array('batch_id'=>$batchId))->count();
            
            $this->_BatchDetail->where(array('batch_id'=>$batchId))->save(array('printstatus'=>1,'update_time'=>date('Y-m-d G:i:s', time())));
            $this->_Batch->where(array('id'=>$batchId))->save(array('print_number'=>$batchDetailCount));
        } catch(Exception $e) {
            $this->error("打印状态更新失败!");
        }
        $this->success("更新成功!");

    }

}
