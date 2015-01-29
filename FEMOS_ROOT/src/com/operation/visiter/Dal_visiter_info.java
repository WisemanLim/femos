package com.operation.visiter;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import com.config.db.DBConnection;
import com.operation.visiter.Biz_visiter_info;

public class Dal_visiter_info 
{
	private Biz_visiter_info biz = null;
	private Vector v_list = null;
	
	public Dal_visiter_info()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
}
