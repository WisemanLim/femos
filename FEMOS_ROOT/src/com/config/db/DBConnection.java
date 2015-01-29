package com.config.db;

import java.util.Properties;
import java.sql.*;
import java.io.*;

public class DBConnection 
{
	private Connection conn = null;
	private InputStream is = null;
	
	String drivers = null,url = null,user = null,password = null;
	
	public Connection DbOpen()
	{
		Properties prop = new Properties();
		try{	
			is = getClass().getResourceAsStream("db.properties");			
			prop.load(is);
			
			if(is!=null) is.close();  
			drivers = prop.getProperty("drivers"); 
			url = prop.getProperty("url");
			user = prop.getProperty("user");
			password = prop.getProperty("password");
			
	        Class.forName(drivers);
	        
	        conn = DriverManager.getConnection(url, user, password);
	        
		}catch(Exception e){System.out.print(e);}
		return conn;
	}
	
	public void SetConClose() throws SQLException
	{
		if(!this.conn.isClosed())
		{
			this.conn.close();
		}
	}
}
