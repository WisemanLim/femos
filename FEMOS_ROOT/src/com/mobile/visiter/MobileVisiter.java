package com.mobile.visiter;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.mobile.visiter.Visiter;

public class MobileVisiter {
	private Visiter obj_out = null;
	private Vector vt_out = null;
	
	private String debugSql = "";
	public String getSql() {
		return debugSql;
	}
	
	public MobileVisiter() {
		vt_out = new Vector();
	}
	
	public Vector getV_list() {
		return vt_out;
	}
	
	// http://hbsys98.vps.phps.kr/mobile/join_festival_1.jsp
	// 시험용 
	public boolean insertVisiter(String festivalCd, String visiterNm, String sex, String hp, String email) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		/**
		 * VISITER_ID : FestivalCD(8자리) + 가입년월일(8자리) + 순번(5자리)
		 */
		String sql = "INSERT INTO TB_VISITER_INFO ( VISITER_ID, VISITER_NM, SEX, HP, EMAIL ) "
				   + "SELECT '" + festivalCd + "' || TO_CHAR(SYSDATE, 'YYYYMMDD') || LPAD(NVL(MAX(SUBSTR(VISITER_ID, 17, 5)), 0) + 1, 5, 0) AS VISITER_ID "
				   + "     , '" + visiterNm + "' AS VISITER_NM, '" + sex + "' AS SEX, '" + hp + "' AS HP, '" + email + "' AS EMAIL "
				   + "FROM TB_VISITER_INFO "
				   + "WHERE VISITER_ID LIKE '" + festivalCd + "' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '%' ";
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
	
	// 실제사용 : 회원가입 --> visiterId발급 --> 발급된 visiterId, QRcode mapping
	public String strInsertVisiter(String festivalCd, String visiterNm, String sex, String hp, String email) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		String visiterId = "";
		String sql = "";
		
		// 동일축제에 중복가입자인지 인증 : 추가할 예정
		
		// visiterId발급
		try {
			/**
			 * VISITER_ID : FestivalCD(8자리) + 가입년월일(8자리) + 순번(5자리)
			 */
			sql = "SELECT '" + festivalCd + "' || TO_CHAR(SYSDATE, 'YYYYMMDD') || LPAD(NVL(MAX(SUBSTR(VISITER_ID, 17, 5)), 0) + 1, 5, 0) AS VISITER_ID "
				+ "FROM TB_VISITER_INFO "
				+ "WHERE VISITER_ID LIKE '" + festivalCd + "' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '%' ";
			debugSql = sql;
			
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			
			if ( rs.next() ) {
				visiterId = rs.getString("VISITER_ID");
			}
			
			if (rs!=null) { rs.close(); }
			if (stmt!=null) { stmt.close(); }
			
//			dbo.SetConClose();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		// 가입처리
		sql = "INSERT INTO TB_VISITER_INFO ( VISITER_ID, VISITER_NM, SEX, HP, EMAIL ) "
			+ "VALUES ( '" + visiterId + "', '" + visiterNm + "', '" + sex + "', '" + hp + "', '" + email + "' ) ";
		debugSql = sql;
		
		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if (stmt != null) { stmt.close(); }
			
//			dbo.SetConClose();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		String viewUrl = "hbsys98.vps.phps.kr/mobile/visiter_check.jsp?festivalCd=FES10001&serial=";
		
		// visiterId, QRCode mapping
		sql = "UPDATE TBL_QR_BATCH_CODE SET VISITER_ID = '" + visiterId + "' "
			+ "WHERE CONTENTS_TYPE||LPAD(SEQ, 10, 0)||LPAD(SUB_SEQ, 10, 0) IN ( "
			+ "      SELECT CONDITIONS "
			+ "      FROM ( SELECT CONTENTS_TYPE||LPAD(SEQ, 10, 0)||LPAD(MAX(SUB_SEQ), 10, 0) AS CONDITIONS "
			+ "             FROM TBL_QR_BATCH_CODE "
			+ "             WHERE CONTENTS_TYPE||LPAD(SEQ, 10, 0) IN ( "
			+ "                   SELECT CONTENTS_TYPE||LPAD(SEQ, 10, 0) AS CONDITIONS "
			+ "     	          FROM TBL_QR_CONTENTS_MASTER "
			+ "     	          WHERE MANDATORY_FIELD LIKE '%" + viewUrl + "%' "
			+ "     	            AND IS_USED = 'Y' ) "
			+ "               AND IS_USED = 'Y' "
			+ "               AND VISITER_ID IS NULL "
			+ "             GROUP BY CONTENTS_TYPE, SEQ, SUB_SEQ "
			+ "             ORDER BY CONDITIONS ) "
			+ "      WHERE ROWNUM = 1 "
			+ ") ";
		debugSql = sql;
		
		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if (stmt != null) { stmt.close(); }
			
			dbo.SetConClose();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
				
		return visiterId;
	}
	
