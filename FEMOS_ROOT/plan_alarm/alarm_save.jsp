<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.alarm.Dal_alarm_msg" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String title  = CharacterSet.UTF8toKorean(request.getParameter("alarm_title"));
	String content = CharacterSet.UTF8toKorean(request.getParameter("alarm_content"));
	String writer_id = session.getAttribute("ADMIN_ID").toString();
	String writer_nm = session.getAttribute("ADMIN_NM").toString();
	
	Dal_alarm_msg alarm = new Dal_alarm_msg();
	alarm.insertAlarm(festival_cd,title,content,writer_id,writer_nm);
	
	response.sendRedirect("alarm_main.jsp");
%>