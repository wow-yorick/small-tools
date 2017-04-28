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
	function getTemplateList(){
		$.post('listTemplates.jsp',null,function(data){
					$('#templateSelector').find('option').remove();
					var templateSelector=$('#templateSelector')[0];
					for(var i=0;i<data.length;i++){
						templateSelector.options[i]=new Option(data[i],data[i]);
					}
				},'json');
	}
	getTemplateList();
	$('#button-set a').click(function(e){
		var text=$(this).text();
		if(text=='打印'||text=='打印预览'){
			// 请选择需要打印的快递单
			var selected=getSelectedOrders();
			if(!selected){
				alert('请选择需要打印的快递单.');
				return;
			}
			var myDoc={
				settings:'auto', // 表示paperWidth,paperHeight,orientation,从page1的style上自动获取
				documents:'getPages2.0.jsp?orders='+selected+'&settingsID='
						+encodeURI($('#templateSelector').val()),
				marginIgnored:true,
				enableScreenOnlyClass:true,
				settingsID:$('#templateSelector').val(),
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
			editorSettings={
				type:'user.design', // user.design:运行时设计报表模板,user.position,运行时调整打印位置，保存注册表
				url:'../demo_user_design_jquery/getPages2.0.jsp?orders='+selected, // 打印测试页
				backgroundUploadService:'../demo_user_design_jquery/uploadBackground.jsp',// '../demo_js_new/uploadBackground.jsp',//
				// 接收票据底图上传的服务位置
				templateService:'../demo_user_design_jquery/templateService.jsp?',// 
				// 可增加的字段
				// names = new String[] { "订单号", "收件人", "单位", "省", "市", "区",
				fields:[{
							type:'label',
							text:'+'
						},{
							type:'text',
							text:'订单号'
						},{
							type:'text',
							text:'收件人'
						},{
							type:'text',
							text:'单位'
						},{
							type:'text',
							text:'省'
						},{
							type:'text',
							text:'市'
						},{
							type:'text',
							text:'区'
						},{
							type:'text',
							text:'地址'
						},{
							type:'text',
							text:'电话'
						},{
							type:'text',
							text:'手机'
						},{
							type:'text',
							text:'物品'
						},{
							type:'text',
							text:'发件人'
						},{
							type:'text',
							text:'发件人单位'
						},{
							type:'text',
							text:'发件人省'
						},{
							type:'text',
							text:'发件人市'
						},{
							type:'text',
							text:'发件人区'
						},{
							type:'text',
							text:'发件人地址'
						},{
							type:'text',
							text:'发件人电话'
						},{
							type:'text',
							text:'发件人手机'
						},{
							type:'barcode',
							text:'订单号',
							codetype:'code128'
						}]
			};
			if(text=='修改模板'){
				editorSettings.settingsID=$('#templateSelector').val();
			}
			editorSettings.callback=function(lastSavedId){
				getTemplateList();
			}
			window
					.showModalDialog(
							'../jatoolsPrinterUI/index.htm',
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
