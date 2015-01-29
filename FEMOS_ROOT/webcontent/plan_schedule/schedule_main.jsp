<%@include file="../lib/session_chk.jsp" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.plan.smu.Dal_smu_base" %>
<%@ page import="com.plan.smu.Biz_smu_base" %>
<%@ page import="com.plan.schedule.Dal_schedule_plan" %>
<%@ page import="com.plan.schedule.Biz_schedule_plan" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = session.getAttribute("FESTIVAL_CD")!=null?session.getAttribute("FESTIVAL_CD").toString():"";
	String festival_hall_cd = request.getParameter("festival_hall_cd") != null ? request.getParameter("festival_hall_cd") : "";
	Dal_smu_base smu = new Dal_smu_base();
	smu.get_smu_base_list(festival_cd);
	Vector list = smu.getV_list();
	
	int pk_id = request.getParameter("pk_id")!= null?Integer.parseInt(request.getParameter("pk_id")):0;
	String view = request.getParameter("view")!= null ? request.getParameter("view").toString():"month";
	
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="./datepicker/css/jquery.ui.all.css" />
<link rel='stylesheet' type='text/css' href='./fullcalendar/fullcalendar.css' />
<link rel='stylesheet' type='text/css' href='./fullcalendar/fullcalendar.print.css' media='print' />

<link rel="stylesheet" type="text/css" href="../css/femos_common.css">

<script type='text/javascript' src='./jquery/jquery-1.7.1.min.js'></script>
<script type='text/javascript' src='./jquery/jquery-ui-1.8.17.custom.min.js'></script>
<script type='text/javascript' src='./fullcalendar/fullcalendar.min.js'></script>

<link rel="stylesheet" href="./colorpicker/css/colorpicker.css" type="text/css" />
<script type="text/javascript" src="./colorpicker/js/colorpicker.js"></script>
<script type="text/javascript" src="./colorpicker/js/eye.js"></script>
<script type="text/javascript" src="./colorpicker/js/utils.js"></script>
<script type="text/javascript" src="./datepicker/jquery.ui.core.js"></script>
<script type="text/javascript" src="./datepicker/jquery.ui.widget.js"></script>
<script type="text/javascript" src="./datepicker/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="../js/dragable/jquery-ui.min.js"></script>
<script type="text/javascript" src="../js/common.js"></script>   

<script type='text/javascript'>

function show_layout_form(obj_id)
{
	for(var i = 0; i < $(".drag").length; i++)
	{
		$(".drag").eq(i).hide();
		$("#"+obj_id).show();
	}
}
	
function hide_layout_form(obj_id)
{
	$("#"+obj_id).hide();
}


function init_form(st_ymd_obj,ed_ymd_obj,st_ymd,ed_ymd)
{
	$('#'+st_ymd_obj).val(st_ymd);
	$('#'+ed_ymd_obj).val(ed_ymd);
}

function init_edit_form(pk_id)
{
	var resultStr = "";
	var arr_all;
	var arr_result;
	var temp = "";
	var arr_temp;
	var temp_val = "";
	var temp_text = "";
	var str = "";

	$.ajax({
	    url: 'schedule_detail.jsp',
	    type: 'POST',
	    data: 'pk_id='+pk_id,
	    dataType: 'html',
	    error: function(){
	        alert('Error loading html document');
	    },
	    success: function(responseText){
			
			if(responseText.replace(/\s/g, "") != '' > 0)
			{
				resultStr = responseText.replace(/\s/g, "");
				
				arr_all = resultStr.split('&');
				arr_result = arr_all[0].split('^');	
				
				$('#pk_id').val(pk_id);	

				$("#edit_program_search_result").empty(); 
				$("#edit_program_search_result").append('<option value="'+arr_result[0]+'">'+arr_result[1]+'</option>');
				
				$('#edit_st_ymd').val(arr_result[2]);
				$('#edit_st_hour').val(arr_result[3]);
				$('#edit_st_minute').val(arr_result[4]);
				$('#edit_ed_ymd').val(arr_result[5]);
				$('#edit_ed_hour').val(arr_result[6]);
				$('#edit_ed_minute').val(arr_result[7]);
				$('#edit_schedule_content').val(arr_result[8].replace(/\@/g, "\n"));
				$('#edit_bg_color_box').css('background','#'+arr_result[9]);
				$('#edit_bg_color').val(arr_result[9]);
				$('#edit_text_color_box').css('background','#'+arr_result[10]);
				$('#edit_text_color').val(arr_result[10]);
				$('#edit_schedule_title').val(arr_result[11]);

				
				temp = arr_all[1].substring(0,arr_all[1].length-1);
				
				arr_temp = temp.split('#');
				
				
				for(var i = 0; i < arr_temp.length; i++)
				{
					temp_val = arr_temp[i].split('^')[0];
					
					temp_text = arr_temp[i].split('^')[1];
					
					str = str + "<option value = '"+temp_val+"'>"+temp_text+"</option>";
						
				}
				if(temp_val.length > 0)
				{
					$("#edit_program_hr").empty(); 
					$("#edit_program_hr").append(str);
				}
			}
	    }
	});	
}

