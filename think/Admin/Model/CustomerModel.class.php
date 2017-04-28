<?php
namespace Admin\Model;
use Think\Model;

class CustomerDetailModel extends Model {
    protected $_scope = array(
        // 命名范围normal
        'normal'=>array(
            'where'=>array('status'=>1),
        ),
        // 命名范围latest
        'latest'=>array(
            'order'=>'createdatetime DESC',
            'limit'=>10,
        ),
    );

    protected $_validate = array(
        array('name','require','客户姓名不能为空!'), 
        array('mobile','require','客户手机不能为空!'), 
        array('address','require','客户联系地址不能为空!'), 
    );

}
