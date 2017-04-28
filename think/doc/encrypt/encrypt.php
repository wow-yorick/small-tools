<?php 
	
$data = array(
	'user'=>'',
	'password'=>'',
	'time'=>strtotime('2016-09-01'),
);
$str =  encrypt($data);

$fp = fopen('./term.txt','w+');
fwrite($fp,$str);

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
	$fp = fopen( "./rsa_private_key.pem", "r"); //你的私钥文件路径
	$private_key = fread($fp, 8192);
	fclose($fp);
	$pr_key = openssl_get_privatekey($private_key);//这个函数可用来判断私钥是否是可用的，可用返回资源id Resource id
	openssl_private_encrypt($str, $encrypt_data, $pr_key);
	return base64_encode($encrypt_data);
}
	
?>