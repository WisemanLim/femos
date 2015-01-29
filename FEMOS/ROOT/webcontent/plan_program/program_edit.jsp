<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.program.Dal_program_plan" %>
<%@ page import="com.plan.budget.Dal_budget" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String program_cd = request.getParameter("program_cd");
	String program_nm  = CharacterSet.UTF8toKorean(request.getParameter("edit_program_nm"));
	String program_div = request.getParameter("edit_program_div");
	String base_summary = CharacterSet.UTF8toKorean(request.getParameter("edit_base_summary"));
	String policy = CharacterSet.UTF8toKorean(request.getParameter("edit_policy"));
	String exec_target = CharacterSet.UTF8toKorean(request.getParameter("edit_exec_target"));
	String importance = request.getParameter("edit_importance");
	
	String[] budget_div = request.getParameterValues("edit_budget_div");
	String[] budget_money = request.getParameterValues("edit_budget_money");
	
	
	Dal_program_plan program = new Dal_program_plan();
	
	program.editProgram(festival_cd ,program_cd,program_nm ,program_div ,base_summary ,policy ,exec_target ,importance);
	
	program.deleteAllProgram_budget(festival_cd ,program_cd);
	program.deleteAll_budget(festival_cd ,program_cd);
	
	int rec_num = 0;
	for(int i = 0; i < budget_money.length; i++)
	{
		if(budget_money[i] != null)
		{
			rec_num = program.insertProgram_budget(festival_cd,program_cd,budget_div[i],budget_money[i]);
			
			program.insertBudget(festival_cd, budget_div[i], program_nm,Integer.parseInt(budget_money[i]),"0","",program_cd);
		}
	}
	
	response.sendRedirect("program_main.jsp");
	
%>