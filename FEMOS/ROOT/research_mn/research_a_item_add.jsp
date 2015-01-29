<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research_a_item" %>
<%@page import="com.util.CharacterSet"%>
<%
	
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num")):0;
	String sv_id = request.getParameter("sv_id")!=null?request.getParameter("sv_id"):"";
	int sv_group = request.getParameter("sv_group")!=null?Integer.parseInt(request.getParameter("sv_group")):0;
	int a_num = request.getParameter("a_num")!=null?Integer.parseInt(request.getParameter("a_num")):0;
	String a_text = request.getParameter("a_text")!=null?CharacterSet.UTF8toKorean(request.getParameter("a_text")):"";
	String other_yn = request.getParameter("other_yn")!=null?request.getParameter("other_yn"):"";
	int other_width = request.getParameter("other_width")!=null?Integer.parseInt(request.getParameter("other_width")):0;
	String other_first = request.getParameter("other_first")!=null?CharacterSet.UTF8toKorean(request.getParameter("other_first")):"";
	String other_last = request.getParameter("other_last")!=null?CharacterSet.UTF8toKorean(request.getParameter("other_last")):"";
	
	Dal_research_a_item a_item = new Dal_research_a_item();
	a_item.insertResearch_a_item(rec_num,a_num,a_text, other_yn, other_width, other_first, other_last);
	
	response.sendRedirect("research_view.jsp?sv_id="+sv_id);
%>