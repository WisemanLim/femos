<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.medical.Biz_medical" %>
<%@ page import="com.operation.medical.Dal_medical" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div").toString():"";
	if(sch_div.length() == 0)
	{
		sch_div = "S_NAME";
	}
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val").toString()):"";
	
	
	String where = "";
	where = where + " WHERE FESTIVAL_CD = '"+festival_cd+"'";
	
	if(sch_val.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + sch_div + " like'%"+sch_val+"%' ";
	}
	
	int recordCount = new Dal_medical().getMedical_list_count(where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_medical list = new Dal_medical(); 
	list.getMedical_list(intStartPoint,intEndPoint,where);
	Vector v_list = list.getV_list();
	
	String PageNavi = PagingUtil.Paging_post(intPage,list_size,recordCount);
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
	setMenu('menu_img',6);
	
	$(".popup1").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});
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
<form id="form1" method="post" action="medical_list.jsp">

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
                <h2><img src="../images/common/t_24.gif" alt="환자진료"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>환자진료 목록</h3>
                <div class="searchbar">
                	<input type="hidden" id="page" name="page" value="<%=intPage %>" />
	                <p class="searchbar_input" style="color:#fff;">
						<select id="sch_div" name="sch_div">
							<option value="S_NAME" <%if(sch_div.equals("S_NAME")){ %>selected="selected"<%} %>>환자 성명</option>
							<option value="S_ADDR" <%if(sch_div.equals("S_ADDR")){ %>selected="selected"<%} %>>환자 주소</option>
							<option value="P_NAME" <%if(sch_div.equals("P_NAME")){ %>selected="selected"<%} %>>보호자 성명</option>
							<option value="P_ADDR" <%if(sch_div.equals("P_ADDR")){ %>selected="selected"<%} %>>환자 주소</option>
							<option value="M_NAME" <%if(sch_div.equals("M_NAME")){ %>selected="selected"<%} %>>진료자 성명</option>
							<option value="SYMPTOM" <%if(sch_div.equals("SYMPTOM")){ %>selected="selected"<%} %>>증상</option>
							<option value="HANDLE" <%if(sch_div.equals("HANDLE")){ %>selected="selected"<%} %>>처치내용</option>
						</select>
						<input type="text" id="sch_val" name="sch_val" value="<%=sch_val %>" />
						<input type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" />
	                </p>
	                <p class="searchbar_btn">
	                	<a href="medical_write.jsp"><img src="../images/common/btn_input.gif" align="absmiddle" /></a>
	                </p>
	            </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<tr>
                		<th rowspan="2" style="width:80px">번호</th>
                		<th colspan="4">환자</th>
                		<th colspan="4">보호자</th>
                		<th colspan="2">진료자</th>
                		<th rowspan="2" style="width:80px">등록일자</th>
                		<th>&nbsp;</th>
                	</tr>
                	<tr>
                		<th style="width:100px">성명</th>
                		<th style="width:80px">성별</th>
                		<th style="width:80px">나이</th>
                		<th style="width:100px">연락처</th>
                		<th style="width:100px">성명</th>
                		<th style="width:80px">성별</th>
                		<th style="width:80px">나이</th>
                		<th style="width:100px">연락처</th>
                		<th style="width:100px">성명</th>
                		<th style="width:100px">연락처</th>
                		<th>&nbsp;</th>
                	</tr>
                	<%if(v_list.size() > 0){ 
                		for(int i = 0; i < v_list.size(); i++)
                		{
                			Biz_medical obj = (Biz_medical)v_list.elementAt(i);	
                	%>
                	<tr>
                		<td><%=obj.getRn() %></td>
                		<td><a href="medical_view.jsp?rec_num=<%=obj.getRec_num() %>"><%=obj.getS_name() %></a></td>
                		<td><%=obj.getS_sex() %></td>
                		<td><%=obj.getS_age() %></td>
                		<td><%=obj.getS_tel()!=null?obj.getS_tel():"" %></td>
                		<td><%=obj.getP_name()!=null?obj.getP_name():""  %></td>
                		<td><%=obj.getP_sex()!=null?obj.getP_sex():""  %></td>
                		<td><%=obj.getP_age() %></td>
                		<td><%=obj.getP_tel()!=null?obj.getS_tel():""  %></td>
                		<td><%=obj.getM_name()!=null?obj.getM_name():""  %></td>
                		<td><%=obj.getM_tel()!=null?obj.getM_tel():""  %></td>
                		<td><%=obj.getReg_ymd() %></td>
                		<td>&nbsp;</td>
                	</tr>
                	<%
                		}
                	}
                	else
                	{ %>
                	
                	<%} %>
                </table>
            </div>
           	
        </div> 
       	<div style="margin-top:10px;text-align:center;"><%=PageNavi %></div>
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>
</body>
</html>
