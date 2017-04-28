<?php

/**
 * 获取当前URL
 * @return type
 */
function get_url()
{
	$sys_protocal = isset($_SERVER['SERVER_PORT']) && $_SERVER['SERVER_PORT'] == '443' ? 'https://' : 'http://';
	$php_self = $_SERVER['PHP_SELF'] ? $_SERVER['PHP_SELF'] : $_SERVER['SCRIPT_NAME'];
	$path_info = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : '';
	$relate_url = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : $php_self . (isset($_SERVER['QUERY_STRING']) ? '?' . $_SERVER['QUERY_STRING'] : $path_info);
	return $sys_protocal . (isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '') . $relate_url;
}

/**
 * 手机号码加密解密
 * @param type $string
 * @param type $operation
 * @param type $key
 * @param type $expiry
 * @return string
 */
function authcode($string, $operation = 'DECODE', $key = '', $expiry = 0)
{
	if (preg_match('/^[0-9]{0,11}$/', $string) && $operation == 'DECODE') {
		return $string;
	}
	$ckey_length = 4;
	// 密匙
	$key = md5($key ? $key : "_think_");
	// 密匙a会参与加解密
	$keya = md5(substr($key, 0, 16));
	// 密匙b会用来做数据完整性验证
	$keyb = md5(substr($key, 16, 16));
	// 密匙c用于变化生成的密文
	$keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length) : substr(md5(microtime()), -$ckey_length)) : '';
	// 参与运算的密匙
	$cryptkey = $keya . md5($keya . $keyc);
	$key_length = strlen($cryptkey);
	// 明文，前10位用来保存时间戳，解密时验证数据有效性，10到26位用来保存$keyb(密匙b)，解密时会通过这个密匙验证数据完整性
	// 如果是解码的话，会从第$ckey_length位开始，因为密文前$ckey_length位保存 动态密匙，以保证解密正确
	$string = $operation == 'DECODE' ? base64_decode(substr($string, $ckey_length)) : sprintf('%010d', $expiry ? $expiry + time() : 0) . substr(md5($string . $keyb), 0, 16) . $string;
	$string_length = strlen($string);
	$result = '';
	$box = range(0, 255);
	$rndkey = array();
	// 产生密匙簿
	for ($i = 0; $i <= 255; $i++) {
		$rndkey[$i] = ord($cryptkey[$i % $key_length]);
	}
	// 用固定的算法，打乱密匙簿，增加随机性，好像很复杂，实际上对并不会增加密文的强度
	for ($j = $i = 0; $i < 256; $i++) {
		$j = ($j + $box[$i] + $rndkey[$i]) % 256;
		$tmp = $box[$i];
		$box[$i] = $box[$j];
		$box[$j] = $tmp;
	}
	// 核心加解密部分
	for ($a = $j = $i = 0; $i < $string_length; $i++) {
		$a = ($a + 1) % 256;
		$j = ($j + $box[$a]) % 256;
		$tmp = $box[$a];
		$box[$a] = $box[$j];
		$box[$j] = $tmp;
		// 从密匙簿得出密匙进行异或，再转成字符
		$result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
	}
	if ($operation == 'DECODE') {
		// substr($result, 0, 10) == 0 验证数据有效性
		// substr($result, 0, 10) - time() > 0 验证数据有效性
		// substr($result, 10, 16) == substr(md5(substr($result, 26).$keyb), 0, 16) 验证数据完整性
		// 验证数据有效性，请看未加密明文的格式
		if ((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16)) {
			return substr($result, 26);
		} else {
			return '';
		}
	} else {
		// 把动态密匙保存在密文里，这也是为什么同样的明文，生产不同密文后能解密的原因
		// 因为加密后的密文可能是一些特殊字符，复制过程可能会丢失，所以用base64编码
		return $keyc . str_replace('=', '', base64_encode($result));
	}
}

/**
 * 判断是否手机端访问
 * @return boolean
 */
