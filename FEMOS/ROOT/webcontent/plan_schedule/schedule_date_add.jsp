<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.schedule.Dal_schedule_plan" %>
<%@ page import="com.plan.schedule.Biz_schedule_plan" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	int pk_id = Integer.parseInt(request.getParameter("pk_id").toString());
	int day = Integer.parseInt(request.getParameter("day").toString());
	int minute = Integer.parseInt(request.getParameter("minute").toString());
	String view = request.getParameter("view")!= null ? request.getParameter("view").toString():"month";
	String festival_hall_cd = request.getParameter("festival_hall_cd");
	
	Dal_schedule_plan schedule = new Dal_schedule_plan();
	
	Biz_schedule_plan obj = schedule.getSchedule_detail(pk_id);
	
	String ed_yyyymmddhhmi = obj.getEd_year() + obj.getEd_month() + obj.getEd_day() + obj.getEd_hour() + obj.getEd_minute();

	Biz_schedule_plan ed_add_date = schedule.getAddDate(ed_yyyymmddhhmi,day,minute);
	
	schedule.updateSchedule_date(pk_id,"ED",ed_add_date.getYyyy(),ed_add_date.getMm(),ed_add_date.getDd(),ed_add_date.getHh(),ed_add_date.getMi());
	
	
	response.sendRedirect("schedule_main.jsp?festival_cd="+festival_cd+"&festival_hall_cd="+festival_hall_cd+"&view="+view);
%>