<?php
class my_curl {
     
    public function __construct() {
        ! extension_loaded ( 'curl' ) && exit ( 'CURL扩展未加载，程序终止运行' );
        header ( 'Content-Type: text/html; charset=utf-8' );
    }
     
    public function go($url, $vars = '') {
        $ch = curl_init ();
        $array [CURLOPT_URL] = $url;
        $array [CURLOPT_HEADER] = false;
        $array [CURLOPT_RETURNTRANSFER] = true;
        $array [CURLOPT_FOLLOWLOCATION] = true;
         
        if (! empty ( $vars )) {
            $postfields = $this->render_postfields ( $vars ); //生成urlcode的url
            $array [CURLOPT_POST] = true;
            $array [CURLOPT_POSTFIELDS] = $postfields;
        }
         
        //判断是否有cookie,有的话直接使用
        if ($_COOKIE ['cookie_jar'] || is_file ( $_COOKIE ['cookie_jar'] )) {
            $array [CURLOPT_COOKIEFILE] = $_COOKIE ['cookie_jar']; //这里判断cookie
        } else {
            $cookie_jar = tempnam ( '/tmp', 'cookie' ); //产生一个cookie文件
            $array [CURLOPT_COOKIEJAR] = $cookie_jar; //写入cookie信息
            setcookie ( 'cookie_jar', $cookie_jar ); //保存cookie路径
        }
        curl_setopt_array ( $ch, $array ); //传入curl参数
        $content = curl_exec ( $ch ); //执行
        curl_close ( $ch );//关闭
        return $content; //返回
    }
     
    protected function render_postfields($vars) {
        foreach ( $vars as $key => $values ) {
            $postdata .= urlencode ( $key ) . "=" . urlencode ( $values ) . "&";
        }
        return $postdata;
    }
}
?>