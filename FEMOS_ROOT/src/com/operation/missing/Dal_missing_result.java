package com.operation.missing;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.missing.Biz_missing_result;

public class Dal_missing_result {
	
	private Biz_missing_result biz = null;
	private Vector v_list = null;
	
	public Dal_missing_result()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	
	public void getMissing_result_list(int missing_key)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT  * FROM TBL_MISSING_RESULT WHERE MISSING_KEY = "+missing_key+" ORDER BY SERIAL ASC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_missing_result();
				
				biz.setSerial(rs.getInt("SERIAL"));
				biz.setMissing_key(rs.getInt("MISSING_KEY"));
				biz.setResult(rs.getString("RESULT"));
				
				v_list.add(biz);
				
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	public int insertMissing_result(int missing_key, String result)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		int serial = 0;
		
		try
		{
		
			sql = "SELECT NVL(MAX(SERIAL),0)+1 SERIAL FROM TBL_MISSING_RESULT ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				serial = rs.getInt("SERIAL");
			}
			
			sql = "INSERT INTO TBL_MISSING_RESULT(SERIAL,MISSING_KEY,RESULT) VALUES("+serial+","+missing_key+",'"+result+"')";
			
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return serial;
	}
}
