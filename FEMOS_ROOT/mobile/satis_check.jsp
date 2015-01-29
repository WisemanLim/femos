<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.satisfaction.MobileSatisfied" %>
<%@ page import="com.util.CharacterSet"%>
<%
    String festival_cd = request.getParameter("festivalCd");
	String festival_hall_cd = request.getParameter("festivalHallCd");
	String visiter_id = request.getParameter("visiterId")!=null?request.getParameter("visiterId"):"";
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
<form name="form1" method="post" action="./satis_check_prc.jsp">
<table width="320" height="600" border="0" background="main_bg.png">
<tr>
<td width="320"><span style="FONT-SIZE: 12pt"><font color="black">
<input type="hidden" id="festival_hall_cd" name="festival_hall_cd" value="<%=festival_hall_cd%>" />
<center>
안성세계민속축전 부스에 대한 평가를 해 주세요.<br/><br/><br/><br/>
</center>
</font></span>
</td>
</tr>
</table>
</form>
</div>
</div>
</BODY>
</HTML>
<script> 
    function setFestivalHallCd(festivalHallCd) {
    	document.form1.festival_hall_cd.value = festivalHallCd;
    }
</script> 
