<%@include file="../lib/session_chk.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.plan.smu.*" %>
<%@ page import="com.util.SmuUtil" %>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():""; 
	String festival_hall_cd = request.getParameter("festival_hall_cd") != null ? request.getParameter("festival_hall_cd") : "";
	
	Dal_smu_base smu = new Dal_smu_base();
	smu.get_smu_base_list(festival_cd);
	Vector base_list = smu.getV_list();
	
	
	if(base_list.size() > 0)
    { 
    	for(int i = 0; i < base_list.size(); i++)
    	{
    		Biz_smu_base obj = (Biz_smu_base)base_list.elementAt(i);
    		if(festival_hall_cd.length() == 0 && i == 0)
    		{
    			festival_hall_cd = obj.getFestival_hall_cd();
    		}
    	}
    }
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=session.getAttribute("FESTIVAL_NM") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>

<style type="text/css">
.temp{padding:8px}
.temp1{color:#09F}
.temp2{color:#F30}
.t_01{ color:#6FF; font-weight:bold}

</style>

<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',2);
	//setMenu('menu_img',2);
	
	$(".popup1").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});

	$(window).load(function(){init();});
	
});



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
<form id="form1" method="post" action="">



<div id="allwrap">
    <div id="header">
        <%@include file="../include/top.jsp" %>
    </div>
    <!--// id="header"-->
    <div id="leftmenu">
       <%@include file="../include/left.jsp" %>
    </div>
    <!--// id="leftmenu"-->
    
    <div id="bodywrap_ex">
        <div id="topmenu">
            <%@include file="../include/oper_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        <div id="contents" style="min-height:760px;"> 
            <div class="contitle">
                <h2><img src="../images/common/t24.gif" alt="" /></h2>
            </div>
            
 			<div class="contents1">
                 <%
	               
	            	Dal_smu_installation list = new Dal_smu_installation(); 
	            	list.getSmu_installation_list(festival_cd,festival_hall_cd);
	            	Vector v_list = list.getV_list();
	            	
	            	Dal_smu_route route_list = new Dal_smu_route(); 
	            	route_list.getSmu_route_list(festival_cd, festival_hall_cd);
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
	            	path_list.getSmu_installation_path(festival_cd,festival_hall_cd,path_info.replace("-",","));
	            	Vector v_path_list = path_list.getV_list();
                %>
                <script type="text/javascript">

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
                </script>
                <h3>
                	<select id="select_menu" name="select_menu" onchange="document.getElementById('form1').action=this.value;document.getElementById('form1').submit();">
	                	<option value="oper_04_main.jsp">관람객 동선현황</option>
	                	<option value="oper_04_main2.jsp" selected="selected">동선추천(최단거리기준)</option>
	                </select>
	               
					출발위치:
					<select id="start_point" name="start_point">
						<option value="">시작점 선택</option>
						<% 
						for(int i = 0; i < v_list.size(); i++)
						{ 
							Biz_smu_installation stp = (Biz_smu_installation)v_list.elementAt(i);
						%>
						<option value="<%=stp.getRn() %>" <%if(stp.getRn() == start_point){%>selected="selected" <%} %>><%= stp.getInst_nm() %></option>
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
						<option value="<%=etp.getRn() %>" <%if(etp.getRn() == end_point){%>selected="selected" <%} %>><%= etp.getInst_nm() %></option>
						<%
						} 
						%>
					</select>
					<input type="submit" value="경로검색" />
	            </h3>
	            <div class="area" style="float:left;padding:10px;">
                    <ul>
                        <%
                        String areaselect = "";
                        String festival_hall_nm = "";
                        int grid_width = 0;
                        int grid_height = 0;
                        
                        if(base_list.size() > 0)
                        { 
                        	for(int i = 0; i < base_list.size(); i++)
                        	{
                        		Biz_smu_base obj = (Biz_smu_base)base_list.elementAt(i);
                        		if(festival_hall_cd.length() == 0 && i == 0)
                        		{
                        			festival_hall_cd = obj.getFestival_hall_cd();
                        		}
                        		
                        		if(festival_hall_cd.equals(obj.getFestival_hall_cd()))
                        		{
                        			areaselect = "class='areaselect'";
                        			festival_hall_nm = obj.getFestival_hall_nm();
                        		}
                        		else
                        		{
                        			areaselect = "style='padding:10px;'";
                        		}
                        		
                        		grid_width = obj.getGrid_width();
                        		grid_height = obj.getGrid_height();
                        %>
                        <li>
                            <div <%=areaselect %>><a href="oper_04_main2.jsp?festival_cd=<%=obj.getFestival_cd() %>&festival_hall_cd=<%=obj.getFestival_hall_cd() %>"><%=obj.getFestival_hall_nm() %></a></div>
                        </li>
                        <%
                        	}
                        }
                        else
                        {
                        	grid_width = 600;
                        	grid_height = 600;
                        }
                        %>   
                    </ul>
                </div>
                <div style="width:<%=grid_width %>px;height:<%=grid_height %>px;border:1px solid #ccc;float:left;background:#fff;">
					<canvas width="<%=grid_width %>px" id="myCanvas" height="<%=grid_height %>px" />
				</div>
				<div style="clear:both"> </div>
            </div>
        </div> 
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>
</body>
</html>
