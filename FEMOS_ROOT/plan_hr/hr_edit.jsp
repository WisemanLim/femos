<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.hr.Dal_hr_plan" %>
<%@page import="com.util.CharacterSet"%>
<%
	String pk_no = request.getParameter("pk_no");
	String festival_cd = request.getParameter("festival_cd");
	String hr_nm  = CharacterSet.UTF8toKorean(request.getParameter("edit_hr_nm"));
	String phone = request.getParameter("edit_phone");
	String support_type = CharacterSet.UTF8toKorean(request.getParameter("edit_support_type"));
	String addr = CharacterSet.UTF8toKorean(request.getParameter("edit_addr"));
	String job = CharacterSet.UTF8toKorean(request.getParameter("edit_job"));

	
	Dal_hr_plan hr = new Dal_hr_plan();
	
	hr.editHr(pk_no,festival_cd,hr_nm, phone, support_type, addr, job);
	
	response.sendRedirect("hr_main.jsp");
%>