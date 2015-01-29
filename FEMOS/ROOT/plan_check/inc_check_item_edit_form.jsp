 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div id="check_item_edit_form" class="popup1" style="margin:250px 0px 0px 200px;display:none;">
	 <p class="closebtn"><a href="javascript:hide_layout_form('check_item_edit_form');"><img src="../images/common/btn_close.png"/></a></p>
	 <h3><img src="../images/common/ic_02.gif" align="absmiddle" /> 체크항목  편집</h3>
	 <table  class="table2">
	     <colgroup>
	     <col width="25%" />
	     <col width="75%" />
	     </colgroup>
	     <tr>
	         <td class="sp">명칭</td>
	         <td><input id="edit_item_nm" name="edit_item_nm" type="text" value="" style="width:60%"></td>
	     </tr>
	    
	     <tr>
	     	<td class="sp">설명</td>
        	<td>
        		 <input id="edit_summary" name="edit_summary" type="text" value="" style="width:99%">
        	</td>
         </tr>
         
          <tr>
	     	<td class="sp">중요도</td>
        	<td>
        		 <%=com.util.CodeUtil.getCodeListRadio("edit_importance","A60","A6010002") %> 
        	</td>
         </tr>
         <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="check_item_edit_error_msg" >&nbsp;</div>
        	</td>
        </tr>
	 </table>
	 <p class="popbtn">
		<a href="javascript:edit_check_item();"><img src="../images/common/btn_input2.gif"/></a> 
		<a href="javascript:del_check_item();"><img src="../images/common/btn_delete2.gif"/></a>
		<a href="javascript:hide_layout_form('check_item_edit_form');"><img src="../images/common/btn_cancel.gif"/></a>
	 </p>
</div>