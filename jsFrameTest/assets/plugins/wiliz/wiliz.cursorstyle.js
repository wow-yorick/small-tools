/*
 * jQuery CursorStyle Plus @requires jQuery
 * 
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-12-12
 *
 * 用法：
	给元素的class添加个下面的'cursorPoint';
 *
 */

//---------------------------------------------------------------------------
/*
 * 更改鼠标移上变成小手的样式
 */
function bindCursorStyle(){
	var cursorClass = 'wiliz-cursor-pointer';
	var cursorType = 'pointer';
	$('.' + cursorClass).live('mouseover',function(){
		$(this).css('cursor', cursorType);
	});
	$('.' + cursorClass).live('mouseout',function(){
		$(this).css('cursor', 'default');
	});
}

$(function(){
	bindCursorStyle();
});