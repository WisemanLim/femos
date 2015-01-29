<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.plan.schedule.Dal_schedule_plan" %>
<%@ page import="com.plan.schedule.Biz_schedule_plan" %>

<%
	String festival_cd = request.getParameter("festival_cd")!= null?request.getParameter("festival_cd").toString():"FS100001";
	int pk_id = request.getParameter("pk_id")!= null?Integer.parseInt(request.getParameter("pk_id")):0;
	String view = request.getParameter("view")!= null ? request.getParameter("view").toString():"month";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<link rel="stylesheet" href="./datepicker/css/jquery.ui.all.css" />
<link rel='stylesheet' type='text/css' href='./fullcalendar/fullcalendar.css' />
<link rel='stylesheet' type='text/css' href='./fullcalendar/fullcalendar.print.css' media='print' />
<link rel='stylesheet' type='text/css' href='../css/common.css' />
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

	$(document).ready(function() {
		
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
			defaultView: '<%=view%>',
			weekends: true,
			eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) // Drop callback 
			{
				location.href = 'schedule_date_move.jsp?festival_cd=<%=festival_cd%>&pk_id='+event.id+'&day='+dayDelta+'&minute='+minuteDelta+'&view='+$('#calendar').fullCalendar('getView').name;
			},
			eventClick: function(event) // Click item
			{
				location.href = "schedule_main.jsp?festival_cd=<%=festival_cd%>&pk_id="+event.id+"&view="+$('#calendar').fullCalendar('getView').name;
				//alert('ID:'+event.id+'\n제목:'+event.title+'\n시작:'+retDate(event.start)+'\n종료:'+retDate(event.end));	
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
		    },					
			eventResize: function(event,dayDelta,minuteDelta,revertFunc) // Item resize
			{
		    	location.href = 'schedule_date_add.jsp?festival_cd=<%=festival_cd%>&pk_id='+event.id+'&day='+dayDelta+'&minute='+minuteDelta+'&view='+$('#calendar').fullCalendar('getView').name;
			},
			editable: true,
			events: 
			[
				<%=com.util.ScheduleUtil.getScheduleEventItems(festival_cd)%>
			]
		});
				
		var doc = document.documentElement;
		var body = document.body;
		
		$('#view_schedule_form').css('top',(doc.clientHeight/2)+(doc.scrollTop+body.scrollTop)-280);
		$('#view_schedule_form').css('left',(body.clientWidth/2)-150);
		$('#view_schedule_edit_form').css('top',(doc.clientHeight/2)+(doc.scrollTop+body.scrollTop)-280);
		$('#view_schedule_edit_form').css('left',(body.clientWidth/2)-150);
		
	});

	function planInsertAction()
	{
		
		var objs = 'schedule_div,schedule_title,st_ymd,ed_ymd,schedule_content';
		var Msgs = '구분을 입력해주세요.,제목을 입력해주세요.,시작일시를 입력해주세요.,종료일시를 입력해주세요.,내용을 입력해주세요.';
		var inner_layer = 'error_msg';
		
		if(CheckForm(objs,Msgs,inner_layer))
		{
			$('#view').val($('#calendar').fullCalendar('getView').name);
			document.getElementById('schedule_form').action = 'schedule_save.jsp';
			document.getElementById('schedule_form').submit();
		}
	}

	function planEditAction()
	{
		
		var objs = 'edit_schedule_div,edit_schedule_title,edit_st_ymd,edit_ed_ymd,edit_schedule_content';
		var Msgs = '구분을 입력해주세요.,제목을 입력해주세요.,시작일시를 입력해주세요.,종료일시를 입력해주세요.,내용을 입력해주세요.';
		var inner_layer = 'error_msg';
		
		if(CheckForm(objs,Msgs,inner_layer))
		{
			$('#view').val($('#calendar').fullCalendar('getView').name);
			document.getElementById('schedule_form').action = 'schedule_edit.jsp';
			document.getElementById('schedule_form').submit();
		}
	}

	function planDelAction(festival_cd,pk_id)
	{
		location.href='schedule_del.jsp?festival_cd='+festival_cd+'&pk_id='+pk_id;
	}
	
</script>
<style type='text/css'>
	
	#calendar {
		width: 900px;
		margin-top:10px;
		padding:10px;
		float:right;
		border:1px solid #ccc;
	}
	
	.tb_schedule_form table {
		width:100%;
		background:#ccc;
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
		
		background:#fff;
	}
	
	#view_schedule_form {
		display:none;
		position:absolute;
		border:4px solid #aaa;
		width:560px;padding:10px;
		z-index:998;
		background:#fff;
	}
	
	#view_schedule_edit_form {
		position:absolute;
		border:4px solid #aaa;
		width:560px;padding:10px;
		z-index:998;
		background:#fff;
	}
