<?php
class curl
{
	// 这里保存curl_init()对象
	protected $ch;
	// curl调用的URL地址
	protected $url ;
	protected $options = array();
	protected $headers = array(); //输出头信息
	public $info ;  //信息
	public $response = ''; //返回输出
	public $error_code;
	public $error_string;
	public function __construct($url = '')
	{
		if(! $this->is_enabled())
		{
			echo 'error curl class,curl was not loaded, please check extension=php_curl.dll in your php.ini';
			exit;
		}
		$url && $this->create($url);
	}
	/**
	 * 创建 CURL对象
	 * @param string POST 地址
	 * @return object
	 */
	public function create($url)
	{
		$this->url = $url;
		//初始化curl对象
		$this->ch = curl_init();
		//10002
		$this->option('URL',$url);
		return $this;
	}
	
	public function post($params=array(),$options=array())
	{
		$params = http_build_query($params,NULL,'&');
		//echo $params;exit;
		empty($options) ? null : $this->options($options);
		// post方法，默认使用POST
		// 10036
		$this->http_method('post');
		// 10015
		$this->option(CURLOPT_POSTFIELDS, $params);
		return $this->execute();

	}
	//对参数进行urlencode处理，本次接口不需要处理否则会报错
	private function urlencode_init($params = array())
	{
		foreach($params as $k=>$v)
		{
			$params[$k] = urlencode($v);
		}
		return $params;
	}
	
	//执行操作
	public function execute()
	{
		//超时设置
		if ( ! isset($this->options[CURLOPT_TIMEOUT]))
		{
			//13
			$this->options[CURLOPT_TIMEOUT] = 30;
		}
		if ( ! isset($this->options[CURLOPT_RETURNTRANSFER]))
		{ 
			//19913
			$this->options[CURLOPT_RETURNTRANSFER] = 1;
		}
		if ( ! isset($this->options[CURLOPT_FAILONERROR]))
		{
			//45
			$this->options[CURLOPT_FAILONERROR] = TRUE;
		} 
		$this->options();
		$this->response = curl_exec($this->ch);
		$this->info = curl_getinfo($this->ch);
		if($this->response === false)
		{
			$errno = curl_errno($this->ch);
			$error = curl_error($this->ch);
			curl_close($this->ch);
			$this->defaults_init();

			$this->error_code = $errno;
			$this->error_string = $error;
		}
		else
		{
			curl_close($this->ch);
			$this->last_response = $this->response;
			$this->defaults_init();
			return $this->last_response;
		}
		
	}
	/**
	 * 初始化配置参数
	 * Enter description here ...
	 */
	public function defaults_init()
	{
		$this->response = '';
		$this->options = array();
		$this->error_code = null;
		$this->error_string = '';
		$this->ch = null;
	}
	
	/**
	 * 配置为method方法 like:post,get,etc
	 * @param string $method
	 */
	public function http_method($method)
	{
		$this->options[CURLOPT_CUSTOMREQUEST] = strtoupper($method);
		//echo '<br />';
		//echo CURLOPT_TIMEOUT;
	//	echo '&&&'.CURLOPT_CUSTOMREQUEST.'&&&';
		return $this;
	}
	/**
	 * 盘点curl函数是否存在
	 */
	private function is_enabled()
	{
		return function_exists('curl_init');
	}
	/**
	 * Enter description here ...
	 * @param array $options
	 */
	private function options($options=array())
	{
		foreach($options as $k=>$v)
		{
			$this->option($k,$v);
		}
		curl_setopt_array($this->ch,$this->options);
		return $this;
	}
	private function option($code,$value)
	{
		//这里判断如果$code不是常量则自动转换
		if(is_string($code) && ! is_numeric($code))
		{
			//echo $code.'###';
			//这里表示常量字符串不匹配
			if( stripos($code,'CURLOPT_') === false)
			{
				$code = constant('CURLOPT_'.strtoupper($code));
			}
			else
			{
				$code = constant(strtoupper($code));
			}	
		}
		//echo $code.'--';
		$this->options[$code] = $value;
		return $this;
	}
}