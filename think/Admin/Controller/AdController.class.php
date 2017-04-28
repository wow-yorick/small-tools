<?php

namespace Admin\Controller;

use Think\Page;

class AdController extends BaseController 
{

    public function _initialize()
    {
        $this->selectTable = D('Ad');
    }

    public function index()
    {
        $this->display();
    }

    protected function setUpload() {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     3145728 ;// 设置附件上传大小
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath  =     APP_PATH.'Upload/'; // 设置附件上传目录
        // 上传文件 
        $info   =   $upload->upload();
        if(!$info) {// 上传错误提示错误信息
            //$this->error($upload->getError());
        }else{// 上传成功
            $this->selectTable->ad_1 = 'Upload/'.$info['ad_1']['savepath'].$info['ad_1']['savename'];
            $this->selectTable->ad_1_filename = $info['ad_1']['savename'];
            $this->selectTable->ad_2 = 'Upload/'.$info['ad_2']['savepath'].$info['ad_2']['savename'];
            $this->selectTable->ad_2_filename = $info['ad_2']['savename'];
        }
        if('是' == $this->selectTable->is_show) {
            $this->selectTable->where(array())->save(array('is_show'=>'否'));//其他的都设为否
        }

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
                return false;
            }
            $this->selectTable->createdatetime = date('Y-m-d G:i:s', time());
            $this->selectTable->createuser = session(C('USER_AUTH_KEY'));
            $this->setUpload();
            $this->selectTable->add();
            $this->success('添加成功!');
            die;
        }
        $this->display('detail');
    }

    /**
     * edit 
     * 修改
     * @access protected
     * @return void
     */
    public function edit()
    {
        $this->_beforAct();
        if (!IS_POST) {
            $id = I('get.id');
            if (empty($id)) $this->redirect('add');
            $detail = $this->selectTable->where('id = '.$id)->find();
            $this->assign('detail', $detail);
            $this->display('detail');
            return true;
        }
        if(!$this->selectTable->create()) {
            $this->error($this->selectTable->getError());
            return false;
        }
        $this->selectTable->modifydatetime = date('Y-m-d G:i:s', time());
        $this->selectTable->modifyuser = session(C('USER_AUTH_KEY'));

        $this->setUpload();
        $ret = $this->selectTable->save();
        if($ret === false) {
            $this->error('更新失败!');
        } else {
            $this->success('更新成功!');
        }
    }
}