function planInsertAction()
{
	
	var objs = 'st_ymd,ed_ymd,schedule_title,schedule_content';
	var Msgs = '시작일시를 입력해주세요.,종료일시를 입력해주세요.,제목을 입력해주세요.,내용을 입력해주세요.';
	var inner_layer = 'error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer))
	{
		$('#view').val($('#calendar').fullCalendar('getView').name);

		if($("#program_hr option").length > 0)
		{
			$("#program_hr option").each(function (i){
				$("#program_hr option").eq(i).attr('selected','selected');
			});
		}
		
		document.getElementById('form1').action = 'schedule_save.jsp';
		document.getElementById('form1').submit();
	}
}

function planEditAction()
{
	
	var objs = 'edit_st_ymd,edit_ed_ymd,edit_schedule_title,edit_schedule_content';
	var Msgs = '시작일시를 입력해주세요.,종료일시를 입력해주세요.,제목을 입력해주세요.,내용을 입력해주세요.';
	var inner_layer = 'edit_error_msg';
	
	if(CheckForm(objs,Msgs,inner_layer))
	{
		$('#view').val($('#calendar').fullCalendar('getView').name);

		if($("#edit_program_hr option").length > 0)
		{
			$("#edit_program_hr option").each(function (i){
				$("#edit_program_hr option").eq(i).attr('selected','selected');
			});
		}
		document.getElementById('form1').action = 'schedule_edit.jsp';
		document.getElementById('form1').submit();
	}
}

function planDelAction()
{
	if(confirm('일정을 삭제하시겠습니까?'))
	{
		location.href='schedule_del.jsp?festival_cd='+$("#festival_cd")+'&festival_hall_cd='+$("#festival_hall_cd").val()+'&pk_id='+$("#pk_id").val();
	}
}

function program_search(sch_program_div,sch_importance,sch_div,sch_val,program_search_result)
{
	var arr_temp;
	var temp_val = "";
	var temp_text = "";
	var str = "";
	
	if(document.getElementById(sch_val).value.length > 0)
	{
		$.ajax({
		    url: 'program_search.jsp',
		    type: 'POST',
		    data: 'festival_cd='+$('#festival_cd').val()+'&sch_program_div='+$('#'+sch_program_div).val()+'&sch_importance='+$('#'+sch_importance).val()+'&sch_div='+$('#'+sch_div).val()+'&sch_val='+$('#'+sch_val).val(),
		    dataType: 'html',
		    error: function(){
		        alert('Error loading html document');
		    },
		    success: function(responseText){
				
				if(responseText.replace(/\s/g, "") != '' > 0)
				{
					arr_temp = responseText.replace(/\s/g, "").split('^');

					for(var i = 0; i < arr_temp.length; i++)
					{
						
						temp_val = arr_temp[i].split('#')[0];
						temp_text = arr_temp[i].split('#')[1];
						
						str = str + "<option value = '"+temp_val+"'>"+temp_text+"</option>";
					}

					$("#"+program_search_result).empty(); 
					$("#"+program_search_result).append(str);
					
				}
				else
				{
					alert('검색된 결과가 없습니다.');
					//document.getElementById('form1').action = 'hr_save.jsp';
					//document.getElementById('form1').submit();
				}
		    }
		});	
	}
	else
	{
		alert('검색어를 입력해주세요.');
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
	
</script>
<style type='text/css'>
	
	#calendar {
		width: 780px;
		margin-top:10px;
		padding:10px;
		float:right;
		border:1px solid #ccc;
		background:#fff;
	}
	
	.tb_schedule_form table {
		width:100%;
		border:1px solid #ccc;
	}
	
	.tb_schedule_form th {
		font-size:12px;
		font-weight:bold;
		color:#777;
		background:#eee;
		width:100px;
		
	}
	
	.tb_schedule_form td {
		font-size:12px;
		font-weight:normal;
		padding:2px;
		background:#fff;
	}
	
	#input_schedule_form {
		position:absolute;
		border:4px solid #aaa;
		width:560px;padding:10px;
		z-index:998;
		display:none;
		background:#fff;
	}
	
	#edit_schedule_form {
		position:absolute;
		border:4px solid #aaa;
		width:560px;padding:10px;
		z-index:998;
		display:none;
		background:#fff;
	}
	
