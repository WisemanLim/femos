
var user_info_data_file_name = "user_info.txt";
var name;
var gender;
var phone_number;
var email;
var visiter_id;
var image;
 
  $(function() 
  {
      $.fn.raty.defaults.path 		='rating/img';
	  $.fn.raty.defaults.starHalf 	='star-half-big.png';
      $.fn.raty.defaults.starOff 	='star-off-big.png';
      $.fn.raty.defaults.starOn 	='star-on-big.png';
	  $.fn.raty.defaults.half     	= true;
	  $.fn.raty.defaults.size 		= 24;
	  $.fn.raty.defaults.width		= false;
	  $('#fun').raty();
	  $('#environment').raty();
	  $('#facilities').raty();
	  
	  	$(document).bind("mobileinit",function()
		{
			$.mobile.allowCrossDomanPages = true;
		});	
		
		
		$(document).bind("pagechange",function()
		{
			var button = document.getElementById("capture");
			button.addEventListener("click",captureImage,false);
		
			var button2 = document.getElementById("info_submit");
			button2.addEventListener("click",onInfo_submit,false);
			
			/*var button3 = document.getElementById("qr_scanner");
			button3.addEventListener("click",scan,false);*/
			
			var button4 = document.getElementById("checkjoinFestival");
			button4.addEventListener("click", onCheckjoinFestival, false);
		});
		
				
			 $("#SatisfactionRating").click(function(){
  
                var formData = $("#SatisfactionRatingForm").serialize();
				
				alert(formData);
								
                $.ajax({
                    type:"POST",
					url:"http://hbsys98.vps.phps.kr/mobile/join_festival_1.jsp",
                    cache:false,
                    data:formData,
                    success:function(){
						$.mobile.changePage("#main",
						{
							transition:"slide",
						},
						true,
						true);
					},
                    error:function(data)
					{
						alert(data.status);
					}
                });
  
                return false;
            });
			
			 $("#InconvenienceReport").click(function(){
  
                var formData = $("#InconvenienceReportForm").serialize();
				
				//alert(formData + image);
								
                $.ajax({
                    type:"POST",
//					url:"http://hbsys98.vps.phps.kr/mobile/upload_inconvenient.jsp",
					url:"http://hbsys98.vps.phps.kr/mobile/upload_inconvenient_hybrid.jsp",
                    cache:false,
                    data:formData,
                    success:function(){
						$.mobile.changePage("#main",
						{
							transition:"slide",
						},
						true,
						true);
					},
                    error:function(data)
					{
						alert(data.status);
					}
                });
  
                return false;
            });		
	});
	
	function onCheckjoinFestival()
	{	  	
		if(name != "" && name != null )
		{
			$("#popupDialog").popup('open');
		}
		else
		{
			
			$.mobile.changePage("#user_data_input",
			{
				transition:"slide",
			},
			true,
			true);
		}	
	}
	
	function onLoad() 
	{
        document.addEventListener("deviceready", onDeviceReady,false);
    }

    function onDeviceReady() 
	{
		window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, gotFL, Loadfail);
		
		document.addEventListener("backbutton", onBackKeyDown, false);

		var button = document.getElementById("capture");
		button.addEventListener("click",captureImage,false);
		
		var button2 = document.getElementById("info_submit");
		button2.addEventListener("click",onInfo_submit,false);
			
		/*var button3 = document.getElementById("qr_scanner");
		button3.addEventListener("click",scan,false);*/
			
		var button4 = document.getElementById("checkjoinFestival");
		button4.addEventListener("click", onCheckjoinFestival, false);
    }

	function onInfo_submit()
	{
		name = document.getElementById("visiter_nm").value;
		gender = document.getElementById("sex").value;
		phone_number = document.getElementById("hp").value;
		email = document.getElementById("email").value;
		visiter_id = document.getElementById("_visiter_id").value;
		
		if( name == "" )
		{			
			$("#name_error").popup('open');
		}
		else if( phone_number == "" )
		{
			$("#phone_number_error").popup('open');
		}
		else if( email == "" )
		{
			$("#email_error").popup('open');
		}
		else
		{
			$("#welcome").popup('open');
		}
		
//		window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, gotFS, fail);
		
		var formData = $("#registerForm").serialize();
			
		$.ajax
		({
			type:"POST",
//          url:"http://192.168.0.28/TS.php",
//	        url:"http://hbsys98.vps.phps.kr/mobile/join_festival_1.jsp",
	        url:"http://hbsys98.vps.phps.kr/mobile/join_hybrid.jsp",
            cache:false,
            data:formData,
            success:function(xml)
			{
            	var _visiter_id = $(xml).find("visiter_id").text();
//            	alert(xml + "\r\n" + _visiter_id);
            	document.getElementById("_visiter_id").value = _visiter_id;
            	visiter_id = document.getElementById("_visiter_id").value;
				$.mobile.changePage("#main");
				window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, gotFS, fail);
			},
            error:function(data)
			{
				alert(data.status);
			}
       });
	}
	
    function onBackKeyDown() 
	{
		if($.mobile.activePage.is('#main'))
		{
			if ( confirm("Festival App을 종료하시겠습니까?") ) {
				navigator.app.exitApp();
			}
		}
		else 
		{
			navigator.app.backHistory()
		}
    }
	
	function captureImage()
	{
		navigator.camera.getPicture( onSuccess, onError,{ quality : 50, 
		destinationType : Camera.DestinationType.DATA_URL, 
		sourceType : Camera.PictureSourceType.CAMERA, 
		allowEdit : true,
		encodingType: Camera.EncodingType.JPEG} );
	}
	
	function onSuccess(imageData)
	{
		image = document.getElementById('cameraImage');
		image.src = "data:image/jpeg;base64," + imageData;
	}
	
	function onError(error)
	{
		alert('code : ' + error.code + '\n' + 'message: ' + error.message + 'n');
	}
	
