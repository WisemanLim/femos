<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.code.Dal_code" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String budget_div = CharacterSet.UTF8toKorean(request.getParameter("budget_div"));
	String budget_div_nm = CharacterSet.UTF8toKorean(request.getParameter("edit_div_nm"));
	
	Dal_code code = new Dal_code();
	code.updateCode(budget_div, budget_div_nm,"","");
	
	response.sendRedirect("budget_main.jsp");
%>
