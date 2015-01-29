<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.smu.Biz_smu_base" %>
<%@ page import="com.plan.smu.Dal_smu_base" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	String festival_cd = request.getParameter("festival_cd");
	String festival_hall_cd = request.getParameter("festival_hall_cd")!=null?request.getParameter("festival_hall_cd"):"";
	Dal_smu_base smu = new Dal_smu_base();
	Biz_smu_base obj = smu.get_smu_base_detail(festival_cd,festival_hall_cd);
	out.print(""+festival_hall_cd+"^"+obj.getFestival_hall_nm());
%>