<?php
namespace Admin\Model;
use Think\Model;

class AdModel extends Model {
    protected $_scope = array(
        // 命名范围normal
        'normal'=>array(
            'where'=>array('status'=>1),
        ),
        // 命名范围latest
        'latest'=>array(
            'order'=>'create_time DESC',
            'limit'=>10,
        ),
    );

    protected $_validate = array(
        array('name','require','广告名称必须!'), 
        array('ad_1_filename','require','广告A必须!'), 
        array('ad_2_filename','require','广告B必须!'), 
        array('is_show','require','是否展示必须!'), 
    );

}
