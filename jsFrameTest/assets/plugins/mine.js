/*
 * Copyright (c) zqq
 *
 *create rectangle content by rows*cols divs,also can not full filled with divs
 *create move elements on the background,the elements also can be deleted&modified
 *
 * by zhangqiqi
 * 5/2/2013
 * 
 * 5.17 modify:
 * 1.change the css of the background img to center display
 * 2.fix the bug that when browser magnify,the background can not magnify with the browser
 * 3.delete the border of the divs,only display red or green when the div move
 * 4.add display btn: min the dialog div,then show the display btn,click the btn to revert the dialog div
 * 
 * 5.20 modify:
 * 1.unify the gloable var
 * 2.fix the bug that in IE ,the display btn can not work
 * 3.create A tag with function createATag()
 * 
 * 5.24 modify:
 * 1.add change the dialog div size(function dialog_resize()),when dialog div be created,the function is called
 * 2.add iframe in the dialog div to quote the specific page
 * 3.set the change diolog div size function into the drag function
 * 4.refresh button&auto refresh of the iframe 
 * 
 * 5.27 modify:
 * get the gloable params from client, and set in the qq_loadjs.phtml
 * 
 * 5.27-7.26 important modify:
 * add page attribute to the divs,it's not used in the company_protal project
 * 
 * 7.26 modify:
 * 1.calculate the row_num&col_num by the width&height of the screen,
 * 	 if the screen is small,the out div will be delete and use the addapp's function to re-add 
 * 2.if the width or height of the diolog div is larger than the screen's,max the dialog div.
 * 3.the dialog div is middle of the screen
 * 
 */

//---------------------------------------------------------------------------

/*
 * get style from the css file
 */
function GetCurrentStyle (obj, prop)
{
	if(null==obj)
		return false;
   if (obj.currentStyle) //IE
   {
       return obj.currentStyle[prop];
   }
   else if (window.getComputedStyle) //not IE
   {
       propprop = prop.replace (/([A-Z])/g, "-$1");
       propprop = prop.toLowerCase ();
       return document.defaultView.getComputedStyle(obj,null)[propprop];
   }
  return null;
}

/*
 * get the client x&y
 */
function setClientVar()
{
	var browser=navigator.userAgent;   //get the browser attribut
    if (browser.indexOf("MSIE")>0)
    {  //if is IE
    	g_client_width = document.documentElement.clientWidth;
    	g_client_height = document.documentElement.clientHeight;
    }
    else
	{ //if not IE
    	g_client_height = document.body.clientHeight;
	    g_client_width = document.body.clientWidth;
		
	}
    var footer = document.getElementById("footer");
    var header = document.getElementById("header");
	bg_default_height = g_client_height -getNum(GetCurrentStyle(footer,"height"),"px") - 9;
	bg_default_width = g_client_width;
	browser_width = window.screen.availWidth;
	browser_height = window.screen.availHeight - 120 - getNum(GetCurrentStyle(footer,"height"),"px") - getNum(GetCurrentStyle(header,"height"),"px");//minus the taskbar of the browser
}

function stopBubble(event)
{
	event = event||window.event;
	if(document.all)
		window.event.cancelBubble = true;
	else
		event.stopPropagation();
}

/*
 * create background
 * arguments:
 * 			[0,1]:the positon of the target
 * 			[2,3]:the size of the target
 * 			[4]:the background img
 * 	all the args have default value
 * not used
 */
function createBackGround()
{
	
	//getElementsByClassName is not supported in IE
	var old_ele = document.getElementById(bg_default_id);
	if(null!=old_ele)
		document.body.removeChild(old_ele);
	var pos_x = arguments[0]?arguments[0]:bg_div_default_left,pos_y = arguments[1]?arguments[1]:bg_div_default_top + 10;
	var width = arguments[2]?arguments[2]:bg_default_width,height = arguments[3]?arguments[3]:bg_default_height;
	var img = arguments[4]?arguments[4]:bg_default_background_img;
	img = g_default_img_url + img;
	
	//create new div
	var e = document.createElement("div");
	e.className = bg_default_classname;
	e.id = bg_default_id;
	e.style.position = "absolute";
	e.style.left = pos_x + "px";
	e.style.top = pos_y + "px";
	e.style.width = width + "px";
	e.style.height = height + "px";
	e.style.zIndex = bg_default_zindex;
	e.style.backgroundImage = "url(" + img + ")";
	e.style.backgroundPosition = "center";
	e.style.backgroundRepeat = "no-repeat";
	e.style.backgroundAttachment = "fixed";
	document.body.appendChild(e);
}

/*
 * create the background divs
 * arguments:[0,1]:start position on the screen
 * 					 [2]:the num of the background divs
 * 					 [3,4]:the row num &cols num
 * 					 [5,6]:the width&height of the divs
 * 					 [7.8]: the width&height interval of the divs
 * 					 [9]:the background img of the divs
 * all the args have default value
 */
function createBackGroundDivs()
{
	setClientVar();
	var pos_x = (!isNaN(arguments[0]))?arguments[0]:bg_div_default_left,pos_y = ((!isNaN(arguments[1]))?arguments[1]:bg_div_default_top) + 10;
	var div_num = arguments[2]?arguments[2]:bg_div_default_num;
    var rows_num = arguments[3]?arguments[3]:bg_div_default_row_num,cols_num = arguments[4]?arguments[4]:bg_div_default_col_num;
	var div_width = arguments[5]?arguments[5]:bg_div_default_width,div_height = arguments[6]?arguments[6]:bg_div_default_height;
	var interval_width = (!isNaN(arguments[7]))?arguments[7]:bg_div_default_interval_width;
	var interval_height = (!isNaN(arguments[8]))?arguments[8]:bg_div_default_interval_height;
	var img = arguments[9]?arguments[9]:bg_div_default_background_img;
	var tmp_cols_num = Math.floor((browser_width+interval_width)/(interval_width+div_width));
	var tmp_rows_num = Math.floor((browser_height+interval_height)/(interval_height+div_height));
	cols_num = cols_num<tmp_cols_num?cols_num:tmp_cols_num;
	rows_num = rows_num<tmp_rows_num?rows_num:tmp_rows_num;
	//set global var
	bg_div_default_left = pos_x;
	bg_div_default_top = pos_y;
	bg_div_default_num = div_num;
	bg_div_default_row_num = rows_num;
	bg_div_default_col_num = cols_num;
	bg_div_default_width = div_width;
	bg_div_default_height = div_height;
	bg_div_default_interval_width = interval_width;
	bg_div_default_interval_height = interval_height;
	bg_div_default_background_img = img;
	if(div_num>rows_num*cols_num)
		div_num = rows_num*cols_num;
	//create divs
	for(var i = 1 ; i <= div_num ; ++i)
	{
		var new_node = document.createElement("div");
		new_node.className = bg_div_default_classname;
		new_node.id = bg_div_default_prefix + i;
		new_node.style.position = "absolute";
		new_node.style.width = div_width + "px";
		new_node.style.height = div_height + "px";
		var j = i-1;
		new_node.style.left = pos_x + (j%cols_num)*interval_width + j%cols_num*div_width + "px";
		new_node.style.top = pos_y + (Math.floor(j/cols_num))*interval_height + (Math.floor(j/cols_num))*div_height + "px";
		new_node.style.zIndex = bg_div_default_zindex;
		new_node.setAttribute("name",bg_div_default_prefix);
		document.body.appendChild(new_node);
	}
}

/*
 * create the drap drop divs
 * arguments:
 * 		arrays:
 * 			[0]:des_pos(row num,col num)
 * 			[1]:rows
 * 			[2]:cols
 * 			[3]:the background img of the target
 */
