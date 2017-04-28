<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page
	import="com.jatools.mireport.*,java.util.*,org.apache.commons.io.*,java.io.File,java.util.regex.*"%>

<%
	String result = PageBuilder.build(request);
%>
<%=result%>