<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.program.Dal_program_plan" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String program_cd = request.getParameter("program_cd");
	
	Dal_program_plan obj = new Dal_program_plan();
	obj.deleteProgram(program_cd);
	
	response.sendRedirect("program_main.jsp");
	
%>