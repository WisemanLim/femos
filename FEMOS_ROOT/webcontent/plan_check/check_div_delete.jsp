<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.check.Dal_check_div" %>
<%@page import="com.util.CharacterSet"%>
<%
	String check_cd = request.getParameter("check_cd");
	String festival_cd = request.getParameter("festival_cd");
	String parent_check_cd = request.getParameter("edit_parent_check_cd");
	
	Dal_check_div check_div = new Dal_check_div();
	
	check_div.deleteCheck_div(check_cd);
	
	response.sendRedirect("check_main.jsp?festival_cd="+festival_cd);
%>