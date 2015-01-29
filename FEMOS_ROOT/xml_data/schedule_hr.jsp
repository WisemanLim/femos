<%@ page import="com.plan.schedule.*" %><%@ page import="java.util.Vector" %><%@ page language="java" contentType="text/xml; charset=utf-8" pageEncoding="utf-8"%><%
	
	String festival_cd = request.getParameter("festival_cd");
	int pk_id = request.getParameter("pk_id")!=null?Integer.parseInt(request.getParameter("pk_id")):0;
	
	out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>"); 
	
	out.println("<festival id=\""+festival_cd+"\">");
	Dal_schedule_hr hr = new Dal_schedule_hr();
	hr.getScheduleHrList(pk_id);
	
	Vector list = hr.getV_list();
	
	for(int i = 0; i < list.size(); i++)
	{
		Biz_schedule_hr hr_obj = (Biz_schedule_hr)list.elementAt(i);
		out.println("<data>");
		out.println("<rec_num>"+hr_obj.getRec_num()+"</rec_num>");
		out.println("<pk_id>"+hr_obj.getPk_id()+"</pk_id>");
		out.println("<pk_no>"+hr_obj.getPk_no()+"</pk_no>");
		out.println("<festival_hall_cd>"+hr_obj.getFestival_hall_cd()+"</festival_hall_cd>");
		out.println("<hr_nm>"+hr_obj.getHr_nm()+"</hr_nm>");
		out.println("<phone>"+hr_obj.getPhone()+"</phone>");
		out.println("<support_type>"+hr_obj.getSupport_type()+"</support_type>");
		out.println("</data>");
	}
	out.println("</festival>");
%>