function loadURL(url)
{ 
	navigator.app.loadUrl(url, { openExternal:true }); 
} 
 
function scan() 
{
	window.plugins.barcodeScanner.scan(
	function(result) 
	{
		if( result.text != "")
		{
			loadURL(result.text);				   
		}
	}, 
	function(error) 
	{
	});
}
	
function encode(type, data)
{
	window.plugins.barcodeScanner.encode(type, data, 
	function(result) 
	{
    }, 
	function(error) 
	{
    });
}

function gotFS(fileSystem) 
{
	fileSystem.root.getFile(user_info_data_file_name, {create: true, exclusive: false}, gotFileEntry, fail);
}

function gotFileEntry(fileEntry)
{
	fileEntry.createWriter(gotFileWriter, fail);
}

 function gotFileWriter(writer) 
 {
// 	var _visiter_id = document.getElementById("_visiter_id").value;
// 	alert("gotFileWriter" + _visiter_id);
   writer.write(name+'\n'+gender+'\n'+phone_number+'\n'+email+'\n'+visiter_id+"\n");
 }

function fail(error) 
{	
	//alert(error.code);
}
function Loadfail(error) 
{
}

function gotFL(fileSystem) 
{
	fileSystem.root.getFile(user_info_data_file_name, null, getFile, Loadfail);
}
function getFile(fileEntry) 
{
	fileEntry.file(gotFile, fail);
}
function gotFile(file)
{
	readDataUrl(file);
	readAsText(file);
}
function readDataUrl(file) 
{
	var reader = new FileReader();
	reader.readAsDataURL(file);
}

function readAsText(file) 
{
	var reader = new FileReader();
	
	reader.onload = function(e) 
	{
//	  name = e.target.result[0];
// 	  gender = e.target.result[1];
// 	  phone_number = e.target.result[2];
// 	  email = e.target.result[3];
// 	  alert("file:" + e.target.result.length);
 	  var text = "";
 	  for (i=0; i<e.target.result.length; i++ ) {
 		  text = text + e.target.result[i];
 	  }
 	  var _tmp = text.split("\n");
// 	  alert(_tmp.length + "\r\n" + _tmp[0] + "," + _tmp[1] + "," + _tmp[2] + "," + _tmp[3] + "," + _tmp[4]);
	  name = _tmp[0];
 	  gender = _tmp[1];
 	  phone_number = _tmp[2];
 	  email = _tmp[3];
 	 visiter_id = _tmp[4];
 	 document.getElementById("visiter_id").value = visiter_id; //불편 신고
	}

	reader.readAsText(file);	
}

function showVisiter() {
	var url = "http://hbsys98.vps.phps.kr/mobile/view_hybrid.jsp?visiterId=" + visiter_id;
	processAjax(url);
}
var processAjax = function(url) {
	if (window.XMLHttpRequest) { // Non-IE browsers
		req = new XMLHttpRequest();
		req.onreadystatechange = targetDiv;
		try {
			req.open("GET", url, true);
		} catch (e) {
			alert(e);
		}
		req.send(null);
	} else if (window.ActiveXObject) { // IE
		req = new ActiveXObject("Microsoft.XMLHTTP");
		if (req) {
			req.onreadystatechange = targetDiv;
			req.open("GET", url, true);
			req.send();
		}
	}
}

var targetDiv = function() {
	if (req.readyState == 4) { // Complete 
		if (req.status == 200) { // OK response
//			alert(req.responseText);
			document.getElementById("visitor").innerHTML = req.responseText;
		} else { 
			alert("Problem: " + req.statusText);
		} 
	} 
}