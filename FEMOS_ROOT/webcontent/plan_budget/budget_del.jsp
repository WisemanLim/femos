<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.budget.Dal_budget" %>
<%@page import="com.util.CharacterSet"%>
<%
	int rec_num = request.getParameter("rec_num")!= null?Integer.parseInt(request.getParameter("rec_num").toString()):0;
	String festival_cd = request.getParameter("festival_cd");
	
	Dal_budget budget = new Dal_budget();
	budget.deleteBudget(festival_cd, rec_num);
	
	response.sendRedirect("budget_main.jsp");
%>
