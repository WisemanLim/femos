package com.plan.smu;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.smu.Biz_smu_installation;

public class Dal_smu_installation
{
	private Biz_smu_installation biz = null;
	private Vector v_list = null;
	
	public Dal_smu_installation()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getSmu_installation_list(String festival_cd, String festival_hall_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT ROWNUM SORT_RN,AA.* FROM ";
			sql = sql + " ( ";
			sql = sql + "SELECT rownum RN, A.*,B.INST_NM,B.SAVE_IMG_PATH FROM TB_SMU_INSTALLATION A INNER JOIN TB_INST_META B ";
			sql = sql + " ON A.INST_CD = B.INST_CD WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"' ORDER BY A.OBJ_CD ASC ";
			sql = sql + "  ) AA ";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_installation();
				biz.setRn(rs.getInt("SORT_RN"));
				biz.setObj_cd(rs.getString("OBJ_CD"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setInst_cd(rs.getString("INST_CD"));
				biz.setInst_nm(rs.getString("INST_NM"));
				biz.setSave_img_path(rs.getString("SAVE_IMG_PATH"));
				biz.setInst_x(rs.getInt("INST_X"));
				biz.setInst_y(rs.getInt("INST_Y"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	/*
	public void getSmu_installation_path(String festival_cd,String festival_hall_cd,String path)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		String arr_path [] = path.split(",");
		
		
		try
		{
			String sql = "SELECT B.* FROM  ";
			sql = sql + " ( ";
			for(int i = 0; i < arr_path.length; i++)
			{
				sql = sql + " 	SELECT "+arr_path[i]+" RN,"+i+" SEQ, '"+festival_cd+"' FESTIVAL_CD,'"+festival_hall_cd+"' FESTIVAL_HALL_CD,'' INST_CD,0 INST_X,0 INST_Y FROM DUAL ";
				if(i < arr_path.length-1)
				{
					sql = sql + " UNION ALL ";
				}
			}
			sql = sql + " ) A,";
			sql = sql + " ( ";
			sql = sql + "  SELECT * FROM ";
			sql = sql + "  (SELECT rownum RN,OBJ_CD,FESTIVAL_CD,FESTIVAL_HALL_CD,INST_CD,INST_X,INST_Y FROM TB_SMU_INSTALLATION WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"' ORDER BY OBJ_CD) ";
			sql = sql + "  WHERE RN in("+path+") ";
			sql = sql + " ) B ";
			sql = sql + " WHERE A.RN = B.RN ORDER BY A.RN,A.SEQ ASC ";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_installation();
				
				biz.setObj_cd(rs.getString("OBJ_CD"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setInst_cd(rs.getString("INST_CD"));
				biz.setInst_x(rs.getInt("INST_X"));
				biz.setInst_y(rs.getInt("INST_Y"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}*/
	
	public void getSmu_installation_path(String festival_cd,String festival_hall_cd,String path)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		String arr_path [] = path.split(",");
		
		
		try
		{
			String sql = "SELECT B.* FROM  ";
			sql = sql + " ( ";
			for(int i = 0; i < arr_path.length; i++)
			{
				sql = sql + " 	SELECT "+arr_path[i]+" RN,"+i+" SEQ, '"+festival_cd+"' FESTIVAL_CD,'"+festival_hall_cd+"' FESTIVAL_HALL_CD,'' INST_CD,0 INST_X,0 INST_Y FROM DUAL ";
				if(i < arr_path.length-1)
				{
					sql = sql + " UNION ALL ";
				}
			}
			sql = sql + " ) A,";
			sql = sql + " ( ";
			sql = sql + "  SELECT ROWNUM SORT_RN,AA.* FROM  ";
			sql = sql + "  (SELECT rownum RN, A.*,B.INST_NM,B.SAVE_IMG_PATH FROM TB_SMU_INSTALLATION A INNER JOIN TB_INST_META B ON A.INST_CD = B.INST_CD WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'  ORDER BY A.OBJ_CD ASC ) AA ";
			sql = sql + " ) B ";
			sql = sql + " WHERE A.RN = B.SORT_RN  ORDER BY A.SEQ ASC  ";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_installation();
				
				biz.setObj_cd(rs.getString("OBJ_CD"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setInst_cd(rs.getString("INST_CD"));
				biz.setInst_x(rs.getInt("INST_X"));
				biz.setInst_y(rs.getInt("INST_Y"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	public void getSmu_installation_path_2(String festival_cd,String festival_hall_cd,String path)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			
			String sql = "SELECT * FROM ";
			sql = sql + " (SELECT rownum RN,OBJ_CD,FESTIVAL_CD,FESTIVAL_HALL_CD,INST_CD,INST_X,INST_Y FROM TB_SMU_INSTALLATION WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"' ORDER BY OBJ_CD ASC ) ";
			sql = sql + " WHERE OBJ_CD in("+path+") ORDER BY OBJ_CD ASC ";
			
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_installation();
				
				biz.setObj_cd(rs.getString("OBJ_CD"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setInst_cd(rs.getString("INST_CD"));
				biz.setInst_x(rs.getInt("INST_X"));
				biz.setInst_y(rs.getInt("INST_Y"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	
	public void getSmu_installation_path_ex(String festival_cd,String festival_hall_cd,String path)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		String arr_path [] = path.split(",");
		
		try
		{
			
			String sql = "SELECT RN,BB.OBJ_CD,INST_X,INST_Y FROM ";
			sql = sql + " ( ";
			for(int i = 0; i < arr_path.length; i++)
			{
				sql = sql + " 	SELECT "+i+" RN ,'"+arr_path[i]+"' OBJ_CD,'"+festival_cd+"','"+festival_hall_cd+"','',0,0 FROM DUAL A_"+i;
				if(i < arr_path.length-1)
				{
					sql = sql + " UNION ALL ";
				}
			}
			sql = sql + "  ) AA, ";
			sql = sql + " (SELECT OBJ_CD,FESTIVAL_CD,FESTIVAL_HALL_CD,INST_CD,INST_X,INST_Y FROM TB_SMU_INSTALLATION WHERE FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"') BB ";
			sql = sql + " WHERE AA.OBJ_CD = BB.OBJ_CD ";
			sql = sql + " ORDER BY RN ASC ";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_smu_installation();
				
				biz.setObj_cd(rs.getString("OBJ_CD"));
				biz.setInst_x(rs.getInt("INST_X"));
				biz.setInst_y(rs.getInt("INST_Y"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	
	
}
