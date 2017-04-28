<?php
namespace Admin\Model;
use Think\Model;

class ShipmentModel extends Model {
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
        array('customer_id','require','请选择客户!'), 
        array('number','number','请填写数量!'), 
    );

}
