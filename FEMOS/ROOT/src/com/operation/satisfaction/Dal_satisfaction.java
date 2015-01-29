package com.operation.satisfaction;

import java.sql.*;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.satisfaction.Biz_satisfaction;

public class Dal_satisfaction 
{
	Biz_satisfaction biz = null;
	Vector v_list = null;
	
	public Dal_satisfaction()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public int getSatisfaction_count(String festival_cd,String strWhere)
	{
		int ret = 0;
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = " SELECT COUNT(*) REC_CNT ";
		sql = sql + " FROM TB_VISITER_INFO A ";
		sql = sql + " INNER JOIN ";
		sql = sql + " TBL_SATISFACTION B ";
		sql = sql + " ON A.VISITER_ID = B.VISITER_ID ";
		sql = sql + " INNER JOIN ";
		sql = sql + " TB_SMU_BASE C ";
		sql = sql + " ON B.FESTIVAL_HALL_CD = C.FESTIVAL_HALL_CD ";
		sql = sql + " WHERE B.FESTIVAL_CD = '"+festival_cd+"' " + strWhere;
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				ret = rs.getInt("REC_CNT");
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
		return ret;
	}
	
	public void getSatisfaction_list(String festival_cd,String strWhere,int intStartPoint,int intEndPoint)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT * ";
		sql = sql + " FROM ";
		sql = sql + " ( ";
		sql = sql + " 	SELECT ROWNUM AS RNUM,A.*,B.FESTIVAL_CD,B.REC_NUM,B.FESTIVAL_HALL_CD, ";
		sql = sql + "	C.FESTIVAL_HALL_NM,B.GRADE,to_char(to_date(B.SATISFIED_YMD,'yyyy-mm-dd'),'yyyy-mm-dd') SATISFIED_YMD, ";
		sql = sql + "	CASE WHEN GRADE = 1 THEN 'O' ELSE '' END GRADE_1, ";
		sql = sql + "	CASE WHEN GRADE = 2 THEN 'O' ELSE '' END GRADE_2, ";
		sql = sql + "	CASE WHEN GRADE = 3 THEN 'O' ELSE '' END GRADE_3, ";
		sql = sql + "	CASE WHEN GRADE = 4 THEN 'O' ELSE '' END GRADE_4, ";
		sql = sql + "	CASE WHEN GRADE = 5 THEN 'O' ELSE '' END GRADE_5 ";
		sql = sql + " 	FROM TB_VISITER_INFO A ";
		sql = sql + " 	INNER JOIN ";
		sql = sql + " 	TBL_SATISFACTION B ";
		sql = sql + " 	ON A.VISITER_ID = B.VISITER_ID ";
		sql = sql + " 	INNER JOIN ";
		sql = sql + " 	TB_SMU_BASE C ";
		sql = sql + " 	ON B.FESTIVAL_HALL_CD = C.FESTIVAL_HALL_CD ";
		sql = sql + " 	WHERE B.FESTIVAL_CD = '"+festival_cd+"' "+strWhere;
		sql = sql + "	AND ROWNUM <= "+Integer.toString(intStartPoint);
		sql = sql + " 	ORDER BY B.REC_NUM DESC ";
		sql = sql +	" ) AA ";
		sql = sql + " WHERE RNUM >= "+Integer.toString(intEndPoint)+" ORDER BY RNUM DESC ";
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				biz = new Biz_satisfaction();
				
				biz.setRnum(rs.getInt("RNUM"));
				biz.setVisiter_id(rs.getString("VISITER_ID"));
				biz.setVisiter_nm(rs.getString("VISITER_NM"));
				biz.setSex(rs.getString("SEX"));
				biz.setHp(rs.getString("HP"));
				biz.setEmail(rs.getString("EMAIL"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setGrade(rs.getInt("GRADE"));
				biz.setSatisfied_ymd(rs.getString("SATISFIED_YMD"));
				biz.setGrade_1(rs.getString("GRADE_1"));
				biz.setGrade_2(rs.getString("GRADE_2"));
				biz.setGrade_3(rs.getString("GRADE_3"));
				biz.setGrade_4(rs.getString("GRADE_4"));
				biz.setGrade_5(rs.getString("GRADE_5"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	public void getSatisfaction_stat(String festival_cd)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + " SELECT A.FESTIVAL_CD,A.FESTIVAL_HALL_CD,A.FESTIVAL_HALL_NM, ";
		sql = sql + " NVL(SUM(GRADE_1_CNT),0) GRADE_1_CNT, ";
		sql = sql + " NVL(SUM(GRADE_2_CNT),0) GRADE_2_CNT, ";
		sql = sql + " NVL(SUM(GRADE_3_CNT),0) GRADE_3_CNT, ";
		sql = sql + " NVL(SUM(GRADE_4_CNT),0) GRADE_4_CNT, ";
		sql = sql + " NVL(SUM(GRADE_5_CNT),0) GRADE_5_CNT, ";
		sql = sql + " COUNT(B.REC_NUM) CNT ";
		sql = sql + " FROM TB_SMU_BASE A ";
		sql = sql + " LEFT OUTER JOIN ";
		sql = sql + " (";
		sql = sql + " 	SELECT REC_NUM,FESTIVAL_CD,FESTIVAL_HALL_CD, ";
		sql = sql + " 		CASE WHEN GRADE = 1 THEN 1 ELSE 0 END GRADE_1_CNT, ";
		sql = sql + " 		CASE WHEN GRADE = 2 THEN 1 ELSE 0 END GRADE_2_CNT, ";
		sql = sql + " 		CASE WHEN GRADE = 3 THEN 1 ELSE 0 END GRADE_3_CNT, ";
		sql = sql + " 		CASE WHEN GRADE = 4 THEN 1 ELSE 0 END GRADE_4_CNT, ";
		sql = sql + " 		CASE WHEN GRADE = 5 THEN 1 ELSE 0 END GRADE_5_CNT  ";
		sql = sql + " 	FROM TBL_SATISFACTION ";
		sql = sql + " ) B  ";
		sql = sql + " ON A.FESTIVAL_CD = B.FESTIVAL_CD AND A.FESTIVAL_HALL_CD = B.FESTIVAL_HALL_CD ";
		sql = sql + " WHERE A.FESTIVAL_CD = '"+festival_cd+"' GROUP BY A.FESTIVAL_CD,A.FESTIVAL_HALL_CD,A.FESTIVAL_HALL_NM";
		
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				biz = new Biz_satisfaction();
				
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setFestival_hall_cd(rs.getString("FESTIVAL_HALL_CD"));
				biz.setFestival_hall_nm(rs.getString("FESTIVAL_HALL_NM"));
				biz.setGrade_1_cnt(rs.getInt("GRADE_1_CNT"));
				biz.setGrade_2_cnt(rs.getInt("GRADE_2_CNT"));
				biz.setGrade_3_cnt(rs.getInt("GRADE_3_CNT"));
				biz.setGrade_4_cnt(rs.getInt("GRADE_4_CNT"));
				biz.setGrade_5_cnt(rs.getInt("GRADE_5_CNT"));
				biz.setCnt(rs.getInt("CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
}