function createDrapDropDivs()
{
	var datas = arguments[0];
	try
	{
		for(var i=0;i<datas.length;++i)
		{
			var data = datas[i];
			data = data.split("=");
			createDrapDropDiv(data[0],parseInt(data[1]),parseInt(data[2]),data[3],data[4],data[5],parseInt(data[6]),parseInt(data[7]),parseInt(data[8]),parseInt(data[9]),parseInt(data[10]),parseInt(data[11]));
		}
	}
	catch(e)
	{
		return false;
	}
	return true;
}

/*
 * create  drapdrop div
 * arguments:
 * 			[0]=>des_pos(row num,col num)
 * 			[1]=>rows
 * 			[2]=>cols
 * 			[3]=>background color
 * 			[4]=>background image
 * all the args have default value
 */
function createDrapDropDiv()
{
	var pos = arguments[0]?arguments[0]:0,rows = arguments[1]?arguments[1]:0,cols = arguments[2]?arguments[2]:0;
	if(0==pos||0==rows||0==cols)
		return;
	var name = arguments[4];
	var img = arguments[5];
	var color = arguments[3];
	var page = arguments[10];//page
	var old_id = pos;
	old_id = old_id.split(",");
	old_id = parseInt(old_id[0]) + (parseInt(old_id[1])-1)*bg_div_default_col_num;//for x,y ,if row_no,col_no,modify here
	var old_node = document.getElementById(bg_div_default_prefix+old_id);
	if(null==old_node||(!canMultiDrop(old_node,rows,cols)))
		return false;
	var new_node = document.createElement("div");
	new_node.className = drag_drop_div_default_classname;
	new_node.style.position = "absolute";
	new_node.style.left = old_node.style.left;
	new_node.style.top = old_node.style.top;
	new_node.style.width = bg_div_default_width*cols + bg_div_default_interval_width*(cols-1) + "px";
	new_node.style.height = bg_div_default_height*rows + bg_div_default_interval_height*(rows-1) + "px";
	new_node.id = old_id + "_" + rows + "_" + cols + "_" + arguments[11];
	new_node.setAttribute("name",bg_div_default_prefix+old_id);
	new_node.setAttribute("div_name",name);
	new_node.setAttribute("page",page);
	new_node.style.zIndex = drag_drop_div_default_zindex;
	document.body.appendChild(new_node);
	if("/"!=img.substr(0,1))
	{
		//add shortcut
		new_node.style.backgroundColor = color;
		$("<img/>").attr("src",g_default_img_url+"/"+img
				).appendTo($("<div/>").attr({
			"class":drag_drop_div_default_content_classname,"id":drag_drop_div_default_content_classname + new_node.id
		}).css({
			"position":"absolute","width":"100%"
		}).appendTo($("<div/>").attr("class","grid-img").appendTo(new_node)));
		$("<div/>").attr("class","grid-name").text(name).appendTo(new_node);
		var tmp_move = createDragMoveDiv(new_node.id,getNum(new_node.style.width,"px"),getNum(new_node.style.height,"px"),true,0,true,0,page);
	}
	else
	{
		var estop_pos_x = arguments[6],estop_pos_y = arguments[7],estop_width = arguments[8],estop_height = arguments[9];
		new_node.style.backgroundColor = color;
		img = g_baseUrl + img;
		//add app
		var iframe_e = $("<iframe/>").attr({"class":"test","id":dialog_default_content_prefix + new_node.id,"src":img})
		.css({"position":"absolute","left":"0px","top":"0px",
			"width":getNum(new_node.style.width,"px") + "px",
			"height":getNum(new_node.style.height,"px") + "px","frameborder":"no","border":"0","z-index":"10"
			}).appendTo(new_node);
		//mouseMoveDisplay(iframe_e.get(0));
		var width = getNum(new_node.style.width,"px");
		var height = getNum(new_node.style.height,"px");
		if(estop_width!=0)
			width = estop_width;
		if(estop_height!=0)
			height = estop_height;
		var tmp_move = createDragMoveDiv(new_node.id,width,height,true,estop_pos_x,true,estop_pos_y,page);
	}
	if(page!=$("#desk_switch").text())
	{
		new_node.style.display="none";
		tmp_move.css("display","none");
	}
	
	mouseMoveDisplay(new_node);
}

function delDrapDropDivById(id)
{
	var tmp = parseInt(id["pos_x"]) + (parseInt(id["pos_y"])-1)*bg_div_default_col_num;
	id = tmp + "_" + parseInt(id["row_num"]) + "_" + id["col_num"] + "_" + id["conf_id"];
	if($("#"+drag_move_prefix+id).find("a.btn_del").length>0)
		$("#"+drag_move_prefix+id).find("a.btn_del").click();
	else if($("#"+id).find("a.btn_del").length>0)
		$("#"+id).find("a.btn_del").click();
}


function changeBackgroundDivClass(page)
{
	$("div."+bg_div_default_classname).attr("name",bg_div_default_prefix);
	$("div."+drag_drop_div_default_classname).each(function(){
		if($(this).css("display")!="none")
		{
			var ids = $(this).attr("id").split("_");
			var div_name_height = parseInt(ids[1]),div_name_width = parseInt(ids[2]);
			for(var i=0;i<div_name_height;i++)
				for(var j=0;j<div_name_width;j++)
					$("#"+bg_div_default_prefix + (parseInt(ids[0])+i*bg_div_default_col_num +j)).attr("name",ids);
		}
	});
	$("div."+dialog_default_classname).each(function(){
		if(parseInt($(this).attr("page"))!=parseInt(page))
		{
			$(this).css("display","none");
			if(parseInt($(this).css("z-index"))==parseInt(dialog_default_zindex))
				$("#" + iframe_click_div_prefix + $(this).attr("id")).css("display","none");
		}
		else
		{
			if($(this).css("display")=="none")
			{
				$(this).css("display","");
				if(parseInt($(this).css("z-index"))==parseInt(dialog_default_zindex))
					$("#" + iframe_click_div_prefix + $(this).attr("id")).css("display","");
			}
		}
	});
}


function createDragMoveDiv()
{
	var id = arguments[0]?arguments[0]:-1;
	var ele = $("#"+id);
	if(-1==id)
		return false;
	var width = arguments[1],height = arguments[2],isLeft = arguments[3],left = arguments[4],isTop = arguments[5],top = arguments[6],page = arguments[7];
	var e = $("<div/>").attr({
		"class":drag_move_classname,"id":drag_move_prefix + id,"name":id,"page":page
		//"class":drag_drop_div_inner_classname,"id":dialog_move_prefix + id,"name":id
	}).css({
		//"position":"absolute","width":width,"height":height,"background-color":"#fff","opacity":0.5,
		"position":"absolute","width":width,"height":height,
		"z-index":parseInt(drag_drop_div_default_zindex) + 10 + ""
	});
	if(isLeft)
		e.css({"left":left + getNum(ele.css("left")) + "px","width":getNum(e.css("width"))-left});
	else
		e.css({"left":getNum(ele.css("left")) + getNum(ele.css("width")) - left + "px","width":getNum(e.css("width")) + left - getNum(ele.css("width"))});
	if(isTop)
		e.css({"top":top + getNum(ele.css("top")) + "px","height":getNum(e.css("height"))-top});
	else
		e.css({"top":getNum(ele.css("top")) + getNum(ele.css("height")) - top,"height":getNum(e.css("height")) + top - getNum(ele.css("height"))});
	e.appendTo("body");
	try
	{
		var btn_del = createATag(id,"display:none","btn_del");
		if((isTop&&top>0)||((getNum(e.css("left"),"px")-getNum(ele.css("left"),"px") + getNum(e.css("width"),"px"))<getNum(ele.css("width"),"px")))
		{	
			//mouseMoveDisplay(ele.get(0));
			ele.get(0).appendChild(btn_del);
		}
		else
		{
			//mouseMoveDisplay(e.get(0));
			e.get(0).appendChild(btn_del);
		}
			
		drag(e.get(0));
		return e;
	}
	catch(e)
	{
		return false;
	}
}


