<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.visiter.MobileVisiter" %>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.util.*, java.lang.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta name = "viewport" content = "user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="keywords" content="안성세계민속축전" />
<title></title>
<link rel="stylesheet" type="text/css" href="http://www.inven.co.kr/mobile/lib/style/layout.css?v=20120104a"/>
<script type="text/javascript" src="http://www.inven.co.kr/common/lib/js/common.js"></script>
<script type="text/javascript" src="http://www.inven.co.kr/common/lib/js/xml.js"></script>
<script type="text/javascript" src="http://www.inven.co.kr/mobile/lib/js/common.js"></script>
<link rel = "apple-touch-icon" href = "http://img.inven.co.kr/image/mobile/common/logo_iphone.png" />
</head>
<body>
<div id = "mobileWrap">
<div id = "topNav">
<table width="320" height="600" border="0"  background="main_bg.png">
<tr>
<td>
<center>
<span style="FONT-SIZE: 10pt"><font color="black">
<%
    String festival_cd = request.getParameter("festival_cd")!=null?request.getParameter("festival_cd"):"";
    String festival_hall_cd = request.getParameter("festival_hall_cd")!=null?request.getParameter("festival_hall_cd"):"";
	String serial = request.getParameter("serial")!=null?request.getParameter("serial"):"";
	String visiter_id = request.getParameter("visiter_id")!=null?request.getParameter("visiter_id"):"";
    
    MobileVisiter mv = new MobileVisiter();
    
    boolean mv_rtn = mv.insertVisiterState(festival_cd, Integer.parseInt(serial), visiter_id, festival_hall_cd);
    
    if ( mv_rtn ) {
%>
방문객 체크가 완료 하였습니다.
<%
    } else {
%>
방문객 체크가 실패 하였습니다.
<%
	}
%>
</font></span>
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd%>" />
<input type="hidden" id="serial" name="serial" value="<%=serial%>" />
<input type="hidden" id="visiter_id" name="visiter_id" value="<%=visiter_id%>" />
<input type="hidden" id="festival_hall_cd" name="festival_hall_cd" value="<%=festival_hall_cd%>" />
</center>
</td>
</tr>
</table>
</div></div>
</BODY>
</HTML>
