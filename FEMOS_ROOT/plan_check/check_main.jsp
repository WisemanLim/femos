<%@include file="../lib/session_chk.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.plan.check.Dal_check_div" %>
<%@ page import="com.plan.check.Biz_check_div" %>
<%@ page import="com.plan.check.Dal_check_items" %>
<%@ page import="com.plan.check.Biz_check_items" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String check_cd = request.getParameter("check_cd") != null?request.getParameter("check_cd").toString():"";
	Dal_check_div chk_div = new Dal_check_div();
	chk_div.getCheckDivList(festival_cd);
	Vector div_list = chk_div.getV_list();
	
	String parent_check_cd = "";
	String check_nm = "";
	int leaf = 0;
	String check_nm_path = "";
	
	String moveUrl = "";
		
	Dal_check_items items = new Dal_check_items();
	items.getCheckItemsList(check_cd);
	Vector list = items.getV_list();
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=session.getAttribute("FESTIVAL_NM") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>
<script type="text/javascript" src="dtree.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',1);
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

function setCheckDivEditForm(check_cd,parent_check_cd,check_nm,leaf)
{
	if($('#check_cd').val() == '')
	{
		alert('선택된 그룹이 없습니다.');
	}
	else
	{
		show_layout_form('check_div_edit_form');
		$('#check_cd').val(check_cd);
		$('#leaf').val(leaf);
		$('#edit_check_cd').html(check_cd);
		$('#edit_parent_check_cd').val(parent_check_cd);
		$('#edit_check_nm').val(check_nm);
	}
}

function save_check_div()
{
	var objs = 'check_nm';
	var Msgs = '명칭을 입력해주세요';
	var inner_layer = 'check_div_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'check_div_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit_check_div()
{
	var objs = 'edit_check_nm';
	var Msgs = '명칭을 입력해주세요';
	var inner_layer = 'check_div_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'check_div_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function setCheckItemEditform(item_num,item_nm,summary,importance)
{
	show_layout_form('check_item_edit_form');
	$('#item_num').val(item_num);
	$('#edit_item_nm').val(item_nm);
	$('#edit_summary').val(summary);
	$('input:radio[name="edit_importance"]').each(function (i){
		
		if($('input:radio[name="edit_importance"]').eq(i).val() == importance)
		{
			$('input:radio[name="edit_importance"]').eq(i).attr('checked',true);
		}
	});
}

function del_check_div()
{
	if($('#leaf').val() == 0)
	{
		alert('하위그룹이 존재할 경우 삭제 할수 없습니다.');
	}
	else
	{
		if(confirm('체크리스트 구분을 삭제하시겠습니까?'))
		{
			document.getElementById('form1').action = 'check_div_delete.jsp';
			document.getElementById('form1').submit();
		}
	}
}

function save_check_item()
{
	var objs = 'item_nm';
	var Msgs = '명칭을 입력해주세요';
	var inner_layer = 'check_item_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'check_item_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit_check_item()
{
	var objs = 'edit_item_nm';
	var Msgs = '명칭을 입력해주세요';
	var inner_layer = 'check_item_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'check_item_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function del_check_item()
{
	if(confirm('체크항목을 삭제하시겠습니까?'))
	{
		document.getElementById('form1').action = 'check_item_delete.jsp';
		document.getElementById('form1').submit();
	}
}

</script>
</head>

<body>
<form id="form1" method="post" action="">

<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="check_cd" name="check_cd" value="<%=check_cd %>" />
<input type="hidden" id="leaf" name="leaf" value="<%=leaf %>" />
<input tupe="hidden" id="item_num" name="item_num" value="" />

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
        
         <div id="contents">
            <div class="contitle">
                <h2><img src="../images/common/t_check.gif"/></h2>
            </div>
            <div class="contents1">
                <h3>체크리스트</h3>
                <div class="check">
                   <div style="background:#f2f2f2;padding:5px;">
	                   <script type="text/javascript">
							<!--
					
							d = new dTree('d');
							d.add(0,-1,'<strong>체크리스트 구분</strong>');
							<%
								if(div_list.size() > 0)
								{
									
									for(int i = 0; i < div_list.size(); i++)
									{
										Biz_check_div div_obj = (Biz_check_div)div_list.elementAt(i);
										
										moveUrl = "check_main.jsp?festival_cd="+festival_cd+"&check_cd="+div_obj.getCheck_cd();
										if(check_cd.equals(div_obj.getCheck_cd()))
										{
											parent_check_cd = div_obj.getParent_check_cd();
											check_nm = div_obj.getCheck_nm();
											leaf = div_obj.getLeaf();
											check_nm_path = div_obj.getCheck_nm_path();
										}
							%>
										d.add('<%=div_obj.getCheck_cd()%>','<%=div_obj.getParent_check_cd()%>','<%=div_obj.getCheck_nm()%>','<%=moveUrl%>');
							<%
									}
								}
							%>
							document.write(d);
					
							//-->
						</script>
					</div>
					 <div style="margin-top:10px;padding:5px;text-align:center;">
	                	<a href="javascript:show_layout_form('check_div_input_form');"><img src="../images/common/group_add.gif" alt="그룹추가" /></a>
	                	<a href="javascript:setCheckDivEditForm('<%=check_cd %>','<%= parent_check_cd%>','<%= check_nm%>','<%=leaf %>');"><img src="../images/common/group_edit.gif" alt="그룹편집" /></a>
	                	<%if(check_cd.length() > 0){ %>
	                	<a href="javascript:show_layout_form('check_item_input_form');"><img src="../images/common/group_sub_add.gif" alt="체크항목등록" /></a>
	                	<%} %>
	                </div>
                </div>
                
                <%@include file="inc_check_div_input_form.jsp" %>
                <%@include file="inc_check_div_edit_form.jsp" %>	
                <%@include file="inc_check_item_input_form.jsp" %>	
                <%@include file="inc_check_item_edit_form.jsp" %>
                
                <!--// class="area"-->
                
                <div class="checkcon">
                    <table  class="table1">
                        <colgroup>
                        <col width="200"/>
                        <col width="350"/>
                        <col width="100"/>
                        
                        </colgroup>
                        <tr>
                            <th>명칭</th>
                            <th>설명</th>
                            <th>중요도</th>
                        </tr>
                        <%if(list.size() > 0)
                        {
                        	for(int i = 0; i < list.size(); i++)
                        	{
                        		Biz_check_items obj = (Biz_check_items)list.elementAt(i);
                        %>
                        <tr>
                            <td><a href="javascript:setCheckItemEditform('<%=obj.getItem_num() %>','<%=obj.getItem_nm() %>','<%=obj.getSummary() %>','<%=obj.getImportance() %>');"><%=obj.getItem_nm() %></a></td>
                            <td><%=obj.getSummary() %></td>
                            <td><span style="color:<%=obj.getImportance_text_color() %>"><%=obj.getImportance_nm() %></span></td>
                        </tr>
                        <%
                        	}
                        }
                        else
                        { 
                        	if(check_cd.length() == 0)
                        	{
                        %>
                        <tr>
                            <td colspan="3">체크리스트 구분을 선택해주세요.</td>
                        </tr>
                       	<% 	}
                        	else
                        	{
                       	%>
                       	 <tr>
                            <td colspan="3">등록된 체크 항목이 없습니다.</td>
                        </tr>
                        <%	}
                        } %>
                   		
                    </table>
                </div>
            </div>
            <!--// class="contents1">--> 
    </div>
    
</div>
<!--// id="bodywrap"-->
<div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
<!--// id="footer"--> 
<!--// id="allwrap"-->
</form>
</body>
</html>
