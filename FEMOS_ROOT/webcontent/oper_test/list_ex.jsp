<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.plan.smu.*" %>
<%@ page import="com.util.SmuUtil" %>
<%
	String festival_hall_cd = "FSH10001";
	Dal_smu_installation list = new Dal_smu_installation(); 
	list.getSmu_installation_list(festival_hall_cd);
	Vector v_list = list.getV_list();
	
	Dal_smu_route route_list = new Dal_smu_route(); 
	route_list.getSmu_route_list(festival_hall_cd);
	Vector v_route_list = route_list.getV_list();
	
	
	
	//다익스트라 알고리즘을 이용한 최단경로를 검색한다.
	int distance = 0;
	int [][] arr_distance = new int[v_list.size()][v_list.size()];
	
	for(int i = 0; i< v_list.size(); i++)
	{
		Biz_smu_installation dis = (Biz_smu_installation)v_list.elementAt(i);
		for(int j = 0; j < v_list.size(); j++)
		{
			Biz_smu_installation dis_sub = (Biz_smu_installation)v_list.elementAt(j);
			if(dis.getObj_cd() == dis_sub.getObj_cd())
			{
				distance = 0;
			}
			else
			{
				distance = route_list.getStartBtweenEndDistance(dis.getObj_cd(), dis_sub.getObj_cd());
				if(distance == 0)
				{
					distance = 10000;
				}
			}
			arr_distance[i][j] = distance;
		}
	}
	
	int start_point = request.getParameter("start_point")!=null?Integer.parseInt(request.getParameter("start_point")):1;
	int end_point = request.getParameter("end_point")!=null?Integer.parseInt(request.getParameter("end_point")):1;
	
	String path_info = SmuUtil.getObjRoutePath(arr_distance,start_point,end_point);
	String [] arr_draw_path = path_info.split("-");
	
	Dal_smu_installation path_list = new Dal_smu_installation(); 
	path_list.getSmu_installation_path(festival_hall_cd,path_info.replace("-",","));
	Vector v_path_list = path_list.getV_list();
	
%>
<!DOCTYPE html >
<html>
<head>
<link rel='stylesheet' type='text/css' href='../css/common.css' />
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
<script type="text/javascript" src="../js/common.js"></script>   
<script type="text/javascript" src="../js/jquery.min.js"></script>   
<script type="text/javascript">
$(function() {	
	$(window).load(function(){init();});
});

function init()
{
	var canvas = document.getElementById('myCanvas');
	var context = canvas.getContext('2d');
	var img = new Image();
	
	context.beginPath();
	
	<%
	if(v_route_list.size() > 0)
	{
		for(int i = 0; i < v_route_list.size(); i++)
		{
			Biz_smu_route route = (Biz_smu_route)v_route_list.elementAt(i);	
	%>
	context.beginPath();
	setLineColor(context,"<%=route.getRoute_color()%>");
	setLineWidth(context,<%=route.getRoute_width()%>);
	moveToLine(context,<%=route.getStart_point_x()%>,<%=route.getStart_point_y()%>);
	drawLine(context,<%=route.getEnd_point_x()%>,<%=route.getEnd_point_y()%>);
	context.stroke();
	context.closePath();
	
	//context.fillText("거리:<%=route.getDistance()%>",<%=route.getStart_point_x()%>,<%=route.getStart_point_y()%>);
	<%
		}
	}
	if(v_list.size() > 0)
	{
		for(int i = 0; i < v_list.size(); i++)
		{
			Biz_smu_installation obj = (Biz_smu_installation)v_list.elementAt(i);
			
	%>
	img.src = "../images/meta_img/<%=obj.getSave_img_path() %>";
	context.drawImage(img,<%=obj.getInst_x()%>,<%=obj.getInst_y()%>);
	
	<%
		}
	}
	if(v_path_list.size() > 0)
	{
	%>
		context.beginPath();
		setLineColor(context,"#000000");
		setLineWidth(context,4);
	<%
		for(int i = 0; i < v_path_list.size(); i++)
		{
			Biz_smu_installation obj_path = (Biz_smu_installation)v_path_list.elementAt(i);
			
			if(i == 0)
			{
	%>
				moveToLine(context,<%=obj_path.getInst_x()%>,<%=obj_path.getInst_y()%>);
	<%
			}
			else
			{
	%>
				drawLine(context,<%=obj_path.getInst_x()%>,<%=obj_path.getInst_y()%>);	
	<%
			}
		}
	%>
		context.stroke();
		context.closePath();
	<%
	}
	%>
}

function moveToLine(ctx,x,y)
{
	ctx.moveTo(x,y);
}

function drawLine(ctx,x,y)
{
	ctx.lineTo(x,y);
}

function setLineWidth(ctx,width)
{
	ctx.lineWidth = width;
}

function setLineColor(ctx,color)
{
	ctx.strokeStyle = color;
}

</script>
</head>
<body>

<form id="schedule_form" method="post">
<div id="wrap" style="width:1200px;margin: 0 auto;">
	<div style="width:800px;height:660px;border:1px solid #ccc;float:left;">
		<canvas width="800px" id="myCanvas" height="660px" />
	</div>
	<div style="clear:both"> </div>
	<div>
		출발위치:
		<select id="start_point" name="start_point">
			<option value="">시작점 선택</option>
			<% 
			for(int i = 0; i < v_list.size(); i++)
			{ 
				Biz_smu_installation stp = (Biz_smu_installation)v_list.elementAt(i);
			%>
			<option value="<%=i+1 %>" <%if(i+1 == start_point){%>selected="selected" <%} %>><%= stp.getInst_nm() %></option>
			<%
			} 
			%>
		</select>
		도착위치: 
		<select id="end_point" name="end_point">
			<option value="">도착점 선택</option>
			<% 
			for(int i = 0; i < v_list.size(); i++)
			{ 
				Biz_smu_installation etp = (Biz_smu_installation)v_list.elementAt(i);
			%>
			<option value="<%=i+1 %>" <%if(i+1 == end_point){%>selected="selected" <%} %>><%= etp.getInst_nm() %></option>
			<%
			} 
			%>
		</select>
		<input type="submit" value="경로검색" />
	</div>
	
	<div style="clear:both"> </div>
	
</div>
</form>
</body>
</html>
