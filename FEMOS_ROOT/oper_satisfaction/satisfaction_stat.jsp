<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.satisfaction.Biz_satisfaction" %>
<%@ page import="com.operation.satisfaction.Dal_satisfaction" %>
<%@ page import="com.plan.smu.Biz_smu_base" %>
<%@ page import="com.plan.smu.Dal_smu_base" %>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	Dal_satisfaction satisfaction = new Dal_satisfaction();
	satisfaction.getSatisfaction_stat(festival_cd);
	Vector v_list = satisfaction.getV_list();
	
	String graph_col = "";
	String grade_1_data = "";
	String grade_2_data = "";
	String grade_3_data = "";
	String grade_4_data = "";
	String grade_5_data = "";
	
	for(int i = 0; i < v_list.size(); i++)
	{
		Biz_satisfaction obj = (Biz_satisfaction)v_list.elementAt(i);
		
		graph_col = graph_col + "'"+obj.getFestival_hall_nm()+"',";
		grade_1_data = grade_1_data + obj.getGrade_1_cnt()+",";
		grade_2_data = grade_2_data + obj.getGrade_2_cnt()+",";
		grade_3_data = grade_3_data + obj.getGrade_3_cnt()+",";
		grade_4_data = grade_4_data + obj.getGrade_4_cnt()+",";
		grade_5_data = grade_5_data + obj.getGrade_5_cnt()+",";
	}
	
	graph_col = graph_col.substring(0,graph_col.length()-1);
	grade_1_data = grade_1_data.substring(0,grade_1_data.length()-1);
	grade_2_data = grade_2_data.substring(0,grade_2_data.length()-1);
	grade_3_data = grade_3_data.substring(0,grade_3_data.length()-1);
	grade_4_data = grade_4_data.substring(0,grade_4_data.length()-1);
	grade_5_data = grade_5_data.substring(0,grade_5_data.length()-1);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<style>
.temp{padding:8px}
.temp1{color:#09F}
.temp2{color:#F30}
.t_01{ color:#6FF; font-weight:bold}
</style>
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',2);
	setMenu('menu_img',3);
	
	$(".popup1").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});
});
</script>
</head>

<body>
<form id="form1" method="post" action="satisfaction_main.jsp">

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
    
    <div id="bodywrap">
        <div id="topmenu">
            <%@include file="../include/oper_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        <div id="contents"> 
			
            <div class="contitle">
                <h2><img src="../images/common/t_23.gif"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>축제 행사장 평가 통계</h3>
                <div style="padding:10px;">
	                <div>
						<select id="graph_type">
							<option value="column">세로막대</option>
							<option value="bar">가로막대</option>
						</select>
					</div>
	                <div id="container" style="width:800px;height:340px;border:1px solid #ccc;"></div>
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
												text: ''
											},
											subtitle: {
												text: ''
											},
											xAxis: {
												categories: [<%=graph_col%>]
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
													{
														name: '매우만족',
														data: [<%=grade_1_data%>]
													},
													{
														name: '만족',
														data: [<%=grade_2_data%>]
													}
													,
													{
														name: '보통',
														data: [<%=grade_3_data%>]
													}
													,
													{
														name: '불만',
														data: [<%=grade_4_data%>]
													}
													,
													{
														name: '매우불만',
														data: [<%=grade_5_data%>]
													}
													
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
               	<div style="width:800px;padding:10px;">
	                <table  class="table1">
	                    <colgroup>
		                    <col width="*"/>
		                    <col width="80px"/>
		                    <col width="80px"/>
		                    <col width="80px"/>
		                    <col width="80px"/>
		                    <col width="80px"/>
		                    <col width="80px"/>
	                    </colgroup>
	                    <tr>
	                        <th>행사장</th>
	                        <th>매우만족</th>
	                        <th>만족</th>
	                        <th>보통</th>
	                        <th>불만</th>
	                        <th>매우불만</th>
	                        <th>참여수</th>
	                    </tr>
	                    <%
	                    int tot_grade_1 = 0;
	                    int tot_grade_2 = 0;
	                    int tot_grade_3 = 0;
	                    int tot_grade_4 = 0;
	                    int tot_grade_5 = 0;
	                    int tot_cnt = 0;
	                    if(v_list.size() > 0)
	                    {
	                    	for(int i = 0; i < v_list.size(); i++)
	                    	{
	                    		Biz_satisfaction obj = (Biz_satisfaction)v_list.elementAt(i);
	                    		
	                    		tot_grade_1 = tot_grade_1 + obj.getGrade_1_cnt();
	                    		tot_grade_2 = tot_grade_2 + obj.getGrade_2_cnt();
	                    		tot_grade_3 = tot_grade_3 + obj.getGrade_3_cnt();
	                    		tot_grade_4 = tot_grade_4 + obj.getGrade_4_cnt();
	                    		tot_grade_5 = tot_grade_5 + obj.getGrade_5_cnt();
	                    		tot_cnt = tot_cnt + obj.getCnt();
	                    %>
	                    <tr>
	                    	<td><%=obj.getFestival_hall_nm() %></td>
	                    	<td><%=obj.getGrade_1_cnt() %></td>
	                    	<td><%=obj.getGrade_2_cnt() %></td>
	                    	<td><%=obj.getGrade_3_cnt() %></td>
	                    	<td><%=obj.getGrade_4_cnt() %></td>
	                    	<td><%=obj.getGrade_5_cnt() %></td>
	                    	<td><%=obj.getCnt() %></td>
	                    </tr>	
	                    <%
	                    	}
	                    %>
	                    <tr>
	                    	<th>합계</th>
	                    	<td><%= tot_grade_1 %></td>
	                    	<td><%= tot_grade_2 %></td>
	                    	<td><%= tot_grade_3 %></td>
	                    	<td><%= tot_grade_4 %></td>
	                    	<td><%= tot_grade_5 %></td>
	                    	<td><%= tot_cnt %></td>
	                    </tr>
	                    <%
	                    }
	                    else
	                    {
	                    %>
	                    <tr>
	                    	<td colspan="7">검색 된 정보가 없습니다.</td>
	                    </tr>
	                    <%
	                    }
	                    %>
	                  </table>
                  </div>      
                  <div style="clear:both"> </div>
           		  <div style="width:800px;text-align:center;margin-top:10px;">
           		  	<a href="satisfaction_main.jsp"><img src="../images/btn/prev.gif" alt="돌아가기"/></a>
           		  </div>
            </div>
        </div>
        <!--// id="contents"--> 
       	
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>
</body>
</html>
