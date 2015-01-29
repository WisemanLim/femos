<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.missing.MissingInfo" %>
<%@ page import="com.mobile.missing.MobileChild" %>
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
<script type="text/javascript" src="http://hbsys98.vps.phps.kr/mobile/view_missing_info.js"></script>
<script type="text/javascript" src="http://hbsys98.vps.phps.kr/mobile/jquery.js"></script>
<script src="animatedcollapse.js" type="text/javascript">
/***********************************************
* Animated Collapsible DIV- ⓒ Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for this script and 100s more
***********************************************/
</script>

<div id="waiting" style="clear:both;padding-top:0px;position:absolute;width:100%;height:100%;visibility:hidden;background-color:#000;color:#517277;ext-align:center;z-index:1" align="center" valigh="middle"> 
<table height="480px"><tr><td height="480px" valign="middle"><h1>조치내역을 조회중입니다.<br/>잠시만 기다려 주세요.</h1></td></tr></table>
</div> 
<link rel = "apple-touch-icon" href = "http://img.inven.co.kr/image/mobile/common/logo_iphone.png" />
<style>
body {
	height: 100%;
	width: 100%;
	background:#5CD1E5;
	font-size:10pt;
}

#layout-container {
	position: absolute;
	width:99%;
	height: 98%;
}

#layout-content {
	text-align:center;
	position:absolute;
	top:20%;
	width:100%;
}
#missing_info {
	width:80%;
	text-align:center;
	margin:0 auto;
}
#missing_info_title {
	background: #4374D9;
	padding: 4px;
	width: 100%;
	color: #fff;
	background-image: url(images/bt_bg01.gif);
}
#missing_info_result {
	background:#fff;
	padding:4px;
	width:100%;
}
#missing_result_history {
	width:80%;
	text-align:center;
	margin:0 auto;
}
#missing_result_history_title {
	background: #6799FF;
	padding: 4px;
	width: 100%;
	color: #fff;
	background-image: url(images/bt_bg02.gif);
}
#missing_result_item {
	background:#fff;
	width:100%;
	padding:4px;
	text-align:left;
	font-weight:normal;
	border-top:1px solid #ddd;
}
#missing_result_item div {
	padding:5px;
}
#missing_result_input_area {
	width:80%;
	text-align:center;
	margin:0 auto;
}
#missing_result_input_title {
	background: #6799FF;
	padding: 4px;
	width: 100%;
	color: #fff;
	background-image: url(images/bt_bg02.gif);
}
#missing_result_input {
	background:#fff;
	width:100%;
	padding:4px;
	text-align:left;
	font-weight:normal;
	border-top:1px solid #ddd;
}

</style>
</head>
<body onLoad="javascript:showResultHistory();">
<div id="layout-container">
	<div id="layout-content">
<%
	//http://hbsys98.vps.phps.kr/oper_missing/missing_history_save.jsp?missing_key=3&result=AAA
    String missing_key = request.getParameter("missingKey") == null ? "0" : request.getParameter("missingKey");
    
	MobileChild mv = new MobileChild();
    mv.getChildList(Integer.parseInt(missing_key));
    Vector v_list = mv.getV_list();
    
    if ( v_list.size() > 0 ) {
        for ( int i = 0; i < v_list.size(); i++ ) {
            MissingInfo vs = (MissingInfo)v_list.elementAt(i);
%>
		<div id="missing_info">
			<div id="missing_info_title"><strong><%=vs.getName()%>님</strong>의 결과입니다.</div>
			<div id="missing_info_result">
				<table width="100%" cellpadding="3" cellspacing="1">
					<colgroup>
						<col width="100px"/>
						<col width="*"/>
					</colgroup>
					<tr>
						<th style="text-align:left;">보호자 성명:</th>
						<td style="text-align:left;"><%=vs.getProtector()%></td>
					</tr>
					<tr>
						<th style="text-align:left;">보호자 연락처:</th>
						<td style="text-align:left;"><a href="tel:<%=vs.getProtectorTel()%>"><%=vs.getProtectorTel()%></a></td>
					</tr>
			  	</table>
		  	</div>
		</div>
<%
        }
    } else {
%>
		<div id="missing_info">
			<div id="missing_info_title"><strong>요청 정보 없음</strong></div>
			<div id="missing_info_result">
			조회 요청하신 <strong>미아/노인</strong>분의 정보가 없습니다.<br>
			미아/노인 보호소에 안내 부탁 드립니다.
			</div>
		</div>
<%
    }
%>
		<div id="missing_result_history" style="margin-top:10px;">
			<div id="missing_result_history_title"><strong>조치이력</div>
			<div id="missing_result_item">
				<div>
					1.피보호자의 QR태그 스캔 후 <br/>
					보호자에게 연락
				</div>
				<div>
					2.연락결과 보호자와 거리가 멀어 가까운 <br/>보호소로 인솔
				</div>
				<div id="missing_history"></div>
			</div>
			<input type="hidden" name="missing_key" id="missing_key" value="<%=missing_key%>"></input>
		</div>
		<div id="missing_result_input_area" style="margin-top:10px;">
			<div id="missing_result_input_title"><strong>조치내용 입력</div>
			<div id="missing_result_input">
				<textarea id="result" name="result" style="width:100%;height:80px;"></textarea>
			</div>
		</div>
	  <div style="text-align: center; margin: 0 auto; width: 80%; margin-top: 10px;">
		<!--button>전송</button-->
		<a href="javascript:result();"><img src="images/sub_bt_01.png" alt="" width="179" height="39" border="0" /></a>
        </div>
	</div>
</div>
</body>
</html>