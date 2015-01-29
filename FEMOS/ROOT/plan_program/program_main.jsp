<%@include file="../lib/session_chk.jsp" %>

<%@page import="com.util.PagingUtil"%>
<%@page import="com.plan.program.Dal_program_plan" %>
<%@page import="com.plan.program.Biz_program_plan" %>
<%@page import="com.util.CharacterSet"%>
<%@page import="java.util.*" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String sch_program_div = request.getParameter("sch_program_div")!=null?request.getParameter("sch_program_div").toString():"";
	String sch_importance = request.getParameter("sch_importance")!=null?request.getParameter("sch_importance").toString():"";
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div").toString():"PROGRAM_NM";
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val").toString()):"";
	
	String where  = "";
	
	where = where + " WHERE FESTIVAL_CD = '"+festival_cd+"'";
	
	if(sch_program_div.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + " PROGRAM_DIV = '"+sch_program_div+"'";
	}
	
	if(sch_importance.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + " IMPORTANCE = '"+sch_importance+"'";
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
	
	
	int recordCount = new Dal_program_plan().getProgram_count(where);
	int intPage = request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1;
	int list_size = request.getParameter("list_size")!=null?Integer.parseInt(request.getParameter("list_size")):15;
	int pagecount = (recordCount-1)/list_size +1;
	int intStartPoint = recordCount - (intPage - 1) * list_size;
	int intEndPoint = recordCount - (intPage) * list_size+1;
	
	Dal_program_plan list = new Dal_program_plan(); 
	list.getProgram_list(intStartPoint,intEndPoint,where);
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

<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',1);
	setMenu('menu_img',1);
	
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
	var objs = 'program_nm';
	var Msgs = '프로그램명을 입력해주세요.';
	var inner_layer = 'program_input_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		$("#program_hr option").each(function (i){
			$("#program_hr option").eq(i).attr('selected','selected');
		});
		document.getElementById('form1').action = 'program_save.jsp';
		document.getElementById('form1').submit();
	}
}

