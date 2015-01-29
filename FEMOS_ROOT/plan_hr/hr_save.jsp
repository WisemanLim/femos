<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.hr.Dal_hr_plan" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String hr_nm  = CharacterSet.UTF8toKorean(request.getParameter("hr_nm"));
	String phone = request.getParameter("phone");
	String support_type = CharacterSet.UTF8toKorean(request.getParameter("support_type"));
	String addr = CharacterSet.UTF8toKorean(request.getParameter("addr"));
	String job = CharacterSet.UTF8toKorean(request.getParameter("job"));
	
	Dal_hr_plan hr = new Dal_hr_plan();
	
	hr.insertHr(festival_cd,hr_nm, phone, support_type, addr, job);
	
	response.sendRedirect("hr_main.jsp");
%>