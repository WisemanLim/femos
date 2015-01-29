package com.operation.ivt;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import com.config.db.DBConnection;
import com.operation.ivt.Biz_ivt_info;

public class Dal_ivt_info 
{
	private Biz_ivt_info biz = null;
	private Vector v_list = null;
	
	public Dal_ivt_info()
	{
		v_list = new Vector();
	}
	
	public Vector getV_list()
	{
		return v_list;
	}
	
	public void getIvt_list_stat(String festival_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = " SELECT A.CODE IVT_DIV,A.CODE_NM IVT_DIV_NM,NVL(CNT,0) CNT FROM  ";
		sql = " (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A70' AND MEAN_CODE <> '10000') A,  ";
		sql = " (SELECT IVT_DIV,COUNT(*) CNT FROM TB_IVT_INFO WHERE FESTIVAL_CD = 'FES10001' GROUP BY IVT_DIV) B ";
		sql = " WHERE A.CODE = B.IVT_DIV(+) ";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_ivt_info();
				
				biz.setIvt_div(rs.getString("IVT_DIV"));
				biz.setIvt_div_nm(rs.getString("IVT_DIV_NM"));
				biz.setCnt(rs.getInt("CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	public void getIvtDiv_list_stat(String festival_cd,String ivt_div)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + " SELECT A.CODE PROC_STATE_CD,A.CODE_NM PROC_STATE_NM,NVL(CNT,0) CNT FROM  ";
		sql = sql + " (SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A80' AND MEAN_CODE <> '10000') A,  ";
		sql = sql + " (SELECT PROC_STATE_CD,COUNT(*) CNT FROM TB_IVT_INFO WHERE FESTIVAL_CD = '"+festival_cd+"' AND IVT_DIV = '"+ivt_div+"' GROUP BY PROC_STATE_CD) B ";
		sql = sql + " WHERE A.CODE = B.PROC_STATE_CD(+) ORDER BY SORT_SEQ ASC ";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_ivt_info();
				
				biz.setProc_state_cd(rs.getString("PROC_STATE_CD"));
				biz.setProc_state_nm(rs.getString("PROC_STATE_NM"));
				biz.setCnt(rs.getInt("CNT"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	
	
	public int getIvt_count(String festival_cd,String strWhere)
	{
		int ret = 0;
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT COUNT(*) REC_CNT FROM TB_IVT_INFO WHERE FESTIVAL_CD = '"+festival_cd+"' "+strWhere; 
		System.out.println(sql);
		try
		{
			stmt = dbo.DbOpen().createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next())
			{
				ret = rs.getInt("REC_CNT");
				System.out.println(ret);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
		return ret;
	}
	
	
	public void getIvt_list(String festival_cd,int intStartPoint,int intEndPoint,String strWhere)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = "SELECT * ";
		sql = sql + " FROM ";
		sql = sql + " (";
		sql = sql + "	SELECT ROWNUM AS RNUM,A.*,B.CODE_NM IVT_DIV_NM,C.CODE_NM PROC_STATE_NM FROM ";
		sql = sql + "	(SELECT * FROM TB_IVT_INFO WHERE FESTIVAL_CD = '"+festival_cd+"' ORDER BY REC_NUM ASC ) A, ";
		sql = sql + "	(SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A70' AND MEAN_CODE <> '10000') B, ";
		sql = sql + "	(SELECT * FROM TB_CODE WHERE CODE_GROUP = 'A80' AND MEAN_CODE <> '10000') C ";
		sql = sql + "	WHERE A.IVT_DIV = B.CODE AND A.PROC_STATE_CD = C.CODE "+ strWhere;
		sql = sql + "	AND ROWNUM <= "+Integer.toString(intStartPoint);
		sql = sql + "	ORDER BY A.REC_NUM DESC ";
		sql = sql + " ) AA";
		sql = sql + " WHERE RNUM >= "+Integer.toString(intEndPoint)+" ORDER BY RNUM DESC ";
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_ivt_info();
				
				biz.setRn(rs.getInt("RNUM"));
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setHp_no(rs.getString("HP_NO"));
				biz.setIvt_div(rs.getString("IVT_DIV"));
				biz.setIvt_div_nm(rs.getString("IVT_DIV_NM"));
				biz.setTitle(rs.getString("TITLE")!=null?rs.getString("TITLE"):"");
				biz.setContent(rs.getString("CONTENT"));
				biz.setAttach_file(rs.getString("ATTACH_FILE")!=null?rs.getString("ATTACH_FILE"):"");
				biz.setReg_dt(rs.getString("REG_DT"));
				biz.setProc_state_cd(rs.getString("PROC_STATE_CD"));
				biz.setProc_state_nm(rs.getString("PROC_STATE_NM"));
				
				v_list.add(biz);
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
	}
	
	public Biz_ivt_info getIvt_detail(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "";
		
		sql = sql + "SELECT * FROM TB_IVT_INFO WHERE REC_NUM = "+rec_num;
		
		System.out.println(sql);
		try 
		{
			stmt = dbo.DbOpen().createStatement();   
			rs = stmt.executeQuery(sql); 
			while(rs.next())
			{
				biz = new Biz_ivt_info();
				
				biz.setRec_num(rs.getInt("REC_NUM"));
				biz.setFestival_cd(rs.getString("FESTIVAL_CD"));
				biz.setHp_no(rs.getString("HP_NO"));
				biz.setIvt_div(rs.getString("IVT_DIV"));
				biz.setTitle(rs.getString("TITLE")!=null?rs.getString("TITLE"):"");
				biz.setContent(rs.getString("CONTENT"));
				biz.setAttach_file(rs.getString("ATTACH_FILE")!=null?rs.getString("ATTACH_FILE"):"");
				biz.setReg_dt(rs.getString("REG_DT"));
				biz.setProc_state_cd(rs.getString("PROC_STATE_CD"));
				
			}
			if(rs!=null){rs.close();}
			if(stmt!=null){stmt.close();}
			dbo.SetConClose();
		}
		catch(Exception e){}
		return biz;
	}
	
	public boolean insert_ivt(String festival_cd, String hp_no, String ivt_div, String content, String attach_file,String proc_state_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + "INSERT INTO TB_IVT_INFO(REC_NUM,FESTIVAL_CD,HP_NO,IVT_DIV,CONTENT,ATTACH_FILE,PROC_STATE_CD) ";
		sql = sql + "SELECT NVL(MAX(REC_NUM),0)+1,'"+festival_cd+"','"+hp_no+"','"+ivt_div+"','"+content+"','"+attach_file+"','"+proc_state_cd+"' FROM TB_IVT_INFO ";
		
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
	
	public boolean delete_ivt(int rec_num)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + "DELETE FROM TB_IVT_INFO WHERE REC_NUM = "+rec_num;
		
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
	
	
	public boolean change_proc_state_cd(int rec_num, String proc_state_cd)
	{
		DBConnection dbo = new DBConnection();
		Statement stmt = null;
		
		boolean ret = true;
		String sql = "";
		
		sql = sql + " UPDATE TB_IVT_INFO SET PROC_STATE_CD = '"+proc_state_cd+"' WHERE REC_NUM = "+rec_num;
		
		
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