function edit()
{
	var objs = 'edit_program_nm';
	var Msgs = '프로그램명을 입력해주세요.';
	var inner_layer = 'program_edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer,'#fc0a1e'))
	{
		document.getElementById('form1').action = 'program_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function del()
{
	if(confirm('삭제하시겠습니까?'))
	{
		
		document.getElementById('form1').action = 'program_delete.jsp';
		document.getElementById('form1').submit();
		
	}	
}

function hr_search(obj_id,sch_div_id,sch_val_id)
{
	var str = ""; 
	var temp = "";
	var arr_temp;
	var temp_val = "";
	var temp_text = "";
	
	$.ajax({
	    url: 'hr_search_result.jsp',
	    type: 'POST',
	    data: 'festival_cd='+$('#festival_cd').val()+'&sch_div='+$('#'+sch_div_id).val()+'&sch_val='+$('#'+sch_val_id).val(),
	    dataType: 'html',
	    error: function(){
	        alert('Error loading html document');
	    },
	    success: function(responseText){
			
			if(responseText.replace(/\s/g, "") != '')
			{
				temp = responseText.replace(/\s/g, "");
				temp = temp.substring(0,temp.length-1);
				arr_temp = temp.split('&');

				for(var i = 0; i < arr_temp.length; i++)
				{
					temp_val = arr_temp[i].split('^')[0];
					temp_text = arr_temp[i].split('^')[1];
					
					str = str + "<option value = '"+temp_val+"'>"+temp_text+"</option>";
						
				}
				
				$("#"+obj_id).empty(); 
				$("#"+obj_id).append(str);
			}
			else
			{
				alert('검색 결과가 없습니다.');
			}
	    }
	});		
}

function hr_insert(base_obj_id,target_obj_id)
{
	var str = "";
	
	$("#"+base_obj_id+ " option:selected").each(function (i){
		str = str + "<option value = '"+$("#"+base_obj_id+ " option:selected").eq(i).val()+"'>"+$("#"+base_obj_id+ " option:selected").eq(i).text()+"</option>";
	});


	$("#"+base_obj_id+ " option:selected").each(function (i){
		$("#"+target_obj_id+ " option").each(function (j){
			if($("#"+base_obj_id+ " option:selected").eq(i).val() == $("#"+target_obj_id+ " option").eq(j).val())
			{
				$("#"+target_obj_id+ " option").eq(j).remove();
			}
		});
	});
	
	$("#"+base_obj_id+ " option:selected").remove();
	
	$("#"+target_obj_id).append(str);

}

function setEditForm(program_cd)
{
	
	$('#program_cd').val(program_cd);
	$('#edit_budget_form').empty();
	//$("#edit_program_hr").empty(); 
	var options = "<%=com.util.CodeUtil.getCodeListCombo("A30","") %>";
	$.ajax({
	    url: 'getProgram.jsp',
	    type: 'POST',
	    data: 'festival_cd='+$('#festival_cd').val()+'&program_cd='+$('#program_cd').val(),
	    dataType: 'html',
	    error: function(){
	        alert('Error loading html document');
	    },
	    success: function(responseText){
			
			if(responseText.replace(/\s/g, "") != '')
			{
				temp = responseText.replace(/\s/g, "");
				
				arr = temp.split('&');

				arr_temp1 = arr[0].split('^');
				
				$('#edit_program_nm').val(arr_temp1[2]);
				$('#edit_program_div').val(arr_temp1[3]);
				$('#edit_base_summary').val(arr_temp1[4].replace(/\@/g, "\n"));
				$('#edit_policy').val(arr_temp1[5].replace(/\@/g, "\n"));
				$('#edit_exec_target').val(arr_temp1[6]);
				
				$('input:radio[name="edit_importance"]').each(function (i){
					
					if($('input:radio[name="edit_importance"]').eq(i).val() == arr_temp1[7])
					{
						$('input:radio[name="edit_importance"]').eq(i).attr('checked',true);
					}
				});
				
				arr_temp2 = arr[1].split('#');

				var innerHtml = '';

				for(var i = 0; i < arr_temp2.length; i++)
				{
					temp_div = arr_temp2[i].split('^')[0];
					
					temp_money = arr_temp2[i].split('^')[1];
					
					if(temp_div)
					{
						innerHtml  = 			 '<div id="edit_budget" style="float:left;">';	
						innerHtml  = innerHtml + '	<div class="edit_budget_items" style="margin-top:5px;">';
						innerHtml  = innerHtml + '		<select name="edit_budget_div">';
						innerHtml  = innerHtml + options;
						innerHtml  = innerHtml + '		</select>';
						innerHtml  = innerHtml + '		<input name="edit_budget_money" type="text" style="width:100px;text-align:right" value="0" /> 원';
						innerHtml  = innerHtml + '	</div>';
						innerHtml  = innerHtml + '</div>';
						innerHtml  = innerHtml + '<div style="float:right;">';
						innerHtml  = innerHtml + '	<a href=javascript:addBudget("edit_")><img src="../images/btn/black_add_member.gif" alt="추가" /></a>';
						innerHtml  = innerHtml + '</div>';

						$('#edit_budget_form').append(innerHtml);
						
						
						$('select[name="edit_budget_div"]').eq(i).val(temp_div)
						$('input:text[name="edit_budget_money"]').eq(i).val(temp_money);
					}
				}
				
				//$('#edit_need_budget').val(arr_temp1[8]);
				
				/*
				arr_temp2 = arr[1].split('#');

				var option = '';
				
				for(var i = 0; i < arr_temp2.length; i++)
				{
					temp_val = arr_temp2[i].split('^')[0];
					
					temp_text = arr_temp2[i].split('^')[1];
					
					if(temp_val)
					{
						option = option + "<option value = '"+temp_val+"'>"+temp_text+"</option>";
					}	
				}

				if(option.length > 0) 
				{
					$("#edit_program_hr").empty(); 
					$("#edit_program_hr").append(option);
				}
				*/
			}
	    }
	});		
}




function search()
{
	$('#page').val(1);
}

function addBudget(division)
{
	
	$('#'+division+'budget').append($('.'+division+'budget_items').eq(0).clone().appendTo('#'+division+'budget'));
}

function removeBudget()
{
	
}

</script>
</head>

<body>
<form id="form1" method="post" action="">

<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
<input type="hidden" id="program_cd" name="program_cd" value="" />
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
            <%@include file="../include/plan_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        
        <div id="contents"> 
        	
        	<!-- 입력팝업창 시작 -->
			<%@include file="inc_program_input_form.jsp" %>	
			<%@include file="inc_program_edit_form.jsp" %>	
			<%@include file="inc_program_csv_form.jsp" %>	
            <!-- 입력팝업창 종료-->
            
            <div class="contitle">
                <h2><img src="../images/common/t_program.gif"/></h2>
            </div>
            <div class="contents1">
                <h3>프로그램 전체 리스트 및 검색</h3>
                <div class="searchbar">
                    <p class="searchbar_input">
                       	<select id="sch_program_div" name="sch_program_div" >
		                	<option value="">구분</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A10",sch_program_div) %>
		                </select>
                       	<select id="sch_importance" name="sch_importance" >
		                	<option value="">중요도</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A20",sch_importance) %>
		                </select>
		                <select name="sch_div">
                        	<option value="PROGRAM_NM" <%if(sch_div.equals("PROGRAM_NM")) {%>selected="selected" <%} %>>프로그램명</option>
                        	<option value="BASE_SUMMARY" <%if(sch_div.equals("BASE_SUMMARY")) {%>selected="selected" <%} %>>기본내용</option>
                        	<option value="POLICY" <%if(sch_div.equals("POLICY")) {%>selected="selected" <%} %>>추진방안</option>
                        	<option value="EXEC_TARGET" <%if(sch_div.equals("EXEC_TARGET")) {%>selected="selected" <%} %>>실행목표</option>
                        </select>
                        
                        <input id="sch_val" name="sch_val" type="text" value="<%=sch_val %>" />
                        <input type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" onclick="search();"/>    
                    </p>
                    <p class="searchbar_btn">
                    	<a href="javascript:show_layout_form('program_input_form');"><img src="../images/common/btn_input.gif" align="absmiddle"//></a> 
                    	<a href="javascript:show_layout_form('program_csv_form');"><img src="../images/common/btn_csv.gif" align="absmiddle"//></a> 
                    </p>
                </div>
                <!--// class="searchbar"-->
                <table  class="table1">
                    <colgroup>
                    <col width="40"/>
                    <col width="80"/>
                    <col width="400"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <col width="80"/>
                    <!-- 
                    <col width="80"/>
                    <col width="80"/>
                     -->
                    <col width="120"/>
                    </colgroup>
                    <tr>
                        <th>번호</th>
                        <th>구분</th>
                        <th>프로그램명</th>
                        <th>기본내용</th>
                        <th>추진방안</th>
                        <th>실행목표</th>
                        <th>중요도</th>
                        <th>필요예산(원)</th>
                        <!--
                        <th>행사장위치</th>
                        <th>지원인력수</th>
                         -->
                        <th>&nbsp;</th>
                    </tr>
                    <%
                    	if(v_list.size() > 0)
                    	{
                    		for(int i = 0; i < v_list.size(); i++)
                    		{
                    			Biz_program_plan obj = (Biz_program_plan)v_list.elementAt(i);
                    %>
  
                    <tr>
                        <td><%=obj.getRn() %></td>
                        <td><%=obj.getProgram_div_nm() %></td>
                        <td style="text-align:left">
                        	<a href="#" onclick="show_layout_form('program_edit_form');setEditForm('<%=obj.getProgram_cd() %>');"><%=obj.getProgram_nm() %></a>
                        </td>
                        <td colspan="3">
                        	<a href="#" onclick="show_layout_form('program_edit_form');setEditForm('<%=obj.getProgram_cd() %>');">[상세보기]</a></td>
                        <td><span style="color:<%=obj.getImportance_text_color() %>"><%=obj.getImportance_nm() %></span></td>
                        <td style="text-align:right"><%=CharacterSet.converToMoney(obj.getNeed_budget()) %></td>
                        <!-- 
                        <td>###</td>
                        <td style="text-align:right"><%=obj.getHr_count() %></td>
                         -->
                        <td>&nbsp;</td>
                    </tr>
                    <% 
                    		}
                    	} 
                    	else
                    	{
                    %>
                     <tr>
                        <td colspan="8">검색된 프로그램이 없습니다.</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%
                    	}
                    %>
            
                </table>
            </div>
            <!--// class="contents1 프로그램 전체 리스트 및 검색"--> 
            <div style="margin-top:10px;text-align:center;"><%=PageNavi %></div>
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
