<?php

namespace Admin\Controller;

use Think\Page;

class PrintController extends BaseController
{

    public function _initialize()
    {
        $this->tagTable =  D('Tag');
        $this->packageTable = D('PackageBatch');
        $this->selectTable = D('PrintHistory');
        $this->tmpPackagePrintTable = D('TmpPackagePrint');
        $this->designerUrl = get_domain().":8080/MR/mireport/service/buildPage.jsp?report={{TAG_CODE}}&ds=tagpackage&package_num={{PACKAGE_NUM}}";
    }

    /**
     * printOperate 
     * 打印操作界面
     * @access public
     * @return void
     */
    public function printOperate()
    {
        $batchId = I('get.batchId');
        $currentBatch = $this->packageTable->where(array('id'=> intval($batchId)))->find();
        if(!$currentBatch) {
            die('获取当前批次失败!请重试!');
        }
        $depotCode = session('DEPOT_CODE');
        $tagList = $this->tagTable->where('tag_name like "箱标签_%" and depot_code="'.$depotCode.'"')->select();
        $seltSearch = array(
            'product_num' =>$currentBatch['product_num'],
            'depot_code' => $depotCode,
        );
        $selectTag = $this->tagTable->where($seltSearch)->find();
        $this->assign('tagList', $tagList);
        $this->assign('currentBatch', $currentBatch);
        $this->assign('detail', $selectTag);

        $currentBoxNum = session('currentBoxNum');
        $this->assign('currentBoxNum', $currentBoxNum);
        $this->display();
    }

    /**
     * view 
     * 打印预览
     * @access public
     * @return void
     */
    public function view()
    {
        $ret = $this->prepareData();
        $url = $this->getDesignerUrl($ret);

        $this->success($url);
        //$ret = $this->showAct();
        //$this->assign('print', 0);
        //$this->display('printView');
    }

    private function getDesignerUrl($ret) {
        $url = str_replace("{{TAG_CODE}}", $ret['tag']['tag_num'], $this->designerUrl);
        $url = str_replace("{{PACKAGE_NUM}}", $ret['currentBoxNum'], $url);
        return $url;
    }

    /**
     * printView 
     * 打印页面
     * @access public
     * @return void
     */
    public function printView()
    {
        $ret = $this->prepareData();
        $this->historyMark($ret['tag'], $ret['productDate'], $ret['currentBatch'], $ret['pages']);
        $url = $this->getDesignerUrl($ret);
        $this->success($url);

        //$ret = $this->showAct();
        //$this->historyMark($ret['tag'], $ret['productDate'], $ret['currentBatch'], $ret['pages']);
        //$this->assign('print', 1);
        //$this->display();
    }

    /**
     * prepareData 
     * 准备数据
     * @access private
     * @return void
     */
    private function prepareData()
    {
        $currentBoxNum = session('currentBoxNum');
        if(empty($currentBoxNum)) {
            $this->error('获取箱码失败!');
        }
        $tagId = I('post.tagid');
        $tagId = intval($tagId);

        $pages = I('post.pages');
        $pages = intval($pages);

        $productDate = I('post.product');

        $batchId = I('post.batchId');
        $batchId = intval($batchId);

        if(!$tagId || !$pages || !$productDate || !$batchId) {
            //header("Content-Type:text/html;charset=utf-8");
            $this->error('请重新操作!');
        }
        //批次信息
        $currentBatch = $this->packageTable->where(array('id'=> intval($batchId)))->find();
        //标签信息
        $tag = $this->tagTable->where(array('id' =>intval($tagId)))->find();

        $this->tmpPackagePrintTable->where(array('package_num'=>trim($currentBoxNum)))->delete();//先删除已有打印

        $insertData = array();
        for($i = 0; $i < $pages; $i++) {
            $insertData[$i]['product_date'] = $productDate;
            $insertData[$i]['batch_id'] = $batchId;
            $insertData[$i]['batch_num'] = $currentBatch['batch_num'];
            $insertData[$i]['package_num'] = $currentBoxNum;
            $insertData[$i]['brcode'] = $currentBoxNum;
            $insertData[$i]['qrcode'] = U('Front/index',array('code'=>$currentBoxNum), false,true);
            $insertData[$i]['createdatetime'] = date('Y-m-d G:i:s', time());
            $insertData[$i]['createuser'] = session(C('USER_AUTH_KEY'));
            $insertData[$i]['tag_id'] = $tagId;
            $insertData[$i]['pages'] = $pages;
        }
        $this->tmpPackagePrintTable->addAll($insertData);

        $retArr = array();
        $retArr['tag'] = $tag;
        $retArr['productDate'] = $productDate;
        $retArr['currentBatch'] = $currentBatch;
        $retArr['pages'] = $pages;
        $retArr['currentBoxNum'] = $currentBoxNum;
        return $retArr;
    }

