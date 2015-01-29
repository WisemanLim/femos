function GetCookie(name) {	// doesn't work!!!!
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen) { // while open
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg)
			return getCookieVal(j);
		i = document.cookie.indexOf(" ", i) + 1;
		if (i == 0)
			break;
	} // while close
	return null;
}

function SetCookie(name, value) {
	var argv = SetCookie.arguments;
	var argc = SetCookie.arguments.length;
	var expires = (2 < argc) ? argv[2] : null;
	var path = (3 < argc) ? argv[3] : null;
	var domain = (4 < argc) ? argv[4] : null;
	var secure = (5 < argc) ? argv[5] : false;
	document.cookie = name + "=" + escape(value)
			+ ((expires == null) ? "" : ("; expires=" + expires.toGMTString()))
			+ ((path == null) ? "" : ("; path=" + path))
			+ ((domain == null) ? "" : ("; domain=" + domain))
			+ ((secure == true) ? "; secure" : "");
}

function getCookie( name ) {
	  var nameOfCookie = name + "=";
	  var x = 0;
	  while ( x <= document.cookie.length )	{
	    var y = (x+nameOfCookie.length);
	    if ( document.cookie.substring( x, y ) == nameOfCookie ) {
	       if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
	          endOfCookie = document.cookie.length;
	       return unescape( document.cookie.substring( y, endOfCookie ) );
	    }
	    x = document.cookie.indexOf( " ", x ) + 1;
	    if ( x == 0 )
	      break;
	  }
	  return "";
}

function onCencle(form) {
    $(':input', form).each(function() {
        var type = this.type;
        var tag = this.tagName.toLowerCase(); // normalize case
        if (type == 'text' || type == 'password' || tag == 'textarea')
            this.value = "";
        else if (type == 'checkbox' || type == 'radio')
            this.checked = false;
        else if (tag == 'select')
            this.selectedIndex = -1;
    });
};


function chk_radio(f){ 
    var rdioLen = f.length; 
    var cnt = 0;
    for(var i = 0; i < rdioLen; i++){ 
        if(f[i].checked == true){ 
            cnt++; 
        } 
    } 
    if(cnt < 1){ 
        alert('사용 유무를 선택하세요'); 
        return false; 
    }else{ 
        
        return true; 
    } 
     
} 




function isValidEmail(f) {

	 var input = f;
	 
	    var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	    return isValidFormat(input,format);
	}

function isValidFormat(input,format) {
	    if (input.value.search(format) != -1) {
	    	
	    	input.focus();
	    	return "true"; //올바른 포맷 형식
	    }
	    alert("Email 형식이 올바르지 않습니다");
	    input.focus();
	    return;
}


function delete_cookie(name) {
	var today = new Date();

	today.setTime(today.getTime() - 1);
	var value = getCookie(name);
	if (value != "")
		document.cookie = name + "=" + value + "; path=/; expires="	+ today.toGMTString();
}

function WinPopUp(url, windowname)
{
	
	var left = Math.ceil( (window.screen.width  - 500) / 2 );
    var top = Math.ceil( (window.screen.height - 500) / 2 );
    
	if (! window.focus)return true;
	var href;
	if (typeof(url) == 'string')
	   href=url;
	else
	   href=url.href;
	window.open(url, windowname, 'width=500,height=500 left=' + left + ',top=' + top + ',scrollbars=yes, resizble=yes');
	return false;	
}

function Enter_key(e)  
{
    
    if(event.keyCode == 13)
    {
    	login_form();
    }
}  



