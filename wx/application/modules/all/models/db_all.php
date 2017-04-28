<?php

class db_all
{
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
	}

/************************************** BEGIN: 权限判断 ***********************************************/
	/**
	 * 验证权限
	 */
	public function all_authRights($rightsVal)
	{
		if ($rightsVal == 0) {
			echo "<script>alert('没有权限！')</script>";
			exit();
		}
	}

	/**
	 * 获取controller下所有action的权限
	 */
	public function all_getControllerActionRights($moduleName, $controllerName)
	{
		try {
			$sqlStr = "SELECT actionname FROM rights_items
						WHERE modulename='$moduleName' AND controllername='$controllerName' AND actionname!=''";
			$arrActionName = $this->dbAdapter->fetchCol($sqlStr);

			$result = array();
			foreach ($arrActionName as $actionName) {
				$result[$actionName] = self:: all_getMaxRights($moduleName, $controllerName, $actionName);
			}

			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取item最大的权限
	 */
	public function all_getMaxRights($moduleName, $controllerName, $actionName)
	{
		try {
			//如果session值存在，就读取session值了
			/*$strTemp = $this->sessionPrefix . 'rights:' . $moduleName . '/' . $controllerName . '/' . $actionName;
			 if (isset($_SESSION[$strTemp])) {
				return $_SESSION[$strTemp];
			}*/

			$strRoleId = $_SESSION[$this->sessionPrefix . 'rights_userRoleId'];

			//如果不属于任意角色，则无任何权限
			if (empty($strRoleId)) return array(0, 0);

			//获取itemId
			$sqlStr = "SELECT id FROM rights_items
						WHERE modulename='$moduleName' AND controllername='$controllerName' AND actionname='$actionName'";
			$itemId = $this->dbAdapter->fetchOne($sqlStr);

			//如果不存在此item，则不判断权限
			if (empty($itemId)) {
				return array(1, 1);
			}

			//获取登录用户在此controller下的最大权限
			$result = '00';
			$arrRoleId = explode(',', $strRoleId);
			foreach ($arrRoleId as $roleId) {
				$sqlStr = "SELECT rights FROM rights_role_item_rights WHERE roleId=$roleId AND itemId=$itemId";
				$rights = $this->dbAdapter->fetchOne($sqlStr);
				if (empty($rights)) {
					$rights = '00';
				}
				$result = $result | $rights; //按位或
			}
			$result = str_split($result); //返回数组

			//$_SESSION[$strTemp] = $result; //session保存结果
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取登录用户在此item下的最大节点值（逗号隔开）
	 */
	public function all_getMaxDsVal($moduleName, $controllerName, $actionName)
	{
		try {
			$accountTypeId = $_SESSION[$this->sessionPrefix . 'accountTypeId'];
			$userId = $_SESSION[$this->sessionPrefix . 'userId'];
			$strRoleId = $_SESSION[$this->sessionPrefix . 'rights_userRoleId'];

			//获取itemId
			$sqlStr = "SELECT id FROM rights_items
						WHERE modulename='$moduleName' AND controllername='$controllerName' AND actionname='$actionName'";
			$itemId = $this->dbAdapter->fetchOne($sqlStr);

			//获取拥有对此item读权限的roleId（逗号隔开）
			$sqlStr = "SELECT GROUP_CONCAT(DISTINCT roleId) FROM rights_role_item_rights
						WHERE roleId IN ($strRoleId) AND itemId=$itemId AND rights LIKE '1%'";
			$newStrUserRole = $this->dbAdapter->fetchOne($sqlStr);

			$result = '';
			switch ($accountTypeId) {
				case 1:
					//获取此账号对此item的用户-角色关系
					$sqlStr = "SELECT dsId, dsVal FROM rights_at_user_role_ds
								WHERE atId=1 AND userId=$userId AND roleId IN ($newStrUserRole) AND dsId IS NOT NULL";
					$arrUserRole = $this->dbAdapter->fetchAll($sqlStr);

					//获取展开的节点值
					if (sizeof($arrUserRole) > 0) { //表示有设置节点值
						foreach ($arrUserRole as $arrSub) {
							switch ($arrSub['dsId']) {
								case 1: //工地
									$strDsVal = $arrSub['dsVal'];
									break;
								case 4: //全部
									return -1; //表示所有工地
									break;
							}
							$result .= ',' . $strDsVal;
						}
						$result = substr(implode(',', array_unique(explode(',', $result))), 1);
					}
					break;
			}

			if (empty($result)) $result = 0; //表示没有工地
			//all_model_ousu_helper:: ousu_dump($result); exit();
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取登录用户的所有角色，放于session中（逗号隔开）
	 * @param int $userId
	 * @return string $result
	 * 注：在login的controller里调用
	 */
	public function all_getUserRoleId($accountTypeId, $userId)
	{
		try {
			switch ($accountTypeId) {
				case 1:
					$sqlStr = "SELECT GROUP_CONCAT(DISTINCT roleId) FROM rights_at_user_role_ds
								WHERE atId=1 AND userId=$userId";
					$result = $this->dbAdapter->fetchOne($sqlStr);
					break;
			}

			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 *  获取权限表中的权限个数，放于session中
	 * @return int $result
	 * 注：在login的controller里调用
	 */
	public function all_getNoRightsStr()
	{
		try {
			$sqlStr = "SELECT COUNT(*) FROM rights_rights";
			$rightsSize = $this->dbAdapter->fetchOne($sqlStr);
			$result = str_repeat('0', $rightsSize); //'00'，把字符串重复指定的次数
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取所有角色
	 * @return array $result
	 */
	public function all_getAllRole()
	{
		try {
			$sqlStr = "SELECT id AS roleId, rolename AS roleName, remarks FROM rights_roles ORDER BY CONVERT(rolename USING gb2312)";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取所有datasource
	 * @return array $result
	 */
	public function all_getAllDatasource()
	{
		try {
			$sqlStr = "SELECT id AS dsId, datasourcename AS dsName FROM rights_datasources";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
/************************************** END  : 权限判断 ***********************************************/


/************************************** BEGIN: 基类公用 ***********************************************/

	/**
	 * 数字金额转换成中文大写金额的函数
	 * UTF-8版（一个汉字占3字节）
	 * @return string $result
	 */
	function all_num2rmb ($num)
	{
		$c1 = "零壹贰叁肆伍陆柒捌玖";
		$c2 = "分角元拾佰仟万拾佰仟亿";
		$num = round($num, 2);
		$num = $num * 100;
		if (strlen($num) > 10) {
			return "oh,sorry,the number is too long!";
		}

		$i = 0;
		$c = "";

		while (1) {
			if ($i == 0) {
				$n = substr($num, strlen($num)-1, 1);
			} else {
				$n = $num % 10;
			}

			$p1 = substr($c1, 3 * $n, 3);
			$p2 = substr($c2, 3 * $i, 3);

			if ($n != '0' || ($n == '0' && ($p2 == '亿' || $p2 == '万' || $p2 == '元'))) {
				$c = $p1 . $p2 . $c;
			} else {
				$c = $p1 . $c;
			}

			$i = $i + 1;
			$num = $num / 10;
			$num = (int)$num;
			if ($num == 0) {
				break;
			}
		} //end of while| here, we got a chinese string with some useless character
		$j = 0;

		$slen = strlen($c);
		while ($j < $slen) {
			$m = substr($c, $j, 6);
			if ($m == '零元' || $m == '零万' || $m == '零亿' || $m == '零零') {
				$left = substr($c, 0, $j);
				$right = substr($c, $j + 3);
				$c = $left . $right;
				$j = $j-3;
				$slen = $slen-3;
			}

			$j = $j + 3;
		}

		if (substr($c, strlen($c)-3, 3) == '零') {
			$c = substr($c, 0, strlen($c)-3);
		} // if there is a '0' on the end , chop it out
		return $c . "整";
	}

	/**
	 * 获取指定月份的天数
	 * @param date $date '%Y-%m-%d'
	 * @return int $result
	 */
	public function all_getMonthLastDay($date)
	{
		try {
			$sqlStr = "SELECT DAY(LAST_DAY('$date'))";
			$result = $this->dbAdapter->fetchOne($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 文件下载
	 * @return
	 */
	public function all_download($file, $newFileName = null)
	{
		$file = iconv('UTF-8', 'GB2312', $file);
		if ($newFileName == null) {
			$newFileName = $file;
		} else {
			$newFileName = iconv('UTF-8', 'GB2312', $newFileName);
		}

		try {
			if (file_exists($file)) {
				header('Content-Description: File Transfer');
				header('Content-Type: application/octet-stream');
				header('Content-Disposition: attachment; filename=' . basename($newFileName));
				header('Content-Transfer-Encoding: binary');
				header('Expires: 0');
				header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
				header('Pragma: public');
				header('Content-Length: ' . filesize($file));
				ob_clean();
				flush();
				readfile($file);
				exit();
			}
			else {
				header("Content-type: text/html; charset=utf-8");
				echo "<script>alert('下载失败，文件不存在！');window.opener = null;window.open('', '_self');window.close();</script>";
			}
		} catch(Exception $e) {
			echo $e->getMessage();
		}
	}

	/**
	 * 文件上传
	 * @param date $sFileTagName html中file标签的name属性值
	 * @param bool $bIsAlertErr 是否alert错误信息
	 * @param string $sFilePath 文件放置到服务器的路径，包含文件名
	 * @param array $aTypeLimit 格式限制，无限制传入null
	 * @param string $sSizeLimit 大小限制，无限制传入null
	 * @return string $errMsg 错误信息，成功返回true
	 */
	public function all_fileUploadAuth($sFileTagName = 'file', $bIsAlertErr = true, $sFilePath = null, $aTypeLimit = null, $sSizeLimit = null)
	{
		$sFileName = $_FILES[$sFileTagName]['name']; //被上传文件的名称
		$sFileType = $_FILES[$sFileTagName]['type']; //被上传文件的类型
		$iFileSize = $_FILES[$sFileTagName]['size']; //被上传文件的大小，单位为字节
		$sFileTmpName = $_FILES[$sFileTagName]['tmp_name']; //存储在服务器的文件的临时副本的名称
		$iFileErrCode = $_FILES[$sFileTagName]['error']; //由文件上传导致的错误代码

		$errMsg = true;

		//判断文件上传错误代码
		if ($iFileErrCode > 0) {
			$aErrorMsg = array(
				1 => '文件大小超过了PHP.ini中的文件限制！',
				2 => '文件大小超过了浏览器限制！',
				3 => '文件部分被上传！',
				4 => '没有找到要上传的文件！',
				5 => '服务器临时文件夹丢失，请重新上传！',
				6 => '文件写入到临时文件夹出错！',
			);
			$errMsg = 'Error Code ' . $iFileErrCode . ': ' . $aErrorMsg[$iFileErrCode];
		}

		//判断文件是否正在打开，打开状态上传会失败
		if ($errMsg === true && $sFileType == 'application/octet-stream') {
			$errMsg = '文件正在打开，请先关闭文件后再重新上传！';
		}

		//限制上传文件类型
		if ($errMsg === true && !empty($aTypeLimit)) {
			$aValue = array();
			foreach ($aTypeLimit as $val) {
				if (is_array($val)) {
					foreach ($val as $v) {
						array_push($aValue, $v);
					}
				} else {
					array_push($aValue, $val);
				}
			}
			if (!in_array($sFileType, $aValue)) {
				$sKey = implode(',', array_keys($aTypeLimit));
				$errMsg = 'Error Type: 文件格式错误，文件扩展名必须在\"' . $sKey . '\"内！';
			}
		}

		//限制上传文件大小
		if ($errMsg === true && !empty($sSizeLimit)) {
			if ($iFileSize > $sSizeLimit) {
				$errMsg = 'Error Size: 文件大小超出限制，文件大小必须小于' . $sSizeLimit . '字节(KB)！';
			}
		}

		//移动文件到指定目录
		if ($errMsg === true && !empty($sFilePath)) {
			if (file_exists($sFilePath)) {
				$errMsg = 'Error: 上传失败，文件已存在！';
			} else {
				$flag = move_uploaded_file($sFileTmpName, $sFilePath);
				if ($flag) {
					return true;
				} else {
					$errMsg = 'Error Move: 移动文件失败！';
				}
			}
		}

		//alert错误信息
		if ($errMsg !== true && $bIsAlertErr == true) {
			header("Content-type: text/html; charset=utf-8");
			echo '<script>alert("' . $errMsg . '");</script>';
			exit();
		}

		return $errMsg;

		//文件类型定义Demo:
		/*$aTypeLimit = array(
			'txt' => 'text/plain',
			'doc' => 'application/msword',
			'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
			'xls' => 'application/vnd.ms-excel',
			'xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
			'ppt' => 'application/vnd.ms-powerpoint',
			'pptx' => 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
			'pdf' => 'application/pdf',
			'rar' => 'application/octet-stream',
			'zip' => 'application/x-zip-compressed',
			'jpg' => array(
				'image/pjpeg',
				'image/jpeg',
				'image/jpg',
			),
			'png' => array(
				'image/x-png',
				'image/png',
			),
			'bmp' => 'image/bmp',
			'gif' => 'image/gif',
		);*/
	}

	/**
	 * 获取excel数据
	 * @param string $filePath 文件路径
	 * @param string $fileType 文件类型，默认为Excel2003
	 * @param string $startRow 起始行
	 * @param string $startCol 起始列
	 * @param string $endRow 结束行
	 * @param string $endCol 结束列
	 * @return array $result 二维数组
	 */
	public function all_getExcelData($filePath, $fileType = 'application/vnd.ms-excel', $startRow = 1, $startCol = 'A', $endRow = null, $endCol = null) {
		try {
			require_once 'PHPExcel1.7.6/PHPExcel.php';
			if ($fileType == 'application/vnd.ms-excel') { //Excel2003
				$objReader = PHPExcel_IOFactory::createReader('Excel5');
			} else if ($fileType == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') { //Excel2007
				$objReader = PHPExcel_IOFactory::createReader('Excel2007');
			} else {
				return false;
			}
			$objPHPExcel = $objReader->load($filePath);
			$objActSheet = $objPHPExcel->getSheet(0);
			$endRow = $objActSheet->getHighestRow(); //取得总行数
			$endCol = $objActSheet->getHighestColumn(); //取得总列数

			$result = array();
			for ($i=$startRow; $i<=$endRow; $i++) {
				$arrTemp =array();
				for ($j=$startCol; $j<=$endCol; $j++) {
					array_push($arrTemp, trim($objActSheet->getCell($j . $i)->getValue()));
				}
				array_push($result, $arrTemp);
			}
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 格式化PHPExcel中单元格类型为日期的数据
	 */
	public function all_formatPhpExcelDate($iDate, $time = false)
	{
		if(is_numeric($iDate)){
			//based on 1900-1-1
			$jd = GregorianToJD(1, 1, 1970);
			$gregorian = JDToGregorian($jd + intval($iDate) - 25569);
			$myDate = explode('/', $gregorian);
			$myDateStr = str_pad($myDate[2], 4, '0', STR_PAD_LEFT)
				."-".str_pad($myDate[0], 2, '0', STR_PAD_LEFT)
				."-".str_pad($myDate[1], 2, '0', STR_PAD_LEFT)
				.($time ? " 00:00:00" : '');
			$iDate = $myDateStr;
		}
		return $iDate;
	}

	/**
	 * 创建文件（可移动创建文件夹）
	 * @return int $result 写入到文件内数据的字节数
	 */
	public function all_createFile($file, $data, $mode = null, $context = null)
	{
		self:: all_createDirCascade(dirname($file));
		$result = file_put_contents($file, $data, $mode, $context);
		return $result;
	}

	/**
	 * 级联创建文件夹
	 */
	public function all_createDirCascade($dirName)
	{
		if (!file_exists($dirName)){
			self:: all_createDirCascade(dirname($dirName));
			mkdir($dirName);
		}
	}

	/**
	 * 级联删除文件夹
	 */
	public function all_removeDirCascade($dirName)
	{
		if(!is_dir($dirName)) return false;

		$handle = @opendir($dirName);
		while(($file = @readdir($handle)) !== false) {
			if($file != "." && $file != "..") {
				$dir = $dirName . "/" . $file;
				is_dir($dir) ? self::all_removeDirCascade($dir) : @unlink($dir);
			}
		}
		closedir($handle);
		return rmdir($dirName);
	}

	/**
	 * 服务器端dataTable分页实现
	 * @param string $sqlStr 数据源的sql语句
	 * @param array $aColumns 页面显示字段，不从数据库读的字段用' '表示。 eg: $aColumns = array('id', 'username', ' ', 'pwd');
	 * @return array $result
	 */
	public function all_pagingServer($aColumns, $sqlStr)
	{
		try {
			require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //

			//Paging
			$sLimit = "";
			if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' ) {
				//$sLimit = "LIMIT " . mysql_real_escape_string( $_GET['iDisplayStart'] ) . ", " . mysql_real_escape_string( $_GET['iDisplayLength'] );
				$sLimit = "LIMIT " . addslashes( $_GET['iDisplayStart'] ) . ", " . addslashes( $_GET['iDisplayLength'] );
			}
			//Ordering
			$sOrder = "";
			if ( isset( $_GET['iSortCol_0'] ) ) {
				$sOrder = "ORDER BY ";
				for ( $i=0 ; $i<intval( $_GET['iSortingCols'] ) ; $i++ ) {
					if ( $_GET[ 'bSortable_'.intval($_GET['iSortCol_'.$i]) ] == "true" ) {
						//$sOrder .= $aColumns[ intval( $_GET['iSortCol_' . $i] ) ] . " " . mysql_real_escape_string( $_GET['sSortDir_' . $i] ) . ", ";
						$sOrder .= $aColumns[ intval( $_GET['iSortCol_' . $i] ) ] . " " . addslashes( $_GET['sSortDir_' . $i] ) . ", ";
					}
				}
				$sOrder = substr_replace( $sOrder, "", -2 ); //demo内写法
				//$sOrder = trim(substr_replace( $sOrder, "", -5 ));
				if ( $sOrder == "ORDER BY" ) {
					$sOrder = "";
				}
			}
			
			//Filtering
			$sWhere = "";
			if ( $_GET['sSearch'] != "" ) {
				$sWhere = "WHERE (";
				for ( $i=0 ; $i<count($aColumns) ; $i++ ) {
					//$sWhere .= $aColumns[$i] . " LIKE '%" . mysql_real_escape_string( $_GET['sSearch'] ) . "%' OR ";
					$sWhere .= $aColumns[$i] . " LIKE '%" . addslashes( $_GET['sSearch'] ) . "%' OR ";
				}
				$sWhere = substr_replace( $sWhere, "", -3 );
				$sWhere .= ')';
			}
			// Individual column filtering
			for ( $i=0 ; $i<count($aColumns) ; $i++ ) {
				if ( $_GET['bSearchable_' . $i] == "true" && $_GET['sSearch_' . $i] != '' ) {
					if ( $sWhere == "" ) {
						$sWhere = "WHERE ";
					} else {
						$sWhere .= " AND ";
					}
					//$sWhere .= $aColumns[$i] . " LIKE '%" . mysql_real_escape_string($_GET['sSearch_' . $i]) . "%' ";
					$sWhere .= $aColumns[$i] . " LIKE '%" . addslashes($_GET['sSearch_' . $i]) . "%' ";
				}
			}
			//SQL queries
			$sTable = "($sqlStr) t";
			$sQuery = "SELECT SQL_CALC_FOUND_ROWS " . str_replace(" , ", "", implode(", ", $aColumns)) . " FROM $sTable $sWhere $sOrder $sLimit";
			//$this->logger->debug("DEBUG sql:$sQuery");
			$rResult = $this->dbAdapter->fetchAll($sQuery);
			$iFilteredTotal = $this->dbAdapter->fetchOne('SELECT FOUND_ROWS()');
			$sQuery = "SELECT COUNT(*) FROM $sTable";
			$iTotal = $this->dbAdapter->fetchOne($sQuery);

			//rebuild array
			$size = sizeof($rResult);
			for ($i=0; $i<$size; $i++) {
				$arrTemp = array();
				for ($j=0; $j<sizeof($aColumns); $j++) {
					if ($aColumns[$j] == ' ') {
						array_push($arrTemp, $_GET['iDisplayStart'] + $i + 1);
					} else if ($aColumns[$j] == null) {
						array_push($arrTemp, '');
					} else {
						array_push($arrTemp, $rResult[$i][$aColumns[$j]]);
					}
				}
				$rResult[$i] = $arrTemp;
			}

			//Output
			$result = array(
					"sEcho" => intval($_GET['sEcho']),
					"iTotalRecords" => $iTotal,
					"iTotalDisplayRecords" => $iFilteredTotal,
					"aaData" => $rResult
			);

			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 根据数组和数组中得列名 返回叠加的总数
	 * @param array $postarray
	 * @param string $fieldname
	 * @return int $result
	 */
	 public function getFieldSum($fieldname,$postarray)
	{
		$tolnum = 0;
		if(is_array($postarray)) {
			foreach($postarray as $key=>$value) {
				$tolnum += $postarray[$key][$fieldname];
			}
		}
		return $tolnum;
	}

	/**
	 * 实例化一个Zend_Cache对象
	 * @param int $timeout 超时时间，默认1小时
	 * @param string $cacheDir 缓存路径，默认为DOCUMENT_ROOT下的temp文件夹下
	 * @return array $result
	 */
	public function newZendCache($timeout = 3600, $cacheDir = null)
	{
		if(empty($cacheDir)) $cacheDir = FILE_PREFIX_TEMP;

		$frontendOptions = array(
			'lifeTime' => $timeout //单位秒
			,'automatic_serialization' => true
		);
		$backendOptions = array(
			'cache_dir' => $cacheDir
		);
		$cache = Zend_Cache::factory('core', 'File', $frontendOptions, $backendOptions);
		return $cache;
	}

	/**
	 * 二维数组中的某一列排序（字符串值包括字母和数字，数字按数字类型方式排）
	 * @param array $arrData 数据源，二维数组
	 * @param string $colNum 列号
	 * @return array $result
	 */
	public function all_sort_intstr($arrData, $colNum)
	{
		$arrDataOld = self::all_multiArr_getCol($arrData, $colNum);
		$arrDataNew = $arrDataOld;
		$colSize = sizeof($arrDataOld);
		for ($i=0; $i<$colSize-1; $i++) {
			for($j=$i+1; $j<$colSize; $j++) {
				preg_match_all('/([\D]+)|([\d]+)/', $arrDataNew[$i], $tmpArr);
				$arrA = $tmpArr[0];
				preg_match_all('/([\D]+)|([\d]+)/', $arrDataNew[$j], $tmpArr);
				$arrB = $tmpArr[0];
				$size = sizeof($arrA);
				for ($k=0; $k<$size; $k++) {
					if ($arrA[$k] > $arrB[$k]) {
						$temp = $arrDataNew[$i];
						$arrDataNew[$i] = $arrDataNew[$j];
						$arrDataNew[$j] = $temp;
						break;
					} else if ($arrA[$k] == $arrB[$k]) {
						continue;
					} else if ($arrA[$k] < $arrB[$k]) {
						break;
					}
				}
			}
		}
		//all_model_ousu_helper:: ousu_dump($arrDataNew); exit();

		$arrDataFlip = array_flip($arrDataOld);
		$arrIndex = array();
		foreach ($arrDataNew as $val) {
			array_push($arrIndex, $arrDataFlip[$val]);
		}
		//all_model_ousu_helper:: ousu_dump($arrIndex); exit();

		$result = array();
		foreach ($arrIndex as $val) {
			array_push($result, $arrData[$val]);
		}
		//all_model_ousu_helper:: ousu_dump($result); exit();

		return $result;
	}

	/**
	 * 从二维数组中取出某一列的值放入一维数组中
	 * @param array $mArr 二维数组
	 * @param string $colNum 列号
	 * @return array $result
	 */
	public function all_multiArr_getCol($mArr, $colNum)
	{
		$result = array();
		foreach ($mArr as $arrSub) {
			array_push($result, $arrSub[$colNum]);
		}
		return $result;
	}

	/**
	 * 二维数字,转换为 key => value 的一维数组
	 * @return array $result
	 */
	public function all_mArr_KeyValue($mArr,$key,$value)
	{
		$result = array();
		foreach($mArr as $arr){
			$result[$arr[$key]] = $arr[$value];
		}
		return $result;
	}

	/**
	 * 获取所有登录账号的类型
	 * @return array $result
	 */
	public function all_getAllAccountType()
	{
		try {
			$sqlStr = "SELECT seq AS typeId, name AS typeName FROM sys_dictdata WHERE type='帐号类型' ORDER BY seq";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 从字典表获取需要的信息
	 * @return array $result
	 */
	public function all_getGlobalType($type)
	{
		try {
			$sqlStr = "SELECT * FROM sys_dictdata WHERE type='".$type."' ORDER BY seq";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * 获取字典表中的所有组
	 * @param string $strIdLimit 获取的id范围限制
	 * @return array $result
	 */
	public function all_getGlobalTypeGroup($strIdLimit = null)
	{
		try {
			$sqlStr = "SELECT seq AS groupId, name as groupName FROM sys_dictdata WHERE type='字典类型'";
			if (isset($strIdLimit)) $sqlStr .= " AND id IN ($strIdLimit)";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
	/**
	 * 获取配置表中的所有组
	 * @param string $strIdLimit 获取的id范围限制
	 * @return array $result
	 */
	public function all_getGlobalConfig($type = "")
	{
		try {
			if ($type == "") $sqlStr = "SELECT type as groupId,type as groupName FROM sys_configdata group by type";
			else $sqlStr = "SELECT * FROM sys_configdata WHERE type='$type'";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
	/**
	 * 获取数据表的所有字段定义
	 * @param string $table 表名
	 * @return array $result
	 */
	public function all_getFieldList($table)
	{
		try {
			$sqlStr = "SHOW FULL FIELDS FROM $table";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
/************************************** END  : 基类公用 ***********************************************/


/************************************** BEGIN: 项目公用 ***********************************************/
	/**
	 * 服务器端dataTable分页实现 for dbAdapter_ss
	 * @param string $sqlStr 数据源的sql语句
	 * @param array $aColumns 页面显示字段，不从数据库读的字段用' '表示。 eg: $aColumns = array('id', 'username', ' ', 'pwd');
	 * @return array $result
	 */
	public function all_pagingServer_ss($aColumns, $sqlStr)
	{
		try {
			require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //

			//Paging
			$sLimit = "";
			if ( isset( $_GET['iDisplayStart'] ) && $_GET['iDisplayLength'] != '-1' ) {
				//$sLimit = "LIMIT " . mysql_real_escape_string( $_GET['iDisplayStart'] ) . ", " . mysql_real_escape_string( $_GET['iDisplayLength'] );
				$sLimit = "LIMIT " . addslashes( $_GET['iDisplayStart'] ) . ", " . addslashes( $_GET['iDisplayLength'] );
			}
			//Ordering
			if ( isset( $_GET['iSortCol_0'] ) ) {
				$sOrder = "ORDER BY  ";
				for ( $i=0 ; $i<intval( $_GET['iSortingCols'] ) ; $i++ ) {
					if ( $_GET[ 'bSortable_'.intval($_GET['iSortCol_'.$i]) ] == "true" ) {
						//$sOrder .= $aColumns[ intval( $_GET['iSortCol_' . $i] ) ] . " " . mysql_real_escape_string( $_GET['sSortDir_' . $i] ) . ", ";
						$sOrder .= $aColumns[ intval( $_GET['iSortCol_' . $i] ) ] . " " . addslashes( $_GET['sSortDir_' . $i] ) . ", ";
					}
				}
				//$sOrder = substr_replace( $sOrder, "", -2 ); //demo内写法
				$sOrder = trim(substr_replace( $sOrder, "", -5 ));
				if ( $sOrder == "ORDER BY" ) {
					$sOrder = "";
				}
			}

			//Filtering
			$sWhere = "";
			if ( $_GET['sSearch'] != "" ) {
				$sWhere = "WHERE (";
				for ( $i=0 ; $i<count($aColumns) ; $i++ ) {
					//$sWhere .= $aColumns[$i] . " LIKE '%" . mysql_real_escape_string( $_GET['sSearch'] ) . "%' OR ";
					$sWhere .= $aColumns[$i] . " LIKE '%" . addslashes( $_GET['sSearch'] ) . "%' OR ";
				}
				$sWhere = substr_replace( $sWhere, "", -3 );
				$sWhere .= ')';
			}
			// Individual column filtering
			for ( $i=0 ; $i<count($aColumns) ; $i++ ) {
				if ( $_GET['bSearchable_' . $i] == "true" && $_GET['sSearch_' . $i] != '' ) {
					if ( $sWhere == "" ) {
						$sWhere = "WHERE ";
					} else {
						$sWhere .= " AND ";
					}
					//$sWhere .= $aColumns[$i] . " LIKE '%" . mysql_real_escape_string($_GET['sSearch_' . $i]) . "%' ";
					$sWhere .= $aColumns[$i] . " LIKE '%" . addslashes($_GET['sSearch_' . $i]) . "%' ";
				}
			}

			//SQL queries
			$sTable = "($sqlStr) t";
			$sQuery = "SELECT SQL_CALC_FOUND_ROWS " . str_replace(" , ", "", implode(", ", $aColumns)) . " FROM $sTable $sWhere $sOrder $sLimit";
			$rResult = $this->dbAdapter_ss->fetchAll($sQuery);
			$iFilteredTotal = $this->dbAdapter_ss->fetchOne('SELECT FOUND_ROWS()');
			$sQuery = "SELECT COUNT(*) FROM $sTable";
			$iTotal = $this->dbAdapter_ss->fetchOne($sQuery);

			//rebuild array
			$size = sizeof($rResult);
			for ($i=0; $i<$size; $i++) {
				$arrTemp = array();
				for ($j=0; $j<sizeof($aColumns); $j++) {
					if ($aColumns[$j] == ' ') {
						array_push($arrTemp, $_GET['iDisplayStart'] + $i + 1);
					} else if ($aColumns[$j] == null) {
						array_push($arrTemp, '');
					} else {
						array_push($arrTemp, $rResult[$i][$aColumns[$j]]);
					}
				}
				$rResult[$i] = $arrTemp;
			}

			//Output
			$result = array(
					"sEcho" => intval($_GET['sEcho']),
					"iTotalRecords" => $iTotal,
					"iTotalDisplayRecords" => $iFilteredTotal,
					"aaData" => $rResult
			);

			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}

	/**
	 * CUSTOM SQL (ONE ROW)
	 * @return array $result
	 */
	public function getCustomSqlOne($sql)
	{
		try {
			$result = $this->dbAdapter->fetchRow($sql);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
	/**
	 * CUSTOM SQL (ALL)
	 * @return array $result
	 */
	public function getCustomSqlAll($sql)
	{
		try {
			$result = $this->dbAdapter->fetchAll($sql);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
	
	/*
	 * CUSTOM SQL(SELECT COL FROM $TABLE GROUP COL)
	 * $return array col group
	 */
	public function getGroupCol($table,$col){
		try{
			$sql = "SELECT $col FROM $table GROUP BY $col";
			$result = $this->dbAdapter->fetchAll($sql);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
    
    /**
     * 从配置表获取需要的信息
     * @return array $result
     */
    public function all_getConfData($typename,$name ="")
    {
        try {
        	if ($name == ""){
        		$sqlStr = "SELECT Id as id, seq, name, value FROM sys_configdata WHERE type='".$typename."' ORDER BY seq";
        	}
        	else {
        		$sqlStr = "SELECT Id as id, seq, name, value FROM sys_configdata WHERE type='".$typename."' and name='".$name."'";
        	}
            
            $result = $this->dbAdapter->fetchAll($sqlStr);
            $this->logger->debug("提取数据字典 type : $typename , $name");
			return $result;
        } catch (Exception $e) {
            $this->logger->err("[$this->table]删除错误 : $err");
			die($e->getMessage());
        }
    }   
    
    /**
	 * 查询
	 * @param string $sql,boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function findData($sql,$transaction = true)
	{
		$result = array();
		try {
			$rows =$this->dbAdapter->fetchAll($sql);
			if (strpos('UPDATE',".".$sql)>0)
				$this->logger->info("查询数据库 : [$sql] 结果[".sizeof($rows)."]行");
			else 
				$this->logger->debug("查询数据库 : [$sql] 结果[".sizeof($rows)."]行");
			$result = Ousu::getJsonResult();
			$result["success"] = true;
			$result["msg"] = "查询成功!";
			$result["obj"] = $rows;
			return $result;
		} catch (Exception $e) {
			$err =$e->getMessage(); 
			$this->logger->err("[$this->table]查询数据错误 : [$sql] \r\n			ERROR : $err" );
			$result = Ousu::getJsonResult();
			$result["success"] = false;
			$result["msg"] = $err;
			return $result;
		}
	}
	
	/**
	 * 获取组名
	 * @param string $strIdLimit 获取的id范围限制
	 * @return array $result
	 */
	public function all_GroupName($field,$table)
	{
		try {
		 	$sqlStr = "SELECT {$field} FROM {$table} WHERE {$field} !=''";
			$result = $this->dbAdapter->fetchAll($sqlStr);
			return $result;
		} catch (Exception $e) {
			die($e->getMessage());
		}
	}
	
/* ************************************** END: 项目公用 ***********************************************/
	


}