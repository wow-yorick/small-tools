<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>

<%
	// 快递单收件人数据
	// 为演示方便，直接以二维数组的形式给出
	// 在实际项目中,该数据一般通过访问数据库获得.
	Object[][] rows = {
			new Object[] { "100", "王德明", "北京斯达软件有限公司", "北京市", "西城区",
					"", "展览馆路XXX号", "010-88635255", "13790438608", "合同" },
			new Object[] { "101", "崔永山", "山东省淄博市行政服务中心", "山东省", "淄博",
					"西湖区", "西斗门路12号天堂软件园19b1", "88254255",
					"13777865078", "发票" },
			new Object[] { "102", "李晓", "深圳市科达信息技术有限公司", "广东省", "深圳市",
					"南山区", "高新技术产业园北区朗山路", "0755-26991111",
					"13923841111", "合同" },
			new Object[] { "103", "张春燕", "农业部渔政指挥中心", "北京", "", "朝阳区",
					"西斗门路12号天堂软件园19b1", "010-59191111", "13683151111",
					"培训资料" },
			new Object[] { "104", "李涛", "中联新佳科技（北京）有限公司", "山东省", "济南市",
					"", "洪楼西路101号广场4号楼2单元999室", "0531-88031111-603",
					"13655311111", "技术文档" },
			new Object[] { "105", "宋小波", "上海广大电子技术有限公司", "上海市", "徐汇区",
					"", "乐山路33号慧谷创业10号楼700室", "021-51711111",
					"13524921111", "发票" },
			new Object[] { "106", "王燕", "浙江省渔业船舶交易服务中心", "浙江省", "杭州",
					"拱墅区", "莫干山路76号万达宾馆北楼345室", "0571-89912222",
					"13732281111", "技术资料" },
			new Object[] { "107", "刘承光", "阳光保险集团股份有限公司", "北京市", "海淀区",
					"", "花园北路22号湖南大厦A座1层", "010-59936666",
					"13621215678", "保险单" },
			new Object[] { "108", "梁森", "广州市明光计算机科技有限公司", "广东省", "广州市",
					"天河区", "天河北路国家软件基地科贸园区991号1009",
					"020-38383333-801", "13711173372", "报销单据" },
			new Object[] { "109", "吴敏珠", "北京蓝图信息技术有限公司", "北京市", "朝阳区",
					"", "朝外南大街三丰北里六号楼2层", "010-85615555-851",
					"13910507777", "技术文档" } };
	// 为查询方便,转到Map上保存
	Map<String, Object[]> data = new HashMap<String, Object[]>();
	for (Object[] row : rows) {
		data.put((String) row[0], row);
	}
	// 收件人信息
	Object[] sender = new Object[] { "", "张国栋", "杭州杰创软件有限公司", "浙江省",
			"杭州市", "西湖区", "杭州市西斗门路3号天堂软件园A幢19层B1座", "010-85615555-851",
			"13910507777", "技术文档" };
	// 字段索引,便于根据字段名称,找出在数组中的位置
	Map<String, Integer> nameIndex = new HashMap<String, Integer>();
	String[] names = new String[] { "订单号", "收件人", "单位", "省", "市", "区",
			"地址", "电话", "手机", "物品" };
	for (int i = 0; i < names.length; i++) {
		nameIndex.put(names[i], i);
	}
	nameIndex.put("发件人", nameIndex.get("收件人"));
	// 生成页
	String[] orders = request.getParameter("orders").split(",");
%>
<html>
<head>
<title>jatoolsPrinter打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.jp-page {
	position: relative
}

.jp-text,.jp-label,.jp-image,.jp-barcode {
	position: absolute;
	overflow: hidden
}

.jp-auto-stretch,.jp-barcode object,.jp-barcode embed {
	width: 100%;
	height: 100%;
}

.jp-paper-background {
	position: absolute;
	width: 100%;
	height: 100%;
}

.jp-comp-0 {
	opacity: 1;
}

.jp-comp-1 {
	left: 486px;
	top: 94px;
	width: 95px;
	height: 18px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 101;
	background-color: transparent;
}

