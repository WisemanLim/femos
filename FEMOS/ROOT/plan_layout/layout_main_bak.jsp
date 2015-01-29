<%@include file="../lib/session_chk.jsp" %>

<%@ page import="com.util.PagingUtil" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="java.util.*" %>
<%@ page import="com.plan.layout.Dal_route_base" %>
<%@ page import="com.plan.layout.Dal_route_smu" %>

<%
	//String contextPath = "/FEMOS";
	String url = (String)request.getAttribute("url"); 
	//String contextPath = (String)request.getAttribute("contextPath"); 
	String contextPath = "/webcontent"; 

	int smuHMax = new Dal_route_smu().getBaseMaxHcd();
	int smuRMax = new Dal_route_smu().getRouteMaxRcd();
	int smuOMax = new Dal_route_smu().getInstMaxObjcd();
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//String festival_cd = "FES10001";
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=session.getAttribute("FESTIVAL_NM") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="../css/style.css">
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<link rel="stylesheet" type="text/css" href="../css/jquery.miniColors.css">
<style type="text/css">

.tb_layout_form table {
		width:100%;
		border:1px solid #ccc;
	}
	
	.tb_layout_form th {
		font-size:12px;
		font-weight:bold;
		color:#777;
		background:#eee;
		width:100px;
		
	}
	
	.tb_layout_form td {
		font-size:12px;
		font-weight:normal;
		padding:2px;
		background:#fff;
	}
	
	#input_layout_form {
		position:absolute;
		border:4px solid #aaa;
		width:400px;padding:10px;
		left:300px;
		top:460px;
		z-index:998;
		display:none;
		background:#fff;
	}
	
	#edit_layout_form {
		position:absolute;
		border:4px solid #aaa;
		width:400px;padding:10px;
		left:300px;
		top:460px;
		z-index:998;
		display:none;
		background:#fff;
	}

</style>
<!-- jQuery -->
<script src="../lib/jquery-1.7.2.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/jquery.miniColors.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/jquery.util.js" type="text/javascript" charset="utf-8"></script>
<!--  -->
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>
<!-- route.design -->
<script src="../lib/route.design.core.js" type="text/javascript" charset="utf-8"></script>
<!-- script src="../lib/route.design.core.extend.js" type="text/javascript" charset="utf-8"></script -->
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
__contextPath = "..";

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

	$(".drag").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});
	
	
});

function show_layout_form(obj_id)
{
	for(var i = 0; i < $(".drag").length; i++)
	{
		$(".drag").eq(i).hide();
		$("#"+obj_id).show(500);
	}
}
	
function hide_layout_form(obj_id)
{
	$("#"+obj_id).hide(500);
}

function init_layout_edit_form(obj_id)
{
	if($('#fhCD').val().length > 0)
	{
		$.ajax({
		    url: 'get_festival_hall.jsp',
		    type: 'POST',
		    data: 'festival_cd='+$('#festival_cd').val()+'&festival_hall_cd='+$('#fhCD').val(),
		    dataType: 'html',
		    error: function(){
		        alert('Error loading html document');
		    },
		    success: function(responseText){
				
				if(responseText.replace(/\s/g, "") != '' > 0)
				{
					$('#edit_festival_hall_cd').val(responseText.replace(/\s/g, "").split('^')[0]);	
					$('#edit_festival_hall_nm').val(responseText.replace(/\s/g, "").split('^')[1]);	
				}
				
		    }
		});	
		show_layout_form(obj_id);
	}
	else
	{
		alert('선택된 구역이 없습니다.');
	}
}

function save()
{
	var objs = 'input_festival_hall_nm';
	var Msgs = '구역명칭을 입력해주세요.';
	var inner_layer = 'error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer))
	{
		document.getElementById('form1').action = 'festival_hall_save.jsp';
		document.getElementById('form1').submit();
	}
}


