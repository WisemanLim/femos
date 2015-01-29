<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.visiter.MobileVisiter" %>
<%@ page import="com.util.CharacterSet"%>
<%
    String festival_cd = request.getParameter("festival_cd");
    String visiter_id = request.getParameter("visiter_id");
	String visiter_nm = CharacterSet.UTF8toKorean(request.getParameter("visiter_nm"));
    String sex = request.getParameter("sex");
    String hp = request.getParameter("hp");
    String email = request.getParameter("email");
%>
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
<img src="./a_festival_ok.png" border="0" width="317" height="382">
</font></span>
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd%>" />
<input type="hidden" id="visiter_nm" name="visiter_nm" value="<%=visiter_nm%>" />
<input type="hidden" id="sex" name="sex" value="<%=sex%>" />
<input type="hidden" id="hp" name="hp" value="<%=hp%>" />
<input type="hidden" id="email" name="email" value="<%=email%>" />
<input type="hidden" id="visiter_id" name="visiter_id" value="<%=visiter_id%>" />
</center>
</td>
</tr>
</table>
</div></div>
</BODY>
</HTML>
