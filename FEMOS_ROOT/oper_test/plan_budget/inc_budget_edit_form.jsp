<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 예산입력 팝업시작 ------------------------------------------------------------------------------------------------------------->
<div id="budget_edit_form" class="popup1" style="margin:100px 0px 0px 200px;display:none">
    <p class="closebtn"><a href="javascript:hide_layout_form('budget_edit_form');"><img src="../images/common/btn_close.png"/></a></p>
    <h3><img src="../images/common/ic_01.gif" align="absmiddle" /> 예산계획 편집</h3>
    <table class="table2">
        <colgroup>
        <col width="25%" />
        <col width="75%" />
        </colgroup>
        <tr>
            <td class="sp">구분</td>
            <td>
            	<span id="edit_budget_div_nm"></span>
            </td>
        </tr>
        <tr>
            <td class="sp">상세내역</td>
            <td>
            	<input type="hidden" id="edit_budget_div" name="budget_div" value="" />
            	<input type="text" id="edit_detail_history" name="edit_detail_history" value="" style="width:98%;"/>
            </td>
        </tr>
        <tr>
            <td class="sp">예산액(원)</td>
            <td>
            	<input type="text" id="edit_budget_money" name="edit_budget_money" value="0" style="width:100px;text-align:right;"/> 원
            </td>
        </tr>
        <tr>
            <td class="sp">구성비(%)</td>
            <td>
            	<input type="text" id="edit_comp_ratio" name="edit_comp_ratio" value="0" style="width:100px;text-align:right;"/> %
            </td>
        </tr>
        <tr>
            <td class="sp">비고</td>
            <td>
            	<input type="text" id="edit_other" name="edit_other" value="" style="width:98%;"/>
            </td>
        </tr>
  
        <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="budget_edit_error_msg" >&nbsp;</div>
        	</td>
        </tr>
    </table>
    <p class="popbtn">
    	<a href="javascript:edit();"><img src="../images/common/btn_input2.gif"/></a> 
    	<a id="lnk_del" href="javascript:del();"><img src="../images/common/btn_delete2.gif"/></a> 
    	<a href="javascript:hide_layout_form('budget_edit_form');"><img src="../images/common/btn_cancel.gif"/></a>
    </p>
   
    
</div>
<!--// class="popup1"--> 