<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.hr.Dal_hr_plan" %>
<%@ page import="com.plan.hr.Biz_hr_plan" %>
<%
	Dal_hr_plan hr = new Dal_hr_plan();
	
	String festival_cd = request.getParameter("festival_cd");
	String jumin_fst = request.getParameter("jumin_fst");
	String jumin_lst = request.getParameter("jumin_lst");
	
	int rec_cnt = 0;
	rec_cnt = hr.getJumin_count(festival_cd,jumin_fst,jumin_lst);
	out.print(rec_cnt);
%>