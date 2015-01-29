<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 
<script src="./js/common.js" type="text/javascript"></script>

<!-- <script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAAJMiX5qC_bFBCBFnJF_7YMxSEvByt5H2Q8727iYoUV9FnFc1sgRSsVFr1jeFjLOzpDsUZ_2AkLRi6hQ"></script> -->

<title>QRCS</title>
<script>
function submit_form(v)
{
	if(v == "txtform")
	{
		if(document.getElementById('txt').value == '')
		{
				alert("텍스트 란에 아무것도 입력하지 않았습니다.");
				return 0;
		}
		document.txtform.flag.value = 'submit';
	}else if(v == "urlform")
	{
		document.urlform.flag.value = 'submit';
		
	}else if(v == "wifiform")
	{
		document.wifiform.flag.value = 'submit';
		
	}else if(v == "smsform")
	{
		document.smsform.flag.value = 'submit';
		
	}else if(v == "telform")
	{
		document.telform.flag.value = 'submit';
		
	}else if(v == "mailform")
	{
		document.mailform.flag.value = 'submit';
	}
	
	 
	
	submit_ajax(v, "./QRCodeListAction.action", "JSON", "QrCreate", $('#'+v));
	 
}
function contentsCh(f)
{
	if(f.value == "URL")
	{
		document.urlform.contentType.value ="URL";
		txtb1.style.display = 'none';	
		txtb2.style.display = 'block';
		txtb3.style.display = 'none';
		txtb4.style.display = 'none';
		txtb5.style.display = 'none';
		txtb6.style.display = 'none';
		txtb7.style.display = 'none';
		//$('#mapbase').hide();
		
	}else if(f.value == "Text")
	{
		document.txtform.contentType.value ="Text";
		txtb1.style.display = 'block';	
		txtb2.style.display = 'none';
		txtb3.style.display = 'none';
		txtb4.style.display = 'none';
		txtb5.style.display = 'none';
		txtb6.style.display = 'none';
		txtb7.style.display = 'none';
		//$('#mapbase').hide();
		
	}else if(f.value == "Wifi network")
	{
		document.wifiform.contentType.value ="Wifi network";
		txtb1.style.display = 'none';	
		txtb2.style.display = 'none';
		txtb3.style.display = 'block';
		txtb4.style.display = 'none';
		txtb5.style.display = 'none';
		txtb6.style.display = 'none';
		txtb7.style.display = 'none';
		//$('#mapbase').hide();
		
	}else if(f.value == "SMS")
	{
		document.smsform.contentType.value ="SMS";
		txtb1.style.display = 'none';	
		txtb2.style.display = 'none';
		txtb3.style.display = 'none';
		txtb4.style.display = 'block';
		txtb5.style.display = 'none';
		txtb6.style.display = 'none';
		txtb7.style.display = 'none';
		//$('#mapbase').hide();
		
	}else if(f.value == "Phone number")
	{
		document.telform.contentType.value ="Phone number";
		txtb1.style.display = 'none';	
		txtb2.style.display = 'none';
		txtb3.style.display = 'none';
		txtb4.style.display = 'none';
		txtb5.style.display = 'block';
		txtb6.style.display = 'none';
		txtb7.style.display = 'none';
		//$('#mapbase').hide();
		
	}else if(f.value == "Email address")
	{
		document.mailform.contentType.value ="Email address";
		txtb1.style.display = 'none';	
		txtb2.style.display = 'none';
		txtb3.style.display = 'none';
		txtb4.style.display = 'none';
		txtb5.style.display = 'none';
		txtb6.style.display = 'block';
		txtb7.style.display = 'none';
		//$('#mapbase').hide();
		
	}else if(f.value == "Geo location")
	{
		document.geoform.contentType.value ="Geo location";
		txtb1.style.display = 'none';	
		txtb2.style.display = 'none';
		txtb3.style.display = 'none';
		txtb4.style.display = 'none';
		txtb5.style.display = 'none';
		txtb6.style.display = 'none';
		txtb7.style.display = 'block';
		//$('#mapbase').hide();
		
	}
	
	
	
	
	
}


