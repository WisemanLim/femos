<%@ page import="com.plan.smu.*" %><%@ page import="java.util.Vector" %><%@ page language="java" contentType="text/xml; charset=utf-8" pageEncoding="utf-8"%><%
	
	String festival_cd = request.getParameter("festival_cd");
	out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>"); 
	
	out.println("<festival id=\""+festival_cd+"\">");
	Dal_smu_base smu = new Dal_smu_base();
	smu.get_smu_base_list(festival_cd);
	Vector list = smu.getV_list();
	for(int i = 0; i < list.size(); i++)
	{
		Biz_smu_base obj = (Biz_smu_base)list.elementAt(i);
		out.println("<data>");
		out.println("<val>"+obj.getFestival_hall_cd()+"</val>");
		out.println("<name>"+obj.getFestival_hall_nm()+"</name>"); 
		out.println("</data>");
	}
	out.println("</festival>");
%>