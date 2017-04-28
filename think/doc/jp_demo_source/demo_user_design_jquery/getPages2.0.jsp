<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,org.apache.commons.io.*,java.io.File,java.util.regex.*" %>

<%
     // 根据settingsID,取得模板数据
     // 模板数据分为两部分,
     ServletContext context = pageContext.getServletContext();
	
	
	// 从模板文件读入模板数据,为演示方便，模板数据放在templates目录下
	
	File template = new File(context.getRealPath( "templates/"+request.getParameter("settingsID")));
	// 以====分割
	String[] tempateparts = FileUtils.readFileToString(template,"UTF-8").split("====");
	
	String styles = tempateparts[0];
	String pageBody = tempateparts[1];


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

	// 收件人信息
	String[] sender = new String[] {  "张国栋", "杭州杰创软件有限公司", "浙江省",
			"杭州市", "西湖区", "杭州市西斗门路3号天堂软件园A幢19层B1座", "010-85615555-851",
			"13910507777" };
	String[] names = new String[] {  "发件人", "发件人单位", "发件人省", "发件人市", "发件人区",
			"发件人地址", "发件人电话", "发件人手机"};
	// 将收件人信息，事先写到rowdata中
	Map<String,String> rowdata = new HashMap<String,String>();

	for (int i = 0; i < names.length; i++) {
		rowdata.put(names[i], sender[i]);
	}
%>
<html>
<head>
<title>可以增加套打模板的打印页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
<%=styles%>
</style>
</head>
<body>
<%
	  	names = new String[] { "订单号", "收件人", "单位", "省", "市", "区",
		"地址", "电话", "手机", "物品" };
		// 生成页
		String[] orders = request.getParameter("orders").split(",");
		for (int i = 0; i < orders.length; i++) {
			// 将收件人信息，准备到rowdata中
			for (int n = 0; n < names.length; n++) {
				rowdata.put(names[n], (String)rows[i][n]);
			}
			// 设当前页面编号
			rowdata.put("pageNo",(i+1)+"");
			// 拼出 page div的html,凡是${}，都用实际数据代替
            Pattern p = Pattern.compile("\\$\\{([^}]*)\\}");
            Matcher m = p.matcher(pageBody);
            StringBuffer html = new StringBuffer();

            while (m.find()) {
                m.appendReplacement(html, rowdata.get( m.group(1)));
            }
            m.appendTail(html);
	%>
	<%=html.toString()%>
	<%
		}
	%>
</body>
</html>