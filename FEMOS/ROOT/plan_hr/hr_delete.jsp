<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.hr.Dal_hr_plan" %>
<%@page import="com.util.CharacterSet"%>
<%
	String pk_no = request.getParameter("pk_no");
	String festival_cd = request.getParameter("festival_cd");
	
	Dal_hr_plan hr = new Dal_hr_plan();
	
	hr.deleteHr(pk_no,festival_cd);
	
	response.sendRedirect("hr_main.jsp");
%>