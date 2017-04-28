// 快递单收件人数据
// 为演示方便，直接以二维数组的形式给出
// 在实际项目中,该数据一般通过ajax调用从后台获得.
var printData=[{
	cell:['100','王德明','北京斯达软件有限公司','北京市','西城区','','展览馆路XXX号','010-88635255',
			'13790438608','合同']
},{
	cell:['101','崔永山','山东省淄博市行政服务中心','山东省','淄博','西湖区','西斗门路12号天堂软件园19b1',
			'88254255','13777865078','发票']
},{
	cell:['102','李晓','深圳市科达信息技术有限公司','广东省','深圳市','南山区','高新技术产业园北区朗山路',
			'0755-26991111','13923841111','合同']
},{
	cell:['103','张春燕','农业部渔政指挥中心','北京','','朝阳区','西斗门路12号天堂软件园19b1',
			'010-59191111','13683151111','培训资料']
},{
	cell:['104','李涛','中联新佳科技（北京）有限公司','山东省','济南市','','洪楼西路101号广场4号楼2单元999室',
			'0531-88031111-603','13655311111','技术文档']
},{
	cell:['105','宋小波','上海广大电子技术有限公司','上海市','徐汇区','','乐山路33号慧谷创业10号楼700室',
			'021-51711111','13524921111','发票']
},{
	cell:['106','王燕','浙江省渔业船舶交易服务中心','浙江省','杭州','拱墅区','莫干山路76号万达宾馆北楼345室',
			'0571-89912222','13732281111','技术资料']
},{
	cell:['107','刘承光','阳光保险集团股份有限公司','北京市','海淀区','','花园北路22号湖南大厦A座1层',
			'010-59936666','13621215678','保险单']
},{
	cell:['108','梁森','广州市明光计算机科技有限公司','广东省','广州市','天河区','天河北路国家软件基地科贸园区991号1009',
			'020-38383333-801','13711173372','报销单据']
},{
	cell:['109','吴敏珠','北京蓝图信息技术有限公司','北京市','朝阳区','','朝外南大街三丰北里六号楼2层',
			'010-85615555-851','13910507777','技术文档']
}];
$(function(){
	// 生成 jquery ui buttset
	$('#button-set').buttonset();
	var flexi=$("#print-data-table").flexigrid({
				checkbox:true,
				onDblClick:function(){
					flexi.flexEdit(this,event);
				},
				dataType:'json',
				colModel:[{
					display:'订单号',
					name:'订单号',
					width:60
						// ,
						// hide:false
					},{
					display:'收件人',
					name:'收件人',
					width:80,
					sortable:true
				},{
					display:'单位',
					name:'收件人单位',
					width:180,
					sortable:true
				},{
					display:'省',
					name:'收件省',
					width:80,
					sortable:true
				},{
					display:'市(县)',
					name:'收件市',
					width:80,
					sortable:true
				},{
					display:'区(镇)',
					name:'收件区',
					width:80,
					sortable:true
				},{
					display:'地址',
					name:'收件地址',
					width:210,
					sortable:true
				},{
					display:'电话',
					name:'收件人电话',
					width:110,
					sortable:true
				},{
					display:'手机',
					name:'收件人手机',
					width:80,
					sortable:true
				},{
					display:'物品',
					name:'物品名称',
					width:80,
					sortable:true
				}],
				width:'auto',
				height:'250'
			});
	flexi.flexAddData({
				total:printData.length,
				page:1,
				rows:printData
			});
	$('#button-set a').click(function(e){
		var text=$(this).text();
		if(text!='打印位置调整'){
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
			if(text=='打印'){
				jatoolsPrinter.print(myDoc,true);
			}else if(text=='打印预览'){
				jatoolsPrinter.printPreview(myDoc);
			}
		}else{
			var selected=getSelectedOrders();
			if(!selected){
				// 如果一个都没选择，则以第一个单据作为设计依据
				selected='100';
			}
			var editorSettings={
				type:'user.position', // user.design:运行时设计报表模板,user.position,运行时调整打印位置，保存注册表
				url:'../demo_user_position_jquery/getPages.jsp?orders='+selected, // 用于拖放设计的页面,如果有多页,设计面板上只显示第一页，用于拖放
				settingsID:'mydoc1' // 拖放后,保存注册表时的对应settingsID
			};
			window
					.showModalDialog(
							'../jatoolsPrinter/index.htm',
							editorSettings,
							'dialogWidth=1150px;dialogHeight=670px;status=no;help=no;scroll=no;resizable=yes');
		}
	});
	function getSelectedOrders(){
		var result=[];
		$("#print-data-table").find('.trSelected').each(function(){
					result.push($(this).find('td:first').text());
				});
		return result.join(',');
	}
});