function isDate(dtStr) {
	// alert("hi");
	var dtCh = "/";
	var minYear = 1900;
	var maxYear = 2100;
	var daysInMonth = DaysArray(12);
	var pos1 = dtStr.indexOf(dtCh);
	var pos2 = dtStr.indexOf(dtCh, pos1 + 1);
	var strYear = dtStr.substring(0, pos1);
	var strMonth = dtStr.substring(pos1 + 1, pos2);
	var strDay = dtStr.substring(pos2 + 1);
	strYr = strYear;
	if (strDay.charAt(0) == "0" && strDay.length > 1)
		strDay = strDay.substring(1);
	if (strMonth.charAt(0) == "0" && strMonth.length > 1)
		strMonth = strMonth.substring(1);
	for ( var i = 1; i <= 3; i++) {
		if (strYr.charAt(0) == "0" && strYr.length > 1)
			strYr = strYr.substring(1);
	}
	month = parseInt(strMonth);
	day = parseInt(strDay);
	year = parseInt(strYr);
	if ((pos1 == -1 || pos2 == -1) && dtstr.value != null) {
		alert("The date format should be : yyyy/mm/dd");
		return false;
	}
	if (strMonth.length < 1 || month < 1 || month > 12) {
		alert("Please enter a valid month");
		return false;
	}
	if (strDay.length < 1 || day < 1 || day > 31
			|| (month == 2 && day > daysInFebruary(year))
			|| day > daysInMonth[month]) {
		alert("Please enter a valid day");
		return false;
	}
	if (strYear.length != 4 || year == 0) {
		alert("Please enter a valid 4 digit year ");
		return false;
	}
	if (dtStr.indexOf(dtCh, pos2 + 1) != -1
			|| isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
		alert("Please enter a valid date");
		return false;
	}
	return true;
}

function checkemail() {
	var str = document.validation.emailcheck.value;
	var filter = /^.+@.+\..{2,3}$/;

	if (filter.test(str))
		testresults = true;
	else {
		alert("Please input a valid email address!");
		testresults = false;
	}
	return (testresults);
}

var Num = /^[0-9]+$/;
var Phone = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
var Htel = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$/;
var Mail = /^[_a-zA-Z0-9-]+@[._a-zA-Z0-9-]+\.[a-zA-Z]+$/;
var Domain = /^[.a-zA-Z0-9-]+.[a-zA-Z]+$/;
var Alpha = /^[a-zA-Z]+$/;
var Host = /^[a-zA-Z-]+$/;
var AlphaNum = Alpha + Num;
var ID = /^[a-zA-Z]{1}[a-zA-Z0-9_-]{4,10}$/;
var illegalStr = "~`!@#$%^&*()_-+=\|]}[{'\";:/?.><,";
var AlphaNum = "abcdefghijklmnopqrstuvwxyz0123456789";
var Same = /^(.)(\1)*$/;

//var field = document.forms["form"].field;
var pattern = "Num";
var Msg = "숫자 입력만 허용됩니다.";

function isChars(field, pattern, Msg) {
	patten = eval(pattern);

	//alert(field.value);
	if (!patten.test(field.value)) {
		alert(Msg);
		field.select();
		return false;
	}
	return true;
}

function index_special(x) {
	var ans = x.value;
	var i = 0;
	var special = new Array(" ", "'", "?", "|", "~", "!", "@", "#", "$", "%",
			"^", "&", "*", "(", ")", "-", "=", "+", "`", "{", "}", "[", "]",
			"\\", "/", "<", ">", ",", ".", "`", ":", ";", "\"");

	for (i = 0; i < special.length; i++) {
		var output = ans.indexOf(special[i], 0);
		if (output != -1) {

			alert("Only A-Z, a-z, _and 0-9 are allowed.");
			x.focus();
			x.value = '';

			return false;
		}
	}

}

function numbersonly(e, decimal, x) {
    var key;
    var keychar;

    if (window.event) {
        key = window.event.keyCode;
    } else if (e) {
        key = e.which;
    } else {
        return true;
    }
    keychar = String.fromCharCode(key);

    if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13)
            || (key == 27)) {
        return true;
    } else if ((("0123456789").indexOf(keychar) > -1)) {
        return true;
    } else if (decimal && (keychar == ".")) {
        return true;
    } else
    {
       // return false;    	
    	alert("오직 숫자만 입력 가능합니다.");
    	
    	return false; 
    }
}

function checkNumValid(x) {
	var s_len = x.value;
	if (x.value == 0) {

		alert(" The length must be between 1 to 10 numbers. ");
		x.value = '';
		x.focus();
		return false;
	}
	if (x.value < 0 || x.value > 10 || isNaN(x.value)) {

		alert(" The length must be between 1 to 10 numbers. ");
		x.value = '';
		x.focus();
		return false;

	}
	return true;

}

function isChecked(f){
    var ml = f;
    var len = ml.elements.length;
    for (var i = 0; i < len; i++) {
        var e = ml.elements[i];
        if (e.name == "iFavoriteID") {
            if(e.checked == true) return true;
        }
    }
    return false;
}

function input_empty(x)
{
	var s_len = x.value;
	if(x.value == 0)
	{
		
		return false; 
	}
	
	return true;
}