function is_mobile_request()
{
	$_SERVER['ALL_HTTP'] = isset($_SERVER['ALL_HTTP']) ? $_SERVER['ALL_HTTP'] : '';
	$mobile_browser = '0';
	if (preg_match('/(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|iphone|ipad|ipod|android|xoom)/i', strtolower($_SERVER['HTTP_USER_AGENT'])))
		$mobile_browser++;
	if ((isset($_SERVER['HTTP_ACCEPT'])) and (strpos(strtolower($_SERVER['HTTP_ACCEPT']), 'application/vnd.wap.xhtml+xml') !== false))
		$mobile_browser++;
	if (isset($_SERVER['HTTP_X_WAP_PROFILE']))
		$mobile_browser++;
	if (isset($_SERVER['HTTP_PROFILE']))
		$mobile_browser++;
	$mobile_ua = strtolower(substr($_SERVER['HTTP_USER_AGENT'], 0, 4));
	$mobile_agents = array(
		'w3c ', 'acs-', 'alav', 'alca', 'amoi', 'audi', 'avan', 'benq', 'bird', 'blac',
		'blaz', 'brew', 'cell', 'cldc', 'cmd-', 'dang', 'doco', 'eric', 'hipt', 'inno',
		'ipaq', 'java', 'jigs', 'kddi', 'keji', 'leno', 'lg-c', 'lg-d', 'lg-g', 'lge-',
		'maui', 'maxo', 'midp', 'mits', 'mmef', 'mobi', 'mot-', 'moto', 'mwbp', 'nec-',
		'newt', 'noki', 'oper', 'palm', 'pana', 'pant', 'phil', 'play', 'port', 'prox',
		'qwap', 'sage', 'sams', 'sany', 'sch-', 'sec-', 'send', 'seri', 'sgh-', 'shar',
		'sie-', 'siem', 'smal', 'smar', 'sony', 'sph-', 'symb', 't-mo', 'teli', 'tim-',
		'tosh', 'tsm-', 'upg1', 'upsi', 'vk-v', 'voda', 'wap-', 'wapa', 'wapi', 'wapp',
		'wapr', 'webc', 'winw', 'winw', 'xda', 'xda-'
	);
	if (in_array($mobile_ua, $mobile_agents))
		$mobile_browser++;
	if (strpos(strtolower($_SERVER['ALL_HTTP']), 'operamini') !== false)
		$mobile_browser++;
	// Pre-final check to reset everything if the user is on Windows  
	if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'windows') !== false)
		$mobile_browser = 0;
	// But WP7 is also Windows, with a slightly different characteristic  
	if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'windows phone') !== false)
		$mobile_browser++;
	if ($mobile_browser > 0)
		return true;
	else
		return false;
}

/**
 * 获取IP
 * @return string
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

/**
 * 获取用户的密码
 * @param $password
 * @param $salt
 * @param string $key
 * @return string
 */
function get_password($password, $salt, $key = '')
{
	$key = empty($key) ? C('ADMIN_PASSWORD_KEY') : $key;
	return md5($password . $key . $salt);
}

/**
 * 判断是否手机号码
 * @param $phonenumber
 * @return bool
 */
function is_mobile($phonenumber)
{
	return (preg_match("/^1[34578]{1}\d{9}$/", $phonenumber));

}

/**
 * 判断是否邮箱地址
 * @param $email
 * @return bool
 */
function is_email($email)
{
	return (preg_match("/^([0-9A-Za-z\\-_\\.]+)@([0-9a-z]+\\.[a-z]{2,3}(\\.[a-z]{2})?)$/i", $phonenumber));
}

/**
 * 产生随机字串，可用来自动生成密码
 * 默认长度6位 字母和数字混合 支持中文
 * @param string $len 长度
 * @param string $type 字串类型
 * 0 字母 1 数字 其它 混合
 * @param string $addChars 额外字符
 * @return string
 */
