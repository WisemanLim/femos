 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div id="hr_edit_form" class="popup1" style="margin:250px 0px 0px 200px;display:none;">
	 <p class="closebtn"><a href="javascript:hide_layout_form('hr_edit_form');"><img src="../images/common/btn_close.png"/></a></p>
	 <h3><img src="../images/common/ic_02.gif" align="absmiddle" /> 인력 정보 편집</h3>
	 <table  class="table2">
	     <colgroup>
	     <col width="25%" />
	     <col width="75%" />
	     </colgroup>
	     <tr>
	         <td class="sp">고유번호</td>
	         <td><span id="edit_pk_no" class="txt_blue"> </span></td>
	     </tr>
	     <tr>
	         <td class="sp">이름</td>
	         <td><input id="edit_hr_nm" name="edit_hr_nm" type="text" value="" readonly="readonly"/></td>
	     </tr>
	     <tr>
	         <td class="sp">연락처</td>
	         <td><input id="edit_phone" name="edit_phone" type="text" value="" /></td>
	     </tr>
	     <tr>
	         <td class="sp">지원유형</td>
	         <td>
	         	<select name="edit_support_type">
                 	<%=com.util.CodeUtil.getCodeListCombo("A40","") %>
                </select>
	         </td>
	     </tr>
	     <tr>
	         <td class="sp">주소</td>
	         <td><input id="edit_addr" name="edit_addr" type="text" value=""></td>
	     </tr>
	     <tr>
	         <td class="sp">직업</td>
	         <td>
	         	<select name="edit_job">
                 	<%=com.util.CodeUtil.getCodeListCombo("A50","") %>
                </select>
	         </td>
	     </tr>
	     <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="hr_edit_error_msg" >&nbsp;</div>
        	</td>
        </tr>
	    </table>
	    <p class="popbtn">
	    	<a href="javascript:edit();"><img src="../images/common/btn_input2.gif"/></a> 
	    	<a href="javascript:del();"><img src="../images/common/btn_delete2.gif"/></a> 
	    	<a href="javascript:hide_layout_form('hr_edit_form');"><img src="../images/common/btn_cancel.gif"/></a>
	    </p>
</div>