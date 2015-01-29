package com.operation.missing;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.missing.Biz_missing;

public class Dal_missing {
	
	private Biz_missing biz = null;
	private Vector v_list = null;
	
	public Dal_missing()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public int insertMissing(String name, String protector, String protector_tel)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		int serial = 0;
		
		try
		{
		
			sql = "SELECT NVL(MAX(SERIAL),0)+1 SERIAL FROM TBL_MISSING_INFO ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				serial = rs.getInt("SERIAL");
			}
			
			sql = "INSERT INTO TBL_MISSING_INFO(SERIAL,NAME,PROTECTOR,PROTECTOR_TEL) VALUES("+serial+",'"+name+"','"+protector+"','"+protector_tel+"')";
			
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return serial;
	}
	
	public void updateMissing(int serial, String name, String protector, String protector_tel)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
	
		String sql = "";
		
		try
		{	
			sql = "UPDATE TBL_MISSING_INFO SET NAME = '"+name+"',PROTECTOR = '"+protector+"',PROTECTOR_TEL = '"+protector_tel+"' WHERE SERIAL = "+serial;
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		
	}
	
	public int getMissing_list_count(String strWhere)
	{
		int ret = 0;
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT COUNT(*) REC_CNT FROM TBL_MISSING_INFO "+ strWhere;
			
			System.out.println(sql);
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
		catch(Exception e){System.out.println(e.getMessage());}
		
		return ret;
	}
	
	public void getMissing_list(int intStartPoint,int intEndPoint,String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT   * ";
		sql = sql + "		FROM (SELECT ROWNUM AS RNUM, MAIN.* ";
		sql = sql + "				FROM (";
		sql = sql + "						SELECT A.SERIAL,A.NAME,A.PROTECTOR,A.PROTECTOR_TEL,";			
		sql = sql + "						COUNT(B.SERIAL) RESULT_CNT ";	
		sql = sql + "						FROM (SELECT * FROM TBL_MISSING_INFO) A LEFT OUTER JOIN TBL_MISSING_RESULT B ";
		sql = sql + "						ON A.SERIAL = B.MISSING_KEY "+strWhere;
		sql = sql + "						GROUP BY A.SERIAL,A.NAME,A.PROTECTOR,A.PROTECTOR_TEL";
		sql = sql + "						ORDER BY SERIAL ASC ";
		sql = sql + "				) MAIN ";
		sql = sql + "			   WHERE ROWNUM <= "+Integer.toString(intStartPoint)+") ";
		sql = sql + "	   WHERE RNUM >= "+Integer.toString(intEndPoint) + " ORDER BY RNUM DESC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_missing();
				
				biz.setRn(rs.getInt("RNUM"));
				biz.setSerial(rs.getInt("SERIAL"));
				biz.setName(rs.getString("NAME"));
				biz.setProtector(rs.getString("PROTECTOR"));
				biz.setProtector_tel(rs.getString("PROTECTOR_TEL"));
				biz.setResult_cnt(rs.getInt("RESULT_CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	public Biz_missing getDetailMissing(int serial)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT * FROM TBL_MISSING_INFO WHERE SERIAL = "+serial;
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_missing();
				
				biz.setSerial(rs.getInt("SERIAL"));
				biz.setName(rs.getString("NAME"));
				biz.setProtector(rs.getString("PROTECTOR"));
				biz.setProtector_tel(rs.getString("PROTECTOR_TEL"));
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return biz;
	}
	
}
