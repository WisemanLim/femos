package com.plan.smu;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.smu.Biz_smu_route;

public class Dal_smu_route
{
	private Biz_smu_route biz = null;
	private Vector v_list = null;
	
	public Dal_smu_route()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getSmu_route_list(String festival_cd , String festival_hall_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT ROUTE_CD,FESTIVAL_CD,FESTIVAL_HALL_CD,ROUTE_WIDTH,ROUTE_COLOR,ROUTE_TYPE,START_POINT_X,START_POINT_Y,";
			sql = sql + " MID_POINT_X,MID_POINT_Y,END_POINT_X,END_POINT_Y,START_OBJ_CD,MID_OBJ_CD,END_OBJ_CD,";
			sql = sql + " ROUND(TO_NUMBER(SQRT(POWER((START_POINT_X-END_POINT_X),2)+POWER((START_POINT_Y-END_POINT_Y),2)))) DISTANCE ";
			sql = sql + " FROM TB_SMU_ROUTE WHERE FESTIVAL_CD ='"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"' ";
			
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_route(); 
				
				biz.setRoute_cd(rs.getString("ROUTE_CD"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setRoute_width(rs.getInt("ROUTE_WIDTH"));
				biz.setRoute_color(rs.getString("ROUTE_COLOR"));
				biz.setRoute_type(rs.getString("ROUTE_TYPE"));
				biz.setStart_point_x(rs.getInt("START_POINT_X"));
				biz.setStart_point_y(rs.getInt("START_POINT_Y"));
				biz.setMid_point_x(rs.getInt("MID_POINT_X"));
				biz.setMid_point_y(rs.getInt("MID_POINT_Y"));
				biz.setEnd_point_x(rs.getInt("END_POINT_X"));
				biz.setEnd_point_y(rs.getInt("END_POINT_Y"));
				biz.setStart_obj_cd(rs.getString("START_OBJ_CD"));
				biz.setMid_obj_cd(rs.getString("MID_OBJ_CD"));
				biz.setEnd_obj_cd(rs.getString("END_OBJ_CD"));
				biz.setDistance(rs.getInt("DISTANCE"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	public void getSmu_route_path(String start_obj_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			
			String sql = "SELECT A.START_OBJ_CD SORT_SEQ ,B.START_OBJ_CD,B.MID_OBJ_CD,B.END_OBJ_CD,B.START_POINT_X,B.START_POINT_Y, ";
			sql = sql + " B.MID_POINT_X,B.MID_POINT_Y,B.END_POINT_X,B.END_POINT_Y,";
			sql = sql + " ROUND(TO_NUMBER(SQRT(POWER((B.START_POINT_X-B.END_POINT_X),2)+POWER((B.START_POINT_Y-B.END_POINT_Y),2)))) DISTANCE";
			sql = sql + " FROM TB_SMU_ROUTE A LEFT OUTER JOIN ";
			sql = sql + " (SELECT * FROM TB_SMU_ROUTE WHERE START_OBJ_CD = '"+start_obj_cd+"') B";
			sql = sql + " ON A.END_OBJ_CD = B.START_OBJ_CD AND A.START_OBJ_CD = B.END_OBJ_CD ORDER BY SORT_SEQ ASC ";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_route(); 
				
				biz.setStart_obj_cd(rs.getString("START_OBJ_CD"));
				biz.setMid_obj_cd(rs.getString("MID_OBJ_CD"));
				biz.setEnd_obj_cd(rs.getString("END_OBJ_CD"));
				biz.setStart_point_x(rs.getInt("START_POINT_X"));
				biz.setStart_point_y(rs.getInt("START_POINT_Y"));
				biz.setMid_point_x(rs.getInt("MID_POINT_X"));
				biz.setMid_point_y(rs.getInt("MID_POINT_Y"));
				biz.setEnd_point_x(rs.getInt("END_POINT_X"));
				biz.setEnd_point_y(rs.getInt("END_POINT_Y"));
				biz.setDistance(rs.getInt("DISTANCE"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	
	public int getStartBtweenEndDistance(String start_obj_cd, String end_obj_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		int distance = 0;
		
		try
		{
			
			String sql = "	SELECT ROUTE_CD,START_OBJ_CD,END_OBJ_CD, ";
			sql = sql + "	ROUND(TO_NUMBER(SQRT(POWER((START_POINT_X-END_POINT_X),2)+POWER((START_POINT_Y-END_POINT_Y),2)))) DISTANCE ";
			sql = sql + "	FROM TB_SMU_ROUTE WHERE (START_OBJ_CD = '"+start_obj_cd+"' AND END_OBJ_CD = '"+end_obj_cd+"') ";
			sql = sql + " 	OR (END_OBJ_CD = '"+start_obj_cd+"' AND START_OBJ_CD = '"+end_obj_cd+"') ";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_route(); 
				distance = rs.getInt("DISTANCE");
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return distance;
	}
	
	public void getRoutePosition(String festival_hall_cd, String path)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		
		try
		{
			
			String sql = "SELECT * FROM  ";
			sql = sql + " (SELECT rownum RN,ROUTE_CD,START_POINT_X,START_POINT_Y,END_POINT_X,END_POINT_Y FROM TB_SMU_ROUTE ";
			sql = sql + " WHERE FESTIVAL_HALL_CD = '"+festival_hall_cd+"') ";
			sql = sql + " where RN in("+path+")";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_route(); 
				
				biz.setRoute_cd(rs.getString("ROUTE_CD"));
				biz.setStart_point_x(rs.getInt("START_POINT_X"));
				biz.setStart_point_y(rs.getInt("START_POINT_Y"));
				biz.setEnd_point_x(rs.getInt("END_POINT_X"));
				biz.setEnd_point_y(rs.getInt("END_POINT_Y"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
}
