<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.operation.research.Dal_research" %>
<%@ page import="com.operation.research.Biz_research_q_item" %>
<%@ page import="com.operation.research.Dal_research_q_item" %>
<%@page import="com.util.CharacterSet"%>
<%@ page import="java.util.Vector" %>
<%
	String sv_id = request.getParameter("sv_id")!=null?request.getParameter("sv_id"):"";
	String email = request.getParameter("user_mail_addr")!=null?request.getParameter("user_mail_addr"):"";
	String user_nm = request.getParameter("user_nm")!=null?CharacterSet.UTF8toKorean(request.getParameter("user_nm")):"";
	
	Dal_research research = new Dal_research();
	research.insertResearch_result_base(sv_id,email,user_nm);
	
	Dal_research_q_item q_item = new Dal_research_q_item();
	q_item.getResearch_q_item_list(sv_id);
	
	Vector v_q_list = q_item.getV_list();
	
	if(v_q_list.size() > 0)
	{
		for(int i = 0;  i < v_q_list.size(); i++ )
		{
			Biz_research_q_item q_item_obj = (Biz_research_q_item)v_q_list.elementAt(i);
			
			String [] list_nums = request.getParameterValues("item_"+q_item_obj.getRec_num());
			String [] list_texts = request.getParameterValues("item_"+q_item_obj.getRec_num()+"_text");
			if (list_nums != null)
			{
				for(int j = 0; j < list_nums.length; j++)
				{
					String list_num = list_nums[j];
					String list_text = "";
					
					if(list_texts != null)
					{
						if(list_texts.length < j)
						{
							list_text = "";	
						}
						else 
						{
							list_text = list_texts[j];
						}
					}
					
					research.insertResearch_result_answer(q_item_obj.getRec_num(),list_num,list_text,email);
				}
			}
		}
	}
%>

<script type="text/javascript">
alert('설문에 응답해주셔서 대단히 감사합니다.');
location.href='research.jsp?sv_id=<%=sv_id%>';
</script>