<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="input_schedule_form" class="drag">
	<div style="width:100%;">
		<div style="float:left;color:#000;font-weight:bold;">
			일정추가
		</div>
		<div style="float:right;padding-bottom:10px;">
			<a href="#" onclick="hide_layout_form('input_schedule_form');"><img src="../images/btn/btn_close_x.gif" alt="닫기"/></a>
		</div>
	</div>
	
	<div class="tb_schedule_form" style="width:100%;">
		<table cellspacing="1" cellpadding="3">
			<tr>
				<th>프로그램 검색</th>
				<td>
					<select id="sch_program_div" name="sch_program_div" >
		                	<option value="">구분</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A10","") %>
		                </select>
                       	<select id="sch_importance" name="sch_importance" >
		                	<option value="">중요도</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A20","") %>
		                </select>
		                <select id="sch_div" name="sch_div">
                        	<option value="PROGRAM_NM" >프로그램명</option>
                        	<option value="BASE_SUMMARY" >기본내용</option>
                        	<option value="POLICY" >추진방안</option>
                        	<option value="EXEC_TARGET" >실행목표</option>
                        </select>
                        
                        <input id="sch_val" name="sch_val" type="text" value="" />
						<a href="javascript:program_search('sch_program_div','sch_importance','sch_div','sch_val','program_search_result');">
							<img src="../images/common/btn_search.gif" alt="검색" align="absmiddle"/>
						</a>
				</td>
			</tr>
			<tr>
				<th>프로그램 선택</th>
				<td>
					<select id="program_search_result" name="program_search_result">
						<option value="">선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>일시</th>
				<td>
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
				<th>제목</th>
				<td>
					<input id="schedule_title" name="schedule_title" type="text" value="" style="width:99%;"/>
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
	            <th>지원인력</th>
	            <td>
	            	<div style="padding:5px 0 5px 0">
	            		<select id="hr_sch_div" name="hr_sch_div">
	                    	<option value="HR_NM">이름</option>
	                    	<option value="PHONE">연락처</option>
	                    	<option value="SUPPORT_TYPE">지원유형</option>
	                    	<option value="ADDR">주소</option>
	                    	<option value="JOB">직업</option>
	                    </select>
	                    <input id="hr_sch_val" name="hr_sch_val" type="text" value="" />
	                    <a href="javascript:hr_search('sch_hr','hr_sch_div','hr_sch_val');"><img type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" style="padding-bottom:5px;"/></a>
	            	</div>
	            	<div style="float:left;">
	            		<select id="sch_hr" name="sch_hr" style="width:130px;height:100px" multiple>
	            		</select>
	            	</div>
	            	<div style="float:left;padding:35px 2px 0 2px;">
	            		<a href="javascript:hr_insert('sch_hr','program_hr')" style="color:#000">▶</a><br/><br/>
	            		<a href="javascript:hr_insert('program_hr','sch_hr')" style="color:#000">◀</a>
	            	</div>
	            	<div style="float:left;">
	            		<select id="program_hr" name="program_hr" style="width:130px;height:100px;" multiple>
	            		</select>
	            	</div>
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