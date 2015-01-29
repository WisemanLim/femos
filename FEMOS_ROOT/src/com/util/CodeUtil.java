package com.util;

import java.util.Vector;
import com.code.Biz_code;
import com.code.Dal_code;

public class CodeUtil 
{
	public static String getCodeListCombo(String code_group,String code_value)
	{
		String retStr = "";

		Dal_code code_list = new Dal_code(); 
		code_list.getCodeList(code_group);
		Vector v_code_list = code_list.getV_list();
		
		for(int i = 0; i < v_code_list.size(); i++)
		{
			Biz_code code = (Biz_code)v_code_list.elementAt(i); 
			
			if(code_value.equals(code.getCode()))
			{
				retStr = retStr + "<option value='"+code.getCode()+"' selected='selected'>"+code.getCode_nm()+"</option>";
			}
			else 
			{
				retStr = retStr + "<option value='"+code.getCode()+"'>"+code.getCode_nm()+"</option>";
			}
		}
		
		return retStr;
	}
	
	
	public static String getCodeListRadio(String create_name,String code_group,String code_value)
	{
		String retStr = "";

		Dal_code code_list = new Dal_code(); 
		code_list.getCodeList(code_group);
		Vector v_code_list = code_list.getV_list();
		
		for(int i = 0; i < v_code_list.size(); i++)
		{
			Biz_code code = (Biz_code)v_code_list.elementAt(i); 
			
			if(code_value.equals(code.getCode()))
			{
				retStr = retStr + "<span style='color:"+code.getText_color()+"'>"+code.getCode_nm()+"</span>&nbsp;&nbsp;<input name='"+create_name+"' type='radio' value='"+code.getCode()+"' checked='checked' />&nbsp;&nbsp;&nbsp;";
			}
			else 
			{
				retStr = retStr + "<span style='color:"+code.getText_color()+"'>"+code.getCode_nm()+"</span>&nbsp;&nbsp;<input name='"+create_name+"' type='radio' value='"+code.getCode()+"' />&nbsp;&nbsp;&nbsp;";
			}
		}
		
		return retStr;
	}
}
