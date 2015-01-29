<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.visiter.MobileVisiter" %>
<%@ page import="com.util.CharacterSet"%>
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
<%
	String festival_cd = request.getParameter("festivalCd")!=null?request.getParameter("festivalCd"):"";
    String visiter_id = request.getParameter("visiterId")!=null?request.getParameter("visiterId"):"";
    
    // count checking 만들 것
/*     MobileVisiter mv = new MobileVisiter();
    int cnt = mv.selectVisiter(festival_cd, visiter_id);
 */    
    int cnt = 0;
    if ( cnt > 0 ) {
%>
<table width="320" height="600" border="0"  background="main_bg.png">
<tr>
<td>
<center>
<span style="FONT-SIZE: 12pt"><font color="black">
<b>2012 안성세계민속축전</b><br><br><br></font></span>
<span style="FONT-SIZE: 10pt"><font color="black">
사용자분께서는 이미 축제참여를 하셨습니다.
</font></span>
</center>
</td>
</tr>
</table>
<%
    } else {
    	festival_cd = "FES10001";
%>
<form name="form1" method="post" action="./join_festival_2.jsp">
<input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd%>" />
<table width="320" height="600" border="0"  background="main_bg.png">
<tr>
<td>
<span style="FONT-SIZE: 12pt"><font color="black">
2012 안성세계민속축전은 CIOFF<sup>&#174;</sup>(국제민속축전기구협의회)가 매 4년마다 개최하는 국제민속축전으로서 1996년 네덜란드에서
첫 대회가 시작하여 2012년 대한민국 안성시에서 개최되는 지구촌 무형의 전통 민속공연 축전입니다.
<br/><br/>
따라서 우리는 2012년 전 세계의 무형 유산을 국내외 관광객들에게 소개하고 전통문화의 보전과 보급이라는 CIOFF<sup>&#174;</sup> 및
UNESCO의 기본이념을 발전시켜 전 세계의 우호증진과 평화 정착에 기여하고자 합니다. <br />
그리고 다양한 인종과 민족의 영혼이 담긴 대표적인 민속 공연을 접할 수 있는 축전이 될 수 있도록 준비하겠습니다.
<br/><br/>
안성은 남사당 놀이와 태평무, 향당무, 안성맞춤 유기장, 입사장, 주물장 등 한국의 대표적 무형문화유산이 연면해 오고
있으며 시인, 화가, 무용가들이 활동하고 있는 예향의 도시입니다.
<br/><br/>
시민이 행복한 맞춤도시에서 더 나아가 한국 민속문화의 메카에서 펼쳐지는 인류 화해와 평화의 축전에서 여러분을 꼭 뵙기를
소망합니다.
<br/><br/>
감사합니다.<br/><br/>
<center>
<a href="javascript:actionDo();"><img src="ok.png" border="0"></a>
</center>
</font></span>
</td>
</tr>
</table>
</form>
<script> 
    function actionDo(){ 
        document.form1.submit(); 
    } 
</script> 
<%
    }
%>
</div></div>
</BODY>
</HTML>
