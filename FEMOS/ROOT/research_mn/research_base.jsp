<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h3>설문 기본 정보</h3>
<!--// class="searchbar"-->
<%
if(proc.equals("research_edit"))
{
%>
<table  class="table_research_base">
	<colgroup>
		<col width="100px" />
		<col width="500px" />
		<col width="100px" />
		<col width="200px" />
		<col width="*" />
	</colgroup>
	<tr>
		<th>설문제목</th>
		<td>
			<input type="text" id="sv_title" name="sv_title" value="<%=base_obj.getSv_title() %>" style="width:99%;" />
		</td>
		<th>설문년월</th>
		<td style="text-align:left;">
			<select id="sv_yyyy" name="sv_yyyy">
				<%
				for(int i = 2012; i <= java.util.Calendar.getInstance().get(java.util.Calendar.getInstance().YEAR); i++)
				{
				%>
				<option value="<%=i%>" <%if(Integer.parseInt(base_obj.getSv_yyyymm().substring(0,4)) == i){ %>selected="selected"<% }%>><%=i%></option>	
				<%
				} 
				%>
			</select>
			<select id="sv_mm" name="sv_mm">
				<%
			String m_str = "";
			for(int i = 1; i <= 12; i++)
			{
				if(i < 10)
				{
					m_str = "0"+Integer.toString(i);
				}
				else
				{
					m_str = Integer.toString(i);
				}
			%>
			<option value="<%=m_str%>" <%if(base_obj.getSv_yyyymm().substring(4,6).equals(m_str)){ %>selected="selected"<% }%>><%=m_str%> 월</option>
			<%
			}	
			%>
			</select>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<th>진행여부</th>
		<td colspan="3" style="text-align:left;">
			<select id="sv_end_yn" name="sv_end_yn">
				<option value="N" <%if(base_obj.getSv_end_yn().equals("N")){ %>selected="selected"<%} %>>진행</option>
				<option value="Y" <%if(base_obj.getSv_end_yn().equals("Y")){ %>selected="selected"<%} %>>만료</option>
			</select>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<th>비고</th>
		<td colspan="3"><input type="text" id="other" name="other" value="<%=base_obj.getOther() %>" style="width:99%;" /></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align:left">
			<div id="err_msg" style="float:left;padding:3px"> </div>
			<div style="float:right">
				<a href="#" onclick="save();"><img src="../images/btn/save.gif" alt="저장"/></a>
				<a href="research_view.jsp?sv_id=<%=sv_id %>"><img src="../images/btn/cancel.gif" alt="취소"/></a>
			</div>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
<%
}
else
{
%>
<table  class="table_research_base">
	<colgroup>
	<col width="100px" />
	<col width="500px" />
	<col width="100px" />
	<col width="200px" />
	<col width="*" />
	</colgroup>
	<tr>
		<th>설문제목</th>
		<td style="text-align:left;">
			<%=base_obj.getSv_title() %>
		</td>
		<th>설문년월</th>
		<td style="text-align:left;">
			<%=base_obj.getSv_yyyymm().substring(0,4) %>.<%=base_obj.getSv_yyyymm().substring(4,6) %>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<th>진행여부</th>
		<td colspan="3" style="text-align:left;">
			<%if(base_obj.getSv_end_yn().equals("N")){ %>
			진행
			<%}else{ %>
			만료
			<%} %>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<th>비고</th>
		<td colspan="3" style="text-align:left;"><%=base_obj.getOther() %></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align:right">
			<a href="research_list.jsp"><img src="../images/btn/btn_research_list.gif" alt="목록"/></a>
			<a href="research_view.jsp?sv_id=<%=sv_id%>&proc=group_add"><img src="../images/btn/btn_research_group_add.gif" alt="그룹추가"/></a>
			<a href="research_view.jsp?sv_id=<%=sv_id%>&proc=research_edit"><img src="../images/btn/btn_research_edit.gif" alt="설문편집"/></a>
			<a href="javascript:del_research('<%=sv_id%>');"><img src="../images/btn/btn_research_del.gif" alt="설문삭제"/></a>
			<a href="research_preview.jsp?sv_id=<%=sv_id%>"><img src="../images/btn/btn_research_preview.gif" alt="설문미리보기"/></a>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
<%
}
%>