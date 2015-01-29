<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="edit_schedule_form" class="drag">
	<div style="width:100%;">
		<div style="float:left;color:#000;font-weight:bold;">
			일정편집
		</div>
		<div style="float:right;padding-bottom:10px;">
			<a href="#" onclick="hide_layout_form('edit_schedule_form');"><img src="../images/btn/btn_close_x.gif" alt="닫기"/></a>
		</div>
	</div>
	
	<div class="tb_schedule_form" style="width:100%;">
		<table cellspacing="1" cellpadding="3">
			<tr>
				<th>프로그램 검색</th>
				<td>
					<select id="edit_sch_program_div" name="edit_sch_program_div" >
		                	<option value="">구분</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A10","") %>
		                </select>
                       	<select id="edit_sch_importance" name="edit_sch_importance" >
		                	<option value="">중요도</option>
		                	<%=com.util.CodeUtil.getCodeListCombo("A20","") %>
		                </select>
		                <select id="edit_sch_div" name="edit_sch_div">
                        	<option value="PROGRAM_NM" >프로그램명</option>
                        	<option value="BASE_SUMMARY" >기본내용</option>
                        	<option value="POLICY" >추진방안</option>
                        	<option value="EXEC_TARGET" >실행목표</option>
                        </select>
                        
                        <input id="edit_sch_val" name="edit_sch_val" type="text" value="" />
						<a href="javascript:program_search('edit_sch_program_div','edit_sch_importance','edit_sch_div','edit_sch_val','edit_program_search_result');">
							<img src="../images/common/btn_search.gif" alt="검색" align="absmiddle"/>
						</a>
				</td>
			</tr>
			<tr>
				<th>프로그램 선택</th>
				<td>
					<select id="edit_program_search_result" name="edit_program_search_result">
						<option value="">선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>일시</th>
				<td>
					<div>
						<input type="text" id="edit_st_ymd" name="edit_st_ymd" value="" style="width:70px;" readonly="readonly" class="datepicker"/>
						<select id="edit_st_hour" name="edit_st_hour">
							<%
							String edit_loop_st_hour = "";
							for(int i=1; i <= 24; i++)
							{ 
								if(i < 10)
								{
									edit_loop_st_hour = "0"+Integer.toString(i);
								}
								else
								{
									edit_loop_st_hour = Integer.toString(i);
								}
							%>
							<option value="<%=edit_loop_st_hour%>"><%=edit_loop_st_hour%>시</option>
							<%} %>
						</select>
						<select id="edit_st_minute" name="edit_st_minute">
							<option value="00">00분</option>
							<option value="30">30분</option>
						</select>
						~
						<input type="text" id="edit_ed_ymd" name="edit_ed_ymd" value="" style="width:70px;" readonly="readonly" class="datepicker"/>
						<select id="edit_ed_hour" name="edit_ed_hour">
							<%
							String edit_loop_ed_hour = "";
							for(int i=1; i <= 24; i++)
							{ 
								if(i < 10)
								{
									edit_loop_ed_hour = "0"+Integer.toString(i);
								}
								else
								{
									edit_loop_ed_hour = Integer.toString(i);
								}
							%>
							<option value="<%=edit_loop_ed_hour%>"><%=edit_loop_ed_hour%>시</option>
							<%} %>
						</select>
						<select id="edit_ed_minute" name="edit_ed_minute">
							<option value="00">00분</option>
							<option value="30">30분</option>
						</select>
					</div>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input id="edit_schedule_title" name="edit_schedule_title" type="text" value="" style="width:99%;"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea id="edit_schedule_content" name="edit_schedule_content" style="width:100%;" rows="6"></textarea>
				</td>
			</tr>
			<tr>
				<th>배경색상</th>
				<td>
					<div id="edit_bg_color_box" style="float:left;width:20px;height:20px;background-color:#000000;"></div>
					<div style="float:left;margin-left:5px;"><input type="text" id="edit_bg_color" name="edit_bg_color" value="000000" maxlength="6" size="6" /></div>
				</td>
			</tr>
			<tr>
				<th>텍스트색상</th>
				<td>
					<div id="edit_text_color_box" style="float:left;width:20px;height:20px;background-color:#ffffff;"></div>
					<div style="float:left;margin-left:5px;"><input type="text" id="edit_text_color" name="edit_text_color" value="ffffff" maxlength="6" size="6" readonly="readonly"/></div>
				</td>
			</tr>
			<tr>
	            <th>지원인력</th>
	            <td>
	            	<div style="padding:5px 0 5px 0">
	            		<select id="edit_hr_sch_div" name="edit_hr_sch_div">
	                    	<option value="HR_NM">이름</option>
	                    	<option value="PHONE">연락처</option>
	                    	<option value="SUPPORT_TYPE">지원유형</option>
	                    	<option value="ADDR">주소</option>
	                    	<option value="JOB">직업</option>
	                    </select>
	                    <input id="edit_hr_sch_val" name="edit_hr_sch_val" type="text" value="" />
	                    <a href="javascript:hr_search('edit_sch_hr','edit_hr_sch_div','edit_hr_sch_val');"><img type="image" src="../images/common/btn_search.gif" alt="" align="absmiddle" style="padding-bottom:5px;"/></a>
	            	</div>
	            	<div style="float:left;">
	            		<select id="edit_sch_hr" name="edit_sch_hr" style="width:130px;height:100px" multiple>
	            		</select>
	            	</div>
	            	<div style="float:left;padding:35px 2px 0 2px;">
	            		<a href="javascript:hr_insert('edit_sch_hr','edit_program_hr')" style="color:#000">▶</a><br/><br/>
	            		<a href="javascript:hr_insert('edit_program_hr','edit_sch_hr')" style="color:#000">◀</a>
	            	</div>
	            	<div style="float:left;">
	            		<select id="edit_program_hr" name="edit_program_hr" style="width:130px;height:100px;" multiple>
	            		</select>
	            	</div>
	           	</td>
	        </tr>
			<tr>
				<td colspan="2" style="text-align:right;">
					<div id="edit_error_msg" style="float:left;color:#f20909;padding:4px;"></div>
					<div style="float:right;">
						<a href="#" onclick="planEditAction();"><img src="../images/btn/save.gif" alt="저장" /></a>
						<a href="#" onclick="planDelAction();"><img src="../images/btn/delete.gif" alt="삭제" /></a>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>