    /**
     * showAct 
     * 渲染主逻辑
     * @access private
     * @return void
     */
    private function showAct()
    {
        header("Content-type:text/html;charset=utf-8");
        $filePath = APP_PATH.'Upload/';
        $fileUrl = __ROOT__.'/Upload/';
        $currentBoxNum = session('currentBoxNum');
        if(empty($currentBoxNum)) {
            $this->error('获取箱码失败!');
        }
        //二维码
        vendor("phpqrcode.phpqrcode");
        //条形码
        vendor("barcodegen.class.BCGFontFile");
        vendor("barcodegen.class.BCGColor");
        vendor("barcodegen.class.BCGDrawing");
        vendor("barcodegen.class.BCGcode39#barcode");

        $tagId = I('get.tagid');
        $pages = I('get.pages');
        $productDate = I('get.product');
        $batchId = I('get.batchId');
        if(!$tagId || !$pages || !$productDate || !$batchId) {
            header("Content-Type:text/html;charset=utf-8");
            die('请重新操作!');
        }
        //批次信息
        $currentBatch = $this->packageTable->where(array('id'=> intval($batchId)))->find();
        //标签信息
        $tag = $this->tagTable->where(array('id' =>intval($tagId)))->find();
        //二维码生成
        $qrFileName = 'qr/'.time().'qrcode.png';
        $qrcode = $filePath.$qrFileName;
        //\QRcode::png($currentBatch['batch_num'], $qrcode, 'L', 4);
        \QRcode::png($currentBoxNum, $qrcode, 'L', 4);//二维码中放箱码
        $qrcodeUrl = $fileUrl.$qrFileName;
        $qrcodeImg = "<img id='qrcode' src='{$qrcodeUrl}' alt='二维码' />";

        //条形码
        // The arguments are R, G, B for color.
        $color_black = new \BCGColor(0, 0, 0);
        $color_white = new \BCGColor(255, 255, 255);
        $barFileName = 'bar/'.time().'barcode.png';
        //加载字体
        $font = new \BCGFontFile(VENDOR_PATH.'barcodegen/font/Arial.ttf', 12);
        try {
            $code = new \BCGcode39();//实例化对应的编码格式
            $code->setScale(2); // Resolution
            $code->setThickness(23); // 条形码的厚度
            $code->setForegroundColor($color_black); // 条形码颜色
            $code->setBackgroundColor($color_white); // 空白间隙颜色
            $code->setFont($font); // 
            $code->parse($currentBoxNum);
            $drawing = new \BCGDrawing($filePath.$barFileName, $color_white);
            $drawing->setBarcode($code);
            $drawing->draw();
            $drawing->finish(\BCGDrawing::IMG_FORMAT_PNG);
        } catch(Exception $exception) {
            $this->error($exception->getMessage());
            return false;
        }
        $barcodeUrl = $fileUrl.$barFileName;
        $barcodeImg = "<img id='barcode' src='{$barcodeUrl}' alt='条形码' />";
        $productDateDiv = "<span id='productDate'>{$productDate}</span>";
        $batchNumDiv = "<span id='batchNum'>{$currentBatch['batch_num']}</span>";


        //$qrcodeImg = $qrcodeUrl;
        //$barcodeImg = $barcodeUrl;
        //$productDateDiv = $productDate;
        //$batchNumDiv = $currentBatch['batch_num'];

        $result = $tag['tag_detail'];
        $result = str_replace('{*二维码*}',$qrcodeImg,$result);
        $result = str_replace('{*产地*}',$tag['product_place'],$result);
        $result = str_replace('{*批次号*}',$batchNumDiv, $result);
        $result = str_replace('{*生产日期*}',$productDateDiv,$result);
        $result = str_replace('{*产品名称*}',$tag['product_name'],$result);
        $result = str_replace('{*条形码*}',$barcodeImg,$result);
        $result = str_replace('{*模板底图*}',__ROOT__.'/'.$tag['template_url'],$result);
        $result = html_entity_decode($result);


        $this->assign('content',$tag);
        $this->assign('showBody', $result);
        $this->assign('title', '打印页');
        $retArr = array();
        $retArr['tag'] = $tag;
        $retArr['productDate'] = $productDate;
        $retArr['currentBatch'] = $currentBatch;
        $retArr['pages'] = $pages;
        return $retArr;
    }

    /**
     * historyMark 
     * 打印历史记录
     * @param mixed $tag 
     * @param mixed $productDate 
     * @param mixed $currentBatch 
     * @param mixed $pages 
     * @access private
     * @return void
     */
    private function historyMark($tag, $productDate, $currentBatch, $pages)
    {
        //记录打印历史
        $printH = array();
        $printH['tag_id'] = $tag['id'];
        $printH['tag_name'] = $tag['tag_name'];
        $printH['product_date'] = $productDate;
        $printH['product_name'] = $currentBatch['product_name'];
        $printH['depot_code'] = session('DEPOT_CODE');
        $printH['batch_num'] = $currentBatch['batch_num'];
        $printH['batch_id'] = $currentBatch['id'];
        $printH['page_num'] = $pages;
        $printH['createdatetime'] = date('Y-m-d G:i:s', time());
        $printH['createuser'] = session(C('USER_AUTH_KEY'));
        $this->selectTable->add($printH);
    }


}
