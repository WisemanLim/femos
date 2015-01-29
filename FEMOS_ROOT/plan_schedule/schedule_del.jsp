<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.schedule.Dal_schedule_plan" %>
<%@page import="com.util.CharacterSet"%>
<%
	String view = request.getParameter("view")!= null ? request.getParameter("view").toString():"month";
	int pk_id = Integer.parseInt(request.getParameter("pk_id"));
	String festival_cd = request.getParameter("festival_cd");
	String festival_hall_cd = request.getParameter("festival_hall_cd");
	
	Dal_schedule_plan schedule = new Dal_schedule_plan();
	
	schedule.deleteSchedule_hr_by_pk_id(pk_id);
	schedule.deleteSchedule(pk_id);
	
	response.sendRedirect("schedule_main.jsp?festival_cd="+festival_cd+"&festival_hall_cd="+festival_hall_cd+"&view="+view);
%>