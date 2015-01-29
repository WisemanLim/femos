<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	if(session.getAttribute("FESTIVAL_CD") == null)
	{
		out.print("<script>alert('연결정보가 없습니다. 다시 로그인후 이용해주세요.');location.href='../login.jsp';</script>");
	}
%>