<?php

class baseDao 
{
	private $table;
	private $keyId;
	private $basePageModel;
	private $baseDbModel;
	
	public function __construct()
	{
		require APPLICATION_PATH . '/modules/all/models/ousu_ini_db.php'; // !--- COPY --- //
		$this->basePageModel = new basePageModel(); 
	}

	public function getTable(){
		return $this->table;
	}
	
	public function setTable($table)
	{
		$this->table = $table;
	}
	
	public function getDbModel(){
		return $this->baseDbModel;
	}
	
	public function setDbModel($baseDbModel)
	{
		$this->baseDbModel = $baseDbModel;
	}
		
	public function getKeyId(){
		return $this->keyId;
	}
	
	public function setKeyId($keyId)
	{
		$this->keyId = $keyId;
	}
	
	public function copyDbFromPOSTWithSearch($pageModal,$post){
		$result = array();
		foreach ($pageModal["fields"] as $key => $value){
			$field = $value["field"];
			if (isset($post[$field])&&$post[$field]!="")
				$result["%".$field] = "%".$post[$field];
		}
		foreach ($pageModal["searchType"] as $key => $value){
			if ($value["type"] == "between"){
				if (isset($post[$value["start"]])&&$post[$value["start"]]!="")
					$result[">".$key] = ">".$post[$value["start"]];
				if (isset($post[$value["end"]])&&$post[$value["end"]]!="")
					$result["<".$key] = "<".$post[$value["end"]];
			}
		}
		return $result;
	}
	
