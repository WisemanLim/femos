<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.lodge.Dal_lodge_sub" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String lodge_no = request.getParameter("lodge_no");
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num").toString()):0;
	
	Dal_lodge_sub lodge = new Dal_lodge_sub(); 
	
	lodge.deleteLodge_sub(rec_num);
	
	response.sendRedirect("lodge_main.jsp?festival_cd="+festival_cd+"&lodge_no="+lodge_no);
%>