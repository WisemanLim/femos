package com.plan.lodge;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.lodge.Biz_lodge_main;

public class Dal_lodge_main {
	
	private Biz_lodge_main biz = null;
	private Vector v_list = null;
	
	public Dal_lodge_main()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public String insertLodge_main(String festival_cd, String lodge_nm, String phone, String addr)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		
		String sql = "";
		String lodge_no = "";
		
		try
		{
		
			sql = "SELECT 'LOD'|| NVL(REPLACE(MAX(LODGE_NO),'LOD','')+1,'10000') LODGE_NO FROM TB_LODGE_MAIN WHERE FESTIVAL_CD = '"+festival_cd+"' ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				lodge_no = rs.getString("LODGE_NO");
			}
			
			sql = " INSERT INTO TB_LODGE_MAIN(LODGE_NO,FESTIVAL_CD,LODGE_NM,PHONE,ADDR) ";
			sql = sql + " VALUES( '"+lodge_no+"','"+festival_cd+"','"+lodge_nm+"','"+phone+"','"+addr+"') ";
			
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return lodge_no;
	}
	
	
	
	public boolean updateLodge_main(String lodge_no,String festival_cd, String lodge_nm, String phone, String addr)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_LODGE_MAIN SET LODGE_NM = '"+lodge_nm+"', PHONE = '"+phone+"', ADDR = '"+addr+"' ";
		sql = sql + " WHERE FESTIVAL_CD = '"+festival_cd+"' AND LODGE_NO = '"+lodge_no+"' ";
		
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
	
	public boolean deleteLodge_main(String lodge_no,String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		System.out.println(sql);
		try
		{
			sql = " DELETE FROM TB_LODGE_SUB WHERE FESTIVAL_CD = '"+festival_cd+"' AND LODGE_NO = '"+lodge_no+"' ";
			
			
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql); 
			
			sql = " DELETE FROM TB_LODGE_MAIN WHERE FESTIVAL_CD = '"+festival_cd+"' AND LODGE_NO = '"+lodge_no+"' ";
			
			
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		
		return ret;
	}
	
	public void getLodge_list(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT * FROM TB_LODGE_MAIN WHERE FESTIVAL_CD = '"+festival_cd+"' ORDER BY LODGE_NO DESC ";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_lodge_main();
				biz.setLodge_no(rs.getString("LODGE_NO"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setLodge_nm(rs.getString("LODGE_NM"));
				biz.setPhone(rs.getString("PHONE"));
				biz.setAddr(rs.getString("ADDR"));
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
}