</style>

<title>Untitled Document</title>
</head>

<body>
<form id="form1" method="post" action="">


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
                <h2><img src="../images/common/t_schedule.gif"/></h2>
            </div>
            <div class="contents1">
                <h3>일정보기</h3>
                <div class="area">
                    <ul>
                    	<!-- 
                        <li>
                            <div class="areahead">구역_1</div>
                        </li>
                         -->
                        <%
                        String areaselect = "";
                        String festival_hall_nm = "";
                        if(list.size() > 0)
                        { 
                        	for(int i = 0; i < list.size(); i++)
                        	{
                        		Biz_smu_base obj = (Biz_smu_base)list.elementAt(i);
                        		if(festival_hall_cd.length() == 0 && i == 0)
                        		{
                        			festival_hall_cd = obj.getFestival_hall_cd();
                        		}
                        		
                        		if(festival_hall_cd.equals(obj.getFestival_hall_cd()))
                        		{
                        			areaselect = "class='areaselect'";
                        			festival_hall_nm = obj.getFestival_hall_nm();
                        		}
                        %>
                        <li>
                            <div <%=areaselect %>><a href="schedule_main.jsp?festival_cd=<%=obj.getFestival_cd() %>&festival_hall_cd=<%=obj.getFestival_hall_cd() %>"><%=obj.getFestival_hall_nm() %></a></div>
                        </li>
                        <%
                        	}
                        } 
                        %>   
                    </ul>
                </div>
                <!--// class="area"-->
                
                <div class="calender">
                    <h3><%=festival_hall_nm %></h3>
                    <p>
                    	<div id="calendar"></div>
                    	<%@include file="inc_schedule_input_form.jsp" %>	
                    	<%@include file="inc_schedule_edit_form.jsp" %>
                    </p>
                </div>
                <!--// class="calender"--> 
                
            </div>
            <!--// class="contents1">--> 
            
        </div>
        <!--// id="contents"--> 
    </div>
    <!--// id="bodywrap"-->
    <input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
	<input type="hidden" id="festival_hall_cd" name="festival_hall_cd" value="<%=festival_hall_cd %>" />
	<input type="hidden" id="view" name="view" value="" />
	<input type="hidden" id="pk_id" name="pk_id" value="" />
    
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->
</form>

<script type="text/javascript">

