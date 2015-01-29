 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script src="./js/miv.js" type="text/javascript"></script>
<script src="./js/lock.js" type="text/javascript"></script>
<script src="./js/common.js" type="text/javascript"></script>
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 

<title>QRCS</title>
<script>
function resetSubmit()
{
	if(confirm("정말로 관리자 암호를 초기화 하시 겠습니까?"))
	{
		document.passwd.action = "./LoginAction.action?parameter=reset&flag=1";
		document.passwd.submit(); 
		alert("초기화 되었습니다."); 
		document.location.href = "./";
	}
}

function findIdPw()
{
	submit_ajax("fwrite", "./LoginAction.action", "JSON", "IDPW", document.fwrite);
}

function ResetPw()
{
	if(confirm("정말로 관리자 암호를 초기화 하시 겠습니까?"))
	{
		
		submit_ajax("fwrite2", "./LoginAction.action", "JSON", "ResetPW", document.fwrite2);
		//alert("초기화 되었습니다."); 
	}

}
</script>
</head>
<body>
<div id="wrap">
    <div id="header"><a href="./"><img src="img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>
    <div id="content_popup">

        <div id="title">
            <h1><img src="img/t_idpw_search.gif" alt="ìì´ëí¨ì¤ìë ì°¾ê¸°" /></h1>
            <span></span> 
        </div>
        
        <div class="box2">
        	<form name=fwrite id=fwrite>
        	<input type=hidden name=flag value='2'></input>
	            <table class="table1">
	                <colgroup>
	                <col width="20%" />
	                <col width="80%" />
	                </colgroup>
	                <tr>
	                    <td>Name</td>
	                    <td><input class="input1" type="text" name=name id=name /></td>
	                </tr>
	                <tr>
	                    <td>E-Mail</td>
	                    <td><input class="input1" type="text" name=email id=email /></td>
	                </tr>
	            </table>
            </form>
        </div>
        
	<div class="button"><a href="javascript:void(0);" onclick="findIdPw();"><img src="img/btn_idsearch.gif" /></a> <a href="./"><img src="img/btn_cancel.gif" alt="ì·¨ì"/></a></div>   
        <div>&nbsp;</div>
        <div class="box2">
        	<form name=fwrite2 id=fwrite2>
        	<input type=hidden name=flag value='3'></input>
            <table class="table1">
                <colgroup>
                <col width="20%" />
                <col width="80%" />
                </colgroup>
                <tr>
                    <td>ID</td>
                    <td><input class="input1" type="text" name=id id=id/></td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td><input class="input1" type="text" name=name id=name /></td>
                </tr>
                <tr>
                    <td>E-Mail</td>
                    <td><input class="input1" type="text" name=email id=email /></td>
                </tr>
                </from>
            </table>
        </div>
     <form name=passwd id=passwd method=post>
        
	<div class="button"><a href="javascript:void(0);" onclick="ResetPw();"><img src="img/btn_pwreset.gif"/></a> <a href="./"><img src="img/btn_cancel.gif" alt="ì·¨ì"/></a></div>   
	
         
    </div>
    </form>
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>
</body>
</html>
