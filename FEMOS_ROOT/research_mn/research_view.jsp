<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.research.Biz_research" %>
<%@ page import="com.operation.research.Dal_research" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String sv_id = request.getParameter("sv_id");
	Biz_research base_obj = new Dal_research().getDetailResearch_base(sv_id);
	
	String proc = request.getParameter("proc")!=null?request.getParameter("proc"):"";
	
	int sv_group = request.getParameter("sv_group")!=null?Integer.parseInt(request.getParameter("sv_group")):0;
	
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num")):0;

	int list_num = request.getParameter("list_num")!=null?Integer.parseInt(request.getParameter("list_num")):0;
	
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
	setMenu('menu_img',5);
	
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
	var inner_layer = "err_msg";
	var objs = 'sv_title';
	var Msgs = '설문제목을 입력해주세요.';
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
			if (confirm('입력된 정보로 설문을 저장하여 생성하시겠습니까?'))
			{
				document.getElementById('form1').action = 'research_edit.jsp';		
				document.getElementById('form1').submit();		
			}
	}
}

function group_save()
{
	var inner_layer = "err_msg";
	var objs = 'sv_group_nm';
	var Msgs = '설문그룹명을 입력해주세요.';
	
	if (CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
			if (confirm('입력된 정보로 설문그룹을 저장하여 생성하시겠습니까?'))
			{
				document.getElementById('form1').action = "research_group_add.jsp";		
				document.getElementById('form1').submit();		
			}
	}
}
function group_edit()
{
	var inner_layer = "err_msg";
	var objs = 'sv_group_nm';
	var Msgs = '설문그룹명을 입력해주세요.';
	
	if (CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
			if (confirm('입력된 정보로 설문그룹을 저장하여 생성하시겠습니까?'))
			{
				document.getElementById('form1').action = "research_group_edit.jsp";		
				document.getElementById('form1').submit();		
			}
	}
}

function q_item_save()
{
	var inner_layer = "err_msg";
	var objs = 'q_num,q_text';
	var Msgs = '문항번호를 입력해주세요,문항텍스트를 입력해주세요';
	if (CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
		if (confirm('입력된 정보로 문항을 저장하여 생성하시겠습니까?'))
		{
			document.getElementById('form1').action = "research_q_item_add.jsp";		
			document.getElementById('form1').submit();		
		}
	}
}
function q_item_edit()
{
	var inner_layer = "err_msg";
	var objs = 'q_num,q_text';
	var Msgs = '문항번호를 입력해주세요,문항텍스트를 입력해주세요';
	if (CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
		if (confirm('입력된 정보로 문항을 저장하여 생성하시겠습니까?'))
		{
			document.getElementById('form1').action = "research_q_item_edit.jsp";		
			document.getElementById('form1').submit();		
		}
	}
}

function a_item_save()
{
	var inner_layer = "err_msg";
	var objs = 'a_num,a_text,other_width';
	var Msgs = '선택항목번호를 입력해주세요,선택항목텍스트를 입력해주세요,기타값입력너비를 입력해주세요'
	if (CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
		if (confirm('입력된 정보로 선택항목을 저장하여 생성하시겠습니까?'))
		{
			document.getElementById('form1').action = "research_a_item_add.jsp";		
			document.getElementById('form1').submit();		
		}
	}
}

function a_item_edit()
{
	var inner_layer = "err_msg";
	var objs = 'a_num,a_text,other_width';
	var Msgs = '선택항목번호를 입력해주세요,선택항목텍스트를 입력해주세요,기타값입력너비를 입력해주세요'
	if (CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
		if (confirm('입력된 정보로 선택항목을 저장하여 변경하시겠습니까?'))
		{
			document.getElementById('form1').action = "research_a_item_edit.jsp";		
			document.getElementById('form1').submit();		
		}
	}
}

function del_research(sv_id)
{
	if(confirm('해당 설문을 삭제하시겠습니까?'))
	{
		location.href = 'research_del.jsp?sv_id='+sv_id;
	}
}

function del_group_item(sv_id,sv_group)
{
	if(confirm('해당 그룹을 삭제하시겠습니까?'))
	{
		location.href = 'research_group_item_del.jsp?sv_id='+sv_id+'&sv_group='+sv_group;
	}
}
function del_q_item(sv_id,rec_num)
{
	if(confirm('해당 문항을 삭제하시겠습니까?'))
	{
		location.href = 'research_q_item_del.jsp?sv_id='+sv_id+'&rec_num='+rec_num;
	}
}


function del_a_item(sv_id,list_num,rec_num)
{
	if(confirm('해당 선택항목을 삭제하시겠습니까?'))
	{
		location.href = 'research_a_item_del.jsp?sv_id='+sv_id+'&list_num='+list_num+'&rec_num='+rec_num;
	}
}
</script>
</head>

<body>
<form id="form1" method="post" action="">
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="sv_id" name="sv_id" value="<%=sv_id%>" />
<input type="hidden" id="sv_group" name="sv_group" value="<%=sv_group%>" />
<input type="hidden" id="rec_num" name="rec_num" value="<%=rec_num%>" />
<input type="hidden" id="list_num" name="list_num" value="<%=list_num%>" />
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
                <%@include file="research_base.jsp" %>
            </div>
            
            <div class="contents1">
                <%@include file="research_group.jsp" %>
            </div>
        </div> 
    </div>
    <!--// id="bodywrap"-->
</div>
 <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
<!--// id="allwrap"-->
</form>
</body>
</html>
