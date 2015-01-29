<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.smu.Dal_smu_base" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	String festival_cd = request.getParameter("festival_cd");
	String festival_hall_nm = request.getParameter("input_festival_hall_nm")!=null?CharacterSet.UTF8toKorean(request.getParameter("input_festival_hall_nm")):"";
	int grid_width = 600;
	int grid_height = 600;
	int grid_cell_size = 20;
	int map_x = 0;
	int map_y = 0;
	
	String festival_hall_cd = new Dal_smu_base().insertSmu_base(festival_cd,festival_hall_nm,grid_width,grid_height,grid_cell_size,map_x,map_y);
	
	response.sendRedirect("layout_main.jsp?festival_cd="+festival_cd+"&festival_hall_cd="+festival_hall_cd);
%>