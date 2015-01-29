package com.plan.program;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.budget.Biz_budget;
import com.plan.program.Biz_program_plan;

public class Dal_program_plan 
{
	private Biz_program_plan biz = null;
	private Vector v_list = null;
	
	public Dal_program_plan()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	
	public String insertProgram(String festival_cd ,
			String program_nm ,
			String program_div ,
			String base_summary ,
			String policy ,
			String exec_target ,
			String importance 
	)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "";
		String program_cd = "";
		
		try
		{
		
			sql = "SELECT 'PRO'|| NVL(REPLACE(MAX(PROGRAM_CD),'PRO','')+1,'10000') PROGRAM_CD FROM TB_PROGRAM WHERE FESTIVAL_CD = '"+festival_cd+"'";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				program_cd = rs.getString("PROGRAM_CD");
			}
			
			sql = " INSERT INTO TB_PROGRAM(FESTIVAL_CD,PROGRAM_CD,PROGRAM_NM,PROGRAM_DIV,BASE_SUMMARY,POLICY,EXEC_TARGET,IMPORTANCE)";
			sql = sql + " VALUES('"+festival_cd+"','"+program_cd+"','"+program_nm+"','"+program_div+"','"+base_summary+"','"+policy+"','"+exec_target+"','"+importance+"')";
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return program_cd;
	}
	
	public int insertProgram_budget(String festival_cd ,
			String program_cd ,
			String budget_div ,
			String budget_money
	)
	{
		int rec_num = 0;
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		try
		{
			sql = "SELECT NVL(MAX(REC_NUM),0) + 1 REC_NUM FROM TB_PROGRAM_BUDGET ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				rec_num = rs.getInt("REC_NUM");
			}
			
			sql = " INSERT INTO TB_PROGRAM_BUDGET(REC_NUM,FESTIVAL_CD,PROGRAM_CD,BUDGET_DIV,BUDGET_MONEY) VALUES ";
			sql = sql + " ( "+rec_num+",'"+festival_cd+"','"+program_cd+"','"+budget_div+"',"+budget_money + " )";
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);
			
			
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return rec_num;
	}
	
	
	public boolean insertBudget(String festival_cd,String budget_div, String detail_history, int budget_money,String comp_ratio, String other,String program_key)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_BUDGET(FESTIVAL_CD,REC_NUM,BUDGET_DIV, DETAIL_HISTORY, BUDGET_MONEY, COMP_RATIO, OTHER,PROGRAM_KEY) ";
		sql = sql + " SELECT '"+festival_cd+"',NVL(MAX(REC_NUM),0)+1,'"+budget_div+"','"+detail_history+"',"+budget_money+",'"+comp_ratio+"','"+other+"','"+program_key+"'";
		sql = sql + " FROM TB_BUDGET WHERE FESTIVAL_CD = '"+festival_cd+"'";
		
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
	
	public boolean editProgram(String festival_cd ,
			String program_cd ,
			String program_nm ,
			String program_div ,
			String base_summary ,
			String policy ,
			String exec_target ,
			String importance 
	)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		String sql = "";
		
		try
		{
		
			
			sql = " UPDATE TB_PROGRAM SET ";
			sql = sql + " PROGRAM_NM = '"+program_nm+"',PROGRAM_DIV = '"+program_div+"',BASE_SUMMARY = '"+base_summary+"',POLICY = '"+policy+"',EXEC_TARGET = '"+exec_target+"',";
			sql = sql + " IMPORTANCE = '"+importance+"'";
			sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_CD = '"+program_cd+"'";
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return true;
	}
	
	
	public boolean deleteProgram(String program_cd )
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		String sql = "";
		
		try
		{
			/*
			sql = " DELETE FROM TB_PROGRAM_HR WHERE PROGRAM_CD = '"+program_cd+"'";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);
			*/
			
			sql = " DELETE FROM TB_PROGRAM_BUDGET WHERE PROGRAM_CD = '"+program_cd+"'";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);
			
			sql = " DELETE FROM TB_BUDGET WHERE PROGRAM_KEY = '"+program_cd+"'";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);
			
			
			sql = " DELETE FROM TB_SCHEDULE_PLAN WHERE PROGRAM_CD = '"+program_cd+"'";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);
			
			
			sql = " DELETE FROM TB_PROGRAM WHERE PROGRAM_CD = '"+program_cd+"'";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();   
			stmt.executeUpdate(sql);
			
			
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return true;
	}
	
	
	public boolean insertProgram_hr(String festival_cd ,String program_cd,String pk_no)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_PROGRAM_HR(REC_NUM,FESTIVAL_CD,PROGRAM_CD,PK_NO) ";
		sql = sql + " SELECT NVL(MAX(REC_NUM),0)+1,'"+festival_cd+"','"+program_cd+"','"+pk_no+"' FROM ";
		sql = sql + " TB_PROGRAM_HR WHERE FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_CD = '"+program_cd+"' ";
		
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
	
	public boolean deleteAllProgram_budget(String festival_cd ,String program_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " DELETE FROM TB_PROGRAM_BUDGET ";
		sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_CD = '"+program_cd+"'";
		
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
	
	public boolean deleteAll_budget(String festival_cd ,String program_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " DELETE FROM TB_BUDGET ";
		sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_KEY = '"+program_cd+"'";
		
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
	
	
	
	public boolean deleteAllProgram_hr(String festival_cd ,String program_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " DELETE FROM TB_PROGRAM_HR ";
		sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_CD = '"+program_cd+"'";
		
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
	
	
	public int getProgram_count(String strWhere)
	{
		int ret = 0;
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + "SELECT COUNT(*) REC_CNT FROM TB_PROGRAM "+strWhere; 
		
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
	
	public void getProgram_list(int intStartPoint,int intEndPoint,String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT   * ";
		sql = sql + "		FROM (SELECT ROWNUM AS RNUM, A.* ";
		sql = sql + "				FROM (SELECT  * ";
		sql = sql + "						  FROM (" ;
		sql = sql + "									SELECT AA.*,BB.CODE_NM PROGRAM_DIV_NM,CC.CODE_NM IMPORTANCE_NM,CC.TEXT_COLOR IMPORTANCE_TEXT_COLOR, ";
		sql = sql + "									(SELECT NVL(SUM(BUDGET_MONEY),0) FROM TB_PROGRAM_BUDGET BBB WHERE AA.FESTIVAL_CD = BBB.FESTIVAL_CD AND AA.PROGRAM_CD = BBB.PROGRAM_CD ) NEED_BUDGET ";	
		sql = sql + "									FROM TB_PROGRAM AA, ";
		sql = sql + "									(SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A10') BB,";
		sql = sql + "									(SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A20') CC ";
		sql = sql + "									WHERE AA.PROGRAM_DIV = BB.CODE AND AA.IMPORTANCE = CC.CODE ";
		sql = sql + "								) " + strWhere;				  
		sql = sql + "					 ORDER BY PROGRAM_CD ASC ) A ";
		sql = sql + "			   WHERE ROWNUM <= "+Integer.toString(intStartPoint)+") ";
		sql = sql + "	   WHERE RNUM >= "+Integer.toString(intEndPoint) + " ORDER BY RNUM DESC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_program_plan();
				biz.setRn(rs.getInt("RNUM"));
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setProgram_nm(rs.getString("PROGRAM_NM"));
				biz.setProgram_div(rs.getString("PROGRAM_DIV"));
				biz.setProgram_div_nm(rs.getString("PROGRAM_DIV_NM"));
				biz.setBase_summary(rs.getString("BASE_SUMMARY"));
				biz.setPolicy(rs.getString("POLICY"));
				biz.setExec_target(rs.getString("EXEC_TARGET"));
				biz.setImportance(rs.getString("IMPORTANCE"));
				biz.setImportance_nm(rs.getString("IMPORTANCE_NM"));
				biz.setImportance_text_color(rs.getString("IMPORTANCE_TEXT_COLOR"));
				biz.setNeed_budget(rs.getInt("NEED_BUDGET"));
				
				
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	
	public void getProgram_list_all(String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + "						SELECT  * ";
		sql = sql + "						  FROM (" ;
		sql = sql + "									SELECT AA.*,BB.CODE_NM PROGRAM_DIV_NM,CC.CODE_NM IMPORTANCE_NM,CC.TEXT_COLOR IMPORTANCE_TEXT_COLOR";
		sql = sql + "									FROM TB_PROGRAM AA, ";
		sql = sql + "									(SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A10') BB,";
		sql = sql + "									(SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A20') CC ";
		sql = sql + "									WHERE AA.PROGRAM_DIV = BB.CODE AND AA.IMPORTANCE = CC.CODE ";
		sql = sql + "								) " + strWhere;				  
		sql = sql + "					 ORDER BY PROGRAM_CD ASC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_program_plan();
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setProgram_nm(rs.getString("PROGRAM_NM"));
				biz.setProgram_div(rs.getString("PROGRAM_DIV"));
				biz.setProgram_div_nm(rs.getString("PROGRAM_DIV_NM"));
				biz.setBase_summary(rs.getString("BASE_SUMMARY"));
				biz.setPolicy(rs.getString("POLICY"));
				biz.setExec_target(rs.getString("EXEC_TARGET"));
				biz.setImportance(rs.getString("IMPORTANCE"));
				biz.setImportance_nm(rs.getString("IMPORTANCE_NM"));
				biz.setImportance_text_color(rs.getString("IMPORTANCE_TEXT_COLOR"));
				
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	public Biz_program_plan getProgram_detail(String festival_cd, String program_cd)
	{
		int ret = 0;
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + "SELECT AA.*,BB.CODE_NM PROGRAM_DIV_NM,CC.CODE_NM IMPORTANCE_NM,CC.TEXT_COLOR IMPORTANCE_TEXT_COLOR, ";
		sql = sql + " (SELECT COUNT(*) HR_COUNT FROM TB_PROGRAM_HR AAA WHERE AA.FESTIVAL_CD = AAA.FESTIVAL_CD AND AA.PROGRAM_CD = AAA.PROGRAM_CD) HR_COUNT ";	
		sql = sql + " FROM ";
		sql = sql + " (SELECT * FROM TB_PROGRAM WHERE FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_CD = '"+program_cd+"') AA, ";
		sql = sql + " (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A10') BB,";
		sql = sql + " (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A20') CC ";
		sql = sql + " WHERE AA.PROGRAM_DIV = BB.CODE AND AA.IMPORTANCE = CC.CODE ";
		
		try
		{
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				biz = new Biz_program_plan();
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setProgram_nm(rs.getString("PROGRAM_NM"));
				biz.setProgram_div(rs.getString("PROGRAM_DIV"));
				biz.setProgram_div_nm(rs.getString("PROGRAM_DIV_NM"));
				biz.setBase_summary(rs.getString("BASE_SUMMARY"));
				biz.setPolicy(rs.getString("POLICY"));
				biz.setExec_target(rs.getString("EXEC_TARGET"));
				biz.setImportance(rs.getString("IMPORTANCE"));
				biz.setImportance_nm(rs.getString("IMPORTANCE_NM"));
				biz.setImportance_text_color(rs.getString("IMPORTANCE_TEXT_COLOR"));
				biz.setHr_count(rs.getInt("HR_COUNT"));
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
		return biz;
	}
}
