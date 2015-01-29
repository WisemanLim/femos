<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research" %>
<%@page import="com.util.CharacterSet"%>
<%
	String sv_id = request.getParameter("sv_id")!=null?request.getParameter("sv_id"):"";
	String email = request.getParameter("email")!=null?request.getParameter("email"):"";
	
	Dal_research research = new Dal_research();
	out.print(research.getResearch_email_count(sv_id,email));
%>