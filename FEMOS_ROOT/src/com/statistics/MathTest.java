package com.statistics;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.math3.stat.descriptive.DescriptiveStatistics;

public class MathTest {

	/**
	 * @param args
	 * @throws SQLException 
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@hbsys98.vps.phps.kr:1521:FEMOS", "hbsys" , "hbsys2012");
			
			String query = ""; // "select * from sv_user_info where rownum <= ? ";
			query = "SELECT B.USER_MAIL_ADDR AS USER_MAIL_ADDR, A.REC_NUM AS REC_NUM/*, A.SV_ID AS SV_ID*/ "
				  + "  , A.Q_NUM AS Q_NUM, A.Q_TEXT AS Q_TEXT "
				  + "  , B.LIST_NUM AS LIST_NUM/*, B.CNT AS CNT*/ "
				  + "FROM SV_Q_ITEM A, ( "
				  + "SELECT USER_MAIL_ADDR, REC_NUM, LIST_NUM/*, COUNT(LIST_NUM) AS CNT*/ "
				  + "FROM SV_A_RESULT "
				  + "/*GROUP BY REC_NUM, LIST_NUM*/ "
				  + "ORDER BY REC_NUM "
				  + ") B "
				  + "WHERE A.REC_NUM = B.REC_NUM "
				  + "  AND A.SV_ID = 1002 "
				  + "  AND A.REC_NUM = 6 "
				  + "ORDER BY REC_NUM, USER_MAIL_ADDR ";
			//String query="INSERT INTO test  (t1, t2, t3, t4, t5)   VALUES   (LPAD(SEQ_test.NEXTVAL, 1, '0'), ?, ?,TO_DATE(SYSDATE,'YYYY/MM/DD'),TO_DATE(SYSDATE,'YYYY/MM/DD')) ";
			
			PreparedStatement pstmt = conn.prepareStatement(query);
			//pstmt.setInt(1, 10);
			
			//pstmt.setString(1, "Y");
			//pstmt.setString(2, "aa");
						
			System.out.println(query);
			ResultSet rset = pstmt.executeQuery();
			//int rset = pstmt.executeUpdate();
//				double inputArray[] = {0.1, 0.2, 3, 4, 5};
			// Get a DescriptiveStatistics instance
			DescriptiveStatistics stats = new DescriptiveStatistics();
			
			// Add the data from the array
			while (rset.next()) {
				stats.addValue(Double.parseDouble(rset.getString("list_num")));
				System.out.println(rset.getString("user_mail_addr") + ", " + rset.getString("rec_num") + ", " + rset.getString("q_num") + ", " + rset.getString("q_text") + ", " + rset.getString("list_num"));
			}
			rset.close();
			pstmt.close();
			conn.close();
			
			// Compute some statistics
			System.out.println("==" + stats.getGeometricMean() + ", " + stats.getKurtosis()
					+ "," + stats.getMax() + "," + stats.getMean() + "," + stats.getMin()
					+ "," + stats.getPercentile(5) + "," + stats.getPopulationVariance()
					+ "," + stats.getSkewness() + "," + stats.getStandardDeviation()
					+ "," + stats.getSum() + "," + stats.getSumsq()
					+ "," + stats.getVariance()	+ "," + stats.getWindowSize());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		}
	}

}
