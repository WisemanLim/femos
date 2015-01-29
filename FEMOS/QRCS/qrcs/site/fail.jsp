<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>

	<%
	    JSONObject obj=new JSONObject();
	    obj.put("result","fail");	    
	    out.print(obj);
	    out.flush();
	%>