iframe_click_div_classname = "iframe_click_div";
iframe_click_div_prefix = "iframe_click_";
/*
 * create a dialog div
 * arguments:
 * 				[0,1]:the position of the target
 * 				[2,3]:the size of the target
 * 				[4]:the id of the target(no prefix)
 * 				[5]:the background img of the target
 * all the args have default value
 */
function createDialogDiv()
{
	var d_id = arguments[0];
	var src = g_div_url_default[d_id][0];
	var icon = g_default_img_url+"/"+g_div_url_default[d_id][7];
	var is_resize = g_div_url_default[d_id][8];
	if(src==null||""==src)
		return false;
	if(src.split("?").length>1)
		g_div_url_default[d_id][0] = src.split("?")[0];
	if("/"==src.substr(0,1))
		src = g_baseUrl + src;
	var d_pos_x = g_div_url_default[d_id][3];
	var d_pos_y = g_div_url_default[d_id][4];
	var d_pos_width = g_div_url_default[d_id][5];
	var d_pos_height = g_div_url_default[d_id][6];
	var name = g_div_url_default[d_id][9];
	var loginurl = g_div_url_default[d_id][11];
	var conf_id = g_div_url_default[d_id][12];
	if(null!=d_id&&g_div_url[d_id])
		d_id = g_div_url[d_id];
	else
		d_id = dialog_prefix + (++dialog_num);
	if(document.getElementById(d_id))
		return false;
	
	
	if(null==src)
		return false;
	var e = $("<div/>").attr({
		"id":d_id,"class":dialog_default_classname,"page":$("#desk_switch").text()
	}).css({
		"position":"absolute","left":d_pos_x + "px","top":d_pos_y + "px","width":d_pos_width + "px",
		"height":d_pos_height + "px","z-index":dialog_default_zindex,"margin":"5px","backgroundColor":"#fff"
	}).bind("resize",function(){
		refreshDialog("refresh_" + d_id);
	}).appendTo("body");
	getFocus(e);
	e = e.get(0);
	
	//create 8 divs to resize the dialog div
	if(is_resize==1)
	{
		var tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"left"}).css({
			"position":"absolute","width":"5px","height":"100%","top":"5px","left":"-5px","cursor":"w-resize","overflow":"hidden","opacity":"0"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
		tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"right"}).css({
			"position":"absolute","width":"5px","height":"100%","top":"5","right":"-5px","cursor":"e-resize","overflow":"hidden","opacity":"0"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
		tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"top"}).css({
			"position":"absolute","width":"100%","height":"5px","top":"-5px","cursor":"n-resize","overflow":"hidden","opacity":"0"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
		tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"bottom"}).css({
			"position":"absolute","width":"100%","height":"5px","bottom":"-5px","cursor":"s-resize","overflow":"hidden","opacity":"0"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
		
		tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"left_top"}).css({
			"position":"absolute","width":"5px","height":"5px","top":"-5px","left":"-5px","cursor":"nw-resize","overflow":"hidden","opacity":"0"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
		tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"right_top"}).css({
			"position":"absolute","width":"5px","height":"5px","top":"-5px","right":"-5px","cursor":"ne-resize","overflow":"hidden","opacity":"0"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
		tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"left_bottom"}).css({
			"position":"absolute","width":"5px","height":"5px","bottom":"-5px","left":"-5px","cursor":"sw-resize","overflow":"hidden","opacity":"0","z-index":"10000"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
		tmp_e = $("<div/>").attr({"class":dialog_default_resize_classname,"id":"right_bottom"}).css({
			"position":"absolute","width":"5px","height":"5px","bottom":"-5px","right":"-5px","cursor":"se-resize","overflow":"hidden","opacity":"0"
		}).appendTo(e);
		tmp_e = tmp_e.get(0);
		drag(tmp_e);
	}
	//create title div
	var ele = null;
	if("addappdialogdiv"==d_id)
		ele = createDialogTitleDiv(e,name,null,true);
	else
		ele = createDialogTitleDiv(e,name);
	//create iframe content
	
	tmp_e = document.getElementById("footer").getElementsByTagName("ul");
	tmp_e[0].appendChild(createDisplayLi(name,e.id,icon));
	var iframe_e = $("<iframe/>").attr({"class":dialog_default_content_classname,"id":dialog_default_content_prefix + d_id})
	.css({"position":"absolute","width":"100%","height":((getNum(e.style.height,"px")-getNum(ele.style.height,"px")) + "px"),"frameborder":"no","border":"0"
		}).appendTo(e);
	getFocus($("<div/>").attr({"class":iframe_click_div_classname,"id":iframe_click_div_prefix + d_id}).css({
		"position":"absolute","left":"0px","top":"0px","width":"100%","height":"100%","display":"none"
	}).appendTo(e));
	changeFocus($(e));
	iframe_e.attr("src",src);
	//if out of the browser,  max the iframe
	if(d_pos_height>bg_default_height||d_pos_width>bg_default_width)
		$(e).find("[class=dialog_max]").click();
	else
	{
		d_pos_x = (bg_default_width - d_pos_width)/2;
		d_pos_y = (bg_default_height - d_pos_height)/2;
		$(e).css({"left":d_pos_x,"top":d_pos_y});
	}
	return e;
}


function createDialogDivBytiandiweiye()
{
	window.open("http://122.228.181.202:7000/Easy7/apps/WebClient/dijit/templates/WfrmMain_test.html?username=admin&password=hwzn88898125","WebCLient");
	/*var d_id = arguments[0];
	var src = g_div_url_default[d_id][0];
	var icon = g_default_img_url+"/"+g_div_url_default[d_id][7];
	var is_resize = g_div_url_default[d_id][8];
	if(src==null||""==src)
		return false;
	if(src.split("?").length>1)
		g_div_url_default[d_id][0] = src.split("?")[0];
	if("/"==src.substr(0,1))
		src = g_baseUrl + src;
	var d_pos_x = g_div_url_default[d_id][3];
	var d_pos_y = g_div_url_default[d_id][4];
	var d_pos_width = g_div_url_default[d_id][5];
	var d_pos_height = g_div_url_default[d_id][6];
	var name = g_div_url_default[d_id][9];
	var loginurl = g_div_url_default[d_id][11];
	var conf_id = g_div_url_default[d_id][12];
	if(null!=d_id&&g_div_url[d_id])
		d_id = g_div_url[d_id];
	else
		d_id = dialog_prefix + (++dialog_num);
	if(document.getElementById(d_id))
		return false;
	 
	
	if(null==src)
		return false;
	var e = $("<div/>").attr({
		"id":d_id,"class":dialog_default_classname,"page":$("#desk_switch").text()
	}).css({
		"position":"absolute","left":bg_div_default_left + "px","top":bg_div_default_top - getNum(GetCurrentStyle(header,"height"),"px") + "px","width":bg_default_width -2 - 10 + "px",
		"height":bg_default_height -2 - 10+ "px","z-index":dialog_default_zindex,"margin":"5px","backgroundColor":"#fff"
	}).bind("resize",function(){
		refreshDialog("refresh_" + d_id);
	}).appendTo("body");
	getFocus(e);
	e = e.get(0);
	
	//create title div
	ele = createDialogTitleDiv(e,name);
	//create iframe content
	
	tmp_e = document.getElementById("footer").getElementsByTagName("ul");
	tmp_e[0].appendChild(createDisplayLi(name,e.id,icon));
	var iframe_e = $("<iframe/>").attr({"class":dialog_default_content_classname,"id":dialog_default_content_prefix + d_id})
	.css({"position":"absolute","width":"100%","height":((getNum(e.style.height,"px")-getNum(ele.style.height,"px")) + "px"),"frameborder":"no","border":"0"
		}).appendTo(e);
	getFocus($("<div/>").attr({"class":iframe_click_div_classname,"id":iframe_click_div_prefix + d_id}).css({
		"position":"absolute","left":"0px","top":"0px","width":"100%","height":"100%","display":"none"
	}).appendTo(e));
	changeFocus($(e));
	var browser=navigator.userAgent;   //get the browser attribut
    if (browser.indexOf("MSIE")>0)
    {  
    	var WshShell=new ActiveXObject("WScript.Shell");
    	//添加信任站点ip
    	WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMap\\Ranges\\Range100\\","");
    	WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMap\\Ranges\\Range100\\http","2","REG_DWORD");
    	WshShell.RegWrite("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ZoneMap\\Ranges\\Range100\\:Range","localhost");
    	//禁用Winxp弹出窗口阻止程序
    	//WshShell.RegWrite("HKCU\\Software\\Microsoft\\Internet Explorer\\New Windows\\PopupMgr","no");
    }
	iframe_e.attr("src",src);
	//if out of the browser,  max the iframe
	return e;*/
}