$(document).ready(function() {

	setMenu('left_menu_img',1);
	setMenu('menu_img',5);
	
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
	
	$('#bg_color,#text_color').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$('#'+el.id+'_box').css('background',hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});

	$('#edit_bg_color,#edit_text_color').ColorPicker({
		onSubmit: function(hsb, hex, rgb, el) {
			$(el).val(hex);
			$('#'+el.id+'_box').css('background',hex);
			$(el).ColorPickerHide();
		},
		onBeforeShow: function () {
			$(this).ColorPickerSetColor(this.value);
		}
	})
	.bind('keyup', function(){
		$(this).ColorPickerSetColor(this.value);
	});

	$(".drag").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});
	
	var date = new Date();
	
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	var h = date.getHours();
	var mi = date.getMinutes();
	
	function retDate(dt)
	{
		var ret = '';
		var yyyy = dt != null ? dt.getFullYear() : '';
		var mm = dt != null ? dt.getMonth()+1 : '';
		var dd = dt != null ? dt.getDate() : '';
		var hh = dt != null ? dt.getHours() : '';
		var mi = dt != null ? dt.getMinutes() : '';

		if (dt != null)
		{
			ret = yyyy+'-'+getDateString(mm)+'-'+getDateString(dd)+' '+getDateString(hh)+':'+getDateString(mi);
		}
		else
		{
			ret = '';
		}

		return ret;
	}

	function retYmd(dt)
	{
		var ret = '';
		var yyyy = dt != null ? dt.getFullYear() : '';
		var mm = dt != null ? dt.getMonth()+1 : '';
		var dd = dt != null ? dt.getDate() : '';

		if (dt != null)
		{
			ret = yyyy+'-'+getDateString(mm)+'-'+getDateString(dd);
		}
		else
		{
			ret = '';
		}

		return ret;
	}

	function getDateString(number_dt)
	{
		
		var ret = '';
		if (number_dt.toString().length == 1)
		{
			ret = '0'+number_dt;
		}
		else
		{
			ret = number_dt.toString();
		}
		return ret;
	}

	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		titleFormat: 
		{
			month: 'yyyy년 MMMM',
			week: "yyyy년 MMM d일{ '~' yyyy년 MMM d일 }",
			day: 'yyyy년 MMM d일 dddd'
		},
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		columnFormat: {
			month: 'ddd',
			week: 'M/d ddd',
			day: 'M/d ddd'
		},
		timeFormat: 
		{ // for event elements
			'': 'h(:mm)t' // default
		},
		buttonText: 
		{
			prev: '&nbsp;&#9668;&nbsp;',
			next: '&nbsp;&#9658;&nbsp;',
			prevYear: '&nbsp;&lt;&lt;&nbsp;',
			nextYear: '&nbsp;&gt;&gt;&nbsp;',
			today: '오늘',
			month: '월간',
			week: '주간',
			day: '일간'
		},
		//defaultView: 'agendaMonth',	
		defaultView: 'month',
		weekends: true,
		eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) // Drop callback 
		{
			location.href = 'schedule_date_move.jsp?festival_cd=<%=festival_cd%>&pk_id='+event.id+'&day='+dayDelta+'&minute='+minuteDelta+'&view='+$('#calendar').fullCalendar('getView').name+'&festival_hall_cd='+$("#festival_hall_cd").val();
		},
		eventClick: function(event) // Click item
		{
			//location.href = "schedule_main.jsp?festival_cd=<%=festival_cd%>&pk_id="+event.id+"&view="+$('#calendar').fullCalendar('getView').name;
			//alert('ID:'+event.id+'\n제목:'+event.title+'\n시작:'+retDate(event.start)+'\n종료:'+retDate(event.end));	
			show_layout_form('edit_schedule_form');
			init_edit_form(event.id);
		},
		dayClick: function(date, allDay, jsEvent, view) 
		{
			/*
	        if (allDay) {
	            alert('Clicked on the entire day: ' + date);
	        }else{
	            alert('Clicked on the slot: ' + date);
	        }

	        alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);

	        alert('Current view: ' + view.name);
			*/
	        // change the day's background color just for fun
	        //$(this).css('background-color', 'red');

			show_layout_form('input_schedule_form');
			//기본값셋팅!!
			init_form('st_ymd','ed_ymd',retYmd(date),retYmd(date));
			
	        
	    },					
		eventResize: function(event,dayDelta,minuteDelta,revertFunc) // Item resize
		{
	    	location.href = 'schedule_date_add.jsp?festival_cd=<%=festival_cd%>&pk_id='+event.id+'&day='+dayDelta+'&minute='+minuteDelta+'&view='+$('#calendar').fullCalendar('getView').name+'&festival_hall_cd='+$("#festival_hall_cd").val();
		},
		editable: true,
		events: 
		[
			<%=com.util.ScheduleUtil.getScheduleEventItems(festival_cd,festival_hall_cd)%>
		]
	});
});
</script>
</body>
</html>
