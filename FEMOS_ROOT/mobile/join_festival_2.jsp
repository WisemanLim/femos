<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String festival_cd = request.getParameter("festival_cd")!=null?request.getParameter("festival_cd"):"";
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
<form name="form1" method="post" action="./join_festival_save.jsp">
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd%>" />
<table width="320" height="600" border="0" background="main_bg.png">
<tr>
<td width="320"><span style="FONT-SIZE: 12pt"><font color="black">
<b>기본 정보를 입력하여주세요.</b>
<br>
</font></span>
<span style="FONT-SIZE: 10pt"><font color="black">
1. 이름<br/>
<input type="text" value="" name="visiter_nm" size="10">
2. 성별<br/>
<select name="sex"><option value="male">남자</option><option value="fmale">여자</option></select><br/>
3. 휴대전화<input type="text" value="" name="hp" size="16">(예,010-1234-5678)<br/>
4. 메일<input type="text" value="" name="email" size="40">
<center>
<a href="javascript:actionDo();"><img src="ok.png" border="0"></a>
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
    function actionDo(){ 
        document.form1.submit(); 
    } 
</script> 
