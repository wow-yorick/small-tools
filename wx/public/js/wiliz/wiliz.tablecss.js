/*
 * jQuery TableCss Plus @requires jQuery
 *
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-11-28
 *
 * 用法：
	$(function(){
		//可以不设置，既为默认
		THREAD_BGCOLOR = 'transparent'; //table标题的背景颜色
		THREAD_COLOR = 'transparent'; //table标题的字体颜色
		MOUSE_CLICK_BGCOLOR = '#9ACD32'; //鼠标点击后改变为的背景颜色
		MOUSE_CLICK_COLOR = 'white'; //鼠标点击后改变为的字体颜色
		MOUSE_OVER_BGCOLOR = '#F0F0F0'; //鼠标经过后改变为的背景颜色

		wlz_iniTableCss(tableId); //参数为table的ID
	});
 *
 *
 */

//---------------------------------------------------------------------------

var TABLE_ID;
var THREAD_BGCOLOR = '#328aa4'; //table标题的背景颜色
var THREAD_COLOR = '#fff'; //table标题的字体颜色
var MOUSE_CLICK_BGCOLOR = '#9ACD32'; //鼠标点击后改变为的背景颜色
var MOUSE_CLICK_FONTCOLOR = 'white'; //鼠标点击后改变为的字体颜色
var MOUSE_OVER_BGCOLOR = '#F0F0F0'; //鼠标经过后改变为的背景颜色

/*
 * table行onclick事件，修改css
 */
function wlz_changeRowCss_Click(obj)
{
	if($(obj).closest('tbody').find('[wlz_isSelected]').length > 0) //判断是否有选中行
	{
		if(!$(obj).is('[wlz_isSelected]')) //点击其它行
		{
			wlz_saveClickedRowCss(obj);

			$(obj).closest('tbody').find('[wlz_isSelected]').css('background-color', $(obj).closest('tbody').find('[wlz_isSelected]').attr('wlz_oldBgColor'));
			$(obj).closest('tbody').find('[wlz_isSelected]').css('color', $(obj).closest('tbody').find('[wlz_isSelected]').attr('oldFontColor'));
			$(obj).closest('tbody').find('[wlz_isSelected]').removeAttr('wlz_isSelected');

			$(obj).css('background-color', MOUSE_CLICK_BGCOLOR);
			$(obj).css('color', MOUSE_CLICK_FONTCOLOR);
			$(obj).attr('wlz_isSelected', 'wlz_isSelected');
		}
		else //点击自身行
		{
			$(obj).closest('tbody').find('[wlz_isSelected]').css('background-color', $(obj).attr('wlz_oldBgColor'));
			$(obj).closest('tbody').find('[wlz_isSelected]').css('color', $(obj).attr('oldFontColor'));
			$(obj).closest('tbody').find('[wlz_isSelected]').removeAttr('wlz_isSelected');
		}
	}
	else
	{
		wlz_saveClickedRowCss(obj);
		$(obj).css('background-color', MOUSE_CLICK_BGCOLOR);
		$(obj).css('color', MOUSE_CLICK_FONTCOLOR);
		$(obj).attr('wlz_isSelected', 'wlz_isSelected');
	}
}

/*
 * table行onmouseover事件，修改css
 */
function wlz_changeRowCss_Mouseover(obj)
{
	wlz_saveClickedRowCss(obj);
	$(obj).not('[wlz_isSelected]').css('background-color', MOUSE_OVER_BGCOLOR);
}

/*
 * table行onmouseout事件，修改css
 */
function wlz_changeRowCss_Mouseout(obj)
{
	$(obj).not('[wlz_isSelected]').css('background-color', $(obj).attr('wlz_oldBgColor'));
}

/*
 * 缓存点击行的css
 */
function wlz_saveClickedRowCss(obj)
{
	if(!$(obj).is('[wlz_oldBgColor]')) //缓存原背景颜色
	{
		$(obj).attr('wlz_oldBgColor', $(obj).css('background-color'));
	}
	if(!$(obj).is('[oldFontColor]')) //缓存原字体颜色
	{
		$(obj).attr('oldFontColor', $(obj).css('color'));
	}
}

/*
 * 给table每行绑定click、mouseover、mouseout事件
 */
function wlz_bindRowEvent()
{
	$('#' + TABLE_ID).find('.wiliz-tblcss-tr').each(function(){
		$(this).bind('click', function(){
			wlz_changeRowCss_Click(this);
		});
		$(this).bind('mouseover', function(){
			wlz_changeRowCss_Mouseover(this);
		});
		$(this).bind('mouseout', function(){
			wlz_changeRowCss_Mouseout(this);
		});
	});
}

/*
 * 改变奇偶行css样式
 */
function wlz_iniTableCss(tableId)
{
	TABLE_ID = tableId;
	$('#' + TABLE_ID).find('tbody').find('tr').addClass('wiliz-tblcss-tr');
	wlz_bindRowEvent();
	$('#' + TABLE_ID).find('th').each(function(){
		$(this).css({
			'background-color': THREAD_BGCOLOR
			,'color': THREAD_COLOR
			,'padding': '5px'
			,'border': '0.5px solid #fff'
		});
	});

	$('#' + TABLE_ID).find('.wiliz-tblcss-tr:even').each(function(){
		$(this).css({
			'background': '#f8fbfc'
			,'color': '#555555'
		});
	});
	$('#' + TABLE_ID).find('.wiliz-tblcss-tr:odd').each(function(){
		$(this).css({
			'background': '#e5f1f4'
			,'color': '#4f6b72'
			,'font-weight': 600
		});
	});
}