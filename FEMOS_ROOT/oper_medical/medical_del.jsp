<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.medical.Dal_medical" %>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	
	String savePath = config.getServletContext().getRealPath("/oper_medical/fdata"); // 저장할 디렉토리 (절대경로)
	
	
	File poolPath = new File(savePath);
	
	if (!poolPath.exists())
	{
		poolPath.mkdirs(); //파일 디렉토리 생성
	}
	
	int sizeLimit = 50 * 1024 * 1024 ; // 50메가까지 제한 넘어서면 예외발생
	
	MultipartRequest multi = new MultipartRequest(request, savePath,sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	
	int rec_num = multi.getParameter("rec_num")!=null?Integer.parseInt(multi.getParameter("rec_num")):0;
	
	Dal_medical medical = new Dal_medical();
	
	medical.deleteMedical(rec_num);
	
	response.sendRedirect("medical_list.jsp");
	
%>