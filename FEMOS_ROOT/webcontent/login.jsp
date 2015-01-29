<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/femos_login.css">
<script src="Scripts/swfobject_modified.js" type="text/javascript"></script>
<title>축제행사관리시스템(FEMOS)</title>
<script type="text/javascript">
function sendLogin()
{
	var uid = document.getElementById('uid');
	var pw = document.getElementById('pw');
	
	if(uid.value.length == 0)
	{
		alert('아이디를 입력해주세요.');
		
	}
	else if(pw.value.length == 0)
	{
		alert('비밀번호를 입력해주세요.');
		
	}
	else
	{
		document.getElementById('loginForm').submit();
	}
}
</script>
</head>

<body>

<form id="loginForm" method="post" action="login_ok.jsp">
<input type="hidden" id="festival_cd" name="festival_cd" value="FES10001" />
<div id="login_wrap">

<div class="login">
        <p><label><img src="images/login/t_id.gif" width="41" height="13" /></label><input type="text" class="text" id="uid" name="uid"/>
        </p>
       <p>
    <label><img src="images/login/t_pass.gif" width="41" height="13" /></label><input type="password" class="text" id="pw" name="pw" />
        </p>
    </div>
    
     <div class="loginbtn"><a href="#" onclick="sendLogin()"><img src="images/login/btn_login.gif" width="103" height="96" /></a></div> 
    
<!--  <div class="loginlink"><a href="#">회원가입</a> ㅣ <a href="#">아이디/비번찾기</a></div>  -->
</div>
<!--//id="login_wrap" -->
</form>
</body>
</html>






