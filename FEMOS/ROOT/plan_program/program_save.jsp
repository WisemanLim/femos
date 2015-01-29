<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.program.Dal_program_plan" %>
<%@ page import="com.plan.budget.Dal_budget" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String program_nm  = CharacterSet.UTF8toKorean(request.getParameter("program_nm"));
	String program_div = request.getParameter("program_div");
	String base_summary = CharacterSet.UTF8toKorean(request.getParameter("base_summary"));
	String policy = CharacterSet.UTF8toKorean(request.getParameter("policy"));
	String exec_target = CharacterSet.UTF8toKorean(request.getParameter("exec_target"));
	String importance = request.getParameter("importance");
	int need_budget = request.getParameter("need_budget")!=null?Integer.parseInt(request.getParameter("need_budget").toString()):0;
	String[] budget_div = request.getParameterValues("budget_div");
	String[] budget_money = request.getParameterValues("budget_money");
	
	Dal_program_plan program = new Dal_program_plan();
	
	String program_cd = program.insertProgram(festival_cd ,program_nm ,program_div ,base_summary ,policy ,exec_target ,importance);
	
	
	int rec_num = 0;
	for(int i = 0; i < budget_money.length; i++)
	{
		if(budget_money[i] != null)
		{
			rec_num = program.insertProgram_budget(festival_cd,program_cd,budget_div[i],budget_money[i]);
			
			program.insertBudget(festival_cd, budget_div[i], program_nm,Integer.parseInt(budget_money[i]),"0","",program_cd);
		}
	}
	
	
	
	response.sendRedirect("program_main.jsp?festival_cd="+festival_cd);
	
%>