/*
 * jQuery 控制网站的鼠标选择文字的效果
 * 默认禁止网站选择文字，允许选择text和textarea标签内的文字
 * 
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-12-21
 *
 * 用法：直接引用此JS文件
 *
 * 备注：只支持IE
 *
 */

//---------------------------------------------------------------------------
$(function(){
	//首先禁止整个网站的onselectstart事件
	$('body').bind('selectstart', function(){
		return false;
	});

	//切换body的onselectstart事件
	$(':text,textarea').live('focus', function(){
		$('body').unbind('selectstart');
		$('body').bind('selectstart', function(){
			return true;
		});
	});
	$(':text,textarea').live('blur', function(){
		$('body').unbind('selectstart');
		$('body').bind('selectstart', function(){
			return false;
		});
	});
});