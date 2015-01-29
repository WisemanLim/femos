<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<style>
.temp{padding:8px}
.temp1{color:#09F}
.temp2{color:#F30}
.t_01{ color:#6FF; font-weight:bold}
</style>
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',2);
	setMenu('menu_img',3);
	
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
            
            <!--사진보기 팝업시작 ------------------------------------------------------------------------------------------------------------->
            <div class="popup1" style="margin:250px 0px 0px 650px">
                <p class="closebtn"><a href="#"><img src="../images/common/btn_close.png"/></a></p>
                <h3><img src="../images/common/ic_03.gif" align="absmiddle" /> 001</h3>
   					<div style="border:5px #FFF solid"><img src="../images/common/photo_semple.gif" width="390" height="260" /></div>
                <p class="popbtn">&nbsp;</p>
            </div>
            <!--// class="popup1"-->
            
            <div class="contitle">
                <h2><img src="../images/common/t_21.gif"/></h2>
            </div>
            
            
            
            
 			<div class="contents1">
                <h3>행사 진행 시 불편사항</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="40"/>
                    <col width="40"/>
                    <col width="40"/>
                    <col width="40"/>
                    <col width="20"/>
                    <col width="20"/>
                    <col width="20"/>
                    <col width="20"/>
                    <col width="20"/>
                    <col width="40"/>
                    <col width="20"/>
                    <col width="20"/>
                    <col width="40"/>
                    <col width="40"/>
                    <col width="40"/>
                    </colgroup>
                    <tr>
                        <th>번호</th>
                        <th>행사장코드</th>
                        <th>이미지</th>
                        <th>신고항목</th>
                        <th>신고방법</th>
                        <th>상세내용</th>
                        <th>SNS연동</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td><a href="#"><img src="../images/common/bl_camera.gif" width="16" height="14" /></a></td>
                        <td>파손신고</td>
                        <td>SNS</td>
                        <td>본행사장에서는......</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td><a href="#"><img src="../images/common/bl_camera.gif" width="16" height="14" /></a></td>
                        <td>파손신고</td>
                        <td>SNS</td>
                        <td>본행사장에서는......</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td><a href="#"><img src="../images/common/bl_camera.gif" width="16" height="14" /></a></td>
                        <td>파손신고</td>
                        <td>SNS</td>
                        <td>본행사장에서는......</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td><a href="#"><img src="../images/common/bl_camera.gif" width="16" height="14" /></a></td>
                        <td>파손신고</td>
                        <td>SNS</td>
                        <td>본행사장에서는......</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td><a href="#"><img src="../images/common/bl_camera.gif" width="16" height="14" /></a></td>
                        <td>파손신고</td>
                        <td>SNS</td>
                        <td>본행사장에서는......</td>
                        <td></td>
                        <td></td>
                    </tr>
                  </table>
            </div>
            <!--// class="contents1 축제 행사장 평가 현황"--> 
            
        </div> 
       
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->

</body>
</html>
