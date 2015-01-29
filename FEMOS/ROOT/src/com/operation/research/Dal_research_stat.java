package com.operation.research;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import com.config.db.DBConnection;
import com.operation.research.Biz_research_stat;


public class Dal_research_stat {
	
	private Biz_research_stat biz = null;
	private Vector v_list = null;
	
	public Dal_research_stat()
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
			String sql = " SELECT A.*,B.SV_GROUP_NM FROM ";
			sql = sql + " (SELECT * FROM SV_Q_ITEM WHERE SV_ID = '"+sv_id+"') A, ";
			sql = sql + " (SELECT * FROM SV_GROUP_ITEM WHERE SV_ID = '"+sv_id+"') B ";
			sql = sql + " WHERE A.SV_ID = B.SV_ID	AND A.SV_GROUP = B.SV_GROUP ";
			sql = sql + " ORDER BY B.SV_GROUP ASC,Q_NUM ASC ";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_stat();
				biz.setSv_id(rs.getString("SV_ID"));
				biz.setSv_group(rs.getInt("SV_GROUP"));
				biz.setSv_group_nm(rs.getString("SV_GROUP_NM"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setQ_text(rs.getString("Q_TEXT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	
	
	
	public void getResearch_q_item_stat_select_method_0(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{
			String sql = "";
			sql = sql + " SELECT A.REC_NUM,A.LIST_NUM,A_TEXT,NVL(CNT,0) CNT FROM ";
			sql = sql + " (SELECT * FROM SV_A_ITEM WHERE REC_NUM = "+rec_num+") A ";
			sql = sql + " LEFT OUTER JOIN ";
			sql = sql + " ( ";
			sql = sql + " 	SELECT REC_NUM,LIST_NUM,COUNT(*) CNT FROM SV_A_RESULT WHERE REC_NUM = "+rec_num+" GROUP BY REC_NUM,LIST_NUM ";
			sql = sql + " ) B ";
			sql = sql + " ON A.REC_NUM = B.REC_NUM AND A.LIST_NUM = B.LIST_NUM ORDER BY A_NUM ASC ";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_stat();
				biz.setA_text(rs.getString("A_TEXT"));
				biz.setCnt(rs.getInt("CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public void getResearch_q_item_stat_select_method_2(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{
			String sql = "";
			sql = "SELECT A.REC_NUM,A.LIST_NUM,A_TEXT,  ";
			sql = sql + "NVL(LIST_TEXT_1,0) LIST_TEXT_1,NVL(LIST_TEXT_2,0) LIST_TEXT_2,NVL(LIST_TEXT_3,0) LIST_TEXT_3 ";
			sql = sql + "FROM   ";
			sql = sql + "(SELECT * FROM SV_A_ITEM WHERE REC_NUM = "+rec_num+") A  ";
			sql = sql + "LEFT OUTER JOIN ";
			sql = sql + "(  ";
			sql = sql + "SELECT REC_NUM,LIST_NUM,SUM(LIST_TEXT_1) LIST_TEXT_1,SUM(LIST_TEXT_2) LIST_TEXT_2,SUM(LIST_TEXT_3) LIST_TEXT_3  ";
			sql = sql + "FROM ";
			sql = sql + "( ";
			sql = sql + "SELECT REC_NUM,LIST_NUM, ";
			sql = sql + "CASE WHEN LIST_TEXT = '0' THEN 1 ELSE 0 END LIST_TEXT_1, ";
			sql = sql + "CASE WHEN LIST_TEXT = '1' THEN 1 ELSE 0 END LIST_TEXT_2, ";
			sql = sql + "CASE WHEN LIST_TEXT = '2' THEN 1 ELSE 0 END LIST_TEXT_3 ";
			sql = sql + "FROM SV_A_RESULT WHERE REC_NUM = "+rec_num;
			sql = sql + ") AA GROUP BY REC_NUM,LIST_NUM ";
			sql = sql + ") B ";
			sql = sql + "ON A.REC_NUM = B.REC_NUM AND A.LIST_NUM = B.LIST_NUM  ";
			
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_stat(); 
				biz.setA_text(rs.getString("A_TEXT"));
				biz.setList_text_1(rs.getInt("LIST_TEXT_1"));
				biz.setList_text_2(rs.getInt("LIST_TEXT_2"));
				biz.setList_text_3(rs.getInt("LIST_TEXT_3"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public void getResearch_q_item_stat_select_method_3(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{
			String sql = "  ";
			sql = sql + "";
			sql = sql + "";
			sql = sql + "";
			sql = sql + "";
			sql = sql + "";
			sql = sql + "";
			sql = sql + "";
			sql = sql + "";
			sql = sql + "";
			
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research_stat();
				
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
}
