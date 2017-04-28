<?php
//判断用户是否登录
if (empty($_SESSION[$this->view->sessionPrefix . 'username'])) {
	$url = $this->view->baseUrl() . '/login';
	echo "<script>window.location.href = '$url';</script>";
}
else 
	$this->loginUser=$_SESSION[$this->view->sessionPrefix . 'username'];
//获取controller权限
$this->view->controllerRights = $this->dbAll->all_getMaxRights($this->view->moduleName, $this->view->controllerName, '');
$this->dbAll->all_authRights($this->view->controllerRights[1]); //验证controller写权限

switch ($this->view->actionName) {
	case 'index':
		$this->dbAll->all_authRights($this->view->controllerRights[0]); //验证controller读权限
		break;
	default:
		$this->view->actionRights = $this->dbAll->all_getMaxRights($this->view->moduleName, $this->view->controllerName, $this->view->actionName);
		$this->dbAll->all_authRights($this->view->actionRights[1]); //验证action写权限
		break;
}

//获取登录用户在此item下的最大节点值（逗号隔开）
$this->maxControllerDsVal = $this->dbAll->all_getMaxDsVal($this->view->moduleName, $this->view->controllerName, '');
