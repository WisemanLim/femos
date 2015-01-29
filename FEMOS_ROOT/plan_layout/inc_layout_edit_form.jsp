<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="edit_layout_form" class="drag">
	<div style="width:100%;">
		<div style="float:left;color:#000;font-weight:bold;">
			구역편집
		</div>
		<div style="float:right;padding-bottom:10px;">
			<a href="javascript:hide_layout_form('edit_layout_form');"><img src="../images/btn/btn_close_x.gif" alt="닫기"/></a>
		</div>
	</div>
	
	<div class="tb_layout_form" style="width:100%;">
		<table cellspacing="1" cellpadding="3">
			
			<tr>
				<th>구역명칭</th>
				<td>
					<input id="edit_festival_hall_cd" name="edit_festival_hall_cd" type="hidden" value="" />
					<input id="edit_festival_hall_nm" name="edit_festival_hall_nm" type="text" value="" style="width:99%;"/>
				</td>
				<td style="text-align:right">
					<a href="javascript:edit();"><img src="../img/btn_save.gif" alt="저장" align="absmiddle" /></a>
				</td>
			</tr>
		</table>
	</div>
	<div id="edit_error_msg" style="float:left;color:#f20909;padding:4px;"></div>
</div>