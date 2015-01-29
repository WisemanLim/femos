<%@include file="../lib/session_chk.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.plan.smu.Dal_smu_base" %>
<%@ page import="com.plan.smu.Biz_smu_base" %>
<%@ page import="com.plan.smu.*" %>
<%@ page import="com.util.SmuUtil" %>
<%@ page import="com.operation.route.Dal_route_trace" %>
<%@ page import="com.operation.route.Biz_route_trace" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():""; 
	String festival_hall_cd = request.getParameter("festival_hall_cd") != null ? request.getParameter("festival_hall_cd") : "";
	
	Dal_smu_base smu = new Dal_smu_base();
	smu.get_smu_base_list(festival_cd);
	Vector base_list = smu.getV_list();
	
	
	String path = request.getParameter("path")!=null ? request.getParameter("path").toString():"";
	
	int rn = request.getParameter("rn") != null ? Integer.parseInt(request.getParameter("rn")):0;
	
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

</script>
</head>

<body>
<form id="form1" method="post" action="">

<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />

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
                <h3>
	                <select id="select_menu" name="select_menu" onchange="document.getElementById('form1').action=this.value;document.getElementById('form1').submit();">
	                	<option value="oper_04_main.jsp" selected="selected">관람객 동선현황</option>
	                	<option value="oper_04_main2.jsp">동선추천(최단거리기준)</option>
	                </select>
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
                            <div <%=areaselect %>><a href="oper_04_main.jsp?festival_cd=<%=obj.getFestival_cd() %>&festival_hall_cd=<%=obj.getFestival_hall_cd() %>"><%=obj.getFestival_hall_nm() %></a></div>
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
                <%
	               	Dal_smu_installation list = new Dal_smu_installation(); 
		           	list.getSmu_installation_list(festival_cd,festival_hall_cd);
		           	Vector v_list = list.getV_list();
		           	
		            
		           	Dal_smu_installation path_list = new Dal_smu_installation(); 
		        	if(path.length() > 0)
		        	{
		           		path_list.getSmu_installation_path_ex(festival_cd,festival_hall_cd,path);
		        	}
		        	Vector v_path_list = path_list.getV_list();
		           	
                %>
                <div style="border:1px solid #ccc;float:left;margin-left:10px;">
					<canvas width="<%=grid_width %>px" id="myCanvas" height="<%=grid_height %>px" style="background:#fff;"/>
					<script type="text/javascript">
						
						function init()
						{ 
							var canvas = document.getElementById('myCanvas');
							var context = canvas.getContext('2d');
							var img = new Image();
							
							<%
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
							
							%>
							context.beginPath();
							//##여기에서 라인그리기 시작
							<%
							if(v_path_list.size() > 0)
							{
							%>				
								setLineColor(context,"blue");
								setLineWidth(context,6);
								context.lineCap = "round"; 
								context.lineJoin = "round"; 
								
							<%
								for(int i = 0; i < v_path_list.size(); i++)
								{
						
									Biz_smu_installation obj_path = (Biz_smu_installation)v_path_list.elementAt(i);
							%>
									context.font = "16px impact";
									context.fillStyle = "red";
									context.fillText("("+<%=i+1%>+")", <%=obj_path.getInst_x()+10%>, <%=obj_path.getInst_y()+(i*8)%>); 
																	
							<%			
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
							}
							%>
							//##라인그리기 종료
							context.stroke();
							context.closePath();
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
						
						init();
					</script>
				</div>
				<div style="width:480px;float:left;margin-left:10px;">
					<table class="table1" width="100%;" cellspacing="1" cellpadding="3">
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
							Dal_route_trace route = new Dal_route_trace();
							route.getRoute_trace_list(festival_cd,festival_hall_cd,20);
							Vector route_list = route.getV_list();
							String row_bg = "";
							if(route_list.size() > 0)
							{
								for(int i = 0; i < route_list.size(); i++)
								{
									Biz_route_trace route_obj = (Biz_route_trace)route_list.elementAt(i);
									if(route_obj.getRn() == rn)
									{
										row_bg = "background:#ccc";
									}
									else
									{
										row_bg = "";
									}
						%>
						<tr>
							<td style="text-align:center;<%=row_bg %>"><%=route_obj.getRn() %></td>
							<td style="text-align:left;<%=row_bg %>"><a href="oper_04_main.jsp?festival_cd=<%=festival_cd %>&festival_hall_cd=<%=festival_hall_cd %>&rn=<%=route_obj.getRn() %>&path=<%= route_obj.getPath()%>"><%=route_obj.getPath_nm() %></a></td>
							<td style="text-align:right;<%=row_bg %>"><%=route_obj.getCnt() %></td>
						</tr>
						<%
								}
							}
							else
							{
						%>
						<tr>
							<td colspan="3">동선 정보가 없습니다.</td>
						</tr>
						<%
							}
						%>
					</table>
				</div>
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
