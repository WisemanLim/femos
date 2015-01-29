var gNowMonth = "";

var showCalendar = function(y, m) {
    var text = '<table style="width:100%"><tr style="height:60px;"><td colspan="7" style="width:12%;height:20px;text-align:center;font-size:15pt;font-weight:bold;">'; 
    text += '<span onclick="showCalendar('+(y-1)+','+m+')"> Y- </span>&nbsp;&nbsp;'; 
    text += '<span onclick="showCalendar('+(m==1?(y-1)+','+12:y+','+(m-1))+')"> M- </span>&nbsp;&nbsp;'; 
    text += '[' + y + '/' + ((m < 10) ? ('0' + m) : m) + ']'; 
    text += '&nbsp;&nbsp;<span onclick="showCalendar('+(m==12?(y+1)+','+1:y+','+(m+1))+')"> M+ </span>'; 
    text += '&nbsp;&nbsp;<span onclick="showCalendar('+(y+1)+','+m+')"> Y+ </span>'; 
    text += '</td></tr><tr><td colspan="7" style="height:5px;"></td>';

    var d1 = (y+(y-y%4)/4-(y-y%100)/100+(y-y%400)/400 
          +m*2+(m*5-m*5%9)/9-(m<3?y%4||y%100==0&&y%400?2:3:4))%7; 
    for (i = 0; i < 42; i++) { 
        if (i%7==0) text += '</tr><tr>'; 
        if (i < d1 || i >= d1+(m*9-m*9%8)/8%2+(m==2?y%4||y%100==0&&y%400?28:29:30)) 
            text += '<td></td>'; 
        else 
            text += '<td ' + (i%7 ? ' style="width:12%;height:70px;text-align:right;font-size:11pt;vertical-align:top;"'
            						: ' style="width:12%;height:70px;color:red;text-align:right;font-size:11pt;vertical-align:top;"') + '>'
            						+ (i+1-d1) + '<div id="' + y + '' + ((m < 10) ? ('0' + m) : m) + '' + (((i+1-d1) < 10) ? ('0' + (i+1-d1)) : (i+1-d1)) + '"></div>' + '</td>'; 
    }
    
    text += '</tr></table>';
//    alert(text);
    document.getElementById('calendarDiv').innerHTML = text;
    
    gNowMonth = y + "" + ((m < 10) ? ('0' + m) : m);
}

var onLoad = function() {
	document.addEventListener("deviceready", onDeviceReady, false);
}
var onDeviceReady = function() {
	document.addEventListener("backbutton", onBackKeyDown, false);
	
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth() + 1;
    scheduling(1,"FES10001");
	showCalendar(year,month);
//	gNowMonth = year + "" + ((month < 10) ? ('0' + month) : month);
//	Toast.longshow("Hello, I am long Toast");
//	Toast.shortshow("Hello, I am short Toast");
	
	// event added : 2014.01.20
	document.addEventListener("pause", onPause, false);
	document.addEventListener("resume", onResume, false);
	
//	var now = new Date();
//	now.setSeconds(now.getSeconds() + 5);
//	setAlarm(now, "테스트입니다.\r\n알람시험1", "알람시험1", 1);
//	var now = new Date();
//	now.setSeconds(now.getSeconds() + 60);
//	setAlarm(now, "테스트입니다.\r\n알람시험2", "알람시험2", 2);
}
var onBackKeyDown = function() {
	if ( confirm("행사 일정 알리미 App을 종료하시겠습니까?") ) {
		navigator.app.exitApp();
	}
}

// event added
var onPause = function() {
	//Toast.shortshow("Pause");
}
var onResume = function() {
	//Toast.shortshow("Resume");
	Toast.longshow("해당일정 확인이 보고되었습니다.\r\n\(실제 URL은 공유 금지!!!)");
}

