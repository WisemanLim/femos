 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div id="hr_input_form" class="popup1" style="margin:250px 0px 0px 200px;display:none;">
	 <p class="closebtn"><a href="javascript:hide_layout_form('hr_input_form');"><img src="../images/common/btn_close.png"/></a></p>
	 <h3><img src="../images/common/ic_02.gif" align="absmiddle" /> 인력 정보 입력</h3>
	 <table  class="table2">
	     <colgroup>
	     <col width="25%" />
	     <col width="75%" />
	     </colgroup>
	     <tr>
	         <td class="sp">고유번호</td>
	         <td><span class="txt_blue">자동부여</span></td>
	     </tr>
	     <tr>
	         <td class="sp">이름</td>
	         <td><input id="hr_nm" name="hr_nm" type="text" value="" /></td>
	     </tr>
	     <tr>
	         <td class="sp">연락처</td>
	         <td><input id="phone" name="phone" type="text" value="" /></td>
	     </tr>
	     <tr>
	         <td class="sp">지원유형</td>
	         <td>
	         	<select name="support_type">
                 	<%=com.util.CodeUtil.getCodeListCombo("A40","") %>
                </select>
	         </td>
	     </tr>
	     <tr>
	         <td class="sp">주소</td>
	         <td><input id="addr" name="addr" type="text" value=""></td>
	     </tr>
	     <tr>
	         <td class="sp">직업</td>
	         <td>
	         	<select name="job">
                 	<%=com.util.CodeUtil.getCodeListCombo("A50","") %>
                </select>
	         </td>
	     </tr>
	     <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="hr_input_error_msg" >&nbsp;</div>
        	</td>
        </tr>
	    </table>
	    <p class="popbtn">
	    	<a href="javascript:save();"><img src="../images/common/btn_input2.gif"/></a> 
	    	<a href="javascript:hide_layout_form('hr_input_form');"><img src="../images/common/btn_cancel.gif"/></a>
	    </p>
</div>