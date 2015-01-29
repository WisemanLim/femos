<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.research.Biz_research" %>
<%@ page import="com.operation.research.Dal_research" %>
<%@ page import="com.operation.research.Dal_research_group" %>
<%@ page import="com.operation.research.Biz_research_group" %>
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
            
            <div id="research_wrap">
            	<div id="research_title">
            		<div class="title_left"><%=base_obj.getSv_title() %></div>
            		<div class="title_right">ID : <%=base_obj.getSv_id()%></div>
            	</div>
            	<div style="clear:both"> </div>
            	<div class="research_content">
            		<div style="width:100%;">
            			<div class="title_item_bar" style="width:100px;">일반현황</div>
            			<div style="float:left;margin-top:8px;margin-left:5px;font-size:8pt;">(통계처리를 위한 자료입니다.)</div>
            		</div>
            		<div style="clear:both"> </div>
            		<div class="tb_research">
            			<table border="1" cellpadding="3" cellspacing="1">
            				<colgroup>
            					<col width="114px"/>
            					<col width="300px"/>
            					<col width="114px"/>
            					<col width="300px"/>
            				</colgroup>
            				<tr>
            					<th>메일주소</th>
            					<td>
            						<input type="text" id="user_mail_addr" name="user_mail_addr" value="" style="width:200px;"/>
            					</td>
            					<th>성명</th>
            					<td>
            						<input type="text" id="user_nm" name="user_nm" value="" style="width:200px;"/>
            					</td>
            				</tr>
            			</table>
            		</div>
            		<%
	            		Dal_research_group group = new Dal_research_group();
	            		group.getResearch_group_list(sv_id);
	            		Vector v_group_list = group.getV_list();
            		
            			if(v_group_list.size() > 0)
            			{
            				for(int i = 0; i < v_group_list.size(); i++)
            				{
            					Biz_research_group group_obj = (Biz_research_group)v_group_list.elementAt(i);
            		%>
            		
            		<div class="research_group">
            			<div class="reserch_group_title" style="width:100%;">
							<div class="title_item_bar" >
								<%=group_obj.getSv_group_nm() %>
							</div>
							<%
							if(group_obj.getSv_group_summary().length() > 0)
							{
							%>
							<div style="clear:both"> </div>
							<div class="head_text_box">
								<%=group_obj.getSv_group_summary().replaceAll(System.getProperty("line.separator"),"<br/>") %>
							</div>
							<%
							} 
							%>
							<div class="group_items">
								<%=com.util.ResearchUtil.research_item_write(group_obj.getSv_id(), group_obj.getSv_group()) %>
							</div>
						</div>
						<div style="text-align:center;margin-top:30px;">
							<a href="javascript:history.back();"><img src="../images/btn/prev.gif" alt="돌아가기"/></a>
						</div>
            		</div>
            		<%
            				}
            			}
            		%>
            	</div>
            	
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
