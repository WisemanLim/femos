var goScanning = function() {
	location.href = "scanned.html";
}

// 1.QRCode 조회(미아/노인) : http://hbsys98.vps.phps.kr/mobile/view_missing_info.jsp?missingKey=
var scanCode = function() {
    window.plugins.barcodeScanner.scan(
        function(result) {
//        alert("Scanned Code: " + result.text 
//                + ". Format: " + result.format
//                + ". Cancelled: " + result.cancelled);
        	if ( result.cancelled == false ) {
//				document.getElementById('main').innerHTML = result.text;
//	        	alert("URL:" + result.text);
//	        	location.href = result.text;
//				document.getElementById("main").innerHTML = "<center><h1>요청하신 정보를 스마트 축제 시스템에 조회 중입니다.</h1><center>";
//				document.getElementById("layout-container").innerHTML = "<center><h1>요청하신 정보를 스마트 축제 시스템에 조회 중입니다.</h1><center>";
	        	location.href = result.text;
//	        	processAjax(result.text);
        	} else {
        		history.go(-1);
        	    navigator.app.backHistory();
        	}
    }, function(error) {
        alert("Scan failed: " + error);
    });
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
//		    document.getElementById("main").style.display = "none";
//		    document.getElementById("layout-container").style.display = "none";
//		    document.getElementById("exit").value = "N";
//		    alert(req.responseText);
//		    document.getElementById("scanned").setAttribute("style","");
			document.getElementById("scanned").innerHTML = req.responseText;
		} else {
			alert("Problem: " + req.statusText);
		}
	}
}

var encodeText = function() {
    window.plugins.barcodeScanner.encode(
            BarcodeScanner.Encode.TEXT_TYPE,
            "http://www.mobiledevelopersolutions.com", 
            function(success) {
                alert("Encode success: " + success);
            }, function(fail) {
                alert("Encoding failed: " + fail);
            });
}

var encodeEmail = function() {
    window.plugins.barcodeScanner.encode(
        BarcodeScanner.Encode.EMAIL_TYPE,
        "a.name@gmail.com", function(success) {
            alert("Encode success: " + success);
        }, function(fail) {
            alert("Encoding failed: " + fail);
        });
}

var encodePhone = function() {
    window.plugins.barcodeScanner.encode(
        BarcodeScanner.Encode.PHONE_TYPE,
        "555-227-5283", function(success) {
            alert("Encode success: " + success);
        }, function(fail) {
            alert("Encoding failed: " + fail);
        });
}

var encodeSMS = function() {
    window.plugins.barcodeScanner.encode(
        BarcodeScanner.Encode.SMS_TYPE,
        "An important message for someone.", function(success) {
            alert("Encode success: " + success);
        }, function(fail) {
            alert("Encoding failed: " + fail);
        });
}

var onLoad = function() {
	document.addEventListener("deviceready", onDeviceReady, false);
}
var onDeviceReady = function() {
	document.addEventListener("backbutton", onBackKeyDown, false);	
}
var onBackKeyDown = function() {
	var exit = document.getElementById("exit").value;
	if ( (exit == "Y") && confirm("미아/노인 찾기 App을 종료하시겠습니까?") ) {
		navigator.app.exitApp();
	} else if ( exit == "N" ) {
//	    document.getElementById("layout-container").setAttribute("style","");
//		document.getElementById("scanned").style.display = "none";
//		document.getElementById("exit").value = "Y";
		history.go(-1);
	    navigator.app.backHistory();
    }
}