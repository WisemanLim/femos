<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link rel="stylesheet" type="text/css" href="css/pageStyle.css" media="screen"/>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/pagination.css" />
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
	if(totalCount == null || totalCount == 0) totalCount = 1;
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
			submit_ajax("fwrite", "./QRCodeListAction.action", "JSON", "QrList", null);
		}

	});
	
	var newcontent = '';
	
	
	newcontent +="<div id=\"title\">";
	newcontent +="<h1><img src=\"img/t_m11.gif\" alt=\"QR코드 발급관리\" /></h1>";
	newcontent +="<span>HOME > QR코드 개별관리 > QR코드 조회</span> </div>";
	newcontent +="<table align=left class=\"table2\">";
	newcontent +="<colgroup>"
	newcontent +="<col width=\"7%\" />";
	newcontent +="<col width=\"7%\" />";
	newcontent +="<col width=\"10%\" />";
	newcontent +="<col width=\"20%\" />";
	newcontent +="<col width=\"50%\" />";
	newcontent +="<col width=\"5%\" />";
	newcontent +="</colgroup>";
	newcontent +="<tr>";
	newcontent +="    <th>번호 </th>";
	newcontent +="    <th>타입</th>";
	newcontent +="    <th>발급자</th>";
	newcontent +="    <th>발급일시</th>";
	newcontent +="    <th>발급 이미지 URL</th>";
	newcontent +="    <th>사용</th>";
	newcontent +="</tr>";
	
	
	//newcontent += "<table align=left class=\"table2\">";	
    for(var i=0;i<listVo.length; i++)
    {
    		   		
    	newcontent += "<tr class=\"table6\" onclick=\"location.href='QRCodeListAction.action?param=file&url=" + listVo[i].imgURL +"'\" style=\"cursor:pointer;\" >";
   		newcontent += "<th style=\"cursor:pointer;\" >" + listVo[i].seq + "</th>"; 
   		newcontent += "<th style=\"cursor:pointer;\" >" + listVo[i].contents_type + "</th>" ; 
   		newcontent += "<th style=\"cursor:pointer;\" >" + listVo[i].publisher + "</th>" ;
   		newcontent += "<th style=\"cursor:pointer;\" >" + listVo[i].publisherDate + "</th>"; 
   		newcontent += "<th style=\"cursor:pointer;\" >" + listVo[i].imgURL + "</th>";
   		
   		if(listVo[i].isUsed=='Y')
   			newcontent += "<th style=\"cursor:pointer;\">사용</th></tr>";
   		else
   			newcontent += "<th style=\"cursor:pointer;\">미사용</th></tr>";	
   		
        
    }
    newcontent += "</table>";
    
    
    $('#Searchresult').html(newcontent);
    
    
}
$(document).ready(function() {
	submit_ajax("fwrite", "./QRCodeListAction.action", "JSON", "QrList", null);
	
});



