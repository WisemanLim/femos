<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.lodge.Dal_lodge_main" %>
<%@page import="com.util.CharacterSet"%>
<%
	Dal_lodge_main lodge = new Dal_lodge_main(); 

	String lodge_no = request.getParameter("lodge_no");
	String festival_cd = request.getParameter("festival_cd");
	
	lodge.deleteLodge_main(lodge_no,festival_cd);
	
	response.sendRedirect("lodge_main.jsp?festival_cd="+festival_cd);
%>