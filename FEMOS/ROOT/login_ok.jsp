<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Vector"%>
<%@page import="com.config.db.DBConnection"%>
<%	
	String uid = request.getParameter("uid") != null? request.getParameter("uid").toString() :"";
	String pw = request.getParameter("pw") != null? request.getParameter("pw").toString() :"";
	String festival_cd = request.getParameter("festival_cd");
	
	DBConnection dbo = new DBConnection();
	Statement stmt = null;
	ResultSet rs = null; 
	
	String db_admin_id = "";
	String db_admin_nm = "";
	
	String db_festival_cd = "";
	String db_festival_nm = "";
	String db_weather_area_cd = "";
	String db_weather_area_nm = "";
	String db_festival_land_cd = "";
	String db_festival_land_nm = "";
	String db_weather_grid_x = "";
	String db_weather_grid_y = "";
	
	try
	{
		String sql = "SELECT * FROM TB_ADMIN_INFO WHERE ADMIN_ID = '"+uid+"' AND PWD = '"+pw+"' ";
		
		stmt = dbo.DbOpen().createStatement();
		
		rs = stmt.executeQuery(sql);
		
		while(rs.next())
		{
			db_admin_id = rs.getString("ADMIN_ID");
			db_admin_nm = rs.getString("ADMIN_NM");
		}
		
		sql = "SELECT A.*,B.CODE_NM WEATHER_AREA_NM,C.LAND_NM FESTIVAL_LAND_NM ";
		sql = sql + " FROM TB_FESTIVAL_BASE A ";
		sql = sql + " INNER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'Z10' AND MEAN_CODE <> '10000') B ";
		sql = sql + " ON A.WEATHER_AREA_CD = B.MEAN_CODE ";
		sql = sql + " INNER JOIN TB_LAND_CD C ";
		sql = sql + " ON A.FESTIVAL_LAND_CD = C.LAND_CD ";
		sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' ";
		
		stmt = dbo.DbOpen().createStatement();
		
		rs = stmt.executeQuery(sql);
		
		while(rs.next())
		{
			db_festival_cd = rs.getString("FESTIVAL_CD");
			db_festival_nm = rs.getString("FESTIVAL_NM");
			db_weather_area_cd = rs.getString("WEATHER_AREA_CD");
			db_weather_area_nm = rs.getString("WEATHER_AREA_NM");
			db_festival_land_cd = rs.getString("FESTIVAL_LAND_CD");
			db_festival_land_nm = rs.getString("FESTIVAL_LAND_NM");
			db_weather_grid_x = rs.getString("WEATHER_GRID_X");
			db_weather_grid_y = rs.getString("WEATHER_GRID_Y");
		}
		
		if(rs!=null){rs.close();}
		if(stmt!=null){stmt.close();}
		dbo.SetConClose();
	}
	catch(Exception e){System.out.println(e.getMessage());}
	
	if(!db_admin_id.equals(""))
	{
		session.setAttribute("ADMIN_ID",db_admin_id);
		session.setAttribute("ADMIN_NM",db_admin_nm);
		session.setAttribute("FESTIVAL_CD",db_festival_cd);
		session.setAttribute("FESTIVAL_NM",db_festival_nm);
		session.setAttribute("WEATHER_AREA_CD",db_weather_area_cd);
		session.setAttribute("WEATHER_AREA_NM",db_weather_area_nm);
		session.setAttribute("FESTIVAL_LAND_CD",db_festival_land_cd);
		session.setAttribute("FESTIVAL_LAND_NM",db_festival_land_nm);
		session.setAttribute("WEATHER_GRID_X",db_weather_grid_x);
		session.setAttribute("WEATHER_GRID_Y",db_weather_grid_y);
		
		response.sendRedirect("plan_main/main.jsp");
	}
	else
	{
		out.print("<script>alert('아이디 또는 비밀번호가 다릅니다.');history.back(-1);</script>");
	}
	
%>