</style>
</head>
<body>
<form id="schedule_form" method="post">
<div id="wrap" style="width:1200px;margin: 0 auto;">
	<div id="calendar"></div>
	<input type="hidden" id="view" name="view" value="<%=view %>" />
	<%
	if(pk_id > 0) 
	{
		Dal_schedule_plan schedule = new Dal_schedule_plan();
		
		Biz_schedule_plan obj = schedule.getSchedule_detail(pk_id);
	%>
	<div id="view_schedule_edit_form" class="drag">
		<div style="width:100%;">
			<div style="float:right;padding-bottom:10px;">
				<a href="#" onclick="$('#view_schedule_edit_form').hide();"><img src="../images/btn/btn_close_x.gif" alt="닫기"/></a>
			</div>
		</div>
		
		<div class="tb_schedule_form" style="width:100%;">
			<table cellspacing="1" cellpadding="3">
				<tr>
					<th>구분 / 제목</th>
					<td>
						<input type="hidden" id="edit_festival_cd" name="edit_festival_cd" value="<%=obj.getFestival_cd() %>" />
						<select id="edit_schedule_div" name="edit_schedule_div">
							<option value="">선택</option>
							<%=com.util.CodeUtil.getCodeListCombo("A10",obj.getSchedule_div()) %>
						</select>
						<input type="hidden" id="pk_id" name="pk_id" value="<%=pk_id %>" />
						<input type="text" id="edit_schedule_title" name="edit_schedule_title" style="width:320px;" value="<%=obj.getSchedule_title() %>"/>
					</td>
				</tr>
				<tr>
					<th>일시</th>
					<td>
						<!-- 
						<div>
							<input type="radio" name="edit_all_day_yn" value="N" <%if (obj.getAll_day_yn().equals("N")){ %>checked="checked"<%} %>/> 하루
							<input type="radio" name="edit_all_day_yn" value="Y" <%if (obj.getAll_day_yn().equals("Y")){ %>checked="checked"<%} %>/> 종일
						</div>
						 -->
						<div>
							<input type="text" id="edit_st_ymd" name="edit_st_ymd" value="<%=obj.getSt_year() %>-<%=obj.getSt_month() %>-<%=obj.getSt_day() %>" style="width:70px;" readonly="readonly" class="datepicker"/>
							<select id="edit_st_hour" name="edit_st_hour">
								<%
								String loop_st_hour = "";
								for(int i=1; i <= 24; i++)
								{ 
									if(i < 10)
									{
										loop_st_hour = "0"+Integer.toString(i);
									}
									else
									{
										loop_st_hour = Integer.toString(i);
									}
								%>
								<option value="<%=loop_st_hour%>" <%if(obj.getSt_hour().equals(loop_st_hour)) {%>selected="selected"<%} %>><%=loop_st_hour%>시</option>
								<%} %>
							</select>
							<select id="edit_st_minute" name="edit_st_minute">
								<option value="00" <%if(obj.getSt_minute().equals("00")) {%>selected="selected"<%} %>>00분</option>
								<option value="30" <%if(obj.getSt_minute().equals("30")) {%>selected="selected"<%} %>>30분</option>
							</select>
							~
							<input type="text" id="edit_ed_ymd" name="edit_ed_ymd" value="<%=obj.getEd_year() %>-<%=obj.getEd_month() %>-<%=obj.getEd_day() %>" style="width:70px;" readonly="readonly" class="datepicker"/>
							<select id="edit_ed_hour" name="edit_ed_hour">
								<%
								String loop_ed_hour = "";
								for(int i=1; i <= 24; i++)
								{ 
									if(i < 10)
									{
										loop_ed_hour = "0"+Integer.toString(i);
									}
									else
									{
										loop_ed_hour = Integer.toString(i);
									}
								%>
								<option value="<%=loop_ed_hour%>" <%if(obj.getEd_hour().equals(loop_ed_hour)) {%>selected="selected"<%} %>><%=loop_ed_hour%>시</option>
								<%} %>
							</select>
							<select id="edit_ed_minute" name="edit_ed_minute">
								<option value="00" <%if(obj.getEd_minute().equals("00")) {%>selected="selected"<%} %>>00분</option>
								<option value="30" <%if(obj.getEd_minute().equals("30")) {%>selected="selected"<%} %>>30분</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="edit_schedule_content" name="edit_schedule_content" style="width:100%;" rows="6"><%=obj.getSchedule_content() %></textarea>
					</td>
				</tr>
				<tr>
					<th>배경색상</th>
					<td>
						<div id="edit_bg_color_box" style="float:left;width:20px;height:20px;background-color:#<%=obj.getBg_color()%>;"></div>
						<div style="float:left;margin-left:5px;"><input type="text" id="edit_bg_color" name="edit_bg_color" value="<%=obj.getBg_color()%>" maxlength="6" size="6" /></div>
					</td>
				</tr>
				<tr>
					<th>텍스트색상</th>
					<td>
						<div id="edit_text_color_box" style="float:left;width:20px;height:20px;background-color:#<%=obj.getText_color()%>;"></div>
						<div style="float:left;margin-left:5px;"><input type="text" id="edit_text_color" name="edit_text_color" value="<%=obj.getText_color() %>" maxlength="6" size="6" readonly="readonly"/></div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:right;">
						<div id="error_msg" style="float:left;color:#f20909;padding:4px;"></div>
						<div style="float:right;">
							<a href="#" onclick="planEditAction();"><img src="../images/btn/save.gif" alt="저장" /></a>
							<a href="#" onclick="planDelAction('<%=obj.getFestival_cd()%>','<%=obj.getPk_id()%>');"><img src="../images/btn/delete.gif" alt="삭제" /></a>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<%} %>
	
	<div id="view_schedule_form" class="drag">
		<div style="width:100%;">
			<div style="float:right;padding-bottom:10px;">
				<a href="#" onclick="$('#view_schedule_form').hide();"><img src="../images/btn/btn_close_x.gif" alt="닫기"/></a>
			</div>
		</div>
		
		<div class="tb_schedule_form" style="width:100%;">
			<table cellspacing="1" cellpadding="3">
				<tr>
					<th>구분 / 제목</th>
					<td>
						<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd %>" />
						<select id="schedule_div" name="schedule_div">
							<option value="">선택</option>
							<%=com.util.CodeUtil.getCodeListCombo("A10","") %>
						</select>
						<input type="text" id="schedule_title" name="schedule_title" style="width:320px;" value=""/>
					</td>
				</tr>
				<tr>
					<th>일시</th>
					<td>
						<!-- 
						<div>
							<input type="radio" name="all_day_yn" value="N" checked="checked"/> 하루
							<input type="radio" name="all_day_yn" value="Y" /> 종일
						</div>
						 -->
						<div>
							<input type="text" id="st_ymd" name="st_ymd" value="" style="width:70px;" readonly="readonly" class="datepicker"/>
							<select id="st_hour" name="st_hour">
								<%
								String loop_st_hour = "";
								for(int i=1; i <= 24; i++)
								{ 
									if(i < 10)
									{
										loop_st_hour = "0"+Integer.toString(i);
									}
									else
									{
										loop_st_hour = Integer.toString(i);
									}
								%>
								<option value="<%=loop_st_hour%>"><%=loop_st_hour%>시</option>
								<%} %>
							</select>
							<select id="st_minute" name="st_minute">
								<option value="00">00분</option>
								<option value="30">30분</option>
							</select>
							~
							<input type="text" id="ed_ymd" name="ed_ymd" value="" style="width:70px;" readonly="readonly" class="datepicker"/>
							<select id="ed_hour" name="ed_hour">
								<%
								String loop_ed_hour = "";
								for(int i=1; i <= 24; i++)
								{ 
									if(i < 10)
									{
										loop_ed_hour = "0"+Integer.toString(i);
									}
									else
									{
										loop_ed_hour = Integer.toString(i);
									}
								%>
								<option value="<%=loop_ed_hour%>"><%=loop_ed_hour%>시</option>
								<%} %>
							</select>
							<select id="ed_minute" name="ed_minute">
								<option value="00">00분</option>
								<option value="30">30분</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="schedule_content" name="schedule_content" style="width:100%;" rows="6"></textarea>
					</td>
				</tr>
				<tr>
					<th>배경색상</th>
					<td>
						<div id="bg_color_box" style="float:left;width:20px;height:20px;background-color:#000000;"></div>
						<div style="float:left;margin-left:5px;"><input type="text" id="bg_color" name="bg_color" value="000000" maxlength="6" size="6" /></div>
					</td>
				</tr>
				<tr>
					<th>텍스트색상</th>
					<td>
						<div id="text_color_box" style="float:left;width:20px;height:20px;background-color:#ffffff;"></div>
						<div style="float:left;margin-left:5px;"><input type="text" id="text_color" name="text_color" value="ffffff" maxlength="6" size="6" readonly="readonly"/></div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:right;">
						<div id="error_msg" style="float:left;color:#f20909;padding:4px;"></div>
						<div style="float:right;">
							<a href="#" onclick="planInsertAction();"><img src="../images/btn/save.gif" alt="저장" /></a>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	
	
	<div style="float:left;"><a href="#" onclick="$('#view_schedule_form').show();$('#view_schedule_edit_form').hide();">[일정작성]</a></div>
	
	
</div>
</form>
</body>
</html>
