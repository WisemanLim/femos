<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.check.Dal_check_div" %>
<%@page import="com.util.CharacterSet"%>
<%
	String check_cd = "";
	String festival_cd = request.getParameter("festival_cd");
	String parent_check_cd = request.getParameter("parent_check_cd");
	String check_nm  = CharacterSet.UTF8toKorean(request.getParameter("check_nm"));
	
	Dal_check_div check_div = new Dal_check_div();
	
	check_cd = check_div.insertCheck_div(festival_cd,parent_check_cd,check_nm);
	
	
	response.sendRedirect("check_main.jsp?festival_cd="+festival_cd+"&check_cd="+parent_check_cd);
%>