//행사분류, 세부 행사 일정 조회하기
var scheduling = function(type,festival_cd,festival_hall_cd,divId) {
	var url = "";
	document.getElementById("type").value = type;
	if ( type == 1 ) {
		url = "http://hbsys98.vps.phps.kr/xml_data/festival_hall_data.jsp?festival_cd=" + festival_cd; //"FES10001";
	} else if ( type == 2 ) {
		url = "http://hbsys98.vps.phps.kr/xml_data/schedule_data_ex.jsp?festival_cd=" + festival_cd + "&festival_hall_cd=" + festival_hall_cd;
	} else if ( type == 3 ) {
//		alert(festival_cd + "\r\n" + festival_hall_cd + "\r\n" + divId)
		url = "http://hbsys98.vps.phps.kr/xml_data/schedule_date_detail.jsp?festival_cd=" + festival_cd + "&festival_hall_cd=" + festival_hall_cd + "&date=" + divId;
	} else {
		return;
	}
	
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
	var type = document.getElementById("type").value;
	if (req.readyState == 4) { // Complete
		if (req.status == 200) { // OK response
			if ( type == 1 ) {
				subMenu(req.responseXML);
				
//				scheduling(2,"FES10001","FSH10003");
			} else if ( type == 2 ) {
				registerAlarm(req.responseXML);
			} else if ( type == 3 ) {
				showDetail(req.responseXML);
			} else {
				alert("잘못된 요청사항입니다.\r\n관리자한테 확인 하시기 바랍니다.");
			}
//			document.getElementById(div).innerHTML = req.responseText;
		} else {
			alert("Problem: " + req.statusText);
		} 
	} 
}

var subMenu = function(xml) {
	var festival_cd = $(xml).find("festival").attr("id");
    var text = "<table style='width:100%'><tr style='height:20px;'><td style='width:90%;height:20px;text-align:center;font-size:11pt;font-weight:bold;'>"; 
    var span = "";
	if ( $(xml).find("festival").find("data").length > 0 ) {
		$(xml).find("festival").find("data").each(function(idx) {
			var val = $(this).find("val").text();
			var name = $(this).find("name").text();
			
			if ( span == "" ) {
				span = "<span onclick='scheduling(2,\"" + festival_cd + "\",\"" + val + "\");'>[" + name + "]</span>"; 
			} else {
				span = span + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "<span onclick='scheduling(2,\"" + festival_cd + "\",\"" + val + "\");'>[" + name + "]</span>"; 
			}
			
//			scheduling(2,festival_cd,val);
		});
	}
	
    text += span + "</td></tr></table>";
	document.getElementById("subMenu").innerHTML = text;
}

var registerAlarm = function(xml) {
	var festival_cd = $(xml).find("festival").attr("id");
//	var tmp_id = 0;
//	var text = "";
	if ( $(xml).find("festival").find("data").length > 0 ) {
		$(xml).find("festival").find("data").each(function(idx) {
			var festival_hall_cd = $(this).find("festival_hall_cd").text();
			var programCd = $(this).find("program_cd").text();
			var programNm = $(this).find("program_nm").text();
			var scheduleTitle = $(this).find("schedule_title").text();
			var st_day = parseInt($(this).find("st_day").text()); // - 1; // st_day-1을 해야 함
			var st = $(this).find("st_year").text() + "-" + $(this).find("st_month").text() + "-" + ((st_day < 10) ? ('0' + st_day) : st_day) + "T" + $(this).find("st_hour").text() + ":" + $(this).find("st_minute").text() + ":00Z";
			var ed = $(this).find("ed_year").text() + "-" + $(this).find("ed_month").text() + "-" + $(this).find("ed_day").text() + "T" + $(this).find("ed_hour").text() + ":" + $(this).find("ed_minute").text() + ":00Z";
			var scheduleContent = $(this).find("schedule_content").text();
			
			var divId = $(this).find("st_year").text() + $(this).find("st_month").text();
			
//			alert(gNowMonth + ":" + divId);
			if ( gNowMonth == divId ) {
				var date = new Date(st);
				date.setSeconds(date.getSeconds() - (9*60*60));
//				alert(date + "\r\n" + date.getSeconds());
				var id = $(this).find("st_day").text() + $(this).find("st_hour").text() + $(this).find("st_minute").text();
//				tmp_id++;
//				id = id + tmp_id;
				var id = new Date().getTime();
				setAlarm(date, scheduleContent, scheduleTitle, id);
				divId += $(this).find("st_day").text();
//				alert(id + "\r\n" + divId + "\r\n" + scheduleTitle + "\r\n" + scheduleContent);
//				Toast.shortshow(id + "\r\n" + divId + "\r\n" + scheduleTitle + "\r\n" + scheduleContent);
//				var message = '<span onmouseover="scheduling(3,\'' + festival_cd + '\',\'' + festival_hall_cd + '\',\'' + divId + '\');" onmouseout="scheduling(3,\'\',\'\',\'\');">&nbsp;&nbsp;*&nbsp;&nbsp;</span>';
				var message = '<span onclick="scheduling(3,\'' + festival_cd + '\',\'' + festival_hall_cd + '\',\'' + divId + '\');">&nbsp;&nbsp;&nbsp;<img src="./check.png" width="15" height="13"></span>';
				document.getElementById(divId).innerHTML = message; // scheduleTitle;
			}
		});
	}
	
//	var now = new Date();
//	now.setSeconds(now.getSeconds() + 10);
//	setAlarm(now, "테스트입니다.\r\n알람시험", "알람시험", 1);
//	date = new Date("2013-08-24T17:15:00Z");
//	date.setSeconds(date.getSeconds());
//	alert(now + "\r\n" + date);
//	Toast.shortshow(st + "\r\n" + date);
//	setAlarm(date, "Phonegap - Boooyyyaaaaah!\r\nUpyoass!", "Yeeeaaaaahhhh!!!", 1);
	
//	document.getElementById("calendar").innerHTML = text;
}

