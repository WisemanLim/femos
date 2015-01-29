package com.util;

import com.operation.research.*;
import java.util.Vector;


public class ResearchUtil 
{
	public static String getSelectMethod(String select_method)
	{
		String ret = "";
		if(select_method.equals("0"))
		{
			ret = "객관식";
		}
		else if(select_method.equals("1"))
		{
			ret = "주관식";
		}
		else if(select_method.equals("2"))
		{
			ret = "우선순위기입방식";
		}
		else if(select_method.equals("3"))
		{
			ret = "다중선택객관식";
		}
		return ret;
	}
	
	public static String getSortMethod(String sort_method)
	{
		String ret = "";
		if(sort_method.equals("0"))
		{
			ret = "가로정렬";
		}
		else if(sort_method.equals("1"))
		{
			ret = "세로정렬";
		}
		
		return ret;
	}
	
	public static String research_item_write(String param_sv_id, int param_sv_group)
	{
		String responseHtml = "";
		
		Dal_research_q_item q_item = new Dal_research_q_item();
		q_item.getResearch_q_item_list(param_sv_id, param_sv_group);
		
		Vector v_q_list = q_item.getV_list();
		
		if(v_q_list.size() > 0 )
		{
			for(int i = 0; i < v_q_list.size(); i++)
			{
				Biz_research_q_item q_item_obj = (Biz_research_q_item)v_q_list.elementAt(i);
				
				responseHtml = responseHtml + "<div class='q_items'>";
				responseHtml = responseHtml + "	<div style='font-weight:bold;font-size:8pt;'>";
				responseHtml = responseHtml + "		문 "+q_item_obj.getQ_num()+". "+q_item_obj.getQ_text();
				responseHtml = responseHtml + "		<input type='hidden' id='q_"+q_item_obj.getRec_num()+"' name='q_"+q_item_obj.getRec_num()+"' value='"+q_item_obj.getRec_num()+"'/>";
				responseHtml = responseHtml + "	</div>";
				responseHtml = responseHtml + "	<div style='margin-top:10px;font-size:8pt;'>";
				
				if(q_item_obj.getSelect_method().equals("2"))
				{
					responseHtml = responseHtml + "<div style='padding-bottom:10px;'> ";	
					responseHtml = responseHtml + "(1순위 :  <input type='text' name='item_"+q_item_obj.getRec_num()+"_text' value='' style='width:20px;' onkeyup='ValidNumber(this)' onblur='ValidNumber(this)'/>, ";
					responseHtml = responseHtml + "  2순위 : <input type='text' name='item_"+q_item_obj.getRec_num()+"_text' value='' style='width:20px;' onkeyup='ValidNumber(this)' onblur='ValidNumber(this)'/>, ";
					responseHtml = responseHtml + "  3순위 : <input type='text' name='item_"+q_item_obj.getRec_num()+"_text' value='' style='width:20px;' onkeyup='ValidNumber(this)' onblur='ValidNumber(this)'/> )";
					
					responseHtml = responseHtml + "</div>"; 
				}
				
				responseHtml = responseHtml + reserch_item_a_list(q_item_obj.getSelect_method(),q_item_obj.getSort_method(),q_item_obj.getRec_num());
				
				responseHtml = responseHtml + "	</div>";
				responseHtml = responseHtml + "</div>";
				responseHtml = responseHtml + "<div style='clear:both;'> </div>";
			}
		}
		
		return responseHtml;
	}
	
	
	public static String reserch_item_a_list(String param_select_method,String param_align,int param_rec_num)
	{
		
		String responseHtml = "";
		
		String align = "";
		
		if(param_align.equals("0"))
		{
			align = "float:left;margin-left:10px;";
		}
		else if(param_align.equals("1"))
		{
			align = "margin-top:10px;";
		}
		
		Dal_research_a_item a_item = new Dal_research_a_item();
		a_item.getResearch_a_item_list(param_rec_num);
		Vector v_a_list = a_item.getV_list();
		
		if(v_a_list.size() > 0)
		{
			for(int i = 0; i < v_a_list.size(); i++)
			{
				Biz_research_a_item a_item_obj = (Biz_research_a_item)v_a_list.elementAt(i);
				
				if(param_select_method.equals("0"))
				{
					responseHtml = responseHtml + "		<div style='"+align+"'><input type='radio' name='item_"+param_rec_num+"' value='"+a_item_obj.getList_num()+"' />"+a_item_obj.getA_text();
					if(a_item_obj.getOther_yn().equals("Y"))
					{
						responseHtml = responseHtml + a_item_obj.getOther_first()+"	<input type='text' name='item_"+param_rec_num+"_text' value=''  style='width:"+a_item_obj.getOther_width()+"px;'/> "+a_item_obj.getOther_last();
					}
					responseHtml = responseHtml + "		</div>";
				}
				else if(param_select_method.equals("1"))
				{
					responseHtml = responseHtml + "		<div style='"+align+"'><input type='hidden' name='item_"+param_rec_num+"' value='"+a_item_obj.getList_num()+"' />"+a_item_obj.getA_text();
					if(a_item_obj.getOther_yn().equals("Y"))
					{
						responseHtml = responseHtml + a_item_obj.getOther_first()+"	<input type='text' name='item_"+param_rec_num+"_text' value=''  style='width:"+a_item_obj.getOther_width()+"px;'/> "+a_item_obj.getOther_last();
					}
					responseHtml = responseHtml + "		</div>";
				}
				else if(param_select_method.equals("2"))
				{
					responseHtml = responseHtml + "		<div style='"+align+"'><input type='hidden' name='item_"+param_rec_num+"' value='"+a_item_obj.getA_num()+"' />"+a_item_obj.getA_num()+") "+a_item_obj.getA_text();
					if(a_item_obj.getOther_yn().equals("Y"))
					{
						responseHtml = responseHtml + a_item_obj.getOther_first() +"	<input type='text' name='item_"+param_rec_num+"_text' value=''  style='width:"+a_item_obj.getOther_width()+"px;' /> "+a_item_obj.getOther_last();
					}
					responseHtml = responseHtml + "		</div>";
				}
				else if(param_select_method.equals("3"))
				{
					responseHtml = responseHtml + "		<div style='"+align+"'><input type='checkbox' name='item_"+param_rec_num+"' value='"+a_item_obj.getList_num()+"' />"+a_item_obj.getA_text();
					if(a_item_obj.getOther_yn().equals("Y"))
					{
						responseHtml = responseHtml + a_item_obj.getOther_first() +"	<input type='text' name='item_"+param_rec_num+"_text' value=''  style='width:"+a_item_obj.getOther_width()+"px;'/> "+a_item_obj.getOther_last();
					}
					responseHtml = responseHtml + "		</div>";
				}
			}
		}
		
		return responseHtml;
	}
}
