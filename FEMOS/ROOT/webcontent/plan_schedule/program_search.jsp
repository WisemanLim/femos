<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.program.Dal_program_plan" %>
<%@ page import="com.plan.program.Biz_program_plan" %>
<%@page import="com.util.CharacterSet"%>
<%@page import="java.util.*" %>
<%
	String festival_cd = request.getParameter("festival_cd")!=null?request.getParameter("festival_cd").toString():"";
	String sch_program_div = request.getParameter("sch_program_div")!=null?request.getParameter("sch_program_div").toString():"";
	String sch_importance = request.getParameter("sch_importance")!=null?request.getParameter("sch_importance").toString():"";
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div").toString():"PROGRAM_NM";
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val").toString()):"";
	
	String where  = "";
	
	where = where + " WHERE FESTIVAL_CD = '"+festival_cd+"'";
	
	if(sch_program_div.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + " PROGRAM_DIV = '"+sch_program_div+"'";
	}
	
	if(sch_importance.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + " IMPORTANCE = '"+sch_importance+"'";
	}
	
	if(sch_val.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + sch_div + " like'%"+sch_val+"%' ";
	}
	
	Dal_program_plan list = new Dal_program_plan(); 
	list.getProgram_list_all(where);
	Vector v_list = list.getV_list();
	
	String responseText = "";
	if(v_list.size() > 0)
	{
		for(int i = 0; i < v_list.size(); i++)
		{
			Biz_program_plan obj = (Biz_program_plan)v_list.elementAt(i);
			responseText = responseText + obj.getProgram_cd()+"#"+"["+obj.getProgram_div_nm()+"]"+obj.getProgram_nm()+"^";
		}
	}
	
	if(responseText.length() > 0)
	{
		responseText = responseText.substring(0,responseText.length()-1);
	}
	
	out.print(responseText);
%>


