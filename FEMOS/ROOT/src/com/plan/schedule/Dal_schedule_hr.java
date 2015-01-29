package com.plan.schedule;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.schedule.Biz_schedule_hr;

public class Dal_schedule_hr 
{
	private Biz_schedule_hr biz = null;
	private Vector v_list = null;
	
	public Dal_schedule_hr()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getScheduleHrList(int pk_id)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			
			String sql = " SELECT A.*,B.HR_NM HR_NM,C.CODE_NM SUPPORT_TYPE_NM FROM TB_SCHEDULE_HR A INNER JOIN TB_HR B ";
			sql = sql + "  ON A.PK_NO = B.PK_NO INNER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A40') C  ";
			sql = sql + "  ON B.SUPPORT_TYPE = C.CODE ";
			sql = sql + "  WHERE PK_ID = "+pk_id;	
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_schedule_hr();
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setPk_id(rs.getInt("PK_ID"));
				biz.setPk_no(rs.getString("PK_NO"));
				biz.setHr_nm(rs.getString("HR_NM"));
				biz.setSupport_type(rs.getString("SUPPORT_TYPE_NM"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
	}
	
}