.jp-comp-2 {
	left: 556px;
	top: 214px;
	width: 89px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 102;
	background-color: transparent;
}

.jp-comp-3 {
	left: 718px;
	top: 156px;
	width: 57px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 103;
	background-color: transparent;
}

.jp-comp-4 {
	left: 622px;
	top: 156px;
	width: 57px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 104;
	background-color: transparent;
}

.jp-comp-5 {
	left: 526px;
	top: 156px;
	width: 62px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 105;
	background-color: transparent;
}

.jp-comp-6 {
	left: 710px;
	top: 214px;
	width: 89px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 106;
	background-color: transparent;
}

.jp-comp-7 {
	left: 25px;
	top: 293px;
	width: 220px;
	height: 22px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 107;
	background-color: transparent;
}

.jp-comp-8 {
	left: 79px;
	top: 82px;
	width: 95px;
	height: 18px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 108;
	background-color: transparent;
}

.jp-comp-9 {
	left: 132px;
	top: 218px;
	width: 89px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 108;
	background-color: transparent;
}

.jp-comp-10 {
	left: 280px;
	top: 147px;
	width: 57px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 108;
	background-color: transparent;
}

.jp-comp-11 {
	left: 184px;
	top: 147px;
	width: 57px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 108;
	background-color: transparent;
}

.jp-comp-12 {
	left: 88px;
	top: 147px;
	width: 62px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 108;
	background-color: transparent;
}

.jp-comp-13 {
	left: 285px;
	top: 218px;
	width: 89px;
	height: 28px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	z-index: 108;
	background-color: transparent;
}

.jp-comp-14 {
	left: 492px;
	top: 122px;
	width: 312px;
	height: 29px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	position: absolute;
	z-index: 109;
	background-color: transparent;
}

.jp-comp-15 {
	left: 88px;
	top: 112px;
	width: 312px;
	height: 29px;
	text-align: left;
	color: #000000;
	font-family: Times New Roman;
	font-size: 14px;
	font-style: normal;
	font-weight: 400;
	text-decoration: none;
	position: absolute;
	z-index: 110;
	background-color: transparent;
}
</style>
</head>
<body>
	<%
		for (int i = 0; i < orders.length; i++) {
	%>
	<div style="width: 233mm; height: 128mm;" id="page<%=(i + 1)%>"
		class="jp-page jp-landscape">
		<img class="jp-paper-background screen-only"
			src="images/yt.gif">
		<div class="jp-text jp-comp-1"><%=data.get(orders[i])[nameIndex.get("收件人")]%></div>
		<div class="jp-text jp-comp-14"><%=data.get(orders[i])[nameIndex.get("单位")]%></div>
		<div class="jp-text jp-comp-5"><%=data.get(orders[i])[nameIndex.get("省")]%></div>
		<div class="jp-text jp-comp-4"><%=data.get(orders[i])[nameIndex.get("市")]%></div>
		<div class="jp-text jp-comp-3"><%=data.get(orders[i])[nameIndex.get("区")]%></div>
		<div class="jp-text jp-comp-2"><%=data.get(orders[i])[nameIndex.get("手机")]%></div>
		<div class="jp-text jp-comp-6"><%=data.get(orders[i])[nameIndex.get("电话")]%></div>
		<div class="jp-text jp-comp-7"><%=data.get(orders[i])[nameIndex.get("物品")]%></div>
		<div class="jp-text jp-comp-8"><%=sender[nameIndex.get("发件人")]%></div>
		<div class="jp-text jp-comp-15"><%=sender[nameIndex.get("单位")]%></div>
		<div class="jp-text jp-comp-12"><%=sender[nameIndex.get("省")]%></div>
		<div class="jp-text jp-comp-11"><%=sender[nameIndex.get("市")]%></div>
		<div class="jp-text jp-comp-10"><%=sender[nameIndex.get("区")]%></div>
		<div class="jp-text jp-comp-9"><%=sender[nameIndex.get("手机")]%></div>
		<div class="jp-text jp-comp-13"><%=sender[nameIndex.get("电话")]%></div>
	</div>
	<%
		}
	%>
</body>
</html>