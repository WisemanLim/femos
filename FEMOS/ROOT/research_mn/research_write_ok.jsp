<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	String festival_cd = request.getParameter("festival_cd");
	
	String sv_title = request.getParameter("sv_title")!=null?CharacterSet.UTF8toKorean(request.getParameter("sv_title")):"";
	String sv_yyyy = request.getParameter("sv_yyyy")!=null?request.getParameter("sv_yyyy"):"";
	String sv_mm = request.getParameter("sv_mm")!=null?request.getParameter("sv_mm"):"";
	String sv_yyyymm = sv_yyyy + sv_mm;
	String other = request.getParameter("other")!=null?CharacterSet.UTF8toKorean(request.getParameter("other")):"";
	String sv_end_yn = "N";
	
	String sv_id = "";
	Dal_research research = new Dal_research();
	
	sv_id = research.insertResearch_base(festival_cd, sv_title, sv_yyyymm, other, sv_end_yn);
	
	response.sendRedirect("research_view.jsp?sv_id="+sv_id);
%>