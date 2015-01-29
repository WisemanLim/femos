<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.schedule.Biz_schedule_plan" %>
<%@ page import="com.plan.schedule.Dal_schedule_plan" %>
<%@ page import="com.plan.schedule.Biz_schedule_hr" %>
<%@ page import="com.plan.schedule.Dal_schedule_hr" %>
<%@page import="com.util.CharacterSet"%>
<%@page import="java.util.*" %>
<%
	int pk_id = request.getParameter("pk_id")!=null?Integer.parseInt(request.getParameter("pk_id").toString()):0;
	String responseText = "";
	
	Dal_schedule_plan schedule = new Dal_schedule_plan();
	Biz_schedule_plan obj = schedule.getSchedule_detail(pk_id); 
	
	responseText = responseText + obj.getProgram_cd()+"^["+obj.getProgram_div_nm()+"]"+obj.getProgram_nm()+"^"+obj.getSt_year()+"-"+obj.getSt_month()+"-"+obj.getSt_day();
	responseText = responseText + "^" + obj.getSt_hour() + "^" +obj.getSt_minute() + "^"+obj.getEd_year()+"-"+obj.getEd_month()+"-"+obj.getEd_day()+"^"+obj.getEd_hour();
	responseText = responseText + "^" + obj.getEd_minute() + "^" + obj.getSchedule_content().replaceAll(System.getProperty("line.separator"),"@") + "^" + obj.getBg_color() + "^" + obj.getText_color()+"^"+obj.getSchedule_title();
	
	String responseText2 = "";
	
	Dal_schedule_hr hr = new Dal_schedule_hr();
	hr.getScheduleHrList(pk_id);
	Vector v_list = hr.getV_list();
	
	if(v_list.size() > 0) 
	{
		for(int i = 0; i < v_list.size(); i++)
		{
			Biz_schedule_hr hr_obj = (Biz_schedule_hr)v_list.elementAt(i);
			responseText2 = responseText2 + hr_obj.getPk_no()+"^"+hr_obj.getHr_nm()+"["+hr_obj.getSupport_type()+"]"+"#";
		}
	}
	
	out.print(responseText+"&"+responseText2);
	
%>


