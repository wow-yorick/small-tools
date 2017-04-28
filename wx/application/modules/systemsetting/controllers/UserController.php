<?php

class Systemsetting_UserController extends Zend_Controller_Action // !--- MODIFY --- //
{

	public function init()
	{
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_rights.php'; // !--- COPY --- //
		
	}
	
	private function setSearch()
	{
		$arrSearch = array();
		foreach ($this->view->dataMenuInfo["searchmenu"]["items"] as $arr){
			if ($arr["type"] == "text")
				$arrSearch["%".$arr["name"]] = "%".$_POST[$arr["name"]];
			if ($arr["type"] == "select")
				$arrSearch["=".$arr["name"]] = "=".$_POST[$arr["name"]];
			if ($arr["type"] == "dayse"){
				$arrSearch[">".$arr["name"]."Start"] = ">".$_POST[$arr["name"]."Start"];
				$arrSearch["<".$arr["name"]."End"] = "<".$_POST[$arr["name"]."End"];
			}
		}
		//检查是否存在Filter条件
		$sessionKey = $this->view->sessionPrefix.'Filter_'.$this->view->moduleName.'_'.$this->view->controllerName;
		if (isset($_SESSION[$sessionKey])){
			$arrFilter = $_SESSION[$sessionKey];
			foreach ($arrFilter as $key=>$value)
				$arrSearch["%".$key] = "%".$value;
		}
		//缓存搜索条件，用于分页
		$sessionKey = $this->view->sessionPrefix.'Search_'.$this->view->moduleName.'_'.$this->view->controllerName;
		$_SESSION[$sessionKey] = array();
		foreach ($arrSearch as $key=>$value) {
			$_SESSION[$sessionKey][$key] = $value;
		}
		return $arrSearch;
	}
	
	/**
	 * 私有方法：添加修改操作的view公共变量设置
	 */
	private function getGlobalData()
	{	
		// !---------- BEGIN: CUSTOM ---------- //
		// !---------- END  : CUSTOM ---------- //
	}
	
	/**
	 * 私有方法：获取添加和删除操作的公共数据
	 */
	private function getAddModifySameData()
	{
		$dataInfo = array();
		$fieldlist = $this->dbAll->all_getFieldList($this->view->dataGridInfo["table"]);
		foreach($fieldlist as $arr){
			if (isset($_POST[$arr["Field"]]))
				$dataInfo[$arr["Field"]] = $_POST[$arr["Field"]];
				if($arr["Field"] =='password'){
					$dataInfo[$arr["Field"]] = md5($_POST[$arr["Field"]]);
				}
		}
		// !---------- BEGIN: MODIFY ---------- //
		// !---------- END  : MODIFY ---------- //

		return $dataInfo;
	}
	
	public function indexAction()
	{
		$sessionKey = $this->view->sessionPrefix.'Filter_'.$this->view->moduleName.'_'.$this->view->controllerName;
		unset($_SESSION[$sessionKey]);
		$sessionKey = $this->view->sessionPrefix.'Dialog_'.$this->view->moduleName.'_'.$this->view->controllerName;
		unset($_SESSION[$sessionKey]);
		$arrSearch = self::setSearch();
		$sql = "SELECT * FROM ".$this->view->dataGridInfo["table"];
		$sql = $this->db->addWhere($sql,$arrSearch);
		$sql .= " LIMIT 1,15";
		$allDataList = $this->db->find($sql);
		$this->view->allDataList = $allDataList["obj"];
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/top_data.phtml');
	}

