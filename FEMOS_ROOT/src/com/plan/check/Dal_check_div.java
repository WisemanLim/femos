package com.plan.check;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.code.Biz_code;
import com.config.db.DBConnection;
import com.plan.check.Biz_check_div;

public class Dal_check_div 
{
	private Biz_check_div biz = null;
	private Vector v_list = null;
	
	public Dal_check_div()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getCheckDivList(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{
			String sql = " 	SELECT CHECK_CD,FESTIVAL_CD,PARENT_CHECK_CD,CHECK_NM,SORT_SEQ, LEVEL LVL,  ";
			sql = sql + " 	SUBSTR(SYS_CONNECT_BY_PATH(CHECK_CD, '>'),2,LENGTH(SYS_CONNECT_BY_PATH(CHECK_CD, '>'))) CHECK_CD_PATH, ";
			sql = sql + "	SUBSTR(SYS_CONNECT_BY_PATH(CHECK_NM, '>'),2,LENGTH(SYS_CONNECT_BY_PATH(CHECK_NM, '>'))) CHECK_NM_PATH, ";
			sql = sql + "	CONNECT_BY_ISLEAF LEAF ";
			sql = sql + "	FROM TB_CHECK_DIV WHERE FESTIVAL_CD = '"+festival_cd+"' ";
			sql = sql + "	START WITH PARENT_CHECK_CD = '0' ";
			sql = sql + "	CONNECT BY PRIOR CHECK_CD = PARENT_CHECK_CD  ";
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_check_div();
				biz.setCheck_cd(rs.getString("CHECK_CD"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setParent_check_cd(rs.getString("PARENT_CHECK_CD"));
				biz.setCheck_nm(rs.getString("CHECK_NM"));
				biz.setSort_seq(rs.getInt("SORT_SEQ")); 
				biz.setCheck_cd_path(rs.getString("CHECK_CD_PATH"));
				biz.setCheck_nm_path(rs.getString("CHECK_NM_PATH"));
				biz.setLeaf(rs.getInt("LEAF"));
				biz.setLvl(rs.getInt("LVL"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
	public String insertCheck_div(String festival_cd ,
			String parent_check_cd ,
			String check_nm
	)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "";
		String check_cd = "";
		
		try
		{
		
			sql = "SELECT 'CHK'|| NVL(REPLACE(MAX(CHECK_CD),'CHK','')+1,'10000') CHECK_CD FROM TB_CHECK_DIV ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				check_cd = rs.getString("CHECK_CD");
			}
			
			sql = " INSERT INTO TB_CHECK_DIV(CHECK_CD,FESTIVAL_CD,PARENT_CHECK_CD,CHECK_NM,SORT_SEQ) ";
			sql = sql + " VALUES('"+check_cd+"','"+festival_cd+"','"+parent_check_cd+"','"+check_nm+"',0) ";
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return check_cd;
	}
	
	public boolean updateCheck_div(String check_cd, String parent_check_cd, String check_nm)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_CHECK_DIV SET PARENT_CHECK_CD = '"+parent_check_cd+"', CHECK_NM = '"+check_nm+"' WHERE CHECK_CD = '"+check_cd+"'";
		
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
	
	public boolean deleteCheck_div(String check_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
	
		try
		{
			
			stmt = dbo.DbOpen().createStatement();
			
			sql = " DELETE FROM TB_CHECK_ITEMS WHERE ITEM_DIV = '"+check_cd+"'";
			stmt.executeUpdate(sql);
			
			sql = " DELETE FROM TB_CHECK_DIV WHERE CHECK_CD = '"+check_cd+"'";
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		
		return ret;
	}
}
