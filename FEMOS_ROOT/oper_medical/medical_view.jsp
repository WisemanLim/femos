<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.medical.Biz_medical" %>
<%@ page import="com.operation.medical.Dal_medical" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	int rec_num = request.getParameter("rec_num")!=null?Integer.parseInt(request.getParameter("rec_num")):0;
	
	Biz_medical medical = new Dal_medical().getDetailMedical(rec_num);
	
	
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
	setMenu('menu_img',6);
	
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

function medical_del()
{
	if(confirm('삭제하시겠습니까?'))
	{
		document.getElementById('form1').action = 'medical_del.jsp';
		document.getElementById('form1').submit();
	}
}

</script>
</head>

<body>
<form id="form1" method="post" action="medical_write_ok.jsp" enctype="multipart/form-data">
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="rec_num" name="rec_num" value="<%=rec_num %>" />
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
						<td style="text-align:left;"><%=medical.getS_name() %></td>
						<th>성별</th>
						<td style="text-align:left;">
							<%
								if(medical.getS_sex().equals("M"))
								{
							%>
								남
							<%
								}
								else
								{
							%>
								여
							<%	}%>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>나이</th>
						<td style="text-align:left;"><%=medical.getS_age() %> 세</td>
						<th>연락처</th>
						<td style="text-align:left;"><%=medical.getS_tel()==null?"":medical.getS_tel() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>사는곳</th>
						<td colspan="3" style="text-align:left;"><%=medical.getS_addr()==null?"":medical.getS_addr() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>사진</th>
						<td colspan="3" style="text-align:left;">
							<%if((medical.getPic_path()!= null?medical.getPic_path():"").length() > 0){%>
							<a href="<%=medical.getPic_path() %>" rel="facebox">[VIEW]</a>
							<%
							}
							else
							{
							%>
							&nbsp;
							<%
							} 
							%>
							
						</td>
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
						<td style="text-align:left;"><%=medical.getP_name()==null?"":medical.getP_name() %></td>
						<th>성별</th>
						<td style="text-align:left;">
							<%
								if(medical.getP_sex().equals("M"))
								{
							%>
								남
							<%
								}
								else
								{
							%>
								여
							<%	}%>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>나이</th>
						<td style="text-align:left;"><%=medical.getP_age() %> 세</td>
						<th>연락처</th>
						<td style="text-align:left;"><%=medical.getP_tel()==null?"":medical.getP_tel() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>사는곳</th>
						<td colspan="3" style="text-align:left;">
							<%=medical.getP_addr()==null?"":medical.getP_addr() %>
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
							<%=medical.getSymptom() %>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>처치내용</th>
						<td style="text-align:left;" colspan="3"><%=medical.getHandle() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>진료자 성명</th>
						<td style="text-align:left;"><%=medical.getM_name() %></td>
						<th>진료자 성별</th>
						<td style="text-align:left;">
							<%
								if(medical.getM_sex().equals("M"))
								{
							%>
								남
							<%
								}
								else
								{
							%>
								여
							<%	}%>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>진료자 나이</th>
						<td style="text-align:left;"><%=medical.getM_age() %> 세</td>
						<th>진료자 연락처</th>
						<td style="text-align:left;"><%=medical.getM_tel()==null?"":medical.getM_tel() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:left">
							<div id="err_msg" style="float:left;padding:3px"> </div>
							<div id="err_msg" style="float:right">
							<a href="medical_list.jsp"><img src="../images/btn/list.gif" alt="목록"/></a>
							<a href="medical_edit.jsp?rec_num=<%=rec_num %>"><img src="../images/common/bt_edit.gif" alt="수정"/></a>
							<a href="javascript:medical_del();"><img src="../images/btn/delete.gif" alt="삭제"/></a>
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
