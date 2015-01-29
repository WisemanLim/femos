<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Management Server</title>
<link href="css/style.css" type="text/css" rel="stylesheet" />
<script src="js/miv.js" type="text/javascript"></script>
<script src="./js/lock.js" type="text/javascript"></script>
</head>

<body bgcolor="#5c5c5c" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" onload="MM_preloadImages('img/top_menu_01server_over.jpg','img/top_menu_02system_over.jpg','img/top_menu_03service_over.jpg','img/top_menu_04site_over.jpg')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top" background="img/top_bg.jpg" style="background-repeat:repeat-x">
    <!--top menu s-->
    <table width="1024" border="0" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td height="124" align="center" valign="top"><img src="img/top_menu_line.jpg" width="2" height="124" alt=" " /></td>
        <td width="187" align="center" valign="top"><a href="./MainAction.action"><img src="img/top_menu_home_over.jpg" alt="MIV MS" width="95" height="124" /></a></td>
        <td align="center" valign="top"><img src="img/top_menu_line.jpg" width="2" height="124" alt=" " /></td>
        <!-- <td align="center" valign="top"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','img/top_menu_01server_over.jpg',1);MM_showHideLayers('sub01','','show','sub02','','hide','sub03','','hide','sub04','','hide')"><img src="img/top_menu_01server.jpg" alt="서버관리" name="Image32" width="95" height="85" border="0" id="Image32" /></a></td>
        <td align="center" valign="top"><img src="img/top_menu_bullet.gif" width="8" height="124" alt=" " /></td> -->
        <td align="center" valign="top"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','img/top_menu_02system_over.jpg',1);MM_showHideLayers('sub01','','hide','sub02','','show','sub03','','hide','sub04','','hide')"><img src="img/top_menu_02system.jpg" alt="시스템 관리" name="Image34" width="95" height="85" border="0" id="Image34" /></a></td>
        <td align="center" valign="top"><img src="img/top_menu_bullet.gif" width="8" height="124" alt=" " /></td>
        <td align="center" valign="top"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image38','','img/top_menu_03service_over.jpg',1);MM_showHideLayers('sub01','','hide','sub02','','hide','sub03','','show','sub04','','hide')"><img src="img/top_menu_03service.jpg" alt="시스템 정보 관리" name="Image38" width="95" height="85" border="0" id="Image38" /></a></td>
        <td align="center" valign="top"><img src="img/top_menu_bullet.gif" width="8" height="124" alt=" " /></td>
        <td align="center" valign="top"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image39','','img/top_menu_04site_over.jpg',1);MM_showHideLayers('sub01','','hide','sub02','','hide','sub03','','hide','sub04','','show')"><img src="img/top_menu_04site.jpg" alt="사이트 관리" name="Image39" width="95" height="85" border="0" id="Image39" /></a></td>
        <td align="center" valign="top"><img src="img/top_menu_line.jpg" width="2" height="124" alt=" " /></td>
        <td width="270" align="center" valign="bottom"><table align="right" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><img src="img/top_menu_icon.gif" width="11" height="11" /></td>
            <td>&nbsp;</td>
            <td class="wb">[<s:property value="#session.SID"/>]</td>
            <td>&nbsp;</td>
            <td>
            <table width="93" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td height="23" align="center" background="img/top_menu_btlogin.gif" class="wc" style="cursor:hand" onclick="location.href='./LogoutAction.action'" onmouseover='this.style.backgroundImage="url(img/top_menu_btlogin_over.gif)"' onmouseout='this.style.backgroundImage="url(img/top_menu_btlogin.gif)"'>Log-out</td>
                              </tr>
                              <tr>
                                <td><img src="img/blank.gif" width="1" height="2" /></td>
                              </tr>
                        </table>
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="41" colspan="6">&nbsp;</td>
          </tr>
        </table></td>
        <td align="center" valign="top"><img src="img/top_menu_line.jpg" width="2" height="124" alt=" " /></td>
      </tr>
    </table>
    <div id="sub01">
      <table width="1024" height="34" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td width="187">&nbsp;</td>
          <td align="center"><a href="#" class="submenu">submenu01</a></td>
          <td align="center"><a href="#" class="submenu">submenu02</a></td>
          <td align="center"><a href="#" class="submenu">submenu03</a></td>
          <td align="center"><a href="#" class="submenu">submenu04</a></td>
          <td align="center"><a href="#" class="submenu">submenu05</a></td>
          <td width="250">&nbsp;</td>
          </tr>
      </table>
    </div>
    <div id="sub02">
      <table width="1024" height="34" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td width="187">&nbsp;</td>
          <td align="center"><a href="./SysMsgAction.action" class="submenu">공통메세지관리</a></td>
          <td align="center"><a href="#" class="submenu">&nbsp;</a></td>
          <td align="center"><a href="#" class="submenu">&nbsp;</a></td>
          <td align="center"><a href="#" class="submenu">&nbsp;</a></td>
          <td align="center" width="35%"><a href="#" class="submenu">&nbsp;</a></td>
          <td width="250">&nbsp;</td>
        </tr>
      </table>
    </div>
    <div id="sub03">
      <table width="1024" height="34" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td width="30%">&nbsp;</td>
          <td width="5%" align="center"><a href="./DcsListAction.action" class="submenu">DCS</a></td>
          <td width="5%" align="center"><a href="./EssListAction.action" class="submenu">ESS</a></td>
          <td width="10%" align="center"><a href="./IFListAction.action" class="submenu">I/F 이용현황</a></td>
          <td width="10%" align="center"><a href="./SupplyAction.action" class="submenu">소모품관리</a></td>
          <td width="10%" align="center"><a href="./LicenseAction.action" class="submenu">라이센스관리</a></td>
          <td width="10%" align="center"><a href="./VersionAction.action" class="submenu">버전정보</a></td>
          <td width="25%">&nbsp;</td>
        </tr>
      </table>
    </div>
    <div id="sub04">
      <table width="1024" height="34" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td width="30%">&nbsp;</td>
          <td width="10%" align="center"><a href="#" class="submenu"></a></td>
          <td width="10%" align="center"><a href="#" class="submenu"></a></td>
          <td width="10%" align="center"><a href="#" class="submenu"></a></td>
          <!-- <td width="10%" align="center"><a href="./SiteNotiAction.action" class="submenu">공지사항관리</a></td> -->
          <td width="10%" align="center"><a href="./AdminAction.action" class="submenu">운영자 관리</a></td> 
          <td width="20%">&nbsp;</td>
        </tr>
      </table>
    </div>            
    <!--top menu e-->
    <!--title s-->
    <table width="1024" border="0" cellspacing="0" cellpadding="0" align="center" height="63" background="img/top_titl_bg.jpg">
      <tr>
        <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td colspan="2"><img src="img/blank.gif" width="1" height="5" /></td>
            </tr>
          <tr>
            <td width="65" height="45">&nbsp;</td>
            <td align="left" class="wb">메인 공지사항</td>
          </tr>
        </table>
        </td>
      </tr>
      <tr>
        <td><img src="img/blank.gif" width="1" height="4" /></td>
      </tr>
    </table>
    <!--title e-->
    <!--body s-->
    <table width="100%" height="550" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
      <tr>
        <td valign="top">
        <!--1024 s-->
        <table width="1024" height="550" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr>
            <td width="62">&nbsp;</td>
            <td valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top">
                  
                 <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="298" valign="top">
                    <!--공지사항 s-->
                    <table width="437" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><img src="img/blank.gif" width="1" height="12" /></td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="16"><img src="img/ic_bullet.gif" width="15" height="15" /></td>
                            <td class="bl">공지사항</td>
                          </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td><img src="img/blank.gif" width="1" height="5" /></td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #dfdfdf;">No</td>
                            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">제목</td>
                            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">작성자</td>
                            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">작성일</td>
                            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">조회수</td>
                          </tr>
                          <s:iterator value="notilist">
                          <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SiteNotiAction.action'" >${seq}</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SiteNotiAction.action'">${title}</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SiteNotiAction.action'">${author}</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SiteNotiAction.action'">${writeDate}</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SiteNotiAction.action'">${viewCount}</td>
                          </tr>
                          </s:iterator>
