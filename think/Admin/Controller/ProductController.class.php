<?php

namespace Admin\Controller;

use Think\Page;

class ProductController extends BaseController
{

	private $Attribute;
	private $Product;
	private $ProductAttributeAccess;
	private $_attributeType;
	private $Depot;

	public function _initialize()
	{
		parent::_initialize();
		$this->Attribute = M('product_attribute');
		$this->Product = M('product');
		$this->ProductAttributeAccess = M('product_attribute_access');
		$this->Depot = M('depot');
		$this->_attributeType = array(
			1 => '文本框',
			2 => '单选框',
			3 => '复选框',
		);
	}

	public function productList()
	{
		$product_name = strtoupper(trim(I('get.product_name')));
		$product_code = I('get.product_code');
		$map = array('depot_id' => session('depot'));
		if (!empty($product_name)) $map['product_name'] = array('like', "%{$product_name}%");
		if (!empty($product_code)) $map['product_code'] = array('like', "%{$product_code}%");
		$count = $this->Product->where($map)->count();
		$Page = new Page($count);
		$list = $this->Product->where($map)->limit($Page->firstRow, $Page->listRows)->order(array('id'=>'desc'))->select();
		$this->assign('product_name',$product_name);
		$this->assign('product_code',$product_code);
		$this->assign('list', $list);
		$this->assign('page', $Page->show());
		$this->display('productList');
	}

	public function productAdd()
	{
		if (IS_POST) {
			$product_name = I('post.product_name');
			$remark = I('post.remark');
			if (empty($product_name)) $this->error('请填写商品名称');
			$data = array(
				'product_name' => $product_name,
				'product_code' => auto_genera_num('product', 'ANSA', 6),
				'remark' => $remark,
				'depot_id' => session('depot'),
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY'))
			);
			$id = $this->Product->data($data)->add();
			$this->_productAccess($id, I('post.'));
			$this->success("添加商品成功");
			die;
		}
		$attributeList = S('attributeList');
		if (empty($attributeList)) {
			$attributeList = $this->Attribute->field(array('id', 'type', 'attribute_name', 'default_value'))->select();
			foreach ($attributeList as $k => $value) {
				$attributeList[$k]['default_value'] = explode(',', $value['default_value']);
			}
			S('attributeList', $attributeList);
		}

		//获取仓库名称
		$depots = $this->Depot->getField('id,depot_name');
		$this->assign('depot', session('depot'));
		$this->assign('depots', $depots);
		$this->assign('attributeList', $attributeList);
		$this->display('productAdd');
	}

