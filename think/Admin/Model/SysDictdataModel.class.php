<?php
namespace Admin\Model;
use Think\Model;

class SysDictdataModel extends Model {
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
        array('seq','number','类型序号必须为数字!'), 
        array('name','require','类型必须!'), 
        array('value','require','类型值必须!'), 
        array('type','require','分类必须!'), 
    );

}
