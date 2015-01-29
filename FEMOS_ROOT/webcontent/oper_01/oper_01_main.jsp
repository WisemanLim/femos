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
	setMenu('menu_img',1);
	
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
                <h3>관람객현황</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    </colgroup>
                    <tr>
                        <th>구분</th>
                        <th>전일까지 누계</th>
                        <th>금일()</th>
                        <th>총 누계</th>
                        <th>비고</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td>인건비</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>주행사장</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>행사장 A</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>기타</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>999,999</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div>
            <!--// class="contents1 관람객현황"--> 
            
            
            
            <div class="contents1">
                <h3>날씨현황</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    </colgroup>
                    <tr>
                        <th>일 (6.11)</th>
                        <th>일 (6.11)</th>
                        <th>일 (6.11)</th>
                        <th>일 (6.11)</th>
                        <th>일 (6.11)</th>
                        <th>일 (6.11)</th>
                        <th>일 (6.11)</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td><img src="../images/weather/cloudy1.png" alt="" width="30" height="30"/><span>맑음</span> <p class="temp"> <span class="temp1">20℃</span> <span class="temp2">30℃</span></p></td>
                        <td><img src="../images/weather/cloudy1.png" alt="" width="30" height="30"/><span>맑음</span> <p class="temp"> <span class="temp1">20℃</span> <span class="temp2">30℃</span></p></td>
                        <td><img src="../images/weather/cloudy1.png" alt="" width="30" height="30"/><span>맑음</span> <p class="temp"> <span class="temp1">20℃</span> <span class="temp2">30℃</span></p></td>
                        <td><img src="../images/weather/cloudy1.png" alt="" width="30" height="30"/><span>맑음</span> <p class="temp"> <span class="temp1">20℃</span> <span class="temp2">30℃</span></p></td>
                        <td><img src="../images/weather/cloudy1.png" alt="" width="30" height="30"/><span>맑음</span> <p class="temp"> <span class="temp1">20℃</span> <span class="temp2">30℃</span></p></td>
                        <td><img src="../images/weather/cloudy1.png" alt="" width="30" height="30"/><span>맑음</span> <p class="temp"> <span class="temp1">20℃</span> <span class="temp2">30℃</span></p></td>
                        <td><img src="../images/weather/cloudy1.png" alt="" width="30" height="30"/><span>맑음</span> <p class="temp"> <span class="temp1">20℃</span> <span class="temp2">30℃</span></p></td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <!--// class="contents1 날씨정보"--> 
            
            
            
            
            <div class="contents1">
                <h3>불편사항 접수 건수</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="280"/>
                    <col width="280"/>
                    <col width="280"/>
                    </colgroup>
                    <tr>
                        <th>행사관련 민원</th>
                        <th>시설관련 민원</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td><span class="t_01">15</span></td>
                        <td><span class="t_01">25</span></td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <!--// class="contents1 불편사항 접수 건수"--> 
            
            
            
            
            
            <div class="contents1">
                <h3>Contents 평가</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="180"/>
                    <col width="180"/>
                    <col width="180"/>
                    <col width="180"/>
                    </colgroup>
                    <tr>
                        <th>Location</th>
                        <th>평균 점수 (낮은 순)</th>
                        <th>비고</th>
                        <th>&nbsp;</th>
                    </tr>
                    <tr>
                        <td>권역 _A-행사장_3-Contents_11</td>
                        <td>25</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>권역 _A-행사장_3-Contents_11</td>
                        <td>25</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>권역 _A-행사장_3-Contents_11</td>
                        <td>25</td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <!--// class="contents1 contents 평가"--> 
        
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
