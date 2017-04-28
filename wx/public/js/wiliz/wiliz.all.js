/*
 * Load The Other JS
 *
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-12-14
 *
 * 用法：在iniMyJs()里需要加载几个调用几次include_js()函数就行
 *
 * 备注：加载的文件要和all.js文件放在同一个目录下
 *
 */

//---------------------------------------------------------------------------
/*
 * 初始化
 */
function iniMyJs(){
	var jsName = 'wiliz.all.js';
	var jsPath = getMyJsPath(jsName);

	include_js(jsPath, 'wiliz.cursorstyle.js'); //鼠标小手
	//include_js(jsPath, 'wiliz.tablecss.js'); //表格样式
	//include_js(jsPath, 'wiliz.tablesort.js'); //表格排序
	include_js(jsPath, 'wiliz.dateformat.js'); //时间处理
	include_js(jsPath, 'wiliz.cookie.js'); //cookie处理
	//include_js(jsPath, 'wiliz.clientpath.js'); //客户端文件夹路径选择
	//include_js(jsPath, 'wiliz.bind.onselectstart.js'); //鼠标选择文字事件
	include_js(jsPath, 'wiliz.auth.js'); //验证类
	include_js(jsPath, 'wiliz.strformat.js'); //字符串处理类
}

/*
 * 获取文件名为'jsName'的JS文件路径
 */
function getMyJsPath(jsName){
	var js = document.scripts;
	var jsPath;
	for(var i=js.length; i>0; i--){
		if(js[i-1].src.indexOf(jsName) > -1){
			jsPath = js[i-1].src.substring(0,js[i-1].src.lastIndexOf("/") + 1);
		}
	}
	return jsPath;
}

/*
 * JS文件中加载其它JS文件
 */
function include_js(path, jsName){
	var sobj = document.createElement('script');
	sobj.type = 'text/javascript';
	sobj.src = path + '/' + jsName;
	var headobj = document.getElementsByTagName('head')[0];
	headobj.appendChild(sobj);
}

/*
 * JS文件中加载其它CSS文件
 */
function include_css(path)
{
	var fileref=document.createElement('link')
	fileref.rel = 'stylesheet';
	fileref.type = 'text/css';
	fileref.href = path;
}

iniMyJs(); //初始化