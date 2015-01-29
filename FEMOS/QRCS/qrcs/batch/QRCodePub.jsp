<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link rel="stylesheet" type="text/css" href="css/pageStyle.css" media="screen"/>
<link href="css/style.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="css/jquery.ui.all.css">
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 
<script src="js/jquery.ui.widget.js"></script> 
<script src="js/jquery.ui.datepicker.js"></script>
<script src="js/common.js"></script> 
<script src="js/jquery.paginate.js" type="text/javascript"></script>

<title>QRCS</title>
<script >
var totalCount;
var listVo; 
function onSubmit(f)
{
	
	if(f.contentCount.value == '')
	{
		alert("발급 개수를 입력 해주세요.");
		return ;		
	 
	}/* else if(!checkNumValid(f.contentCount))
	{
		return ;
	} */else		
	{
		
		if($(':input[name=chk]:radio:checked').val())
		{
			
		}else
		{
			alert("등록된 항목 리스트 중 한개를 선택해 주세요.");
			return ;
		}
		 	
	}

	f.submit(); 
}

function onReserch(f)
{
	if(f.startDate.value == '')
	{
		alert("시작 날짜를 입력해 주세요.");
		return ;
			
	}else if(f.endDate.value == '')
	{
		alert("종료 날짜를 입력 해 주세요.");
		return ;
	}
	
	document.fwrite1.startDate.value = f.startDate.value;
	document.fwrite1.endDate.value = f.endDate.value;
	submit_ajax("fwrite1", "./QRBatchListAction.action", "JSON", "QrList", null);
	jQuery('#box2').show();
	jQuery('#box1').hide();
	//f.submit(); 
}

function selectChk(v, contentsType)
{
	//alert(v);
	document.fwrite.seq.value = v;
	document.fwrite1.seq.value = v;
	//alert(document.fwrite.seq.value);
	//document.fwrite.contents_type.value = contentsType; 
}



$(function() {
	
	var dates = $( "#from, #to" ).datepicker({
		defaultDate: "+1d",
		changeMonth: true,
		numberOfMonths: 1,
		onSelect: function( selectedDate ) {
			var option = this.id == "from" ? "minDate" : "maxDate",
				instance = $( this ).data( "datepicker" ),
				date = $.datepicker.parseDate(
					instance.settings.dateFormat ||
					$.datepicker._defaults.dateFormat,
					selectedDate, instance.settings );
			dates.not( this ).datepicker( "option", option, date );
		}
	});
	$(  "#from, #to"  ).datepicker( "option", "dateFormat", "yymmdd" );
});

function hide()
{
	jQuery('#box1').show();
	jQuery('#box2').hide();
}

function getPageGO()
{

	var newcontent = '';
	
	newcontent +="<div>";
	newcontent +="<h3>QR코드 조회</h3>";
	newcontent +="</div>";
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
/*     newcontent += "<div class=\"content\">";
    newcontent += "<div id=\"page\"></div>";
    newcontent += "</div>"; */
    
    $('#Searchresult1').html(newcontent);
	
	
	$("#page").paginate({
		count 		: Math.ceil(totalCount/10),
		start 		: document.fwrite1.currentPage.value,
		display     : 5,
		images : true,
		border					: false,
		text_color  			: '#888',
		background_color    	: '#EEE',	
		text_hover_color  		: 'black',
		background_hover_color	: '#CFCFCF',
		mouse					: 'press',
		onChange     			: function(page){
			
			document.fwrite1.currentPage.value = page; 
			submit_ajax("fwrite1", "./QRBatchListAction.action", "JSON", "QrList", null);
		}

	});
	

    
    
}


$(document).ready(function() {
	//submit_ajax("fwrite1", "./QRBatchListAction.action", "JSON", "QrList", null);
	jQuery('#box2').hide();
});



