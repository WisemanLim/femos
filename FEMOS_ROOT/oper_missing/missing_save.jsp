<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.missing.Dal_missing" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	String name = CharacterSet.UTF8toKorean(request.getParameter("inst_name"));
	String protector = CharacterSet.UTF8toKorean(request.getParameter("inst_protector"));
	String protector_tel = CharacterSet.UTF8toKorean(request.getParameter("inst_protector_tel"));
	
	Dal_missing missing = new Dal_missing();
	
	missing.insertMissing(name,protector,protector_tel);
	
	response.sendRedirect("missing_list.jsp");
	
%>