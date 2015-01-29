<%@include file="../lib/session_chk.jsp" %>

<%@page import="com.util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.alarm.Dal_alarm_msg" %>
<%@ page import="com.plan.alarm.Biz_alarm_msg" %>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.util.*" %>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div").toString():"TITLE";
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val").toString()):"";
	
	String where  = "";
	
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
	
	
	int recordCount = new Dal_alarm_msg().getAlarm_count(where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_alarm_msg list = new Dal_alarm_msg(); 
	list.getAlarm_list(intStartPoint,intEndPoint,where);
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
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',1);
	setMenu('menu_img',9);
	
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

function setEditForm(rec_num,title,content)
{
	$('#rec_num').val(rec_num);
	$('#edit_alarm_title').val(title);
	$('#edit_alarm_content').val(content.replace(/\%@/g, "\n"));

	 show_layout_form('alarm_edit_form');
}

function save()
{
	var objs = 'alarm_title,alarm_content';
	var Msgs = '제목을 입력해주세요.,내용을 입력해주세요.';
	var inner_layer = 'alarm_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'alarm_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit()
{
	var objs = 'edit_alarm_title,edit_alarm_content';
	var Msgs = '제목을 입력해주세요.,내용을 입력해주세요.';
	var inner_layer = 'alarm_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'alarm_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function del()
{
	if(confirm('삭제하시겠습니까?'))
	{
		document.getElementById('form1').action = 'alarm_delete.jsp';
		document.getElementById('form1').submit();
	}
}

function search()
{
	$('#page').val(1);
}

</script>
</head>

<body>
<form id="form1" method="post" action="">

<input type="text" id="rec_num" name="rec_num" value="" />
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="page" name="page" value="<%=intPage %>" />

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
           <%@include file="../include/plan_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        <div id="contents"> 
   			
   			<!-- 입력팝업창 시작 -->
			<%@include file="inc_alarm_input_form.jsp" %>	
			<%@include file="inc_alarm_edit_form.jsp" %>
            <!-- 입력팝업창 종료-->
                     
            <div class="contitle">
                <h2><img src="../images/common/t_alarm.gif"/></h2>
            </div>
            <div class="contents1">
                <h3>알리미 리스트</h3>
                <div class="searchbar">
                    <p class="searchbar_input">
                    	<select id="sch_div" name="sch_div">
                    		<option value="TITLE" <%if(sch_div.equals("TITLE")){ %>selected="selected"<%} %>>제목</option>
                    		<option value="CONTENT" <%if(sch_div.equals("CONTENT")){ %>selected="selected"<%} %>>내용</option>
                    		<option value="WRITER_NM" <%if(sch_div.equals("WRITER_NM")){ %>selected="selected"<%} %>>작성자</option>
                    	</select>
                    	<input type="text" id="sch_val" name="sch_val" value="<%=sch_val %>" />
                        <input type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" onclick="search();"/>
                   	</p>
                    <p class="searchbar_btn">
                    	
                    	<a href="javascript:show_layout_form('alarm_input_form');"><img src="../images/common/btn_input.gif" align="absmiddle" /></a> 
                    	
                    </p>
                </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    	<col width="80" />
                    	<col width="510" />
                    	<col width="140" />
                    	<col width="140" />
                    </colgroup>
                    <tr>
                    	<th>번호</th>
                    	<th>제목</th>
                    	<th>작성자</th>
                    	<th>등록일시</th>
                    	<th>&nbsp;</th>
                    </tr>
                    <%
                    if(v_list.size() > 0 )
                    {
                    	for(int i = 0; i < v_list.size(); i++)
                    	{
                    		Biz_alarm_msg obj = (Biz_alarm_msg)v_list.elementAt(i);
                    %>
                    <tr>
                    	<td><%=obj.getRn() %></td>
                    	<td style="text-align:left"><a href="javascript:setEditForm('<%=obj.getRec_num() %>','<%=obj.getTitle() %>','<%=obj.getContent().replaceAll(System.getProperty("line.separator"),"%@") %>')"><%=obj.getTitle() %></a></td>
                    	<td><%=obj.getWriter_nm() %></td>
                    	<td><%=obj.getWrite_dt() %></td>
                    	<td>&nbsp;</td>
                    </tr>
                    <%
                    	}
                    }
                    else
                    {
                    %>
                    <tr>
                    	<td colspan="4">검색된 내용이 없습니다.</td>
                    	<td>&nbsp;</td>
                    </tr>
                    <%
                    }
                    %>
                </table>
            </div>
          	
            <div style="margin-top:10px;text-align:center;"><%=PageNavi %></div>
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
