<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.check.Dal_check_items" %>
<%@page import="com.util.CharacterSet"%>
<%
	int item_num = request.getParameter("item_num") != null ? Integer.parseInt(request.getParameter("item_num").toString()):0;
	String check_cd = request.getParameter("check_cd");
	String festival_cd = request.getParameter("festival_cd");
	
	Dal_check_items check_items = new Dal_check_items();
	
	check_items.deleteCheck_items(item_num);
	
	response.sendRedirect("check_main.jsp?festival_cd="+festival_cd+"&check_cd="+check_cd);
%>