function verifyIP_network(IPvalue) {
	// alert("sada"+IPvalue);
	var ipadd = IPvalue.value;
	if (IPvalue.value != '') {
		errorString = "";
		theName = "IPaddress";

		var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
		var ipArray = IPvalue.value.match(ipPattern);

		if (IPvalue.value == "0.0.0.0") {
			errorString = errorString + theName + ': ' + IPvalue.value
					+ ' is a special IP address and cannot be used here.';

			alert(errorString);
			IPvalue.value = '';
			return false;
		}

		// else if (IPvalue == "255.255.255.255")
		// errorString = errorString + theName + ': '+IPvalue+' is a special IP
		// address and cannot be used here.';
		// ipadd.value='';
		if (ipArray == null) {
			errorString = errorString + theName + ': ' + IPvalue.value
					+ ' is not a valid IP address.';
			// errorString = errorString + theName + ':
			// '+IPvalue.value+HIDE_ADV_VAL2;
			IPvalue.value = '';
			alert(errorString);
			return false;
		} else {
			for (i = 0; i < 5; i++) {
				thisSegment = ipArray[i];
				if (thisSegment > 255) {
					errorString = errorString + theName + ': ' + IPvalue.value
							+ ' is not a valid IP address.';
					// errorString = errorString + theName + ':
					// '+IPvalue.value+HIDE_ADV_VAL2;
					IPvalue.value = '';
					alert(errorString);
					return false;
					// ipadd.value='';
				}

				if ((i == 0) && (thisSegment > 255)) {
					errorString = errorString
							+ theName
							+ ': '
							+ IPvalue.value
							+ ' is a special IP address and cannot be used here.';
					// errorString = errorString + theName + ':
					// '+IPvalue.value+HIDE_ADV_VAL1;
					// ipadd.value='';
					IPvalue.value = '';
					alert(errorString);
					return false;
				}
			}
		}
		extensionLength = 3;
		if (errorString != "") {
			IPvalue.value = '';
			alert(errorString);
			// document.location.reload();
			return 0; // fail
		}
		return 1; // success
	}
}


