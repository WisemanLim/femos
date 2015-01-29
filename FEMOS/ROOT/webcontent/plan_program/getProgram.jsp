<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.program.Dal_program_plan" %>
<%@ page import="com.plan.program.Biz_program_plan" %>
<%@ page import="com.plan.program.Dal_program_budget" %>
<%@ page import="com.plan.program.Biz_program_budget" %>
<%@page import="com.util.CharacterSet"%>
<%@page import="java.util.*" %>
<%
	String festival_cd = request.getParameter("festival_cd");
	String program_cd = request.getParameter("program_cd")!=null?request.getParameter("program_cd").toString():"";
	
	Biz_program_plan obj = new Dal_program_plan().getProgram_detail(festival_cd,program_cd); 
	
	String base_summary = obj.getBase_summary().replaceAll(System.getProperty("line.separator"),"@");
	String policy = obj.getPolicy().replaceAll(System.getProperty("line.separator"),"@");
	
	String responseText1 = obj.getFestival_cd()+"^"+obj.getProgram_cd()+"^"+obj.getProgram_nm()+"^"+obj.getProgram_div()+"^"+base_summary+"^"+policy;
	responseText1 = responseText1 + "^"+obj.getExec_target()+"^"+obj.getImportance()+"^"+obj.getNeed_budget();
	
	String responseText2 = "";
	
	/*
	Dal_hr_plan list = new Dal_hr_plan(); 
	list.getProgram_hr_list(festival_cd,program_cd);
	Vector v_list = list.getV_list();
	
	if(v_list.size() > 0)
	{
		for(int i = 0; i < v_list.size(); i++)
		{
			Biz_hr_plan hr = (Biz_hr_plan)v_list.elementAt(i);
			responseText2 = responseText2 + hr.getPk_no()+"^"+hr.getHr_nm()+"["+hr.getSupport_type()+"]"+"#";
		}
		
		responseText2 = responseText2.substring(0,responseText2.length()-1);
	}*/
	Dal_program_budget budget = new Dal_program_budget();
	budget.getProgramByBudgetList(festival_cd,program_cd);
	Vector v_list = budget.getV_list();
	
	if(v_list.size() > 0)
	{
		for(int i = 0; i < v_list.size(); i++)
		{
			Biz_program_budget b_obj = (Biz_program_budget)v_list.elementAt(i);
			responseText2 = responseText2 + b_obj.getBudget_div()+"^"+b_obj.getBudget_money()+"#";
		}
		
		responseText2 = responseText2.substring(0,responseText2.length()-1);
	}
	
	out.print(responseText1+"&"+responseText2);
%>
