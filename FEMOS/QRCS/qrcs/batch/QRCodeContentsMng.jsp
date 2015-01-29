<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<title>QRCS</title>
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 
<script src="js/jquery.ui.widget.js"></script> 
<script src="js/jquery.ui.datepicker.js"></script>
<script src="js/common.js"></script> 
<script>
function onSubmit(f)
{
	
	if(f.required.value == '')
	{
		alert("필수 항목을 입력 해주세요.");
		return ;
		
	}else if(!chk_radio(f.used))
	{
		//alert("사용 유무를 선택 해 주세요.");
		return ; 
	} 

	f.submit(); 
}

function deleteList(v)
{
	location.href="./QRBatchListAction.action?param=type&flag=delete&seq="+v;
}
</script>

</head>
<body>
<div id="wrap">
    <div id="header">
        <div class="logo"><a href="./MainAction.action"><img src="img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>
        <div class="admin"><span>[<s:property value="#session.SID"/>]</span><a href="./LogoutAction.action"><img src="img/btn_logout.gif" alt="log-out" width="72" height="22" border="0"/></a></div>
    </div>
    <!--메뉴영역-->
    <div id="menu">
        <ul>
            <li class="m1"><a  href="./QRCodeListAction.action?param=reference"><span>QR코드 개별관리</span></a>
                <ul>
                    <li><a href="./QRCodeListAction.action?param=reference">QR코드 조회</a></li>
                    <li><a href="./QRCodeListAction.action?param=used">QR코드 사용관리</a></li>
                    <li><a href="./QRCodeListAction.action?param=pub">QR코드 발급관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m2"><a class="on" href="javascript:void(0)"><span>QR코드 일괄관리</span></a>
                <ul  class="on2">
                    <li><a href="javascript:void(0)">Contents Type관리</a></li>
                    <li><a href="./QRBatchListAction.action?param=pub">QR코드 발급관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m3"><a href="./QRSiteAction.action?param=admin"><span>사이트관리</span></a>
                <ul>
                    <!-- <li><a href="site/notice.html">공지사항</a></li> -->
                    <li><a href="site/admin.html">관리자 관리</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!--//메뉴영역-->
    <!--컨텐츠영역-->
    <div id="content">
   		<form id=fwrite name=fwrite method=post action=./QRBatchListAction.action>
   		<input type=hidden name=param value=type></input>
        <input type=hidden name=flag value=submit></input>
        <div id="title">
            <h1><img src="img/t_m21.gif" alt="contents type관리" /></h1>
            <span>HOME > QR코드 일괄관리 > Contents Type관리</span> </div>
        <div class="box1">
            <table class="table1" >
                <colgroup>
                <col width="20%" />
                <col width="30%" />
                <col width="50%" />
                </colgroup>
                <tr>
                    <td>Contents<br /></td>
                    <td>
                        <select class="select1" id=contents_type name=contents_type>
                            <option value="008" selected>URL</option>
                        </select>
                    </td>
                    <td rowspan='3' class="table8" style="padding-left:10px;	">
                    <center>&lt;등록된 항목 리스트&gt;</center>
                    	<table align=center class="table7" >
	                    	<colgroup>
				                <col width="20%" />
				                <col width="30%" />
				                <col width="30%" />
				                <col width="10%" />
			                </colgroup>
                    	<tr><td>순번</td><td>필수항목</td><td>사용유무</td><td>&nbsp;</td></tr>
		                <s:iterator value="qrBatchList" status="rowStatus">		                	
				            <tr align=left>
				            	<td class="comment1"> <s:property value="#rowStatus.index+1" /></td>
				                <td class="comment1">${defulltValue}${required}</td>				               
				                <td class="comment1"><s:if test='%{used.equals("Y")}'>
				                		사용함</s:if>
				                	<s:else>
				                		미사용
				                	</s:else>	
				                </td>
				                <td><input type=button value="삭제" onclick="deleteList('${seq}');"></input></td>
				             </tr>
				             
			             </s:iterator> 
			             </table>			             
                    </td>
                </tr>
                <tr>
                    <td><br /></td>
                    <td><span class="comment1">&lt;Contents 제공 항목&gt;<br />
                    aaa,bbb,ccc</span></td>
                </tr>
                <tr>
                    <td>필수항목<br /></td>
                    <td><input class="input1" type="text" id=required name=required /></td>
                </tr>
                <tr>
					<td>사용유무</td>
                    <td><input type="radio" name=used id=used value='Y' checked/>
                        사용 &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name=used id=used value='N' />
                        미사용</td>
                </tr>
            </table>
        </div>        
        <div class="button"><a href="javascript:onSubmit(document.fwrite);"><img src="img/btn_ok.gif" alt="확인"/></a> <a href="javascript:onCencle(fwrite);"><img src="img/btn_cancel.gif" alt="취소"/></a></div>
        </form>
    </div>
    <!--//컨텐츠영역-->
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>
</body>
</html>
