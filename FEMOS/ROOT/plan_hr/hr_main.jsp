<%@include file="../lib/session_chk.jsp" %>

<%@page import="com.util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.hr.Dal_hr_plan" %>
<%@ page import="com.plan.hr.Biz_hr_plan" %>
<%@page import="com.util.CharacterSet"%>
<%@ page import="java.util.*" %>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
	String sch_support_type = request.getParameter("sch_support_type")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_support_type").toString()):"";
	String sch_job = request.getParameter("sch_job")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_job").toString()):"";
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div").toString():"HR_NM";
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val").toString()):"";
	
	String where  = "";
	
	where = where + " WHERE FESTIVAL_CD = '"+festival_cd+"'";
	
	if(sch_support_type.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where +  " SUPPORT_TYPE = '"+sch_support_type+"'";
	}
	
	if(sch_job.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where +  " JOB = '"+sch_job+"'";
	}
	
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
	
	
	int recordCount = new Dal_hr_plan().getHr_count(where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_hr_plan list = new Dal_hr_plan(); 
	list.getHr_list(intStartPoint,intEndPoint,where);
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
	setMenu('menu_img',3);
	
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

function save()
{
	var objs = 'hr_nm,phone,support_type,job';
	var Msgs = '이름을 입력해주세요.,연락처를 입력해주세요.,지원유형을 입력해주세요.,직업을 입력해주세요.';
	var inner_layer = 'hr_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'hr_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit()
{
	var objs = 'edit_hr_nm,edit_phone,edit_support_type,edit_job';
	var Msgs = '이름을 입력해주세요.,연락처를 입력해주세요.,지원유형을 입력해주세요.,직업을 입력해주세요.';
	var inner_layer = 'hr_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'hr_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function del()
{
	if(confirm('삭제하시겠습니까?'))
	{
		
		document.getElementById('form1').action = 'hr_delete.jsp';
		document.getElementById('form1').submit();
		
	}	
}

function setEditForm(pk_no,hr_nm,phone,support_type,addr,job)
{
	$('#pk_no').val(pk_no);
	$('#edit_pk_no').html(pk_no);
	$('#edit_hr_nm').val(hr_nm);
	$('#edit_phone').val(phone);
	$('#edit_addr').val(addr);
	$('select[name="edit_support_type"]').eq(0).val(support_type);
	$('select[name="edit_job"]').eq(0).val(job)
}

function search()
{
	$('#page').val(1);
}

</script>
<title>Untitled Document</title>
</head>

<body>
<form id="form1" method="post" action="">
<input type="hidden" id="pk_no" name="pk_no" value="" />
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
			<%@include file="inc_hr_input_form.jsp" %>	
			<%@include file="inc_hr_edit_form.jsp" %>
			<%@include file="inc_hr_csv_form.jsp" %>	
            <!-- 입력팝업창 종료-->
                     
            <div class="contitle">
                <h2><img src="../images/common/t_manpower.gif"/></h2>
            </div>
            <div class="contents1">
                <h3>인력 리스트</h3>
                <div class="searchbar">
                    <p class="searchbar_input">
                    	<select name="sch_support_type">
                        	<option value="">지원유형</option>
                        	<%=com.util.CodeUtil.getCodeListCombo("A40",sch_support_type) %>
                        </select>
                        <select name="sch_job">
                        	<option value="">직업</option>
                        	<%=com.util.CodeUtil.getCodeListCombo("A50",sch_job) %>
                        </select>
                        
                        <select name="sch_div">
                        	<option value="HR_NM" <%if(sch_div.equals("HR_NM")) {%>selected="selected" <%} %>>이름</option>
                        	<option value="PHONE" <%if(sch_div.equals("PHONE")) {%>selected="selected" <%} %>>연락처</option>
                        	<option value="ADDR" <%if(sch_div.equals("ADDR")) {%>selected="selected" <%} %>>주소</option>
                        </select>
                        <input id="sch_val" name="sch_val" type="text" value="<%=sch_val %>" />
                        <input type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" onclick="search();"/>
                   	</p>
                    <p class="searchbar_btn">
                    	<a href="javascript:show_layout_form('hr_input_form');"><img src="../images/common/btn_input.gif" align="absmiddle" /></a> 
                    	<a href="javascript:show_layout_form('hr_csv_form');"><img src="../images/common/btn_csv.gif" align="absmiddle" /></a> 
                    </p>
                </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="40"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="120"/>
                    <col width="120"/>
                    <col width="500"/>
                    <col width="120"/>
                    </colgroup>
                    <tr>
                        <th>번호</th>
                        <th>고유번호</th>
                        <th>이름</th>
                        <th>연락처</th>
                        <th>지원유형</th>
                        <th>주소</th>
                        <th>직업</th>
                        <th>&nbsp;</th>
                    </tr>
                    <%
                    	if(v_list.size() > 0)
                    	{
                    		for(int i = 0; i < v_list.size(); i++)
                    		{
                    			Biz_hr_plan obj = (Biz_hr_plan)v_list.elementAt(i);
                    %>
                    <tr>
                        <td><%=obj.getRn() %></td>
                        <td><a href="javascript:show_layout_form('hr_edit_form');setEditForm('<%=obj.getPk_no() %>','<%=obj.getHr_nm() %>','<%=obj.getPhone() %>','<%=obj.getSupport_type() %>','<%=obj.getAddr() %>','<%=obj.getJob() %>')"><%=obj.getPk_no() %></a></td>
                        <td><%=obj.getHr_nm() %></td>
                        <td><%=obj.getPhone() %></td>
                        <td><%=obj.getSupport_type_nm() %></td>
                        <td style="text-align:left;"><%=obj.getAddr() %></td>
                        <td><%=obj.getJob_nm() %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    		}
                    	}
                    	else
                    	{
                    %>
                     <tr>
                        <td colspan="7">검색된 인력이 없습니다.</td>
                        <td>&nbsp;</td>
                    </tr>
                    <% 
                    	}
                    %>
                   
                    
                </table>
            </div>
            <!--// class="contents1 인력리스트"--> 
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
