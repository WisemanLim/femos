<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

	<%
	    JSONObject obj=new JSONObject();
	    obj.put("result","success");	    
	    out.print(obj);
	    out.flush();
	%>

