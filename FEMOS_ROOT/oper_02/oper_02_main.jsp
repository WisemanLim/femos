<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.ivt.Biz_ivt_info" %>
<%@ page import="com.operation.ivt.Dal_ivt_info" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
	String sch_ivt_div = request.getParameter("sch_ivt_div") != null ? request.getParameter("sch_ivt_div"):"";
	String sch_proc_state_cd = request.getParameter("sch_proc_state_cd") != null ? request.getParameter("sch_proc_state_cd").toString():"";
	
	String sch_div = request.getParameter("sch_div") != null ? request.getParameter("sch_div").toString():"CONTENT";
	String sch_val = request.getParameter("sch_val") != null ? request.getParameter("sch_val").toString():"";
	
	String where  = "";
	
	if(sch_ivt_div.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " AND ";
		}
		
		where = where + " IVT_DIV = '"+sch_ivt_div+"'";
	}
	
	if(sch_proc_state_cd.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " AND ";
		}
		
		where = where + " PROC_STATE_CD = '"+sch_proc_state_cd+"'";
	}
	
	if(sch_val.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " AND ";
		}
		
		where = where + sch_div + " like'%"+sch_val+"%' ";
	}
	
	//out.println(where);
	
	int recordCount = new Dal_ivt_info().getIvt_count(festival_cd,where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_ivt_info list = new Dal_ivt_info(); 
	list.getIvt_list(festival_cd,intStartPoint,intEndPoint,where);
	Vector v_list = list.getV_list();
	
	String PageNavi = PagingUtil.Paging_post(intPage,list_size,recordCount);
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
	setMenu('menu_img',2);
	
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

function setDetail(division,attach_file,content)
{
	
	$('#attach_img').attr('src','../images/common/photo_semple.gif'); //첨부사진이 없는 경우에 보여줄 사진
	$('#ivt_num').html('<img src="../images/common/ic_03.gif" align="absmiddle"  /> '+division);

	
	if(attach_file.length > 0)
	{
		$('#attach_img').attr('src',attach_file);
		$('#attach_img').attr('width',390);
	}
	
	$('#ivt_content').html(content);
}
function search()
{
	$('#page').val(1);
}

function change_state(rec_num,state_nm, state_cd)
{
	if(confirm(state_nm+' 상태로 처리 하시겠습니까?'))
	{
		location.href = 'change_proc_state.jsp?rec_num='+rec_num+'&proc_state_cd='+state_cd;
	}
}

function delete_ivt(rec_num)
{
	if(confirm('삭제하시겠습니까?'))
	{
		location.href = 'ivt_delete.jsp?rec_num='+rec_num;
	}
}
</script>
</head>

<body>
<form id="form1" method="post" action="">

<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="page" name="page" value="<%=intPage %>" />

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
            <div id="detail_ivt" class="popup1" style="margin:150px 0px 0px 650px;display:none">
                <p class="closebtn"><a href="javascript:hide_layout_form('detail_ivt');"><img src="../images/common/btn_close.png"/></a></p>
                <h3 id="ivt_num"></h3>
   					<div style="border:5px #FFF solid;background:#fff;"><img id="attach_img" src="../images/common/photo_semple.gif" /></div>
                	<div id="ivt_content" style="background:#fff;width:390px;padding:5px;color:#000;"></div>
                <p class="popbtn">&nbsp;</p>
            </div>
            <!--// class="popup1"-->
            
            <div class="contitle">
                <h2><img src="../images/common/t_22.gif"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>행사 진행 시 불편사항</h3>
                <div class="searchbar">
	                <p class="searchbar_input">
	                	<select id="sch_ivt_div" name="sch_ivt_div">
	                   		<option value="">구분</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A70",sch_ivt_div) %>
	                   	</select>
	                   	<select id="sch_proc_state_cd" name="sch_proc_state_cd">
	                   		<option value="">처리상태</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A80",sch_proc_state_cd) %>
	                   	</select>
	                   	<select id="sch_div" name="sch_div">
	                   		<option value="CONTENT" <%if(sch_div.equals("CONTENT")){ %>selected="selected"<%} %>>내용</option>
	                   		<option value="HP_NO" <%if(sch_div.equals("HP_NO")){ %>selected="selected"<%} %>>휴대전화</option>
	                   	</select>
	                   	<input type="text" id="sch_val" name="sch_val" value="<%=sch_val %>" />
	                    <input type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" onclick="search();"/>    
	                </p>
	                <p class="searchbar_btn">
	                	
	                </p>
	            </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    	<col width="60px"/>
                    	<col width="100px"/>
                    	<col width="100px"/>
                    	<col width="120px"/>
                    	<col width="60px"/>
                    	<col width="280px"/>
                    	<col width="60px"/>
                    	<col width="60px"/>
                    	<col width="60px"/>
                    	<col width="60px"/>
                    	<col width="180px"/>
                    	<col width="60px" />
                    	<col width="*"/>
                    </colgroup>
                    <tr>
                        <th>번호</th>
                        <th>처리상태</th>
                        <th>휴대전화</th>
                        <th>구분</th>
                        <th>사진</th>
                        <th>내용</th>
                        <th>신고</th>
                        <th>접수</th>
                        <th>처리중</th>
                        <th>처리완료</th>
                        <th>등록일시</th>
                        <th>삭제</th>
                        <th>&nbsp;</th>
                    </tr>
                    <%
                    if(v_list.size() > 0)
                    {
                    	for(int i = 0; i < v_list.size(); i++)
                    	{
                    		Biz_ivt_info obj = (Biz_ivt_info)v_list.elementAt(i);
                    %>
                    <tr>
                        <td><%=obj.getRn() %></td>
                        <td><%=obj.getProc_state_nm() %></td>
                        <td><%=obj.getHp_no() %></td>
                        <td><%=obj.getIvt_div_nm() %></td>
                        <td>
                        	<%if(obj.getAttach_file().length() > 0){ %><img src="../images/common/bl_camera.gif" width="16" height="14" /><%} %>
                        </td>
                        <td style="text-align:left">
                        	<a href="javascript:show_layout_form('detail_ivt');setDetail('<%=obj.getIvt_div_nm() %>','<%=obj.getAttach_file() %>','<%=obj.getContent()!=null?obj.getContent().replace(System.getProperty("line.separator"),"<br/>"):"" %>');">
                        	<%=CharacterSet.cutOfString(obj.getContent()!=null?obj.getContent():"",20) %>
                        	</a>
                        </td>
                        <td>
                        	<% if(obj.getProc_state_cd().equals("A8010001")){ %>○<%}else{ %><a href="#" onclick="change_state('<%=obj.getRec_num()%>','신고','A8010001')"><img src="../images/common/confirm.gif" alt="확인" /></a><%} %>
                        </td>
                        <td>
                        	<% if(obj.getProc_state_cd().equals("A8010002")){ %>○<%}else{ %><a href="#" onclick="change_state('<%=obj.getRec_num()%>','접수','A8010002')"><img src="../images/common/confirm.gif" alt="확인" /></a><%} %>
                        </td>
                        <td>
                        	<% if(obj.getProc_state_cd().equals("A8010003")){ %>○<%}else{ %><a href="#" onclick="change_state('<%=obj.getRec_num()%>','처리중','A8010003')"><img src="../images/common/confirm.gif" alt="확인" /></a><%} %>
                        </td>
                        <td>
                        	<% if(obj.getProc_state_cd().equals("A8010004")){ %>○<%}else{ %><a href="#" onclick="change_state('<%=obj.getRec_num()%>','처리완료','A8010004')"><img src="../images/common/confirm.gif" alt="확인" /></a><%} %>
                        </td>
                        <td><%=obj.getReg_dt() %></td> 
                        <td><a href="javascript:delete_ivt('<%=obj.getRec_num() %>');"><img src="../images/common/delete.gif" alt="삭제" /></a></td>
                        <td> </td>
                    </tr>
                    <%
                    	}
                    }
                    else 
                    {
                    %>
                    <tr>
                    	<td colspan="12">검색된 자료가없습니다.</td>
                    </tr>
                    <%
                    }
                    %>
                  </table>
            </div>
           	
        </div> 
       	<div style="margin-top:10px;text-align:center;"><%=PageNavi %></div>
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>
</body>
</html>
