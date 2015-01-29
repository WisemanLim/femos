package com.plan.budget;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import com.config.db.DBConnection;

public class Dal_budget {
	private Biz_budget biz = null;
	private Vector v_list = null;
	
	public Dal_budget()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getBudgetList(String code_group,String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT A.*,(SELECT COUNT(*) FROM TB_BUDGET AA WHERE AA.FESTIVAL_CD = '"+festival_cd+"' AND AA.BUDGET_DIV = A.CODE) CNT";
			sql = sql + " FROM TB_CODE A WHERE CODE_GROUP = '"+code_group+"' AND MEAN_CODE <> '10000'";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_budget();
				biz.setBudget_div(rs.getString("CODE"));
				biz.setBudget_div_nm(rs.getString("CODE_NM"));
				biz.setCnt(rs.getInt("CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public void getBudgetMainList(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "";
			sql = sql + " SELECT A.CODE BUDGET_DIV,A.CODE_NM BUDGET_DIV_NM, ";
			sql = sql + " NVL(SUM(B.BUDGET_MONEY),0) BUDGET_MONEY ";
			sql = sql + " FROM TB_CODE A LEFT OUTER JOIN ";
			sql = sql + " (SELECT * FROM TB_BUDGET WHERE FESTIVAL_CD = '"+festival_cd+"') B ";
			sql = sql + " ON A.CODE = B.BUDGET_DIV ";
			sql = sql + " WHERE CODE_GROUP = 'A30' AND MEAN_CODE <> '10000' ";
			sql = sql + " GROUP BY CODE,CODE_NM ORDER BY CODE ASC ";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_budget();
				biz.setBudget_div(rs.getString("BUDGET_DIV"));
				biz.setBudget_div_nm(rs.getString("BUDGET_DIV_NM"));
				biz.setBudget_money(rs.getInt("BUDGET_MONEY"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public void getBudgetSubList(String festival_cd,String budget_div)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = " SELECT * FROM TB_BUDGET ";
			sql = sql + "  WHERE FESTIVAL_CD = '"+festival_cd+"' AND BUDGET_DIV = '"+budget_div+"'";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_budget();
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setBudget_div(rs.getString("BUDGET_DIV"));
				biz.setDetail_history(rs.getString("DETAIL_HISTORY"));
				biz.setBudget_money(rs.getInt("BUDGET_MONEY"));
				biz.setComp_ratio(rs.getString("COMP_RATIO"));
				biz.setOther(rs.getString("OTHER"));
				biz.setProgram_key(rs.getString("PROGRAM_KEY"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	
	
	
	public boolean insertBudget(String festival_cd,String budget_div, String detail_history, int budget_money,String comp_ratio, String other)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_BUDGET(FESTIVAL_CD,REC_NUM,BUDGET_DIV, DETAIL_HISTORY, BUDGET_MONEY, COMP_RATIO, OTHER) ";
		sql = sql + " SELECT '"+festival_cd+"',NVL(MAX(REC_NUM),0)+1,'"+budget_div+"','"+detail_history+"',"+budget_money+",'"+comp_ratio+"','"+other+"'";
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
	
	public boolean updateBudget(String festival_cd,int rec_num, String detail_history, int budget_money,String comp_ratio, String other)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_BUDGET SET DETAIL_HISTORY = '"+detail_history+"', BUDGET_MONEY = "+budget_money+",COMP_RATIO = '"+comp_ratio+"',OTHER = '"+other+"'";
		sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND REC_NUM = "+rec_num;
		
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
	
	public boolean deleteBudget(String festival_cd,int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " DELETE FROM TB_BUDGET WHERE FESTIVAL_CD = '"+festival_cd+"' AND REC_NUM = "+rec_num;
		
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
