<%@ page import="com.code.*" %><%@ page import="java.util.Vector" %><%@ page language="java" contentType="text/xml; charset=utf-8" pageEncoding="utf-8"%><%
	
	String code_group = request.getParameter("code_group");
	out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>"); 
	
	out.println("<codegroup id=\""+code_group+"\">");
	Dal_code code = new Dal_code();
	code.getCodeList(code_group);
	Vector list = code.getV_list();
	for(int i = 0; i < list.size(); i++)
	{
		Biz_code obj = (Biz_code)list.elementAt(i);
		out.println("<data>");
		out.println("<val>"+obj.getCode()+"</val>");
		out.println("<name>"+obj.getCode_nm()+"</name>"); 
		out.println("<textcolor>"+obj.getText_color()+"</textcolor>");
		out.println("</data>");
	}
	out.println("</codegroup>");
%>