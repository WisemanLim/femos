package com.mobile.satisfaction;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.mobile.visiter.Visiter;

public class MobileSatisfied {
	private Visiter obj_out = null;
	private Vector vt_out = null;
	
	private String debugSql = "";
	public String getSql() {
		return debugSql;
	}
	
	public MobileSatisfied() {
		vt_out = new Vector();
	}
	
	public Vector getV_list() {
		return vt_out;
	}
	
	// baseUrl : hbsys98.vps.phps.kr/mobile/satis_check.jsp?festivalCd=FES10001&festivalHallCd=FSH10001 --> old
	//           hbsys98.vps.phps.kr/mobile/satis_check.jsp?festivalHallCd=FHS10001 로 변경
	// parameter adding : festivalCd, visiterId, &grade
	public boolean insertSatisfaction(String festivalCd, String festivalHallCd, String visiterId, int grade) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		String sql = "INSERT INTO TBL_SATISFACTION ( REC_NUM, VISITER_ID, FESTIVAL_CD, FESTIVAL_HALL_CD, GRADE, SATISFIED_YMD ) "
					+ "SELECT NVL(MAX(REC_NUM) + 1, 1) AS REC_NUM "
					+ "     , '" + visiterId + "' AS VISITER_ID "
					+ "     , '" + festivalCd + "' AS FESTIVAL_CD, '" + festivalHallCd + "' AS FESTIVAL_HALL_CD "
					+ "     , NVL(" + grade + ", 0) AS GRADE "
					+ "     , TO_CHAR(SYSDATE, 'YYYYMMDD') AS SATISFIED_YMD "
					+ "FROM TBL_SATISFACTION ";
		debugSql = sql;
		
		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if (stmt != null) { stmt.close(); }
			dbo.SetConClose();
			
			ret = true;
		} catch(Exception e) {
			System.out.println(e.getMessage());
			ret = false;
		}
		
		return ret;
	}
}
