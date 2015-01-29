package com.operation.route;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.route.Biz_route_trace;

public class Dal_route_trace
{
	private Biz_route_trace biz = null;
	private Vector v_list = null;
	
	public Dal_route_trace()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getRoute_trace_list(String festival_cd, String festival_hall_cd, int top)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = " SELECT ROWNUM RN, PATH,PATH_NM,CNT FROM  ";
			sql = sql + " ( ";
			sql = sql + " 	 SELECT PATH,PATH_NM,COUNT(PKEY) CNT ";
			sql = sql + " 	 FROM TB_ROUTE_TRACE WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"' ";
			sql = sql + " 	 GROUP BY PATH,PATH_NM ORDER BY CNT DESC ";
			sql = sql + " ) WHERE ROWNUM <= "+top;
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_route_trace();
				
				biz.setRn(rs.getInt("RN"));
				biz.setPath(rs.getString("PATH"));
				biz.setPath_nm(rs.getString("PATH_NM"));
				biz.setCnt(rs.getInt("CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
}