function randString($len = 6, $type = '', $addChars = '')
{
	$str = '';
	switch ($type) {
		case 0:
			$chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' . $addChars;
			break;
		case 1:
			$chars = str_repeat('0123456789', 3);
			break;
		case 2:
			$chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' . $addChars;
			break;
		case 3:
			$chars = 'abcdefghijklmnopqrstuvwxyz' . $addChars;
			break;
		case 4:
			$chars = "们以我到他会作时要动国产的一是工就年阶义发成部民可出能方进在了不和有大这主中人上为来分生对于学下级地个用同行面说种过命度革而多子后自社加小机也经力线本电高量长党得实家定深法表着水理化争现所二起政三好十战无农使性前等反体合斗路图把结第里正新开论之物从当两些还天资事队批点育重其思与间内去因件日利相由压员气业代全组数果期导平各基或月毛然如应形想制心样干都向变关问比展那它最及外没看治提五解系林者米群头意只明四道马认次文通但条较克又公孔领军流入接席位情运器并飞原油放立题质指建区验活众很教决特此常石强极土少已根共直团统式转别造切九你取西持总料连任志观调七么山程百报更见必真保热委手改管处己将修支识病象几先老光专什六型具示复安带每东增则完风回南广劳轮科北打积车计给节做务被整联步类集号列温装即毫知轴研单色坚据速防史拉世设达尔场织历花受求传口断况采精金界品判参层止边清至万确究书术状厂须离再目海交权且儿青才证低越际八试规斯近注办布门铁需走议县兵固除般引齿千胜细影济白格效置推空配刀叶率述今选养德话查差半敌始片施响收华觉备名红续均药标记难存测士身紧液派准斤角降维板许破述技消底床田势端感往神便贺村构照容非搞亚磨族火段算适讲按值美态黄易彪服早班麦削信排台声该击素张密害侯草何树肥继右属市严径螺检左页抗苏显苦英快称坏移约巴材省黑武培著河帝仅针怎植京助升王眼她抓含苗副杂普谈围食射源例致酸旧却充足短划剂宣环落首尺波承粉践府鱼随考刻靠够满夫失包住促枝局菌杆周护岩师举曲春元超负砂封换太模贫减阳扬江析亩木言球朝医校古呢稻宋听唯输滑站另卫字鼓刚写刘微略范供阿块某功套友限项余倒卷创律雨让骨远帮初皮播优占死毒圈伟季训控激找叫云互跟裂粮粒母练塞钢顶策双留误础吸阻故寸盾晚丝女散焊功株亲院冷彻弹错散商视艺灭版烈零室轻血倍缺厘泵察绝富城冲喷壤简否柱李望盘磁雄似困巩益洲脱投送奴侧润盖挥距触星松送获兴独官混纪依未突架宽冬章湿偏纹吃执阀矿寨责熟稳夺硬价努翻奇甲预职评读背协损棉侵灰虽矛厚罗泥辟告卵箱掌氧恩爱停曾溶营终纲孟钱待尽俄缩沙退陈讨奋械载胞幼哪剥迫旋征槽倒握担仍呀鲜吧卡粗介钻逐弱脚怕盐末阴丰雾冠丙街莱贝辐肠付吉渗瑞惊顿挤秒悬姆烂森糖圣凹陶词迟蚕亿矩康遵牧遭幅园腔订香肉弟屋敏恢忘编印蜂急拿扩伤飞露核缘游振操央伍域甚迅辉异序免纸夜乡久隶缸夹念兰映沟乙吗儒杀汽磷艰晶插埃燃欢铁补咱芽永瓦倾阵碳演威附牙芽永瓦斜灌欧献顺猪洋腐请透司危括脉宜笑若尾束壮暴企菜穗楚汉愈绿拖牛份染既秋遍锻玉夏疗尖殖井费州访吹荣铜沿替滚客召旱悟刺脑措贯藏敢令隙炉壳硫煤迎铸粘探临薄旬善福纵择礼愿伏残雷延烟句纯渐耕跑泽慢栽鲁赤繁境潮横掉锥希池败船假亮谓托伙哲怀割摆贡呈劲财仪沉炼麻罪祖息车穿货销齐鼠抽画饲龙库守筑房歌寒喜哥洗蚀废纳腹乎录镜妇恶脂庄擦险赞钟摇典柄辩竹谷卖乱虚桥奥伯赶垂途额壁网截野遗静谋弄挂课镇妄盛耐援扎虑键归符庆聚绕摩忙舞遇索顾胶羊湖钉仁音迹碎伸灯避泛亡答勇频皇柳哈揭甘诺概宪浓岛袭谁洪谢炮浇斑讯懂灵蛋闭孩释乳巨徒私银伊景坦累匀霉杜乐勒隔弯绩招绍胡呼痛峰零柴簧午跳居尚丁秦稍追梁折耗碱殊岗挖氏刃剧堆赫荷胸衡勤膜篇登驻案刊秧缓凸役剪川雪链渔啦脸户洛孢勃盟买杨宗焦赛旗滤硅炭股坐蒸凝竟陷枪黎救冒暗洞犯筒您宋弧爆谬涂味津臂障褐陆啊健尊豆拔莫抵桑坡缝警挑污冰柬嘴啥饭塑寄赵喊垫丹渡耳刨虎笔稀昆浪萨茶滴浅拥穴覆伦娘吨浸袖珠雌妈紫戏塔锤震岁貌洁剖牢锋疑霸闪埔猛诉刷狠忽灾闹乔唐漏闻沈熔氯荒茎男凡抢像浆旁玻亦忠唱蒙予纷捕锁尤乘乌智淡允叛畜俘摸锈扫毕璃宝芯爷鉴秘净蒋钙肩腾枯抛轨堂拌爸循诱祝励肯酒绳穷塘燥泡袋朗喂铝软渠颗惯贸粪综墙趋彼届墨碍启逆卸航衣孙龄岭骗休借" . $addChars;
			break;
		default :
			// 默认去掉了容易混淆的字符oOLl和数字01，要添加请使用addChars参数
			$chars = 'ABCDEFGHIJKMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789' . $addChars;
			break;
	}
	if ($len > 10) {//位数过长重复字符串一定次数
		$chars = $type == 1 ? str_repeat($chars, $len) : str_repeat($chars, 5);
	}
	if ($type != 4) {
		$chars = str_shuffle($chars);
		$str = substr($chars, 0, $len);
	} else {
		// 中文随机字
		for ($i = 0; $i < $len; $i++) {
			$str .= self::msubstr($chars, floor(mt_rand(0, mb_strlen($chars, 'utf-8') - 1)), 1, 'utf-8', false);
		}
	}
	return $str;
}


