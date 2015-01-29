<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="css/jquery.ui.all.css">
<title>QRCS</title>

<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 
<script src="js/jquery.ui.widget.js"></script> 
<script src="js/jquery.ui.datepicker.js"></script>
<script src="js/common.js"></script> 
<script src="js/lock.js" type="text/javascript"></script>
<link rel="stylesheet" href="css/demos.css">  


<script>
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
	
	function onSubmit(f)
	{
		
		if(f.publisher.value == '')
		{
			alert("발급 자를 입력 해주세요.");
			return ;
			
		}else if(f.startDate.value == '')
		{
			alert("시작 날짜를 입력해 주세요.");
			return ;
				
		}else if(f.endDate.value == '')
		{
			alert("종료 날짜를 입력 해 주세요.");
			return ;
		} else if(!chk_radio(f.used))
		{
			//alert("사용 유무를 선택 해 주세요.");
			return ; 
		} 
	
		f.submit(); 
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
            <li class="m1"><a class="on" href="javasrcipt:void(0)"><span>QR코드 개별관리</span></a>
                <ul class="on2">
                    <li><a href="./QRCodeListAction.action?param=reference">QR코드 조회</a></li>
                    <li><a href="javasrcipt:void(0)">QR코드 사용관리</a></li>
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
    <div id="content">
        <form id=fwrite name=fwrite method=post action=./QRCodeListAction.action>
        <input type=hidden name=param value=used></input>
        <input type=hidden name=flag value=submit></input>
        <div id="title">
            <h1><img src="img/t_m12.gif" alt="QR코드 사용관리" /></h1>
            <span>HOME > QR코드 개별관리 > QR코드 사용관리</span> </div>
        <div class="box1">
            <table class="table1">
                <colgroup>
                <col width="20%" />
                <col width="80%" />
                </colgroup>
                <tr>
                    <td>발급자</td>
                    <td><input class="input1" name=publisher id=publisher type="text"/></td>
                </tr>
                <tr>
                    <td>발급일시</td>
                    <td><input class="input1" name="startDate" type="text" id=from />
                        ~
                        <input class="input1" name="endDate" id=to type="text"/>
                    </td>
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
        <div class="button"><a href="javascript:onSubmit(document.fwrite);"><img src="img/btn_request.gif" alt="신청"/></a> <a href="javascript:onCencle(fwrite);"><img src="img/btn_cancel.gif" alt="취소"/></a></div>
        </form>
    </div>
    <!--//컨텐츠영역-->
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>
</body>
</html>