	public function productEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$product_name = I('post.product_name');
			$remark = I('post.remark');
			if (empty($id)) $this->error('请填写商品ID');
			if (empty($product_name)) $this->error('请填写商品名称');
			$data = array(
				'product_name' => $product_name,
				'remark' => $remark,
				'depot_id' => session('depot'),
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY'))
			);
			$this->Product->data($data)->where(array('id' => $id))->save();
			$this->_productAccess($id, I('post.'));
			$this->success("编辑商品成功");
			die;
		}
		$attributeList = S('attributeList');
		if (empty($attributeList)) {
			$attributeList = $this->Attribute->field(array('id', 'type', 'attribute_name', 'default_value'))->select();
			foreach ($attributeList as $k => $value) {
				$attributeList[$k]['default_value'] = explode(',', $value['default_value']);
			}
			S('attributeList', $attributeList);
		}
		$id = I('get.id');
		$product = $this->Product->where(array('id' => $id))->find();
		$access = $this->ProductAttributeAccess->where(array('product_id' => $id))->getField('product_attribute_id,attribute_value');
		//获取仓库名称
		$depots = $this->Depot->getField('id,depot_name');
		$this->assign('depot', session('depot'));
		$this->assign('depots', $depots);
		$this->assign('product', $product);
		$this->assign('access', $access);
		$this->assign('attributeList', $attributeList);
		$this->display('productEdit');
	}

	public function attributeList()
	{
		$map = array();
		$count = $this->Attribute->where($map)->count();
		$Page = new Page($count);
		$list = $this->Attribute->where($map)->limit($Page->firstRow, $Page->listRows)->select();
		$this->assign('list', $list);
		$this->assign('attributeType', $this->_attributeType);
		$this->assign('page', $Page->show());
		$this->display('attributeList');
	}


	public function attributeAdd()
	{
		if (IS_POST) {
			$attribute_name = I('post.attribute_name');
			$remark = I('post.remark');
			$type = I('post.type');
			$default_value = trim(I('post.default_value'));
			if (empty($attribute_name)) $this->error('请填写属性名称');
			if (empty($type)) $this->error('请选择属性类型');
			if ($type != 1 && empty($default_value)) $this->error('请填写属性选项值');
			$attribute = $this->Attribute->where(array("attribute_name" => $attribute_name))->find();
			if (!empty($attribute)) $this->error('该属性已存在');

			$data = array(
				'attribute_name' => $attribute_name,
				'type' => $type,
				'default_value' => preg_replace('/,+/', ',', str_replace(array("\r\n", "\r", "\n"), ",", $default_value)),
				'remark' => $remark,
				'status' => 1,
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY')),
			);
			$this->Attribute->data($data)->add();
			S('attributeList', null);
			$this->success('添加属性成功');
			die;
		}
		$this->assign('attributeType', $this->_attributeType);
		$this->display('attributeAdd');
	}

	public function attributeEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$attribute_name = I('post.attribute_name');
			$remark = I('post.remark');
			$type = I('post.type');
			$default_value = trim(I('post.default_value'));
			if (empty($attribute_name)) $this->error('请填写属性名称');
			if (empty($type)) $this->error('请选择属性类型');
			if ($type != 1 && empty($default_value)) $this->error('请填写属性选项值');
			$attribute = $this->Attribute->where(array("attribute_name" => $attribute_name, 'id' => array('neq', $id)))->find();
			if (!empty($attribute)) $this->error('该属性已存在');
			$data = array(
				'attribute_name' => $attribute_name,
				'type' => $type,
				'default_value' => preg_replace('/,+/', ',', str_replace(array("\r\n", "\r", "\n"), ",", $default_value)),
				'remark' => $remark,
				'status' => 1,
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY')),
			);
			$this->Attribute->data($data)->where(array('id' => $id))->save();
			S('attributeList', null);
			$this->success('更新属性成功');
			die;
		}
		$id = I('get.id');
		$attribute = $this->Attribute->where(array('id' => $id))->find();
		$this->assign('attributeType', $this->_attributeType);
		$this->assign('attribute', $attribute);
		$this->display('attributeEdit');
	}


	public function unitList()
	{
		$list = $this->Unit->select();
		$this->assign('list', $list);
		$this->display();
	}

	public function unitAdd()
	{
		if (IS_POST) {
			$name = I('post.name');
			$remark = I('post.remark');
			if (empty($name)) $this->error('请填写单位名称');
			if (empty($remark)) $this->error('请填写单位描述');
			//检验名称唯一
			$unit = $this->Unit->where(array('name' => $name))->find();
			if (!empty($unit)) $this->error('该单位名称已存在');
			$data = array(
				'name' => $name,
				'remark' => $remark,
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY'))
			);
			$this->Unit->data($data)->add();
			$this->success('添加单位成功');
			die;
		}
		$this->display('unitAdd');
	}

	public function unitEdit()
	{
		if (IS_POST) {
			$id = I('post.id');
			$name = I('post.name');
			$remark = I('post.remark');
			if (empty($name)) $this->error('请填写单位名称');
			if (empty($remark)) $this->error('请填写单位描述');
			//检验名称唯一
			$unit = $this->Unit->where(array('name' => $name, 'id' => array('neq', $id)))->find();
			if (!empty($unit)) $this->error('该单位名称已存在');
			$data = array(
				'name' => $name,
				'remark' => $remark,
				'create_time' => date('Y-m-d H:i:s'),
				'admin_id' => session(C('USER_AUTH_KEY'))
			);
			$this->Unit->data($data)->where(array('id' => $id))->save();
			$this->success('修改单位成功');
			die;
		}
		$id = I('get.id');
		$unit = $this->Unit->where(array('id' => $id))->find();
		$this->assign('unit', $unit);
		$this->display('unitEdit');
	}

	private function _productAccess($product_id, $data)
	{
		$filter = array('product_name', 'remark', 'product_code');
		$insert = array();
		foreach ($data as $k => $val) {
			if (empty($val) || in_array($k, $filter)) continue;
			$k = str_replace('attribute_', '', $k);
			$insert[] = $k;
		}
		$inhere = $this->ProductAttributeAccess->where(array('product_id' => $product_id))->getField('product_attribute_id', true);
		$inhere = empty($inhere) ? array() : $inhere;
		$insert_data = array_diff($insert, $inhere);
		$del_data = array_diff($inhere, $insert);
		$update_data = array_intersect($insert, $inhere);
		$admin_id = session(C('USER_AUTH_KEY'));
		$create_time = date("Y-m-d H:i:s");
		if (!empty($insert_data)) {
			foreach ($insert_data as $k) {
				$val = I("post.attribute_{$k}");
				$data = array(
					'product_id' => $product_id,
					'product_attribute_id' => $k,
					'attribute_value' => is_array($val) ? implode(',', $val) : $val,
					'create_time' => $create_time,
					'admin_id' => $admin_id
				);
				$this->ProductAttributeAccess->data($data)->add();
			}

		}
		if (!empty($update_data)) {
			foreach ($update_data as $k) {
				$val = I("post.attribute_{$k}");
				$data = array(
					'attribute_value' => is_array($val) ? implode(',', $val) : $val,
					'create_time' => $create_time,
					'admin_id' => $admin_id
				);
				$map = array(
					'product_id' => $product_id,
					'product_attribute_id' => $k
				);
				$this->ProductAttributeAccess->data($data)->where($map)->save();
			}
		}


		if (!empty($del_data)) {
			$map = array(
				'product_id' => $product_id,
				'product_attribute_id' => array('in', $del_data)
			);
			$this->ProductAttributeAccess->where($map)->delete();
		}

	}
}
