package com.operation.medical;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.config.db.DBConnection;
import com.operation.medical.Biz_medical;
import com.operation.research.Biz_research;

public class Dal_medical {

	private Biz_medical biz = null;
	private Vector v_list = null;
	
	public Dal_medical()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public int insertMedical(String festival_cd,String s_name,int s_age,String s_sex,String s_addr,String s_tel,String p_name,int p_age,String p_sex,String p_addr,
			String p_tel, String symptom,String handle,String pic_path,String m_name,int m_age,String m_sex,String m_tel)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		int rec_num = 0;
		
		try
		{
		
			sql = "SELECT NVL(MAX(REC_NUM),0)+1 REC_NUM FROM TB_MEDICAL ";
			
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			
			while(rs.next())
			{
				rec_num = rs.getInt("REC_NUM");
			}
			
			sql = "INSERT INTO TB_MEDICAL(REC_NUM,FESTIVAL_CD,S_NAME,S_AGE,S_SEX,S_ADDR,S_TEL,P_NAME,P_AGE,P_SEX,P_ADDR,P_TEL,SYMPTOM,HANDLE,REG_YMD,";
			sql = sql + "PIC_PATH,M_NAME,M_AGE,M_SEX,M_TEL) VALUES("+rec_num+",'"+festival_cd+"','"+s_name+"',"+s_age+",'"+s_sex+"','"+s_addr+"',";
			sql = sql +"'"+s_tel+"','"+p_name+"',"+p_age+",'"+p_sex+"','"+p_addr+"','"+p_tel+"','"+symptom+"','"+handle+"',to_char(sysdate,'YYYYMMDD'),";
			sql = sql + "'"+pic_path+"','"+m_name+"',"+m_age+",'"+m_sex+"','"+m_tel+"')";
			
			System.out.println(sql);
			stmt.executeUpdate(sql);
			
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return rec_num;
	}
	
	public boolean updateMedical(int rec_num,String s_name,int s_age,String s_sex,String s_addr,String s_tel,String p_name,int p_age,String p_sex,String p_addr,
			String p_tel, String symptom,String handle,String pic_path,String m_name,int m_age,String m_sex,String m_tel)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = false;
		String sql = "";
		
		try
		{
			stmt = dbo.DbOpen().createStatement();   
			
			sql = "UPDATE TB_MEDICAL SET S_NAME = '"+s_name+"', S_AGE = "+s_age+", S_SEX = '"+s_sex+"',S_ADDR = '"+s_addr+"',S_TEL = '"+s_tel+"',";
			sql = sql + "P_NAME = '"+p_name+"',P_AGE = "+p_age+", P_SEX = '"+p_sex+"',P_ADDR = '"+p_addr+"',P_TEL = '"+p_tel+"',SYMPTOM = '"+symptom+"',";
			sql = sql + "HANDLE = '"+handle+"',";
			
			if (pic_path.length() > 0)
			{
				sql = sql + "PIC_PATH = '"+pic_path+"',";
			}
			sql = sql + "M_NAME = '"+m_name+"', M_AGE = "+m_age+", M_SEX = '"+m_sex+"', M_TEL = '"+m_tel+"' ";
			sql = sql + "WHERE REC_NUM = "+rec_num;
			
			System.out.println(sql);
			stmt.executeUpdate(sql);
			ret = true;
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return ret;
	}
	
	public boolean deleteMedical(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = false;
		String sql = "";
		
		try
		{
			stmt = dbo.DbOpen().createStatement();   
			
			sql = "DELETE FROM TB_MEDICAL WHERE REC_NUM = "+rec_num;
			
			System.out.println(sql);
			stmt.executeUpdate(sql);
			ret = true;
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
			
			
		}catch(Exception e){System.out.println(e.getMessage());}
		
		return ret;
	}
	
	
	public Biz_medical getDetailMedical(int rec_num)
	{
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT A.*,TO_DATE(REG_YMD,'YYYY-MM-DD') V_REG_YMD FROM TB_MEDICAL A WHERE REC_NUM = "+rec_num;
			
			System.out.println(sql);
			stmt = dbo.DbOpen().createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				biz = new Biz_medical();
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setS_name(rs.getString("S_NAME"));
				biz.setS_age(rs.getInt("S_AGE"));
				biz.setS_sex(rs.getString("S_SEX"));
				biz.setS_addr(rs.getString("S_ADDR"));
				biz.setS_tel(rs.getString("S_TEL"));
				biz.setP_name(rs.getString("P_NAME"));
				biz.setP_age(rs.getInt("P_AGE"));
				biz.setP_sex(rs.getString("P_SEX"));
				biz.setP_addr(rs.getString("P_ADDR"));
				biz.setP_tel(rs.getString("P_TEL"));
				biz.setSymptom(rs.getString("SYMPTOM"));
				biz.setHandle(rs.getString("HANDLE"));
				biz.setReg_ymd(rs.getString("V_REG_YMD"));
				biz.setPic_path(rs.getString("PIC_PATH"));
				biz.setM_name(rs.getString("M_NAME"));
				biz.setM_age(rs.getInt("M_AGE"));
				biz.setM_sex(rs.getString("M_SEX"));
				biz.setM_tel(rs.getString("M_TEL"));
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){System.out.println(e.getMessage());}
		
		return biz;
		
	}

	public int getMedical_list_count(String strWhere)
	{
		int ret = 0;
		
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;  
		
		try
		{

			String sql = " SELECT COUNT(*) REC_CNT FROM ";
			sql = sql + " ( SELECT * FROM TB_MEDICAL ) MAIN " + strWhere;
			
			
			System.out.println(sql);
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
		catch(Exception e){System.out.println(e.getMessage());}
		
		return ret;
	}
	
	public void getMedical_list(int intStartPoint,int intEndPoint,String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT   * ";
		sql = sql + "		FROM (SELECT ROWNUM AS RNUM, A.* ";
		sql = sql + "				FROM (SELECT *,to_date(REG_YMD,'YYYYMMDD') V_REG_YMD FROM TB_MEDICAL " + strWhere + " ORDER BY REC_NUM ASC ) A ";
		sql = sql + "			   WHERE ROWNUM <= "+Integer.toString(intStartPoint)+") ";
		sql = sql + "	   WHERE RNUM >= "+Integer.toString(intEndPoint) + " ORDER BY RNUM DESC ";
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_medical();
				
				biz.setRn(rs.getInt("RNUM"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setS_name(rs.getString("S_NAME"));
				biz.setS_age(rs.getInt("S_AGE"));
				biz.setS_addr(rs.getString("S_ADDR"));
				biz.setS_sex(rs.getString("S_SEX"));
				biz.setS_tel(rs.getString("S_TEL"));
				biz.setP_name(rs.getString("P_NAME"));
				biz.setP_age(rs.getInt("P_AGE"));
				biz.setP_addr(rs.getString("P_ADDR"));
				biz.setP_sex(rs.getString("P_SEX"));
				biz.setP_tel(rs.getString("P_TEL"));
				biz.setM_name(rs.getString("M_NAME"));
				biz.setM_age(rs.getInt("M_AGE"));
				biz.setM_sex(rs.getString("M_SEX"));
				biz.setM_tel(rs.getString("M_TEL"));
				biz.setSymptom(rs.getString("SYMPTOM"));
				biz.setHandle(rs.getString("HANDLE"));
				biz.setReg_ymd(rs.getString("V_REG_YMD"));
				biz.setPic_path(rs.getString("PIC_PATH"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
}


