<%@page import="com.util.CharacterSet"%>
<%@include file="../lib/session_chk.jsp" %>
<%@page import="com.plan.budget.Dal_budget"%>
<%@page import="com.plan.budget.Biz_budget"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	
	Dal_budget budget = new Dal_budget();
	budget.getBudgetList("A30",festival_cd);
	Vector list = budget.getV_list();
%>
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
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',1);
	setMenu('menu_img',2);
	
	$(".popup1").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});
});

function show_layout_form(obj_id,budget_div,budget_div_nm)
{
	document.getElementById('form1').reset();
	for(var i = 0; i < $(".popup1").length; i++)
	{
		$(".popup1").eq(i).hide();
		$("#"+obj_id).show();
		$("#budget_div").val(budget_div);
		$("#budget_div_nm").html(budget_div_nm);
		
	}
}

function show_layout(obj_id)
{
	$("#"+obj_id).show();
}
function hide_layout_form(obj_id)
{
	$("#"+obj_id).hide();
}

function save_budget_div()
{
	var objs = 'div_nm';
	var Msgs = '명칭을 입력해주세요.';
	var inner_layer = 'budget_div_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'budget_div_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit_budget_div()
{
	var objs = 'edit_div_nm';
	var Msgs = '명칭을 입력해주세요.';
	var inner_layer = 'budget_div_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'budget_div_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function save()
{
	var objs = 'detail_history,budget_money,comp_ratio';
	var Msgs = '상세내역을 입력해주세요.,예산액을 입력해주세요,구성비를 입력해주세요,';
	var inner_layer = 'budget_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'budget_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit()
{
	var objs = 'edit_detail_history,edit_budget_money,edit_comp_ratio';
	var Msgs = '상세내역을 입력해주세요.,예산액을 입력해주세요,구성비를 입력해주세요,';
	var inner_layer = 'budget_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'budget_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function del()
{
	if(confirm('삭제하시겠습니까?'))
	{
		document.getElementById('form1').action = 'budget_del.jsp';
		document.getElementById('form1').submit();
	}
}

function setEditForm(festival_cd,rec_num,budget_div,budget_div_nm,detail_history,budget_money,comp_ratio,other)
{
	
	for(var i = 0; i < $(".popup1").length; i++)
	{
		$(".popup1").eq(i).hide();
		$("#budget_edit_form").show();
	}
	
	$("#festival_cd").val(festival_cd);
	$("#rec_num").val(rec_num);
	$("#edit_budget_div").val(budget_div);
	$("#edit_budget_div_nm").html(budget_div_nm);
	$("#edit_detail_history").val(detail_history);
	$("#edit_budget_money").val(budget_money);
	$("#edit_comp_ratio").val(comp_ratio);
	$("#edit_other").val(other);
}

function setEditBudgetDivForm(budget_div, budget_div_nm)
{
	$("#budget_div").val(budget_div); 
	$("#edit_div_nm").val(budget_div_nm);
}

</script>
</head>

<body>
<form id="form1" method="post" action="">

<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="budget_div" name="budget_div" value="" />
<input type="hidden" id="rec_num" name="rec_num" value="" />

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
        	
        	<%@include file="inc_budget_div_input_form.jsp" %>
        	<%@include file="inc_budget_div_edit_form.jsp" %>
        	
        	<%@include file="inc_budget_input_form.jsp" %>	
        	<%@include file="inc_budget_edit_form.jsp" %>	
        	
            <div class="contitle">
                <h2><img src="../images/common/t_budget.gif"/></h2>
            </div>
            <div class="contents1">
                <h3>예산 입력</h3>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="200"/>
                    <col width="200"/>
                    <col width="200"/>
                    <col width="200"/>
                    <col width="200"/>
                    </colgroup>
                    <tr>
                        <th>구분</th>
                        <th>상세내역</th>
                        <th>예산액(원)</th>
                        <th>구성비(%)</th>
                        <th>비고</th>
                        <th>&nbsp;</th>
                    </tr>
                    <!-- 인건비-------------------->
                    <%
                    	int tot_budget_money = 0;
                    	String program_key = "";
                    	if(list.size() > 0)
                    	{
                    		for(int i = 0; i < list.size(); i++)
                    		{
                    			Biz_budget obj = (Biz_budget)list.elementAt(i);
                    			Dal_budget s_budget = new Dal_budget();
                    			s_budget.getBudgetSubList(festival_cd,obj.getBudget_div());
                    			Vector s_v_list = s_budget.getV_list();
                    			for(int j = 0; j < s_v_list.size(); j++)
                    			{
                    				Biz_budget s_obj = (Biz_budget)s_v_list.elementAt(j);
                    				
                    				tot_budget_money = tot_budget_money + s_obj.getBudget_money();
                    				
                    				program_key = s_obj.getProgram_key()!=null?s_obj.getProgram_key():"";
                    %>
                    <tr>
                     <% if(j == 0) {%>
                        <td class="sp" rowspan="<%=obj.getCnt()+1 %>"><%=obj.getBudget_div_nm() %></td>
                     <% }%>
                        <td>
                        	<%if(program_key.equals("")){ %>
                        	<a href="#" onclick="setEditForm('<%=s_obj.getFestival_cd() %>','<%=s_obj.getRec_num() %>','<%=s_obj.getBudget_div() %>','<%=obj.getBudget_div_nm() %>','<%=s_obj.getDetail_history() %>','<%=s_obj.getBudget_money() %>','<%=s_obj.getComp_ratio() %>','<%=s_obj.getOther() %>')"><%=s_obj.getDetail_history()%></a>
                        	<%}else{ %>
                        	<%=s_obj.getDetail_history()%>
                        	<%} %>
                        </td>
                        <td style="text-align:right;"><%=CharacterSet.converToMoney(s_obj.getBudget_money()) %> 원</td>
                        <td style="text-align:right;"><%=s_obj.getComp_ratio() %> %</td>
                        <td><%=s_obj.getOther() %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    				
                    			}
                   
                    			if(obj.getCnt() == 0)
                    			{
                    %>
                    <tr>
                        <td class="sp"><a href="javascript:show_layout('budget_div_edit_form');setEditBudgetDivForm('<%=obj.getBudget_div() %>', '<%=obj.getBudget_div_nm() %>');"><%=obj.getBudget_div_nm() %></a></td>
                        <td><a href="javascript:show_layout_form('budget_input_form','<%=obj.getBudget_div()%>','<%=obj.getBudget_div_nm() %>');"><img src="../images/common/btn_add2.gif"/></a></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%        
                    			}
                    			else
                    			{
                    %>
                    <tr>
                        <td><a href="javascript:show_layout_form('budget_input_form','<%=obj.getBudget_div()%>','<%=obj.getBudget_div_nm() %>');"><img src="../images/common/btn_add2.gif"/></a></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%				
                    			}
                    		}
                    	}
                    %>
                 	 <tr>
                 	 	<td class="sp"><a href="javascript:show_layout('budget_div_input_form');"><img src="../images/common/btn_add2.gif"/></a></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="6" class="gap"></td>
                    </tr>
                    <!--// 업무추진비-------------------->
                </table>
                <div class="total">예산총액:<%=CharacterSet.converToMoney(tot_budget_money)%> 원</div>
            </div>
            <!--// class="contents1 예산입력"--> 
        </div>
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
