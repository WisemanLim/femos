<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Random" %>
<%@ page import="com.util.CharacterSet" %>
<%@ page import="com.operation.research.Biz_research_user_info" %>
<%@ page import="com.operation.research.Dal_research_user_info" %>
<%@ page import="com.operation.research.Biz_research_q_item" %>
<%@ page import="com.operation.research.Dal_research_q_item" %>
<%@ page import="com.operation.research.Dal_research" %>
<%
	String sv_id = request.getParameter("sv_id");

	Dal_research_user_info user_list = new Dal_research_user_info(); 
	user_list.getResearch_user_info(sv_id);
	Vector v_user_list = user_list.getV_list();
	
	Dal_research_q_item q_list = new Dal_research_q_item();
	q_list.getResearch_q_item_list(sv_id);
	Vector v_q_list = q_list.getV_list();
	
	Dal_research result = new Dal_research();
	
	if(v_user_list.size() > 0)
	{
		for(int i = 0; i < v_user_list.size(); i++)
		{
			Biz_research_user_info user = (Biz_research_user_info)v_user_list.elementAt(i);
			out.println(i+1+")====================================================</br>");
			if(v_q_list.size() > 0)
			{
				for(int j = 0; j < v_q_list.size(); j++)
				{
					Biz_research_q_item q_item = (Biz_research_q_item)v_q_list.elementAt(j);
				
					Random r = new Random();
					int list_num = r.nextInt(5)+1;
					
					out.println("성명:"+user.getUser_nm()+",메일주소:"+user.getUser_mail_addr()+",문 "+q_item.getQ_num()+"."+q_item.getQ_text()+":["+list_num+"]"+"<br/>");
					
					result.insertResearch_result_answer(q_item.getRec_num(),Integer.toString(list_num),"",user.getUser_mail_addr());
				}
			}
		}
	}
%>