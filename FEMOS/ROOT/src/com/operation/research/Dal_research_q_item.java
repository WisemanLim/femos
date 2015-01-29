package com.operation.research;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.research.Biz_research_q_item;

public class Dal_research_q_item 
{
	private Biz_research_q_item biz = null;
	private Vector v_list = null;
	
	public Dal_research_q_item()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getResearch_q_item_list(String sv_id)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT * FROM SV_Q_ITEM WHERE SV_ID = '"+sv_id+"'";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_q_item();
				
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setSv_id(rs.getString("SV_ID"));
				biz.setSv_group(rs.getInt("SV_GROUP"));
				biz.setQ_num(rs.getInt("Q_NUM"));
				biz.setQ_text(rs.getString("Q_TEXT"));
				biz.setSelect_method(rs.getString("SELECT_METHOD"));
				biz.setSort_method(rs.getString("SORT_METHOD"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public void getResearch_q_item_list(String sv_id,int sv_group)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT * FROM SV_Q_ITEM WHERE SV_ID = '"+sv_id+"' AND SV_GROUP = "+sv_group+" ORDER BY Q_NUM ASC";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_q_item();
				
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setSv_id(rs.getString("SV_ID"));
				biz.setSv_group(rs.getInt("SV_GROUP"));
				biz.setQ_num(rs.getInt("Q_NUM"));
				biz.setQ_text(rs.getString("Q_TEXT"));
				biz.setSelect_method(rs.getString("SELECT_METHOD"));
				biz.setSort_method(rs.getString("SORT_METHOD"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	
	public Biz_research_q_item getResearch_q_item_Detail(int rec_num)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT * FROM SV_Q_ITEM WHERE REC_NUM = '"+rec_num+"'";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_q_item();
				
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setSv_id(rs.getString("SV_ID"));
				biz.setSv_group(rs.getInt("SV_GROUP"));
				biz.setQ_num(rs.getInt("Q_NUM"));
				biz.setQ_text(rs.getString("Q_TEXT"));
				biz.setSelect_method(rs.getString("SELECT_METHOD"));
				biz.setSort_method(rs.getString("SORT_METHOD"));
				
			
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return biz;
	}
	
	public boolean insertResearch_q_item(String sv_id,int sv_group,int q_num, String q_text, String select_method, String sort_method)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "	INSERT INTO SV_Q_ITEM(REC_NUM,SV_ID,SV_GROUP,Q_NUM,Q_TEXT,SELECT_METHOD,SORT_METHOD) ";
			sql = sql + "  SELECT NVL(MAX(REC_NUM),0)+1,'"+sv_id+"','"+sv_group+"',"+q_num+",'"+q_text+"','"+select_method+"','"+sort_method+"' FROM SV_Q_ITEM ";
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean updateResearch_q_item(int rec_num,int q_num, String q_text, String select_method, String sort_method)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "	UPDATE SV_Q_ITEM SET Q_NUM = "+q_num+",Q_TEXT = '"+q_text+"', SELECT_METHOD = '"+select_method+"', SORT_METHOD = '"+sort_method+"' WHERE REC_NUM = "+rec_num;
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	
	public boolean deleteResearch_q_item(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql1 = "";
		String sql2 = "";
		
		try
		{	
			sql1 = "	DELETE FROM SV_Q_ITEM WHERE REC_NUM = "+rec_num;
			sql2 = "	DELETE FROM SV_A_ITEM WHERE REC_NUM = "+rec_num;
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql1);
			stmt.executeUpdate(sql2);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
}
