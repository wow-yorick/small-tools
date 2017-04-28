<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*,org.apache.commons.io.*,java.io.File,java.util.regex.*" %>

<%
	 // 用于保存设计模板或打开报表模板
	 // 1. 无论读或写,都需要知道目标文件
        ServletContext context = pageContext.getServletContext();
    

	// 从模板文件读入模板数据,为演示方便，模板数据放在templates目录下
	 String settingsID = request.getParameter("settingsID").toString();
   
	
	 File template = new File(context.getRealPath( "templates/"+settingsID));	
	 String styles = "";
	 String pageBody = "";
		
	 if(request.getParameter("how").equals("upload"))
	 {
		 // 写模板
		 String _styles = request.getParameter("styles");
		 String _pageBody = request.getParameter("pageBody");
		 String templatetext = _styles+"===="+_pageBody;
		 FileUtils.writeStringToFile(template,templatetext,"UTF-8");
		 
	 }else
	 {
		 // 下载报表模板
		String[] tempateparts = FileUtils.readFileToString(template,"UTF-8").split("====");
		styles = tempateparts[0];
		pageBody = tempateparts[1].replaceAll("\\$\\{pageNo}","1");
	 }
%>
<html>
<head>
<title>jatoolsPrinter打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
<%=styles%>
</style>
</head>
<body>
<%=pageBody%>
</body>
</html>