// 행사일정에 맞춰 알람 울리기
var setAlarm = function(date, message, ticker, id) {
	if (typeof plugins !== "undefined") {
/*		var now = new Date();
		now.setSeconds(now.getSeconds() + 90);
		
		plugins.localNotification.add({
			date : now,
			message : "Phonegap - Boooyyyaaaaah!\r\nUpyoass!",
			ticker : "Yeeeaaaaahhhh!!!",
			repeatDaily : false,
			id : 4
		});*/
		plugins.localNotification.add({
			date : date,
			message : message,
			ticker : ticker,
			repeatDaily : false,
			id : id/*
		  , hasAction : true,
		    background : 'app.background()',
		    foreground : 'app.running()'*/
		});
	}
}

/*// 사용하지 않게 설정
var notificationProc = function(notificationData) {
	Toast.longshow("해당일정 확인이 보고되었습니다.");
}

var app = {
	background : function(id) {
		Toast.shortshow("백그라운드에서 실행한 알람입니다.: " + id);
	},
	running : function(id) {
		Toast.shortshow("앱이 실행되는 화면에서 실행한 알람입니다.: " + id);
	}
}*/

var showDetail = function(xml) {
    var text = "<center><table style='width:80%'><tr><td style='font-color:#ffffff;font-weight:bold;'>"; 
	var i = 0;
	if ( $(xml).find("festival").find("data").length > 0 ) {
		$(xml).find("festival").find("data").each(function(idx) {
			var programCd = $(this).find("program_cd").text();
			var programNm = $(this).find("program_nm").text();
			var scheduleTitle = $(this).find("schedule_title").text();
			var st_day = parseInt($(this).find("st_day").text()); // - 1; // st_day-1을 해야 함
			var st = $(this).find("st_year").text() + "-" + $(this).find("st_month").text() + "-" + ((st_day < 10) ? ('0' + st_day) : st_day) + " " + $(this).find("st_hour").text() + ":" + $(this).find("st_minute").text();
			var ed = $(this).find("ed_year").text() + "-" + $(this).find("ed_month").text() + "-" + $(this).find("ed_day").text() + " " + $(this).find("ed_hour").text() + ":" + $(this).find("ed_minute").text();
			var scheduleContent = $(this).find("schedule_content").text();
			
			i++;
			text += "<br/>[" + i + "]번째 행사" + "<br/>-일시 : " + st + "~" + ed + "<br/>-제목 : " + scheduleTitle + "<br/>-내용 : " + scheduleContent;
		});
	}
	text += "</td></tr></table>";
	
    var objDiv = document.getElementById('viewCalendar'); //idMyDiv);
    objDiv.innerHTML = text;
    
    if (objDiv.style.display == "block") {
    	objDiv.style.display = "none";
    } else {
    	objDiv.style.display = "block";
    }
}