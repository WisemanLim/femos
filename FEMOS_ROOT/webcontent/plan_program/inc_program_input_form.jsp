<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 프로그램입력 팝업시작 ------------------------------------------------------------------------------------------------------------->
<div id="program_input_form" class="popup1" style="margin:100px 0px 0px 200px;display:none">
    <p class="closebtn"><a href="javascript:hide_layout_form('program_input_form');"><img src="../images/common/btn_close.png"/></a></p>
    <h3><img src="../images/common/ic_01.gif" align="absmiddle" /> 프로그램 입력</h3>
    <table class="table2">
        <colgroup>
        <col width="25%" />
        <col width="75%" />
        </colgroup>
        <tr>
            <td class="sp">구분</td>
            <td>
            	<select id="program_div" name="program_div" style="width:50px">
                	<%=com.util.CodeUtil.getCodeListCombo("A10","") %>
                </select>
            </td>
        </tr>
        <tr>
            <td class="sp">프로그램명</td>
            <td>
            	<input id="program_nm" name="program_nm" type="text" style="width:250px;" value=""/>
            </td>
        </tr>
        <tr>
            <td class="sp">기본내용</td>
            <td>
            	<textarea id="base_summary" name="base_summary" style="width:250px;height:80px;"></textarea>
            </td>
        </tr>
        <tr>
            <td class="sp">추진방안</td>
            <td>
            	<textarea id="policy" name="policy" style="width:250px;height:80px;"></textarea>
            </td>
        </tr>
        <tr>
            <td class="sp">실행목표</td>
            <td>
            	<input id="exec_target" name="exec_target" type="text" style="width:250px;" value=""/>
            </td>
        </tr>
        <tr>
            <td class="sp">중요도</td>
            <td>
            	<%=com.util.CodeUtil.getCodeListRadio("importance","A20","A2010002") %>
       		</td>
        </tr>
        <tr>
            <td class="sp">필요예산</td>
            <td>
            	<div>
	            	<div id="budget" style="float:left;">
		            	<div class="budget_items" style="margin-top:5px;">
			            	<select name="budget_div">
			            		<%=com.util.CodeUtil.getCodeListCombo("A30","") %>
			            	</select>
			            	<input name=budget_money type="text" style="width:100px;text-align:right" value="0" /> 원
	            		</div>
	            	</div>
	  				<div style="float:right;">
            			<a href="javascript:addBudget('');">[추가]</a>
            		</div>
	            </div>
           	</td>
        </tr>
       <!-- 
        <tr>
            <td class="sp">지원인력</td>
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
         -->
        <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="program_input_error_msg" >&nbsp;</div>
        	</td>
        </tr>
    </table>
    <p class="popbtn">
    	<a href="javascript:save();"><img src="../images/common/btn_input2.gif"/></a> 
    	<a href="javascript:hide_layout_form('program_input_form');"><img src="../images/common/btn_cancel.gif"/></a>
    </p>
   
    
</div>
<!--// class="popup1"--> 