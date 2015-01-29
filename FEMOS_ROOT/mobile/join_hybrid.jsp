<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.visiter.MobileVisiter" %>
<%@ page import="com.util.CharacterSet"%>
<%
    String festival_cd = request.getParameter("festival_cd");
	String visiter_nm = request.getParameter("visiter_nm");
//	String visiter_nm = CharacterSet.UTF8toKorean(request.getParameter("visiter_nm"));
    String sex = request.getParameter("sex");
    String hp = request.getParameter("hp");
    String email = request.getParameter("email");
    
    MobileVisiter mv = new MobileVisiter();
    
    String mv_rtn = mv.strInsertVisiter(festival_cd, visiter_nm, sex, hp, email);
    
    if ( mv_rtn.length() > 0 ) {
//<!-- input type="hidden" id="visiter_id" name="visiter_id" value="mv_rtn" /-->
%>
<visiter_id><%=mv_rtn%></visiter_id>
<%
    } else {
%>
<visiter_id>error</visiter_id>
<%
    }
%>