function createDialogDivByChild(url)
{
	//var url_add = url.split("url")[0];
	for(var v in g_div_url_default)
	{
		if(g_div_url_default[v][1]=="17")
		{
			g_div_url_default[v][0]=url;
			createDialogDiv(v);
			return true;
		}
	}
	return false;
	
}

function getFocus(e)
{
	if(e.attr("class")==dialog_default_classname)
		e.bind("mousedown",function(){
			changeFocus(e);
		});
	else if(e.attr("class")==iframe_click_div_classname)
		e.bind("mousedown",function(){
			changeFocus(e.parent());
		});
	
}

function changeFocus(e)
{
	var data = $("."+ dialog_default_classname);
	var page = $("#desk_switch").text();
	
	for(var i=0;i<data.length;i++)
	{
		var tmp_e = data.eq(i);
		if(tmp_e.attr("id")!=e.attr("id")&&parseInt(tmp_e.css("z-index"))>parseInt(dialog_default_zindex))
		{
			tmp_e.css("z-index",dialog_default_zindex);
			$("#" + iframe_click_div_prefix + tmp_e.attr("id")).css("display","");
			//$("a[name=\"Drevert_" + tmp_e.attr("id") + "\"]").parent().css("backgroundImage","url(" + g_default_img_url + "/bg_task_nor.png)");
			$("a[name=\"Drevert_" + tmp_e.attr("id") + "\"]").parent().attr("class","");
		}
	}
	e.css({"z-index":parseInt(dialog_default_zindex) + 1 +""});
	$("#" + iframe_click_div_prefix + e.attr("id")).css("display","none");
	//$("a[name=\"Drevert_" + e.attr("id") + "\"]").parent().css("backgroundImage","url(" + g_default_img_url + "/bg_task_cur.png)");
	$("a[name=\"Drevert_" + e.attr("id") + "\"]").parent().attr("class","active");
	if(parseInt(page)!=parseInt(e.attr("page")))
	{
		$("ul.desk-switch").find("li").each(function(){
			if($(this).find("em").text()==e.attr("page"))
				$(this).click();
		});
	}
}

dialog_title_btn_div_classname = "dialog_title_btn_div";
/*
 * create the dialog titile
 * arguments:
 * 				[0]:the parentnode of the title
 * 				[1]:the text that display on the title
 * 				[2]:the height of the title,best percent.
 * all the args have default value
 */
function createDialogTitleDiv()
{
	var ele = arguments[0]?arguments[0]:null;
	if(null==ele)
		return fasle;
	var insert_text = arguments[1]?arguments[1]:dialog_title_default_title;
	var e_height = arguments[2]?arguments[2]:dialog_title_default_height;
	var is_btn = arguments[3]?arguments[3]:false;
	//create div
	e = $("<div/>").attr({
		"class":dialog_title_classname
	}).css({
		"height":e_height,"width":"100%","height":"24px"
	}).appendTo(ele).get(0);
	var title_text = $("<h2/>").attr({
		"id":dialog_title_prefix + ele.id,"class":dialog_title_default_drag_classname
	}).html(insert_text).appendTo(e);
	var tmp_ele = $("<div/>").attr("class",dialog_title_btn_div_classname).css("position","absolute").appendTo(e).get(0);
	
	if(!is_btn)
	{
		tmp_ele.appendChild(createATag("close_"+ele.id,"","dialog_close"));
		tmp_ele.appendChild(createATag("max_"+ele.id,"","dialog_max"));
		tmp_ele.appendChild(createATag("revert_"+ele.id,"display:none","dialog_revert"));
		tmp_ele.appendChild(createATag("min_"+ele.id,"","dialog_min"));
		tmp_ele.appendChild(createATag("refresh_"+ele.id,"","dialog_refresh"));
	}
	else
		tmp_ele.appendChild(createATag("close_"+ele.id,"","app_close"));
	drag(title_text.get(0));
	return e;
}

/*
 * create <a> tag
 */
function createATag()
{
	var ele = document.createElement("a");
	if(arguments[0])
		ele.setAttribute("name",arguments[0]);
	if(arguments[1])
		ele.setAttribute("style",arguments[1]);
	if(arguments[2])
		ele.setAttribute("class",arguments[2]);
	if(arguments[3])
		ele.setAttribute("id",arguments[3]);
	ele.setAttribute("href","javascript:;");
	ele.setAttribute("onmousedown","stopBubble(event)");
	return ele;
}


/*
 * max the dialog div
 */
$(".dialog_max").live("click",function(event){
	ele = $(this).attr("name");
//function dialog_div_max(ele,event)
//{
	stopBubble(event);
	setClientVar();
	var id = ele.split("_");
	id.shift();
	id = id.join("_");
	var e = document.getElementById(id);
	g_dialog_params[id] = new Array(getNum(e.style.left,"px"),getNum(e.style.top,"px"),getNum(e.style.width,"px"),getNum(e.style.height,"px"));
	e.style.left = bg_div_default_left + "px";
	e.style.top = bg_div_default_top - getNum(GetCurrentStyle(header,"height"),"px") + "px";
	e.style.width = bg_default_width -2 - 10 + "px";
	e.style.height = bg_default_height -2 - 10+ "px";
	var e = document.getElementsByName(ele);
	for(var i=0;i<e.length;i++)
		if(e[i].tagName == "A")
		{
			e[i].style.display = "none";
			break;
		}
	refreshDialog("refresh_" + id);
	id = "revert_" + id;
	var e = document.getElementsByName(id);
	for(var i=0;i<e.length;i++)
		if(e[i].tagName == "A")
		{
			e[i].style.display = "";
			break;
		}
	
});

/*
 * revert the dialog div
 */
