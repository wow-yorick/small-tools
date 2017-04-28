<?php
namespace Admin\Controller;
use Think\Controller;
class JkController extends Controller implements datas
{

 
 function getdatas($datas=''){  
    if(!$datas){
      $data=$_POST['json'];
      $gs=$_POST['gs_name'];
      $datas=json_decode($data,true);

  $arrs=array();
  mysql_query("BEGIN");
 foreach($datas as $key=>$val){
  $arr=array();

  $arrs=M("tag_tb")->data(array('tag_num'=>$val['tag_num'],'product_id'=>$val['product_id'],'product_name'=>$val['product_name'],'product_num'=>$val['product_num'],'tag_name'=>$val['tag_name'],'depot_id'=>$val['depot_id'],'depot_code'=>$val['depot_code'],'product_place'=>$val['product_place'],'product_date'=>$val['product_date'],'tag_detail'=>$val['tag_detail'],'create_time'=>$val['create_time'],'admin_id'=>$val['admin_id']))->add();

  $arr1=M("product_batch_tb")->data(array('batch_num'=>$val['batch_num'],'tag_num'=>$val['tag_num'],
    'tag_name'=>$val['tag_name'],'depot_id'=>$val['depot_id'],'product_id'=>$val['product_id'],'number'=>$val['number'],'print_number'=>$val['print_number'],'create_time'=>$val['create_time'],'admin_id'=>$val['admin_id'],'gs_name'=>$gs))->add();
  
 }

      if ($arrs)  {
 
               if($arr1){
               mysql_query("COMMIT");  
                echo "同步成功";
                exit;
               }else{
                mysql_query("ROLLBACK");        
                echo "同步失败";
                exit;     
                }

          } else { 
           mysql_query("ROLLBACK");        
            echo "初始化失败";
            exit;

          }
      //dump($datas);
        }else{
      echo "暂无数据";
       exit;   
        }
    }
}
interface datas{
 function getdatas($datas);
 }   