function edit()
{
	var objs = 'edit_festival_hall_nm';
	var Msgs = '구역명칭을 입력해주세요.';
	var inner_layer = 'edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer))
	{
		document.getElementById('form1').action = 'festival_hall_edit.jsp';
		document.getElementById('form1').submit();
	}
}

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
							<a href="#"><img id="btnDelete" onclick="menuDelete();" src="../img/btn_selectDelete.gif" /></a>
							<a href="#"><img id="btnReset" onclick="menuReset();" src="../img/btn_delete.gif" /></a>
							<a href="#"><img id="btnSave" onclick="menuSave();" src="../img/btn_save.gif" /></a> 
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
						<li><a href="#" style="padding: 6px 10px;" onClick="expandcontent('sc1', this);modeConfig._construct();" theme="#ffffff">건물</a></li>
						<li><a href="#" style="padding: 6px 10px;" onClick="expandcontent('sc2', this);lineConfig._type(1);" theme="#ffffff">동선</a></li>
					</ul>
					<div id="tabcontentcontainer">
						<div id="sc1" class="tabcontent" style="overflow-y:scroll;height:460px;width:178px">
							<ul id="imgBooth">
							</ul>				
						</div>
						<!--//id="sc1" class="tabcontent"-->
						<div id="sc2" class="tabcontent">
							<h4>선종류</h4>
							<div class="line">
								<ul>
									<li id="lineConfig1"><a href="#" onClick="lineConfig._type(1);"><img id="lineType1" src="../img/line_01.gif" /></a></li>
									<li id="lineConfig2"><a href="#" onClick="lineConfig._type(2);"><img id="lineType1" src="../img/line_02.gif" /></a></li>
									<li id="lineConfig3"><a href="#" onClick="lineConfig._type(3);"><img id="lineType1" src="../img/line_03.gif" /></a></li>
									<li id="lineConfig4"><a href="#" onClick="lineConfig._type(4);"><img id="lineType1" src="../img/line_04.gif" /></a></li>
								</ul>
							</div>
							<!--//class="line"-->
							<h4>선색상</h4>
							<div class="line">
								<ul>
									<li id="lineColor1"><a href="#" onClick="lineConfig._color(1);">&nbsp;<img src="../img/color_01.gif" />&nbsp;</a></li>
									<li id="lineColor2"><a href="#" onClick="lineConfig._color(2);">&nbsp;<img src="../img/color_02.gif" />&nbsp;</a></li>
									<li id="lineColor3"><a href="#" onClick="lineConfig._color(3);">&nbsp;<img src="../img/color_03.gif" />&nbsp;</a></li>
									<li id="lineColor4"><a href="#" onClick="lineConfig._color(4);">&nbsp;<img src="../img/color_04.gif" />&nbsp;</a></li>
									<li id="lineColor5"><a href="#" onClick="lineConfig._color(5);">&nbsp;<img src="../img/color_05.gif" />&nbsp;</a></li>
									<li id="lineColor6"><a href="#" onClick="lineConfig._color(6);">&nbsp;<img src="../img/color_06.gif" />&nbsp;</a></li>
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
			
			<!-- ###START 행사구역 관리 -->
			
			<div style="clear:both"> </div>
			
			<%@include file="inc_layout_input_form.jsp" %>	
			<%@include file="inc_layout_edit_form.jsp" %>	
			
			<div style="background:#6F7F83;width:870px;text-align:right;padding:5px 30px 10px 0;">
				<a href="javascript:show_layout_form('input_layout_form');"><img src="../images/btn/area_add.gif" alt="신규구역추가"/></a>
				<a href="javascript:init_layout_edit_form('edit_layout_form');"><img src="../images/btn/area_edit.gif" alt="구역편집"/></a>
				<!-- <a href="#">[구역삭제]</a>  -->
			</div>
			
			<!-- ###END 행사구역 관리 -->
			
			<!--//id="layout_wrap" -->
        </div>
        <!--// id="contents"--> 
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>

<!-- SAVE FORM -->
<form id="saveForm" action="layout_main_save.jsp" method="post">
		<input id="saveType" name="saveType" type="hidden" value="" />
		<input id="fhCD" name="fhCD" type="hidden" value="" /> 
		<input id="smu_imgData" name="smu_imgData" type="hidden" value="" />
		<input id="smu_installation" name="smu_installation" type="hidden" value="" /> 
		<input id="smu_route" name="smu_route" type="hidden" value="" />
</form>
	
</body>
</html>
