 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div id="lodge_main_input_form" class="popup1" style="margin:250px 0px 0px 200px;display:none;">
	 <p class="closebtn"><a href="javascript:hide_layout_form('lodge_main_input_form');"><img src="../images/common/btn_close.png"/></a></p>
	 <h3><img src="../images/common/ic_02.gif" align="absmiddle" /> 숙소 정보 입력</h3>
	 <table  class="table2">
	     <colgroup>
	     <col width="30%" />
	     <col width="70%" />
	     </colgroup>
	    
	     <tr>
	         <td class="sp">숙소명</td>
	         <td><input id="lodge_nm" name="lodge_nm" type="text" value="" style="width:99%;"/></td>
	     </tr>
	      <tr>
	         <td class="sp">주소</td>
	         <td>
	         	<input id="addr" name="addr" type="text" value="" style="width:99%;"/ >
	         </td>
	     </tr>
	     <tr>
	         <td class="sp">연락처</td>
	         <td><input id="phone" name="phone" type="text" /></td>
	     </tr>
	     <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="lodge_main_input_error_msg" >&nbsp;</div>
        	</td>
        </tr>
	    </table>
	    <p class="popbtn">
	    	<a href="javascript:save_main();"><img src="../images/common/btn_input2.gif"/></a> 
	    	<a href="javascript:hide_layout_form('lodge_main_input_form');"><img src="../images/common/btn_cancel.gif"/></a>
	    </p>
</div>