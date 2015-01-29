package com.plan.program;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import com.config.db.DBConnection;

import com.plan.program.Biz_program_budget;

public class Dal_program_budget 
{
	private Biz_program_budget biz = null;
	private Vector v_list = null;
	
	public Dal_program_budget()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getProgramByBudgetList(String festival_cd,String program_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = " SELECT * FROM TB_PROGRAM_BUDGET WHERE FESTIVAL_CD = '"+festival_cd+"' AND PROGRAM_CD = '"+program_cd+"'";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_program_budget();
				
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setBudget_div(rs.getString("BUDGET_DIV"));
				biz.setBudget_money(rs.getInt("BUDGET_MONEY"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
		
	}
}
