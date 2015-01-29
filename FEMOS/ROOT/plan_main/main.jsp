<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../lib/session_chk.jsp" %>
<%@page import="com.plan.budget.Dal_budget" %>
<%@page import="com.plan.budget.Biz_budget" %>
<%@page import="com.plan.schedule.Dal_schedule_plan" %>
<%@page import="com.plan.schedule.Biz_schedule_plan" %>
<%@page import="com.plan.hr.Dal_hr_plan" %>
<%@page import="com.plan.hr.Biz_hr_plan" %>
<%@page import="com.plan.alarm.Dal_alarm_msg" %>
<%@page import="com.plan.alarm.Biz_alarm_msg" %>
<%@page import="com.plan.smu.Dal_smu_base" %>
<%@page import="com.plan.smu.Biz_smu_base" %>
<%@page import="com.util.CharacterSet"%>
<%@page import="java.util.*" %>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
	Dal_budget budget = new Dal_budget();
	budget.getBudgetMainList(festival_cd);
	Vector budget_list = budget.getV_list();
	
	Dal_schedule_plan schedule = new Dal_schedule_plan();
	schedule.getSchedule_list_all(festival_cd);
	Vector schedule_list = schedule.getV_list();
	
	Dal_hr_plan hr = new Dal_hr_plan();
	hr.getHr_list_main_all(festival_cd);
	Vector hr_list = hr.getV_list();
	
	
	Dal_alarm_msg alarm = new Dal_alarm_msg();
	alarm.getAlarm_top_list(5,festival_cd);
	Vector alarm_list = alarm.getV_list();
	
	
	Dal_smu_base layout = new Dal_smu_base();
	layout.get_smu_base_top_list(festival_cd,2);
	Vector layout_list = layout.getV_list();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=session.getAttribute("FESTIVAL_NM") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/facebox.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../css/faceplant.css" media="screen" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">

<script src="../js/jquery.js" type="text/javascript"></script>
<script src="../js/facebox.js" type="text/javascript"></script>
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>


