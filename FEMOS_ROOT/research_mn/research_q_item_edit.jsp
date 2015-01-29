<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research_q_item" %>
<%@page import="com.util.CharacterSet"%>
<%
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num")):0;
	String sv_id = request.getParameter("sv_id");
	int sv_group = request.getParameter("sv_group")!=null?Integer.parseInt(request.getParameter("sv_group")):0;
	int q_num = request.getParameter("q_num")!=null?Integer.parseInt(request.getParameter("q_num")):0;
	String q_text = request.getParameter("q_text")!=null?CharacterSet.UTF8toKorean(request.getParameter("q_text")):"";
	String select_method = request.getParameter("select_method");
	String sort_method = request.getParameter("sort_method");
	
	
	Dal_research_q_item q_item = new Dal_research_q_item();
	q_item.updateResearch_q_item( rec_num, q_num,  q_text,  select_method,  sort_method);
	
	response.sendRedirect("research_view.jsp?sv_id="+sv_id);
%>