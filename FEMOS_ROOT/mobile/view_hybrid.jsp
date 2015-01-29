<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.visiter.MobileVisiter" %>
<%@ page import="com.mobile.visiter.Visiter" %>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.util.*" %>
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
<table width="320" height="600" border="0" background="main_bg.png">
<%
    String visiter_id = request.getParameter("visiterId");
    
    MobileVisiter mv = new MobileVisiter();
    mv.getVisiterList(visiter_id);
    Vector v_list = mv.getV_list();
    
    if ( v_list.size() > 0 ) {
        for ( int i = 0; i < v_list.size(); i++ ) {
            Visiter vs = (Visiter)v_list.elementAt(i);
%>
<tr>
<td width="320" height="450"><span style="FONT-SIZE: 12pt"><font color="black">
<b><%=vs.getVisiterNm()%>님.<br>축제에 참여하여 주셔서 감사합니다.</b>
<br>
</font></span>
<span style="FONT-SIZE: 10pt"><font color="black">
<br>
<center>
<%
            if ( vs.getQrcode().equals("NOT") ) { } else {
%>
<img src="http://hbsys98.vps.phps.kr/QRCS/QRImage/<%=vs.getQrcode()%>" border="0">
<%
            }
%>
</font></span> </center>
</td>
</tr>
<%
        }
    } else {
%>
<tr>
<td width="320"><span style="FONT-SIZE: 12pt"><font color="black">
<b>요청하신 사용자의 정보가 없습니다.</b>
</font></span> </center>
</td>
</tr>
<%
    }
%>
</table>
</div></div>
</BODY>
</HTML>