<!--                           <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">3</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">공지사항</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">ADMIN</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">2011-07-12</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                          </tr>
                          <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">2</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">공지사항</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">ADMIN</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">2011-07-12</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                          </tr>
                          <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">1</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">공지사항</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">ADMIN</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">2011-07-12</td>
                            <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                          </tr> -->
                        </table>
                          <table border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                              <td colspan="5">&nbsp;</td>
                            </tr>
<!--                             <tr>
                              <td><a href="#"><img src="img/table_arrow_left2.gif" width="23" height="23" border="0" /></a></td>
                              <td><a href="#"><img src="img/table_arrow_left1.gif" width="23" height="23" border="0" /></a></td>
                              <td><table width="190" border="0" cellspacing="0" cellpadding="0">
                                <tr align="center">
                                  <td>1</td>
                                  <td>2</td>
                                  <td>3</td>
                                  <td>4</td>
                                  <td>5</td>
                                  <td>6</td>
                                  <td>7</td>
                                  <td>8</td>
                                  <td>9</td>
                                  <td>10</td>
                                </tr>
                              </table></td>
                              <td><a href="#"><img src="img/table_arrow_right1.gif" width="23" height="23" border="0" /></a></td>
                              <td><a href="#"><img src="img/table_arrow_right2.gif" width="23" height="23" border="0" /></a></td>
                            </tr> -->
                          </table></td>
                      </tr>
   				</table>
                <!--공지사항 e-->
      </td>
  </tr> 
  <tr>
    <td>
