package com.plan.layout;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import com.config.db.DBConnection;
import com.plan.layout.Biz_route_base;


public class Dal_route_base {
	private Biz_route_base biz = null;
	private JSONObject json = null;
	private JSONArray jsonArray = null;
	private Vector v_list = null;
	
	public Dal_route_base()
	{
		v_list = new Vector();
		json = new JSONObject();
		jsonArray = new JSONArray();
	}
	
	public JSONObject getJSON()
	{
		return json;
	}
	public JSONArray getJSONS()
	{
		return jsonArray;
	}
	
	public Vector getV_list()
	{
		return v_list;
	}

	@SuppressWarnings("unchecked")
	public void getTB_InstMeta()
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
		    StringBuilder sql = new StringBuilder();
		    sql.append("SELECT ");
		    sql.append("		INST_CD, ");
		    sql.append("		INST_TYPE, ");
		    sql.append("		INST_NM, ");
		    sql.append("		INST_SIZE, ");
		    sql.append("		INST_UNIT, ");
		    sql.append("		USER_LIMIT, ");
		    sql.append("		SAVE_IMG_PATH ");
		    sql.append("FROM ");
		    sql.append("		TB_INST_META ");

			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql.toString());
			
			json.put("list", covRs2JsonArray(rs));
            
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
		}catch(Exception e){System.out.println(e.getMessage());}
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray covRs2JsonArray( ResultSet rs ){
		
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
