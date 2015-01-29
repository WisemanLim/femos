package com.operation.research;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.research.Biz_research;

public class Dal_research 
{
	private Biz_research biz = null;
	private Vector v_list = null;
	
	public Dal_research()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public int getResearch_list_count(String strWhere)
	{
		int ret = 0;
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT COUNT(*) REC_CNT FROM ";
			sql = sql + " ( SELECT * FROM SV_BASE_INFO ) MAIN " + strWhere;
			
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				ret = rs.getInt("REC_CNT");
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return ret;
	}
	
	
	public Biz_research getDetailResearch_base(String sv_id)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT * FROM SV_BASE_INFO WHERE SV_ID = '"+sv_id+"' ";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_research();
				biz.setSv_id(rs.getString("SV_ID"));
				biz.setSv_title(rs.getString("SV_TITLE"));
				biz.setSv_yyyymm(rs.getString("SV_YYYYMM"));
				biz.setOther(rs.getString("OTHER"));
				biz.setSv_end_yn(rs.getString("SV_END_YN"));
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return biz;
		
	}
	
	public void getResearch_list(int intStartPoint,int intEndPoint,String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT   * ";
		sql = sql + "		FROM (SELECT ROWNUM AS RNUM, A.* ";
		sql = sql + "				FROM (SELECT  * ";
		sql = sql + "						  FROM (" ;
		sql = sql + "									SELECT A.*,(SELECT COUNT(*) GROUP_CNT FROM SV_GROUP_ITEM AA WHERE A.SV_ID = AA.SV_ID) GROUP_CNT, ";
		sql = sql + "									(SELECT COUNT(*) Q_CNT FROM SV_Q_ITEM BB WHERE A.SV_ID = BB.SV_ID) Q_CNT, ";	
		sql = sql + "									(SELECT COUNT(*) USER_CNT FROM SV_USER_INFO CC WHERE A.SV_ID = CC.SV_ID) USER_CNT ";
		sql = sql + "									FROM SV_BASE_INFO A ";
		sql = sql + "								) " + strWhere;				  
		sql = sql + "					 ORDER BY SORT_SEQ ASC ) A ";
		sql = sql + "			   WHERE ROWNUM <= "+Integer.toString(intStartPoint)+") ";
		sql = sql + "	   WHERE RNUM >= "+Integer.toString(intEndPoint) + " ORDER BY RNUM DESC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_research();
				
				biz.setRn(rs.getInt("RNUM"));
				biz.setSv_id(rs.getString("SV_ID"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setSv_title(rs.getString("SV_TITLE"));
				biz.setSv_yyyymm(rs.getString("SV_YYYYMM"));
				biz.setGroup_cnt(rs.getInt("GROUP_CNT"));
				biz.setQ_cnt(rs.getInt("Q_CNT"));
				biz.setUser_cnt(rs.getInt("USER_CNT"));
				biz.setSv_end_yn(rs.getString("SV_END_YN"));
				biz.setSort_seq(rs.getInt("SORT_SEQ"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	public String insertResearch_base(String festival_cd, String sv_title, String sv_yyyymm, String other,String sv_end_yn)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "";
		String sv_id = "";
		
		try
		{
		
			sql = "SELECT NVL(MAX(SV_ID),'1000')+1 SV_ID FROM SV_BASE_INFO ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				sv_id = rs.getString("SV_ID");
			}
			
			sql = "INSERT INTO SV_BASE_INFO(SV_ID,FESTIVAL_CD,SV_TITLE,SV_YYYYMM,OTHER,SV_END_YN,SORT_SEQ) ";
			sql = sql + " SELECT '"+sv_id+"','"+festival_cd+"','"+sv_title+"','"+sv_yyyymm+"','"+other+"','"+sv_end_yn+"',NVL(MAX(SORT_SEQ),0)+1 FROM SV_BASE_INFO ";
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return sv_id;
	}
	
	
	public boolean updateResearch_base(String sv_id,String festival_cd, String sv_title, String sv_yyyymm, String other,String sv_end_yn)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "";
		
		try
		{	
			sql = "	UPDATE SV_BASE_INFO SET FESTIVAL_CD = '"+festival_cd+"',SV_TITLE = '"+sv_title+"',SV_YYYYMM = '"+sv_yyyymm+"',OTHER = '"+other+"'";
			sql = sql + ",SV_END_YN = '"+sv_end_yn+"' ";
			sql = sql + " WHERE SV_ID = '"+sv_id+"' ";
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	
	
	public boolean deleteResearch_base(String sv_id)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		Statement stmt2 = null;
		boolean ret = true;
		
		ResultSet rs = null;  
		
		
		String sql1 = " DELETE FROM SV_Q_ITEM WHERE SV_ID = '"+sv_id+"' ";
		String sql2 = " DELETE FROM SV_USER_INFO WHERE SV_ID = '"+sv_id+"' ";
		String sql3 = " DELETE FROM SV_GROUP_ITEM WHERE SV_ID = '"+sv_id+"' ";
		String sql4 = " DELETE FROM SV_BASE_INFO WHERE SV_ID = '"+sv_id+"' ";
		
		String sql5 = "";
		String sql6 = "";
		
		String sql = "SELECT * FROM SV_Q_ITEM WHERE SV_ID = "+sv_id;
		
		
		try
		{	
			
			
			stmt = dbo.DbOpen().createStatement();   
			stmt2 = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				
				sql5 = "DELETE FROM SV_A_ITEM WHERE REC_NUM = "+rs.getInt("REC_NUM");
				System.out.println("1:"+sql5);
				stmt2.executeUpdate(sql5);
				sql6 = "DELETE FROM SV_A_RESULT WHERE REC_NUM = "+rs.getInt("REC_NUM");
				System.out.println("2:"+sql6);
				stmt2.executeUpdate(sql6);
				
				
			}
			if(rs!=null){rs.close();}
			
			
			System.out.println("3");
			stmt2.executeUpdate(sql1);
			System.out.println("4");
			stmt2.executeUpdate(sql2);
			System.out.println("5");
			stmt2.executeUpdate(sql3);
			System.out.println("6");
			stmt2.executeUpdate(sql4);
			System.out.println("7");
			
			if(stmt!=null){stmt.close();}
			if(stmt2!=null){stmt2.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	
	
	public int getResearch_email_count(String sv_id, String email)
	{
		int ret = 0;
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql =  "SELECT COUNT(*) REC_CNT FROM SV_USER_INFO WHERE SV_ID = '"+sv_id+"' AND USER_MAIL_ADDR = '"+email+"'";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				ret = rs.getInt("REC_CNT");
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return ret;
	}
	
	
	
	public boolean insertResearch_result_base(String sv_id,String email, String user_nm)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		
	
		String sql = "INSERT INTO SV_USER_INFO(SV_ID,USER_MAIL_ADDR,USER_NM,REG_YMD) ";
		sql = sql + " VALUES('"+sv_id+"','"+email+"','"+user_nm+"',to_char(sysdate,'yyyymmdd'))";
	
		try
		{	
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean insertResearch_result_answer(int rec_num,String list_num,String list_text,String email)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		
	
		String sql = "INSERT INTO SV_A_RESULT(PKEY,REC_NUM,LIST_NUM,LIST_TEXT,USER_MAIL_ADDR) ";
		sql = sql + " SELECT NVL(MAX(PKEY),0)+1,"+rec_num+","+list_num+",'"+list_text+"','"+email+"' FROM SV_A_RESULT ";
	
		try
		{	
			
			stmt = dbo.DbOpen().createStatement(); 
			System.out.println(sql);
			stmt.executeUpdate(sql);			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
}
