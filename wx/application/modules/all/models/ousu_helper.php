<?php

class all_model_ousu_helper extends Zend_View_Helper_Abstract
{
	public function __construct()
	{
		$this->view = Zend_Registry::get('view');
	}

	function dump($vars, $output = TRUE)
	{
		$content = "<div align=left><pre>\n" . htmlspecialchars(print_r($vars, true)) . "\n</pre></div>\n";
		$content .= " -------------------------------------------------------------------------- \n";
		if(TRUE != $output) { return $content; }
		echo $content;
		return null;
	}

	/**
	 * 静态方法，echo出参数的内容
	 * @param object $vars  要打印的参数
	 * @param bool  $output 为true，则返回要打印的字符串
	 * @return
	 */
	public static function ousu_dump($vars, $output = true)
	{
		header("Content-type: text/html; charset=utf-8");
		if ($output) {
			$content = "<div align=left><pre>\n" . htmlspecialchars(print_r($vars, true)) . "\n</pre></div>\n";
			$content .= " -------------------------------------------------------------------------- \n";
			echo $content;
		} else {
			$content = htmlspecialchars(print_r($vars, true)) ;
			$content .= "\n-------------------------------------------------------------------------- \n";
			return $content;
		}
	}

	public static function ousu_dump_alert($vars, $output = true)
	{
		$content = "<div align=left><pre>\n" . htmlspecialchars(print_r($vars, true)) . "\n</pre></div>\n";
		$content .= " -------------------------------------------------------------------------- \n";
		if(true != $output) {
			return $content;
		}
		echo "<script>alert('" . $content . "');</script>";
	}

	function getHTMLselect($gridinfo,$fieldname,$datavalue,$keyfield,$dispfield)
	{
		$result = "";
		if ($gridinfo["searchfield"][$fieldname]["type"] == "select")
		{
			$result .= "<td>".$gridinfo["searchfield"][$fieldname]["dispname"]."</td>";
			if (isset($gridinfo["searchfield"][$fieldname]["colspan"])) {
				$result .= "<td colspan=".$gridinfo["searchfield"][$fieldname]["colspan"].">"; }
			else {
				$result .= "<td>"; }
			$result .= "<select id='".$gridinfo["searchfield"][$fieldname]["name"]."' name='".$gridinfo["searchfield"][$fieldname]["name"]."' class='".$gridinfo["searchfield"][$fieldname]["class"]."'>";
			$result .= "<option></option>";
			if(isset($datavalue))
			{
				foreach ($datavalue as $arrSub)
				{
					$result .="<option value='".$arrSub[$keyfield]."'>".$arrSub[$dispfield]."</option>";
				}
			}
			$result .= "</select></td>";
		}
		return $result;
	}

	function getHTMLinput($gridinfo,$fieldname)
	{
		$result = "";
		if ($gridinfo["searchfield"][$fieldname]["type"] == "input")
		{
			$result .= "<td>".$gridinfo["searchfield"][$fieldname]["dispname"]."</td>";
			if (isset($gridinfo["searchfield"][$fieldname]["colspan"])) {
			  $result .= "<td colspan=".$gridinfo["searchfield"][$fieldname]["colspan"]."><input name='"; }
			else {
			  $result .="<td><input name='"; }
			$result .= $gridinfo["searchfield"][$fieldname]["name"]."' type='text' class='";
			$result .= $gridinfo["searchfield"][$fieldname]["class"]."' /></td>";
		}
		return $result;
	}

	function getHTMLDate($gridinfo,$fieldname)
	{
		$result = "";
		if ($gridinfo["searchfield"][$fieldname]["type"] == "date")
		{
			$result .= "<td>".$gridinfo["searchfield"][$fieldname]["dispname"]."</td>";
			if (isset($gridinfo["searchfield"][$fieldname]["colspan"])) {
			  $result .= "<td colspan=".$gridinfo["searchfield"][$fieldname]["colspan"]."><input name='"; }
			else {
			  $result .="<td><input name='";
			  }
			$result .= $gridinfo["searchfield"][$fieldname]["name"]."' type='text' ";
			$result .= "onFocus='WdatePicker({isShowClear:true,readOnly:true})' class='Wdate ";
			$result .= $gridinfo["searchfield"][$fieldname]["class"]."' /></td>";
		}
		return $result;
	}

