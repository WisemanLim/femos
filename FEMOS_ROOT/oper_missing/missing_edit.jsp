<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.missing.Dal_missing" %>
<%@page import="com.util.CharacterSet"%>
<%
	int serial = request.getParameter("edit_serial")!=null?Integer.parseInt(request.getParameter("edit_serial").toString()):0;
	String name = CharacterSet.UTF8toKorean(request.getParameter("edit_name"));
	String protector = CharacterSet.UTF8toKorean(request.getParameter("edit_protector"));
	String protector_tel = CharacterSet.UTF8toKorean(request.getParameter("edit_protector_tel"));
	
	Dal_missing missing = new Dal_missing();
	
	missing.updateMissing(serial,name,protector,protector_tel);
	
	response.sendRedirect("missing_list.jsp");
	
%>