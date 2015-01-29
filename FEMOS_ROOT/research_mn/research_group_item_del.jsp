<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research_group" %>
<%@page import="com.util.CharacterSet"%>
<%

	String sv_id = request.getParameter("sv_id")!=null?request.getParameter("sv_id"):"";
	int sv_group = 	request.getParameter("sv_group")!=null?Integer.parseInt(request.getParameter("sv_group")):0;
	Dal_research_group group = new Dal_research_group();
	group.deleteResearch_group(sv_group);
	
	response.sendRedirect("research_view.jsp?sv_id="+sv_id);
%>