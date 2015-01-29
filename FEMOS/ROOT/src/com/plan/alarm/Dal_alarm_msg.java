package com.plan.alarm;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import com.config.db.DBConnection;
import com.plan.alarm.Biz_alarm_msg;
import com.plan.hr.Biz_hr_plan;

public class Dal_alarm_msg 
{
	private Biz_alarm_msg biz = null;
	private Vector v_list = null;
	
	public Dal_alarm_msg()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public int getAlarm_count(String strWhere)
	{
		int ret = 0;
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + "SELECT COUNT(*) REC_CNT FROM TB_ALARM_MSG "+strWhere; 
		
		try
		{
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
		catch(Exception e){}
		return ret;
	}
	
	
	public void getAlarm_list(int intStartPoint,int intEndPoint,String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT   * ";
		sql = sql + "		FROM (SELECT ROWNUM AS RNUM, A.* ";
		sql = sql + "				FROM (SELECT  A.*";
		sql = sql + "						  FROM TB_ALARM_MSG A " + strWhere;				  
		sql = sql + "					 ORDER BY REC_NUM ASC ) A ";
		sql = sql + "			   WHERE ROWNUM <= "+Integer.toString(intStartPoint)+") ";
		sql = sql + "	   WHERE RNUM >= "+Integer.toString(intEndPoint) + " ORDER BY RNUM DESC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_alarm_msg();
				biz.setRn(rs.getInt("RNUM"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setTitle(rs.getString("TITLE"));
				biz.setContent(rs.getString("CONTENT"));
				biz.setWriter_id(rs.getString("WRITER_ID"));
				biz.setWriter_nm(rs.getString("WRITER_NM"));
				biz.setWrite_dt(rs.getString("WRITE_DT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	public void getAlarm_top_list(int top,String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "			SELECT ROWNUM AS RNUM, A.* ";
		sql = sql + "	FROM (SELECT  A.* ";
		sql = sql + "	FROM TB_ALARM_MSG A  WHERE FESTIVAL_CD = '"+festival_cd+"' ";
		sql = sql + "	ORDER BY REC_NUM ASC ) A  ";				  
		sql = sql + "	WHERE ROWNUM <= "+top+" ORDER BY ROWNUM DESC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_alarm_msg();
				biz.setRn(rs.getInt("RNUM"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setTitle(rs.getString("TITLE"));
				biz.setContent(rs.getString("CONTENT"));
				biz.setWriter_id(rs.getString("WRITER_ID"));
				biz.setWriter_nm(rs.getString("WRITER_NM"));
				biz.setWrite_dt(rs.getString("WRITE_DT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	public boolean insertAlarm(String festival_cd, String title, String content, String writer_id, String writer_nm)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_ALARM_MSG(REC_NUM,FESTIVAL_CD,TITLE,CONTENT,WRITER_ID,WRITER_NM) ";
		sql = sql + " SELECT NVL(MAX(REC_NUM),0)+1,'"+festival_cd+"','"+title+"','"+content+"','"+writer_id+"','"+writer_nm+"' FROM TB_ALARM_MSG ";
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
		
	}
	
	public boolean editAlarm(int rec_num, String title, String content)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_ALARM_MSG SET TITLE = '"+title+"',CONTENT = '"+content+"' ";
		sql = sql + " WHERE REC_NUM = "+rec_num;
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
		
	}
	
	public boolean deleteAlarm(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " DELETE FROM TB_ALARM_MSG ";
		sql = sql + " WHERE REC_NUM = "+rec_num;
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
		
	}
}
