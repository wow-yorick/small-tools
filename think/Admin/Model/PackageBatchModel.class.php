<?php
namespace Admin\Model;
use Think\Model;

class PackageBatchModel extends Model {
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
        array('product_num','require','请选择产品!'), 
        array('number','number','请填写数量!'), 
        array('specification','number','请填写规格!'), 
    );

}
