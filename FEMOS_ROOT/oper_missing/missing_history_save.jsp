<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.missing.Dal_missing_result" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	int missing_key = request.getParameter("missing_key")!=null?Integer.parseInt(request.getParameter("missing_key").toString()):0;
	String result = CharacterSet.UTF8toKorean(request.getParameter("result"));
	
	Dal_missing_result missing = new Dal_missing_result();
	
	int ret_serial = missing.insertMissing_result(missing_key,result);
	
	out.print(ret_serial);
%>