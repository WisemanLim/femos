<%@page import="com.util.ResearchUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="com.operation.research.Dal_research_a_item" %>
<%@ page import="com.operation.research.Biz_research_a_item" %>
<%@ page import="com.util.CharacterSet"%>
<%
	Dal_research_a_item a_item = new Dal_research_a_item();
	a_item.getResearch_a_item_list(q_item_obj.getRec_num());
	Vector a_item_list = a_item.getV_list();
	if(a_item_list.size() > 0 )
	{
		for(int k = 0; k < a_item_list.size(); k++)
		{
			Biz_research_a_item a_item_obj = (Biz_research_a_item)a_item_list.elementAt(k);
			
			if(proc.equals("a_item_edit") && rec_num == a_item_obj.getRec_num() && list_num == a_item_obj.getList_num())
			{
%>
				<div style="margin-top:10px">
					<h3>설문 선택항목 편집</h3>
					<table class="table_research_a_item">
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
								<input type="text" id="a_num" name="a_num" value="<%=a_item_obj.getA_num() %>"  style="width:30px;" onkeyup="ValidNumber(this)" onblur="ValidNumber(this)"/>
								&nbsp;)&nbsp;&nbsp;<input type="text" id="a_text" name="a_text" value="<%=a_item_obj.getA_text() %>" style="width:600px;" />
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th>기타값허용</th>
							<td style="text-align:left;">
								<select id="other_yn" name="other_yn">
									<option value="Y" <%if(a_item_obj.getOther_yn().equals("Y")){ %>selected="selected"<%} %>>Y</option>
									<option value="N" <%if(a_item_obj.getOther_yn().equals("N")){ %>selected="selected"<%} %>>N</option>
								</select>
							</td>
							<th>기타값너비</th>
							<td style="text-align:left;"><input type="text" id="other_width" name="other_width" value="<%=a_item_obj.getOther_width() %>" onkeyup="ValidNumber(this)" onblur="ValidNumber(this)"  style="width:30px;"/>px</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th>기타값_앞자리</th>
							<td style="text-align:left;"><input type="text" id="other_first" name="other_first" value="<%=a_item_obj.getOther_first()==null?"":a_item_obj.getOther_first() %>" style="width:80px;"/></td>
							<th>기타값_뒤자리</th>
							<td style="text-align:left;"><input type="text" id="other_last" name="other_last" value="<%=a_item_obj.getOther_last()==null?"":a_item_obj.getOther_last() %>" style="width:80px;"/></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="4">
								<div id="err_msg" style="float:left;padding:3px"> </div>
								<div style="float:right">
									<a href="javascript:a_item_edit();"><img src="../images/btn/save.gif" alt="저장"/></a>
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
					<h3>설문 선택항목 정보</h3>
					<table class="table_research_a_item">
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
								<%=a_item_obj.getA_num() %>
								&nbsp;)&nbsp;&nbsp;<%=a_item_obj.getA_text() %>
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th>기타값허용</th>
							<td style="text-align:left;">
								<%=a_item_obj.getOther_yn() %>
							</td>
							<th>기타값너비</th>
							<td style="text-align:left;"><%=a_item_obj.getOther_width() %> px</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th>기타값_앞자리</th>
							<td style="text-align:left;"><%=a_item_obj.getOther_first()==null?"":a_item_obj.getOther_first() %></td>
							<th>기타값_뒤자리</th>
							<td style="text-align:left;"><%=a_item_obj.getOther_last()==null?"":a_item_obj.getOther_last() %></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="4" style="text-align:right">
								<a href="research_view.jsp?sv_id=<%=sv_id%>&sv_group=<%=sv_group%>&rec_num=<%=a_item_obj.getRec_num()%>&list_num=<%=a_item_obj.getList_num()%>&proc=a_item_edit"><img src="../images/btn/btn_research_a_edit.gif" alt="선택항목편집" /></a>
								<a href="javascript:del_a_item('<%=sv_id %>','<%= a_item_obj.getList_num()%>','<%=a_item_obj.getRec_num() %>')"><img src="../images/btn/btn_research_a_del.gif" alt="선택항목삭제" /></a>
							</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</div>
<%			
			}
		}
%>
	
<%		
	}
	else
	{
%>
				<div style="margin-top:10px">
					<h3>설문 선택항목 정보</h3>
					<table class="table_research_a_item">
						<colgroup>
							<col width="900px" />
							<col width="*" />
						</colgroup>
						<tr>
							<td>
								등록된 선택항목이 없습니다.
							</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</div>
<%
	}
%>
<%
	if(proc.equals("a_item_add") && rec_num == q_item_obj.getRec_num())
	{
%>
				<div style="margin-top:10px">
					<h3>설문 선택항목 추가</h3>
					<table class="table_research_a_item">
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
								<input type="text" id="a_num" name="a_num" value=""  style="width:30px;" onkeyup="ValidNumber(this)" onblur="ValidNumber(this)"/>
								&nbsp;)&nbsp;&nbsp;<input type="text" id="a_text" name="a_text" value="" style="width:600px;" />
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th>기타값허용</th>
							<td style="text-align:left;">
								<select id="other_yn" name="other_yn">
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</td>
							<th>기타값너비</th>
							<td style="text-align:left;"><input type="text" id="other_width" name="other_width" value="0" onkeyup="ValidNumber(this)" onblur="ValidNumber(this)"  style="width:30px;"/>px</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<th>기타값_앞자리</th>
							<td style="text-align:left;"><input type="text" id="other_first" name="other_first" value="" style="width:80px;"/></td>
							<th>기타값_뒤자리</th>
							<td style="text-align:left;"><input type="text" id="other_last" name="other_last" value="" style="width:80px;"/></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="4">
								<div id="err_msg" style="float:left;padding:3px"> </div>
								<div style="float:right">
									<a href="javascript:a_item_save();"><img src="../images/btn/save.gif" alt="저장"/></a>
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