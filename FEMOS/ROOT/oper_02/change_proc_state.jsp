<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.ivt.Dal_ivt_info" %>
<%@page import="com.util.CharacterSet"%>
<%
	int rec_num = request.getParameter("rec_num") != null? Integer.parseInt(request.getParameter("rec_num").toString()):0;
	String proc_state_cd = request.getParameter("proc_state_cd");
	
	Dal_ivt_info ivt = new Dal_ivt_info();
	ivt.change_proc_state_cd(rec_num,proc_state_cd);
	
	response.sendRedirect("oper_02_main.jsp");
	
%>