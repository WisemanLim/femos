// 미아/노인 조치내역 등 : http://hbsys98.vps.phps.kr/oper_missing/missing_history_save.jsp?missing_key=1&result=BBB
var result = function() {
	var missing_key = document.getElementById("missing_key").value;
	var result = document.getElementById("result").value;
	var url = "http://hbsys98.vps.phps.kr/oper_missing/missing_history_save.jsp?missing_key=" + missing_key + "&result=" + result;
	
//	alert(url);
	processAjax(url);
}

var processAjax = function(url) {
	if (window.XMLHttpRequest) { // Non-IE browsers
		req = new XMLHttpRequest();
		req.onreadystatechange = targetDiv;
		try {
			req.open("POST", url, true);
		} catch (e) {
			alert(e);
		}
		req.send(null);
	} else if (window.ActiveXObject) { // IE
		req = new ActiveXObject("Microsoft.XMLHTTP");
		if (req) {
			req.onreadystatechange = targetDiv;
			req.open("POST", url, true);
			req.send();
		}
	}
}

var targetDiv = function() {
	var missing_key = document.getElementById("missing_key").value;
	
	if (req.readyState == 4) { // Complete
		if (req.status == 200) { // OK response
//			document.getElementById("missing_history").innerHTML = req.responseText;
//			location.href = "http://hbsys98.vps.phps.kr/mobile/view_missing_info.jsp?missingKey=" + missing_key;
			alert("조치내용 등록이 완료되었습니다.")
			history.go(-2);
		} else {
			alert("Problem: " + req.statusText);
		} 
	} 
}

var showResultHistory = function() {
	initLoading();
	var missing_key = document.getElementById("missing_key").value;
	var url = "http://hbsys98.vps.phps.kr/xml_data/missing_result_history.jsp?missing_key=" + missing_key;
	
//	alert(url);
	historyAjax(url);
}

var historyAjax = function(url) {
	if (window.XMLHttpRequest) { // Non-IE browsers
		req = new XMLHttpRequest();
		req.onreadystatechange = targetHistory;
		try {
			req.open("GET", url, true);
		} catch (e) {
			alert(e);
		}
		req.send(null);
	} else if (window.ActiveXObject) { // IE
		req = new ActiveXObject("Microsoft.XMLHTTP");
		if (req) {
			req.onreadystatechange = targetHistory;
			req.open("GET", url, true);
			req.send();
		}
	}
}

var targetHistory = function() {
	if (req.readyState == 4) { // Complete
		if (req.status == 200) { // OK response
			showHistory(req.responseXML);
		} else {
			alert("Problem: " + req.statusText);
		} 
	} 
}

var showHistory = function(xml) {
    var text = ""; //"<table style='width:100%'><tr style='height:20px;'><td style='width:90%;height:20px;text-align:center;font-size:11pt;font-weight:bold;'>"; 
    var span = "";
	if ( $(xml).find("data").find("rows").length > 0 ) {
		$(xml).find("data").find("rows").each(function(idx) {
			var missing_key = $(this).find("missing_key").text();
			var serial = "";
			var missing_result_history = "";
			if ( missing_key != "0" ) {
				serial = $(this).find("serial").text();
				missing_result_history = $(this).find("missing_result_history").text();
				
				if ( span == "" ) {
					span = "<span>[" + missing_result_history + "]</span>"; 
				} else {
					span = span + "<br />" + "<span>[" + missing_result_history + "]</span>"; 
				}
			}
		});
	}
	
    text += span; // + "</td></tr></table>";
//    alert(missing_result_history + '\r\n' + text);
    if ( missing_result_history != "0" ) {
    	document.getElementById("missing_history").innerHTML = text;
    }
    Loaded();
}

<!-- 로딩중 화면표시 시작 --> 
var initLoading = function() {
	wb = document.body.offsetHeight/2 - waiting.offsetHeight/2 
	wp = document.body.offsetWidth/2 -waiting.offsetWidth/2 
	waiting.style.top=wb 
	waiting.style.left=wp 
	waiting.style.visibility="visible" 
}
<!-- 로딩중 화면표시 끝 -->

<!-- 로딩중 화면표시 스크립터 --> 
var Loaded = function() {
	waiting.style.visibility="hidden" 
}
<!-- 로딩중 화면표시 스크립터 끝 -->
