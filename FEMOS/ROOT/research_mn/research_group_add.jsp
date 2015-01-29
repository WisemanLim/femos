<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research_group" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	
	String sv_id = request.getParameter("sv_id");
	String sv_group_nm = request.getParameter("sv_group_nm")!=null?CharacterSet.UTF8toKorean(request.getParameter("sv_group_nm")):"";
	String sv_group_summary = request.getParameter("sv_group_summary")!=null?CharacterSet.UTF8toKorean(request.getParameter("sv_group_summary")):"";

	Dal_research_group research = new Dal_research_group();
	
	research.insertResearch_group(sv_id,sv_group_nm,sv_group_summary);
	
	response.sendRedirect("research_view.jsp?sv_id="+sv_id);
%>