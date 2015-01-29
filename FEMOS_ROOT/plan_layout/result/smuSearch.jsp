<%@page contentType="application/json; charset=UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page import="com.util.CharacterSet"%>
<%@page import="com.plan.layout.Dal_route_base"%>
<%@page import="com.plan.layout.Dal_route_smu"%>
<%
	String _cd = request.getParameter("cd");
	String _type = request.getParameter("pt");
	
	if( _cd.substring(0,3).equals("FES") ){
		_cd = "FS" + _cd.substring(3);
	}
	
	Dal_route_smu smu = new Dal_route_smu();
	
	if( _type.equals("building") ){
		smu.getBuildingByFhcd(_cd);
	}else if( _type.equals("route") ){		
		smu.getRouteByFhcd(_cd);
	}

	JSONObject obj = smu.getJSON();
	out.print(obj);
	out.flush();
%>