$(".dialog_revert").live("click",function(event){
	ele = $(this).attr("name");
//function dialog_div_revert(ele,event)
//{
	stopBubble(event);
	var id = ele.split("_");
	id.shift();
	id = id.join("_");
	var e = document.getElementById(id);
	var tm_e = document.getElementsByTagName("a");
	if("D"== ele.substr(0,1))
	{//start with "D" mean it's the display btn click
		for(var i=0;i<tm_e.length;i++)
		{
			if(tm_e[i].name==(ele))
			{
				//document.body.removeChild(tm_e[i]);
				e.style.display = "";
				return;
			}
		}
	}
	e.style.left = g_dialog_params[id][0] + "px";
	e.style.top = g_dialog_params[id][1] + "px";
	e.style.width = g_dialog_params[id][2] + "px";
	e.style.height = g_dialog_params[id][3] + "px";
	var e = document.getElementsByName(ele);
	for(var i=0;i<e.length;i++)
		if(e[i].tagName == "A")
		{
			e[i].style.display = "none";
			break;
		}
	refreshDialog("refresh_" + id);
	id = id.split("_");
	id.unshift("max");
	id = id.join("_");
	var e = document.getElementsByName(id);
	for(var i=0;i<e.length;i++)
		if(e[i].tagName == "A")
		{
			e[i].style.display = "";
			break;
		}
});

/*
 * min the dialog div
 */
$(".dialog_min").live("click",function(){
	ele = $(this).attr("name");
//function dialog_div_min(ele)
//{
	var id = ele.split("_");
	id.shift();
	id = id.join("_");
	var e = document.getElementById(id);
	e.style.display = "none";
});

/*
 * close the dialog div
 */
$(".dialog_close").live("click",function(){
	ele = $(this).attr("name");
//function dialog_div_close(ele)
//{
	var id = ele.split("_");
	id.shift();
	id = id.join("_");
	var e = document.getElementById(id);
	document.body.removeChild(e);
	e = document.getElementById("footer").getElementsByTagName("ul")[0];
	var tmp_e = document.getElementsByTagName("a");
	for(var i=0;i<tmp_e.length;i++)
	{
		if(tmp_e[i].name == ("Drevert_" + id))
		{
			e.removeChild(tmp_e[i].parentNode);
			break;
		}
	}
	for(var i = 0;i<g_div_url.length;i++)
		if(g_div_url[i]==id)
		{
			g_div_url[i] == null;
			break;
		}
});
/*
 * close the app div
 */
$(".app_close").live("click",function(){
	$("#add_app_div").remove();
});

/*
 * refresh the iframen in the dialog
 */
$(".dialog_refresh").live("click",function(){
	id = $(this).attr("name");
	refreshDialog(id);
});

function refreshDialog(id)
{
	id = id.split("_");
	id.shift();
	id = id.join("_");
	var e = document.getElementById(dialog_default_content_prefix + id);
	var ele = e.parentNode;
	e.style.width = ele.style.width;
	e.style.height = (getNum(ele.style.height,"px") - getNum(dialog_title_default_height,"px")) + "px";
	//top.frames[e.name].location.reload();
	//window.frames[e.name].location.reload();
	e.src = e.src;
}
/*
 * display&hide the dialog div
 */
function dialog_div_revert_display(ele)
{
	var id = ele.split("_");
	id.shift();
	id = id.join("_");
	var e = $("#" + id);
	if(e.css("z-index")==dialog_default_zindex)
	{
		changeFocus(e);
		if("none"==e.css("display"))
			e.css({"display":""});
	}
	else
	{
		if("none"==e.css("display"))
		{
			e.css({"display":""});
			changeFocus(e);
		}
		else 
			e.css({"display":"none"});
	}
}

/*
 * create display <a> tag
 * use jquery
 */
function createDisplayBtn(name,id,e,icon)
{
	var e = $("<a/>").attr({
		"name":"Drevert_"+id,
		"href":"javascript:;"
	}).click(function(){
		dialog_div_revert_display(this.name);
	}).appendTo(e?e:document.body);
	var e_div = $("<em></em>").appendTo(e);
	$("<img/>").attr("src",icon).appendTo(e_div);
	$("<p/>").html(name).appendTo(e);
	
}

/*
 * create the display li in the footer bar
 */
function createDisplayLi(title,id,icon)
{
	
	var e_li = $("<li/>");
	createDisplayBtn(title,id,e_li.get(0),icon);
	/*e_li.bind({
		mousemove:function(){
			e_li.css("backgroundImage","url(" + g_default_img_url + "/bg_task_over.png)");
		},
		mouseout:function(){
			var id = e_li.find("a").attr("name");
			id = id.split("_");
			id.shift();
			id = id.join("_");
			if($("#" + id).css("z-index")!=dialog_default_zindex)
				e_li.css("backgroundImage","url(" + g_default_img_url + "/bg_task_cur.png)");
			else
				e_li.css("backgroundImage","url(" + g_default_img_url + "/bg_task_nor.png)");
		}
	});*/
	return e_li.get(0);
}

/*
 * display&hide 
 * arguments:
 * 			e:the target to display&hide
 * 			is_display:to display or hide,true=>display,false=>hide 
 */
function btn_display(e,is_display)
{
	if(is_display)
		is_display = "";
	else
		is_display = "none";
	var ele = $("#" + e.id + " .btn_del");
	if(ele.length==1)
		ele.css("display",is_display);
	else if($("#" + $(e).attr("name") + " .btn_del").length>0)
	{
		$("#" + $(e).attr("name") + " .btn_del").css("display",is_display);
	}
}

/*
 * delete move element
 */
$(".btn_del").live("click",function(event){
	var name = $(this).attr("name");
//function btn_delete(name,event)
//{
	stopBubble(event);
	if($("div[name='"+name+"']").length>0)
		$("div[name='"+name+"']").remove();
	$("#" + name).remove();
	
	var div_id = name.split("_");
	var div_name_width = parseInt(div_id[2]),div_name_height = parseInt(div_id[1]);
	for(var i=0;i<div_name_height;i++)
		for(var j=0;j<div_name_width;j++)
			$("#"+bg_div_default_prefix + (parseInt(div_id[0])+i*bg_div_default_col_num +j)).attr("name",bg_div_default_prefix);
	
	//delete data from the database
	var db_id = name.split("_")[3];
	var tmp = {"id":db_id.toString(),"user_id":g_user_session["userId"],"type":"delete","page":$("#desk_switch").text()};
	tmp = JSON.stringify(tmp);
	$("#save").load(g_baseUrl+"/default/index/returninfo",{"data":tmp});
});


/*
 * check single content can drop 
 * arguments:
 * 		[0]:the target which is checked can drop or not
 * 		[1]:check if itself
 */
function canSingleDrop()
{
	var id = arguments[0]?arguments[0]:-1,o = arguments[1]?arguments[1]:null;
	if(null == document.getElementById(bg_div_default_prefix + id))
		return false;
	//check if ele is display none
	if($("#"+bg_div_default_prefix + id).attr("name")!=bg_div_default_prefix)
		return false;
	var tmp = null;
	if($("div").find("name="+bg_div_default_prefix+id).length>0)
	{
		$("div").find("name="+bg_div_default_prefix+id).each(function(){
			if($(this).display!="none")
				tmp = $(this);
		});
	}
	if(null==tmp)
		return true;
	//for IE:in IE,getElementsByName is equal to getElementsById
	if(ele.length>0&&ele[0].id==(bg_div_default_prefix+id))
		return true;
	if(ele.length>0&&(null==o||ele[0].id!=o.id))
		return false;
	else
		return true;
}

/*
 * check if the rows*cols des can drop
 * arguments:
 * 		[0]:the target that to be dropped
 * 		[1]:the row num of the area
 * 		[2]:the col num of the area
 * 		[3]:the drop content,use to check if it's itself
 */
