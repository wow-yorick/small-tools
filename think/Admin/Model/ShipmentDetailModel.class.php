<?php
namespace Admin\Model;
use Think\Model;

class ShipmentDetailModel extends Model {
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
        array('package_code','require','箱编号不能为空!'), 
    );

}
