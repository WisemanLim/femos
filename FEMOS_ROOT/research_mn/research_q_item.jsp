<%@page import="com.util.ResearchUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.operation.research.Dal_research_q_item" %>
<%@ page import="com.operation.research.Biz_research_q_item" %>
<%@ page import="com.util.CharacterSet"%>
<%
	Dal_research_q_item q_item = new Dal_research_q_item();
	q_item.getResearch_q_item_list(sv_id,group_obj.getSv_group());
	Vector v_q_item_list = q_item.getV_list();
	if(v_q_item_list.size() > 0)
	{
		for(int j = 0; j < v_q_item_list.size(); j++)
		{
			Biz_research_q_item q_item_obj = (Biz_research_q_item)v_q_item_list.elementAt(j);
			if(rec_num == q_item_obj.getRec_num() && proc.equals("q_item_edit"))
			{
%>
			<div style="margin-top:10px">
				<h3>설문 문항 편집</h3>
				<table class="table_research_q_item">
					<colgroup>
						<col width="100px" />
						<col width="350px" />
						<col width="100px" />
						<col width="350px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>번호/텍스트</th>
						<td colspan="3" style="text-align:left;">
							문 <input type="text" id="q_num" name="q_num" value="<%=q_item_obj.getQ_num()%>"  style="width:30px;" onkeyup="ValidNumber(this)" onblur="ValidNumber(this)"/>
							&nbsp;.&nbsp;&nbsp;<input type="text" id="q_text" name="q_text" value="<%=q_item_obj.getQ_text()%>" style="width:600px;" />
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>문항선택방식</th>
						<td style="text-align:left;">
							<select id="select_method" name="select_method">
								<option value="0" <%if(q_item_obj.getSelect_method().equals("0")){ %>selected="selected"<%} %>>객관식</option>
								<option value="3" <%if(q_item_obj.getSelect_method().equals("3")){ %>selected="selected"<%} %>>다중선택객관식</option>
							</select>
						</td>
						<th>문항정렬방식</th>
						<td style="text-align:left;">
							<select id="sort_method" name="sort_method">
								<option value="0" <%if(q_item_obj.getSort_method().equals("0")){ %>selected="selected"<%} %>>가로정렬</option>
								<option value="1" <%if(q_item_obj.getSort_method().equals("1")){ %>selected="selected"<%} %>>세로정렬</option>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4">
							<div id="err_msg" style="float:left;padding:3px"> </div>
							<div style="float:right">
								<a href="javascript:q_item_edit();"><img src="../images/btn/save.gif" alt="저장"/></a>
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
				<h3>설문 문항 정보</h3>
				<table class="table_research_q_item">
					<colgroup>
						<col width="100px" />
						<col width="350px" />
						<col width="100px" />
						<col width="350px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>번호/텍스트</th>
						<td colspan="3" style="text-align:left;">
							문 <%=q_item_obj.getQ_num() %>&nbsp;.&nbsp;&nbsp;<%=q_item_obj.getQ_text()%>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>문항선택방식</th>
						<td style="text-align:left;">
							<%=ResearchUtil.getSelectMethod(q_item_obj.getSelect_method()) %>
						</td>
						<th>문항정렬방식</th>
						<td style="text-align:left;">
							<%=ResearchUtil.getSortMethod(q_item_obj.getSort_method()) %>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:right">
							<a href="research_view.jsp?sv_id=<%=sv_id%>&sv_group=<%=group_obj.getSv_group()%>&rec_num=<%=q_item_obj.getRec_num()%>&proc=a_item_add"><img src="../images/btn/btn_research_a_add.gif" alt="선택항목추가" /></a>
							<a href="research_view.jsp?sv_id=<%=sv_id%>&sv_group=<%=group_obj.getSv_group()%>&rec_num=<%=q_item_obj.getRec_num()%>&proc=q_item_edit"><img src="../images/btn/btn_research_q_edit.gif" alt="문항편집" /></a>
							<a href="javascript:del_q_item('<%=sv_id%>','<%=q_item_obj.getRec_num()%>')"><img src="../images/btn/btn_research_q_del.gif" alt="문항삭제" /></a>
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>
			<%
			}
			%>
			<%@include file="research_a_item.jsp" %>
			<%
		}
	}
	else
	{
%>
			<div style="margin-top:10px">
				<h3>설문 문항 정보</h3>
				<table  class="table_research_q_item">
					<colgroup>
						<col width="900px"/>
						<col width="*"/>
					</colgroup>
					<tr>
						<td>
							등록된 설문 문항이 없습니다.
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>
<%
	}
%>

<%
	if(sv_group == group_obj.getSv_group() && proc.equals("q_item_add"))
	{
%>
			<div style="margin-top:10px">
				<h3>설문 문항 추가</h3>
				<table  class="table_research_q_item">
					<colgroup>
						<col width="100px" />
						<col width="350px" />
						<col width="100px" />
						<col width="350px" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>번호/텍스트</th>
						<td colspan="3" style="text-align:left;">
							문 <input type="text" id="q_num" name="q_num" value=""  style="width:30px;" onkeyup="ValidNumber(this)" onblur="ValidNumber(this)"/>
							&nbsp;.&nbsp;&nbsp;<input type="text" id="q_text" name="q_text" value="" style="width:600px;" />
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>문항선택방식</th>
						<td style="text-align:left;">
							<select id="select_method" name="select_method">
								<option value="0">객관식</option>
								<option value="3">다중선택객관식</option>
							</select>
						</td>
						<th>문항정렬방식</th>
						<td style="text-align:left;">
							<select id="sort_method" name="sort_method">
								<option value="0">가로정렬</option>
								<option value="1">세로정렬</option>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4">
							<div id="err_msg" style="float:left;padding:3px"> </div>
							<div style="float:right">
								<a href="javascript:q_item_save();"><img src="../images/btn/save.gif" alt="저장"/></a>
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