package com.operation.research;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.research.Biz_research_a_item;

public class Dal_research_a_item 
{
	private Biz_research_a_item biz = null;
	private Vector v_list = null;
	
	public Dal_research_a_item()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getResearch_a_item_list(int rec_num)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT * FROM SV_A_ITEM WHERE REC_NUM = "+rec_num+" ORDER BY A_NUM ASC ";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_a_item();
				
				biz.setList_num(rs.getInt("LIST_NUM"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setA_num(rs.getInt("A_NUM"));
				biz.setA_text(rs.getString("A_TEXT"));
				biz.setOther_yn(rs.getString("OTHER_YN"));
				biz.setOther_width(rs.getInt("OTHER_WIDTH"));
				biz.setOther_first(rs.getString("OTHER_FIRST"));
				biz.setOther_last(rs.getString("OTHER_LAST"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public boolean insertResearch_a_item(int rec_num,int a_num,String a_text, String other_yn, int other_width, String other_first,String other_last)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "	INSERT INTO SV_A_ITEM(LIST_NUM,REC_NUM,A_NUM,A_TEXT,OTHER_YN,OTHER_WIDTH,OTHER_FIRST,OTHER_LAST) ";
			sql = sql + "  SELECT NVL(MAX(LIST_NUM),0)+1,"+rec_num+","+a_num+",'"+a_text+"','"+other_yn+"',"+other_width+",'"+other_first+"','"+other_last+"' FROM SV_A_ITEM WHERE REC_NUM = "+rec_num;
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean updateResearch_a_item(int list_num,int rec_num,int a_num,String a_text, String other_yn, int other_width, String other_first,String other_last)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "UPDATE SV_A_ITEM SET ";
			sql = sql + " A_NUM = "+a_num;
			sql = sql + ",A_TEXT = '"+a_text+"' ";
			sql = sql + ",OTHER_YN = '"+other_yn+"' ";
			sql = sql + ",OTHER_WIDTH = "+other_width;
			sql = sql + ",OTHER_FIRST = '"+other_first+"' ";
			sql = sql + ",OTHER_LAST = '"+other_last+"' ";
			sql = sql + " WHERE REC_NUM = "+rec_num+" AND LIST_NUM = "+list_num;
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean deleteResearch_a_item(int list_num,int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "DELETE FROM SV_A_ITEM WHERE LIST_NUM = "+list_num+" AND REC_NUM = "+rec_num;
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
}
