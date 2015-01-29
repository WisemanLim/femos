 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div id="check_div_edit_form" class="popup1" style="margin:250px 0px 0px 200px;display:none;">
	 <p class="closebtn"><a href="javascript:hide_layout_form('check_div_edit_form');"><img src="../images/common/btn_close.png"/></a></p>
	 <h3><img src="../images/common/ic_02.gif" align="absmiddle" /> 체크리스트 구분 편집</h3>
	 <table  class="table2">
	     <colgroup>
	     <col width="25%" />
	     <col width="75%" />
	     </colgroup>
	     <tr>
	         <td class="sp">코드</td>
	         <td><span id="edit_check_cd"></span></td>
	     </tr>
	     <tr>
	         <td class="sp">상위그룹</td>
	         <td>
	         	<select id="edit_parent_check_cd" name="edit_parent_check_cd">
	         		<option value="0">상위없음</option>
	         		<%
	         		if(div_list.size() > 0)
					{
						for(int i = 0; i < div_list.size(); i++)
						{
							Biz_check_div div_obj = (Biz_check_div)div_list.elementAt(i);
	         		%>
	         		<option value="<%= div_obj.getCheck_cd()%>" ><%= div_obj.getCheck_nm_path()%></option>
	         		<%
						}
					}
	         		%>
	         	</select>
	         </td>
	     </tr>
	  
	     <tr>
	         <td class="sp">명칭</td>
	         <td><input id="edit_check_nm" name="edit_check_nm" type="text" value=""></td>
	     </tr>
	    
	     <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="check_div_edit_error_msg" >&nbsp;</div>
        	</td>
        </tr>
	    </table>
	    <p class="popbtn">
	    	<a href="javascript:edit_check_div();"><img src="../images/common/btn_input2.gif"/></a> 
	    	<a href="javascript:del_check_div();"><img src="../images/common/btn_delete2.gif"/></a> 
	    	<a href="javascript:hide_layout_form('check_div_edit_form');"><img src="../images/common/btn_cancel.gif"/></a>
	    </p>
</div>