	/**
	 * 搜索
	 */
	public function searchAction()
	{
		$sessionKey = $this->view->sessionPrefix.'Dialog_'.$this->view->moduleName.'_'.$this->view->controllerName;
		if (isset($_SESSION[$sessionKey])) 		$this->view->searchlabel = 'search';
		$arrSearch = self::setSearch();
		$sql = "SELECT * FROM ".$this->view->dataGridInfo["table"];
		$sql = $this->db->addWhere($sql,$arrSearch);
		$sql .= " LIMIT 1,15";
		$allDataList = $this->db->find($sql);
		$this->view->allDataList = $allDataList["obj"];
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/list_ajax.phtml');
	}
	/**
	 * 分页功能实现
	 */
	public function pagingrecordinfoAction()
	{
		$sessionKey = $this->view->sessionPrefix.'Search_'.$this->view->moduleName.'_'.$this->view->controllerName;
		$arrSearch = $_SESSION[$sessionKey];
		$aColumns = array();
		if ($this->view->dataMenuInfo['batchoperation'] == 1)
			array_push($aColumns,$this->view->dataGridInfo["keyid"]); 		 
		foreach ($this->view->dataGridInfo["listfield"] as $arr){
			array_push($aColumns,$arr["fieldname"]);
		}
		$sql = "SELECT * FROM ".$this->view->dataGridInfo["table"];
		$sql = $this->db->addWhere($sql,$arrSearch);
		$datalist = $this->dbAll->all_pagingServer($aColumns, $sql);	
		echo json_encode($datalist);
	}
	/**
	 * 显示添加界面
	 */
	public function showaddAction()
	{
		$this->view->editType = 'add';
		self::getGlobalData();
		// !---------- BEGIN: CUSTOM ---------- //
		// !---------- END  : CUSTOM ---------- //
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/detail_ajax.phtml');
	}

	/**
	 * 显示修改界面
	 */
	public function showmodifyAction()
	{
		$this->view->editType = 'modify';
		$this->view->keyId = $_POST['keyId'];
		$data = $this->db->get($this->view->keyId);
		$this->view->dataDetail = $data["obj"];
		self::getGlobalData();
		// !---------- BEGIN: CUSTOM ---------- //
		// !---------- END  : CUSTOM ---------- //
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/detail_ajax.phtml');
	}

	/**
	 * 显示详细界面
	 */
	public function showdetailAction()
	{
		$this->view->editType = 'detail';
		$this->view->keyId = $_POST['keyId'];
		$data = $this->db->get($this->view->keyId);
		$this->view->dataDetail = $data["obj"];
		self::getGlobalData();
		// !---------- BEGIN: CUSTOM ---------- //
		// !---------- END  : CUSTOM ---------- //
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/detail_ajax.phtml');
	}

	/**
	 * 添加
	 */
	public function addAction()
	{
		$dataInfo = self:: getAddModifySameData();
		// !---------- BEGIN: CUSTOM ---------- //
		$dataInfo['insertuserid'] = $_SESSION[$this->view->sessionPrefix . 'username'];
		$dataInfo['inserttime'] = date('Y-m-d G:i:s');
		// !---------- END  : CUSTOM ---------- //
	
		$this->db->addData($dataInfo);
		$this->view->menuId = 'li' . $this->view->moduleName . $this->view->controllerName;
		echo $this->view->render('/all/views/refresh_ajax.phtml');
	}

	/**
	 * 修改
	 */
	public function modifyAction()
	{
		$dataInfo = self:: getAddModifySameData();
		$dataInfo[$this->view->dataGridInfo["keyid"]] = $_POST['keyId'];
		$dataInfo['modifyuserid'] = $_SESSION[$this->view->sessionPrefix . 'username'];
		$dataInfo['modifytime'] = date('Y-m-d G:i:s');
		$this->db->saveData($dataInfo);
		$this->view->menuId = 'li' . $this->view->moduleName . $this->view->controllerName;
		echo $this->view->render('/all/views/refresh_ajax.phtml');
	}
	
