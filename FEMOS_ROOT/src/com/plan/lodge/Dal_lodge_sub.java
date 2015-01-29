package com.plan.lodge;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.lodge.Biz_lodge_sub;

public class Dal_lodge_sub {
	
	private Biz_lodge_sub biz = null;
	private Vector v_list = null;
	
	public Dal_lodge_sub()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public boolean insertLodge_sub(String lodge_no,String festival_cd,String room_nm, String team_nm, int male_cnt, int fmale_cnt, String st_ymd, String ed_ymd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_LODGE_SUB(REC_NUM,LODGE_NO,FESTIVAL_CD,ROOM_NM,TEAM_NM,MALE_CNT,FMALE_CNT,ST_YMD,ED_YMD) ";
		sql = sql + " SELECT NVL(MAX(REC_NUM),0)+1,'"+lodge_no+"','"+festival_cd+"','"+room_nm+"','"+team_nm+"',"+male_cnt+","+fmale_cnt+",'"+st_ymd+"','"+ed_ymd+"' ";
		sql = sql + " FROM TB_LODGE_SUB WHERE FESTIVAL_CD = '"+festival_cd+"' AND LODGE_NO = '"+lodge_no+"' ";
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public boolean updateLodge_sub(int rec_num, String room_nm, String team_nm, int male_cnt, int fmale_cnt, String st_ymd, String ed_ymd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_LODGE_SUB SET ROOM_NM = '"+room_nm+"', TEAM_NM = '"+team_nm+"' , MALE_CNT = "+male_cnt+", FMALE_CNT = "+fmale_cnt+", ";
		sql = sql + " ST_YMD = '"+st_ymd+"', ED_YMD = '"+ed_ymd+"'  ";
		sql = sql + " WHERE REC_NUM = "+rec_num;
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	
	public boolean deleteLodge_sub(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " DELETE FROM TB_LODGE_SUB WHERE REC_NUM = "+rec_num;
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			ret = true;
			
		}catch(Exception e){System.out.println(e.getMessage());ret = false;}
		
		return ret;
	}
	
	public void getLodge_subList(String festival_cd,String lodge_no)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = " SELECT A.*,TO_CHAR(TO_DATE(ST_YMD,'yyyy-mm-dd'),'yyyy-mm-dd') V_ST_YMD, TO_CHAR(TO_DATE(ED_YMD,'yyyy-mm-dd'),'yyyy-mm-dd') V_ED_YMD ";
			sql = sql + " FROM TB_LODGE_SUB A WHERE FESTIVAL_CD = '"+festival_cd+"' AND LODGE_NO = '"+lodge_no+"' ORDER BY REC_NUM DESC ";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_lodge_sub();
				
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setLodge_no(rs.getString("LODGE_NO"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setRoom_nm(rs.getString("ROOM_NM"));
				biz.setTeam_nm(rs.getString("TEAM_NM"));
				biz.setMale_cnt(rs.getInt("MALE_CNT"));
				biz.setFmale_cnt(rs.getInt("FMALE_CNT"));
				biz.setSt_ymd(rs.getString("V_ST_YMD"));
				biz.setEd_ymd(rs.getString("V_ED_YMD"));
					
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
}
