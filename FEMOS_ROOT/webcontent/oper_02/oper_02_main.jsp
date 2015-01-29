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
	setMenu('menu_img',2);
	
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
            

            
            <div class="contitle">
                <h2><img src="../images/common/t_21.gif"/></h2>
            </div>
            
            
            
            
 			<div class="contents1">
                <h3>축제 행사장 평가 현황</h3>
                <div class="searchbar">
                    <p class="searchbar_input">
                        <select style="width:50px">
                        </select>
                        <input type="text">
                        </input>
                        <a href="#"><img src="../images/common/btn_search.gif" align="absmiddle"/></a></p>
                    <p class="searchbar_btn"><a href="#"><img src="../images/common/btn_statistics.gif" align="absmiddle"//></a> </p>
                </div>
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
                        <th>이름</th>
                        <th>연락처</th>
                        <th>매우만족</th>
                        <th>만족</th>
                        <th>보통</th>
                        <th>불만</th>
                        <th>매우불만</th>
                        <th>참여형태</th>
                        <th>참여연령</th>
                        <th>SNS연동</th>
                        <th>참여의견</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td>홍길동</td>
                        <td>010-0000-0000</td>
                        <td>O</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>가족</td>
                        <td>20대</td>
                        <td>O</td>
                        <td>본행사장에는............</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td>홍길동</td>
                        <td>010-0000-0000</td>
                        <td>O</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>가족</td>
                        <td>20대</td>
                        <td>O</td>
                        <td>본행사장에는............</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td>홍길동</td>
                        <td>010-0000-0000</td>
                        <td>O</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>가족</td>
                        <td>20대</td>
                        <td>O</td>
                        <td>본행사장에는............</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td>홍길동</td>
                        <td>010-0000-0000</td>
                        <td>O</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>가족</td>
                        <td>20대</td>
                        <td>O</td>
                        <td>본행사장에는............</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>001</td>
                        <td>a_A1-P1</td>
                        <td>홍길동</td>
                        <td>010-0000-0000</td>
                        <td>O</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>가족</td>
                        <td>20대</td>
                        <td>O</td>
                        <td>본행사장에는............</td>
                        <td>&nbsp;</td>
                    </tr>
                  </table>
            </div>
            <!--// class="contents1 축제 행사장 평가 현황"--> 
         
        </div>
        <!--// id="contents"--> 
       
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->

</body>
</html>
