<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.check.Dal_check_items" %>
<%@page import="com.util.CharacterSet"%>
<%
	int item_num = request.getParameter("item_num") != null ? Integer.parseInt(request.getParameter("item_num").toString()):0;
	String check_cd = request.getParameter("check_cd");
	String festival_cd = request.getParameter("festival_cd");
	String item_nm  = CharacterSet.UTF8toKorean(request.getParameter("edit_item_nm"));
	String summary  = CharacterSet.UTF8toKorean(request.getParameter("edit_summary"));
	String importance  = request.getParameter("edit_importance");
	
	Dal_check_items check_items = new Dal_check_items();
	
	check_items.updateCheck_items(item_num,item_nm,summary,importance);
	
	response.sendRedirect("check_main.jsp?festival_cd="+festival_cd+"&check_cd="+check_cd);
%>