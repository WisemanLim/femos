<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<title>QRCS</title>
</head>
<body>
<div id="wrap">
    <div id="header">
        <div class="logo"><a href="./"><img src="img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>
        <div class="admin"><span>[<s:property value="#session.SID"/>]</span><a href="./LogoutAction.action"><img src="img/btn_logout.gif" alt="log-out" width="72" height="22" border="0"/></a></div>
    </div>
    <!--ë©ë´ìì­-->
    <div id="menu">
        <ul>
            <li class="m1"><a href="./QRCodeListAction.action?param=reference"><span>1QRì½ë ê°ë³ê´ë¦¬</span></a>
                <ul>
                    <li><a href="../admin_each/search.html">QRì½ë ì¡°í</a></li>
                    <li><a href="../admin_each/use.html">QRì½ë ì¬ì©ê´ë¦¬</a></li>
                    <li><a href="../admin_each/publish.html">QRì½ë ë°ê¸ê´ë¦¬</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m2"><a href="../QRBatchListAction.action?param=type"><span>QRì½ë ì¼ê´ê´ë¦¬</span></a>
                <ul>
                    <li><a href="./QRBatchListAction.action?param=type">Contents Typeê´ë¦¬</a></li>
                    <li><a href="./QRBatchListAction.action?param=pub">QRì½ë ë°ê¸ê´ë¦¬</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m3"><a  href="./QRSiteAction.action?param=admin"><span>ì¬ì´í¸ê´ë¦¬</span></a>
                <ul >
                    <!-- <li><a href="./QRSiteAction?param=notice">ê³µì§ì¬í­</a></li> -->
                    <li><a href="./QRSiteAction?param=admin">ê´ë¦¬ì ê´ë¦¬</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!--//ë©ë´ìì­-->
    <!--ì»¨íì¸ ìì­-->
<div id="content_main"></div>
    <!--//ì»¨íì¸ ìì­-->
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>
</body>
</html>
