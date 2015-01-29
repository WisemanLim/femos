<%@page contentType="application/json; charset=UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page import="com.util.CharacterSet"%>
<%@page import="com.plan.layout.Dal_route_base"%>
<%@page import="com.plan.layout.Dal_route_smu"%>
<%
	Dal_route_smu smu = new Dal_route_smu();
	smu.getTB_AllBase();
	JSONObject obj = smu.getJSON();
	out.print(obj);
	out.flush();
%>