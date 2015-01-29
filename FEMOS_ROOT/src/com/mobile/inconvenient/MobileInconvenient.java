package com.mobile.inconvenient;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.mobile.visiter.Visiter;

public class MobileInconvenient {
	private Inconvenient obj_out = null;
	private Vector vt_out = null;
	
	private String debugSql = "";
	public String getSql() {
		return debugSql;
	}
	
	public MobileInconvenient() {
		vt_out = new Vector();
	}
	
	public Vector getV_list() {
		return vt_out;
	}
	
	public boolean insertInconvenient(String reporterId, String festivalCd, String inconvenientDiv
									, String festivalHallCd, String title, String content, String state
									, String filePath, String fileNm, String fileExt, int fileSize) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;
		
		int attachFileGroup = insertAttachFile(filePath, fileNm, fileExt, fileSize);
		
		festivalHallCd = "FSH10001"; // 임의변경
		
		String sql = "INSERT INTO TB_INCONVENIENT ( REC_NUM, REPORTER_ID, FESTIVAL_CD, INCONVENIENT_DIV "
				   + ", FESTIVAL_HALL_CD, TITLE, CONTENT, ATTACH_FILE_GROUP, REPORT_DT "
				   + ", TRANS_DT, TRANS_YN, RECEIVE_DT, RECEIVE_YN, PROGRESS_STATE ) "
				   + "SELECT NVL(MAX(REC_NUM), 0) + 1 AS REC_NUM, '" + reporterId + "' AS REPORTER_ID "
				   + ", '" + festivalCd + "' AS FESTIVAL_CD, '" + inconvenientDiv + "' AS INCONVENIENT_DIV "
				   + ", '" + festivalHallCd + "' AS FESTIVAL_HALL_CD, '" + title + "' AS TITLE "
				   + ", '" + content + "' AS CONTENT, NVL(" + attachFileGroup + ", 0) AS ATTACH_FILE_GROUP "
				   + ", SYSDATE AS REPORT_DT, SYSDATE AS TRANS_DT, 'Y' AS TRANS_YN "
				   + ", SYSDATE AS RECEIVE_DT, 'Y' AS RECEIVE_YN, '" +  state + "' "
				   + "FROM TB_INCONVENIENT ";
		
		System.out.println(sql);
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
	
	private int insertAttachFile(String filePath, String fileNm, String fileExt, int fileSize) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		int fileGroup = 0;
		String sql = "";
		
		try {
			/**
			 * VISITER_ID : FestivalCD(8자리) + 가입년월일(8자리) + 순번(5자리)
			 */
			sql = "SELECT NVL(MAX(FILE_NUM), 0) + 1 AS FILE_NUM "
				+ "FROM TB_ATTACH_FILE ";
			debugSql = sql;
			
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			
			if ( rs.next() ) {
				fileGroup = rs.getInt("FILE_NUM");
			}
			
			if (rs!=null) { rs.close(); }
			if (stmt!=null) { stmt.close(); }
			
//			dbo.SetConClose();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		sql = "INSERT INTO TB_ATTACH_FILE ( FILE_NUM, FILE_GROUP, FILE_PATH, FILE_NM, FILE_EXT, FILE_SIZE ) "
			+ "SELECT NVL(MAX(FILE_NUM), 0) + 1 AS FILE_NUM, NVL(" + fileGroup + ", 0) AS FILE_GROUP "
			+ ", '" + filePath + "' AS FILE_PATH, '" + fileNm + "' AS FILE_NM "
			+ ", '" + fileExt + "' AS FILE_EXT, NVL(" + fileSize + ", 0) AS FILE_SIZE "
			+ "FROM TB_ATTACH_FILE ";
		
		System.out.println(sql);
		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if (stmt != null) { stmt.close(); }
			dbo.SetConClose();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return fileGroup;
	}
}
