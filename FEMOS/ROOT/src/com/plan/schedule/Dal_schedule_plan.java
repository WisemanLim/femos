package com.plan.schedule;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.plan.schedule.Biz_schedule_plan;

public class Dal_schedule_plan 
{
	private Biz_schedule_plan biz = null;
	private Vector v_list = null;
	
	public Dal_schedule_plan() 
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getSchedule_detail_list(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT A.*,B.PROGRAM_DIV_NM,B.PROGRAM_NM,C.FESTIVAL_HALL_NM FROM TB_SCHEDULE_PLAN A ,  ";
			sql = sql + "(";
			sql = sql + "	SELECT AA.*,NVL(BB.CODE_NM,'') PROGRAM_DIV_NM FROM TB_PROGRAM AA LEFT OUTER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A10' AND MEAN_CODE <>'10000') BB  ";
			sql = sql + "	ON AA.PROGRAM_DIV = BB.CODE";
			sql = sql + ") B, ";
			sql = sql + "(SELECT * FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"') C ";
			sql = sql + "WHERE A.PROGRAM_CD = B.PROGRAM_CD(+) AND A.FESTIVAL_HALL_CD = C.FESTIVAL_HALL_CD ";
			sql = sql + "AND A.FESTIVAL_CD = '"+festival_cd+"'";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_schedule_plan();
				biz.setPk_id(rs.getInt("PK_ID"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setProgram_div_nm(rs.getString("PROGRAM_DIV_NM"));
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setProgram_nm(rs.getString("PROGRAM_NM"));
				biz.setAll_day_yn(rs.getString("ALL_DAY_YN"));
				biz.setSt_year(rs.getString("ST_YEAR"));
				biz.setSt_month(rs.getString("ST_MONTH"));
				biz.setSt_day(rs.getString("ST_DAY"));
				biz.setSt_hour(rs.getString("ST_HOUR"));
				biz.setSt_minute(rs.getString("ST_MINUTE"));
				biz.setEd_year(rs.getString("ED_YEAR"));
				biz.setEd_month(rs.getString("ED_MONTH"));
				biz.setEd_day(rs.getString("ED_DAY"));
				biz.setEd_hour(rs.getString("ED_HOUR"));
				biz.setEd_minute(rs.getString("ED_MINUTE"));
				biz.setSchedule_title(rs.getString("SCHEDULE_TITLE"));
				biz.setSchedule_content(rs.getString("SCHEDULE_CONTENT"));
				biz.setBg_color(rs.getString("BG_COLOR"));
				biz.setText_color(rs.getString("TEXT_COLOR")); 
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	public void getSchedule_list(String festival_cd,String festival_hall_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT A.*,B.PROGRAM_DIV_NM,B.PROGRAM_NM FROM TB_SCHEDULE_PLAN A , ";
			sql = sql + "(";
			sql = sql + "	SELECT AA.*,NVL(BB.CODE_NM,'') PROGRAM_DIV_NM FROM TB_PROGRAM AA LEFT OUTER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A10' AND MEAN_CODE <>'10000') BB ";
			sql = sql + "	ON AA.PROGRAM_DIV = BB.CODE";
			sql = sql + ") B ";
			sql = sql + "WHERE A.PROGRAM_CD = B.PROGRAM_CD(+) ";
			sql = sql + "AND A.FESTIVAL_CD = '"+festival_cd+"' AND FESTIVAL_HALL_CD = '"+festival_hall_cd+"'";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_schedule_plan();
				biz.setPk_id(rs.getInt("PK_ID"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setProgram_div_nm(rs.getString("PROGRAM_DIV_NM"));
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setProgram_nm(rs.getString("PROGRAM_NM"));
				biz.setAll_day_yn(rs.getString("ALL_DAY_YN"));
				biz.setSt_year(rs.getString("ST_YEAR"));
				biz.setSt_month(rs.getString("ST_MONTH"));
				biz.setSt_day(rs.getString("ST_DAY"));
				biz.setSt_hour(rs.getString("ST_HOUR"));
				biz.setSt_minute(rs.getString("ST_MINUTE"));
				biz.setEd_year(rs.getString("ED_YEAR"));
				biz.setEd_month(rs.getString("ED_MONTH"));
				biz.setEd_day(rs.getString("ED_DAY"));
				biz.setEd_hour(rs.getString("ED_HOUR"));
				biz.setEd_minute(rs.getString("ED_MINUTE"));
				biz.setSchedule_title(rs.getString("SCHEDULE_TITLE"));
				biz.setSchedule_content(rs.getString("SCHEDULE_CONTENT"));
				biz.setBg_color(rs.getString("BG_COLOR"));
				biz.setText_color(rs.getString("TEXT_COLOR")); 
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	
	public void getSchedule_list_all(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "";
			sql = sql + " SELECT A.*,B.PROGRAM_DIV_NM,B.PROGRAM_NM ,C.FESTIVAL_HALL_NM, ";
			sql = sql + " (SELECT COUNT(*) FROM TB_SCHEDULE_HR AA WHERE A.PK_ID = AA.PK_ID) HR_CNT ";
			sql = sql + " FROM TB_SCHEDULE_PLAN A ,  ";
			sql = sql + " ( ";
			sql = sql + "  	SELECT AA.*,NVL(BB.CODE_NM,'') PROGRAM_DIV_NM FROM TB_PROGRAM AA LEFT OUTER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A10' AND MEAN_CODE <>'10000') BB ";
			sql = sql + "  	ON AA.PROGRAM_DIV = BB.CODE ";
			sql = sql + " ) B, ";
			sql = sql + " (SELECT * FROM TB_SMU_BASE WHERE FESTIVAL_CD = '"+festival_cd+"') C ";
			sql = sql + " WHERE A.PROGRAM_CD = B.PROGRAM_CD(+) AND A.FESTIVAL_HALL_CD = C.FESTIVAL_HALL_CD ";
			sql = sql + " AND A.FESTIVAL_CD = '"+festival_cd+"'  ";
			sql = sql + " ORDER BY (ST_YEAR + ST_MONTH + ST_DAY + ST_HOUR + ST_MINUTE) ASC, ";
			sql = sql + " (ED_YEAR + ED_MONTH + ED_DAY + ED_HOUR + ED_MINUTE) ";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_schedule_plan();
				biz.setPk_id(rs.getInt("PK_ID"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setProgram_div_nm(rs.getString("PROGRAM_DIV_NM"));
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setProgram_nm(rs.getString("PROGRAM_NM"));
				biz.setAll_day_yn(rs.getString("ALL_DAY_YN"));
				biz.setSt_year(rs.getString("ST_YEAR"));
				biz.setSt_month(rs.getString("ST_MONTH"));
				biz.setSt_day(rs.getString("ST_DAY"));
				biz.setSt_hour(rs.getString("ST_HOUR"));
				biz.setSt_minute(rs.getString("ST_MINUTE"));
				biz.setEd_year(rs.getString("ED_YEAR"));
				biz.setEd_month(rs.getString("ED_MONTH"));
				biz.setEd_day(rs.getString("ED_DAY"));
				biz.setEd_hour(rs.getString("ED_HOUR"));
				biz.setEd_minute(rs.getString("ED_MINUTE"));
				biz.setSchedule_title(rs.getString("SCHEDULE_TITLE"));
				biz.setSchedule_content(rs.getString("SCHEDULE_CONTENT"));
				biz.setBg_color(rs.getString("BG_COLOR"));
				biz.setText_color(rs.getString("TEXT_COLOR")); 
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setHr_cnt(rs.getInt("HR_CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
	}
	
	
	
	public Biz_schedule_plan getSchedule_detail(int pk_id)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT A.*,B.PROGRAM_DIV_NM,B.PROGRAM_NM FROM TB_SCHEDULE_PLAN A , ";
			sql = sql + "(";
			sql = sql + "	SELECT AA.*,BB.CODE_NM PROGRAM_DIV_NM FROM TB_PROGRAM AA LEFT OUTER JOIN (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A10' AND MEAN_CODE <>'10000') BB ";
			sql = sql + "	ON AA.PROGRAM_DIV = BB.CODE";
			sql = sql + ") B ";
			sql = sql + "WHERE A.PROGRAM_CD = B.PROGRAM_CD(+) ";
			sql = sql + "AND PK_ID = "+pk_id;
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_schedule_plan();
				biz.setPk_id(rs.getInt("PK_ID"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setProgram_div_nm(rs.getString("PROGRAM_DIV_NM"));
				biz.setProgram_cd(rs.getString("PROGRAM_CD"));
				biz.setProgram_nm(rs.getString("PROGRAM_NM"));
				biz.setAll_day_yn(rs.getString("ALL_DAY_YN"));
				biz.setSt_year(rs.getString("ST_YEAR"));
				biz.setSt_month(rs.getString("ST_MONTH"));
				biz.setSt_day(rs.getString("ST_DAY"));
				biz.setSt_hour(rs.getString("ST_HOUR"));
				biz.setSt_minute(rs.getString("ST_MINUTE"));
				biz.setEd_year(rs.getString("ED_YEAR"));
				biz.setEd_month(rs.getString("ED_MONTH"));
				biz.setEd_day(rs.getString("ED_DAY"));
				biz.setEd_hour(rs.getString("ED_HOUR"));
				biz.setEd_minute(rs.getString("ED_MINUTE"));
				biz.setSchedule_title(rs.getString("SCHEDULE_TITLE"));
				biz.setSchedule_content(rs.getString("SCHEDULE_CONTENT"));
				biz.setBg_color(rs.getString("BG_COLOR"));
				biz.setText_color(rs.getString("TEXT_COLOR")); 
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return biz;
	}
	
	public int insertSchedule(	String festival_cd,
									String festival_hall_cd,
									String program_cd, 
									String all_day_yn,
									String st_year,
									String st_month,
									String st_day,
									String st_hour,
									String st_minute,
									String ed_year,
									String ed_month,
									String ed_day,
									String ed_hour,
									String ed_minute,
									String schedule_title,
									String schedule_content,
									String bg_color,
									String text_color
								)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		int pk_id = 0;
		
		
		String sql = "";
		
	
		
		try
		{
			sql = "SELECT NVL(MAX(PK_ID),0)+1 PK_ID FROM TB_SCHEDULE_PLAN ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				pk_id = rs.getInt("PK_ID");
			}
			
			sql = "INSERT INTO TB_SCHEDULE_PLAN(PK_ID,FESTIVAL_CD,FESTIVAL_HALL_CD,PROGRAM_CD,ALL_DAY_YN";
			sql = sql + ",ST_YEAR,ST_MONTH,ST_DAY,ST_HOUR,ST_MINUTE,ED_YEAR,ED_MONTH,ED_DAY,ED_HOUR,ED_MINUTE";
			sql = sql + ",SCHEDULE_TITLE,SCHEDULE_CONTENT,BG_COLOR,TEXT_COLOR";
			sql = sql + ") ";
			sql = sql + "VALUES";
			sql = sql + "(";
			sql = sql + pk_id;
			sql = sql + "	,'"+festival_cd+"','"+festival_hall_cd+"','"+program_cd+"','"+all_day_yn+"','"+st_year+"','"+st_month+"','"+st_day+"'";
			sql = sql + "	,'"+st_hour+"','"+st_minute+"','"+ed_year+"','"+ed_month+"','"+ed_day+"','"+ed_hour+"'";
			sql = sql + "	,'"+ed_minute+"','"+schedule_title+"','"+schedule_content+"','"+bg_color+"','"+text_color+"'";
			sql = sql + ")";
			
			System.out.println(sql);
			
			stmt = dbo.DbOpen().createStatement();
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		
		return pk_id;
	}
	
	
	public boolean updateSchedule(	int pk_id,
									String program_cd,
									String all_day_yn,
									String st_year,
									String st_month,
									String st_day,
									String st_hour,
									String st_minute,
									String ed_year,
									String ed_month,
									String ed_day,
									String ed_hour,
									String ed_minute,
									String schedule_title,
									String schedule_content,
									String bg_color,
									String text_color
								)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + "UPDATE TB_SCHEDULE_PLAN SET ";
		sql = sql + " PROGRAM_CD = '"+program_cd+"'";
		sql = sql + ",ALL_DAY_YN = '"+all_day_yn+"'";
		sql = sql + ",ST_YEAR = '"+st_year+"'";
		sql = sql + ",ST_MONTH = '"+st_month+"'";
		sql = sql + ",ST_DAY = '"+st_day+"'";
		sql = sql + ",ST_HOUR = '"+st_hour+"'";
		sql = sql + ",ST_MINUTE = '"+st_minute+"'";
		sql = sql + ",ED_YEAR = '"+ed_year+"'";
		sql = sql + ",ED_MONTH = '"+ed_month+"'";
		sql = sql + ",ED_DAY = '"+ed_day+"'";
		sql = sql + ",ED_HOUR = '"+ed_hour+"'";
		sql = sql + ",ED_MINUTE = '"+ed_minute+"'";
		sql = sql + ",SCHEDULE_TITLE = '"+schedule_title+"'";
		sql = sql + ",SCHEDULE_CONTENT = '"+schedule_content+"'";
		sql = sql + ",BG_COLOR = '"+bg_color+"'";
		sql = sql + ",TEXT_COLOR = '"+text_color+"'";
		sql = sql + " WHERE PK_ID = "+pk_id;
		
		
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
	
	public boolean deleteSchedule(int pk_id)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "DELETE FROM TB_SCHEDULE_PLAN WHERE PK_ID = "+pk_id;
		
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
	

	public boolean deleteSchedule_hr_by_pk_id(int pk_id)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "DELETE FROM TB_SCHEDULE_HR WHERE PK_ID = "+pk_id;
		
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
	
	
	public boolean updateSchedule_date(int pk_id,String div,String yyyy,String mm, String dd, String hh, String mi)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_SCHEDULE_PLAN SET ";
		sql = sql + div+"_YEAR = '"+yyyy+"',";
		sql = sql + div+"_MONTH = '"+mm+"',";
		sql = sql + div+"_DAY = '"+dd+"',";
		sql = sql + div+"_HOUR = '"+hh+"',";
		sql = sql + div+"_MINUTE = '"+mi+"'";
		sql = sql + " WHERE PK_ID = "+pk_id;
		
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
	
	public Biz_schedule_plan getAddDate(String yyyymmddhhmi,int addDay, int addMinute)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null; 
		
		try
		{
			String sql = "SELECT ";
			sql = sql + " TO_CHAR(TO_DATE(yyyymmddhhmi,'YYYYMMDDhh24mi'),'yyyy') YYYY,";
			sql = sql + " TO_CHAR(TO_DATE(yyyymmddhhmi,'YYYYMMDDhh24mi'),'mm') MM,";
			sql = sql + " TO_CHAR(TO_DATE(yyyymmddhhmi,'YYYYMMDDhh24mi'),'dd') DD,";
			sql = sql + " TO_CHAR(TO_DATE(yyyymmddhhmi,'YYYYMMDDhh24mi'),'hh24') HH,";
			sql = sql + " TO_CHAR(TO_DATE(yyyymmddhhmi,'YYYYMMDDhh24mi'),'mi') MI ";
			sql = sql + " FROM ";
			sql = sql + " ( ";
			sql = sql + " 	SELECT TO_CHAR(TO_DATE('"+yyyymmddhhmi+"','YYYYMMDDhh24mi') + (1 / 1440 * (1440 * "+addDay+" + "+addMinute+")),'yyyymmddhh24mi') yyyymmddhhmi FROM DUAL  ";
			sql = sql + " ) ";
			
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_schedule_plan();
				
				biz.setYyyy(rs.getString("YYYY"));
				biz.setMm(rs.getString("MM"));
				biz.setDd(rs.getString("DD"));
				biz.setHh(rs.getString("HH"));
				biz.setMi(rs.getString("MI"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return biz;
	}
	
	public boolean insertSchedule_hr(int pk_id, String pk_no, String festival_cd, String festival_hall_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " INSERT INTO TB_SCHEDULE_HR(REC_NUM,PK_ID,PK_NO,FESTIVAL_CD,FESTIVAL_HALL_CD) ";
		sql = sql + " SELECT NVL(MAX(REC_NUM),0)+1, "+pk_id+",'"+pk_no+"','"+festival_cd+"','"+festival_hall_cd+"' FROM TB_SCHEDULE_HR ";
		
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
	
	
}
