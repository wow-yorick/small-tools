<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%

// 套打底图上传的路径
String backgroundImages = "backgroundImages";
File file;
ServletContext context = pageContext.getServletContext();

// 准备好底图目录
File imagesDir = new File(context.getRealPath( backgroundImages));

if (!imagesDir.exists()) {
    imagesDir.mkdirs();
}
String fileName = request.getParameter("name");
String data = request.getParameter("data");
byte[] bytes = Base64.decodeBase64(data.getBytes());

    try {

                // 不直接使用上传的文件名，防止名称冲突
                file = File.createTempFile("jp-", fileName.substring(fileName.lastIndexOf('.')), imagesDir);
                FileUtils.writeByteArrayToFile(file,bytes);
                out.print("backgroundImages/" + file.getName());

    } catch (Exception ex) {
        System.out.println(ex);
    }


%>