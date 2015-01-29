<%@include file="../lib/session_chk.jsp" %>
<%@ page import="com.util.PagingUtil"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.satisfaction.Biz_satisfaction" %>
<%@ page import="com.operation.satisfaction.Dal_satisfaction" %>
<%@ page import="com.plan.smu.Biz_smu_base" %>
<%@ page import="com.plan.smu.Dal_smu_base" %>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String sch_festival_hall_cd = request.getParameter("sch_festival_hall_cd")!=null?request.getParameter("sch_festival_hall_cd"):"";
	String sch_grade = request.getParameter("sch_grade")!=null?request.getParameter("sch_grade"):"";
	String sch_sex = request.getParameter("sch_sex")!=null?request.getParameter("sch_sex"):"";
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div"):"VISITER_NM";
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val")):"";
		
	
	String where  = "";
	
	if(sch_festival_hall_cd.length() > 0)
	{
		where = where + " AND B.FESTIVAL_HALL_CD = '" + sch_festival_hall_cd + "' ";
	}
	if(sch_grade.length() > 0)
	{
		where = where + " AND GRADE = " + sch_grade;
	}
	if(sch_sex.length() > 0)
	{
		where = where + " AND SEX = '" + sch_sex + "' ";
	}
	if(sch_val.length() > 0)
	{
		where = where + " AND "+sch_div+" like '%" + sch_val + "%' ";
	}
	
	
	int recordCount = new Dal_satisfaction().getSatisfaction_count(festival_cd,where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_satisfaction satisfaction = new Dal_satisfaction();
	satisfaction.getSatisfaction_list(festival_cd,where,intStartPoint,intEndPoint);
	Vector v_list = satisfaction.getV_list();
	
	String PageNavi = PagingUtil.Paging_post(intPage,list_size,recordCount);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<form id="form1" method="post" action="satisfaction_main.jsp">

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
			
            <div class="contitle">
                <h2><img src="../images/common/t_23.gif"/></h2>
            </div>
            
 			<div class="contents1">
                <h3>축제 행사장 평가 현황</h3>
                <div class="searchbar">
                    <p class="searchbar_input">
                        <select id="sch_festival_hall_cd" name="sch_festival_hall_cd">
                        	<option value="">행사장 선택</option>
                        	<%
                        		Dal_smu_base festival_hall = new Dal_smu_base();
                        		festival_hall.get_smu_base_list(festival_cd);
                        		Vector v_hall_list = festival_hall.getV_list();
                        		for(int i = 0; i < v_hall_list.size(); i++)
                        		{
                        			Biz_smu_base hall = (Biz_smu_base)v_hall_list.elementAt(i); 
                        	%>
                        	<option value="<%=hall.getFestival_hall_cd() %>" <%if(sch_festival_hall_cd.equals(hall.getFestival_hall_cd())){ %>selected="selected"<%} %>><%=hall.getFestival_hall_nm() %></option>	
                        	<%
                        		}
                        	%>
                        </select>
                        <select id="sch_grade" name="sch_grade">
                        	<option value="">만족도 선택</option>
                        	<option value="1" <%if(sch_grade.equals("1")) {%>selected="selected"<%} %>>매우만족</option>
                        	<option value="2" <%if(sch_grade.equals("2")) {%>selected="selected"<%} %>>만족</option>
                        	<option value="3" <%if(sch_grade.equals("3")) {%>selected="selected"<%} %>>보통</option>
                        	<option value="4" <%if(sch_grade.equals("4")) {%>selected="selected"<%} %>>불만</option>
                        	<option value="5" <%if(sch_grade.equals("5")) {%>selected="selected"<%} %>>매우불만</option>
                        </select>
                        <select id="sch_sex" name="sch_sex">
                        	<option value="">성별 선택</option>
                        	<option value="male" <%if(sch_sex.equals("male")) { %>selected="selected"<%} %>>남</option>
                        	<option value="fmale" <%if(sch_sex.equals("fmale")) { %>selected="selected"<%} %>>여</option>
                        </select>
                     	<select id="sch_div" name="sch_div">
                     		<option value="VISITER_NM" <%if(sch_div.equals("VISITER_NM")){ %>selected="selected"<%} %>>이름</option>
                     		<option value="HP" <%if(sch_div.equals("HP")){ %>selected="selected"<%} %>>연락처</option>
                     		<option value="EMAIL" <%if(sch_div.equals("EMAIL")){ %>selected="selected"<%} %>>메일주소</option>
                     	</select>
                        <input type="text" id="sch_val" name="sch_val" value="<%=sch_val %>" />
                        <input type="image" src="../images/common/btn_search.gif" align="absmiddle"/>
                    </p>
                    <p class="searchbar_btn"><a href="satisfaction_stat.jsp"><img src="../images/common/btn_statistics.gif" align="absmiddle"//></a> </p>
                </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="80px"/>
                    <col width="200px"/>
                    <col width="140px"/>
                    <col width="120px"/>
                    <col width="160px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                    <col width="70px"/>
                     <col width="100px"/>
                    <col width="*"/>
                    </colgroup>
                    <tr>
                        <th>번호</th>
                        <th>행사장</th>
                        <th>이름</th>
                        <th>연락처</th>
                        <th>메일주소</th>
                        <th>성별</th>
                        <th>매우만족</th>
                        <th>만족</th>
                        <th>보통</th>
                        <th>불만</th>
                        <th>매우불만</th>
                        <th>평가일자</th>
                        <th>&nbsp;</th>
                    </tr>
                    <%
                    if(v_list.size() > 0)
                    {
                    	for(int i = 0; i < v_list.size(); i++)
                    	{
                    		Biz_satisfaction obj = (Biz_satisfaction)v_list.elementAt(i);
                    %>
                    <tr>
                        <td><%=obj.getRnum() %></td>
                        <td><%=obj.getFestival_hall_nm() %></td>
                        <td><%=obj.getVisiter_nm() %></td>
                        <td><%=obj.getHp() %></td>
                        <td><%=obj.getEmail() %></td>
                        <td><%=obj.getSex().equals("male")?"남":"여"%></td>
                        <td><%=obj.getGrade_1()!=null?obj.getGrade_1():"" %></td>
                        <td><%=obj.getGrade_2()!=null?obj.getGrade_2():"" %></td>
                        <td><%=obj.getGrade_3()!=null?obj.getGrade_3():"" %></td>
                        <td><%=obj.getGrade_4()!=null?obj.getGrade_4():"" %></td>
                        <td><%=obj.getGrade_5()!=null?obj.getGrade_5():"" %></td>
                        <td><%=obj.getSatisfied_ymd() %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    	}
                    
                    }
                    else
                    {
                    %>
                    <tr>
                        <td colspan="12">검색 된 정보가 없습니다.</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    }
                    %>
                  </table>
            </div>
            <!--// class="contents1 축제 행사장 평가 현황"--> 
        </div>
        <!--// id="contents"--> 
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
