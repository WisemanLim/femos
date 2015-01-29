<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research_a_item" %>
<%@page import="com.util.CharacterSet"%>
<%
	int list_num = request.getParameter("list_num")!=null?Integer.parseInt(request.getParameter("list_num")):0;
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num")):0;
	String sv_id = request.getParameter("sv_id")!=null?request.getParameter("sv_id"):"";
	
	Dal_research_a_item a_item = new Dal_research_a_item();
	a_item.deleteResearch_a_item(list_num,rec_num);
	
	response.sendRedirect("research_view.jsp?sv_id="+sv_id);
%>