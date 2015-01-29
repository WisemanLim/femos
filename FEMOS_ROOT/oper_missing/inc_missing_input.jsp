<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 프로그램입력 팝업시작 ------------------------------------------------------------------------------------------------------------->
<div id="missing_input_form" class="popup1" style="margin:100px 0px 0px 200px;display:none">
    <p class="closebtn"><a href="javascript:hide_layout_form('missing_input_form');"><img src="../images/common/btn_close.png"/></a></p>
    <h3><img src="../images/common/ic_01.gif" align="absmiddle" /> 아동/노인 등록</h3>
    <table class="table2">
        <colgroup>
        <col width="28%" />
        <col width="72%" />
        </colgroup>
        <tr>
            <td class="sp">아동/노인 성명</td>
            <td>
            	<input id="inst_name" name="inst_name" type="text" style="width:250px;" value=""/>
            </td>
        </tr>
        <tr>
            <td class="sp">보호자 성명</td>
            <td>
            	<input id="inst_protector" name="inst_protector" type="text" style="width:250px;" value=""/>
            </td>
        </tr>
        <tr>
            <td class="sp">연락처</td>
            <td>
            	<input id="inst_protector_tel" name="inst_protector_tel" type="text" style="width:250px;" value=""/>
            </td>
        </tr>
        <tr>
        	<td colspan="2" style="text-align:center">
        		 <div id="missing_input_error_msg" >&nbsp;</div>
        	</td>
        </tr>
    </table>
    <p class="popbtn">
    	<a href="javascript:save();"><img src="../images/common/btn_input2.gif"/></a> 
    	<a href="javascript:hide_layout_form('missing_input_form');"><img src="../images/common/btn_cancel.gif"/></a>
    </p>
   
    
</div>
<!--// class="popup1"--> 