/**
 * 功能：生成二维码
 * @param string $qr_data 手机扫描后要跳转的网址
 * @param string $qr_level 默认纠错比例 分为L、M、Q、H四个等级，H代表最高纠错能力
 * @param string $qr_size 二维码图大小，1－10可选，数字越大图片尺寸越大
 * @param string $save_path 图片存储路径
 * @param string $save_prefix 图片名称前缀
 */
function createQRcode($save_path, $qr_data = 'PHP QR Code :)', $qr_level = 'L', $qr_size = 4, $save_prefix = '')
{
	Vendor('phpqrcode.phpqrcode');
	if (!isset($save_path)) return '';
	//设置生成png图片的路径
	$PNG_TEMP_DIR = &$save_path;
	//导入二维码核心程序
	vendor('PHPQRcode.class#phpqrcode');  //注意这里的大小写哦，不然会出现找不到类，PHPQRcode是文件夹名字，class#phpqrcode就代表class.phpqrcode.php文件名
	//检测并创建生成文件夹
	if (!file_exists($PNG_TEMP_DIR)) {
		mkdir($PNG_TEMP_DIR);
	}
	$filename = $PNG_TEMP_DIR . 'test.jpg';
	$errorCorrectionLevel = 'L';
	if (isset($qr_level) && in_array($qr_level, array('L', 'M', 'Q', 'H'))) {
		$errorCorrectionLevel = &$qr_level;
	}
	$matrixPointSize = 4;
	if (isset($qr_size)) {
		$matrixPointSize = &min(max((int)$qr_size, 1), 10);
	}
	if (isset($qr_data)) {
		if (is_array($qr_data)) {
			$t = '';
			foreach ($qr_data as $k => $v)
				if (!is_numeric($k)) $t .= "{$k}:{$v}" . PHP_EOL;
			$qr_data = $t;
		} else {
			if (trim($qr_data) == '') {
				die('data cannot be empty!');
			}
		}
		//生成文件名 文件路径+图片名字前缀+md5(名称)+.png
		$filename = $PNG_TEMP_DIR . $save_prefix . md5($qr_data . '|' . $errorCorrectionLevel . '|' . $matrixPointSize) . '.jpg';
		//开始生成
		QRcode::png($qr_data, $filename, $errorCorrectionLevel, $matrixPointSize, 2);
	} else {
		//默认生成
		QRcode::png('PHP QR Code :)', $filename, $errorCorrectionLevel, $matrixPointSize, 2);
	}
	if (file_exists($PNG_TEMP_DIR . basename($filename)))
		return basename($filename);
	else
		return FALSE;
}

/**
 * $data = array('user_name' => 'admin@qeeka.com', 'password' => '123456', 'time' => strtotime('2016-09-01'));
 * ksort($data);
 * $str = encrypt(http_build_query($data));
 * $fp = fopen(COMMON_PATH.'term.txt','w+');
 * fwrite($fp,$str);
 * @param $data
 * @return string
 */

function encrypt($data)
{
	ksort($data);
	$str = http_build_query($data);
	$fp = fopen(COMMON_PATH . "/rsa_private_key.pem", "r"); //你的私钥文件路径
	$private_key = fread($fp, 8192);
	fclose($fp);
	$pr_key = openssl_get_privatekey($private_key);//这个函数可用来判断私钥是否是可用的，可用返回资源id Resource id
	openssl_private_encrypt($str, $encrypt_data, $pr_key);
	return base64_encode($encrypt_data);
}

function decrypt($encryptData)
{
	$fp = fopen(COMMON_PATH . "/rsa_public_key.pem", "r"); //你的私钥文件路径
	$public_key = fread($fp, 8192);
	fclose($fp);
	$pu_key = openssl_get_publickey($public_key);//这个函数可用来判断私钥是否是可用的，可用返回资源id Resource id
	openssl_public_decrypt(base64_decode($encryptData), $decryptData, $pu_key);
	return $decryptData;


}