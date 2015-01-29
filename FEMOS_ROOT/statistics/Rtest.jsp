<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.rosuda.REngine.REXP" %>
<%@page import="org.rosuda.REngine.REXPMismatchException" %>
<%@page import="org.rosuda.REngine.Rserve.RConnection" %>
<%@page import="org.rosuda.REngine.Rserve.RserveException" %>
<%
	out.print("Rtest start<br/>");
	RConnection c;
	try {
		c = new RConnection("localhost", 6311);
		REXP x = c.eval("1+2");
		out.print(x.asInteger());
	} catch (RserveException e) {
		e.printStackTrace();
	} catch (REXPMismatchException e) {
		e.printStackTrace();
	} catch (Exception e) {
		e.printStackTrace();
	}
%>