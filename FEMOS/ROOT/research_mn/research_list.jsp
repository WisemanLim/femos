<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.research.Biz_research" %>
<%@ page import="com.operation.research.Dal_research" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	int nowYear = java.util.Calendar.getInstance().get(java.util.Calendar.getInstance().YEAR);
	String sch_year =  request.getParameter("sch_year")!=null?request.getParameter("sch_year"):"";
	String sch_end_yn = request.getParameter("sch_end_yn")!=null?request.getParameter("sch_end_yn"):"";
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div"):"SV_TITLE";
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val")):"";
	
	String where = "";
	where = where + " WHERE FESTIVAL_CD = '"+festival_cd+"'";
	
	if(sch_year.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + " SUBSTR(SV_YYYYMM,1,4) = '"+sch_year+"'";
	}
	
	if(sch_end_yn.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + " SV_END_YN = '"+sch_end_yn+"'";
	}
	
	if(sch_val.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + sch_div + " like'%"+sch_val+"%' ";
	}
	
	int recordCount = new Dal_research().getResearch_list_count(where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_research list = new Dal_research(); 
	list.getResearch_list(intStartPoint,intEndPoint,where);
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
		$("#"+obj_id).show(500);
	}
}

function hide_layout_form(obj_id)
{
	$("#"+obj_id).hide(500);
}

</script>
</head>

<body>
<form id="form1" method="post" action="research_list.jsp">

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
                <h2><img src="../images/common/t_24.gif" alt="설문조사"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>설문조사 목록</h3>
                <div class="searchbar">
	                <p class="searchbar_input">
	                	  <select id="sch_year" name="sch_year">
							<option value="">설문년도</option>
							<%
								
								for(int i = 2012; i <= nowYear; i++)
								{
							%>
							<option value="<%=i%>" <%if(Integer.toString(i).equals(sch_year)){%> selected="selected" <%} %> ><%=i%></option>	
							<%
								} 
							%>
						</select>
						<select id="sch_end_yn" name="sch_end_yn">
							<option value="">진행여부</option>
							<option value="N" <%if(sch_end_yn.equals("N")){%> selected="selected" <%} %>>진행</option>
							<option value="Y" <%if(sch_end_yn.equals("Y")){%> selected="selected" <%} %>>만료</option>
						</select>
						<select id="sch_div" name="sch_div">
							<option value="SV_TITLE" <%if(sch_div.equals("SV_TITLE")){%> selected="selected" <%} %>>설문제목</option>
							<option value="OTHER" <%if(sch_div.equals("OTHER")){%> selected="selected" <%} %>>비고</option>
						</select>
						<input type="text" id="sch_val" name="sch_val" value="<%=sch_val%>" />
						<input type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" />
	                </p>
	                <p class="searchbar_btn">
	                	<a href="research_write.jsp"><img src="../images/common/btn_input.gif" align="absmiddle" /></a>
	                </p>
	            </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                	<colgroup>
                		<col width="100px"/>
						<col width="330px"/>
						<col width="80px"/>
						<col width="100px"/>
						<col width="100px"/>
						<col width="80px"/>
						<col width="220px"/>
						<col width="*"/>
                	</colgroup>
                	<tr>
                		<th>설문ID</th>
						<th>설문제목</th>
						<th>설문년월</th>
						<th>진행여부</th>
						<th>설문그룹 / 문항</th>
						<th>참여인원</th>
						<th>보기</th>
						<th>&nbsp;</th>
                	</tr>   
                	<%
                		if(v_list.size() > 0)
                		{
	                		for(int i = 0; i < v_list.size(); i++)
	                		{
	                			Biz_research obj = (Biz_research)v_list.elementAt(i);
                	%>
                	<tr>
                		<td><%=obj.getSv_id() %></td>
                		<td style="text-align:left"><%=obj.getSv_title() %></td>
                		<td><%=obj.getSv_yyyymm().substring(0,4) %>.<%=obj.getSv_yyyymm().substring(4,6) %></td>
                		<td>
                			<%if(obj.getSv_end_yn().equals("N")){ %>
                			진행
                			<%}else{ %>
                			만료
                			<%}%>
                		</td>
                		<td><%=obj.getGroup_cnt() %>/<%=obj.getQ_cnt() %></td>
                		<td><%=obj.getUser_cnt() %></td>
                		<td>
                			<a href="research_view.jsp?sv_id=<%=obj.getSv_id() %>"><img src="../images/btn/detail_view.gif" alt="상세보기"/></a>
                			<a href="research_preview.jsp?sv_id=<%=obj.getSv_id() %>"><img src="../images/btn/preview.gif" alt="미리보기"/></a>
                			<a href="research_stat.jsp?sv_id=<%=obj.getSv_id() %>"><img src="../images/btn/stat.gif" alt="통계"/></a>
                		</td>
                		<td>&nbsp;</td>
                	</tr>	
                	<%
                			}
                		}
                		else
                		{
                	%>
                	<tr>
                		<td colspan="7">검색 된 설문이 없습니다.</td>
                		<td>&nbsp;</td>
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