function canMultiDrop()
{
	var des = arguments[0]?arguments[0]:null;
	var rows = arguments[1]?arguments[1]:0;
	var cols = arguments[2]?arguments[2]:0;
	var o = arguments[3]?arguments[3]:null;
	if(null==des)
		return false;
	var par_id =  getNum(des.id,bg_div_default_prefix)-1;
	for(var i =0;i<rows;++i)
	{
		for(var j = 0;j < cols;++j)
		{
			if((par_id%bg_div_default_col_num + i >=bg_div_default_col_num)||(Math.floor(par_id/bg_div_default_col_num)+j>=bg_div_default_col_num)||(false==canSingleDrop((par_id+1+i*bg_div_default_col_num+j),o)))//test
				return false;
		}
	 }
	 return true;
}

/*
 * check if the multi content can drop on des
 * should check drop on the des,or the next row/col area
 * arguments:
 * 		[0]:the target that to be dropped
 * 		[1]:the drop content,use to check if it's itself
 */
function canMultiDropByObj()
{
	var des = arguments[0]?arguments[0]:null;
	var o = arguments[1]?arguments[1]:null;
	var col_num = parseInt(o.id.split("_")[2]),row_num = parseInt(o.id.split("_")[1]);
	if(null==des)
		return false;
	if(row_num>des[1]||col_num>des[2])
		return false;
	if(!canMultiDrop(des[0],row_num,col_num,o))
		return false;
	return des;
}

/*
 * drag and drop function
 */
function drag(e)
{
	if(e.className == drag_drop_div_default_content_classname)
		e = e.parentNode;
	is_move = null;
	e.onmousedown=function(a)
	{
		is_move = 0;
		var d=document;
		if(!a) 
			a=window.event; 
		var x=a.layerX?a.layerX:a.offsetX,y=a.layerY?a.layerY:a.offsetY;
		if(e.className == drag_drop_div_default_classname)
		{
			drag_move_page = $(e).attr("page");
			changeColorId = new Array(parseInt(e.id.split("_")[0]),parseInt(e.id.split("_")[1]),parseInt(e.id.split("_")[2]));
			changeBackGroundColor(changeColorId[0],changeColorId[1],changeColorId[2],true);
			var div_id = e.id.split("_");
			var div_name_width = div_id[2],div_name_height = div_id[1];
			for(var i=0;i<div_name_height;i++)
				for(var j=0;j<div_name_width;j++)
					$("#"+bg_div_default_prefix + (parseInt(div_id[0])+i*bg_div_default_col_num +j)).attr("name",bg_div_default_prefix);
		}
		else if(e.className == dialog_default_resize_classname)
		{
			var left_val = (a.pageX?a.pageX:a.clientX) - getNum(e.offsetLeft,"px");
			var top_val = (a.pageY?a.pageY:a.clientY) - getNum(e.offsetTop,"px");
			var e_change_top = getNum(e.parentNode.offsetTop,"px");
			var e_change_left = getNum(e.parentNode.offsetLeft,"px");
			var e_change_width = getNum(e.parentNode.offsetWidth,"px");
			var e_change_height = getNum(e.parentNode.offsetHeight,"px");
		}
		else if(e.className == drag_move_classname)
		{
			drag_move_page = $(e).attr("page");
			changeColorId = new Array(parseInt($(e).attr("name").split("_")[0]),parseInt($(e).attr("name").split("_")[1]),parseInt($(e).attr("name").split("_")[2]));
			changeBackGroundColor(changeColorId[0],changeColorId[1],changeColorId[2],true);
			var div_id = e.id.split(drag_move_prefix)[1];
			div_id = div_id.split("_");
			var div_name_width = parseInt(div_id[2]),div_name_height = parseInt(div_id[1]);
			for(var i=0;i<div_name_height;i++)
				for(var j=0;j<div_name_width;j++)
					$("#"+bg_div_default_prefix + (parseInt(div_id[0])+i*bg_div_default_col_num +j)).attr("name",bg_div_default_prefix);
		}
		if(e.setCapture)
			e.setCapture();
		else if(window.captureEvents)
			window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);  
		
		 d.onmousemove=function(a){  
	            if(!a)
	            	a=window.event;  
	            if(!a.pageX)
	            	a.pageX=a.clientX;  
	            if(!a.pageY)
	            	a.pageY=a.clientY;  
	            var tx=a.pageX-x;
	            var ty=a.pageY-y;
	            if(tx!=getNum(e.style.left,"px")||ty!=getNum(e.style.top,"px"))
	            	is_move = 1;
	            if(e.className == dialog_title_default_drag_classname)//move the dialog div
            	{
	            	e.parentNode.parentNode.style.left=tx;  
		            e.parentNode.parentNode.style.top=ty;
            	}
	            else if(e.className == dialog_default_resize_classname)//resize the dialog div
            	{
	            	var isLeft = false,isTop = false,lockX = true,lockY = true;
	            	var data = e.id.split("_");
	            	if(data.length>2)
	            		return false;
            		else if(data.length==1)
            		{
	            		if("left"==data[0])
            			{
	            			isLeft = true;
	            			lockX = false;
            			}
	            		else if("top" == data[0])
            			{
	            			isTop = true;
	            			lockY = false;
            			}
	            		else if("right" == data[0])
	            			lockX = false;
	            		else if("bottom" == data[0])
	            			lockY = false;
            		}
            		else
        			{
            			lockX = false;
            			lockY = false;
            			if("left"==data[0])
        				{
	            			isLeft = true;
	            			if("top" == data[1])
	            				isTop = true;
	            			
        				}
	            		else if("top" == data[1])
	            				isTop = true;
        			}
	            	//start resize the div
	            	
	            	var ele = e.parentNode;
	            	//var max_width = bg_default_width - getNum(ele.offsetLeft,"px") - 2;
	            	//var max_height = bg_default_height - getNum(ele.offsetTop,"px") - 2;
	            	var dis_width = 0,dis_height=0,dis_left,dis_top;
	            	dis_left = a.pageX - left_val;
	            	dis_top = a.pageY - top_val;
	            	if(isLeft)
            		{
	            		dis_width = e_change_width - dis_left;
	            		ele.style.left = e_change_left + dis_left + "px";
            		}
	            	else
	            		dis_width = e.offsetWidth + dis_left;
	            	if(isTop)
            		{
	            		dis_height = e_change_height - dis_top;
	            		ele.style.top = e_change_top + dis_top + "px";
            		}
	            	else
	            		dis_height = e.offsetHeight + dis_top;
	            	if(dis_width < minWidth)
	            		dis_width = minWidth;
	            	//if(dis_width > max_width)
	            		//dis_width = max_width;
	            	if(!lockX)
	            		ele.style.width = dis_width + "px";
	            	
	            	if(dis_height < minHeight)
	            		dis_height = minHeight;
	            	//if(dis_height > max_height)
	            		//dis_height = max_height;
	            	if(!lockY)
	            		ele.style.height = dis_height + "px";
	            	if((isLeft&&dis_width == minWidth)||(isTop&&dis_height == minHeight))
	            		document.onmousemove = null;
	            	
            	}
	            else if(e.className == drag_move_classname)
	        	{	
	            	var ele = $("#"+$(e).attr("name"));
	            	ele.css({"left":tx + getNum(ele.css("left"),"px") - getNum($(e).css("left"),"px"),"top":ty + getNum(ele.css("top"),"px") - getNum($(e).css("top"),"px")});
	            	$(e).css({"left":tx,"top":ty});
	        	}
	            else //move the e element
            	{
		            e.style.left=tx;  
		            e.style.top=ty;
            	}
	            if(e.className == drag_drop_div_default_classname||e.className == drag_move_classname)//change the background divs' border to remind the user if can drop or not
            	{
	            	var ele = null;
	            	if(e.className == drag_move_classname)
	            		ele = getPos(document.getElementById($(e).attr("name")));
	            	else
		            	ele = getPos(e);
		            if(null!=ele[0])
	            	{
		            	var is_green = true;
			            if(null!=changeColorId&&(getNum(ele[0].id,bg_div_default_prefix)!=changeColorId[0]||ele[1]==changeColorId[1]||ele[2]==changeColorId[2]))
		            	{
			            	setBackGroundColorBack();
		            	}
			            var e_on = e;
			            if(e.className == drag_move_classname)
			            	e_on = document.getElementById($(e).attr("name"));
			            if(!canMultiDropByObj(ele,e_on))
				            	is_green = false;
				        changeBackGroundColor(getNum(ele[0].id,bg_div_default_prefix),ele[1],ele[2],is_green);
	            	}
		            else
		            	setBackGroundColorBack();
            	}
	            if(e.className == drag_move_classname)
            	{
	            	var ele = fnGetPage(a.pageX,a.pageY);
	            	if(null!=ele)
            		{
	            		
	            		$(ele).click();
	            		$(e).attr("page",$(ele).text()).css("display","");
	            		$("#"+$(e).attr("name")).attr("page",$(ele).text()).css("display","");
            		}
            	}
	        };  
	  
	        d.onmouseup=function(){
	        	
	        	if(e.className == drag_drop_div_default_classname||e.className == drag_move_classname)//move the e element to the background divs
        		{
	        		var tmp_ele_inner = null;
	        		if(e.className == drag_move_classname)
            		{
	            		tmp_ele_inner = e;
	            		e = document.getElementById($(e).attr("name"));
            		}
	        		if(null!=changeColorId)
		        		setBackGroundColorBack();
	        		if(0==is_move)
	        		{
		        		var e_url = createDialogDiv(e.id);
		        		if(e_url)
		        			g_div_url[e.id] = e_url.id;
		        		is_move = null;
	        		}
						var ele = getPos(e);
						//can not drop,back
						if(null==ele||ele.className==drag_drop_div_default_classname||!canMultiDropByObj(ele,e))
						{
							$(e).attr("page",drag_move_page);
							ele = document.getElementById(e.getAttribute("name"));
							$(ele).attr("page",drag_move_page);
						}
						else
							ele = ele[0];
						if(null != tmp_ele_inner)
						{
			            	e = tmp_ele_inner;
			            	tmp_ele_inner = null;
						}
						//move the element
						drop(ele,e);
        		}
	        	else if(e.className == dialog_default_resize_classname)
	        		refreshDialog("refresh_" + e.parentNode.id);
	            if(e.releaseCapture)  
	                e.releaseCapture();  
	            else if(window.captureEvents)  
	                window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);  
	            d.onmousemove = null;
	            d.onmouseup=null;  
	        };  
	    };  
	e.onmousemove = function()
	{
		if(e.className!=drag_drop_div_default_classname&&e.className != drag_move_classname)
			return;
		btn_display(e,true);
	};
	e.onmouseout = function(a)
	{
		if(e.className!=drag_drop_div_default_classname&&e.className != drag_move_classname)
			return;
		
		if(!a)
			a = window.event;
		//check if the mouse is out of the element or just move to the child of the e element
		//if just move to the child of e,return
		var browser=navigator.userAgent;   //get the browser attribut
        /*if (browser.indexOf("Firefox")>0)
        {  //if is Firefox
            if (e.contains(a.relatedTarget)) 
            {  //if is child node
                  return;  
             } 
        } */
        if (browser.indexOf("MSIE")>0)
        {  //if is IE
              if (e.contains(event.toElement))
              {  //if is child node
                     return; 
              }
        }
        else
    	{
        	if (e.contains(a.relatedTarget)) 
            { 
                  return;  
             } 
    	}
        btn_display(e,false);
	};
}