	public function copyDbFromPOST($pageModal,$post){
		$result = array();
		foreach ($pageModal["fields"] as $key => $value){
			$field = $value["field"];
			if (isset($post[$field]))
				$result[$field] = $post[$field];
		}
		return $result;
	}
	/**
	 * 获取单个记录
	 * @param string $id, boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function get($id,$transaction = true)
	{
		$result = array();
		try {
			$sql = "SELECT * FROM $this->table WHERE $this->keyId = '".$id."'";
			$row = $this->dbAdapter->fetchRow($sql);
			$this->logger->debug("[$this->table]获取一条记录 : $id");
			$result = Ousu::getJsonResult();
			$result["success"] = true;
			$result["msg"] = "查询成功!";
			$result["obj"] = $row;
			return $result;
		} catch (Exception $e) {
			$err =$e->getMessage(); 
			$this->logger->err("[$this->table]获得数据错误 : $err" );
			$result = Ousu::getJsonResult();
			$result["success"] = false;
			$result["msg"] = $err;
			return $result;
		}
	}
	
	/**
	 * 查询
	 * @param string $sql,array $params,boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function findWithParams($sql,$params,$transaction = true)
	{
		$result = array();
		try {
			$rows = $this->dbAdapter->fetchAll($sql,$params);
			$this->logger->debug("查询数据库 : [$sql] 查询到[".sizeof($rows)."]行");
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
	 * 查询
	 * @param string $sql,boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function find($sql,$transaction = true)
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
	 * 添加记录
	 * @param array $dataInfo, boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function addData($dataInfo,$transaction = true)
	{
		if ($transaction)
			$this->dbAdapter->beginTransaction();
		$result = array();
		try {
			$row = $dataInfo;
			$rows_affected = $this->dbAdapter->insert($this->table, $row);
			$sql = Zend_Json::encode($dataInfo);
			$this->logger->info("[$this->table]插入成功 : $sql");
			if ($transaction)
				$this->dbAdapter->commit();
			$result = Ousu::getJsonResult();
			$result["success"] = true;
			$result["msg"] = "添加成功";
			$result["obj"] = $dataInfo;
			return $result;
		} catch (Exception $e) {
			if ($transaction)
				$this->dbAdapter->rollBack();
			$err =$e->getMessage(); 
			$this->logger->err("[$this->table]插入错误 : $err" );
			$result = Ousu::getJsonResult();
			$result["success"] = false;
			$result["msg"] = $err;
			return $result;
		}
	}
	/**
	 * 更新记录
	 * @param array $dataInfo, boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function saveData($dataInfo,$transaction = true)
	{	
			if ($transaction)
				$this->dbAdapter->beginTransaction();
			$result = array();
			try {
				$where = "$this->keyId='".$dataInfo[$this->keyId]."'";
				$rows_affected = $this->dbAdapter->update($this->table,$dataInfo,$where);
				$sql = Zend_Json::encode($dataInfo);
				$this->logger->info("[$this->table]更新成功 : $sql");
				if ($transaction)
					$this->dbAdapter->commit();
				$result = Ousu::getJsonResult();
				$result["success"] = true;
				$result["msg"] = "数据更新成功";
				$result["obj"] = $dataInfo;
				return $result;
			} catch (Exception $e) {
				if ($transaction)
					$this->dbAdapter->rollBack();
				$err =$e->getMessage(); 
				$this->logger->err("[$this->table]更新错误 : $err" );
				$result = Ousu::getJsonResult();
				$result["success"] = false;
				$result["msg"] = $err;
				return $result;
			}
	}
	/**
	 * 批量删除
	 * @param string $idString, boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function deleteData($idString,$transaction = true)
	{
		if ($transaction)
			$this->dbAdapter->beginTransaction();
		$result = array();
		try {
			$where ="$this->keyId IN($idString)";
			$rows_affected = $this->dbAdapter->delete($this->table, $where);
			$sql = Zend_Json::encode($idString);
			$this->logger->info("[$this->table]删除成功 : $sql");
			if ($transaction)
				$this->dbAdapter->commit();
			$result = Ousu::getJsonResult();
			$result["success"] = true;
			$result["msg"] = "删除成功!";
			return $result;
		} catch (Exception $e) {
			if ($transaction)
				$this->dbAdapter->rollBack();
			$err = $e->getMessage();
			$this->logger->err("[$this->table]删除错误 : $err");
			$result = Ousu::getJsonResult();
			$result["success"] = false;
			$result["msg"] = $err;
			return $result;
		}
	}

	/**
	 * 统计记录数
	 * @param string $sql
	 * @return array $JsonResult
	 */
	public function count($sql)
	{
		$result = array();
		try {
			if (($sql == null) || ($sql == "")){
				$sql = "select count(*) from $this->table";
				$count =$this->dbAdapter->fetchOne($sql);
				$this->logger->debug("[$this->table]查询记录数 ");
				$result = Ousu::getJsonResult();
			$result["success"] = true;
				$result["msg"] = "查询记录数成功!";
				$result["obj"] = $count[0][0];
				return $result;
			}
			else{
				$rows =$this->dbAdapter->fetchAll($sql);
				$this->logger->debug("[$this->table]查询记录数 ");
				$result = Ousu::getJsonResult();
				$result["success"] = true;
				$result["msg"] = "查询记录数成功!";
				$result["obj"] = sizeof($rows);
				return $result;
			}
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
	 * 统计记录数带参数
	 * @param string $sql,array $params
	 * @return array $JsonResult
	 */
	public function countWithParams($sql,$params)
	{
		$result = array();
		try {
			$count =$this->dbAdapter->fetchAll($sql,$params);
			$this->logger->debug("[$this->table]查询记录数 ");
			$result = Ousu::getJsonResult();
			$result["success"] = true;
			$result["msg"] = "查询记录数成功!";
			$result["obj"] = $count[0][0];
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
	 * 数据表格查询
	 * @param array $params, boolean $transaction = true
	 * @return array $JsonResult
	 */
	public function datagrid($params,$transaction = true)
	{
		$result = array();
		try {
			$sql = "Select * From $this->table";
			$datagrid = basePageModel::getDataGrid();
			$datagrid = Ousu::copyProperty($params, $datagrid);
			$dbModel = $this->copyDbFromPOSTWithSearch($this->baseDbModel, $params);
			$sql = $this->addWhere($sql,$dbModel);
			$stmt =$this->dbAdapter->query($sql);
			$count = $stmt->fetchAll();
			$datagrid["total"] = sizeof($count);
			$sql = $this->addOrder($sql, $datagrid);
			$sql = $this->addLimit($sql,$datagrid);
			$stmt =$this->dbAdapter->query($sql);
			$rows = $stmt->fetchAll();
			$datagrid["rows"] = $rows;
			$this->logger->debug("[$this->table]显示datagrid : [$sql]");
			$result = Ousu::getJsonResult();
			$result["success"] = true;
			$result["msg"] = "查询记录数成功!";
			$result["obj"] = $datagrid;
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
	
	public function addWhere($sql,$params){
		$sql .= " where 1=1 ";
		foreach($params as $key => $value){
			if ((substr($value,0,1)=="%")&&(substr($value,1)!= "" ))
				$sql .= " and  ".substr($key,1)." like '%%".substr($value,1)."%%' ";
			if ((substr($value,0,1)=="=")&&(substr($value,1)!= "" ))
				$sql .= " and  ".substr($key,1)." = '".substr($value,1)."' ";
			if ((substr($value,0,1)==">")&&(substr($value,1)!= "" ))
				$sql .= " and ".substr($key,1)." >= '".substr($value,1)."' ";
			if ((substr($value,0,1)=="<")&&(substr($value,1)!= "" ))
				$sql .= " and ".substr($key,1)." <= '".substr($value,1)."' ";
			if ((substr($value,0,1)=="!")&&(substr($value,1)!= "" ))
				$sql .= " and ".substr($key,1)." != '".substr($value,1)."' ";
		}
		
		
		return $sql;
	}
	
	public function addOrder($sql,$params){
		
		$sql .= " order by ".$params['sort']." ".$params['order']." ";
		return $sql;
	}

	private function addLimit($sql,$params){
		$start = ($params["page"] - 1) * $params["rows"];
		$sql .= " LIMIT ".$start.",".$params["rows"]." ";
		return $sql;
	}
	
}