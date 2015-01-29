<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.research.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String sv_id = request.getParameter("sv_id");
	Biz_research base_obj = new Dal_research().getDetailResearch_base(sv_id);
	
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num")):0;
	
	Biz_research_q_item q_item;
	
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

<style>
.temp{padding:8px}
.temp1{color:#09F}
.temp2{color:#F30}
.t_01{ color:#6FF; font-weight:bold}
</style>
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',2);
	setMenu('menu_img',5);
	
});


function show_layout_form(obj_id)
{
	for(var i = 0; i < $(".popup1").length; i++)
	{
		$(".popup1").eq(i).hide();
		$("#"+obj_id).show(500);
	}
}

function hide_layout_form(obj_id)
{
	$("#"+obj_id).hide(500);
}

</script>
</head>

<body>
<form id="form1" method="post" action="research_list.jsp">

<div id="allwrap">
    <div id="header">
        <%@include file="../include/top.jsp" %>
    </div>
    <!--// id="header"-->
    <div id="leftmenu">
       <%@include file="../include/left.jsp" %>
    </div>
    <!--// id="leftmenu"-->
    
    <div id="bodywrap">
        <div id="topmenu">
            <%@include file="../include/oper_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        <div id="contents"> 
            
            <div class="contitle">
                <h2><img src="../images/common/t_24.gif" alt="설문조사"/></h2>
            </div>
 			<div class="contents1">
                <h3><%=base_obj.getSv_title() %> 통계</h3>
                <div style="width:890px">
                	<div style="color:#bbb;padding:10px;float:left;">※ 각 설문항목을 클릭하면 해당 항목에 대한 통계수치를 볼수 있습니다.</div>
                	<div style="color:#bbb;padding:10px;float:right;">
                		<a href="research_list.jsp"><img src="../images/btn/list.gif" alt="목록"/></a>
                	</div>
                </div>
                <table  class="table1">
                	<colgroup>
                		<col width="400px"/>
                		<col width="500px"/>
                		<col width="*"/>
                	</colgroup>
                	<tr>
                		<th>설문그룹</th>
                		<th>설문항목</th>
                		<th>&nbsp;</th>
                	</tr>
                	<%
	                	Dal_research_stat research_stat = new Dal_research_stat();
	                	research_stat.getResearch_q_item_list(sv_id);
	                	Vector v_list = research_stat.getV_list();
	                	
	                	if(v_list.size() > 0)
	                	{
	                		for(int i = 0; i < v_list.size(); i++)
	                		{
	                			Biz_research_stat obj = (Biz_research_stat)v_list.elementAt(i);	
                	%>
                	<tr>
                		<td style="text-align:left;<%if(rec_num == obj.getRec_num()){ %>background:#aaeeaa;<%} %>"><%=obj.getSv_group_nm() %></td>
                		<td style="text-align:left;<%if(rec_num == obj.getRec_num()){ %>background:#aaeeaa;<%} %>"><a href="research_stat.jsp?sv_id=<%=sv_id %>&rec_num=<%=obj.getRec_num() %>"><%=obj.getQ_text() %></a></td>
                		<td>&nbsp;</td>
                	</tr>
                	<%
	                		}
	                	}
	                	else
	                	{
                	%>
                	<tr>
                		<td colspan="2">등록 된 설문항목이 없습니다.</td>
                		<td>&nbsp;</td>
                	</tr>
                	<%
	                	}
                	%>
                </table>
            </div>
           	
        </div>
        
        <div style="clear:both"> </div> 
       	
       	<%
       	String GraphCol = ""; 
		String GraphData = "";
		
       	if(rec_num != 0) 
       	{
       	%>
       	
		<div style="margin-top:10px;">
			<select id="graph_type">
				<option value="column">세로막대</option>
				<option value="bar">가로막대</option>
			</select>
		</div>
       	<div id="container" style="float:left;width:500px;margin-top:10px;"></div>
       	
       	<%
       		q_item = new Dal_research_q_item().getResearch_q_item_Detail(rec_num);
       		if(q_item.getSelect_method().equals("0") || q_item.getSelect_method().equals("3"))
       		{
       			
       	%>
       	
       	<div style="float:left;width:400px; margin-top:10px;">
       		<table class="table1">
				<colgroup>
					<col width="*" />
					<col width="100px" />
				</colgroup>
				<tr>
					<th>선택항목</th>
					<th>선택건수</th>
				</tr>
				<%
					Dal_research_stat stat = new Dal_research_stat();
					stat.getResearch_q_item_stat_select_method_0(rec_num);
					Vector v_stat_list = stat.getV_list();
					if(v_stat_list.size() > 0)
					{
						for(int i = 0; i < v_stat_list.size(); i++)
						{
							Biz_research_stat stat_obj = (Biz_research_stat)v_stat_list.elementAt(i);
				%>
				<tr>
					<td style="text-align:left;"><%=stat_obj.getA_text() %></td>
					<td><%=stat_obj.getCnt() %></td>
				</tr>     
				<%
						}	
					}
					else
					{
				%>	
				<tr>
					<td colspan="2">등록 된 선택항목이 없습니다.</td>
				</tr>
				<%
					}
				%>	
       		</table>	
       	</div>
       	<script type="text/javascript" src="./jquery.min.js"></script>
		<script type="text/javascript" src="./highcharts.js"></script>
		<!--[if IE]>
		<script type="text/javascript" src="./excanvas.compiled.js"></script>	
		<![endif]-->
        <script type="text/javascript">
				
				$(document).ready(function() {
										
						function init_graph(type)
						{
							var chart = new Highcharts.Chart({
											chart: {
												renderTo: 'container',
												defaultSeriesType: type
											},
											title: {
												text: '<%=q_item.getQ_text()%>'
											},
											subtitle: {
												text: ''
											},
											xAxis: {
												categories: ['선택건수']
											},
											yAxis: {
												min: 0,
												title: {
												text: ''
												}
											},
											legend: {
												layout: 'vertical',
												align: 'right',
												backgroundColor: '#FFFFFF',
												style: {
													left: '100px',
													top: '70px',
													bottom: 'auto'
												}
											},
											tooltip: {

												formatter: function() {
													return '<b>'+ this.series.name +'</b><br/>'+
														this.x +': '+ this.y +'';
												}
											},
											plotOptions: {
												column: {
													pointPadding: 0.2,
													borderWidth: 1,
													dataLabels: {
														enabled: true
													}
												}
											},
											series: [
											<%
											if(v_stat_list.size() > 0)
											{
												for(int i = 0; i < v_stat_list.size(); i++)
												{
													Biz_research_stat stat_obj = (Biz_research_stat)v_stat_list.elementAt(i);
											%>
													{
														name: '<%=stat_obj.getA_text()%>',
														data: [<%=stat_obj.getCnt()%>]
													}
													<%
														if(i < v_stat_list.size())
														{
													%>
													,
													<%		
														}
													%>
											<%
												}
											}
											%>
											]
									});
								}
								
								init_graph('column');

								$('#graph_type').bind('change',
									function (event){
										init_graph($('#graph_type').val());
									}
								)

				});
				</script>
     	
       	<%
       		}
       	}	
       	%>
     
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>
</body>
</html>