	// http://hbsys98.vps.phps.kr/mobile/view_festival.jsp?visiterId=
	public void getVisiterList(String visiterId) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		// visiterId조회시 기본정보와 QRCode정보를 내려줌
		try {
//			String sql = "SELECT VISITER_ID, VISITER_NM, SEX, HP, EMAIL "
//					+ "FROM TB_VISITER_INFO "
//					+ "WHERE VISITER_ID = '" + visiterId + "' ";
			String sql = "SELECT VISITER_ID, VISITER_NM, SEX, HP, EMAIL, QRCODE "
						+ "FROM ( SELECT A.VISITER_ID AS VISITER_ID, A.VISITER_NM AS VISITER_NM "
						+ "            , A.SEX AS SEX, A.HP AS HP, A.EMAIL AS EMAIL "
						+ "            , B.PUBLISH_QRCODE_IMAGE_URL AS QRCODE "
						+ "       FROM ( SELECT VISITER_ID, VISITER_NM, SEX, HP, EMAIL "
						+ "              FROM TB_VISITER_INFO "
						+ "              WHERE VISITER_ID = '" + visiterId + "' "
						+ "            ) A, ( "
						+ "            SELECT VISITER_ID, PUBLISH_QRCODE_IMAGE_URL "
						+ "            FROM TBL_QR_BATCH_CODE "
						+ "            WHERE VISITER_ID = '" + visiterId + "' "
						+ "            UNION ALL "
						+ "            SELECT '" + visiterId + "' AS VISITER_ID, 'NOT' AS PUBLISH_QRCODE_IMAGE_URL "
						+ "            FROM DUAL "
						+ "            ) B "
						+ "       WHERE A.VISITER_ID = B.VISITER_ID "
						+ "       ORDER BY PUBLISH_QRCODE_IMAGE_URL ASC "
						+ "     ) A "
						+ "WHERE ROWNUM = 1 ";
			debugSql = sql;
			
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				obj_out = new Visiter();

				obj_out.setVisiterId(rs.getString("VISITER_ID"));
				obj_out.setVisiterNm(rs.getString("VISITER_NM"));
				obj_out.setSex(rs.getString("SEX"));
				obj_out.setHp(rs.getString("HP"));
				obj_out.setEmail(rs.getString("EMAIL"));
				obj_out.setQrcode(rs.getString("QRCODE"));
				
				vt_out.add(obj_out);
			}
			
			if (rs!=null) { rs.close(); }
			if (stmt!=null) { stmt.close(); }
			
			dbo.SetConClose();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	// baseUrl : hbsys98.vps.phps.kr/FEMOS/mobile/visiter_check.jsp?festivalCd=FES10001&serial=
	// parameter adding : &visiterId=
	public boolean insertVisiterState(String festivalCd, int serial, String visiterId, String festivalHallCd) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		boolean ret = true;
		
		String sql = "";
		
		if ( visiterId.equals("") || visiterId == "" ) {
			try {
				sql = "SELECT VISITER_ID "
					+ "FROM TBL_QR_BATCH_CODE "
					+ "WHERE CONTENTS_TYPE||LPAD(SEQ, 10, 0)||LPAD(SUB_SEQ, 10, 0) IN ( "
				    + "      SELECT CONTENTS_TYPE||LPAD(SEQ, 10, 0)||LPAD(SUB_SEQ, 10, 0) AS CONDITIONS "
				    + "      FROM TBL_QR_BATCH_CODE "
				    + "      WHERE CONTENTS_TYPE||LPAD(SEQ, 10, 0) IN ( "
				    + "            SELECT CONTENTS_TYPE||LPAD(SEQ, 10, 0) AS CONDITIONS "
				    + "     	   FROM TBL_QR_CONTENTS_MASTER "
				    + "     	   WHERE MANDATORY_FIELD LIKE '%" + festivalCd + "%' "
				    + "     	     AND IS_USED = 'Y' ) "
				    + "        AND IS_USED = 'Y' "
				    + "        AND SUB_SEQ = " + serial + " "
				    + ") ";
				debugSql = sql;
				
				stmt = dbo.DbOpen().createStatement();
				rs = stmt.executeQuery(sql);
				
				if ( rs.next() ) {
					visiterId = rs.getString("VISITER_ID");
				}
				
				if (rs!=null) { rs.close(); }
				if (stmt!=null) { stmt.close(); }
				
	//			dbo.SetConClose();
			} catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
		
		sql = "INSERT INTO TB_VISITER_STATE ( REC_NUM, VISITER_ID, FESTIVAL_CD, FESTIVAL_HALL_CD, VISIT_YMD ) "
			+ "SELECT NVL(MAX(REC_NUM) + 1, 1) AS REC_NUM "
			+ "     , '" + visiterId + "' AS VISITER_ID "
			+ "     , '" + festivalCd + "' AS FESTIVAL_CD, '" + festivalHallCd + "' AS FESTIVAL_HALL_CD "
			+ "     , TO_CHAR(SYSDATE, 'YYYYMMDD') AS VISIT_YMD "
			+ "FROM TB_VISITER_STATE ";
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
