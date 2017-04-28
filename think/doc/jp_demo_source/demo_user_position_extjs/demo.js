Ext.BLANK_IMAGE_URL="extjs/img/s.gif";
Ext.QuickTips.init();
Ext.onReady(function(){
	function getSelectedOrders(){
		var result=[];
		var selected=Ext.getCmp('data-grid').getSelectionModel().getSelections();
		if(selected&&selected.length){
			for(var i=0;i<selected.length;i++){
				result.push(selected[i].get('ID'));
			}
		}
		return result.join(',');
	}
	function doPrint(how){
		// 请选择需要打印的快递单
		var selected=getSelectedOrders();
		if(!selected){
			Ext.Msg.alert('错了','请选择需要打印的快递单.');
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
			url:'../demo_user_position_extjs/getPages.jsp?orders='+selected, // 用于拖放设计的页面,如果有多页,设计面板上只显示第一页，用于拖放
			settingsID:'mydoc1' // 拖放后,保存注册表时的对应settingsID
		};
		window
				.showModalDialog(
						'../jatoolsPrinterUI/index.htm',
						editorSettings,
						'dialogWidth=1150px;dialogHeight=670px;status=no;help=no;scroll=no;resizable=yes');
	}
	var sm=new Ext.grid.CheckboxSelectionModel();
	var cm=new Ext.grid.ColumnModel([sm,{
				header:"订单号",
				dataIndex:"ID",
				sortable:true,
				align:"left",
				width:1
			},{
				header:"收件人",
				dataIndex:"name",
				sortable:true,
				align:"left",
				width:1
			},{
				header:"单位",
				dataIndex:"company",
				sortable:true,
				align:"left",
				width:3
			},{
				header:"省",
				dataIndex:"prov",
				sortable:true,
				align:"left",
				width:1
			},{
				header:"市(县)",
				dataIndex:"city",
				sortable:true,
				align:"left",
				width:1
			},{
				header:"区(镇)",
				dataIndex:"district",
				sortable:true,
				align:"left",
				width:1
			},{
				header:"地址",
				dataIndex:"address",
				sortable:true,
				align:"left",
				width:4
			},{
				header:"电话",
				dataIndex:"tel",
				sortable:true,
				align:"left",
				width:2
			},{
				header:"手机",
				dataIndex:"mobile",
				sortable:true,
				align:"left",
				width:1
			},{
				header:"物品",
				dataIndex:"article",
				sortable:true,
				align:"left",
				width:1
			}]);
	var grid=new Ext.grid.GridPanel({
		id:'data-grid',
		region:'center',
		ds:new Ext.data.ArrayStore({
			data:[
					['100','王德明','北京斯达软件有限公司','北京市','西城区','','展览馆路XXX号','010-88635255',
							'13790438608','合同'],
					['101','崔永山','山东省淄博市行政服务中心','山东省','淄博','西湖区','西斗门路12号天堂软件园19b1',
							'88254255','13777865078','发票'],
					['102','李晓','深圳市科达信息技术有限公司','广东省','深圳市','南山区','高新技术产业园北区朗山路',
							'0755-26991111','13923841111','合同'],
					['103','张春燕','农业部渔政指挥中心','北京','','朝阳区','西斗门路12号天堂软件园19b1',
							'010-59191111','13683151111','培训资料'],
					['104','李涛','中联新佳科技（北京）有限公司','山东省','济南市','','洪楼西路101号广场4号楼2单元999室',
							'0531-88031111-603','13655311111','技术文档'],
					['105','宋小波','上海广大电子技术有限公司','上海市','徐汇区','','乐山路33号慧谷创业10号楼700室',
							'021-51711111','13524921111','发票'],
					['106','王燕','浙江省渔业船舶交易服务中心','浙江省','杭州','拱墅区','莫干山路76号万达宾馆北楼345室',
							'0571-89912222','13732281111','技术资料'],
					['107','刘承光','阳光保险集团股份有限公司','北京市','海淀区','','花园北路22号湖南大厦A座1层',
							'010-59936666','13621215678','保险单'],
					['108','梁森','广州市明光计算机科技有限公司','广东省','广州市','天河区',
							'天河北路国家软件基地科贸园区991号1009','020-38383333-801','13711173372','报销单据'],
					['109','吴敏珠','北京蓝图信息技术有限公司','北京市','朝阳区','','朝外南大街三丰北里六号楼2层',
							'010-85615555-851','13910507777','技术文档']],
			fields:["ID","name","company","prov","city","district","address","tel",
					"mobile","article"]
		}),
		sm:sm,
		cm:cm,
		stripeRows:true,
		enableHdMenu:false,
		viewConfig:{
			forceFit:true
		},
		tbar:new Ext.Toolbar({
					items:[{
								text:"打印",
								handler:function(){
									doPrint('打印')
								}
							},{
								text:"打印预览",
								handler:function(){
									doPrint('打印预览')
								}
							},{
								text:"打印位置调整",
								handler:doPosition
							}]
				})
	});
	var viewport=new Ext.Viewport({
				layout:'border',
				items:[grid]
			});
});