$(document).ready(function() {
	//$('#mapbase').hide();
	//createMap();
});


function init()
{

	 
//txtb1.style.display = 'none';
	
}

</script>
</head>
<body onload="init();">
<div id="wrap">
    <div id="header">
        <div class="logo"><a href="./MainAction.action"><img src="../img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>
        <div class="admin"><span>[<s:property value="#session.SID"/>]</span><a href="./LogoutAction.action"><img src="img/btn_logout.gif" alt="log-out" width="72" height="22" border="0"/></a></div>
    </div>
    <!--ë©ë´ìì­-->
    <div id="menu">
        <ul>
            <li class="m1"><a class="on" href="javasrcipt:void(0)"><span>QR코드 개별관리</span></a>
                <ul class="on2">
                    <li><a href="./QRCodeListAction.action?param=reference">QR코드 조회</a></li>
                    <li><a href="./QRCodeListAction.action?param=used">QR코드 사용관리</a></li>
                    <li><a href="javasrcipt:void(0)">QR코드 발급 관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m2"><a href="./QRBatchListAction.action?param=type"><span>QR코드 일괄관리</span></a>
                <ul>
                    <li><a href="./QRBatchListAction.action?param=type">Contents Type관리</a></li>
                    <li><a href="./QRBatchListAction.action?param=pub">QR코드 발급 관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m3"><a href=./QRSiteAction.action?param=admin><span>사이트 관리</span></a>
                <ul>
                    <!-- <li><a href="../site/notice.html">공지사항</a></li> -->
                    <li><a href="../site/admin.html">관리자 관리</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!--//ë©ë´ìì­-->
    <!--ì»¨íì¸ ìì­-->


    <div id="content">
        <div id="title">
            <h1><img src="../img/t_m13.gif" alt="QRì½ë ë°ê¸ê´ë¦¬" width="157" height="20" /></h1>
            <span>HOME > QR코드 개별관리 > QR코드 발급관리</span> </div>
        <center>
        		<div id="ui" >
			<table cellspacing="0" cellpadding="0" id="mainpanel">
			 
				<tbody>
					<tr>
						<td align="left" style="vertical-align: top; display:none" id=txtb1   >
						<form id=txtform name=txtform>
					    <input type=hidden id=param name=param value='pub'></input>
    					<input type=hidden id=flag name=flag value=''></input>
						  <table>						     
								<tbody >
									<tr>
										<td><table>
													<tr>
														<td>컨덴츠</td>
														<td>
														        <select id=contentType name=contentType class='select2' onchange="contentsCh(this);">
															        <option value="Calendar event">Calendar event</option>
																	<option value="Contact information">Contact	information</option>
																	<option value="Email address">Email address</option>
																	<option value="Geo location">Geo location</option>
																	<option value="Phone number">Phone number</option>
																	<option value="SMS" >SMS</option>
																	<option value="Text" selected>Text</option>
																	<option value="URL">URL</option>
																	<option value="Wifi network">Wifi network</option>
																</select>
														</td>
													</tr>
											
													<tr>
														<td height=10>&nbsp;</td>
														<td height=10>&nbsp;</td>
													</tr>
											
													<tr >
															<td>텍스트</td>
															<td><textarea id=txt name=txt rows="5"></textarea></td>
													</tr>
																										<tr>
														<td height=10>&nbsp;</td>
														<td height=10>&nbsp;</td>
													</tr>
												<tbody>
													<tr>
														<td>바코드 사이즈</td>
														<td>
														        <select id=barSize name=barSize class='select3'>
															        <option value="120">Small</option>
																	<option value="230">Medium</option>
																	<option value="350">Large</option>
																</select>
														</td>
													</tr>

													<tr>
														<td>문자 인코딩</td>
														<td><select id=encoding name=encoding class='select3'>
														        <option value="UTF-8">UTF-8</option>
																<option value="ISO-8859-1">ISO-8859-1</option>
																</select>
														</td>
													</tr>
												</tbody>
												
												<tbody>
													<tr>
														<td height=10>&nbsp;</td>
													</tr>
												</tbody>
												
												<tbody>
													<tr>
														<td ></td>
														<td >
														   <button type="button" style="width:100px;height:30px" onclick="submit_form('txtform');">생성</button></td>
													</tr>
												</tbody>
											</table></td>
									</tr>

								</tbody>								   
							</table> </form></td>
							<td align="left" style="vertical-align: top;" id=txtb2  >
							<form id=urlform name=urlform>
							<input type=hidden id=param name=param value='pub'></input>
    					    <input type=hidden id=flag name=flag value=''></input>
							  <table>						     
									<tbody >
										<tr>
											<td><table>
														<tr>
															<td>컨덴츠</td>
															<td>
															        <select id=contentType name=contentType class='select2' onchange="contentsCh(this);">
																 <!--        <option value="Calendar event">Calendar event</option>
																		<option value="Contact information">Contact	information</option>
																		<option value="Email address">Email address</option>
																		<option value="Geo location">Geo location</option>
																		<option value="Phone number">Phone number</option>
																		<option value="SMS" >SMS</option>
																		<option value="Text" >Text</option> -->
																		<option value="URL" selected>URL</option>
																		<!-- <option value="Wifi network">Wifi network</option> -->
																	</select>
															</td>
														</tr>
												
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
														<tr >
																<td>웹사이트</td>
																<td><input type=text id=url name=url style="width: 130px"> </input></td>
														</tr>
																										<tr>
														<td height=10>&nbsp;</td>
														<td height=10>&nbsp;</td>
													</tr>
													<tbody>
														<tr>
															<td>바코드 사이즈</td>
															<td>
															        <select id=barSize name=barSize class='select3'>
																        <option value="120">Small</option>
																		<option value="230">Medium</option>
																		<option value="350">Large</option>
																	</select>
															</td>
														</tr>
	
														<tr>
															<td>문자 인코딩</td>
															<td><select id=encoding name=encoding class='select3'>
															        <option value="UTF-8">UTF-8</option>
																	<option value="ISO-8859-1">ISO-8859-1</option>
																	</select>
															</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td height=10>&nbsp;</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td ></td>
															<td >
															   <button type="button" style="width:100px;height:30px" onclick="submit_form('urlform');">생성</button></td>
														</tr>
													</tbody>
												</table></td>
										</tr>
	
									</tbody>								   
								</table> </form></td>		
							<td align="left" style="vertical-align: top; display:none" id=txtb3   >
							<form id=wifiform name=wifiform>
							<input type=hidden id=param name=param value='pub'></input>
    					    <input type=hidden id=flag name=flag value=''></input>
							  <table>						     
									<tbody >
										<tr>
											<td><table>
														<tr>
															<td>컨덴츠</td>
															<td>
															        <select id=contentType name=contentType onchange="contentsCh(this);" class='select2'>
																        <option value="Calendar event">Calendar event</option>
																		<option value="Contact information">Contact	information</option>
																		<option value="Email address">Email address</option>
																		<option value="Geo location">Geo location</option>
																		<option value="Phone number">Phone number</option>
																		<option value="SMS" >SMS</option>
																		<option value="Text" >Text</option>
																		<option value="URL" >URL</option>
																		<option value="Wifi network" selected>Wifi network</option>
																	</select>
															</td>
														</tr>
												
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
														<tr >
																<td>SSID</td>
																<td><input type=text id=ssid name=ssid style="width: 130px"> </input></td>
														</tr>
														<tr >
																<td>Password</td>
																<td><input type=text id=wifipwd name=wifipwd style="width: 130px"> </input></td>
														</tr>
														<tr >
																<td>Network Type</td>
																<td>
																	<select  id=networkType name=networkType style="width: 135px"> 
																		<option value="WEP">WEP</option>
																		<option value="WPA/WPA2">WPA/WPA2</option>
																		<option value="No encryption">No encryption</option> 
																	</select>
																</td>
														</tr>
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
													
													<tbody>
														<tr>
															<td>바코드 사이즈</td>
															<td>
															        <select id=barSize name=barSize class='select3'>
																        <option value="120">Small</option>
																		<option value="230">Medium</option>
																		<option value="350">Large</option>
																	</select>
															</td>
														</tr>
	
														<tr>
															<td>문자 인코딩</td>
															<td><select id=encoding name=encoding class='select3'>
															        <option value="UTF-8">UTF-8</option>
																	<option value="ISO-8859-1">ISO-8859-1</option>
																	</select>
															</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td height=10>&nbsp;</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td ></td>
															<td >
															   <button type="button" style="width:100px;height:30px" onclick="submit_form('wifiform');">생성</button></td>
														</tr>
													</tbody>
												</table></td>
										</tr>
	
									</tbody>								   
								</table> </form></td>	
							<td align="left" style="vertical-align: top; display:none" id=txtb4   >
							<form id=smsform name=smsform>
							<input type=hidden id=param name=param value='pub'></input>
    					    <input type=hidden id=flag name=flag value=''></input>
							  <table>						     
									<tbody >
										<tr>
											<td><table>
														<tr>
															<td>컨덴츠</td>
															<td>
															        <select id=contentType name=contentType onchange="contentsCh(this);" class='select2'>
																        <option value="Calendar event">Calendar event</option>
																		<option value="Contact information">Contact	information</option>
																		<option value="Email address">Email address</option>
																		<option value="Geo location">Geo location</option>
																		<option value="Phone number">Phone number</option>
																		<option value="SMS" selected>SMS</option>
																		<option value="Text" >Text</option>
																		<option value="URL" >URL</option>
																		<option value="Wifi network" >Wifi network</option>
																	</select>
															</td>
														</tr>
												
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
														<tr >
																<td>전화번호</td>
																<td><input type=text id=phoneNum name=phoneNum style="width: 130px"> </input></td>
														</tr>
														<tr >
																<td>메세지</td>
																<td><textarea id=txt name=txt rows="5" style="width: 130px"></textarea></td>
														</tr>														
														
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
													
													<tbody>
														<tr>
															<td>바코드 사이즈</td>
															<td>
															        <select id=barSize name=barSize class='select3'>
																        <option value="120">Small</option>
																		<option value="230">Medium</option>
																		<option value="350">Large</option>
																	</select>
															</td>
														</tr>
	
														<tr>
															<td>문자 인코딩</td>
															<td><select id=encoding name=encoding class='select3'>
															        <option value="UTF-8">UTF-8</option>
																	<option value="ISO-8859-1">ISO-8859-1</option>
																	</select>
															</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td height=10>&nbsp;</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td ></td>
															<td >
															   <button type="button" style="width:100px;height:30px" onclick="submit_form('smsform');">생성</button></td>
														</tr>
													</tbody>
												</table></td>
										</tr>
	
									</tbody>								   
								</table> </form></td>	
    					   	<td align="left" style="vertical-align: top; display:none" id=txtb5   >
							<form id=telform name=telform>
							<input type=hidden id=param name=param value='pub'></input>
    					    <input type=hidden id=flag name=flag value=''></input>
							  <table>						     
									<tbody >
										<tr>
											<td><table>
														<tr>
															<td>컨덴츠</td>
															<td>
															        <select id=contentType name=contentType onchange="contentsCh(this);" class='select2'>
																        <option value="Calendar event">Calendar event</option>
																		<option value="Contact information">Contact	information</option>
																		<option value="Email address">Email address</option>
																		<option value="Geo location">Geo location</option>
																		<option value="Phone number" selected>Phone number</option>
																		<option value="SMS" >SMS</option>
																		<option value="Text" >Text</option>
																		<option value="URL" >URL</option>
																		<option value="Wifi network" >Wifi network</option>
																	</select>
															</td>
														</tr>
												
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
														<tr >
																<td>전화번호</td>
																<td><input type=text id=phoneNum name=phoneNum style="width: 130px"> </input></td>
														</tr>
														
														
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
													
													<tbody>
														<tr>
															<td>바코드 사이즈</td>
															<td>
															        <select id=barSize name=barSize class='select3'>
																        <option value="120">Small</option>
																		<option value="230">Medium</option>
																		<option value="350">Large</option>
																	</select>
															</td>
														</tr>
	
														<tr>
															<td>문자 인코딩</td>
															<td><select id=encoding name=encoding class='select3'>
															        <option value="UTF-8">UTF-8</option>
																	<option value="ISO-8859-1">ISO-8859-1</option>
																	</select>
															</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td height=10>&nbsp;</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td ></td>
															<td >
															   <button type="button" style="width:100px;height:30px" onclick="submit_form('telform');">생성</button></td>
														</tr>
													</tbody>
												</table></td>
										</tr>
	
									</tbody>								   
								</table> </form></td>
    					   	<td align="left" style="vertical-align: top; display:none" id=txtb6   >
							<form id=mailform name=mailform>
							<input type=hidden id=param name=param value='pub'></input>
    					    <input type=hidden id=flag name=flag value=''></input>
							  <table>						     
									<tbody >
										<tr>
											<td><table>
														<tr>
															<td>컨덴츠</td>
															<td>
															        <select id=contentType name=contentType onchange="contentsCh(this);" class='select2'>
																        <option value="Calendar event">Calendar event</option>
																		<option value="Contact information">Contact	information</option>
																		<option value="Email address" selected>Email address</option>
																		<option value="Geo location">Geo location</option>
																		<option value="Phone number" >Phone number</option>
																		<option value="SMS" >SMS</option>
																		<option value="Text" >Text</option>
																		<option value="URL" >URL</option>
																		<option value="Wifi network" >Wifi network</option>
																	</select>
															</td>
														</tr>
												
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
														<tr >
																<td>이메일</td>
																<td><input type=text id=email name=email style="width: 130px"> </input></td>
														</tr>
														
														
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
													
													<tbody>
														<tr>
															<td>바코드 사이즈</td>
															<td>
															        <select id=barSize name=barSize class='select3'>
																        <option value="120">Small</option>
																		<option value="230">Medium</option>
																		<option value="350">Large</option>
																	</select>
															</td>
														</tr>
	
														<tr>
															<td>문자 인코딩</td>
															<td><select id=encoding name=encoding class='select3'>
															        <option value="UTF-8">UTF-8</option>
																	<option value="ISO-8859-1">ISO-8859-1</option>
																	</select>
															</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td height=10>&nbsp;</td>
														</tr>
													</tbody>
																
			
				
													<tbody>
														<tr>
															<td ></td>
															<td >
																
															   <button type="button" style="width:100px;height:30px" onclick="submit_form('mailform');">생성</button></td>
														</tr>
													</tbody>
												</table></td>
										</tr>
	
									</tbody>								   
								</table> </form></td>	
						   	<td align="left" style="vertical-align: top; display:none" id=txtb7   >
							<form id=geoform name=geoform>
							<input type=hidden id=param name=param value='pub'></input>
    					    <input type=hidden id=flag name=flag value='submit'></input>
							  <table>						     
									<tbody >
										<tr>
											<td><table>
														<tr>
															<td>컨덴츠</td>
															<td>
															        <select id=contentType name=contentType onchange="contentsCh(this);" class='select2'>
																        <option value="Calendar event">Calendar event</option>
																		<option value="Contact information">Contact	information</option>
																		<option value="Email address" >Email address</option>
																		<option value="Geo location" selected>Geo location</option>
																		<option value="Phone number" >Phone number</option>
																		<option value="SMS" >SMS</option>
																		<option value="Text" >Text</option>
																		<option value="URL" >URL</option>
																		<option value="Wifi network" >Wifi network</option>
																	</select>
															</td>
														</tr>
												
														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
														<tr >
																<td>주소로 위도/경도 좌표 찾기</td>
																<td><input type=text id=mapq name=hardness onkeydown="checkKeyDown(event);" style="width: 130px"> </input>
																<input type=button value=찾기 onclick="searchMap();">
																</td>
														</tr>
														
														<tr >
																<td>위도</td>
																<td><input type=text id=latitude name=latitude style="width: 130px"> </input></td>
														</tr>
														
														<tr >
																<td>경도</td>
																<td><input type=text id=hardness name=hardness style="width: 130px"> </input></td>
														</tr>
														

														<tr>
															<td height=10>&nbsp;</td>
															<td height=10>&nbsp;</td>
														</tr>
												
													
													<tbody>
														<tr>
															<td>바코드 사이즈</td>
															<td>
															        <select id=barSize name=barSize class='select3'>
																        <option value="120">Small</option>
																		<option value="230">Medium</option>
																		<option value="350">Large</option>
																	</select>
															</td>
														</tr>
	
														<tr>
															<td>문자 인코딩</td>
															<td><select id=encoding name=encoding class='select3'>
															        <option value="UTF-8">UTF-8</option>
																	<option value="ISO-8859-1">ISO-8859-1</option>
																	</select>
															</td>
														</tr>
													</tbody>
													
													<tbody>
														<tr>
															<td height=10>&nbsp;</td>
														</tr>
													</tbody>
																
			
				
													<tbody>
														<tr>
															<td ></td>
															<td >
																
															   <button type="button" style="width:100px;height:30px" onclick="submit_form('geoform');">생성</button></td>
														</tr>
													</tbody>
												</table></td>
										</tr>
	
									</tbody>								   
								</table> </form></td>													
						<td align="left" style="vertical-align: top;">
						       <table	cellspacing="0" cellpadding="0">
								<tbody>
									<tr>
										<td align="left" style="vertical-align: top;">
										   <div id="imageresult">
												<div id="innerresult">
													<center><img src=""  id=qrImage name=qrImage  style="display:none" />
													<!-- <div id="mapbase" style="width:300px;height:300px" ></div> --></center>
												</div>
											</div></td>
									</tr>
								</tbody>
							</table></td>
					</tr>
				</tbody>

			</table>
		</div>
        </center>
        
    </div>

    <!--//ì»¨íì¸ ìì­-->
    <div id="footer"><img src="../img/footer.gif" width="800" height="20" /></div>


	</div>
	
	