$(".test").live({
	mousemove:function(){
		btn_display($(this).get(0),true);
	},
	mouseout:function(){
		btn_display($(this).get(0),false);
	}
});

function mouseMoveDisplay(e)
{
	if($("#" + e.id + " .btn_del").length == 0)
		return;
	e.onmousemove = function()
	{
		btn_display(e,true);
	};
	e.onmouseout = function(a)
	{
		if(!a)
			a = window.event;
		//check if the mouse is out of the element or just move to the child of the e element
		//if just move to the child of e,return
		var browser=navigator.userAgent;   //get the browser attribut
        if (browser.indexOf("Firefox")>0)
        {  //if is Firefox
            if (e.contains(a.relatedTarget)) 
            {  //if is child node
                  return;  
             } 
        } 
        if (browser.indexOf("MSIE")>0)
        {  //if is IE
              if (e.contains(event.toElement))
              {  //if is child node
                     return; 
              }
        }
    	btn_display(e,false);
	};
}

/*
 * drop o on the des
 * arguments:
 * 		des:the area to be dropped
 * 		e:the move element
 */
function drop(des,e)
{
	
	var tmp_ele_inner = null;
	if(e.className == drag_move_classname)
	{
		tmp_ele_inner = e;
		e = $("#"+$(e).attr("name"));
		var dis_left = getNum($(tmp_ele_inner).css("left"),"px") - getNum(e.css("left"),"px");
		var dis_top = getNum($(tmp_ele_inner).css("top"),"px") - getNum(e.css("top"),"px");
	}
	else
		e = $(e);
	var old_id = e.attr("id");
	var ids = old_id.split("_");
	
	ids[0] = getNum(des.id,bg_div_default_prefix);
	e.attr({
		"name":des.id,"id":ids.join("_")
		}).css({
		"top":$(des).css("top"),"left":$(des).css("left")
	});
	var div_id = old_id.split("_");
	var div_name_width = div_id[2],div_name_height = div_id[1];
	for(var i=0;i<div_name_height;i++)
		for(var j=0;j<div_name_width;j++)
			$("#"+bg_div_default_prefix + (parseInt(ids[0])+i*bg_div_default_col_num +j)).attr("name",old_id);
	
	if(e.attr("id")!=old_id)
	{
		g_div_url_default[e.attr("id")] = g_div_url_default[old_id];
		g_div_url_default[old_id] = null;
		if(null!=g_div_url[old_id])
		{
			g_div_url[e.attr("id")] = g_div_url[old_id];
			g_div_url[old_id] = null;
		}
		//save into the database
		var db_id = e.attr("id").split("_")[3];
		var db_pos_x = (ids[0]-1)%bg_div_default_col_num + 1,db_pos_y = Math.floor((ids[0]-1)/bg_div_default_col_num) + 1;
		var tmp = {"id":db_id.toString(),"user_id":g_user_session["userId"],"pos_x":db_pos_x.toString(),"pos_y":db_pos_y.toString(),"type":"update","page":$("#desk_switch").text()};
		tmp = JSON.stringify(tmp);
		
		$("#save").load(g_baseUrl+"/default/index/returninfo",{"data":tmp});
	}
	
	
	
	$("a[name='"+old_id+"']").attr({"name":e.attr("id")});
	if(null!=tmp_ele_inner)
	{
		e = $(tmp_ele_inner).attr({
				"name":e.attr("id"),"id":drag_move_prefix + e.attr("id")
		}).css({
			"top":getNum(e.css("top"),"px") + dis_top,"left":getNum(e.css("left"),"px") + dis_left
		});
    	tmp_ele_inner = null;
    	dis_top = null;
    	dis_left = null;
	}
	
	
	
}

/*
 * get the element by target's position
 * not the target itself
 */
