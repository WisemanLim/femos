<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.budget.Dal_budget" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String budget_div = request.getParameter("budget_div");
	String detail_history = CharacterSet.UTF8toKorean(request.getParameter("detail_history"));
	int budget_money = request.getParameter("budget_money")!= null?Integer.parseInt(request.getParameter("budget_money").toString()):0;
	String comp_ratio = request.getParameter("comp_ratio");
	String other = request.getParameter("other")!=null?CharacterSet.UTF8toKorean(request.getParameter("other")):"";
	
	
	Dal_budget budget = new Dal_budget();
	budget.insertBudget(festival_cd, budget_div, detail_history,budget_money,comp_ratio,other);
	
	response.sendRedirect("budget_main.jsp");
%>
