<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

Connection conn = null;
Statement stmt = null;
try{
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:FMOS", "scott", "tiger");
	
	stmt = conn.createStatement();
	
	String sql = "";
	sql = "DELETE FROM TMP_PATH_TEST";
	out.println("쿼리실행:"+sql+"<br/>");
	stmt.executeUpdate(sql);
	
	String strN = "";
	
	for (int i = 1; i <= 10000; i++)
	{
		strN = "";
		for (int j = 1; j <= 10; j++) 
		{
	    	int n = (int) (Math.random() * 10) + 1;
	    	
	    	strN = strN + "-"+Integer.toString(n);	
		}
		
		sql = "INSERT INTO TMP_PATH_TEST(REC_NUM,PATH_OTHER) VALUES((SELECT NVL(MAX(REC_NUM),0)+1 FROM TMP_PATH_TEST),'"+strN.substring(1,strN.length())+"')";
		stmt.executeUpdate(sql);
		//out.println(strN.substring(1,strN.length())+"<br/>");
	}
	
	stmt.close();
	conn.close();
}catch(Exception e){}

%>