	/*
	function getHTMLDialog($menuinfo)
	{
		$result = "";
		if(isset($menuinfo['dialog']))
		{
			$result .=  "<button class='data-detail-input wiliz-btn' onclick='dialogProductSearch(this);'>".$menuinfo['dialog']['title']."</button>";
			$result .=  "<div id='";
			$result .= 	'div'.$menuinfo['dialog']['divname']."'></div>";
		}
		return $result;
	}

	*/


	// getSynclistinput 生成ajax列表
	// $data 数据库查询结果集
	// $keyid id值
	// $value 显示值
	function getSynclistinput($data,$keyid,$value)
	{
		$result = "<option></option>";
		if (isset($data))
		foreach($data as $subArr)
		{
			$result .= "<option value='".$subArr[$keyid]."'>".$subArr[$value]."</option>";
		}
		return $result;
	}

	// getHTMLmenubuttonBig 生成菜单按钮,(为大按钮,图片上,文字下)
	// $menuinfo 菜单定义结构
	// $menuarea 菜单块, basemenu,searchmenu,othermenu等
	// $buttonname 需要生成的按钮
	function getHTMLmenubuttonBig($menuinfo,$menuarea,$buttonname)
	{
		$result = "";
		if (isset($menuinfo[$menuarea][$buttonname]))
		{
			$baseUrl = Zend_Controller_Front::getInstance()->getRequest()->getBaseUrl();
			$result .= "<div id=".$menuinfo[$menuarea][$buttonname]["itemname"]." disabled='disabled'";
			$result .= " state='disabled' imgname='".$menuinfo[$menuarea][$buttonname]["imgname"]."' style='margin:0 3px;'";
			$result .= " onclick=\"".$menuinfo[$menuarea][$buttonname]["onclick"]."\" >";
			$result .= " <img src='".$baseUrl."/img/".$menuinfo[$menuarea][$buttonname]["imgname"]."-disabled.png' ";
			$result .= " class='content-menu-item-img' /><label style='white-space:nowrap;display:block;'>".$menuinfo[$menuarea][$buttonname]["dispname"]."</label></div>";
		}
		return $result;
	}

	// getHTMLmenubuttonSmall 生成菜单按钮,(为上下2个小按钮,图片左,文字右 (只生成2个))
	// $menuinfo 菜单定义结构
	// $menuarea 菜单块, basemenu,searchmenu,othermenu等
	// $buttonname array(), 需要生成的按钮组
	function getHTMLmenubuttonSmall($menuinfo,$menuarea,$buttonname)
	{
		$result = "";
		if (isset($menuinfo[$menuarea][$buttonname[0]]))
		{
			$baseUrl = Zend_Controller_Front::getInstance()->getRequest()->getBaseUrl();
			$result .= "<div style='margin:1px 10px;'>";
			$result .= " <div id=".$menuinfo[$menuarea][$buttonname[0]]["itemname"]." disabled='disabled'";
			$result .= " state='disabled' imgname=".$menuinfo[$menuarea][$buttonname[0]]["imgname"];
			$result .= " onclick=\"".$menuinfo[$menuarea][$buttonname[0]]["onclick"]."\">";
			$result .= " <img src='".$baseUrl."/img/".$menuinfo[$menuarea][$buttonname[0]]["imgname"]."-disabled.png' ";
			$result .= " class='content-menu-item-imgs' /><label>".$menuinfo[$menuarea][$buttonname[0]]["dispname"]."</label></div>";
			$result .= " <div id=".$menuinfo[$menuarea][$buttonname[1]]["itemname"]." disabled='disabled'";
			$result .= " state='disabled' imgname=".$menuinfo[$menuarea][$buttonname[1]]["imgname"];
			$result .= " onclick=\"".$menuinfo[$menuarea][$buttonname[1]]["onclick"]."\">";
			$result .= " <img src='".$baseUrl."/img/".$menuinfo[$menuarea][$buttonname[1]]["imgname"]."-disabled.png' ";
			$result .= " class='content-menu-item-imgs' /><label>".$menuinfo[$menuarea][$buttonname[1]]["dispname"]."</label></div>";
			$result .= "</div>";
		}
		return $result;
	}

