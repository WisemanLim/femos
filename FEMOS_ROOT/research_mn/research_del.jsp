<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research" %>
<%@page import="com.util.CharacterSet"%>
<%
	String sv_id = request.getParameter("sv_id")!=null?request.getParameter("sv_id"):"";
	
	Dal_research research = new Dal_research();
	research.deleteResearch_base(sv_id);
	
	response.sendRedirect("research_list.jsp");
%>