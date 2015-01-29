<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link rel="stylesheet" type="text/css" href="css/pageStyle.css" media="screen"/>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/pagination.css" />
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 
<script src="./js/common.js" type="text/javascript"></script>
<script src="./js/jquery.paginate.js" type="text/javascript"></script>
<title>QRCS</title>
<script>
var totalCount;
var listVo; 

function getPageGO()
{
	
	$("#page").paginate({
		count 		: Math.ceil(totalCount/10),
		start 		: document.fwrite.currentPage.value,
		display     : 5,
		images : true,
		border					: false,
		text_color  			: '#888',
		background_color    	: '#EEE',	
		text_hover_color  		: 'black',
		background_hover_color	: '#CFCFCF',
		mouse					: 'press',
		onChange     			: function(page){
			
			document.fwrite.currentPage.value = page; 
			document.fwrite.param.value ='reference';
			submit_ajax("fwrite", "./QRSiteAction.action", "JSON", "AdminList", null);
		}

	});
	
	var newcontent = '';
	
	
	newcontent +="<div id=\"title\">";
	newcontent +="<h1><img src=\"../img/t_m32.gif\" alt=\"QR코드 발급관리\" /></h1>";
	newcontent +="<span>HOME > 사이트관리 > 관리자 관리</span> </div>";
	newcontent +="<table align=left class=\"table2\">";
	newcontent +="<colgroup>"
	newcontent +="<col width=\"15%\" />";
	newcontent +="<col width=\"15%\" />";
	newcontent +="<col width=\"15%\" />";
	newcontent +="<col width=\"45%\" />";
	newcontent +="<col width=\"10%\" />";	
	newcontent +="</colgroup>";
	newcontent +="<tr>";
	newcontent +="    <th>번호 </th>";
	newcontent +="    <th>ID</th>";
	newcontent +="    <th>이름</th>";
	newcontent +="    <th>E-Mail</th>";
	newcontent +="    <th>승인여부</th>";	
	newcontent +="</tr>";
	
	
	//newcontent += "<table align=left class=\"table2\">";	
	//alert(listVo.length);
    for(var i=0;i<listVo.length; i++)
    {
    	 
    	
    	newcontent += "<tr class=\"table6\"  >";
   		newcontent += "<th  >" + listVo[i].seq + "</th>"; 
   		newcontent += "<th  >" + listVo[i].id + "</th>" ; 
   		newcontent += "<th  >" + listVo[i].name + "</th>" ;
   		newcontent += "<th  >" + listVo[i].email + "</th>"; 
   		//newcontent += "<th  >" + listVo[i].isAdmin + "</th>";
   		
   	 	if(listVo[i].isAdmin=='Y')
   			newcontent += "<th ><input type=checkbox id=chk1 name=chk1 checked onclick=\"allowChk('"+listVo[i].id+"', this)\"/></th></tr>";
   		else
   			newcontent += "<th ><input type=checkbox id=chk1 name=chk1 onclick=\"allowChk('"+listVo[i].id+"', this)\"/></th></tr>";	
   		
        
    }
    newcontent += "</table>";
    
    
    $('#Searchresult').html(newcontent);
    
    
}
$(document).ready(function() {
	submit_ajax("fwrite", "./QRSiteAction.action", "JSON", "AdminList", null);
	
});

function allowChk(v, f)
{
	document.fwrite.id.value = v; 
	document.fwrite.param.value ='isAdmin';
	
	if(f.checked)
	{
		document.fwrite.isAdmin.value ='Y';
			
	}else 
	{
		document.fwrite.isAdmin.value ='N';
		
	}
	submit_ajax("fwrite", "./QRSiteAction.action", "JSON", "IsAdmin", null);
}

</script>

</head>
<body>
<form id=fwrite name=fwrite method=post>
<input type=hidden name=flag value=getlist>
<input type=hidden name=param value=reference>
<input type=hidden name=currentPage value=1>
<input type=hidden name=id value=''>
<input type=hidden name=isAdmin value=''>

</form>

<div id="wrap">
    <div id="header">
        <div class="logo"><a href="./MainAction.action"><img src="../img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>
        <div class="admin"><span>[<s:property value="#session.SID"/>]</span><a href="./LogoutAction.action"><img src="img/btn_logout.gif" alt="log-out" width="72" height="22" border="0"/></a></div>
    </div>
    <!--ë©ë´ìì­-->
    <div id="menu">
        <ul>
            <li class="m1"><a href="./QRCodeListAction.action?param=reference"><span>QRì½ë ê°ë³ê´ë¦¬</span></a>
                <ul>
                    <li><a href="./QRCodeListAction.action?param=reference">QRì½ë ì¡°í</a></li>
                    <li><a href="./QRCodeListAction.action?param=used">QRì½ë ì¬ì©ê´ë¦¬</a></li>
                    <li><a href="./QRCodeListAction.action?param=pub">QRì½ë ë°ê¸ê´ë¦¬</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m2"><a href="./QRBatchListAction.action?param=type"><span>QRì½ë ì¼ê´ê´ë¦¬</span></a>
                <ul >
                    <li><a href="./QRBatchListAction.action?param=type">Contents Typeê´ë¦¬</a></li>
                    <li><a href="./QRBatchListAction.action?param=pub">QRì½ë ë°ê¸ê´ë¦¬</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m3"><a class="on" href="./QRSiteAction.action?param=admin"><span>ì¬ì´í¸ê´ë¦¬</span></a>
                <ul class="on2">
                   <!--  <li><a href="./QRSiteAction.action?param=notice">공지사항</a></li> -->
                    <li><a href="javascript:void(0)">관리자 관리</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!--//ë©ë´ìì­-->
    <!--ì»¨íì¸ ìì­-->
    <div id="content">
       <div id="Searchresult" >
        <div id="title">
            <h1><img src="../img/t_m32.gif" /></h1>
            <span>HOME > 사이트관리 > 관리자 관리</span> </div>
	        <table class="table2">
	            <colgroup>
	            <col width="15%" />
	            <col width="15%" />
	            <col width="15%" />
	            <col width="45%" />
	            <col width="10%" />
	            </colgroup>
	            <tr>
	                <th>번호</th>
	                <th>ID</th>
	                <th>이름</th>
	                <th>E-Mail</th>
	                <th>승인여부</th>
	            </tr>
	 			<tr class=table1>
							<td colspan='6' >
		
							</td>
				</tr>
		
		
				
	        </table>
        </div>
        <div id="align"> 
							
										<div class="content">               
							                <div id="page">                   
							                </div>	
							            </div>
							
							 
			</div>    
    </div>
    <!--//ì»¨íì¸ ìì­-->
    <div id="footer"><img src="../img/footer.gif" width="800" height="20" /></div>
</div>
</body>
</html>
