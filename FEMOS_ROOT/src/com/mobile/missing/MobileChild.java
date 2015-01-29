/**
 * 
 */
package com.mobile.missing;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.mobile.missing.MissingInfo;

/**
 * @author wisemanlim
 *
 */
public class MobileChild {
	private MissingInfo obj_out = null;
	private Vector vt_out = null;
	
	private String debugSql = "";
	public String getSql() {
		return debugSql;
	}
	
	public MobileChild() {
		vt_out = new Vector();
	}
	
	public Vector getV_list() {
		return vt_out;
	}
	
	// http://hbsys98.vps.phps.kr/mobile/view_missing_info.jsp?missing_key=
	public void getChildList(int missingKey) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		// missingKey조회시 기본정보와 QRCode정보를 내려줌
		try {
			String sql = "SELECT SERIAL, NAME, PROTECTOR, PROTECTOR_TEL, R_SERIAL, RESULT "
						+ "FROM ( SELECT A.SERIAL AS SERIAL, A.NAME AS NAME "
						+ "            , A.PROTECTOR AS PROTECTOR "
						+ "            , A.PROTECTOR_TEL AS PROTECTOR_TEL "
						+ "                 , NVL(B.SERIAL, 0) AS R_SERIAL, NVL(B.RESULT, ' ') AS RESULT "
						+ "            FROM TBL_MISSING_INFO A, TBL_MISSING_RESULT B "
						+ "            WHERE A.SERIAL = B.MISSING_KEY (+) "
						+ "              AND A.SERIAL = NVL(" + missingKey + ", 0) "
						+ "     ) A "
						+ "WHERE ROWNUM = 1 ";
			debugSql = sql;
			
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				obj_out = new MissingInfo();

				obj_out.setSerial(rs.getInt("SERIAL"));
				obj_out.setName(rs.getString("NAME"));
				obj_out.setProtector(rs.getString("PROTECTOR"));
				obj_out.setProtectorTel(rs.getString("PROTECTOR_TEL"));
				obj_out.setRSerial(rs.getInt("R_SERIAL"));
				obj_out.setResult(rs.getString("RESULT"));
				
				vt_out.add(obj_out);
			}
			
			if (rs!=null) { rs.close(); }
			if (stmt!=null) { stmt.close(); }
			
			dbo.SetConClose();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