</script>
</head>
<body>
<form id=fwrite name=fwrite method=post>
<input type=hidden name=flag value=getlist>
<input type=hidden name=param value=reference>
<input type=hidden name=currentPage value=1>
</form>
<div id="wrap">
    <div id="header">
        <div class="logo"><a href="./MainAction.action"><img src="img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>
		<div class="admin"><span>[<s:property value="#session.SID"/>]</span><a href="./LogoutAction.action"><img src="img/btn_logout.gif" alt="log-out" width="72" height="22" border="0"/></a></div>        
    </div>
    <!--메뉴영역-->
    <div id="menu">
        <ul>
            <li class="m1"><a class="on" href="javasrcipt:void(0)"><span>QR코드 개별관리</span></a>
                <ul class="on2">
                    <li><a href="javascript:void(0)">QR코드 조회</a></li>
                    <li><a href="./QRCodeListAction.action?param=used">QR코드 사용관리</a></li>
                    <li><a href="./QRCodeListAction.action?param=pub">QR코드 발급관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m2"><a href="./QRBatchListAction.action?param=type"><span>QR코드 일괄관리</span></a>
                <ul>
                    <li><a href="./QRBatchListAction.action?param=type">Contents Type관리</a></li>
                    <li><a href="./QRBatchListAction.action?param=pub">QR코드 발급관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m3"><a href=./QRSiteAction.action?param=admin><span>사이트관리</span></a>
                <ul>
                    <!-- <li><a href="site/notice.html">공지사항</a></li> -->
                    <li><a href="site/admin.html">관리자 관리</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!--//메뉴영역-->
    <!--컨텐츠영역-->
    <div id=content >
	    <div id="Searchresult" >
	        <div id="title">
	            <h1><img src="img/t_m11.gif" alt="QR코드 발급관리" /></h1>
	            <span>HOME > QR코드 개별관리 > QR코드 조회</span> </div>
	        <table align=left class="table2">
	            <colgroup>
	            <col width="7%" />
	            <col width="7%" />
	            <col width="10%" />
	            <col width="20%" />
	            <col width="50%" />
	            <col width="5%" />
	            </colgroup>
	            <tr>
	                <th>번호 </th>
	                <th>타입</th>
	                <th>발급자</th>
	                <th>발급일시</th>
	                <th>발급 이미지 URL</th>
	                <th>사용</th>
	            </tr>
	
	 <%--                        <s:iterator value="sysMsglist">
	                          <tr align="center" style="cursor:hand" bgcolor="#ffffff" onmouseover='this.style.backgroundColor="#eaeaea"' onmouseout='this.style.backgroundColor="#ffffff"'>
	                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SysMsgAction.action?parameter=reference&read=${seq}'" >${seq}</td>
	                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SysMsgAction.action?parameter=reference&read=${seq}'">${messageCode}</td>
	                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SysMsgAction.action?parameter=reference&read=${seq}'">${description}</td>
	                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SysMsgAction.action?parameter=reference&read=${seq}'">
		                            <s:if test='%{serverType.equals("001")}'>공통</s:if>
		                            <s:elseif test='%{serverType.equals("002")}'>DCS</s:elseif>
		                            <s:elseif test='%{serverType.equals("003")}'>ESS</s:elseif>
		                            <s:elseif test='%{serverType.equals("004")}'>MS</s:elseif>
		                            <s:else>공통</s:else>                
	                            </td>
	                            <td height="26" style="border-bottom:1px solid #d7d7d7" onclick="location.href='./SysMsgAction.action?parameter=reference&read=${seq}'">${messageValue}</td>
	                            <td height="26" style="border-bottom:1px solid #d7d7d7">
	                            <table border="0" cellspacing="0" cellpadding="0">
	                              <tr onclick="location.href='./SysMsgAction.action?parameter=reference&read=${seq}'">
	                                 <s:if test='%{usedSelect.equals("001")}'>
	                                 	<td><img src="img/ic_working.gif" width="14" height="13" /></td>                                
	                                	<td class="f8" >	 사용함  </td></s:if>
	                                  <s:else>
	                                  	<td><img src="img/ic_noworking.gif" width="14" height="13" /></td>                                
	                                	<td class="f8" >	 미사용   </td>                                
	                                  </s:else>                                   
	                              </tr>
	                            </table>
	                            </td>
	                          </tr>
	                         </s:iterator> --%>
	<%--             <s:iterator value="qRCodeListVo">
	            <tr  align=left onclick="location.href='QRCodeListAction.action?param=file&url=${imgURL}'" style="cursor:pointer;" >
	                <td style="cursor:pointer;" >${seq}</td>
	                <td style="cursor:pointer;" >${contents_type}</td>
	                <td style="cursor:pointer;" >${publisher}</td>
	                <td style="cursor:pointer;" >${publisherDate}</td>
	                <td align=left style="cursor:pointer;" >${imgURL}</td>
	                <td><s:if test='%{isUsed.equals("Y")}'>
	                		<input type="checkbox" checked/></s:if>
	                	<s:else>
	                		<input type="checkbox" />
	                	</s:else>	
	                </td>
	             </tr>
	             </s:iterator> --%>
						
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
    </div> <!-- content -->

    <!--//컨텐츠영역-->
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>

		

		<script type="text/javascript">
/* 		$(function() {

			$("#demo2").paginate({
				count 		: 20,
				start 		: 5,
				display     : 10,
				images : true,
				border					: true,
				text_color  			: '#888',
				background_color    	: '#EEE',	
				text_hover_color  		: 'black',
				background_hover_color	: '#CFCFCF'
			});


		});  */
		</script>

</body>
</html>
