<?php

namespace Admin\Controller;

use Think\Controller;

class APIClientController extends Controller
{
	public function _initialize()
	{
	}

    /**
     * tagSync 
     * 标签同步
     * @access public
     * @return void
     */
    public function tagSync()
    {
        $retMap = array();
        try{
            $tagTable = M('Tag');
            $depotCode = C('DEPOT_CODE');
            $tagList = $tagTable->where(array('depot_code'=>$depotCode))->select();
            foreach($tagList as &$tag) {
                unset($tag['id']);
                $tag['tag_num'] = empty($tag['tag_num']) ? '' : $tag['tag_num'];
                $tag['product_id'] = empty($tag['product_id']) ? 0 : intval($tag['product_id']);
                $tag['product_name'] = empty($tag['product_name']) ? '' : $tag['product_name'];
                $tag['product_num'] = empty($tag['product_num']) ? '' : $tag['product_num'];
                $tag['tag_name'] = empty($tag['tag_name']) ? '' : $tag['tag_name'];
                $tag['depot_id'] = empty($tag['depot_id']) ? 0 : intval($tag['depot_id']);
                $tag['depot_code'] = empty($tag['depot_code']) ? '' : $tag['depot_code'];
                $tag['product_place'] = empty($tag['product_place']) ? '' : $tag['product_place'];
                $tag['product_date'] = empty($tag['product_date']) ? date('Y-m-d',time()) : $tag['product_date'];
                $tag['tag_detail'] = empty($tag['tag_detail']) ? '' : $tag['tag_detail'];
                $tag['create_time'] = empty($tag['create_time']) ? date('Y-m-d G:i:s',time()) : $tag['create_time'];
                $tag['admin_id'] = empty($tag['admin_id']) ? 0 : intval($tag['admin_id']);
            }

            if(empty($tagList)) {
                $tagList = array();
            }

            $retMap = array(
                'datalist' => $tagList,
                'depot-code' => $depotCode,
                'success' => true,
            );

            $url = C('SERVER_API_URL').'/tagSync';
            $httpstr = http($url, $retMap, 'POST');
            $httpstr = json_decode($httpstr, true);
            if(!$httpstr['success']) {
                die('同步失败!');
            }
            foreach($httpstr['datalist'] as $tag) {
                //$tagSearch = array('depot_code'=>array('neq'=>$depotCode),'tag_num' => $tag['tag_num']);
                $tagSearch = "depot_code != '{$depotCode}' and tag_num = '{$tag['tag_num']}'";
                $has = $tagTable->where($tagSearch)->count();
                if($has) {
                    $tagTable->where($tagSearch)->save($tag);
                } else {
                    $tagTable->add($tag);
                }
            }

        } catch(Exception $e) {
            echo $e->getMessage();
            return false;
        }
        echo '同步成功!';

    }

}
