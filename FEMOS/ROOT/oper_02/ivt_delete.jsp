<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.ivt.Dal_ivt_info" %>
<%@ page import="com.operation.ivt.Biz_ivt_info" %>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.io.*"%>
<%
	 
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num").toString()):0;
	
	Dal_ivt_info ivt = new Dal_ivt_info();
	Biz_ivt_info obj = ivt.getIvt_detail(rec_num);
	//out.println("시작!");
	//out.println(obj.getAttach_file());
	//out.println("<br/>");
	//out.println(request.getRealPath("/webcontent/oper_02/pic_data")+"/"+obj.getAttach_file().replaceAll("./",""));
	File file = null;
	if(obj.getAttach_file().length() > 0)
	{
		try{
			file = new File(request.getRealPath("/oper_02/"+obj.getAttach_file().replace("./","")));
			file.delete();
			
			
			out.println(request.getRealPath("/oper_02/"+obj.getAttach_file().replace("./","")));
		}catch(Exception e){out.print(e.getMessage());}
	}
	
	ivt.delete_ivt(rec_num);
	
	response.sendRedirect("oper_02_main.jsp");
	
%>