<!-- <script>
	var center = new GLatLng(37.566535, 126.9779692);
	var map = null;
	var marker = null;

	function createMap() {
		if (map != null) {
			return true;
		}
		map = new GMap2(document.getElementById('mapbase'));
		map.setCenter(center,6);

		marker = new GMarker(center, {draggable:true});
		GEvent.addListener(marker, "dragend", function() { syncLatLng(); });

		map.addOverlay(marker);

		map.addControl(new GSmallZoomControl());
		map.addControl(new GMapTypeControl());
	};

	function syncLatLng() {
		var p = marker.getPoint();
		document.getElementById('latitude').value = p.lat();
		document.getElementById('hardness').value = p.lng();
	};

	function syncMap() {
		var lat = document.getElementById('latitude').value;
		var lng = document.getElementById('hardness').value;

		if ((lat != '') && (lng != '')) {
			var p = new GLatLng(lat, lng);
			map.setCenter(p);
			marker.setLatLng(p);
		}
	};

	function checkKeyDown(event) {
		if (typeof window.event != "undefined")
			event = window.event;

		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;

		if (keyCode == 13) {
			searchMap();
			return false;
		}
	};


	var geocoder = new GClientGeocoder();
	function searchMap() {
		var q = document.getElementById('mapq').value;
		if (q != '') {
			geocoder.getLatLng(q, function(cp) { 
				if (!cp) {
					alert("검색어에 해당하는 위치를 찾지 못했습니다.");
					return false;
				}

				map.setCenter(cp);
				marker.setLatLng(cp);

				syncLatLng();
			});
		}
	};
	</script> -->
</body>
</html>
