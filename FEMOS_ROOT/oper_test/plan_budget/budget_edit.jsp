<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.budget.Dal_budget" %>
<%@page import="com.util.CharacterSet"%>
<%
	int rec_num = request.getParameter("rec_num")!= null?Integer.parseInt(request.getParameter("rec_num").toString()):0;
	String festival_cd = request.getParameter("festival_cd");
	String budget_div = request.getParameter("edit_budget_div");
	String detail_history = CharacterSet.UTF8toKorean(request.getParameter("edit_detail_history"));
	int budget_money = request.getParameter("edit_budget_money")!= null?Integer.parseInt(request.getParameter("edit_budget_money").toString()):0;
	String comp_ratio = request.getParameter("edit_comp_ratio");
	String other = request.getParameter("edit_other")!=null?CharacterSet.UTF8toKorean(request.getParameter("edit_other")):"";
	
	Dal_budget budget = new Dal_budget();
	budget.updateBudget(festival_cd, rec_num, detail_history,budget_money,comp_ratio,other);
	
	response.sendRedirect("budget_main.jsp");
%>