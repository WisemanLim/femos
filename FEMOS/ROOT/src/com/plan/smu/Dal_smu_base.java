package com.plan.smu;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.smu.Biz_smu_base;

public class Dal_smu_base 
{
	private Biz_smu_base biz = null;
	private Vector v_list = null;
	
	public Dal_smu_base()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void get_smu_base_list(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"'";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				biz = new Biz_smu_base();
				
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setGrid_width(rs.getInt("GRID_WIDTH"));
				biz.setGrid_height(rs.getInt("GRID_HEIGHT"));
				biz.setGrid_cell_size(rs.getInt("GRID_CELL_SIZE"));
				biz.setMap_x(rs.getInt("MAP_X"));
				biz.setMap_y(rs.getInt("MAP_Y"));
				biz.setSave_img_path(rs.getString("SAVE_IMG_PATH"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	public void get_smu_base_top_list(String festival_cd,int limit)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"' AND ROWNUM <= "+limit+" ORDER BY FESTIVAL_HALL_CD DESC";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				biz = new Biz_smu_base();
				
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setGrid_width(rs.getInt("GRID_WIDTH"));
				biz.setGrid_height(rs.getInt("GRID_HEIGHT"));
				biz.setGrid_cell_size(rs.getInt("GRID_CELL_SIZE"));
				biz.setMap_x(rs.getInt("MAP_X"));
				biz.setMap_y(rs.getInt("MAP_Y"));
				biz.setSave_img_path(rs.getString("SAVE_IMG_PATH"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	
	public Biz_smu_base get_smu_base_detail(String festival_cd,String festival_hall_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				biz = new Biz_smu_base();
				
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setGrid_width(rs.getInt("GRID_WIDTH"));
				biz.setGrid_height(rs.getInt("GRID_HEIGHT"));
				biz.setGrid_cell_size(rs.getInt("GRID_CELL_SIZE"));
				biz.setMap_x(rs.getInt("MAP_X"));
				biz.setMap_y(rs.getInt("MAP_Y"));
				biz.setSave_img_path(rs.getString("SAVE_IMG_PATH"));
				
				
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
		
		return biz;
	}
	
	
	public String insertSmu_base(String festival_cd,String festival_hall_nm,int grid_width,int grid_height,int grid_cell_size,int map_x,int map_y)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		String festival_hall_cd = "";
		
		try
		{
		
			sql = "SELECT 'FSH' || TO_CHAR(TO_NUMBER(SUBSTR(NVL(MAX(FESTIVAL_HALL_CD),'FSH10001'),4,5))+1) FESTIVAL_HALL_CD FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"' ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				festival_hall_cd = rs.getString("FESTIVAL_HALL_CD");
			}
			
			sql = "INSERT INTO TB_SMU_BASE(FESTIVAL_HALL_CD,FESTIVAL_CD,FESTIVAL_HALL_NM,GRID_WIDTH,GRID_HEIGHT,GRID_CELL_SIZE,MAP_X,MAP_Y) ";
			sql = sql + " VALUES('"+festival_hall_cd+"','"+festival_cd+"','"+festival_hall_nm+"',"+grid_width+","+grid_height+","+grid_cell_size+","+map_x+","+map_y+")";
			
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return festival_hall_cd;
	}
	
	public boolean updateSmu_base(String festival_cd,String festival_hall_cd,String festival_hall_nm)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "	UPDATE TB_SMU_BASE SET ";
			sql = sql + " FESTIVAL_HALL_NM = '"+festival_hall_nm+"' ";
			sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean deleteSmu_base(String festival_cd,String festival_hall_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = " DELETE FROM TB_ROUTE_TRACE WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'";
			System.out.println(sql);
			stmt1 = dbo.DbOpen().createStatement();   
			stmt1.executeUpdate(sql);
			
			sql = " DELETE FROM TB_SMU_ROUTE WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'";
			System.out.println(sql);
			stmt2 = dbo.DbOpen().createStatement();   
			stmt2.executeUpdate(sql);
			
			sql = " DELETE FROM TB_SMU_INSTALLATION WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'";
			System.out.println(sql);
			stmt3 = dbo.DbOpen().createStatement();   
			stmt3.executeUpdate(sql);
			
			sql = " DELETE FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'";
			System.out.println(sql);
			stmt4 = dbo.DbOpen().createStatement();   
			stmt4.executeUpdate(sql);
			
			
			if(stmt1!=null){stmt1.close();}
			if(stmt2!=null){stmt2.close();}
			if(stmt3!=null){stmt3.close();}
			if(stmt4!=null){stmt4.close();}
			
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
}
