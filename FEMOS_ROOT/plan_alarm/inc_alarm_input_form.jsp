 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div id="alarm_input_form" class="popup1" style="margin:250px 0px 0px 200px;display:none;">
	 <p class="closebtn"><a href="javascript:hide_layout_form('alarm_input_form');"><img src="../images/common/btn_close.png"/></a></p>
	 <h3><img src="../images/common/ic_02.gif" align="absmiddle" /> 알리미 입력</h3>
	 <table  class="table2">
	     <colgroup>
	     <col width="25%" />
	     <col width="75%" />
	     </colgroup>
	     <tr>
	         <td class="sp">제목</td>
	         <td><input id="alarm_title" name="alarm_title" type="text" value="" style="width:99%"/></td>
	     </tr>
	     <tr>
	         <td class="sp">내용</td>
	         <td>
	         	<textarea id="alarm_content" name="alarm_content" rows="8" style="width:100%"></textarea>
	         </td>
	     </tr>
	     <tr>
         	 <td colspan="2" style="text-align:center">
        		<div id="alarm_input_error_msg" >&nbsp;</div>
        	 </td>
        </tr>
	    </table>
	    <p class="popbtn">
	    	<a href="javascript:save();"><img src="../images/common/btn_input2.gif"/></a> 
	    	<a href="javascript:hide_layout_form('alarm_input_form');"><img src="../images/common/btn_cancel.gif"/></a>
	    </p>
</div>