package com.plan.hr;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.hr.Biz_hr_plan;

public class Dal_hr_plan 
{
	private Biz_hr_plan biz = null;
	private Vector v_list = null;
	
	public Dal_hr_plan()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public int getJumin_count(String festival_cd,String jumin_fst,String jumin_lst)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		int rec_cnt = 0;
		try
		{
			String sql = "SELECT COUNT(*) REC_CNT FROM TB_HR WHERE FESTIVAL_CD = '"+festival_cd+"' AND JUMIN_FST = '"+jumin_fst+"' AND JUMIN_LST = '"+jumin_lst+"'";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				rec_cnt = rs.getInt("REC_CNT");
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return rec_cnt;
	}
	
	public boolean insertHr(String festival_cd, String hr_nm,String phone,String support_type, String addr, String job)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_HR(PK_NO,FESTIVAL_CD,HR_NM,PHONE,SUPPORT_TYPE,ADDR,JOB)";
		sql = sql + " SELECT 'FHR'|| NVL(REPLACE(MAX(PK_NO),'FHR','')+1,'10000') ,'"+festival_cd+"','"+hr_nm+"','"+phone+"','"+support_type+"','"+addr+"','"+job+"'";
		sql = sql + " FROM TB_HR WHERE FESTIVAL_CD = '"+festival_cd+"'";
		
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
	
	public boolean editHr(String pk_no,String festival_cd, String hr_nm,String phone,String support_type, String addr, String job)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_HR SET";
		sql = sql + " 	HR_NM = '"+hr_nm+"',";
		sql = sql + " 	PHONE = '"+phone+"',";
		sql = sql + " 	SUPPORT_TYPE = '"+support_type+"',";
		sql = sql + " 	ADDR = '"+addr+"',";
		sql = sql + " 	JOB = '"+job+"' ";
		sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND PK_NO = '"+pk_no+"'";
		
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
	
	public boolean deleteHr(String pk_no,String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		System.out.println(sql);
		try
		{
			sql = " DELETE FROM TB_HR ";
			sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND PK_NO = '"+pk_no+"'";
			
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			/*
			sql = " DELETE FROM TB_PROGRAM_HR ";
			sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND PK_NO = '"+pk_no+"'";
			
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			*/
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		
		return ret;
	}
	
	
	
	public int getHr_count(String strWhere)
	{
		int ret = 0;
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + "SELECT COUNT(*) REC_CNT FROM TB_HR "+strWhere; 
		
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
	
	
	public void getHr_list(int intStartPoint,int intEndPoint,String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT   * ";
		sql = sql + "		FROM (SELECT ROWNUM AS RNUM, A.* ";
		sql = sql + "				FROM (SELECT  A.*,B.CODE_NM SUPPORT_TYPE_NM,C.CODE_NM JOB_NM ";
		sql = sql + "						  FROM TB_HR A INNER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A40') B ON A.SUPPORT_TYPE = B.CODE INNER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A50') C ON A.JOB = C.CODE " + strWhere;				  
		sql = sql + "					 ORDER BY PK_NO ASC ) A ";
		sql = sql + "			   WHERE ROWNUM <= "+Integer.toString(intStartPoint)+") ";
		sql = sql + "	   WHERE RNUM >= "+Integer.toString(intEndPoint) + " ORDER BY RNUM DESC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_hr_plan();
				biz.setRn(rs.getInt("RNUM"));
				biz.setPk_no(rs.getString("PK_NO"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setHr_nm(rs.getString("HR_NM"));
				biz.setPhone(rs.getString("PHONE"));
				biz.setSupport_type(rs.getString("SUPPORT_TYPE"));
				biz.setAddr(rs.getString("ADDR"));
				biz.setJob(rs.getString("JOB"));
				biz.setSupport_type_nm(rs.getString("SUPPORT_TYPE_NM"));
				biz.setJob_nm(rs.getString("JOB_NM"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	public void getHr_list_all(String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT A.*,B.CODE_NM SUPPORT_TYPE_NM FROM TB_HR A INNER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A40') B ON A.SUPPORT_TYPE = B.CODE "+strWhere;
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_hr_plan();
				
				biz.setPk_no(rs.getString("PK_NO"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setHr_nm(rs.getString("HR_NM"));
				biz.setPhone(rs.getString("PHONE"));
				biz.setSupport_type(rs.getString("SUPPORT_TYPE"));
				biz.setSupport_type_nm(rs.getString("SUPPORT_TYPE_NM"));
				biz.setAddr(rs.getString("ADDR"));
				biz.setJob(rs.getString("JOB"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	public void getHr_list_main_all(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + " SELECT A.CODE SUPPORT_TYPE,A.CODE_NM SUPPORT_TYPE_NM,NVL(B.CNT,0) CNT FROM TB_CODE A,  ";
		sql = sql + " ( ";
		sql = sql + "  	SELECT BB.SUPPORT_TYPE,COUNT(SUPPORT_TYPE) CNT FROM TB_SCHEDULE_PLAN AA,";
		sql = sql + "  	(SELECT * FROM TB_SCHEDULE_HR AAA, TB_HR BBB WHERE AAA.PK_NO = BBB.PK_NO) BB ";
		sql = sql + "  	WHERE AA.PK_ID = BB.PK_ID AND AA.FESTIVAL_CD = '"+festival_cd+"'  ";
		sql = sql + "  	GROUP BY BB.SUPPORT_TYPE ";
		sql = sql + "  ) B ";
		sql = sql + "  WHERE A.CODE = B.SUPPORT_TYPE(+) AND CODE_GROUP = 'A40' AND MEAN_CODE <> '10000'  ";
		sql = sql + "  ORDER BY CODE ASC,SORT_SEQ ASC ";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_hr_plan();
				biz.setSupport_type(rs.getString("SUPPORT_TYPE"));
				biz.setSupport_type_nm(rs.getString("SUPPORT_TYPE_NM"));
				biz.setCnt(rs.getInt("CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	public void getProgram_hr_list(String festival_cd, String program_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = " SELECT B.* FROM TB_PROGRAM_HR A INNER JOIN TB_HR B ";
		sql = sql + " ON A.FESTIVAL_CD = B.FESTIVAL_CD AND A.PK_NO = B.PK_NO ";
		sql = sql + " WHERE A.FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_CD = '"+program_cd+"' ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_hr_plan();
				
				biz.setPk_no(rs.getString("PK_NO"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setHr_nm(rs.getString("HR_NM"));
				biz.setPhone(rs.getString("PHONE"));
				biz.setSupport_type(rs.getString("SUPPORT_TYPE"));
				biz.setAddr(rs.getString("ADDR"));
				biz.setJob(rs.getString("JOB"));
				
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
}
