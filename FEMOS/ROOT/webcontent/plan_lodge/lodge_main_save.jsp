<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.lodge.Dal_lodge_main" %>
<%@page import="com.util.CharacterSet"%>
<%
	Dal_lodge_main lodge = new Dal_lodge_main(); 

	String festival_cd = request.getParameter("festival_cd");
	String lodge_nm = CharacterSet.UTF8toKorean(request.getParameter("lodge_nm"));
	String phone = request.getParameter("phone");
	String addr = CharacterSet.UTF8toKorean(request.getParameter("addr"));
	
	String lodge_no = lodge.insertLodge_main(festival_cd, lodge_nm, phone, addr);
	
	
	response.sendRedirect("lodge_main.jsp?festival_cd="+festival_cd+"&lodge_no="+lodge_no);
%>