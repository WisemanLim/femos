<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 예산입력 팝업시작 ------------------------------------------------------------------------------------------------------------->
<div id="budget_div_input_form" class="popup1" style="margin:100px 0px 0px 200px;display:none">
    <p class="closebtn"><a href="javascript:hide_layout_form('budget_div_input_form');"><img src="../images/common/btn_close.png"/></a></p>
    <h3><img src="../images/common/ic_01.gif" align="absmiddle" /> 예산구분  입력</h3>
    <table class="table2">
        <colgroup>
        <col width="25%" />
        <col width="75%" />
        </colgroup>
        <tr>
            <td class="sp">명칭</td>
            <td>
            	<input type="text" id="div_nm" name="div_nm" value="" style="width:98%;"/>
            </td>
        </tr>
        
        <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="budget_div_input_error_msg" >&nbsp;</div>
        	</td>
        </tr>
    </table>
    <p class="popbtn">
    	<a href="javascript:save_budget_div();"><img src="../images/common/btn_input2.gif"/></a> 
    	<a href="javascript:hide_layout_form('budget_div_input_form');"><img src="../images/common/btn_cancel.gif"/></a>
    </p>
   
    
</div>
<!--// class="popup1"--> 