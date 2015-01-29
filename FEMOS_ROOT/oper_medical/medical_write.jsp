<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
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
	setMenu('menu_img',6);
	
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
	var objs = 's_name,s_age,symptom,handle,m_name,m_age';
	var Msgs = '환자성명을 입력해주세요.,환자나이를 입력해주세요.,증상을 입력해주세요.,처치내용을 입력해주세요.,진료자성명을 입력해주세요.,진료자나이를 입력해주세요.';
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{		
			if (confirm('입력된 정보 저장하시겠습니까?'))
			{
				document.getElementById('form1').submit();		
			}
	}
}
</script>
</head>

<body>
<form id="form1" method="post" action="medical_write_ok.jsp" enctype="multipart/form-data">
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
                <h2><img src="../images/common/t_24.gif" alt="환자진료"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>환자 정보</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<colgroup>
						<col width="100px" />
						<col width="300px" />
						<col width="100px" />
						<col width="300px" />
						<col width="*" />
					</colgroup>
					
					<tr>
						<th>성명</th>
						<td style="text-align:left;"><input type="text" id="s_name" name="s_name" value="" /></td>
						<th>성별</th>
						<td style="text-align:left;">
							<select id="s_sex" name="s_sex">
								<option value="M">남</option>
								<option value="F">여</option>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>나이</th>
						<td style="text-align:left;"><input type="text" id="s_age" name="s_age" value="" style="text-align:right;width:40px;" /> 세</td>
						<th>연락처</th>
						<td style="text-align:left;"><input type="text" id="s_tel" name="s_tel" value="" /></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>사는곳</th>
						<td colspan="3" style="text-align:left;"><input type="text" id="s_addr" name="s_addr" value="" style="width:99%"/></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>사진</th>
						<td colspan="3" style="text-align:left;"><input type="file" id="pic" name="pic" value="" style="width:99%"/></td>
						<td>&nbsp;</td>
					</tr>
                </table>
            </div>
            
            <div class="contents1">
                <h3>보호자 정보</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<colgroup>
						<col width="100px" />
						<col width="300px" />
						<col width="100px" />
						<col width="300px" />
						<col width="*" />
					</colgroup>
					
					<tr>
						<th>성명</th>
						<td style="text-align:left;"><input type="text" id="p_name" name="p_name" value="" /></td>
						<th>성별</th>
						<td style="text-align:left;">
							<select id="p_sex" name="p_sex">
								<option value="M">남</option>
								<option value="F">여</option>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>나이</th>
						<td style="text-align:left;"><input type="text" id="p_age" name="p_age" value="" style="text-align:right;width:40px;" /> 세</td>
						<th>연락처</th>
						<td style="text-align:left;"><input type="text" id="p_tel" name="p_tel" value="" /></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>사는곳</th>
						<td colspan="3" style="text-align:left;">
							<input type="text" id="p_addr" name="p_addr" value="" style="width:80%"/>
						</td>
						<td>&nbsp;</td>
					</tr>
                </table>
            </div>
            
            <div class="contents1">
                <h3>진료 정보</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<colgroup>
						<col width="100px" />
						<col width="300px" />
						<col width="100px" />
						<col width="300px" />
						<col width="*" />
					</colgroup>
					
					
					<tr>
						<th>증상</th>
						<td style="text-align:left;" colspan="3">
							<textarea id="symptom" name="symptom" style="width:99%;height:100px;"></textarea>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>처치내용</th>
						<td style="text-align:left;" colspan="3"><textarea id="handle" name="handle" style="width:99%;height:100px;"></textarea></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>진료자 성명</th>
						<td style="text-align:left;"><input type="text" id="m_name" name="m_name" value="" /></td>
						<th>진료자 성별</th>
						<td style="text-align:left;">
							<select id="m_sex" name="m_sex">
								<option value="M">남</option>
								<option value="F">여</option>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>진료자 나이</th>
						<td style="text-align:left;"><input type="text" id="m_age" name="m_age" value="" style="text-align:right;width:40px;" /> 세</td>
						<th>진료자 연락처</th>
						<td style="text-align:left;"><input type="text" id="m_tel" name="m_tel" value="" /></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:left">
							<div id="err_msg" style="float:left;padding:3px"> </div>
							<div id="err_msg" style="float:right">
							<a href="#" onclick="save();"><img src="../images/btn/save.gif" alt="저장"/></a>
							<a href="medical_list.jsp"><img src="../images/btn/cancel.gif" alt="취소"/></a>
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
