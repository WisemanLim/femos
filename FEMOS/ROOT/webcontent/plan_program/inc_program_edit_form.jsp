<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 프로그램입력 팝업시작 ------------------------------------------------------------------------------------------------------------->
<div id="program_edit_form" class="popup1" style="margin:100px 0px 0px 200px;display:none">
    <p class="closebtn"><a href="javascript:hide_layout_form('program_edit_form');"><img src="../images/common/btn_close.png"/></a></p>
    <h3><img src="../images/common/ic_01.gif" align="absmiddle" /> 프로그램 편집</h3>
    <table class="table2">
        <colgroup>
        <col width="25%" />
        <col width="75%" />
        </colgroup>
        <tr>
            <td class="sp">구분</td>
            <td>
            	<select id="edit_program_div" name="edit_program_div" style="width:50px">
                	<%=com.util.CodeUtil.getCodeListCombo("A10","") %>
                </select>
            </td>
        </tr>
        <tr>
            <td class="sp">프로그램명</td>
            <td>
            	<input id="edit_program_nm" name="edit_program_nm" type="text" style="width:250px;" value=""/>
            </td>
        </tr>
        <tr>
            <td class="sp">기본내용</td>
            <td>
            	<textarea id="edit_base_summary" name="edit_base_summary" style="width:250px;height:80px;"></textarea>
            </td>
        </tr>
        <tr>
            <td class="sp">추진방안</td>
            <td>
            	<textarea id="edit_policy" name="edit_policy" style="width:250px;height:80px;"></textarea>
            </td>
        </tr>
        <tr>
            <td class="sp">실행목표</td>
            <td>
            	<input id="edit_exec_target" name="edit_exec_target" type="text" style="width:250px;" value=""/>
            </td>
        </tr>
        <tr>
            <td class="sp">중요도</td>
            <td>
            	<%=com.util.CodeUtil.getCodeListRadio("edit_importance","A20","A2010002") %>
       		</td>
        </tr>
        <tr>
            <td class="sp">필요예산</td>
            <td>
            	<div id="edit_budget_form">
	            	
	            </div>
           	</td>
        </tr>
        <!-- 
        <tr>
            <td class="sp">지원인력</td>
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
         -->
        <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="program_edit_error_msg" >&nbsp;</div>
        	</td>
        </tr>
    </table>
    <p class="popbtn">
    	<a href="javascript:edit();"><img src="../images/common/btn_input2.gif"/></a> 
	    	<a href="javascript:del();">[ 삭제 ]</a> 
    	<a href="javascript:hide_layout_form('program_edit_form');"><img src="../images/common/btn_cancel.gif"/></a>
    </p>
   
    
</div>
<!--// class="popup1"--> 