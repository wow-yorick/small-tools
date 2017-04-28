<?php
namespace Admin\Model;
use Think\Model;

class PackageBatchDetailModel extends Model {
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
        array('product_num','require','产品编号不能为空!'), 
        array('shape_code','8,35','产品条码位数不符!',3,'length'), 
    );

}
