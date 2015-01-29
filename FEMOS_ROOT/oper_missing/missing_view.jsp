<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.missing.Biz_missing" %>
<%@ page import="com.operation.missing.Dal_missing" %>
<%@ page import="com.operation.missing.Biz_missing_result" %>
<%@ page import="com.operation.missing.Dal_missing_result" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	int missing_key = request.getParameter("missing_key")!=null?Integer.parseInt(request.getParameter("missing_key")):0;
	Biz_missing missing = new Dal_missing().getDetailMissing(missing_key);
	
	Dal_missing_result result = new Dal_missing_result();
	result.getMissing_result_list(missing_key);
	
	Vector v_list = result.getV_list();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=session.getAttribute("FESTIVAL_NM") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/facebox.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../css/faceplant.css" media="screen" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/facebox.js" type="text/javascript"></script>
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

	 $('a[rel*=facebox]').facebox({
	      loading_image : '../css/loading.gif',
	      close_image   : '../css/closelabel.gif' 
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
<form id="form1" method="post" action="" >
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="missing_key" name="missing_key" value="<%=missing_key %>" />
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
                <h2><img src="../images/common/t_24.gif" alt="아동/노인"/></h2>
            </div>
            
            <div class="contents1">
                <h3>아동/노인 상세정보</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<colgroup>
                		<col width="100px" />
                		<col width="200px" />
                		<col width="100px" />
                		<col width="200px" />
                		<col width="100px" />
                		<col width="200px" />
                		<col width="*" />
                	</colgroup>
                	<tr>
                		<th>아동/노인 성명</th>
                		<td><%=missing.getName() %></td>
                		<th>보호자 성명</th>
                		<td><%=missing.getProtector() %></td>
                		<th>연락처</th>
                		<td><%=missing.getProtector_tel() %></td>
                		<td>&nbsp;</td>
                	</tr>
                </table>
            </div>
            <%if(v_list.size() > 0){ %>
            <div class="contents1">
                <h3>조치이력</h3>
                <!--// class="searchbar"-->
               	<%for(int i = 0; i < v_list.size(); i++){ 
               		Biz_missing_result obj = (Biz_missing_result)v_list.elementAt(i);
               	%>
                <div style="margin-top:5px;padding:5px;width:890px;border:1px solid #41575c;">
                	<%=obj.getResult().replaceAll(System.getProperty("line.separator"), "</br>") %>
                </div>
                <%} %>
            </div>
           	<%} %>
           	<div style="width:900px;text-align:right;margin-top:10px;">
           		<a href="missing_list.jsp"><img src="../images/btn/list.gif" alt="목록"/></a>
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
