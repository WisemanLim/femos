<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.plan.schedule.Dal_schedule_plan" %>
<%@page import="com.util.CharacterSet"%>
<%
	String view = request.getParameter("view")!= null ? request.getParameter("view").toString():"month";
	int pk_id = Integer.parseInt(request.getParameter("pk_id"));
	String festival_cd = request.getParameter("festival_cd");
	String festival_hall_cd = request.getParameter("festival_hall_cd");
	String program_cd = request.getParameter("edit_program_search_result");
	
	String all_day_yn = "N";
	
	String st_ymd = request.getParameter("edit_st_ymd")!=null?request.getParameter("edit_st_ymd").toString():"";
	String arr_st_ymd [] = st_ymd.split("-");
	String st_year = arr_st_ymd[0];
	String st_month = arr_st_ymd[1];
	String st_day = arr_st_ymd[2];
	String st_hour = request.getParameter("edit_st_hour");
	String st_minute = request.getParameter("edit_st_minute");
	
	String ed_ymd = request.getParameter("edit_ed_ymd")!=null?request.getParameter("edit_ed_ymd").toString():"";
	String arr_ed_ymd [] = ed_ymd.split("-");
	String ed_year = arr_ed_ymd[0];
	String ed_month = arr_ed_ymd[1];
	String ed_day = arr_ed_ymd[2];
	String ed_hour = request.getParameter("edit_ed_hour");
	String ed_minute = request.getParameter("edit_ed_minute");
	
	String schedule_title = CharacterSet.UTF8toKorean(request.getParameter("edit_schedule_title"));
	String schedule_content = CharacterSet.UTF8toKorean(request.getParameter("edit_schedule_content"));
	String bg_color = request.getParameter("edit_bg_color");
	String text_color = request.getParameter("edit_text_color"); 
	
	Dal_schedule_plan schedule = new Dal_schedule_plan();
	
	schedule.updateSchedule(pk_id,program_cd,all_day_yn,st_year,st_month,st_day,st_hour,st_minute,ed_year,ed_month,
			ed_day,ed_hour,ed_minute,schedule_title,schedule_content,bg_color,text_color);
	
	schedule.deleteSchedule_hr_by_pk_id(pk_id);
	
	String[] program_hr = request.getParameterValues("edit_program_hr");
	
	if(program_hr != null)
	{
		for(int i = 0; i < program_hr.length; i++)
		{
			if(program_hr[i] != null)
			{
				schedule.insertSchedule_hr(pk_id, program_hr[i], festival_cd,  festival_hall_cd);
			}
		}
	}
	
	response.sendRedirect("schedule_main.jsp?festival_cd="+festival_cd+"&festival_hall_cd="+festival_hall_cd+"&view="+view);
%>