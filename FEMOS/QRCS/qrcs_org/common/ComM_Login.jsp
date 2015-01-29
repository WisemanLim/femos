<%@page language="java" contentType="text/html; charset=euc-kr"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags" %>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>Management Server</title>
<link href="./css/style.css" type="text/css" rel="stylesheet" />
<script src="./js/miv.js" type="text/javascript"></script>
<script src="./js/lock.js" type="text/javascript"></script>
<script src="./js/common.js" type="text/javascript"></script>
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 
<script>
<!--

function login_form()
{

    if (!document.login.id.value)
    {
        alert("Input ID");
        document.login.id.focus();
        return 0;
    }
    
    if (!document.login.password.value)
    {
        alert("Input Password");
        document.login.password.focus();
        return 0;
    }
    
   
    // 로그인 시, 쿠키의 값을 삭제
    var cuki = new Array("sKind", "minDate","maxDate","huid","code", "supplyName",
    		"startDate","endDate","requestIF");
	for(var i=0; i<cuki.length; i++){
		var cucki_v = getCookie(cuki[i]);
		if(cucki_v != ""){
		   	delete_cookie(cuki[i]);
		}
	}

	submit_ajax("login", "./LoginAction.action", "JSON", "LOGIN", document.login);
	//document.login.submit(); 
}

function specialCheck(f)
{
	
	var limit_char = /[@%()~!\#$^&*\=+|:;?"<,.>']/;
	  if(limit_char.test(f.value)) {
	   alert('특수문자는 삭제 됩니다.');
	   f.value = f.value.split(limit_char).join("");
	   
	   }


	 return;
	
}	


-->
</script>
</head>

<body leftmargin="0" rightmargin="0" bottommargin="0" background="../images/login_bg.jpg" onload="document.login.id.focus();">
<div id="content">
 <form name='login'  id='login' action="LoginAction.action" method="post" >
<table height="100%" width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr valign="middle">
    <td align="center" valign="middle">
        <table height="100%" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td background="../images/login_line.gif"><img src="../images/blank.gif" width="1" height="2"></td>
          </tr>
          <tr>
            <td height="124" style="border-bottom:1px solid #474d5b" valign="middle">
            <table border="0" cellspacing="0" cellpadding="0" align="center">
              <tr>
                <td><img src="../images/login_logo.jpg" width="105" height="54"></td>
                <td width="46">&nbsp;</td>
                <td>
                 <table border="0" cellspacing="0" cellpadding="0">                
                  <tr>                  
                    <td>                    
                    <table border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td><img src="../images/top_menu_icon.gif" width="11" height="11"></td>
                        <td width="8">&nbsp;</td>
                        <td class="wb">ID</td>
                        <td width="9">&nbsp;</td>
                        <td><input name="id" type="text" style="ime-mode:disabled" class="inp200" id="textfield" TABINDEX=1 onkeyup="specialCheck(this);"></td>
                      </tr>
                      <tr>
                        <td colspan="5"><img src="../images/blank.gif" width="1" height="3"></td>
                        </tr>
                      <tr>
                        <td><img src="../images/top_menu_icon.gif" width="11" height="11"></td>
                        <td width="8">&nbsp;</td>
                        <td><span class="wb">Password</span></td>
                        <td width="9">&nbsp;</td>
                        <td><input name="password" type="password" style="ime-mode:disabled" class="inp200" id="textfield2" TABINDEX=2 onkeyup="specialCheck(this);"></td>
                      </tr>
                    </table>
                    </td>
                    <td width="12">&nbsp;</td>
                    <td><table width="93" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <!-- <td height="48" align="center" background="../images/login_bt.jpg" class="wbc" style="cursor:hand" onClick="login_form();" onmouseover='this.style.backgroundImage="url(../images/login_bt_over.jpg)"' onmouseout='this.style.backgroundImage="url(../images/login_bt.jpg)"'><input type=image >Login</td>-->
                        <td height="48" align="center" ><img src="../images/login_bt.jpg" class="wbc" style="cursor:hand" onClick="login_form();" onMouseOut='this.src="../images/login_bt.jpg"' onmouseover='this.src="../images/login_bt_over.jpg"' TABINDEX=3></td>
                      </tr>                      
                    </table></td>
                   
                  </tr>
                  
                </table>
               
                </td>
              </tr>
            </table>
            </td>
          </tr>
          <tr>
            <td height="31" background="../images/login_bgline.jpg" align="center">
            <table width="1024" border="0" cellspacing="0" cellpadding="0" background="../images/login_bg2.jpg" height="31">
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table>
            </td>
          </tr>
          <tr>
            <td align="center"><img src="../images/login_copyright.jpg" width="294" height="24"></td>
          </tr>
        </table>
    </td>
  </tr>
</table>
 </form>
</div>

</body>
</html>