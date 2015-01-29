package com.plan.check;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.check.Biz_check_items;

public class Dal_check_items 
{
	private Biz_check_items biz = null;
	private Vector v_list = null;
	
	public Dal_check_items()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getCheckItemsList(String check_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT A.*,B.CHECK_NM ITEM_DIV_NM,C.CODE_NM IMPORTANCE_NM,  ";
			sql = sql + " 	C.TEXT_COLOR IMPORTANCE_TEXT_COLOR ";
			sql = sql + "	FROM TB_CHECK_ITEMS A ";
			sql = sql + "	INNER JOIN ";
			sql = sql + "	(SELECT * FROM TB_CHECK_DIV ) B ON A.ITEM_DIV = B.CHECK_CD ";
			sql = sql + "	INNER JOIN ";
			sql = sql + "	(SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A60') C ON A.IMPORTANCE = C.CODE ";
			sql = sql + "	WHERE ITEM_DIV = '"+check_cd+"' ";
			
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_check_items();
				biz.setItem_num(rs.getInt("ITEM_NUM"));
				biz.setItem_div(rs.getString("ITEM_DIV"));
				biz.setItem_div_nm(rs.getString("ITEM_DIV_NM"));
				biz.setItem_nm(rs.getString("ITEM_NM"));
				biz.setSummary(rs.getString("SUMMARY"));
				biz.setImportance(rs.getString("IMPORTANCE"));
				biz.setImportance_nm(rs.getString("IMPORTANCE_NM"));
				biz.setImportance_text_color(rs.getString("IMPORTANCE_TEXT_COLOR"));
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public boolean insertCheck_items(
			String item_div ,
			String item_nm,
			String summary,
			String importance
	)
	{
		boolean ret = true;
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "";
		
		try
		{
		
			sql = " INSERT INTO TB_CHECK_ITEMS(ITEM_NUM,ITEM_DIV,ITEM_NM,SUMMARY,IMPORTANCE) ";
			sql = sql + " SELECT NVL(MAX(ITEM_NUM),0)+1 , '"+item_div+"','"+item_nm+"','"+summary+"','"+importance+"'";
			sql = sql + " FROM TB_CHECK_ITEMS ";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean updateCheck_items(
			int item_num ,
			String item_nm,
			String summary,
			String importance
	)
	{
		boolean ret = true;
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "";
		
		try
		{
		
			sql = " UPDATE TB_CHECK_ITEMS SET ITEM_NM = '"+item_nm+"', ";
			sql = sql + "  SUMMARY = '"+summary+"', ";
			sql = sql + "  IMPORTANCE = '"+importance+"' WHERE ITEM_NUM = "+item_num;
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean deleteCheck_items(int item_num )
	{
		boolean ret = true;
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "";
		
		try
		{
		
			sql = " DELETE FROM TB_CHECK_ITEMS WHERE ITEM_NUM = "+item_num;
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	
}
