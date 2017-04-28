/*
 * jQuery JS实现选择文件路径(限IE)，获取客户端桌面路径
 * 
 * Copyright (c) Weili Zhu
 *
 * Autor: 朱威力
 * Date: 2011-12-14
 *
 * 用法：
 *
 * 备注：需要在Internet选项->安全->可信站点中：
		1、将服务器网站添加为可信任站点
		2、打开自定义级别，将"对为标记为可安全执行脚本的ActiveX控件初始化并执行脚本"改为启用
 *
 */

//---------------------------------------------------------------------------
/*
 * JS实现选择文件路径(限IE)
 * 
 */
function BrowseFolder(){
	try{
		var Message = "请选择文件夹"; //选择框提示信息
		var Shell = new ActiveXObject( "Shell.Application" );
		//var Folder = Shell.BrowseForFolder(0,Message,0x0040,0x11); //起始目录为：我的电脑
		var Folder = Shell.BrowseForFolder(0,Message,0); //起始目录为：桌面
		if(Folder != null){
			if(Folder == "桌面" || Folder == "Desktop" || Folder == "DESKTOP"){
				var wsh = new ActiveXObject("wscript.shell");
				Folder = wsh.SpecialFolders("Desktop");
				wsh = null;
			}
			else{
				Folder = Folder.items(); // 返回 FolderItems 对象
				Folder = Folder.item(); // 返回 Folderitem 对象
				Folder = Folder.Path; // 返回路径
			}
			
			if(Folder.charAt(Folder.length-1) != "\\"){
				Folder = Folder + "\\";
			}

			//防止选择"我的电脑"作为路径
			if(Folder.substr(0, 3) == '::{'){
				alert('路径错误，请重新选择！');
				Folder = ''; //防止点"取消"按钮后依然显示'::{...'
				BrowseFolder();
			}

			UpdateGlobalConfigFile(Folder); //将选择的路径存入配置文件中
			Shell = null;
			return Folder;
		}
	}
	catch(e){
		alert(e.message + "\n请参考系统帮助页面，开启浏览器对该功能的支持！");
	}
}

/*
 * 获取客户端桌面路径
 */
function getClientDesktopPath(){
	try{
		var wsh = new ActiveXObject("wscript.shell");
		Folder = wsh.SpecialFolders("Desktop");
		wsh = null;
		return Folder;
	}
	catch(e){
		alert(e.message + "\n请参考系统帮助页面，开启浏览器对该功能的支持！");
		return false;
	}
}