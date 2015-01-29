<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research_q_item" %>
<%@page import="com.util.CharacterSet"%>
<%
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num")):0;
	String sv_id = request.getParameter("sv_id")!=null?request.getParameter("sv_id"):"";
	
	Dal_research_q_item q_item = new Dal_research_q_item();
	q_item.deleteResearch_q_item(rec_num);
	
	response.sendRedirect("research_view.jsp?sv_id="+sv_id);
%>