<script type="text/javascript">
$(document).ready(function() {
	
	 $('a[rel*=facebox]').facebox({
	      loading_image : '../css/loading.gif',
	      close_image   : '../css/closelabel.gif' 
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
    
    <div id="bodywrap" >
        <div id="topmenu">
            <%@include file="../include/plan_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        <div id="contents">
            <div class="contents1">
                <h3>총 사업비</h3>
                <table  class="table1">
                    <tr>
                       	<% 
                       		int total_money = 0;
                       		for(int i = 0; i < budget_list.size(); i++)
                       		{
                       			Biz_budget budget_obj = (Biz_budget)budget_list.elementAt(i);
                       	%>
                       	<th style="width:120px"><%=budget_obj.getBudget_div_nm() %></th>
                       	<%
                       		} 
                       	%>
                       	<th style="width:140px">계</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                       	<% 
                       		for(int i = 0; i < budget_list.size(); i++)
                       		{
                       			Biz_budget budget_obj = (Biz_budget)budget_list.elementAt(i);
                       			total_money = total_money + budget_obj.getBudget_money();
                       	%>
                       	<td style="width:120px;text-align:right"><%=CharacterSet.converToMoney(budget_obj.getBudget_money())%></td>
                       	<%
                       		} 
                       	%>
                       	<td style="width:140px;text-align:right"><%= CharacterSet.converToMoney(total_money) %></td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div>
            <!--// class="contents1 총사업비"-->
            
            <div class="contents1">
                <h3>행사 일정</h3>
                <table  class="table1">
                    <colgroup>
                    <col width="120"/>
                    <col width="150"/>
                    <col width="150"/>
                    <col width="400"/>
                    <col width="80"/>
                    <col width="120"/>
                    <col width="*"/>
                    </colgroup>
                    
                    <tr>
                        <th>시작일시</th>
                        <th>장소(구역)</th>
                        <th>프로그램</th>
                        <th>행사제목</th>
                        <th>인력(명)</th>
                        <th>종료일시</th>
                        <th>&nbsp;</th>
                    </tr>
                    <%
                    if(schedule_list.size() > 0 ) 
                    {
                    	for(int i = 0; i < schedule_list.size(); i++)
                    	{
                    		Biz_schedule_plan schedule_obj = (Biz_schedule_plan)schedule_list.elementAt(i);
                    %>
                    <tr>
                        <td><%=schedule_obj.getSt_year() %>-<%=schedule_obj.getSt_month() %>-<%=schedule_obj.getSt_day() %> <%=schedule_obj.getSt_hour() %>:<%=schedule_obj.getSt_minute() %></td>
                        <td><%=schedule_obj.getFestival_hall_nm() %></td>
                        <td><%=schedule_obj.getProgram_nm()!=null?schedule_obj.getProgram_nm():"" %></td>
                        <td style="text-align:left"><%=schedule_obj.getSchedule_title() %></td>
                        <td style="text-align:right"><%=schedule_obj.getHr_cnt() %> 명</td>
                        <td><%=schedule_obj.getEd_year() %>-<%=schedule_obj.getEd_month() %>-<%=schedule_obj.getEd_day() %> <%=schedule_obj.getEd_hour() %>:<%=schedule_obj.getEd_minute() %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    	}
                    }
                    else
                    {
                    %>
                    <tr>
                    	<td colspan="7" style="text-align:center">등록 된 일정계획이 없습니다.</td>
                    </tr>
                    <%
                    }
                    %>
                </table>
            </div>
            <!--// class="contents1 행사일정"-->
            
            <div class="contents1">
                <h3>인력계획 현황</h3>
                <table  class="table1">
                    <tr>
                    	<%
                    		int tot_cnt = 0;
                    		for(int i = 0; i < hr_list.size(); i++)
                    		{
                    			Biz_hr_plan hr_obj = (Biz_hr_plan)hr_list.elementAt(i);
                    	%>
                        <th style="width:100px"><%=hr_obj.getSupport_type_nm() %></th>
                        <%
                    		}
                        %>
                        <th style="width:100px">합계</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                    	<%
                    		for(int i = 0; i < hr_list.size(); i++)
                    		{
                    			Biz_hr_plan hr_obj = (Biz_hr_plan)hr_list.elementAt(i);
                    			tot_cnt = tot_cnt + hr_obj.getCnt();
                    	%>
                        <td style="width:100px;text-align:right"><%=CharacterSet.converToMoney(hr_obj.getCnt()) %></td>
                        <%
                    		}
                        %>
                        <td style="width:100px;text-align:right"><%=CharacterSet.converToMoney(tot_cnt) %></td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div>
            <!--// class="contents1 인력계획 현황"-->
            
            <div class="line1"></div>
            
            <%
            if(layout_list.size() > 0)
            {
            	for(int i = 0; i < layout_list.size(); i++)
            	{
            		Biz_smu_base smu_obj = (Biz_smu_base)layout_list.elementAt(i);
            %>
            <!-- ###레이아웃 두개 호출### -->
            <div class="contents2">
                <h3><%=smu_obj.getFestival_hall_nm() %></h3>
                <div class="box1" style="background:#fff;"><a href="../plan_layout/upload/<%= smu_obj.getSave_img_path()%>" rel="facebox"><img src="../plan_layout/upload/<%= smu_obj.getSave_img_path()%>" width="100%" height="100%" /></a></div>
            </div>
            <!--// class="contents2 행사장 Layout"-->
            <%
            	}
            }
            %>
            
            <!--// class="contents2 퍼레이드 Layout"-->
            
            <div class="contents2">
                <h3>알리미</h3>
                <div class="list1">
                    <ul>
                    	<%if(alarm_list.size() > 0)
                    	{	
                    		for(int i = 0; i < alarm_list.size(); i++)
                    		{
                    			Biz_alarm_msg alarm_obj = (Biz_alarm_msg)alarm_list.elementAt(i);
                    	%>
                        <li><span><a href="../plan_alarm/alarm_main.jsp?rec_num=<%=alarm_obj.getRec_num() %>"><%= CharacterSet.cutOfString(alarm_obj.getTitle(),20) %></a></span><em class="date"><%=alarm_obj.getWrite_dt().subSequence(0,10) %></em></li>
                    	<%
                    		}
                    	} 
                    	else
                    	{
                    	%>
                    	<li><span><a href="../plan_alarm/alarm_main.jsp">등록된 내용이 없습니다.</a></span><em class="date"> </em></li>
                    	<%
                    	}
                    	%>
                    </ul>
                </div>
            </div>
            <!--// class="contents2 알리미"--> 
            
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
