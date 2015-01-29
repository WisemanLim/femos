<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.alarm.Dal_alarm_msg" %>
<%@page import="com.util.CharacterSet"%>
<%
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num").toString()):0;
	
	Dal_alarm_msg alarm = new Dal_alarm_msg();
	alarm.deleteAlarm(rec_num);
	
	response.sendRedirect("alarm_main.jsp");
%>