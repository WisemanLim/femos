<%@ page import="com.plan.schedule.*" %><%@ page import="java.util.Vector" %><%@ page language="java" contentType="text/xml; charset=utf-8" pageEncoding="utf-8"%><%
	
	String festival_cd = request.getParameter("festival_cd");
	String festival_hall_cd = request.getParameter("festival_hall_cd");
	String yyyymmdd = request.getParameter("date");
	
	out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>"); 
	
	out.println("<festival id=\""+festival_cd+"\">");
	Dal_schedule_plan schedule = new Dal_schedule_plan();
	schedule.getSchedule_list_date(festival_cd,festival_hall_cd,yyyymmdd);
	Vector list = schedule.getV_list();
	for(int i = 0; i < list.size(); i++)
	{
		Biz_schedule_plan obj = (Biz_schedule_plan)list.elementAt(i);
		out.println("<data>");
		out.println("<pk_id>"+obj.getPk_id()+"</pk_id>");
		out.println("<festival_hall_cd>"+obj.getFestival_hall_cd()+"</festival_hall_cd>"); 
		out.println("<festival_hall_nm>"+obj.getFestival_hall_nm()+"</festival_hall_nm>"); 
		out.println("<program_cd>"+obj.getProgram_cd()+"</program_cd>"); 
		out.println("<program_nm>"+obj.getProgram_nm()+"</program_nm>"); 
		out.println("<schedule_title>"+obj.getSchedule_title()+"</schedule_title>"); 
		out.println("<all_day_yn>"+obj.getAll_day_yn()+"</all_day_yn>"); 
		out.println("<st_year>"+obj.getSt_year()+"</st_year>"); 
		out.println("<st_month>"+obj.getSt_month()+"</st_month>"); 
		out.println("<st_day>"+obj.getSt_day()+"</st_day>"); 
		out.println("<st_hour>"+obj.getSt_hour()+"</st_hour>");
		out.println("<st_minute>"+obj.getSt_minute()+"</st_minute>");
		out.println("<ed_year>"+obj.getEd_year()+"</ed_year>");
		out.println("<ed_month>"+obj.getEd_month()+"</ed_month>");
		out.println("<ed_day>"+obj.getEd_day()+"</ed_day>");
		out.println("<ed_hour>"+obj.getEd_hour()+"</ed_hour>");
		out.println("<ed_minute>"+obj.getEd_minute()+"</ed_minute>");
		out.println("<schedule_content><![CDATA["+obj.getSchedule_content()+"]]></schedule_content>");
		out.println("<bg_color>"+obj.getBg_color()+"</bg_color>");
		out.println("<text_color>"+obj.getText_color()+"</text_color>");
		out.println("</data>");
	}
	out.println("</festival>");
%>