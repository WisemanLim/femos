<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>




<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 
<script src="./js/common.js" type="text/javascript"></script>

<title>QRCS</title>
<script>

$(document).ready(function() {

	<s:if test='%{callMethod.equals("each")}'>
	 	if(temp = "<s:property value="result"/>")
		{	
			alert("정상적으로 처리가 되었습니다.");
			location.href="./QRCodeListAction.action?param=used";
		}else{
			alert("비 정상적으로 처리가 되었습니다. \n 다시 확인 하여 주세요.");
			location.href="./QRCodeListAction.action?param=used";
		}
	</s:if>
	<s:elseif test='%{callMethod.equals("USER")}'>

			alert("등록 되었습니다.");
			location.href="./LoginAction.action";
	
	</s:elseif>	
	<s:elseif test='%{callMethod.equals("admin")}'>
			if("true" == "<s:property value="result"/>")
			{	
				alert("승인 처리가 되었습니다.");
				location.href="./QRSiteAction.action?param=admin";
				
			}else {
				alert("비 정상적으로 처리가 되었습니다. \n 다시 확인 하여 주세요.");
				location.href="./QRSiteAction.action?param=admin";
			}

	</s:elseif>		
	<s:else>
		if("true" == "<s:property value="result"/>")
		{	
			alert("정상적으로 처리가 되었습니다.");
			location.href="./QRBatchListAction.action?param=type";
			
		}else if('5' == "<s:property value="result"/>"){
			
			alert("5개 이상 생성 할 수 없습니다.");
			location.href="./QRBatchListAction.action?param=type";
			
		}else if('success' == "<s:property value="result"/>"){
			
			alert("배치가 완료 되었습니다.");
			location.href="./QRBatchListAction.action?param=pub";
			
		}else 
		{
			alert("비 정상적으로 처리가 되었습니다. \n 다시 확인 하여 주세요.");
			location.href="./QRBatchListAction.action?param=type";
		}
	</s:else>
		
 
});


</script>
</head>
<body>

	 
</body>
</html>
