<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page
	import="com.jatools.mireport.*,java.util.*,org.apache.commons.io.*"%>
<%
	String datasourceName = request.getParameter("ds");
	String result = Config.getInstance().getDatasourceManager().load(datasourceName).toString();
%>
<%=result%>