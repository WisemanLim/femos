<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = "FES10001";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',1);
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
		$("#"+obj_id).show();
	}
}

function hide_layout_form(obj_id)
{
	$("#"+obj_id).hide();
}


</script>
<title>Untitled Document</title>
</head>

<body>
<form id="form1" method="post" action="">

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
           <%@include file="../include/plan_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        <div id="contents">
            <div class="contitle">
                <h2><img src="../images/common/t_schedule.gif"/></h2>
            </div>
            <div class="contents1">
                <h3>일정보기</h3>
                <div class="area">
                    <ul>
                        <li>
                            <div class="areahead">구역_1</div>
                        </li>
                        <li>
                            <div class="areaselect"><a href="#">행사장_A</a></div>
                        </li>
                        <li>
                            <div class="areabox"><a href="#">행사장_B</a></div>
                        </li>
                        <li>
                            <div class="areabox"><a href="#">행사장_C</a></div>
                        </li>
                        <li>
                            <div class="areabox"><a href="#">행사장_D</a></div>
                        </li>
                        <li>
                            <div class="areabox"><a href="#">행사장_E</a></div>
                        </li>
                        <li>
                            <div class="areabox"><a href="#">행사장_F</a></div>
                        </li>
                    </ul>
                </div>
                <!--// class="area"-->
                
                <div class="calender">
                    <h3>행사장_A</h3>
                    <p><img src="../images/common/semple_03.gif"/></p>
                </div>
                <!--// class="calender"--> 
                
            </div>
            <!--// class="contents1">--> 
            
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
