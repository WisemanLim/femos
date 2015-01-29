package com.util;

import java.io.UnsupportedEncodingException;

public class CharacterSet 
{
	public static String UTF8toKorean(String str)
	{
		try {
			str = new String(str.getBytes("ISO-8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return str;
	}
	
	public static String converToMoney(int money) //금액 사이에 컴마를 찍는다.
	{
		//컴마를 찍을 자리 설정
		String convertedMoney = "";
		java.text.DecimalFormat dc = new java.text.DecimalFormat(",###");   
		convertedMoney = dc.format(money);
		
		return convertedMoney;
	}
	
	public static String cutOfString(String str,int limit)
	{
		String ret = "";
		
		if(str.length() > limit)
		{
			ret = str.substring(0,limit) + "...";
		}
		else
		{
			ret = str;
		}
		
		return ret;
	}
	
}
