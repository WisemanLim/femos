<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
<%@page import="java.sql.*, javax.sql.*, java.io.*" %>
</head>
<body>
<h1>JDBC Test</h1>

<%
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
	while (rset.next()) {
		out.println(rset.getString("user_mail_addr") + ", " + rset.getString("rec_num") + ", " + rset.getString("q_num") + ", " + rset.getString("q_text") + ", " + rset.getString("list_num") + "</br>");
	}
	rset.close();
	pstmt.close();
	conn.close();
%>
</body>
</html>
