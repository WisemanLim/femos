package com.operation.research;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.research.Biz_research_group;

public class Dal_research_group
{
	private Biz_research_group biz = null;
	private Vector v_list = null;
	
	public Dal_research_group()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public boolean insertResearch_group(String sv_id, String sv_group_nm, String sv_group_summary)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "	INSERT INTO SV_GROUP_ITEM(SV_ID,SV_GROUP,SV_GROUP_NM,SV_GROUP_SUMMARY) ";
			sql = sql + " SELECT '"+sv_id+"',NVL(MAX(SV_GROUP),0)+1,'"+sv_group_nm+"','"+sv_group_summary+"' FROM SV_GROUP_ITEM WHERE SV_ID = '"+sv_id+"' ";
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean updateResearch_group(int sv_group,String sv_id, String sv_group_nm, String sv_group_summary)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "	UPDATE SV_GROUP_ITEM SET SV_GROUP_NM = '"+sv_group_nm+"',SV_GROUP_SUMMARY = '"+sv_group_summary+"' ";
			sql = sql + " WHERE SV_ID = '"+sv_id+"' AND SV_GROUP = "+sv_group;
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean deleteResearch_group(int sv_group)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		Statement stmt2 = null;
		boolean ret = true;
		ResultSet rs = null;  
		
		String sql = "";
		String sql1 = "";
		String sql2 = "";
		String sql3 = "";
		String sql4 = "";
		
		try
		{	
			
			sql1 = "DELETE FROM SV_GROUP_ITEM WHERE SV_GROUP = "+sv_group;
			sql = "SELECT * FROM SV_Q_ITEM WHERE SV_GROUP = "+sv_group;
			sql2 = "DELETE FROM SV_Q_ITEM WHERE SV_GROUP = "+sv_group;
			
			stmt = dbo.DbOpen().createStatement();   
			stmt2 = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql1);
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_group();
				
				sql3 = "DELETE FROM SV_A_ITEM WHERE REC_NUM = "+rs.getInt("REC_NUM");
				stmt2.executeUpdate(sql3);
				sql4 = "DELETE FROM SV_A_RESULT WHERE REC_NUM = "+rs.getInt("REC_NUM");
				stmt2.executeUpdate(sql4);
				
			}
			if(rs!=null){rs.close();}
			
			stmt2.executeUpdate(sql2);
			
			
			
			if(stmt!=null){stmt.close();}
			if(stmt2!=null){stmt2.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public void getResearch_group_list(String sv_id)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT * FROM SV_GROUP_ITEM WHERE SV_ID = '"+sv_id+"' ";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_group();
				
				biz.setSv_id(rs.getString("SV_ID"));
				biz.setSv_group(rs.getInt("SV_GROUP"));
				biz.setSv_group_nm(rs.getString("SV_GROUP_NM"));
				biz.setSv_group_summary(rs.getString("SV_GROUP_SUMMARY"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
}
