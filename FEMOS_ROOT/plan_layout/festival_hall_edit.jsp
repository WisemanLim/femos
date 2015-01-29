<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.smu.Dal_smu_base" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	String festival_cd = request.getParameter("festival_cd");
	String festival_hall_cd = request.getParameter("edit_festival_hall_cd");
	String festival_hall_nm = request.getParameter("edit_festival_hall_nm")!=null?CharacterSet.UTF8toKorean(request.getParameter("edit_festival_hall_nm")):"";
	
	Dal_smu_base smu = new Dal_smu_base();
	
	smu.updateSmu_base(festival_cd,festival_hall_cd,festival_hall_nm);
	response.sendRedirect("layout_main.jsp?festival_cd="+festival_cd+"&festival_hall_cd="+festival_hall_cd);
%>