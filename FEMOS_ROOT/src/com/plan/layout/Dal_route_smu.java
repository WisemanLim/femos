package com.plan.layout;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import com.config.db.DBConnection;

public class Dal_route_smu {
	private Biz_route_smu biz = null;
	private JSONObject json = null;
	private JSONArray jsonArray = null;
	private Vector v_list = null;

	public Dal_route_smu() {
		v_list = new Vector();
		json = new JSONObject();
		jsonArray = new JSONArray();
	}

	public JSONObject getJSON() {
		return json;
	}

	public JSONArray getJSONS() {
		return jsonArray;
	}

	public int getRouteMaxRcd() {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;

		int rInt = 0;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT ");
			sql.append("		MAX(CAST(SUBSTR(ROUTE_CD, 4, LENGTH(ROUTE_CD)) AS integer))+1 as ROUTE_CD ");
			sql.append(" FROM ");
			sql.append("		TB_SMU_ROUTE ");

			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql.toString());

			while (rs.next()) {
				rInt = rs.getInt("ROUTE_CD");
			}

			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return rInt;
	}

	public int getBaseMaxHcd() {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;

		int rInt = 0;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT ");
			sql.append("		MAX(CAST(SUBSTR(FESTIVAL_HALL_CD, 4, LENGTH(FESTIVAL_HALL_CD)) AS integer))+1 as FESTIVAL_HALL_CD ");
			sql.append(" FROM ");
			sql.append("		TB_SMU_BASE ");

			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql.toString());

			while (rs.next()) {
				rInt = rs.getInt("FESTIVAL_HALL_CD");
			}

			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return rInt;
	}

	public int getInstMaxObjcd() {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;

		int rInt = 0;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT ");
			sql.append("		MAX(CAST(SUBSTR(OBJ_CD, 4, LENGTH(OBJ_CD)) AS integer))+1 as OBJ_CD ");
			sql.append(" FROM ");
			sql.append("		TB_SMU_INSTALLATION ");

			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql.toString());

			while (rs.next()) {
				rInt = rs.getInt("OBJ_CD");
			}

			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return rInt;
	}

	@SuppressWarnings("unchecked")
	public void getRouteByFhcd(String cd) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;

		try {
			StringBuilder sql = new StringBuilder();
			sql.append("	SELECT");
			sql.append("		* ");
			sql.append(" FROM");
			sql.append("		TB_SMU_ROUTE");
			sql.append(" WHERE");
			sql.append("		FESTIVAL_HALL_CD=\'" + cd + "\' ");
			sql.append(" ORDER BY	ROUTE_CD ");

			System.out.println(sql.toString());

			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql.toString());

			json.put("list", covRs2JsonArray(rs));

			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	@SuppressWarnings("unchecked")
	public void getBuildingByFhcd(String cd) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;

		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT ");
			sql.append("		a.INST_CD as INST_CD,");
			sql.append("		a.OBJ_CD as OBJ_CD,");
			sql.append("		a.FESTIVAL_CD as FESTIVAL_CD,");
			sql.append("		a.FESTIVAL_HALL_CD as FESTIVAL_HALL_CD,");
			sql.append("		a.INST_X as INST_X,");
			sql.append("		a.INST_Y as INST_Y,");
			sql.append("		b.SAVE_IMG_PATH as SAVE_IMG_PATH,");
			sql.append("		b.INST_SIZE as INST_SIZE");
			sql.append(" FROM");
			sql.append("		TB_SMU_INSTALLATION a, TB_INST_META b ");
			sql.append(" WHERE");
			sql.append("		a.INST_CD = b.INST_CD and a.FESTIVAL_HALL_CD=\'" + cd
					+ "\' ");
			sql.append(" ORDER BY	OBJ_CD ");

			System.out.println(sql.toString());

			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql.toString());

			json.put("list", covRs2JsonArray(rs));

			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	@SuppressWarnings("unchecked")
	public void getTB_AllBase() {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;

		try {
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT ");
			sql.append("		FESTIVAL_HALL_CD, ");
			sql.append("		FESTIVAL_CD, ");
			sql.append("		GRID_WIDTH, ");
			sql.append("		GRID_HEIGHT, ");
			sql.append("		GRID_CELL_SIZE, ");
			sql.append("		MAP_X, ");
			sql.append("		MAP_Y, ");
			sql.append("		SAVE_IMG_PATH, ");
			sql.append("		FESTIVAL_HALL_NM ");
			sql.append(" FROM ");
			sql.append("		TB_SMU_BASE ");

			// sql.append("SELECT ");
			// sql.append("		* ");
			// sql.append("FROM ");
			// sql.append("		TB_SMU_ROUTE ");

			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql.toString());

			json.put("list", covRs2JsonArray(rs));

			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	//
	public boolean insertInstData(String OBJ_CD, String FESTIVAL_CD,
			String FESTIVAL_HALL_CD, String INST_CD, int INST_X, int INST_Y) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;

		boolean ret = true;
		String sql = "";
		
		sql = sql
				+ " INSERT INTO TB_SMU_INSTALLATION(OBJ_CD, FESTIVAL_CD, FESTIVAL_HALL_CD, INST_CD, INST_X, INST_Y) ";
		sql = sql + " VALUES('" + OBJ_CD + "','" + FESTIVAL_CD + "','"
				+ FESTIVAL_HALL_CD + "','" + INST_CD + "','" + INST_X + "','"
				+ INST_Y + "')";

		System.out.println(sql);
		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);

			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

			ret = true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			ret = false;
		}

		return ret;
	}

	public boolean insertRouteData(String ROUTE_CD, String FESTIVAL_CD,
			String FESTIVAL_HALL_CD, int ROUTE_WIDTH, String ROUTE_COLOR,
			String ROUTE_TYPE, int START_POINT_X, int START_POINT_Y,
			int MID_POINT_X, int MID_POINT_Y, int END_POINT_X, int END_POINT_Y,
			String START_OBJ_CD, String MID_OBJ_CD, String END_OBJ_CD) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;

		boolean ret = true;
		String sql = "";

		sql = sql
				+ " INSERT INTO TB_SMU_ROUTE(ROUTE_CD, FESTIVAL_CD, FESTIVAL_HALL_CD, ROUTE_WIDTH, ROUTE_COLOR, ROUTE_TYPE, START_POINT_X, START_POINT_Y, MID_POINT_X, MID_POINT_Y, END_POINT_X, END_POINT_Y, START_OBJ_CD, MID_OBJ_CD, END_OBJ_CD ) ";
		sql = sql + " VALUES('" + ROUTE_CD + "','" + FESTIVAL_CD + "','"
				+ FESTIVAL_HALL_CD + "','" + ROUTE_WIDTH + "','" + ROUTE_COLOR
				+ "','" + ROUTE_TYPE + "','" + START_POINT_X + "','"
				+ START_POINT_Y + "','" + MID_POINT_X + "','" + MID_POINT_Y
				+ "','" + END_POINT_X + "','" + END_POINT_Y + "','"
				+ START_OBJ_CD + "','" + MID_OBJ_CD + "','" + END_OBJ_CD + "')";

		System.out.println(sql);
		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);

			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

			ret = true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			ret = false;
		}

		return ret;
	}

	@SuppressWarnings("unchecked")
	public boolean deleteInstFHCD(String cd) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;

		StringBuilder sql = new StringBuilder();
		sql.append("	DELETE FROM TB_SMU_INSTALLATION");
		sql.append(" WHERE");
		sql.append("		FESTIVAL_HALL_CD=\'" + cd + "\' ");

		System.out.println(sql.toString());

		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql.toString());

			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

			ret = true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			ret = false;
		}

		return ret;
	}

	@SuppressWarnings("unchecked")
	public boolean deleteRouteFHCD(String cd) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;

		StringBuilder sql = new StringBuilder();
		sql.append("	DELETE FROM TB_SMU_ROUTE");
		sql.append(" WHERE");
		sql.append("		FESTIVAL_HALL_CD=\'" + cd + "\' ");

		System.out.println(sql.toString());

		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql.toString());

			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

			ret = true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			ret = false;
		}

		return ret;
	}
	
	public boolean updateBaseFHCD(String fcd, String cd, int posX , int posY ) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;

		StringBuilder sql = new StringBuilder();
		sql.append("	UPDATE TB_SMU_BASE SET MAP_X=" + posX +",MAP_Y=" + posY +"" );
		sql.append(" WHERE FESTIVAL_HALL_CD=\'" + fcd + "\' and  FESTIVAL_CD=\'" + cd + "\'");

		System.out.println(sql.toString());

		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql.toString());

			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

			ret = true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			ret = false;
		}

		return ret;
	}

	public boolean updateBaseImgFHCD(String fcd, String cd, String imgData ) {
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		boolean ret = true;

		StringBuilder sql = new StringBuilder();
		sql.append("	UPDATE TB_SMU_BASE SET SAVE_IMG_PATH =\'" + imgData +"\'" );
		sql.append(" WHERE FESTIVAL_HALL_CD=\'" + fcd + "\' and  FESTIVAL_CD=\'" + cd + "\'");

		System.out.println(sql.toString());

		try {
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql.toString());

			if (stmt != null) {
				stmt.close();
			}
			dbo.SetConClose();

			ret = true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			ret = false;
		}

		return ret;
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray covRs2JsonArray(ResultSet rs) {

		JSONArray objList = new JSONArray();

		try {
			ResultSetMetaData rsmd = rs.getMetaData();
			int numColumns = rsmd.getColumnCount();

			while (rs.next()) {
				JSONObject obj = new JSONObject();
				for (int i = 1; i < numColumns + 1; i++) {

					String columnName = rsmd.getColumnName(i);
					if (rsmd.getColumnType(i) == java.sql.Types.ARRAY) {
						obj.put(columnName, rs.getArray(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.BIGINT) {
						obj.put(columnName, rs.getInt(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.BOOLEAN) {
						obj.put(columnName, rs.getBoolean(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.BLOB) {
						obj.put(columnName, rs.getBlob(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.DOUBLE) {
						obj.put(columnName, rs.getDouble(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.FLOAT) {
						obj.put(columnName, rs.getFloat(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.INTEGER) {
						obj.put(columnName, rs.getInt(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.NVARCHAR) {
						obj.put(columnName, rs.getNString(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.VARCHAR) {
						obj.put(columnName, rs.getString(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.TINYINT) {
						obj.put(columnName, rs.getInt(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.SMALLINT) {
						obj.put(columnName, rs.getInt(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.DATE) {
						obj.put(columnName, rs.getDate(i));
					} else if (rsmd.getColumnType(i) == java.sql.Types.TIMESTAMP) {
						obj.put(columnName, rs.getTimestamp(i));
					} else {
						obj.put(columnName, rs.getObject(i));
					}
				}

				objList.add(obj);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return objList;
	}

}
