<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Vector"%>
<%@page import="com.config.db.DBConnection"%>
<%	
	String uid = request.getParameter("uid") != null? request.getParameter("uid").toString() :"";
	String pw = request.getParameter("pw") != null? request.getParameter("pw").toString() :"";
	
	DBConnection dbo = new DBConnection();
	Statement stmt = null;
	ResultSet rs = null; 
	
	String db_admin_id = "";
	String db_admin_nm = "";
	String festival_cd = request.getParameter("festival_cd");
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
		if(rs!=null){rs.close();}
		if(stmt!=null){stmt.close();}
		dbo.SetConClose();
	}
	catch(Exception e){System.out.println(e.getMessage());}
	
	if(!db_admin_id.equals(""))
	{
		session.setAttribute("ADMIN_ID",db_admin_id);
		session.setAttribute("ADMIN_NM",db_admin_nm);
		session.setAttribute("FESTIVAL_CD",festival_cd);
		
		response.sendRedirect("plan_main/main.jsp");
	}
	else
	{
		out.print("<script>alert('아이디 또는 비밀번호가 다릅니다.');history.back(-1);</script>");
	}
	
%>