	// getHTMLbasemenu 生成基本菜单
	// $menuinfo 菜单定义结构
	function getHTMLbasemenu($menuinfo)
	{
		$result = "";
		if ($menuinfo["menuvisiable"]["basemenu"] == "1" )
		{
			$result .= "<td><div class='content-menu-item'><table><tr><td><table><tr>";
			$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonAdd")."</td>";
			$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonModify")."</td>";
			$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonDelete")."</td>";
			$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonDetail")."</td>";
			$result .= "</tr></table></td></tr>";
			$result .= "<tr><td class='content-menu-item-bottom'><label>".$menuinfo["menuvisiable"]["basename"];
			$result .= "</label></td></tr></table></div></td>";
			$result .= "<td><div class='content-menu-item'><table><tr>";
			$result .= "<td>".$this->getHTMLmenubuttonSmall($menuinfo,"basemenu",array("buttonSubmit","buttonCancel"))."</td>";
			$result .= "</tr><tr><td class='content-menu-item-bottom' colspan='2'><label>提&nbsp;交</label>";
			$result .= "</td></tr></table></div></td>";
		}
		return $result;
	}
	// getHTMLbasemenuWithright 生成基本菜单带权限
	// $menuinfo 菜单定义结构
	function getHTMLbasemenuWithright($menuinfo)
	{
		$result = "";
		if ($menuinfo["menuvisiable"]["basemenu"] == "1" )
		{
			$result .= "<td><div class='content-menu-item'><table><tr><td><table><tr>";
			//添加按钮
			if (isset($this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":add"]) && $this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":add"][0] == 0) {
				$result .= "<td style='display:none;'>".getHTMLmenubuttonBig($menuinfo,"basemenu","buttonAdd")."</td>";
			} else if (isset($this->view->allActionRights[$menuinfo["menuvisiable"]["addactionname"]])) { //添加按钮（新）
				if ($this->view->allActionRights[$menuinfo["menuvisiable"]["addactionname"]][0] == 0) {
					$result .= "<td style='display:none;'>".getHTMLmenubuttonBig($menuinfo,"basemenu","buttonAdd")."</td>";
				}
			} else {
				$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonAdd")."</td>";
			}
			//修改按钮
			if (isset($this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":modify"]) && $this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":modify"][0] == 0) {
				$result .= "<td style='display:none;'>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonModify")."</td>";
			} else if (isset($this->view->allActionRights[$menuinfo["menuvisiable"]["modifyactionname"]]) && $this->view->allActionRights[$menuinfo["menuvisiable"]["modifyactionname"]][0] == 0) { //修改按钮（新）
				$result .= "<td style='display:none;'>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonModify")."</td>";
			} else {
				$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonModify")."</td>";
			}
			//删除按钮
			if (isset($this->view->allActionRights[$menuinfo["menuvisiable"]["deleteactionname"]]) && $this->view->allActionRights[$menuinfo["menuvisiable"]["deleteactionname"]][0] == 0) {
				$result .= "<td style='display:none;'>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonDelete")."</td>";
			} else {
				$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonDelete")."</td>";
			}
			//详细按钮
			if (isset($this->view->allActionRights[$menuinfo["menuvisiable"]["detailactionname"]]) && $this->view->allActionRights[$menuinfo["menuvisiable"]["detailactionname"]][0] == 0) {
				$result .= "<td style='display:none;'>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonDetail")."</td>";
			} else {
				$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"basemenu","buttonDetail")."</td>";
			}
			$result .= "</tr></table></td></tr>";
			$result .= "<tr><td class='content-menu-item-bottom'><label>".$menuinfo["menuvisiable"]["basename"];
			$result .= "</label></td></tr></table></div></td>";
			//确认、取消按钮
			if (empty($this->view->allActionRights)) {
				$result .= "<td><div class='content-menu-item'><table><tr>";
				$result .= "<td>".$this->getHTMLmenubuttonSmall($menuinfo,"basemenu",array("buttonSubmit","buttonCancel"))."</td>";
				$result .= "</tr><tr><td class='content-menu-item-bottom' colspan='2'><label>提&nbsp;交</label>";
				$result .= "</td></tr></table></div></td>";
			} else if (isset($this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":add"][0]) || isset($this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":modify"][0])) {
				if (!($this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":add"][0] === 0 && $this->view->allActionRights[$menuinfo["menuvisiable"]["addmodifyactionname"].":modify"][0] === 0)) {
					$result .= "<td><div class='content-menu-item'><table><tr>";
					$result .= "<td>".$this->getHTMLmenubuttonSmall($menuinfo,"basemenu",array("buttonSubmit","buttonCancel"))."</td>";
					$result .= "</tr><tr><td class='content-menu-item-bottom' colspan='2'><label>提&nbsp;交</label>";
					$result .= "</td></tr></table></div></td>";
				}
			}
		}
		return $result;
	}
	// getHTMLothermenu 生成其他菜单
	// $menuinfo 菜单定义结构
	function getHTMLothermenu($menuinfo)
	{
		$result = "";
		if ($menuinfo["menuvisiable"]["othermenu"] == "1" )
		{
			$result .= "<td><div class='content-menu-item'><table><tr><td><table><tr>";
			foreach($menuinfo["othermenu"] as $menu)
			{
				$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"othermenu",$menu["itemname"])."</td>";
			}
			$result .= "</tr></table></td></tr>";
			$result .= "<tr><td class='content-menu-item-bottom'><label>".$menuinfo["menuvisiable"]["othername"];
			$result .= "</label></td></tr></table></div></td>";
		}
		return $result;
	}
	// getHTMLothermenuWithright 生成其他菜单
	// $menuinfo 菜单定义结构
	function getHTMLothermenuWithright($menuinfo)
	{
		$result = "";
		if ($menuinfo["menuvisiable"]["othermenu"] == "1" )
		{
			$result .= "<td><div class='content-menu-item'><table><tr><td><table><tr>";
			foreach($menuinfo["othermenu"] as $menu)
			{
				if (isset($this->view->allActionRights[$menuinfo["othermenu"][$menu["itemname"]]["actionname"]]) && $this->view->allActionRights[$menuinfo["othermenu"][$menu["itemname"]]["actionname"]][0] == 0) {
					$result .= "<td style='display:none;'>".$this->getHTMLmenubuttonBig($menuinfo,"othermenu",$menu["itemname"])."</td>";
				} else {
					$result .= "<td>".$this->getHTMLmenubuttonBig($menuinfo,"othermenu",$menu["itemname"])."</td>";
				}
			}
			$result .= "</tr></table></td></tr>";
			$result .= "<tr><td class='content-menu-item-bottom'><label>".$menuinfo["menuvisiable"]["othername"];
			$result .= "</label></td></tr></table></div></td>";
		}
		return $result;
	}
	// getHTMLaccordion 生成动态菜单
	// $menuinfo 菜单定义结构
	function getHTMLaccordion ($menuinfo)
	{
		$result = "";
		if($menuinfo["menuvisiable"]["menuaccordion"] == "1" ){
			$baseUrl = Zend_Controller_Front::getInstance()->getRequest()->getBaseUrl();
			$result.= "<script language='javascript' type='text/javascript' src='" . $baseUrl . "/js/jquery.easyAccordion.js'></script> ";
			$result.= "<style> ";
			$result.= ".easy-accordion{display:block;position:relative;overflow:hidden;padding:0;margin:0} ";
			$result.= ".easy-accordion dt,.easy-accordion dd{margin:0;padding:0} ";
			$result.= ".easy-accordion dt,.easy-accordion dd{position:absolute} ";
			$result.= ".easy-accordion dt{margin-bottom:0;margin-left:0;z-index:5;/* Safari */ -webkit-transform: rotate(-90deg); /* Firefox */ -moz-transform: rotate(-90deg);-moz-transform-origin: 20px 0px;  /* Internet Explorer */ filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);cursor:pointer;} ";
			$result.= ".easy-accordion dd{z-index:1;opacity:0;overflow:hidden} ";
			$result.= ".easy-accordion dd.active{opacity:1;} ";
			$result.= ".easy-accordion dd.no-more-active{z-index:2;opacity:1} ";
			$result.= ".easy-accordion dd.active{z-index:3} ";
			$result.= ".easy-accordion dd.plus{z-index:4} ";
			$result.= ".easy-accordion .slide-number{position:absolute;bottom:2;left:2px;font-weight:normal;/* Safari */ -webkit-transform: rotate(90deg); /* Firefox */ -moz-transform: rotate(90deg);  /* Internet Explorer */ filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=1);} ";
			$result.= "#accordion {width:100%;height:135px;} ";
			$result.= "#accordion dl{width:100%;height:135px;} ";
			$result.= "#accordion dt{height:30px;line-height:30px;text-align:right;padding:2px 15px 0 0;font-weight:bold;letter-spacing:5px;background:#eee url('" . $baseUrl . "/img/slide-title-inactive-1.jpg') 0 0 no-repeat;color:#26526c} ";
			$result.= "#accordion dt.active{cursor:pointer;color:#fff;background:#333 url('" . $baseUrl . "/img/slide-title-active-2.jpg') 0 0 no-repeat} ";
			$result.= "#accordion dt.active.hover{color:#333} ";
			$result.= "#accordion dd{background:url('" . $baseurl . "/img/slide.jpg') bottom left repeat-x;border:1px solid #dbe9ea;} ";
			$result.= "#accordion .slide-number{color:#68889b;left:10px;bottom:15px;font-weight:bold} ";
			$result.= "#accordion .active .slide-number{color:#fff} ";
			$result.= "</style> ";

			$result.= "<script> ";
			$result.= "$(document).ready(function () { ";
			$result.= "    $('#accordion').easyAccordion({ ";
			$result.= "        autoStart: false ";
			$result.= "    }); ";
			$result.= "}); ";
			$result.= "</script> ";
		}
		return $result;
	}


