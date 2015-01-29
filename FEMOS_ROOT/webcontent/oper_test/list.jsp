<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.*" %>
<%
	String path = request.getParameter("path")!=null ? request.getParameter("path").toString():"";
	String [] arr_path = path.split("-");
	
	int rn = request.getParameter("rn") != null ? Integer.parseInt(request.getParameter("rn")):0;
%>
<!DOCTYPE html >
<html>
<head>
<link rel='stylesheet' type='text/css' href='../css/common.css' />
<script type="text/javascript" src="../js/common.js"></script>   
<style type="text/css">
.tb_list table
{
	font-family:Dotum, Gulim, Gulim Arial, Helvetica, sans-serif;
	font-size:12px;
	background:#ddd;  
}
.tb_list th
{
	background:#ccc;
	line-height:15px;  
}
.tb_list td
{
	background:#fff;  
	line-height:15px;   
}
</style>
</head>
<body>
<form id="schedule_form" method="post">
<div id="wrap" style="width:1200px;margin: 0 auto;">
	<div style="width:800px;height:660px;border:1px solid #ccc;float:left;">
		<canvas width="800px" id="myCanvas" height="660px" />
		<script type="text/javascript">
			
			function init()
			{
				var canvas = document.getElementById('myCanvas');
				var context = canvas.getContext('2d');
				
				var obj_x_1 = 140;
				var obj_y_1 = 140;
	
				var obj_x_2 = 380;
				var obj_y_2 = 220;
	
				var obj_x_3 = 300;
				var obj_y_3 = 440;
	
				var obj_x_4 = 600;
				var obj_y_4 = 220;

				var obj_x_5 = 660;
				var obj_y_5 = 420;

				var obj_x_6 = 460;
				var obj_y_6 = 520;

				var obj_x_7 = 460;
				var obj_y_7 = 620;

				var obj_x_8 = 560;
				var obj_y_8 = 40;

				var obj_x_9 = 260;
				var obj_y_9 = 580;

				var obj_x_10 = 120;
				var obj_y_10 = 420;
				
				context.font = "18px dotum"; 
				context.fillStyle = "#0000cd";
				context.fillText("①행사장",obj_x_1,obj_y_1);
				
				context.fillStyle = "#008080";
				context.fillText("②행사장",obj_x_2,obj_y_2);

				context.fillStyle = "#b9062f";
				context.fillText("③행사장",obj_x_3,obj_y_3);

				context.fillStyle = "#800080";
				context.fillText("④행사장",obj_x_4,obj_y_4);

				context.fillStyle = "#f50ef5";
				context.fillText("⑤행사장",obj_x_5,obj_y_5);

				context.fillStyle = "#08fa38";
				context.fillText("⑥행사장",obj_x_6,obj_y_6);

				context.fillStyle = "#fa5508";
				context.fillText("⑦행사장",obj_x_7,obj_y_7);

				context.fillStyle = "#800080";
				context.fillText("⑧행사장",obj_x_8,obj_y_8);

				context.fillStyle = "#b9062f";
				context.fillText("⑨행사장",obj_x_9,obj_y_9);

				context.fillStyle = "#f50ef5";
				context.fillText("⑩행사장",obj_x_10,obj_y_10);
				
				
				context.beginPath();
				
				<%
				if (path.length() > 0)
				{
					for(int i = 0; i < arr_path.length-1; i++)
					{
				%>
						
						moveToLine(context,obj_x_<%=arr_path[i]%>,obj_y_<%=arr_path[i]%>);
				<%
						if(i <= arr_path.length)
						{
				%>
						drawLine(context,obj_x_<%=arr_path[i+1]%>,obj_y_<%=arr_path[i+1]%>);
				<%
						}
					}
				}
				%>
				context.stroke();
				
				
			}
			
			function moveToLine(ctx,x,y)
			{
				ctx.moveTo(x,y);
			}
			
			function drawLine(ctx,x,y)
			{
				ctx.lineTo(x,y);
			}	
			
			init();
		</script>
	</div>
	<div class="tb_list" style="width:380px;border:1px solid #ccc;float:right;margin-left:10px;">
		<table width="100%;" cellspacing="1" cellpadding="3">
			<colgroup>
				<col width="100px"/>
				<col width="*"/>
				<col width="100px"/>
			</colgroup>
			<tr>
				<th>순위</th>
				<th>경로</th>
				<th>건</th>
			</tr>
			<%
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null; 
			String row_bg = "";
			try{
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:FMOS", "scott", "tiger");
				
				String sql = "";
				sql = sql + "SELECT ROWNUM RN, PATH_OTHER,CNT FROM ";
				sql = sql + " ( ";
				sql = sql + "	SELECT PATH_OTHER,COUNT(REC_NUM) CNT FROM TMP_PATH_TEST GROUP BY PATH_OTHER ORDER BY CNT DESC ";
				sql = sql + " ) WHERE ROWNUM < 30 "; 
				
				stmt = conn.createStatement();
				
				rs = stmt.executeQuery(sql);
				
				while(rs.next())
				{
					if (rn == rs.getInt("RN"))
					{
						row_bg = "#eee";
					}
					else
					{
						row_bg = "#fff";
					}
			%>
			<tr>
				<td style="text-align:center;background:<%=row_bg %>"><%=rs.getInt("RN") %></td>
				<td style="text-align:left;background:<%=row_bg %>"><a href="list.jsp?rn=<%=rs.getInt("RN") %>&path=<%= rs.getString("PATH_OTHER")%>"><%=rs.getString("PATH_OTHER") %></a></td>
				<td style="text-align:right;background:<%=row_bg %>"><%=rs.getInt("CNT") %></td>
			</tr>
			<%
				}
				rs.close();
				stmt.close();
				conn.close();
			}catch(Exception e){}
			%>
		</table>
	</div>
	
</div>
</form>
</body>
</html>