function submit_ajax(form_name, url, datatype, return_name, send_from_name)
{
        var form_name_val = form_name;

        $postData  = $('#'+form_name_val).serialize();       
        $url = url;
        $datatype = datatype;
        $return_name = return_name;

        jQuery.ajax({

        type :'POST'
        , asyn : true
        , url: $url
        , data : $postData
        , dataType: 'json'
        , success:function( htmlData ){   // Callback func

        	    if(return_name != null)
                {
                        if(return_name == "update")
                        {
                        	if(htmlData.result == "fail")
                        	{
                        		alert("비밀 번호가 틀렸습니다.");
                        	}else if(htmlData.result == "success")
                        	{
                        		send_from_name.submit();
                        	}else
                        	{
                        		alert("잘못된 응답");                        	
                        	}
                        
                            
                        }
                        
                        if(return_name == "IDCheck")
                        {
                        	
                        	if(htmlData.result == "fail")
                        	{
                        		alert("동일한 ID가 존재 합니다.");
                        		send_from_name.idchk.value = 1;
                        	}else if(htmlData.result == "success")
                        	{
                        		alert("사용 할 수 있는 ID 입니다.");
                        		send_from_name.idchk.value = 0;
                        		
                        	}else
                        	{
                        		alert("잘못된 응답");
                        		send_from_name.idchk.value = 1;
                        	}
                        }
                               
                        if(return_name == "LOGIN")
                        {
                        	if(htmlData.LoginReturnCode == "fail")
                        	{
                        		alert("로그인에 실패 하였습니다. \n다시 시도 하여 주세요.");
                        	
                        	}else if(htmlData.LoginReturnCode == "success")
                        	{
                        		location.href="./MainAction.action";   
                        		return ;
                        		
                        	}else if(htmlData.LoginReturnCode == "EXPIRED")                        	
                        	{
                        		alert("계정이 잠금 상태로 되었습니다. \n시스템 관리자에게 문의 하십시오.");
                        	
                        	}else if(htmlData.LoginReturnCode == "19999")
                        	{
                        		alert("데이터 베이스 오류 \n시스템 관리자에게 문의 하십시오.");
                        		
                        	}else if(htmlData.LoginReturnCode == "notIsAdmin")
                        	{
                        		alert("접속 승인이 되지 않았습니다. \n시스템 관리자에게 문의 하십시오. ");
                        		
                        	}else
                        	{
                        		if(htmlData.LoginReturnCode == "NOID")
                        		{
                        			alert("로그인에 실패하였습니다. \n다시 시도하여 주세요.")
                        		}else 
                        		{
                        			alert("연속해서 5회 초과 오류시 해당 계정은 잠금 상태로 변경 됩니다. \n신중히 입력하세요. \n" + htmlData.LoginReturnCode + "회 오류");	
                        		}
                        		
                        	}
                        }
                        
                        if(return_name == "idCheck")
                        {
                        	if(htmlData.idCheck == "fail")
                        	{
                        		alert("중복된 ID가 존재 합니다.");
                        		document.fwrite.idchk.value = 1;
                        	}else if(htmlData.idCheck == "success")
                        	{
                        		alert("사용 할 수 있는 ID 입니다. ");
                        		document.fwrite.idchk.value = 0;
                        	}else
                        	{
                        		alert("잘못된 응답");  
                        		document.fwrite.idchk.value = 1;
                        	}                       
                            
                        }
                        
                        if(return_name == "nameCheck")
                        {
                        	if(htmlData.nameCheck == "fail")
                        	{
                        		alert("중복된 이름이 존재 합니다.");
                        		document.fwrite.namechk.value = 1;
                        	}else if(htmlData.nameCheck == "success")
                        	{
                        		alert("사용 할 수 있는 이름 입니다. ");
                        		document.fwrite.namechk.value = 0;
                        	}else
                        	{
                        		alert("잘못된 응답");          
                        		document.fwrite.namechk.value = 1;
                        	}
                        
                            
                        }
                        
                       if(return_name == "QrCreate")
                       {
                    	   //alert(htmlData.QrImagePath);
                    	   document.getElementById("qrImage").style.display = "block";
                    	   
                    	   $("#innerresult img").attr({src: htmlData.QrImagePath});
                    	   $("#innerresult img").attr('src',   $("#innerresult img").attr('src') + '?' + Math.random()); 
	                       	if(htmlData.QrImagePath == ".png")
	                    	{
	                    		
	                    	}
                       }
                       if(return_name == "QrList")
                    	   
                       {
                    	                   	   
                    	   totalCount = htmlData.totalCount;
                    	   listVo = htmlData.qRCodeListVo; 
                    	   //alert("totalCount = " + totalCount );
                    	   //alert("listVo =" + listVo );
                    	   getPageGO();	
                    	             
                    	   /*var newcontent = ''; 
                    	    for(var i=0;i<listVo.length; i++)
                    	    {
                    	    	
                    	        newcontent += '<dt>' + "SEQ --> " +  listVo[i].seq +",   URL --> " +listVo[i].imgURL+ '</dt>';
                    	        
                    	        
                    	    }
                    	    alert("newcontent " + newcontent);
                    	    $('#Searchresult').html(newcontent);*/
                       }
                       if(return_name == "AdminList")                    	   
                       {
                    	                   	   
                    	   totalCount = htmlData.totalCount;
                    	   listVo = htmlData.qRUserListVo; 

                    	   getPageGO();	                    	             
 
                       }
                    	
                      if(return_name == "IsAdmin")
                      {
                    	  if(htmlData.IsAdmin == "true")
                      	  {                    		  
                    			alert("요청 처리 되었습니다.");
                      	  }else
                      	  {
                      		   alert("요청에 실패 하였습니다.");	  
                      	  }
                      }
                      
                      if(return_name == "IDPW")
                      {
                    	  if(htmlData.ReturnCode == "no")
                    	  {
                    		  alert("잘못된 정보를 입력 하셨습니다.");
                    	  }else
                    	  {
                    		  alert("아이디는 "+ htmlData.ReturnCode + " 입니다.");
                    	  }
                      }else if(return_name == "ResetPW")
                      {
                    	  if(htmlData.ReturnCode == "false")
                    	  {
                    		  alert("잘못된 정보를 입력 하셨습니다.");
                    	  }else
                    	  {
                    		  alert("초기화 되었습니다. \n초기화 된 암호는 1234QWER 입니다. ");
                    		  location.href="./LoginAction.action";   
                    		  
                    	  }  
                      }
                      
                      
                      
                    	   

                }          


        }
        , error:function(xhr,textStatus){

        		alert("서버로 부터 응답이 없습니다."); 


        }
        , complete:function(xhr,textStatus){

        }
        }
        );

}


