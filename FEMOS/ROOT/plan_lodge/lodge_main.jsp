<%@include file="../lib/session_chk.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.lodge.Dal_lodge_main" %>
<%@ page import="com.plan.lodge.Biz_lodge_main" %>
<%@ page import="com.plan.lodge.Dal_lodge_sub" %>
<%@ page import="com.plan.lodge.Biz_lodge_sub" %>
<%@page import="com.util.CharacterSet"%>
<%@ page import="java.util.*" %>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
	Dal_lodge_main lodge_main = new Dal_lodge_main();
	lodge_main.getLodge_list(festival_cd);
	
	Vector main_list = lodge_main.getV_list();
	
	String lodge_no = request.getParameter("lodge_no")!=null?request.getParameter("lodge_no").toString():"";
	
	String lodge_nm = "";
	String lodge_phone = "";
	String lodge_addr = "";
	
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num").toString()):0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=session.getAttribute("FESTIVAL_NM") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="./datepicker/css/jquery.ui.all.css" />
<link rel='stylesheet' type='text/css' href='./fullcalendar/fullcalendar.css' />
<link rel='stylesheet' type='text/css' href='./fullcalendar/fullcalendar.print.css' media='print' />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>
<script type="text/javascript" src="./datepicker/jquery.ui.core.js"></script>
<script type="text/javascript" src="./datepicker/jquery.ui.widget.js"></script>
<script type="text/javascript" src="./datepicker/jquery.ui.datepicker.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	setMenu('menu_img',7);
	
	$(".popup1").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});

	$(".datepicker").datepicker(
	{
		changeMonth: true,
		changeYear: true,
		dateFormat: "yy-mm-dd",
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'], 
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
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

function save_main()
{
	var objs = 'lodge_nm,addr,phone';
	var Msgs = '숙소명을 입력해주세요.,주소를 입력해주세요.,연락처를 입력해주세요.';
	var inner_layer = 'lodge_main_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'lodge_main_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit_main()
{
	var objs = 'edit_lodge_nm,edit_addr,edit_phone';
	var Msgs = '숙소명을 입력해주세요.,주소를 입력해주세요.,연락처를 입력해주세요.';
	var inner_layer = 'lodge_main_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'lodge_main_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function del_main()
{
	if(confirm('삭제하시겠습니까?'))
	{
		document.getElementById('form1').action = 'lodge_main_delete.jsp';
		document.getElementById('form1').submit();
	}
}

function save()
{
	var objs = 'room_nm,team_nm,male_cnt,fmale_cnt,st_ymd,ed_ymd';
	var Msgs = '호/실명을 입력해주세요.,국가/팀/단체명을 입력해주세요.,남성인원을 입력해주세요,여성인원을 입력해주세요,입실일자를 입력해주세요.,퇴실일자를 입력해주세요.';
	var inner_layer = 'lodge_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'lodge_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit()
{
	var objs = 'edit_room_nm,edit_team_nm,edit_male_cnt,edit_fmale_cnt,edit_st_ymd,edit_ed_ymd';
	var Msgs = '호/실명을 입력해주세요.,국가/팀/단체명을 입력해주세요.,남성인원을 입력해주세요,여성인원을 입력해주세요,입실일자를 입력해주세요.,퇴실일자를 입력해주세요.';
	var inner_layer = 'lodge_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'lodge_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function del()
{
	if(confirm('삭제하시겠습니까?'))
	{
		document.getElementById('form1').action = 'lodge_delete.jsp';
		document.getElementById('form1').submit();
	}
}

function setMainEditForm(lodge_no,lodge_nm,addr,phone)
{
	show_layout_form('lodge_main_edit_form');
	$('#lodge_no').val(lodge_no);
	$('#edit_lodge_nm').val(lodge_nm);
	$('#edit_addr').val(addr);
	$('#edit_phone').val(phone);
}

function setEditForm(rec_num,room_nm,team_nm,male_cnt,fmale_cnt,st_ymd,ed_ymd)
{
	show_layout_form('lodge_edit_form');
	$('#rec_num').val(rec_num);
	$('#edit_room_nm').val(room_nm);
	$('#edit_team_nm').val(team_nm);
	$('#edit_male_cnt').val(male_cnt);
	$('#edit_fmale_cnt').val(fmale_cnt);
	$('#edit_st_ymd').val(st_ymd);
	$('#edit_ed_ymd').val(ed_ymd);	
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
                <h2><img src="../images/common/t_lodge.gif"/></h2>
            </div>
            <div class="contents1" style="float:left">
                <h3>숙소계획 입력</h3>
                <div class="area">
                    <ul>
                        <li>
                            <div class="areahead">숙소 리스트</div>
                        </li>
                        <%
                        String cssClass = "";
                        if(main_list.size() > 0)
                        {
                        	for(int i = 0; i < main_list.size(); i++)
                        	{
                        		Biz_lodge_main obj = (Biz_lodge_main)main_list.elementAt(i);
                        		
                        		if(lodge_no.equals("") && i == 0)
                        		{
                        			cssClass = "areaselect";
                        			lodge_no = obj.getLodge_no();
                        			lodge_nm = obj.getLodge_nm();
                    				lodge_phone = obj.getPhone();
                    				lodge_addr = obj.getAddr();
                        		}
                        		else
                        		{
                        			cssClass = "areabox";
                        			if(lodge_no.equals(obj.getLodge_no()))
                        			{
                        				cssClass = "areaselect";
                        				lodge_no = obj.getLodge_no();
                        				lodge_nm = obj.getLodge_nm();
                        				lodge_phone = obj.getPhone();
                        				lodge_addr = obj.getAddr();
                        			}
                        		}
                        %>
                        <li>
                            <div class="<%=cssClass %>"><a href="lodge_main.jsp?festival_cd=<%=festival_cd %>&lodge_no=<%=obj.getLodge_no() %>"><%=obj.getLodge_nm() %></a></div>
                        </li>
                        <%
                        	}
                        } 
                        %>
                        <li>
                            <div class="areabox">
                            	<a href="javascript:show_layout_form('lodge_main_input_form');"><img src="../images/common/input.gif" alt="입력" /></a>
                            	<a href="#" onclick="setMainEditForm('<%=lodge_no %>','<%=lodge_nm %>','<%=lodge_addr %>','<%=lodge_phone %>');"><img src="../images/common/edit.gif" alt="편집" /></a>
                            </div>
                        </li>
                    </ul>
                </div>
                <!--// class="area"--> 
            </div>
            <!--// class="contents1" 숙소선택-->
            
            <div class="contents1" style="position:absolute; margin-left:140px; margin-top:24px">
                <table  class="table1">
                    <colgroup>
	                    <col width="200px"/>
	                    <col width="200px"/>
	                    <col width="440px"/>
	                    <col width="*"/>
                    </colgroup>
                    <tr>
                        <th>숙소명</th>
                        <th>연락처</th>
                        <th>주소</th>
                        <th> </th>
                    </tr>
                    <tr>
                        <td><%=lodge_nm %></td>
                        <td><%=lodge_phone %></td>
                        <td><%=lodge_addr %></td>
                        <td> </td>
                    </tr>
                </table>
                <div class="searchbar" style="margin-top:20px">
                    <p class="searchbar_title"><%=lodge_nm %></p>
                    <p class="searchbar_btn">
                    <a href="javascript:show_layout_form('lodge_input_form');"><img src="../images/common/btn_input.gif" align="absmiddle" /></a> 
                    <a href="javascript:show_layout_form('lodge_csv_form');"><img src="../images/common/btn_csv.gif" align="absmiddle"//></a> </p>
                </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="200"/>
                    <col width="240"/>
                    <col width="120"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="80"/>
                    <col width="*"/>
                    </colgroup>
                    <tr>
                        <th>호/실명</th>
                        <th>국가/팀/단체명</th>
                        <th>인원(남/여)</th>
                        <th>입실일</th>
                        <th>퇴실일</th>
                        <th>보기</th>
                        <th>&nbsp;</th>
                    </tr>
                    <%
                    	Dal_lodge_sub lodge_sub = new Dal_lodge_sub();
                    	lodge_sub.getLodge_subList(festival_cd,lodge_no);
                    	
                    	Vector sub_list = lodge_sub.getV_list();
                    	
                    	if(sub_list.size() > 0)
                    	{
                    		for(int i = 0; i < sub_list.size(); i++)
                    		{
                    			Biz_lodge_sub sub_obj = (Biz_lodge_sub)sub_list.elementAt(i);
                    %>
                    <tr>
                        <td><%=sub_obj.getRoom_nm() %></td>
                        <td><%=sub_obj.getTeam_nm() %></td>
                        <td><%=sub_obj.getMale_cnt()+sub_obj.getFmale_cnt() %> (<%=sub_obj.getMale_cnt() %>/<%=sub_obj.getFmale_cnt() %>)</td>
                        <td><%=sub_obj.getSt_ymd() %></td>
                        <td><%=sub_obj.getEd_ymd() %></td>
                        <td><a href="#" onclick="setEditForm('<%=sub_obj.getRec_num() %>','<%=sub_obj.getRoom_nm() %>','<%=sub_obj.getTeam_nm() %>','<%=sub_obj.getMale_cnt() %>','<%=sub_obj.getFmale_cnt() %>','<%=sub_obj.getSt_ymd() %>','<%=sub_obj.getEd_ymd() %>');">상세보기</a></td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    		}
                    	}
                    	else
                    	{
                    %>
                    <tr>
                        <td colspan="6">검색된 정보가 없습니다.</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    	}
                    %>
                </table>
            </div>
            <!--// class="contents1 숙소입력"--> 
            <%@include file="inc_lodge_main_input_form.jsp" %>
            <%@include file="inc_lodge_main_edit_form.jsp" %>
            
            <%@include file="inc_lodge_input_form.jsp" %>
            <%@include file="inc_lodge_edit_form.jsp" %>
            <%@include file="inc_lodge_csv_form.jsp" %>
        </div>
        
        <input type="hidden" id="lodge_no" name="lodge_no" value="<%=lodge_no %>" />
        <input type="hidden" id="rec_num" name="rec_num" value="<%=rec_num %>" />
        
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
