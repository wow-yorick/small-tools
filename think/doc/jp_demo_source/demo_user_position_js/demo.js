function selectAll(me){
	var checks=document.getElementsByTagName('input');
	for(var i=0;i<checks.length;i++){
		if(checks[i]!=me){
			checks[i].checked=me.checked;
		}
	}
}
function getSelectedOrders(){
	var result=[];
	var checks=document.getElementsByTagName('input');
	for(var i=0;i<checks.length;i++){
		if(checks[i].value&&checks[i].checked){
			result.push(checks[i].value);
		}
	}
	return result.join(',');
}
function doPrint(how){
	// 请选择需要打印的快递单
	var selected=getSelectedOrders();
	if(!selected){
		alert('请选择需要打印的快递单.');
		return;
	}
	var myDoc={
		settings:{
			paperWidth:1280,
			paperHeight:2330,
			orientation:2
		},
		documents:'getPages.jsp?orders='+selected,
		marginIgnored:true,
		enableScreenOnlyClass:true,
		settingsID:'mydoc1',
		copyrights:'杰创软件拥有版权  www.jatools.com'
	};
	var jatoolsPrinter=navigator.userAgent.indexOf('MSIE')>-1?document
			.getElementById('ojatoolsPrinter'):document
			.getElementById('ejatoolsPrinter');
	if(how=='打印'){
		jatoolsPrinter.print(myDoc,true);
	}else{
		jatoolsPrinter.printPreview(myDoc);
	}
}
function doPosition(){
	var selected=getSelectedOrders();
	if(!selected){
		// 如果一个都没选择，则以第一个单据作为设计依据
		selected='100';
	}
	var editorSettings={
		type:'user.position', // user.design:运行时设计报表模板,user.position,运行时调整打印位置，保存注册表
		url:'../demo_user_position_js/getPages.jsp?orders='+selected, // 用于拖放设计的页面,如果有多页,设计面板上只显示第一页，用于拖放
		settingsID:'mydoc1' // 拖放后,保存注册表时的对应settingsID
	};
	window
			.showModalDialog(
					'../jatoolsPrinterUI/index.htm',
					editorSettings,
					'dialogWidth=1150px;dialogHeight=670px;status=no;help=no;scroll=no;resizable=yes');
}