	/**
	 * 批量删除
	 */
	public function deleteAction()
	{
		$idString = $_POST['idString'];
		$idString = Ousu::idsChange($idString);
		$this->db->deleteData($idString);
		$arrSearch = self::setSearch();
		$sql = "SELECT * FROM ".$this->view->dataGridInfo["table"];
		$sql = $this->db->addWhere($sql,$arrSearch);
		$sql .= " LIMIT 1,15";
		$this->view->allDataList = $this->db->find($sql);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/list_ajax.phtml');
	}
	
	
	/**
	 * 提供调取数据的函数--ACTION
	 */
	public function getsearchdataAction()
	{	
		$sessionKey = $this->view->sessionPrefix.'Dialog_'.$this->view->moduleName.'_'.$this->view->controllerName;
		$_SESSION[$sessionKey] = array();
		$_SESSION[$sessionKey]['getsHidName'] = trim($_POST['getsHidName']);		
		$_SESSION[$sessionKey]['needfield'] = trim($_POST['needfield']);		
		$_SESSION[$sessionKey]['needClosText'] = trim($_POST['needClosText']);		
		$_SESSION[$sessionKey]['needSql'] = trim($_POST['needSql']);		
		$_SESSION[$sessionKey]['needFilter'] = trim($_POST['needFilter']);		
		$_SESSION[$sessionKey]['getsType'] = trim($_POST['getsType']);		
		$_SESSION[$sessionKey]['getsName'] = trim($_POST['getsName']);		
		$this->view->dlogtitle = trim($_POST['dlogtitle']);
		$this->view->dlogwidth = trim($_POST['dlogwidth']);
		$this->view->dlogheight = trim($_POST['dlogheight']);
		echo $this->view->render('/all/views/bridgepage.phtml');
	}
	
	/**
	 * 查询内容显示
	 */
	public function contentshowAction()
	{
		$sessionKey = $this->view->sessionPrefix.'Dialog_'.$this->view->moduleName.'_'.$this->view->controllerName;
		$this->view->searchlabel = 'search';
		$this->view->getsHidName = trim($_SESSION[$sessionKey]['getsHidName']);
		$this->view->stateNum = 0; //判断处理分支(0单id操作,1多数据操作)
		$needFilter = $_SESSION[$sessionKey]['needFilter'];
		if($_SESSION[$sessionKey]['needClosText']==="true")
		{
			$this->view->stateNum = 1;
			$this->view->getsType = explode(',', trim($_SESSION[$sessionKey]['getsType']));
			$this->view->getsName = explode(',', trim($_SESSION[$sessionKey]['getsName']));
		}
		else unset($_SESSION[$sessionKey]);
		echo $this->view->render('/main/views/loadsearchjs.phtml');
		if(!empty($needFilter)) {
			$needFilter = explode(',', trim($needFilter));
			$newserArr = array();
			$filterArr = array();
			foreach ($needFilter as $arr) {
				$newserArr = explode('=',$arr);
				$arrkey = $newserArr[0];
				$arrvalue = $newserArr[1];
				$filterArr[$arrkey] = $arrvalue;
			}
			$sessionKey = $this->view->sessionPrefix.'Filter_'.$this->view->moduleName.'_'.$this->view->controllerName;
			$_SESSION[$sessionKey] = array();
			foreach ($filterArr as $key=>$value)
				$_SESSION[$sessionKey][$key] = $value;
		}
		$arrSearch = self::setSearch();
		$this->view->allDataList = $this->db->searchData($arrSearch);
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/top_data.phtml');
	}
	
	/**
	 * 获取数据
	 */
	public function readydataAction()
	{
		$sessionKey = $this->view->sessionPrefix.'Dialog_'.$this->view->moduleName.'_'.$this->view->controllerName;
		$needSql = $_SESSION[$sessionKey]['needSql'];
		$needfield = explode(',', trim($_SESSION[$sessionKey]['needfield']));
		$keyid = $_POST['serkeyid'];
		unset($_SESSION[$sessionKey]);
		if(!empty($needSql)){
			$needSql = str_replace('{<key>}', $keyid, $needSql);
			$result =$this->dbAll->getCustomSqlOne($needSql); 
		}
		else
			$result = $this->db->getDataDetail($keyid);
		$res = "";
		foreach ($needfield as $fieldname)
			$res.= ",".$result[$fieldname];
		$res = substr($res,1);
		echo $res;
	}
}