<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.util.CharacterSet"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.mobile.inconvenient.MobileInconvenient" %>
<%
	String savePath = config.getServletContext().getRealPath("../ROOT/mobileImage");
	File fPath = new File(savePath);
	
	if (!fPath.exists()) {
		fPath.mkdirs(); //파일 디렉토리 생성
	}
	
	int sizeLimit = 50 * 1024 * 1024 ; // 50메가까지 제한 넘어서면 예외발생
	
	MultipartRequest m = new MultipartRequest(request,savePath,sizeLimit,"utf-8",new DefaultFileRenamePolicy());
	
	String festival_cd = m.getParameter("festival_cd")!=null?m.getParameter("festival_cd"):"";
	String ivt_div = m.getParameter("ivt_div")!=null?m.getParameter("ivt_div"):"";
	String ivt_content = m.getParameter("ivt_content")!=null?m.getParameter("ivt_content"):"";
	String attach_file =  m.getFilesystemName("attach_file")!=null?m.getFilesystemName("attach_file"):"";
	String org_attach_file = m.getOriginalFileName("attach_file")!=null?m.getOriginalFileName("attach_file"):"";
	int fileSize = 0;
	String fileNm = "";
	String fileExt = "";
	
	if ( attach_file.equals("") ) {
		fileSize = 0;
	} else {
		fileSize = (int)(new File(savePath + "/" + attach_file).length());
		int dot = attach_file.lastIndexOf('.');
		fileNm = (dot == -1) ? attach_file : attach_file.substring(0, dot);
		fileExt = (dot == -1) ? "" : attach_file.substring(dot+1);
	}
	
	String proc_state_cd = "A8010001";
	
	String visiter_id = m.getParameter("visiter_id")!=null?m.getParameter("visiter_id"):"";
	
    MobileInconvenient mi = new MobileInconvenient();
	boolean rtn = mi.insertInconvenient(visiter_id, festival_cd, ivt_div, "00", "불편신고", ivt_content, proc_state_cd
									, "/mobileImage/" + attach_file, fileNm, fileExt, fileSize);

//	response.sendRedirect("./upload_file_test.jsp");
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
</font></span>
<input type="hidden" id="savePath" name="savePath" value="<%=savePath%>" />
<input type="hidden" id="ivt_div" name="ivt_div" value="<%=ivt_div%>" />
<input type="hidden" id="attach_file" name="attach_file" value="<%=attach_file%>" />
<input type="hidden" id="org_attach_file" name="org_attach_file" value="<%=org_attach_file%>" />
<input type="hidden" id="fileSize" name="fileSize" value="<%=fileSize%>" />
<input type="hidden" id="fileNm" name="fileNm" value="<%=fileNm%>" />
<input type="hidden" id="fileExt" name="fileExt" value="<%=fileExt%>" />
<input type="hidden" id="img_src" name="img_src" value="/mobileImage/<%=attach_file%>" />
<input type="hidden" id="ivt_content" name="ivt_content" value="<%=ivt_content%>" />
</center>
</td>
</tr>
</table>
</div></div>
</BODY>
</HTML>