<!--     운영자 정보 s
    <table width="437" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="img/blank.gif" width="1" height="12" /></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="16"><img src="img/ic_bullet.gif" width="15" height="15" /></td>
            <td class="bl">운영자 정보</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><img src="img/blank.gif" width="1" height="5" /></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #dfdfdf;">No</td>
            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">제목</td>
            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">작성자</td>
            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">작성일</td>
            <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">조회수</td>
          </tr>
          <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
            <td height="26" style="border-bottom:1px solid #d7d7d7">2</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">공지사항</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">ADMIN</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">2011-07-12</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
          </tr>
          <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
            <td height="26" style="border-bottom:1px solid #d7d7d7">1</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">공지사항</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">ADMIN</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">2011-07-12</td>
            <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
          </tr>
        </table>
        </td>
        <tr>
          <td>     
          <table border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td colspan="5">&nbsp;</td>
            </tr>
            <tr>
              <td><a href="#"><img src="img/table_arrow_left2.gif" width="23" height="23" border="0" /></a></td>
              <td><a href="#"><img src="img/table_arrow_left1.gif" width="23" height="23" border="0" /></a></td>
              <td>
	             <table width="190" border="0" cellspacing="0" cellpadding="0">
	                <tr align="center">
	                  <td>1</td>
	                  <td>2</td>
	                  <td>3</td>
	                  <td>4</td>
	                  <td>5</td>
	                  <td>6</td>
	                  <td>7</td>
	                  <td>8</td>
	                  <td>9</td>
	                  <td>10</td>
	                </tr>
	              </table></td>
	              <td><a href="#"><img src="img/table_arrow_right1.gif" width="23" height="23" border="0" /></a></td>
	              <td><a href="#"><img src="img/table_arrow_right2.gif" width="23" height="23" border="0" /></a></td>
	            </tr>
	          </table> 
             </td>
             </tr>
        </table>  -->
    <!--운영자 정보 e-->
    </td>
  </tr>
</table>

</td>
                <td width="27">&nbsp;</td>
                <td valign="top">
                  <!--공지사항 s-->
                  <table width="437" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="img/blank.gif" width="1" height="12" /></td>
                      </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="16"><img src="img/ic_bullet.gif" width="15" height="15" /></td>
                            <td class="bl">DCS 수집정보</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    <tr>
                      <td><img src="img/blank.gif" width="1" height="5" /></td>
                      </tr>
                    <tr>
                      <td valign="top">
                        <table width="100%" height="510" cellspacing="0" cellpadding="0" style="border:1px solid #d5d5d5;">
                          <tr>
                            <td valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#f8f8f8" >
                                <tr>
                                  <td style="border-bottom:1px solid #d7d7d7" width="17" align="center" height="26"><img src="img/ic_dot.gif" width="3" height="3" /></td>
                                  <td style="border-bottom:1px solid #d7d7d7" width="290">전일</td>
                                  <td style="border-bottom:1px solid #d7d7d7" width="8"><img src="img/ic_arrow.gif" width="3" height="5" /></td>
                                  <td style="border-bottom:1px solid #d7d7d7" width="70"><span style="font-size:11px">총 수집건수</span></td>                            
                                  <td style="border-bottom:1px solid #d7d7d7;color:#00a2ff;" width="30" align="right"><b><s:property value="dcsYesterDayListCnt"/></b></td>
                                  <td style="border-bottom:1px solid #d7d7d7" width="2" align="right">&nbsp;</td>
                                  <td style="border-bottom:1px solid #d7d7d7" width="15"><span style="font-size:11px">건</span></td>
                                  </tr>
                                <tr>
                                  <td colspan="7" bgcolor="#FFFFFF"><img src="img/blank.gif" width="1" height="4" /></td>
                                  </tr>  
                                </table>
                              <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                                <tr>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #dfdfdf;">No</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">수집시간</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">ID</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">UID</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">수집건수</td>
                                  </tr>
								<s:iterator value="dcsYesterDayList">                                  
                                <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${num}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${lastDate}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${id}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${uid}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${cnt}</td>
                                  </tr>
								</s:iterator>                                  
                                
                                 
