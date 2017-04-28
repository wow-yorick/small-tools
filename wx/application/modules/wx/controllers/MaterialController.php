<?php
class Wx_MaterialController extends Zend_Controller_Action
{

    public function init()
    {
        require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_controller.php'; // !--- COPY --- //
		require_once APPLICATION_PATH . '/modules/all/models/ousu_ini_rights.php'; // !--- COPY --- //
    }
    
    public static function setSql(){
    	return $sql ="SELECT Id,fromUsername,toUserName,createTime,msgType,event as a,eventKey as b,'c','d','e' FROM wx_msg_event union 
			SELECT *,'c','d','e' FROM wx_msg_image union
			SELECT *,'e'  FROM wx_msg_link union
			SELECT *  FROM wx_msg_location union
			SELECT *,'c','d','e' FROM wx_msg_text";
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
	
	
	public function indexAction()
	{
		$sessionKey = $this->view->sessionPrefix.'Filter_'.$this->view->moduleName.'_'.$this->view->controllerName;
		unset($_SESSION[$sessionKey]);
		$sessionKey = $this->view->sessionPrefix.'Dialog_'.$this->view->moduleName.'_'.$this->view->controllerName;
		unset($_SESSION[$sessionKey]);
		$arrSearch = self::setSearch();
		$sql = self::setSql();
		$sql = $this->db->addWhere($sql,$arrSearch);
		$parm = array(
			'sort' =>'createTime'
			,'order' => 'DESC'
		);
		$sql = $this->db->addOrder($sql,$parm);
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
		$allDataList = $this->db->find($sql);
		$this->view->allDataList = $allDataList["obj"];
		echo $this->view->render('/' . $this->view->moduleName . '/views/' . $this->view->controllerName . '/list_ajax.phtml');
	}


}

