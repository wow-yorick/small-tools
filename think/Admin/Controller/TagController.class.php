<?php

namespace Admin\Controller;

use Think\Page;

class TagController extends BaseController
{

	private $Tag;
	private $_jaToolsUrl;

	public function _initialize()
	{
		parent::_initialize();
		$this->Tag = M('Tag');
		$this->Product = M('product');
		$this->Depot = M('depot');
		$this->_jaToolsUrl = get_domain().':8080/MR/mireport/designer/r.jsp?report={{TAG_CODE}}&ds=tagbzd';
	}

	public function tagList()
	{
		$tag_name = I('get.tag_name');
		$tag_num = I('get.tag_num');
		$product_name = I('get.product_name');
		$product_num = I('get.product_num');
		$product_place = I('get.product_place');
		$batch_num = I('get.batch_num');
		$start_date = I('get.start_date');
		$end_date = I('get.end_date');
		$map = array();
		if (!empty($tag_name))
			$map['tag_name'] = array('like', "%{$tag_name}%");
		if (!empty($tag_num))
			$map['tag_num'] = array('like', "%{$tag_num}%");
		if (!empty($product_name))
			$map['product_name'] = array('like', "%{$product_name}%");
		if (!empty($product_num))
			$map['product_num'] = array('like', "%{$product_num}%");
		if (!empty($product_place))
			$map['product_place'] = array('like', "%{$product_place}%");
		if (!empty($batch_num))
			$map['batch_num'] = array('like', "%{$batch_num}%");
		if (!empty($start_date))
			$map['product_date'][] = array('egt', "{$start_date}");
		if (!empty($end_date))
			$map['product_date'][] = array('elt', "{$end_date}");
		$count = $this->Tag->where($map)->count();
		$Page = new Page($count);
		$list = $this->Tag->where($map)->limit($Page->firstRow, $Page->listRows)->order('id desc')->select();
		$this->assign('tag_name', $tag_name);
		$this->assign('tag_num', $tag_num);
		$this->assign('product_name', $product_name);
		$this->assign('product_num', $product_num);
		$this->assign('product_place', $product_place);
		$this->assign('batch_num', $batch_num);
		$this->assign('start_date', $start_date);
		$this->assign('end_date', $end_date);
		$this->assign('list', $list);
		$this->assign('page', $Page->show());
		$this->display('tagList');
	}

	public function tagAdd()
	{
		if (IS_POST) {
			$product_name = I('post.product_name');
			$product_num = I('post.product_num');
			$product_id = I('post.product_id');
			$tag_name = I('post.tag_name');
			$product_place = I('post.product_place');
			$tag_detail = I('post.tag_detail');
			$depot_code = I('post.depot_code');
			$depot_code = empty($depot_code) ? session('DEPOT_CODE') : $depot_code;
            $depot = $this->Depot->where(array('depot_code'=>$depot_code,'status'=>1))->find();
			if (empty($product_name))
				$this->error('商品名称不能为空');
			if (empty($product_num))
				$this->error('商品编号不能为空');
			if (empty($tag_name))
				$this->error('标签名称不能为空');
			if (empty($product_place))
				$this->error('商品生产地不能为空');
			$data = array(
				'tag_num' => auto_genera_num('tag', $depot_code, 10),
				'product_name' => $product_name,
				'product_num' => $product_num,
				'product_id' => $product_id,
				'tag_name' => $tag_name,
				'product_place' => $product_place,
				'depot_code' => $depot_code,
                'depot_id' => $depot['id'],
				'product_date' => date('Y-m-d G:i:s'),
				'tag_detail' => $tag_detail,
				'depot_id'=>session('DEPOT'),
				'create_time' => date("Y-m-d"),
				'admin_id' => session(C('USER_AUTH_KEY'))
			);
			if ($this->Tag->data($data)->add()) {
                $copyFrom = I('post.template_copy_from');
                $data['tag_num'] = trim($data['tag_num']);
                if(!empty($copyFrom)) {
                    $copyAipUrl = get_domain().":8080/MR/mireport/service/reportService.jsp";
                    $queryParams = array(
                        'how'=>'copy',
                        'from'=>$copyFrom,
                        'to'=>$data['tag_num'],
                    );
                    $httpstr = http($copyAipUrl, $queryParams, 'GET');
                    if(!$httpstr) {
                        $this->error('复制模板失败:'.$copyAipUrl);
                    }
                    $httpstr = json_decode($httpstr, true);
                    if(!$httpstr['success']) {
                        $this->error('复制模板失败:'.$copyAipUrl);
                    }
                }
				$url = str_replace("{{TAG_CODE}}", $data['tag_num'], $this->_jaToolsUrl);
                $url .= '&tmp='.time();
				$this->success("修改成功", $url);
			}
			$this->error('添加失败');
			die;
		}
		$productList = $this->Product->field(array('id', 'product_name', 'product_code'))->where(array('depot_id' => session('depot')))->select();
		$this->assign('productList', $productList);
		$depotList = $this->Depot->field(array('depot_code','depot_address', 'depot_name'))->select();
		$this->assign('depotList', $depotList);
		$this->assign('depot_code', session('DEPOT_CODE'));

        $copyTemplateList = $this->Tag->where(array())->field(array('id','depot_code','tag_name','product_name','tag_num'))->select();
		$this->assign('copyTemplateList', $copyTemplateList);
		$this->display('tagAdd');
	}

	public function tagEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$product_name = I('post.product_name');
			$product_num = I('post.product_num');
			$product_id = I('post.product_id');
			$tag_name = I('post.tag_name');
			$product_place = I('post.product_place');
			$tag_detail = I('post.tag_detail');
			$depot_code = I('post.depot_code');
			$depot_code = empty($depot_code) ? session('DEPOT_CODE') : $depot_code;
            $depot = $this->Depot->where(array('depot_code'=>$depot_code,'status'=>1))->find();
			if (empty($id))
				$this->error('标签ID不能为空');
			if (empty($tag_name))
				$this->error('标签名称不能为空');
			if (empty($product_name))
				$this->error('商品名称不能为空');
			if (empty($product_num))
				$this->error('商品编号不能为空');

			$data = array(
				'product_id'=>$product_id,
				'product_name' => $product_name,
				'product_num' => $product_num,
				'tag_name' => $tag_name,
				'product_place' => $product_place,
				'product_date' => date('Y-m-d G:i:s'),
				'depot_code' => $depot_code,
                'depot_id' => $depot['id'],
				'tag_detail' => $tag_detail,
				'create_time' => date("Y-m-d H:i:s", time()),
				'admin_id' => session(C('USER_AUTH_KEY'))
			);
			if (false == $this->Tag->data($data)->where(array('id' => $id))->save())
				$this->error('修改失败');
			$tag_num = $this->Tag->where(array('id' => $id))->getField("tag_num");
			$url = str_replace("{{TAG_CODE}}", $tag_num, $this->_jaToolsUrl);
            $url .= '&rand='.rand(10,100);
			$this->success("修改成功", $url);
			die;
		}
		$id = I('get.id');
		$tag = $this->Tag->where(array('id' => $id))->find();
		$this->assign('tag', $tag);
		$productList = $this->Product->field(array('id', 'product_name', 'product_code'))->where(array('depot_id' => session('depot')))->select();
		$depotList = $this->Depot->field(array('depot_code', 'depot_address','depot_name'))->select();
		$this->assign('productList', $productList);
		$this->assign('depotList', $depotList);
		$this->assign('depot_code', session('DEPOT_CODE'));
		$this->display('tagEdit');
	}

}
