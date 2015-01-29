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
	
	String festival_cd = multi.getParameter("festival_cd")!=null?multi.getParameter("festival_cd"):"";
	String s_name = multi.getParameter("s_name")!=null?multi.getParameter("s_name"):"";
	String s_age = multi.getParameter("s_age")!=null?multi.getParameter("s_age"):"";
	String s_sex = multi.getParameter("s_sex")!=null?multi.getParameter("s_sex"):"";
	String s_addr = multi.getParameter("s_addr")!=null?multi.getParameter("s_addr"):"";
	String s_tel = multi.getParameter("s_tel")!=null?multi.getParameter("s_tel"):"";
	
	String p_name = multi.getParameter("p_name")!=null?multi.getParameter("p_name"):"";
	String p_age = multi.getParameter("p_age")!=null?multi.getParameter("p_age"):"";
	String p_sex = multi.getParameter("p_sex")!=null?multi.getParameter("p_sex"):"";
	String p_addr = multi.getParameter("p_addr")!=null?multi.getParameter("p_addr"):"";
	String p_tel = multi.getParameter("p_tel")!=null?multi.getParameter("p_tel"):"";
	
	String symptom = multi.getParameter("symptom")!=null?multi.getParameter("symptom"):"";
	String handle = multi.getParameter("handle")!=null?multi.getParameter("handle"):"";
	
	String m_name = multi.getParameter("m_name")!=null?multi.getParameter("m_name"):"";
	String m_age = multi.getParameter("m_age")!=null?multi.getParameter("m_age"):"";
	String m_sex = multi.getParameter("m_sex")!=null?multi.getParameter("m_sex"):"";
	String m_tel = multi.getParameter("m_tel")!=null?multi.getParameter("m_tel"):"";
	
	int n_s_age = s_age.length() > 0 ? Integer.parseInt(s_age):0;
	int n_p_age = p_age.length() > 0 ? Integer.parseInt(p_age):0;
	int n_m_age = m_age.length() > 0 ? Integer.parseInt(m_age):0;
	
	String attach_file =  multi.getFilesystemName("pic")!=null?multi.getFilesystemName("pic"):"";
	String pic_path = "";
	
	if(attach_file.length() > 0)
	{
		pic_path = "./fdata/"+attach_file;
	}
	
	Dal_medical medical = new Dal_medical();
	
	
	int rec_num = medical.insertMedical(festival_cd, s_name, n_s_age, s_sex, s_addr, s_tel, p_name, n_p_age, p_sex, p_addr,
			 p_tel,  symptom, handle, pic_path, m_name, n_m_age, m_sex, m_tel);
	
	response.sendRedirect("medical_view.jsp?rec_num="+rec_num);
	
%>