 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div id="lodge_edit_form" class="popup1" style="margin:250px 0px 0px 200px;display:none;">
	 <p class="closebtn"><a href="javascript:hide_layout_form('lodge_edit_form');"><img src="../images/common/btn_close.png"/></a></p>
	 <h3><img src="../images/common/ic_02.gif" align="absmiddle" /> 상세 정보 편집</h3>
	 <table  class="table2">
	     <colgroup>
	     <col width="30%" />
	     <col width="70%" />
	     </colgroup>
	    
	     <tr>
	         <td class="sp">호/실명</td>
	         <td><input id="edit_room_nm" name="edit_room_nm" type="text" value=""></td>
	     </tr>
	     <tr>
	         <td class="sp">국가/팀/단체명</td>
	         <td><input id="edit_team_nm" name="edit_team_nm" type="text" /></td>
	     </tr>
	     <tr>
	         <td class="sp">인원(남성/여성)</td>
	         <td>
	         	<input id="edit_male_cnt" name="edit_male_cnt" type="text" style="width:50px;text-align:right" value="0" /> / 
	         	<input id="edit_fmale_cnt" name="edit_fmale_cnt" type="text" style="width:50px;text-align:right" value="0" />
	         </td>
	     </tr>
	     <tr>
	         <td class="sp">입실일자</td>
	         <td>
	         	<input id="edit_st_ymd" name="edit_st_ymd" type="text" style="width:80px;" class="datepicker" readonly="readonly" value="" />
	         </td>
	     </tr>
	     <tr>
	         <td class="sp">퇴실일자</td>
	         <td>
	         	<input id="edit_ed_ymd" name="edit_ed_ymd" type="text" style="width:80px;" class="datepicker" readonly="readonly" value="" />
	         </td>
	     </tr>
	     <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="lodge_edit_error_msg" >&nbsp;</div>
        	</td>
        </tr>
	    </table>
	    <p class="popbtn">
	    	<a href="javascript:edit();"><img src="../images/common/btn_input2.gif"/></a> 
	    	<a href="#" onclick="del();">[삭제]</a> 
	    	<a href="javascript:hide_layout_form('lodge_edit_form');"><img src="../images/common/btn_cancel.gif"/></a>
	    </p>
</div>