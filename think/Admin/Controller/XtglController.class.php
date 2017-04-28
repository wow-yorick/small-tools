<?php
namespace Admin\Controller;
use Think\Page;
class XtglController extends BaseController 
{
	private $_Batch;
	private $_Tag;
	private $_Depot;
	private $_BatchDetail;
	private $_depotId;

	public function _initialize()
	{
		parent::_initialize();
		$this->_Batch = M('product_batch_tb');
		$this->_Tag = M('tag_tb');
		$this->_Depot = M('depot');
		$this->_BatchDetail = M('product_batch_detail');
		$this->_depotId = session('depot');
	}
	public function index()
	{
		$map = array('depot_id' => $this->_depotId);
		$count = $this->_Batch->where($map)->count();
		$Page = new Page($count);
		$list = M()->table('product_batch_tb as b')->join('tag_tb as t on t.tag_name = b.tag_name')->limit($Page->firstRow, $Page->listRows)->order('b.id desc')->select();
		$this->assign('page', $Page->show());
		$this->assign('list', $list);
		
		$this->display();
	}
	
}
?>	

