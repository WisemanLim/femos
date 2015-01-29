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
        <div class="logo"><a href="./MainAction.action"><img src="img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>
        <div class="admin"><span>administrator</span><a href="#"><img src="img/btn_logout.gif" alt="log-out" width="72" height="22" border="0"/></a></div>
    </div>
    <!--메뉴영역-->
    <div id="menu">
        <ul>
            <li class="m1"><a href="./QRCodeListAction.action?param=reference"><span>QR코드 개별관리</span></a>
                <ul>
                    <li><a href="./QRCodeListAction.action?param=reference">QR코드 조회</a></li>
                    <li><a href="./QRCodeListAction.action?param=used">QR코드 사용관리</a></li>
                    <li><a href="./QRCodeListAction.action?param=pub">QR코드 발급관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m2"><a href="./QRBatchListAction.action?param=type"><span>QR코드 일괄관리</span></a>
                <ul >
                    <li><a href="./QRBatchListAction.action?param=type">Contents Type관리</a></li>
                    <li><a href="./QRBatchListAction.action?param=pub">QR코드 발급관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m3"><a class="on" href="javascript:void(0)"><span>사이트관리</span></a>
                <ul class="on2">
                    <li><a href="javascript:void(0)">공지사항</a></li>
                    <li><a href="./QRSiteAction.action?param=admin">관리자 관리</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!--//메뉴영역-->
    <!--컨텐츠영역-->
    <div id="content">
        <div id="title">
            <h1><img src="img/t_m31.gif" alt="QR코드 발급관리" /></h1>
            <span>HOME > 사이트관리 > 공지사항</span> </div>
        <table class="table2">
            <colgroup>
            <col width="8%" />
            <col width="74%" />
            <col width="10%" />
            <col width="8%" />
            </colgroup>
            <tr>
                <th>번호 </th>
                <th>내용</th>
                <th>작성자</th>
                <th>조회수</th>
            </tr>
            <tr>
                <td>001</td>
                <td><a href="#">QRCS공지사항입니다 QRCS공지사항입니다 </a></td>
                <td>관리자</td>
                <td>123</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <div class="nevi"> <a href="#"><img src="img/btn_nevi_ll.gif" alt="처음"/></a> <a href="#"><img src="img/btn_nevi_l.gif" alt="이전"/></a> <a href="#">1</a><a href="#">2</a><a href="#">3</a> <a href="#"><img src="img/btn_nevi_r.gif" alt="다음"/></a> <a href="#"><img src="img/btn_nevi_rr.gif" alt="끝"/></a> </div>
        <div class="button"><a href="#"><img src="img/btn_ok.gif" alt="확인"/></a></div>
    </div>
    <!--//컨텐츠영역-->
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>
</body>
</html>
