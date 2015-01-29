<%@include file="../lib/session_chk.jsp" %>

<%@ page import="com.util.PagingUtil"%>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.util.*" %>
<%@ page import="com.plan.layout.Dal_route_smu" %>
<%@ page import="com.plan.layout.Dal_route_base" %>

<%
	String contextPath = "/FEMOS/webcontent";
	int smuHMax = new Dal_route_smu().getBaseMaxHcd();
	int smuRMax = new Dal_route_smu().getRouteMaxRcd();
	int smuOMax = new Dal_route_smu().getInstMaxObjcd();
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="../css/style.css">
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<link rel="stylesheet" type="text/css" href="../css/jquery.miniColors.css">

<!-- jQuery -->
<script src="../lib/jquery-1.7.2.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/jquery.miniColors.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/jquery.util.js" type="text/javascript" charset="utf-8"></script>
<!--  -->
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>
<!-- route.design -->
<script src="../lib/route.design.core.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/route.design.core.extend.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/route.design.util.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/route.design.util.base64.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/route.design.util.image.js" type="text/javascript" charset="utf-8"></script>
<!-- route.design.Design -->
<script src="../js/routedesign/layout.js" type="text/javascript" charset="utf-8"></script>
<!-- route.design.Main -->
<script src="../js/routedesign/main.fn.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/routedesign/main.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">

//Global Setting
__contextPath = "<%=contextPath %>";
__smuHMax = "<%=smuHMax %>"; 
__smuRMax = "<%=smuRMax %>"; 
__smuOMax = "<%=smuOMax %>"; 

$(document).ready(function() {
	setMenu('left_menu_img',1);
	setMenu('menu_img',4);
	
	$(".popup1").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});
});
</script>

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
                <h2><img src="../images/common/t_layout.gif"/></h2>
            </div>
            
			<div id="layout_wrap">
				<div id="layout_top">
					<h3>
						<img src="../img/t_areaSelect.gif" />
					</h3>
					<p>
						<a href="javascript:moveLeftMenu();"><img src="../img/btn_left.gif" /></a>
					</p>
					<div class="area" id="menu">
						<ul style="width: 640px" id="mainList">
							<!--//가로 폭을 들어갈 썸네일의 수에 80px 를 곱해서 지정해주면 가로로 길게 나열됨. 아니면 아래로 떨어짐. -->
						</ul>
					</div>
					<!--//class="area" -->
					<p class="btn_right">
						<a href="javascript:moveRightMenu('80');"><img
							src="../img/btn_right.gif" /></a>
					</p>
					<p class="btn_allArea">
						<a href="#"><img id="area-menu-all" src="../img/btn_allArea.gif" /></a>
					</p>
				</div>
				<!--//id="layout_top" -->
				<div id="layout_body">
					<div class="layout">
						<div class="button">
							<a href="#"><img
								src="../img/btn_save.gif" /></a> <a href="#"><img
								src="../img/btn_delete.gif" /></a>
						</div>
		
						<br>
						<div id="container"></div>
					</div>
					<!--//class="layout" -->
		
					<!--//class="layout container" -->
		
				</div>
		
				<!--//id="layout_body" -->
				<div id="layout_right">
					<h3>
						<img src="../img/t_buildingSelect.gif" />
					</h3>
					<ul id="tablist">
						<li><a href="#" style="padding: 6px 10px;" onClick="return expandcontent('sc1', this)" theme="#ffffff">건물</a></li>
						<li><a href="#" style="padding: 6px 10px;" onClick="return expandcontent('sc2', this)" theme="#ffffff">동선</a></li>
					</ul>
					<div id="tabcontentcontainer">
						<div id="sc1" class="tabcontent">
							<ul id="imgBooth">
							</ul>				
						</div>
						<!--//id="sc1" class="tabcontent"-->
						<div id="sc2" class="tabcontent">
							<h4>선종류</h4>
							<div class="line">
								<ul>
									<li><a href="#" onClick="lineConfig._type(1);"><img src="../img/line_01.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._type(2);"><img src="../img/line_02.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._type(3);"><img src="../img/line_03.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._type(4);"><img src="../img/line_04.gif" /></a></li>
								</ul>
							</div>
							<!--//class="line"-->
							<h4>선색상</h4>
							<div class="line">
								<ul>
									<li><a href="#" onClick="lineConfig._color(1);"><img src="../img/color_01.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._color(2);"><img src="../img/color_02.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._color(3);"><img src="../img/color_03.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._color(4);"><img src="../img/color_04.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._color(5);"><img src="../img/color_05.gif" /></a></li>
									<li><a href="#" onClick="lineConfig._color(6);"><img src="../img/color_06.gif" /></a></li>
								</ul>
							</div>
							<!--//class="line"-->
							<!-- h4>선지우기</h4 >
							<div class="line">
								<ul>
									<li><a href="#" onClick="lineConfig._delete();"><img src="../img/eraser_l.gif" /></a></li>
								</ul>
							</div -->
							<!--//class="line"-->
						</div>
						<!--//id="sc2" class="tabcontent"-->
		
						<!-- div id="sc3" class="tabcontent">
							<h4>기능</h4>
							<div class="line">
								<ul>
									<li><input type="button" value="RESET" onclick="reset();"/></li>
									<li><input type="button" value="라인 불러오기" onclick="loadRoute();"/></li>
									<li><input type="button" value="빌딩 불러오기" onclick="loadBuild();"/></li>
								</ul>
							</div>
						</div -->
						
					</div>
					<!--//id="tabcontentcontainer" -->
				</div>
				<!--//id="layout_right" -->
			</div>
			<!--//id="layout_wrap" -->
			
			<form id="saveForm" name="saveForm">
				<input id="" name="" type="hidden" value=""/>
				<input id="" name="" type="hidden" value=""/>
				<input id="" name="" type="hidden" value=""/>
			</form>
		
			<form id="deleteForm" name="deleteForm">
				<input id="" name="" type="hidden" value=""/>
				<input id="" name="" type="hidden" value=""/>
			</form>
			            
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
