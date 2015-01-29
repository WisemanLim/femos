<%@include file="../lib/session_chk.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.code.*" %>
<%@ page import="com.operation.visiter.Biz_visiter_state" %>
<%@ page import="com.operation.visiter.Dal_visiter_state" %>
<%@ page import="com.operation.ivt.Biz_ivt_info" %>
<%@ page import="com.operation.ivt.Dal_ivt_info" %>
<%@page import="com.util.WeatherUtil"%>
<%@ page import="com.operation.satisfaction.Biz_satisfaction" %>
<%@ page import="com.operation.satisfaction.Dal_satisfaction" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
	Dal_visiter_state visiter = new Dal_visiter_state();
	visiter.getVisiter_state_stat(festival_cd);
	Vector visiter_list = visiter.getV_list();
	
	Dal_ivt_info ivt = new Dal_ivt_info();
	ivt.getIvt_list_stat(festival_cd);
	Vector ivt_list = ivt.getV_list();
	
	
	 
    Dal_code code = new Dal_code();
    code.getCodeList("A70");
    Vector c_a70_list = code.getV_list();
    
    Dal_satisfaction satisfaction = new Dal_satisfaction();
	satisfaction.getSatisfaction_stat(festival_cd);
	Vector v_satisfaction_list = satisfaction.getV_list();
    
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
<style>
.temp{padding:8px}
.temp1{color:#09F}
.temp2{color:#F30}
.t_01{ color:#6FF; font-weight:bold}
</style>
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',2);
	setMenu('menu_img',1);
	
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
        <div id="contents"> 

            <div class="contitle">
                <h2><img src="../images/common/t_21.gif"/></h2>
            </div>
            
            <div class="contents1">
                <h3>관람객현황</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    </colgroup>
                    <tr>
                        <th>구역</th>
                        <th>전일까지 누계</th>
                        <th>금일</th>
                        <th>총 누계</th>
                        <th>비고</th>
                        <th>&nbsp;</th>
                    </tr>
                    <%
                    	int sum_prev_cnt = 0;
                    	int sum_today_cnt = 0;
                    	int sum_total_cnt = 0;
                  		
                    	if (visiter_list.size() > 0)
                    	{
                    		for(int i = 0; i < visiter_list.size(); i++)
                    		{
                    			Biz_visiter_state visiter_obj = (Biz_visiter_state)visiter_list.elementAt(i);
                    			
                    			sum_prev_cnt = sum_prev_cnt + visiter_obj.getPrev_cnt();
                    			sum_today_cnt = sum_today_cnt + visiter_obj.getToday_cnt();
                    			sum_total_cnt = sum_total_cnt + visiter_obj.getTotal_cnt();
                    %>
                    <tr>
                    	<td><%=visiter_obj.getFestival_hall_nm() %></td>
                        <td><%=CharacterSet.converToMoney(visiter_obj.getPrev_cnt()) %></td>
                        <td><%=CharacterSet.converToMoney(visiter_obj.getToday_cnt()) %></td>
                        <td><%=CharacterSet.converToMoney(visiter_obj.getTotal_cnt()) %></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    		}
                    %>
                    <tr>
                    	<th>평균</th>
                    	<td><%=CharacterSet.converToMoney(sum_prev_cnt / visiter_list.size()) %></td>
                    	<td><%=CharacterSet.converToMoney(sum_today_cnt / visiter_list.size()) %></td>
                    	<td><%=CharacterSet.converToMoney(sum_total_cnt / visiter_list.size()) %></td>
                    	<td>&nbsp;</td>
                    	<td>&nbsp;</td>
                    </tr>
                    <%
                    	}
                    	else
                    	{	
                    %>
                    <tr>
                    	<td colspan="6">검색 된 정보가 없습니다.</td>
                    </tr>
                    <%
                    	}
                    %>
                    
                </table>
            </div>
            <!--// class="contents1 관람객현황"--> 
           
            <div class="contents1"> 
   				<%if(!festival_cd.equals("")){ %>
   				<div>
   					<%=WeatherUtil.drawWeather("http://www.kma.go.kr/wid/queryDFS.jsp?gridx="+session.getAttribute("WEATHER_GRID_X")+"&gridy="+session.getAttribute("WEATHER_GRID_Y")) %>
   				</div>
   				<div style="margin-top:10px;">
                	<%=WeatherUtil.drawWeekWeather("http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId="+session.getAttribute("WEATHER_AREA_CD")) %>
            	</div>
            	<%} %>
            </div>
            <!--// class="contents1 날씨정보"--> 
            
            <div class="contents1">
                <h3>불편사항 접수 건수</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <tr>
                        <%for(int i = 0; i < c_a70_list.size(); i++)
                        {
                        	Biz_code code_obj = (Biz_code)c_a70_list.elementAt(i);
                        %>
                        <th colspan="5"><%=code_obj.getCode_nm() %></th>
                        <%
                        }
                        %>
                        <th rowspan="2" width="80">합계</th>
                        <th>&nbsp;</th>
                    </tr>
                   
                    <tr>
                    	<%
                    	for(int i = 0; i < c_a70_list.size(); i++)
                        {
                    		Biz_code code_obj = (Biz_code)c_a70_list.elementAt(i);
                    		Dal_ivt_info ivt_sub = new Dal_ivt_info();
                    		ivt_sub.getIvtDiv_list_stat(festival_cd,code_obj.getCode());
                    		Vector ivt_sub_list = ivt_sub.getV_list();
                    		for(int j = 0; j < ivt_sub_list.size(); j++)
                    		{
                    			Biz_ivt_info sub_obj = (Biz_ivt_info)ivt_sub_list.elementAt(j);
                    	%>
                    	<th width="60"><%=sub_obj.getProc_state_nm() %></th>
                    	<%
                    		}
                    	%>
                    	<th width="60">계</th>
                    	<%
                        }
                    	%>
                    	
                    	<th>&nbsp;</th>
                    </tr>
                    
                    <tr>
                    	<%
                    	int proc_state_tot = 0;
                    	for(int i = 0; i < c_a70_list.size(); i++)
                        {
                    		int proc_state_sum = 0;
                    		
                    		Biz_code code_obj = (Biz_code)c_a70_list.elementAt(i);
                    		Dal_ivt_info ivt_sub = new Dal_ivt_info();
                    		ivt_sub.getIvtDiv_list_stat(festival_cd,code_obj.getCode());
                    		Vector ivt_sub_list = ivt_sub.getV_list();
                    		for(int j = 0; j < ivt_sub_list.size(); j++)
                    		{
                    			Biz_ivt_info sub_obj = (Biz_ivt_info)ivt_sub_list.elementAt(j);
                    			proc_state_sum = proc_state_sum + sub_obj.getCnt();
                    	%>
                    	<td width="60"><a href="../oper_02/oper_02_main.jsp?sch_ivt_div=<%=code_obj.getCode() %>&sch_proc_state_cd=<%= sub_obj.getProc_state_cd()%>"><%=CharacterSet.converToMoney(sub_obj.getCnt())%></a></td>
                    	<%
                    		}
                    		proc_state_tot = proc_state_tot + proc_state_sum;
                    	%>
                    	<td width="60"><a href="../oper_02/oper_02_main.jsp?sch_ivt_div=<%=code_obj.getCode() %>"><%=CharacterSet.converToMoney(proc_state_sum)%></a></td>
                    	<%
                        }
                    	%>
                    	<td width="80"><a href="../oper_02/oper_02_main.jsp"><%=CharacterSet.converToMoney(proc_state_tot)%></a></td>
                    	<td>&nbsp;</td>
                    </tr>
                    
                </table>
            </div>
            <!--// class="contents1 불편사항 접수 건수"--> 
            
            
            <div class="contents1">
                <h3>Contents 평가</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                <colgroup>
                 <col width="300px"/>
                 <col width="90px"/>
                 <col width="90px"/>
                 <col width="90px"/>
                 <col width="90px"/>
                 <col width="90px"/>
                 <col width="90px"/>
                 <col width="*"/>
                </colgroup>
                <tr>
                    <th>행사장</th>
                    <th>매우만족</th>
                    <th>만족</th>
                    <th>보통</th>
                    <th>불만</th>
                    <th>매우불만</th>
                    <th>참여수</th>
                    <th>&nbsp;</th>
                </tr>
                <%
                int tot_grade_1 = 0;
                int tot_grade_2 = 0;
                int tot_grade_3 = 0;
                int tot_grade_4 = 0;
                int tot_grade_5 = 0;
                int tot_cnt = 0;
                if(v_satisfaction_list.size() > 0)
                {
                	for(int i = 0; i < v_satisfaction_list.size(); i++)
                	{
                		Biz_satisfaction obj = (Biz_satisfaction)v_satisfaction_list.elementAt(i);
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
                	<td>&nbsp;</td>
                </tr>
                <%
                }
                else
                {
                %>
                <tr>
                	<td colspan="7">검색 된 정보가 없습니다.</td>
                	<td>&nbsp;</td>
                </tr>
                <%
                }
                %>
              </table>
            </div>
            <!--// class="contents1 contents 평가"--> 
        
        </div>
        <!--// id="contents"--> 
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->

</body>
</html>