<!--                                 <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">2</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">2011-06-29 07:00:00</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">btb</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">R450</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                                  </tr>
                                <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">1</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">2011-06-29 07:00:00</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">ADMIN</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">R450</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                                  </tr> -->
                                </table>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td height="26">&nbsp;</td>
            <%--                       <td width="8"><img src="img/ic_arrow.gif" width="3" height="5" /></td>
                                  <td width="70"><span style="font-size:11px">총 실패건수</span></td>
                                  <td style="color:#ff5a00;" width="30" align="right"><b>10</b></td>
                                  <td width="2" align="right">&nbsp;</td>
                                  <td width="15"><span style="font-size:11px">건</span></td> --%>
                                  </tr>
                                </table>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td>&nbsp;</td>
                                  </tr>
  </table>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#f8f8f8" >
                                <tr>
                                  <td style="border-bottom:1px solid #d7d7d7;border-top:1px solid #d5d5d5;" width="17" align="center" height="26"><img src="img/ic_dot.gif" width="3" height="3" /></td>
                                  <td style="border-bottom:1px solid #d7d7d7;border-top:1px solid #d5d5d5;" width="290">현재</td>
                                  <td style="border-bottom:1px solid #d7d7d7;border-top:1px solid #d5d5d5;" width="8"><img src="img/ic_arrow.gif" width="3" height="5" /></td>
                                  <td style="border-bottom:1px solid #d7d7d7;border-top:1px solid #d5d5d5;" width="70"><span style="font-size:11px">총 수집건수</span></td>
                                  <td style="border-bottom:1px solid #d7d7d7;border-top:1px solid #d5d5d5;color:#00a2ff;" width="30" align="right"><b><s:property value="dcsToDayListCnt"/></b></td>
                                  <td style="border-bottom:1px solid #d7d7d7;border-top:1px solid #d5d5d5;" width="2" align="right">&nbsp;</td>
                                  <td style="border-bottom:1px solid #d7d7d7;border-top:1px solid #d5d5d5;" width="15"><span style="font-size:11px">건</span></td>
                                </tr>
                                <tr>
                                  <td colspan="7" bgcolor="#FFFFFF"><img src="img/blank.gif" width="1" height="4" /></td>
                                </tr>
                              </table>
                              <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                                <tr>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #dfdfdf;">No</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">수집시간</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">ID</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">UID</td>
                                  <td background="img/table_title_bg.jpg" height="26" align="center" style="border-right:1px solid #dfdfdf;border-left:1px solid #ffffff;">수집건수</td>
                                </tr>
								<s:iterator value="dcsToDayList">                                  
                                <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${num}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${lastDate}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${id}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${uid}</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./DcsListAction.action'">${cnt}</td>
                                  </tr>
								</s:iterator>                                   
<!--                                 <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">3</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">2011-06-29 07:00:00</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">btb</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">R450</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                                </tr>
                                <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">2</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">2011-06-29 07:00:00</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">btb</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">R450</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                                </tr>
                                <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">1</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">2011-06-29 07:00:00</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">ADMIN</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">R450</td>
                                  <td height="26" style="border-bottom:1px solid #d7d7d7">10</td>
                                </tr> -->
                              </table>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td height="26">&nbsp;</td>
<%--                                   <td width="8"><img src="img/ic_arrow.gif" width="3" height="5" /></td>
                                  <td width="70"><span style="font-size:11px">총 실패건수</span></td>
                                  <td style="color:#ff5a00;" width="30" align="right"><b>10</b></td>
                                  <td width="2" align="right">&nbsp;</td>
                                  <td width="15"><span style="font-size:11px">건</span></td> --%>
                                </tr>
                              </table></td>
                          </tr>  
                          </table></td>
                      </tr>
                    </table>
                  <!--공지사항 e-->
                  </td>
              </tr>
              </table>
            </td>
            <td width="62">&nbsp;</td>
          </tr>
        </table>
        <!--1024 e-->
        </td>
      </tr>
    </table>
    <!--body e-->
    <!--bottom s-->    
    <table width="100%" height="106" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top:0; margin-left:0">
      <tr>
        <td background="img/bottom_bg.gif" align="center"><img src="img/bottom_copyright.gif" width="308" height="106" /></td>
      </tr>
    </table>
    <!--bottom e-->
</table>
</body>
</html>
