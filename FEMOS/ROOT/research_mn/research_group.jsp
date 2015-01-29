<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.operation.research.Dal_research_group" %>
<%@ page import="com.operation.research.Biz_research_group" %>
<%@ page import="com.util.CharacterSet"%>
<%
	Dal_research_group group = new Dal_research_group();
	group.getResearch_group_list(sv_id);
	Vector v_group_list = group.getV_list();
	
	if(v_group_list.size() > 0)
	{
		for(int i = 0; i < v_group_list.size(); i++)
		{
			Biz_research_group group_obj = (Biz_research_group)v_group_list.elementAt(i);
			if(sv_group == group_obj.getSv_group() && proc.equals("group_edit"))
			{
%>
			<div style="margin-top:10px">
			<h3>설문 그룹 편집</h3>
			<table  class="table_research_group">
				<colgroup>
					<col width="100px"/>
					<col width="800px"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<th>그룹명</th>
					<td><input type="text" id="sv_group_nm" name="sv_group_nm" value="<%=group_obj.getSv_group_nm() %>" style="width:99%;"/></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>설명</th>
					<td>
						<textarea id="sv_group_summary" name="sv_group_summary" style="width:100%;height:200px"><%=group_obj.getSv_group_summary() %></textarea>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="err_msg" style="float:left;padding:3px"> </div>
						<div style="float:right">
							<a href="javascript:group_edit();"><img src="../images/btn/save.gif" alt="저장"/></a>
							<a href="research_view.jsp?sv_id=<%=sv_id %>"><img src="../images/btn/cancel.gif" alt="취소"/></a>
						</div>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			</div>
<%				
			}
			else
			{
%>
			<div style="margin-top:10px">
			<h3>설문 그룹 정보</h3>
			<table  class="table_research_group">
				<colgroup>
					<col width="100px"/>
					<col width="800px"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<th>그룹명</th>
					<td style="text-align:left;"><%=group_obj.getSv_group_nm() %></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>설명</th>
					<td style="text-align:left;">
						<%=group_obj.getSv_group_summary().replaceAll(System.getProperty("line.separator"),"<br/>") %>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:right">
						<a href="research_view.jsp?sv_id=<%=sv_id %>&sv_group=<%=group_obj.getSv_group() %>&proc=q_item_add"><img src="../images/btn/btn_research_q_add.gif" alt="문항추가"/></a>
						<a href="research_view.jsp?sv_id=<%=sv_id %>&sv_group=<%=group_obj.getSv_group() %>&proc=group_edit"><img src="../images/btn/btn_research_group_edit.gif" alt="그룹편집"/></a>
						<a href="javascript:del_group_item('<%=sv_id %>','<%=group_obj.getSv_group() %>');"><img src="../images/btn/btn_research_group_del.gif" alt="그룹삭제"/></a>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>		
<%		
			}
%>
			<%@include file="research_q_item.jsp" %>
<%

		}
	}
	else
	{
%>
			<div style="margin-top:10px">
			<h3>설문 그룹 정보</h3>
			<table  class="table_research_group">
				<colgroup>
					<col width="900px"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<td>
						설문그룹이 없습니다. 설문 문항을 추가하기 위해서는 설문그룹을 등록하여야 합니다.
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
<%		
	}
%>
</div>
<%
	if(proc.equals("group_add"))
	{
%>
			<div style="margin-top:10px">
			<h3>설문 그룹 추가</h3>
			<table  class="table_research_group">
				<colgroup>
					<col width="100px"/>
					<col width="800px"/>
					<col width="*"/>
				</colgroup>
				<tr>
					<th>그룹명</th>
					<td><input type="text" id="sv_group_nm" name="sv_group_nm" value="" style="width:99%;"/></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<th>설명</th>
					<td>
						<textarea id="sv_group_summary" name="sv_group_summary" style="width:100%;height:200px"></textarea>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="err_msg" style="float:left;padding:3px"> </div>
						<div style="float:right">
							<a href="javascript:group_save();"><img src="../images/btn/save.gif" alt="저장"/></a>
							<a href="research_view.jsp?sv_id=<%=sv_id %>"><img src="../images/btn/cancel.gif" alt="취소"/></a>
						</div>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			</div>
<%	
	}
%>

