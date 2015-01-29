<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.lodge.Dal_lodge_sub" %>
<%@page import="com.util.CharacterSet"%>
<%
	String festival_cd = request.getParameter("festival_cd");
	String lodge_no = request.getParameter("lodge_no");
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num").toString()):0;
	String room_nm = CharacterSet.UTF8toKorean(request.getParameter("edit_room_nm"));
	String team_nm = CharacterSet.UTF8toKorean(request.getParameter("edit_team_nm"));
	int male_cnt = request.getParameter("edit_male_cnt")!=null?Integer.parseInt(request.getParameter("edit_male_cnt").toString()):0;
	int fmale_cnt = request.getParameter("edit_fmale_cnt")!=null?Integer.parseInt(request.getParameter("edit_fmale_cnt").toString()):0;
	String st_ymd = request.getParameter("edit_st_ymd")!=null?request.getParameter("edit_st_ymd").toString().replaceAll("-",""):"";
	String ed_ymd = request.getParameter("edit_ed_ymd")!=null?request.getParameter("edit_ed_ymd").toString().replaceAll("-",""):"";
	
	Dal_lodge_sub lodge = new Dal_lodge_sub(); 
	
	lodge.updateLodge_sub(rec_num,room_nm,team_nm,male_cnt,fmale_cnt,st_ymd,ed_ymd);
	
	response.sendRedirect("lodge_main.jsp?festival_cd="+festival_cd+"&lodge_no="+lodge_no);
%>