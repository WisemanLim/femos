package com.code;

import java.sql.*;
import java.util.Vector;
import com.config.db.DBConnection;
import com.code.Biz_code;

public class Dal_code 
{
	private Biz_code biz = null;
	private Vector v_list = null;
	
	public Dal_code()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getCodeList(String code_group)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT * FROM TB_CODE WHERE CODE_GROUP = '"+code_group+"' AND MEAN_CODE <> '10000' ORDER BY SORT_SEQ ASC";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_code();
				biz.setCode(rs.getString("CODE"));
				biz.setCode_nm(rs.getString("CODE_NM"));
				biz.setCode_group(rs.getString("CODE_GROUP"));
				biz.setMean_code(rs.getString("MEAN_CODE"));
				biz.setSort_seq(rs.getInt("SORT_SEQ"));
				biz.setSummary(rs.getString("SUMMARY"));
				biz.setText_color(rs.getString("TEXT_COLOR"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	
	public boolean insertCode(String code_group,String code_nm, String summary,String text_color)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_CODE(CODE,CODE_NM,CODE_GROUP,MEAN_CODE,SORT_SEQ,SUMMARY,TEXT_COLOR) ";
		sql = sql + " SELECT '"+code_group+"' || TO_CHAR(NVL(MAX(MEAN_CODE),10000) + 1),'"+code_nm+"','"+code_group+"', ";
		sql = sql + " TO_CHAR(NVL(MAX(MEAN_CODE),10000) + 1),NVL(MAX(SORT_SEQ),0)+1,'"+summary+"','"+text_color+"' ";
		sql = sql + " FROM TB_CODE WHERE CODE_GROUP = '"+code_group+"' AND MEAN_CODE <> '10000' ";
		
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
	
	public boolean updateCode(String code, String code_nm, String summary,String text_color)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_CODE SET CODE_NM = '"+code_nm+"',SUMMARY = '"+summary+"',TEXT_COLOR = '"+text_color+"' WHERE CODE = '"+code+"'";
		
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
