 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<link href="css/style.css" type="text/css" rel="stylesheet"/>


<script src="js/common.js" type="text/javascript"></script>
<script src="js/jquery-1.6.2.js"></script> 
<script src="js/jquery.ui.core.js"></script> 

<title>QRCS</title>

<script type="text/javascript"> 
var temp = new Array(1, 1, 1, 1);

$(document).ready(function() {
	//var pswd = $('#password').val();

		$('#pswd_info').hide();
		$('#pswd_info1').hide();
		 
	    $('input[id=password]').keyup(function() {
		var pswd = $(this).val();
		//validate the length
		if ( pswd.length < 8 ) {			
			$('#length').removeClass('valid').addClass('invalid');
		} else {		
			temp[0] = 0;
			$('#length').removeClass('invalid').addClass('valid');
		}
		
		//validate letter
		if ( pswd.match(/[A-z]/) ) {
			temp[1] = 0;
			$('#letter').removeClass('invalid').addClass('valid');
		} else {
			$('#letter').removeClass('valid').addClass('invalid');
		}

		//validate capital letter
		if ( pswd.match(/[A-Z]/) ) {
			temp[2] = 0;
			$('#capital').removeClass('invalid').addClass('valid');
		} else {
			$('#capital').removeClass('valid').addClass('invalid');
		}

		//validate number
		if ( pswd.match(/\d/) ) {
			temp[3] = 0;
			$('#number').removeClass('invalid').addClass('valid');
		} else {
			$('#number').removeClass('valid').addClass('invalid');
		}
		
	}).focus(function() {
			$('#pswd_info').show();
	}).blur(function() {
		    $('#pswd_info').hide();
	});	    
	    

});

function DupCheck(val)
{

	if(val == "id")
	    if (!document.fwrite.id.value)
	    {
	        alert("ID 를 입력하세요.");
	        document.fwrite.id.focus();
	        return ;
	    }else
	    {
	        document.fwrite.parameter.value =  'idCheck';
	        
	        document.fwrite.id.value = document.fwrite.id.value;
	    	submit_ajax("fwrite", "./RequestIdAction.action", "JSON", "idCheck", $('#fwrite'));
	    	return ;
	    }

	if(val == "name")
	    if (!document.fwrite.name.value)
	    {
	        alert("이름을 입력 하세요.");
	        document.fwrite.name.focus();
	        return ;
	    }else
	    {
	    	document.fwrite.parameter.value =  'nameCheck';	
	    	
	    	submit_ajax("fwrite", "./RequestIdAction.action", "JSON", "nameCheck", $('#fwrite'));    	
	    }
	 
}

function english_str_check() {
	
	var str = document.getElementById('id').value; 
	var regexp = /^[A-Za-z@._]{1,200}$/i;
	
	if( !regexp.test(str) )
	{    
		alert("영문외 문자는 사용할 수 없습니다"); 
		document.getElementById('id').focus(); 
	return false; 
	}
	return true; 
}	

function Pcheck()
{
	for(var i=0; i < 4; i++)
	{
		if(temp[i] != 0)
		{
				return 1;
		}
	}
	return 0; 
}

function Submit(f){
	
	if(isValidEmail(f.email) != 'true')
	{
			return false;
	}else{	
	}if(f.id.value.length == 0)
	{
		alert("ID를 입력하세요");
		return false; 
	}else if(f.password.value.length == 0)
	{
		alert("비밀번호를 입력하세요.");
		return false; 
	}else if(f.rePassword.value.length ==0 )
	{
		alert("비밀번호 확인을 입력하세요.");
		return false; 
	}else if(f.name.value.length == 0)
	{
		alert("이름을 입력하세요.");
		return false;
		
	}else if(Pcheck() == 1)
	{
		alert("패스워드 입력시 4가지 조건에 만족하지 못했습니다. \n 조건에 맞게 다시 입력 해주세요. ")
		return false; 	
	}
	
	if(document.fwrite.idchk.value != 0)
	{
		alert("ID 중복 체크 확인을 해주세요.");
		return false; 
	}else if(document.fwrite.namechk.value != 0)
	{
		alert("이름 중복 체크 확인을 해주세요.");
		return false; 
	}
	
	document.fwrite.parameter.value = "create";
	document.fwrite.flag.value = "submit";
	f.submit(); 
}
</script>

</head>
<body>
<div id="wrap">
    <div id="header"><a href="./"><img src="img/logo.gif" alt="main" width="174" height="48" border="0" /></a></div>

  
<form id=fwrite name=fwrite method=post  action=./RequestIdAction.action>
<input type=hidden name=parameter  id=parameter value=create></input> 
<input type=hidden name=flag id=flag  value=submit></input> 
<input type=hidden name=idchk id=idchk value='1'></input>
<input type=hidden name=namechk id=namechk value='1'></input>
		
    <div id="content_popup">

        <div id="title">
            <h1><img src="img/t_admin.gif" alt="ê´ë¦¬ììì²­" /></h1>
            <span></span> 
        </div>
        
        <div class="box2">

            <table class="table1">
                <colgroup>
                <col width="20%" />
                <col width="80%" />
                </colgroup>
                <tr>
                    <td>ID</td>
                    <td><input class="input1" type="text" id='id' name='id' ></input>
                    <a href="javascript:DupCheck('id')"><img src="img/btn_overlap.gif" alt="" width="65" height="22" /></a></td>
                </tr>
                <tr>
                    <td>PW</td>
                    <td><input class="input1" type="password" id='password' name='password'/>
                    		    <div id="pswd_info">
									<h4><strong>※ 비밀번호는 다음과 같은 4가지 요구사항에 만족해야 합니다:</strong></h4>
									<ul>
										<li id="letter" class="invalid">최소한 <strong>한개의 문자</strong></li>
										<li id="capital" class="invalid">최소한 <strong>한개의 대문자 </strong></li>
										<li id="number" class="invalid">최소한 <strong>한개의 숫자</strong></li>
										<li id="length" class="invalid">최소한 <strong>8 자리 이상</strong></li>
									</ul>
								</div>
                    </td>
                </tr>
                <tr> 
                    <td>PW 확인</td>
                    <td><input class="input1" type="password" id='rePassword' name='rePassword' />
                    </td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td><input class="input1" type="text" id='name' name='name' /> <a href="javascript:DupCheck('name')"><img src="img/btn_overlap.gif" alt="" width="65" height="22" /></a></td>
                </tr>
                <tr>
                    <td>E-Mail</td>
                    <td><input class="input1" id='email' name='email' type="text"  /></td>
                </tr>
            </table>
          
        </div>
        
	<div class="button"><a href="javascript:Submit(document.fwrite);"><img src="img/btn_ok.gif"  alt="Submit Form"   /></a>&nbsp;&nbsp;<a href="./"><img src="img/btn_cancel.gif" alt=""/></a></div>
  
    </div>
  </form> 
    <div id="footer"><img src="img/footer.gif" width="800" height="20" /></div>
</div>

</body>
</html>
