<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.ivt.Dal_ivt_info" %>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	
	String savePath = config.getServletContext().getRealPath("/oper_02/pic_data"); // 저장할 디렉토리 (절대경로)
	
	
	File poolPath = new File(savePath);
	
	if (!poolPath.exists())
	{
		poolPath.mkdirs(); //파일 디렉토리 생성
	}
	
	int sizeLimit = 50 * 1024 * 1024 ; // 50메가까지 제한 넘어서면 예외발생
	
	MultipartRequest multi = new MultipartRequest(request, savePath,sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	
	String festival_cd = multi.getParameter("festival_cd")!=null?multi.getParameter("festival_cd"):"";
	String hp_no = multi.getParameter("hp_no")!=null?multi.getParameter("hp_no"):"";
	String ivt_div = multi.getParameter("ivt_div")!=null?multi.getParameter("ivt_div"):"";
	String ivt_content = multi.getParameter("ivt_content")!=null?multi.getParameter("ivt_content"):"";
	
	String attach_file =  multi.getFilesystemName("attach_file")!=null?multi.getFilesystemName("attach_file"):"";
	
	String proc_state_cd = "A8010001";
	
	if(attach_file.length() > 0)
	{
		attach_file = "./pic_data/"+attach_file;
	}
	Dal_ivt_info ivt = new Dal_ivt_info();
	ivt.insert_ivt(festival_cd,hp_no,ivt_div,ivt_content,attach_file,proc_state_cd);
	
	
	response.sendRedirect("ivt_insert.jsp");
	
%>