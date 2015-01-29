<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.lodge.Dal_lodge_sub" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String lodge_no = request.getParameter("lodge_no");
	String room_nm = CharacterSet.UTF8toKorean(request.getParameter("room_nm"));
	String team_nm = CharacterSet.UTF8toKorean(request.getParameter("team_nm"));
	int male_cnt = request.getParameter("male_cnt")!=null?Integer.parseInt(request.getParameter("male_cnt").toString()):0;
	int fmale_cnt = request.getParameter("fmale_cnt")!=null?Integer.parseInt(request.getParameter("fmale_cnt").toString()):0;
	String st_ymd = request.getParameter("st_ymd")!=null?request.getParameter("st_ymd").toString().replaceAll("-",""):"";
	String ed_ymd = request.getParameter("ed_ymd")!=null?request.getParameter("ed_ymd").toString().replaceAll("-",""):"";
	
	Dal_lodge_sub lodge = new Dal_lodge_sub(); 
	
	lodge.insertLodge_sub(lodge_no,festival_cd,room_nm,team_nm,male_cnt,fmale_cnt,st_ymd,ed_ymd);
	
	response.sendRedirect("lodge_main.jsp?festival_cd="+festival_cd+"&lodge_no="+lodge_no);
%>