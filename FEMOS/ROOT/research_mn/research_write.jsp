<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.research.Biz_research" %>
<%@ page import="com.operation.research.Dal_research" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
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
				document.getElementById('form1').submit();		
			}
	}
}
</script>
</head>

<body>
<form id="form1" method="post" action="research_write_ok.jsp">
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
                <h2><img src="../images/common/t_24.gif" alt="설문조사"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>설문 기본 정보</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<colgroup>
						<col width="100px" />
						<col width="500px" />
						<col width="100px" />
						<col width="200px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>설문제목</th>
						<td>
							<input type="text" id="sv_title" name="sv_title" value="" style="width:99%;" />
						</td>
						<th>설문년월</th>
						<td style="text-align:left;">
							<select id="sv_yyyy" name="sv_yyyy">
								<%
								for(int i = 2012; i <= java.util.Calendar.getInstance().get(java.util.Calendar.getInstance().YEAR); i++)
								{
								%>
								<option value="<%=i%>" <%if(java.util.Calendar.getInstance().get(java.util.Calendar.getInstance().YEAR) == i){ %>selected="selected"<% }%>><%=i%></option>	
								<%
									} 
								%>
							</select>
							<select id="sv_mm" name="sv_mm">
								<%
								String m_str = "";
								for(int i = 1; i <= 12; i++)
								{
									if(i < 10)
									{
										m_str = "0"+Integer.toString(i);
									}
									else
									{
										m_str = Integer.toString(i);
									}
								%>
								<option value="<%=m_str%>" <%if(java.util.Calendar.getInstance().get(java.util.Calendar.getInstance().MONTH)+1 == i){ %>selected="selected"<% }%>><%=m_str%> 월</option>
								<%
								}	
								%>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3"><input type="text" id="other" name="other" value="" style="width:99%;" /></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:left">
							<div id="err_msg" style="float:left;padding:3px"> </div>
							<div id="err_msg" style="float:right">
							<a href="#" onclick="save();"><img src="../images/btn/save.gif" alt="저장"/></a>
							<a href="research_list.jsp"><img src="../images/btn/cancel.gif" alt="취소"/></a>
							</div>
						</td>
						<td>&nbsp;</td>
					</tr>
                </table>
            </div>
           	
        </div> 
       	
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>
</body>
</html>