</script>
</head>
<body>
<form id=fwrite1 name=fwrite1 method=post>
<input type=hidden name=seq value='' />
<input type=hidden name=flag value=getlist>
<input type=hidden name=param value=reference>
<input type=hidden name=currentPage value=1>
<input type=hidden name=startDate value=''>
<input type=hidden name=endDate value=''>
</form>

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
            <li class="m2"><a class="on" href="./QRBatchListAction.action?param=type"><span>QR코드 일괄관리</span></a>
                <ul  class="on2">
                    <li><a href="./QRBatchListAction.action?param=type">Contents Type관리</a></li>
                    <li><a href="javascript:void(0)">QR코드 발급관리</a></li>
                </ul>
            </li>
            <li class="gap"></li>
            <li class="m3"><a href="./QRSiteAction.action?param=admin"><span>사이트관리</span></a>
                <ul>
                    <!-- <li><a href="site/notice.html">공지사항</a></li> -->
                   <!--  <li><a href="">공지사항</a></li> -->
                    <li><a href="site/admin.html">관리자 관리</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <!--//메뉴영역-->
    <!--컨텐츠영역-->
    <form id=fwrite name=fwrite method=post action=./QRBatchListAction.action>
   		<input type=hidden name=param value=pub></input>
   		<!-- <input type=hidden name=contents_type value=''></input> -->
        <input type=hidden name=flag value=submit></input>
        <input type=hidden name=seq id=seq value=1></input>
    <div id="content">
        <div id="title">
            <h1><img src="img/t_m22.gif" alt="contents type관리" /></h1>
            <span>HOME > QR코드 일괄관리 > QR코드 발급관리</span> </div>
        <div class="box1" id=box1>
            <table class="table1">
                <colgroup>
                <col width="20%" />
                <col width="30%" />
                <col width="50%" />
                </colgroup>
                <tr>
                    <td>Contents<br /></td>
                    <td>
                        <select class="select1" id=contents_type name=contents_type>
                            <option value="URL" selected>URL</option>
                        </select>
                    </td>
                   <td rowspan='3' class="table8" style="padding-left:10px;	">
                    <center>&lt;등록된 항목 리스트&gt;</center>
                    	<table align=center class="table7" >
	                    	<colgroup>
				                <col width="10%" />
				                <col width="10%" />
				                <col width="60%" />
				                <col width="20%" />
			                </colgroup>
                    	<tr><td>선택</td><td>순번</td><td>필수항목</td><td>사용유무</td></tr>
		                <s:iterator value="qrBatchList" status="rowStatus">		                	
				            <tr align=left id=chkradio>
				             	<td><input type=radio id=chk name=chk onclick="selectChk(${seq})"></input></td>
				            	<td class="comment1"> <s:property value="#rowStatus.index+1" /></td>
				                <td class="comment1">${defulltValue}${required}</td>				               
				                <td class="comment1"><s:if test='%{used.equals("Y")}'>
				                		사용함</s:if>
				                	<s:else>
				                		미사용
				                	</s:else>	
				                </td>
				               
				             </tr>
				             
			             </s:iterator> 
			             </table>			             
                    </td>                    
                </tr>
                <tr>
                    <td>발급개수<br /></td>
                    <td><input class="input1" type="text" id=contentCount name=contentCount /></td>
                </tr>
                <tr>
                    <td>발급일시<br /></td>
                    <td><input class="input2" name="startDate" type="text" id=from /> ~ 
                        <input class="input2" name="endDate" id=to type="text"/>
                    </td>
                </tr>
            </table>
             <div class="button"><a href="javascript:onReserch(document.fwrite);"><img src="img/btn_search.gif" alt="조회"/></a> <a href="javascript:onSubmit(document.fwrite);"><img src="img/btn_ok.gif" alt="확인"/></a> <a href="javascript:onCencle(fwrite);"><img src="img/btn_cancel.gif" alt="취소"/></a></div>
        </div>

                <div class="box1" id=box2 style="border:0px solid red;">
                    <div id="Searchresult1" style="border:0px solid red;height:355px;">
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
								<th>번호</th>
								<th>타입</th>
								<th>발급자</th>
								<th>발급일시</th>
								<th>발급 이미지 URL</th>
								<th>사용</th>
							</tr>


							<tr class=table1>
								<td colspan='6'></td>
							</tr>


						</table>

					</div>
					<div class="content">
						<div id="page"></div>
					</div>

					<div class="button">
						<a href="javascript:hide();"><img src="img/btn_cancel.gif" alt="취소" /></a>
					</div>
				</div>
				<!-- content -->

			</div>
    </form>
    <!--//컨텐츠영역-->
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>
</body>
</html>
