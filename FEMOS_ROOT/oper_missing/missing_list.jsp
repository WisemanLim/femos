<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.missing.Biz_missing" %>
<%@ page import="com.operation.missing.Dal_missing" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div").toString():"";
	if(sch_div.length() == 0)
	{
		sch_div = "NAME";
	}
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val").toString()):"";
	
	String where = "";
	
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
	
	int recordCount = new Dal_missing().getMissing_list_count(where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_missing list = new Dal_missing(); 
	list.getMissing_list(intStartPoint,intEndPoint,where);
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
	setMenu('menu_img',7);
	
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

function setEditForm(serial,name,protector,protector_tel)
{
	$('#edit_serial').val(serial);
	$('#edit_name').val(name);
	$('#edit_protector').val(protector);
	$('#edit_protector_tel').val(protector_tel);
	
}

function save()
{
	var objs = 'inst_name,inst_protector,inst_protector_tel';
	var Msgs = '아동/노인 성명을 입력해주세요.,보호자 성명을 입력해주세요.,연락처를 입력해주세요.';
	var inner_layer = 'missing_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'missing_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit()
{
	var objs = 'edit_name,edit_protector,edit_protector_tel';
	var Msgs = '아동/노인 성명을 입력해주세요.,보호자 성명을 입력해주세요.,연락처를 입력해주세요.';
	var inner_layer = 'missing_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'missing_edit.jsp';
		document.getElementById('form1').submit();
	}
}

</script>
</head>

<body>
<form id="form1" method="post" action="missing_list.jsp">

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
            <!-- 입력팝업창 시작 -->
			<%@include file="inc_missing_input.jsp" %>	
			<%@include file="inc_missing_edit.jsp" %>
            <!-- 입력팝업창 종료-->
            <div class="contitle">
                <h2><img src="../images/common/t_24.gif" alt="아동/노인"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>아동/노인 목록</h3>
                <div class="searchbar">
                	<input type="hidden" id="page" name="page" value="<%=intPage %>" />
	                <p class="searchbar_input" style="color:#fff;">
						<select id="sch_div" name="sch_div">
							<option value="NAME" <%if(sch_div.equals("NAME")){ %>selected="selected"<%} %>>아동/노인 성명</option>
							<option value="PROTECTOR" <%if(sch_div.equals("PROTECTOR")){ %>selected="selected"<%} %>>보호자 성명</option>
							<option value="PROTECTOR_TEL" <%if(sch_div.equals("PROTECTOR_TEL")){ %>selected="selected"<%} %>>연락처</option>
						</select>
						<input type="text" id="sch_val" name="sch_val" value="<%=sch_val %>" />
						<input type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" />
	                </p>
	                <p class="searchbar_btn">
	                	
	                </p>
	            </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<colgroup>
                		<col width="100px"/>
                		<col width="100px"/>
                		<col width="200px"/>
                		<col width="200px"/>
                		<col width="200px"/>
                		<col width="200px"/>
                		<col width="150px"/>
                		<col width="*"/>
                	</colgroup>
                	<tr>
                		<th>번호</th>
                		<th>시리얼</th>
                		<th>아동/노인 성명</th>
                		<th>보호자 성명</th>
                		<th>연락처</th>
                		<th>조치내역(건)</th>
                		<th><a href="javascript:show_layout_form('missing_input_form');"><img src="../images/common/btn_input.gif" align="absmiddle" /></a></th>
                		<th>&nbsp;</th>
                	</tr>
                	<%if(v_list.size() > 0){ 
                		for(int i = 0; i < v_list.size(); i++)
                		{
                			Biz_missing obj = (Biz_missing)v_list.elementAt(i);
                	%>
                	<tr>
                		<td><%=obj.getRn() %></td>
                		<td><%=obj.getSerial() %></td>
                		<td><%=obj.getName() %></td>
                		<td><%=obj.getProtector() %></td>
                		<td><%=obj.getProtector_tel() %></td>
                		<td><%=obj.getResult_cnt() %> <a href="missing_view.jsp?missing_key=<%=obj.getSerial() %>">[View]</a></td>
                		<td>
                			<a href="javascript:show_layout_form('missing_edit_form');setEditForm('<%=obj.getSerial() %>','<%=obj.getName() %>','<%=obj.getProtector() %>','<%=obj.getProtector_tel() %>')"><img src="../img/btn_modify.gif" alt="수정" /></a>
                			<a href="#"><img src="../img/btn_delete.gif" alt="삭제" /></a>
                		</td>
                		<td>&nbsp;</td>
                	</tr>
                	<%
                		}
                	}
                	else
                	{
                	%>
                	
                	<%	
                	}
                	%>
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