/************************************** BEGIN: 多表模板使用 ***********************************************/
	/*
	 * 获取label标签的html
	 */
	function getHtml_label($tagInfo)
	{
		$result = '<label';
		if (isset($tagInfo['id'])) { //id属性
			$result .= ' id="' . $tagInfo['id'] . '"';
		}
		if (isset($tagInfo['name'])) { //name属性
			$result .= ' name="' . $tagInfo['name'] . '"';
		}
		if (isset($tagInfo['value'])) { //value属性
			$result .= ' value="' . $tagInfo['value'] . '"';
		}
		if (isset($tagInfo['class'])) { //class
			$result .= ' class="' . $tagInfo['class'] . '"';
		}
		if (isset($tagInfo['attr']) && sizeof($tagInfo['attr']) > 0) { //自定义属性
			foreach ($tagInfo['attr'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		if (isset($tagInfo['event']) && sizeof($tagInfo['event']) > 0) { //事件
			foreach ($tagInfo['event'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		if (isset($tagInfo['style'])) { //CSS
			$result .= ' style="' . $tagInfo['style'] . '"';
		}
		$result .= ' >';
		if (isset($tagInfo['text'])) { //文本值
			$result .= $tagInfo['text'];
		}
		$result .= '</label>';
		return $result;
	}

	/*
	 * 获取text标签的html
	 */
	function getHtml_text($tagInfo)
	{
		$result = '<input type="text"';
		if (isset($tagInfo['id'])) { //id属性
			$result .= ' id="' . $tagInfo['id'] . '"';
		}
		if (isset($tagInfo['name'])) { //name属性
			$result .= ' name="' . $tagInfo['name'] . '"';
		}
		if (isset($tagInfo['value'])) { //value属性
			$result .= ' value="' . $tagInfo['value'] . '"';
		}
		if (isset($tagInfo['class'])) { //class
			$result .= ' class="' . $tagInfo['class'] . '"';
		}
		if (isset($tagInfo['attr']) && sizeof($tagInfo['attr']) > 0) { //自定义属性
			foreach ($tagInfo['attr'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		if (isset($tagInfo['event']) && sizeof($tagInfo['event']) > 0) { //事件
			foreach ($tagInfo['event'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		if (isset($tagInfo['style'])) { //CSS
			$result .= ' style="' . $tagInfo['style'] . '"';
		}
		$result .= ' />';
		return $result;
	}

	/*
	 * 获取date标签的html
	 */
	function getHtml_date($tagInfo)
	{
		$result = '<input type="text"';
		if (isset($tagInfo['id'])) { //id属性
			$result .= ' id="' . $tagInfo['id'] . '"';
		}
		if (isset($tagInfo['name'])) { //name属性
			$result .= ' name="' . $tagInfo['name'] . '"';
		}
		if (isset($tagInfo['value'])) { //value属性
			$result .= ' value="' . $tagInfo['value'] . '"';
		}
		$result .= ' class="Wdate"';
		if (isset($tagInfo['class'])) { //class
			$result .= ' class="' . $tagInfo['class'] . '"';
		}
		if (isset($tagInfo['attr']) && sizeof($tagInfo['attr']) > 0) { //自定义属性
			foreach ($tagInfo['attr'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		$result .= ' onFocus="WdatePicker({' . $tagInfo['plugconfig'] . '});"';
		if (isset($tagInfo['event']) && sizeof($tagInfo['event']) > 0) { //事件
			foreach ($tagInfo['event'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		if (isset($tagInfo['style'])) { //CSS
			$result .= ' style="' . $tagInfo['style'] . '"';
		}
		$result .= ' />';
		return $result;
	}

	/*
	 * 获取select标签的html
	 */
	function getHtml_select($tagInfo)
	{
		$result = '<select';
		if (isset($tagInfo['id'])) { //id属性
			$result .= ' id="' . $tagInfo['id'] . '"';
		}
		if (isset($tagInfo['name'])) { //name属性
			$result .= ' name="' . $tagInfo['name'] . '"';
		}
		if (isset($tagInfo['value'])) { //value属性
			$result .= ' value="' . $tagInfo['value'] . '"';
		}
		if (isset($tagInfo['class'])) { //class
			$result .= ' class="' . $tagInfo['class'] . '"';
		}
		if (isset($tagInfo['attr']) && sizeof($tagInfo['attr']) > 0) { //自定义属性
			foreach ($tagInfo['attr'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		if (isset($tagInfo['event']) && sizeof($tagInfo['event']) > 0) { //事件
			foreach ($tagInfo['event'] as $key=>$val) {
				$result .= ' ' . $key . '="' . $val . '"';
			}
		}
		if (isset($tagInfo['style'])) { //CSS
			$result .= ' style="' . $tagInfo['style'] . '"';
		}
		$result .= '><option></option>';
		if (isset($tagInfo['datasource']) && $tagInfo['datasource'] > 0) { //options
			if (isset($tagInfo['optAttr']) || isset($tagInfo['optAttrDb'])) { //option的自定义属性
				foreach ($tagInfo['datasource'] as $arrSub) {
					$result .= '<option';
					if (isset($tagInfo['optAttr'])) {
						foreach ($tagInfo['optAttr'] as $key=>$val) $result .= ' ' . $key . '="' . $val . '"';
					}
					if (isset($tagInfo['optAttrDb'])) {
						foreach ($tagInfo['optAttrDb'] as $key=>$val) $result .= ' ' . $key . '="' . $arrSub[$val] . '"';
					}
					$result .= ' value="' . $arrSub[$tagInfo['valField']] . '">' . $arrSub[$tagInfo['txtField']] . '</option>';
				}
			} else {
				foreach ($tagInfo['datasource'] as $arrSub) {
					$result .= '<option value="' . $arrSub[$tagInfo['valField']] . '">' . $arrSub[$tagInfo['txtField']] . '</option>';
				}
			}
		}
		$result .= '</select>';
		return $result;
	}

	/*
	 * 获取select标签的html
	 */
	function getHtml_radio($tagInfo)
	{
		$result = '<span>';
		if (isset($tagInfo['datasource'])) {
			foreach ($tagInfo['datasource'] as $arrSub) {
				$result .= '<label><input type="radio"';
				if (isset($tagInfo['id'])) { //id属性
					$result .= ' id="' . $tagInfo['id'] . '"';
				}
				if (isset($tagInfo['name'])) { //name属性
					$result .= ' name="' . $tagInfo['name'] . '"';
				}
				if (isset($tagInfo['class'])) { //class
					$result .= ' class="' . $tagInfo['class'] . '"';
				}
				if (isset($tagInfo['attr']) && sizeof($tagInfo['attr']) > 0) { //自定义属性
					foreach ($tagInfo['attr'] as $key=>$val) {
						$result .= ' ' . $key . '="' . $val . '"';
					}
				}
				if (isset($tagInfo['event']) && sizeof($tagInfo['event']) > 0) { //事件
					foreach ($tagInfo['event'] as $key=>$val) {
						$result .= ' ' . $key . '="' . $val . '"';
					}
				}

				$result .= ' value="' . $arrSub['valField'] . '" />' . $arrSub['txtField'] . '</label>';
			}
		}
		$result .= '</span>';
		return $result;
	}

//--------------------------------------------------------------------------------

	/*
	 * 生成菜单按钮，为大按钮,图片上,文字下
	 */
	function getMenuHtmlBtnBig($menuinfo,$menuarea,$buttonname)
	{
		$result = '';
		if (isset($menuinfo[$menuarea][$buttonname]))
		{
			$baseUrl = Zend_Controller_Front::getInstance()->getRequest()->getBaseUrl();
			$result .= "<div id=".$menuinfo[$menuarea][$buttonname]["itemname"]." disabled='disabled'";
			$result .= " state='disabled' imgname='".$menuinfo[$menuarea][$buttonname]["imgname"]."' style='margin:0 3px;'";
			$result .= " onclick=\"".$menuinfo[$menuarea][$buttonname]["onclick"]."\" >";
			$result .= "<img src='".$baseUrl."/img/".$menuinfo[$menuarea][$buttonname]["imgname"]."-disabled.png'";
			$result .= " class='content-menu-item-img' /><label>".$menuinfo[$menuarea][$buttonname]["dispname"]."</label></div>";
		}
		return $result;
	}

	/*
	 * 生成菜单按钮，为上下2个小按钮,图片左,文字右（只生成2个）
	 */
	function getMenuHtmlBtnSmall($menuinfo,$menuarea,$buttonname)
	{
		$result = '';
		if (isset($menuinfo[$menuarea][$buttonname[0]]))
		{
			$baseUrl = Zend_Controller_Front::getInstance()->getRequest()->getBaseUrl();

			$result .= '<table cellpadding="0" cellspacing="0" style="margin:-3px 5px -3px 0px;">';

			$result .= '<tr id="' . $menuinfo[$menuarea][$buttonname[0]]['itemname'] . '" disabled="disabled" state="disabled" imgname="' . $menuinfo[$menuarea][$buttonname[0]]['imgname'] . '" onclick="' . $menuinfo[$menuarea][$buttonname[0]]['onclick'] . '">';
			$result .= '<td><img src="' . $baseUrl . '/img/' . $menuinfo[$menuarea][$buttonname[0]]['imgname'] . '-disabled.png" class="content-menu-item-imgs" /></td>';
			$result .= '<td style="vertical-align:middle;"><label>' . $menuinfo[$menuarea][$buttonname[0]]['dispname'] . '</label></td></tr>';

			$result .= '<tr id="' . $menuinfo[$menuarea][$buttonname[1]]['itemname'] . '" disabled="disabled" state="disabled" imgname="' . $menuinfo[$menuarea][$buttonname[1]]['imgname'] . '" onclick="' . $menuinfo[$menuarea][$buttonname[1]]['onclick'] . '">';
			$result .= '<td><img src="' . $baseUrl . '/img/' . $menuinfo[$menuarea][$buttonname[1]]['imgname'] . '-disabled.png" class="content-menu-item-imgs" /></td>';
			$result .= '<td style="vertical-align:middle;"><label>' . $menuinfo[$menuarea][$buttonname[1]]['dispname'] . '</label></td></tr>';

			$result .= '</table>';
		}
		return $result;
	}

	/*
	 * 获取条件搜索的html
	 */
	function getMenuSearchHtml($menuinfo)
	{
		$this->view = Zend_Registry::get('view');
		$result = '';
		if ($menuinfo["menuvisible"]["searchmenu"] == "1") {
			$result = '';
			$tmpResult = '';
			$tmpTdNum = 0;
			foreach ($menuinfo["searchmenu"]["items"] as $arrSub) {
				$tmpTdNum = $tmpTdNum + $arrSub["colspan"] + 1;
				$funName = 'getHtml_' . $arrSub['type'];
				$tmpHtml = self::$funName($arrSub);
				$tmpResult .= '<td>' . $arrSub["displayname"] . '</td><td colspan="' . $arrSub["colspan"] . '">' . $tmpHtml . '</td>';
				if (($tmpTdNum) >= $menuinfo["searchmenu"]["tdsize"]) {
					$result .= '<tr>' . $tmpResult . '</tr>';
					$tmpResult = '';
					$tmpTdNum = 0;
				}
			}
			$result = '<div class="content-menu-item-search"><table>' . $result . '</table></div>';
			foreach($menuinfo["searchmenu"] as $menu) {
				$buttonname = $menu['itemname'];
				$baseUrl = Zend_Controller_Front::getInstance()->getRequest()->getBaseUrl();
				$url = $baseUrl . '/' . $this->view->moduleName . '/' . $this->view->controllerName . '/' . $menu['actionname'];
				break;
			}
			$result = '<div class="content-menu-item"><form class="wlz_ajaxForm" ajaxContainer="#data_divList" action="' . $url . '" method="post"><table><tr><td>' . $result . '</td><td>' . $this->getMenuHtmlBtnBig($menuinfo,"searchmenu",$buttonname) . '</td></tr>';
			if ($menuinfo["showmenuword"]) {
				$result .= '<tr><td class="content-menu-item-bottom" colspan="2">' . $menuinfo["menuvisible"]["searchname"] . '</td></tr>';
			}
			$result .= '</table></form></div>';
		}
		return $result;
	}

	/*
	 * 获取确认、取消图标的html
	 */
	function getMenuListHtmlConfirmMenu($menuinfo)
	{
		$this->view = Zend_Registry::get('view');
		$result = '';
		if ($menuinfo["menuvisible"]["confirmmenu"] == "1") {
			$result .= '<div class="content-menu-item"><table><tr><td><table><tr>';

			//小图标
			$arrBtnName = array();
			foreach($menuinfo["confirmmenu"] as $menu) {
				 array_push($arrBtnName, $menu['itemname']);
			}
			$result .= "<td>".$this->getMenuHtmlBtnSmall($menuinfo,"confirmmenu",$arrBtnName)."</td>";
			$result .= "</tr></table></td></tr>";
			if ($menuinfo["showmenuword"]) {
				$result .= '<tr><td class="content-menu-item-bottom"><label>'.$menuinfo["menuvisible"]["confirmname"]."</label></td></tr>";
			}
			$result .= "</table></div>";
		}
		return $result;
	}

	/*
	 * 获取添加、修改、删除、明细图标的html
	 */
	function getMenuListHtmlWithRightsBaseMenu($menuinfo)
	{
		$this->view = Zend_Registry::get('view');
		$result = '';
		if ($menuinfo["menuvisible"]["basemenu"] == "1") {
			$result .= '<div class="content-menu-item"><table><tr><td><table><tr>';
			foreach($menuinfo["basemenu"] as $menu) {
				if (isset($this->view->allActionRights[$menu["actionname_show"]]) && $this->view->allActionRights[$menu["actionname_show"]][0] == 0) {
					//$result .= "<td style='display:none;'>".$this->getMenuHtmlBtnBig($menuinfo,"basemenu",$menu["itemname"])."</td>";
				} else {
					$result .= "<td>".$this->getMenuHtmlBtnBig($menuinfo,"basemenu",$menu["itemname"])."</td>";
				}
			}
			$result .= "</tr></table></td></tr>";
			if ($menuinfo["showmenuword"]) {
				$result .= '<tr><td class="content-menu-item-bottom"><label>'.$menuinfo["menuvisible"]["basename"]."</label></td></tr>";
			}
			$result .= "</table></div>";
		}
		return $result;
	}

	/*
	 * 获取其它图标的html
	 */
	function getMenuListHtmlWithRightsOhterMenu($menuinfo)
	{
		$result = '';
		if ($menuinfo["menuvisible"]["othermenu"] == "1") {
			$result .= "<div class='content-menu-item'><table><tr><td><table><tr>";
			foreach($menuinfo["othermenu"] as $menu) {
				if (isset($this->view->allActionRights[$menu["actionname_show"]]) && $this->view->allActionRights[$menu["actionname_show"]][0] == 0) {
					//$result .= "<td style='display:none;'>".$this->getMenuHtmlBtnBig($menuinfo,"othermenu",$menu["itemname"])."</td>";
				} else {
					$result .= "<td>".$this->getMenuHtmlBtnBig($menuinfo,"othermenu",$menu["itemname"])."</td>";
				}
			}
			$result .= "</tr></table></td></tr>";
			if ($menuinfo["showmenuword"]) {
				$result .= "<tr><td class='content-menu-item-bottom'><label>".$menuinfo["menuvisible"]["othername"]."</label></td></tr>";
			}
			$result .= "</table></div>";
		}
		return $result;
	}

	/*
	 * 获取行数据模板
	 */
	function normal_getDataListTrTemplate($menuInfo, $gridInfo)
	{
		$result = '';
		if($menuInfo['batchoperation']) {
			$result .= '<td></td>';
		}

		foreach ($gridInfo['listfield'] as $arrSub) {
			$result .= '<td>';
			if (isset($arrSub['tagInfo'])) {
				$funName = 'getHtml_' . $arrSub['tagInfo']['type'];
				$result .= self::$funName($arrSub['tagInfo']);
			}
			$result .= '</td>';
		}
		return $result;
	}
/************************************** END  : 多表模板使用 ***********************************************/

}