function getPos(o)
{
	var ele = document.elementFromPoint(getNum(o.style.left,"px")-1,getNum(o.style.top,"px")-1);//-1,not select itself
	var row = parseInt(o.id.split("_")[1]),col = parseInt(o.id.split("_")[2]);
	ele = fnGetEle(ele,o);
	var tmp_id = 0;
	if(null!=ele)
	{
		//left-top in the background
		tmp_id = getNum(ele.id,bg_div_default_prefix);
		if((getNum(o.style.left,"px")-getNum(ele.style.left,"px"))>bg_div_default_width/2&&((tmp_id-1)%bg_div_default_col_num+col+1<=bg_div_default_col_num)&&(tmp_id + (row-1)*bg_div_default_col_num + col + 1)<=bg_div_default_num)
			tmp_id +=1;
		if((getNum(o.style.top,"px")-getNum(ele.style.top,"px"))>bg_div_default_height/2&&(tmp_id + (row-1)*bg_div_default_col_num + col + bg_div_default_col_num)<=bg_div_default_num)
			tmp_id +=bg_div_default_col_num;
		ele = document.getElementById(bg_div_default_prefix + tmp_id);
		var row_add = row<(bg_div_default_row_num-Math.floor((tmp_id-1)/bg_div_default_col_num) + 1)?row:(bg_div_default_row_num-Math.floor((tmp_id-1)/bg_div_default_col_num) + 1);
		var col_add = col<(bg_div_default_col_num-(tmp_id-1)%bg_div_default_col_num)?col:(bg_div_default_col_num-(tmp_id-1)%bg_div_default_col_num);
		return new Array(ele,row_add,col_add);
	}
	else
	{
		//left-top is out of the bandary ,check the right-top
		ele = document.elementFromPoint(getNum(o.style.left,"px")+getNum(o.style.width,"px")+1,getNum(o.style.top,"px")-1);
		ele = fnGetEle(ele,o);
		if(null!=ele)
		{
			//right-top in the background
			tmp_id = getNum(ele.id,bg_div_default_prefix);
			if((getNum(o.style.top,"px")-getNum(ele.style.top,"px"))>bg_div_default_height/2&&(tmp_id + row*bg_div_default_col_num)<=bg_div_default_num)
				tmp_id +=bg_div_default_col_num;
			var row_add = row<(bg_div_default_row_num-Math.floor(tmp_id/bg_div_default_col_num))?row:(bg_div_default_row_num-Math.floor(tmp_id/bg_div_default_col_num));
			var col_add = col<((tmp_id-1)%bg_div_default_col_num+1)?col:((tmp_id-1)%bg_div_default_col_num+1);
			tmp_id =tmp_id - col_add + 1;
			ele = document.getElementById(bg_div_default_prefix + tmp_id);
			return new Array(ele,row_add,col_add);
		}
		else
		{
			//right-top is out of the bandary,check the left-bottom
			ele = document.elementFromPoint(getNum(o.style.left,"px")-1,getNum(o.style.top,"px")+getNum(o.style.height,"px")+1);
			ele = fnGetEle(ele,o);
			if(null!=ele)
			{
				//left-bottom in the background
				tmp_id = getNum(ele.id,bg_div_default_prefix);
				if((getNum(o.style.left,"px")-getNum(ele.style.left,"px"))>bg_div_default_width/2&&((tmp_id-1)%bg_div_default_col_num+col+1<=bg_div_default_col_num)&&(tmp_id + col + 1)<=bg_div_default_num	)
					tmp_id +=1;
				var row_add = row<(Math.floor((tmp_id-1)/bg_div_default_col_num)+1)?row:(Math.floor((tmp_id-1)/bg_div_default_col_num)+1);
				var col_add = col<(bg_div_default_col_num-(tmp_id-1)%bg_div_default_col_num)?col:(bg_div_default_col_num-(tmp_id-1)%bg_div_default_col_num);
				tmp_id -=(row_add-1)*bg_div_default_col_num;
				ele = document.getElementById(bg_div_default_prefix + tmp_id);
				return new Array(ele,row_add,col_add);
			}
			else
			{
				//left-bottom is out of the bandary,check the right-bottom
				ele = document.elementFromPoint(getNum(o.style.left,"px")+getNum(o.style.width,"px")+1,getNum(o.style.top,"px")+getNum(o.style.height,"px")+1);
				ele = fnGetEle(ele,o);
				if(null!=ele)
				{
					//right-bottom in the background
					tmp_id = getNum(ele.id,bg_div_default_prefix);
					var row_add = row<(Math.floor((tmp_id-1)/bg_div_default_col_num)+1)?row:(Math.floor((tmp_id-1)/bg_div_default_col_num)+1);
					var col_add = col<((tmp_id-1)%bg_div_default_col_num+1)?col:((tmp_id-1)%bg_div_default_col_num+1);
					tmp_id -=((row_add-1)*bg_div_default_col_num+col_add-1);
					ele = document.getElementById(bg_div_default_prefix + tmp_id);
					return new Array(ele,row_add,col_add);
				}
			}
		}
		
	}
	return new Array(ele,0,0);
}

/*
 * get the nearest bg_div
 * not the o
 */
function fnGetEle( ele,o )
{
	while(null!=ele)
	{
		if(ele.className==bg_div_default_classname&&ele.id!=o.id)
			break;
		ele = ele.parentNode;
	}
	if(null!=ele&&"HTML"==ele.tagName)
		return null;
	return ele;
}


function fnGetPage(x,y)
{
	var ele = document.elementFromPoint(x,y);
	while(null!=ele&&null!=ele.parentNode)
	{
		if(ele.parentNode.className=="desk-switch")
			break;
		ele = ele.parentNode;
	}
	if(null==ele||null==ele.parentNode)
		return null;
	return ele;
}

/*
 * get num from str separate by separate
 */
function getNum(str,separate)
{
	if(null==str)
		return;
	if(!isNaN(str))
		return str;
	var s = str.split(separate);
	return s[0]?parseInt(s[0]):parseInt(s[1]);
}

/*
 * add color to the area
 */
function changeBackGroundColor()
{
	var id = parseInt(arguments[0]?arguments[0]:-1);
	var rows = parseInt(arguments[1]?arguments[1]:0);
	var cols = parseInt(arguments[2]?arguments[2]:0);
	var is_green = arguments[3]?arguments[3]:false;
	var backGroundColor = "green";
	if(-1==id)
		return false;
	if(!is_green)
		backGroundColor = "red";
	//set to white
	if(null!=changeColorId&&id!=changeColorId[0])
		setBackGroundColorBack();
	 for(var i = 0;i < rows;++i)
		 for(var j = 0; j < cols ;++j)
		 {
			 var e = document.getElementById(bg_div_default_prefix+(id + i*bg_div_default_col_num + j));
			 if(null!=e)
			 	e.style.border = "2px solid " +backGroundColor;
		 }
	 changeColorId = new Array(id,rows,cols);
}

/*
 * set the background back
 */
function setBackGroundColorBack()
{
	if(null==changeColorId)
		return ;
	var id = changeColorId[0],rows=changeColorId[1],cols=changeColorId[2];
	for(var i = 0;i < rows;++i)
		 for(var j = 0; j < cols ;++j)
		{
			 var tmp_id = id + i*bg_div_default_col_num + j;
			 var e = document.getElementById(bg_div_default_prefix+tmp_id);
			 if(null!=e)
				 e.style.border = "0px solid blue";
		}
	changeColorId=null;
}


/*
 * overflow hidden and scroll
 */
function setOverflow()
{
	setClientVar();
	if(g_client_width>overflow_x)
		$("body").css({"overflow-x":"hidden"});
	else
		$("body").css({"overflow-x":"scroll"});
	if(g_client_height>overflow_y)
		$("body").css({"overflow-y":"hidden"});
	else
		$("body").css({"overflow-y":"scroll"});
}






