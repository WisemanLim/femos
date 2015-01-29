package com.operation.visiter;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import com.config.db.DBConnection;
import com.operation.visiter.Biz_visiter_state;


public class Dal_visiter_state 
{
	private Biz_visiter_state biz = null;
	private Vector v_list = null;
	
	public Dal_visiter_state()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getVisiter_state_stat(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "";
			sql = sql + " SELECT B.FESTIVAL_CD,B.FESTIVAL_HALL_CD,B.FESTIVAL_HALL_NM, ";
			sql = sql + " NVL(PREV_CNT,0) PREV_CNT,NVL(TODAY_CNT,0) TODAY_CNT, ";
			sql = sql + " (NVL(PREV_CNT,0) + NVL(TODAY_CNT,0)) TOTAL_CNT ";
			sql = sql + " FROM ";
			sql = sql + " ( ";
			sql = sql + " 	SELECT FESTIVAL_CD,FESTIVAL_HALL_CD,NVL(SUM(PREV_CNT),0) PREV_CNT,NVL(SUM(TODAY_CNT),0) TODAY_CNT ";
			sql = sql + " 	FROM ";
			sql = sql + " 	( ";
			sql = sql + " 		SELECT FESTIVAL_CD,VISITER_ID,FESTIVAL_HALL_CD,VISIT_YMD, ";
			sql = sql + " 		CASE WHEN VISIT_YMD < TO_CHAR(sysdate,'yyyymmdd') THEN 1 ELSE 0 END PREV_CNT, ";
			sql = sql + " 		CASE WHEN VISIT_YMD = TO_CHAR(sysdate,'yyyymmdd') THEN 1 ELSE 0 END TODAY_CNT ";
			sql = sql + " 		FROM TB_VISITER_STATE WHERE FESTIVAL_CD = '"+festival_cd+"' ";
			sql = sql + " 	) GROUP BY FESTIVAL_CD,FESTIVAL_HALL_CD ";
			sql = sql + " ) A , ";
			sql = sql + " (SELECT * FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"') B ";
			sql = sql + " WHERE A.FESTIVAL_HALL_CD(+) = B.FESTIVAL_HALL_CD ";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_visiter_state();
				
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setPrev_cnt(rs.getInt("PREV_CNT"));
				biz.setToday_cnt(rs.getInt("TODAY_CNT"));
				biz.setTotal_cnt(rs.getInt("TOTAL_CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	
}
