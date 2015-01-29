/**
 * This file handles RouteDesign rendering and editor UI. It also
 * provides a simple API for setting RouteDesign size, colors and so on.
 *
 * Copyright (c) 2012 Anthony Kim(김재도), jaedoki@gmail.com
 */

//----------------------------------
// Global Var
//----------------------------------
var __settings = null;
var __contextPath = null;
var __smuHMax = null; 
var __smuRMax = null; 
var __smuOMax = null;

var aMenu = new Array();

$(document).ready(function() {
	
	var stage = new Kinetic.Stage({
		container: "container",
		width: 660,
		height: 500
	});

	//----------------------------------
	// Settings
	//----------------------------------
	var settings = {

		xPos : 0,
		yPos : 0,
		
		//
		cmCD : null,
		cmHCD : null,
		menuList : null,
		contMatrix : null,
		stage : null,
		loadStage : null,
		
		// Dimensions
		rows : 12,
		columns : 12,

		// Cosmetic settings
		cellSize : 20,
		stringSize : 12,
		strokeWidth : null,
		routeColor : "#FF9A39",
		guideColor : "#000000",
		backgroundColor: "#FFFFFF",
				
		// Pattern editor UI colors
		gridColor: "rgb(180, 180, 180)",
		cutColor: "rgb(180, 180, 180)",
		newCutColor: "rgb(0, 255, 0)",
		controlNodeColor1: "#6dcff6",
		controlNodeColor2: "#f66d6d",

		showGrid: true,
		showUi: true,

		controlNodeSize : 5,
		selectedControlNodeSize : 12,
		
		cntHorizontalLine : null,
		cntVerticalLine : null,
		halfCellSize : null,
		halfStringSize : null,
		
		// Position Info Construct
		buildPos : null,	// build Position
		buildPosCd : null,	// build Position
		buildMetaInfo  : null,	// build info
		
		routePosData : null,
		routePosCd : null,
		routePos : null,	// route position
		tmpPos : null,	// temp position
		tmpPosObj : null,	// temp position Obj
		
		// manage layout
		gridLayer : null,
		baseLayer : null,
		pointLayer : null,
		routeLayer : null,
		guideLayer : null,
		imageLayer : null,
		
		// 그리기 모드 설정
		// s : 선택모드  , r : 루트모드 , c : 이미지모드
		mode : "s",
		lineType : "01",
		imgData : null,
		currentObj : "none"
	};
	
	//
	settings.stage = stage;
	
	//
	function setStageConfig(){
		settings.xPos = 0;
		settings.yPos = 0;
		
		settings.halfCellSize = settings.cellSize / 2;
		settings.halfStringSize = settings.stringSize / 2;
		settings.strokeWidth = parseInt(settings.cellSize * 0.5);  // Cell 크기의 50%를 스트로크 넓이로 사용
		
		settings.cntHorizontalLine = parseInt(stage.getHeight() / parseInt(settings.cellSize));
		settings.cntVerticalLine = parseInt(stage.getWidth() / parseInt(settings.cellSize));	

		var numHorizontalLines = settings.cntHorizontalLine;
		var numVerticalLines = settings.cntVerticalLine;

		//var map = new HashMap();
		//settings.buildPos = map;
		
		settings.menuList = new Array();
		settings.buildPos = new Array();
		settings.buildPosCd = new Array();
		settings.buildMetaInfo = new Array();
		
		settings.tmpPos = new Array();
		settings.tmpPosObj = new Array();
		
		settings.routePos = new Array();
		settings.routePosCd = new Array();
		settings.routePosData = new Array();
		
		//var map2 = new HashMap();	
		//settings.mLayerManager = map2;
		//console.debug("1) "+numHorizontalLines +","+ numVerticalLines);

		var gridLayer = new Kinetic.Layer();	
		var routeLayer = new Kinetic.Layer();	
		var guideLayer = new Kinetic.Layer();	
		var pointLayer = new Kinetic.Layer();
		var imageLayer = new Kinetic.Layer();	
		
		settings.gridLayer = gridLayer;
		settings.routeLayer = routeLayer;
		settings.guideLayer = guideLayer;
		settings.pointLayer = pointLayer;
		settings.imageLayer = imageLayer;

		// 그리드 데이터셋 구성
		var state = new Array(numHorizontalLines);
		for (var y = 0; y < numHorizontalLines; ++y) {
		    state[y] = new Array(numVerticalLines);
		}
		
		// 매트릭스 구조체 저장. 
		settings.contMatrix = state;
		
		//
		RouteDraw.drawMatrix(settings);
		
		//
		stage.add(settings.gridLayer);
		stage.add(settings.routeLayer);
		stage.add(settings.guideLayer);
		stage.add(settings.pointLayer);
		stage.add(settings.imageLayer);
		
	}
	
	setStageConfig();	
	__settings = settings;
		
	// 현재 위치 선택하고
	// 선택된 그리드 색칠함
	//------------------------------------------------
	// 그리기 모드가 선택모드이면 라인은 그릴수 없다.
	//------------------------------------------------
	if( __settings.mode === "s" ){
	    RouteFunction.setEventGridPosition("off");
	}else{
	    RouteFunction.setEventGridPosition("on");
	}
	
	//------------------------------------------------
	// 데이터를 담아둔다.
	//------------------------------------------------
	// 메뉴데이터
	//var url ="/routedesign/api/menuList";
	var url ="./result/menuList.jsp"; 
	fnGetApiData(url,scMenuInfo);
	
	// 건물데이터
	//var url ="/routedesign/api/buildingList"; 
	var url ="./result/buildingList.jsp"; 
	fnGetApiData(url,scBuildingInfo);

	//------------------------------------------------
	// 이벤트 세팅
	//------------------------------------------------
	//setMainPageEvent();	
});



//----------------------------------------------------------------------------------
// Data Load Function
//----------------------------------------------------------------------------------
var fnGetApiData = function(url,param,fnCallback){
    $.getJSON(url,param, function(data) {
	fnCallback(eval(data));
    });
};

var fnGetApiData = function(url,fnCallback){
    $.getJSON(url, function(data) {
	fnCallback(eval(data));
    });
};

// 메뉴데이터를 담아둔다.
var scMenuInfo = function(data) {
    __settings.menuList = data.list;

    var strHtml = "";
    $(data.list).each(
	    function(index, obj) {
		var strMenu = "";

		switch (index) {
		case 0:
		    strMenu = "a";
		    break;
		case 1:
		    strMenu = "b";
		    break;
		case 2:
		    strMenu = "c";
		    break;
		case 3:
		    strMenu = "d";
		    break;
		case 4:
		    strMenu = "e";
		    break;
		case 5:
		    strMenu = "f";
		    break;
		case 6:
		    strMenu = "g";
		    break;
		case 7:
		    strMenu = "h";
		    break;
		case 8:
		    strMenu = "i";
		    break;
		case 9:
		    strMenu = "j";
		    break;
		default:
		    strMenu = "j";
		}

		// 메뉴저장
		aMenu.push(strMenu);

		var localMenuImgPath = __contextPath + "/img/area_"
			+ strMenu + "_off.gif";
		strHtml += "<li><a href='#'><span id='area-menutxt-"+ index +"-"+strMenu+"' class='area-menu-text'>"+ obj.FESTIVAL_HALL_NM  +"</span><img id='area-menu-"+ index +"-" + strMenu
			+ "' src='" + localMenuImgPath + "' /></a></li>";
	    });

    $("#mainList").append(strHtml);

    // ------------------------------------------------
    // 이벤트 세팅
    // ------------------------------------------------
    setMainPageEvent();

    // 처음 메뉴 미리선택
    var menuName = "#area-menu-0-" + aMenu[0];
    $(menuName).click();

	
	//-----------------------------------------------------------
	// 우측메뉴 처리
	//-----------------------------------------------------------
/*	document.oncontextmenu=RightMouseDown;
	document.onmousedown = mouseDown; 
	function RightMouseDown() { return false; }	
	function mouseDown(e) {
	    if (e.which==3) {//righClick
		// 삭제모드일 경우에만.
		 if(__settings.mode == "d"){
        		console.log( "선택된 obj :: " + __settings.currentObj );
        		
        		if(  __settings.currentObj != "none" ){
        			var objName = "." + __settings.currentObj;
        			var shapes = __settings.stage.get( objName );
        
        			//shapes.apply('setWidth', 0);
        			//shapes.apply('setHidth', 0);
        			shapes.apply("hide",true);
        			
        			__settings.routeLayer.draw();
        			__settings.imageLayer.draw();
        			
        			//빌딩 데이터 제거
        			$.each(__settings.buildPosCd, function(index, value) {
        			    if ( value[0] ==  __settings.currentObj ){
        				removeByIndex( __settings.buildPos, index);
        				removeByIndex( __settings.buildPosCd, index);
        			    }
        			});

        			
        		}
		 }
	    }
	}*/

};



// 건물데이터를 담아둔다.
var scBuildingInfo = function(data){
	__settings.buildMetaInfo = data.list;
	
	var strHtml = "";
	$(data.list).each(function (index, obj) {
	    __settings.buildMetaInfo[index].SAVE_IMG_PATH = __contextPath+"/img/"+obj.SAVE_IMG_PATH;
	    strHtml += "<li><a href='#' onclick='RouteDraw.drawImgForStage(\""+index+"\");'><img src='"+obj.SAVE_IMG_PATH+"' /><font>"+obj.INST_NM+"</font></a></li>";
	});
	
	$("#imgBooth").append(strHtml);
};



// ----------------------------------------------------------------------------------
// Menu Event Listener
//----------------------------------------------------------------------------------
function setMainPageEvent() {
    // var aMenu = ["a","b","c","d","e","f","g","h"];
    // console.debug(  aMenu +"/"+ aMenu.length );
    
    for ( var i = 0; i < aMenu.length; i++) {
	// 구역 클릭
	var menuName = "#area-menu-"+i+"-" + aMenu[i];
	$(menuName).on('click', function(e) {
	    //
	    var m = $(this).attr('id').split('-')[2];
	    __settings.cmCD = __settings.menuList[m].FESTIVAL_CD;
	    __settings.cmHCD = __settings.menuList[m].FESTIVAL_HALL_CD;
	    
	    // 캔버스 및 데이터 초기화
	    RouteFunction.clearStageAndData();
	    
	    // 도로 불러오기
	    //var url ="/routedesign/api/routeByFcd/"+__settings.cmCD;
	    var url ="./result/smuSearch.jsp?pt=route&cd="+__settings.cmHCD;
	    fnGetApiData(url,function(data){
			// RouteData
			//__settings.routePosData = data.list;
			
			var __array = new Array();
			var __arrayCd = new Array();
			
			$(data.list).each(function (index, obj) {
				var tmpArray = new Array();
				
				var _tmpArray = new Array();
				_tmpArray.push( obj.START_POINT_X );
				_tmpArray.push( obj.START_POINT_Y );
				tmpArray.push(_tmpArray);
				
				_tmpArray = new Array();
				_tmpArray.push( obj.MID_POINT_X );
				_tmpArray.push( obj.MID_POINT_Y );
				tmpArray.push(_tmpArray);
				
				_tmpArray = new Array();
				_tmpArray.push( obj.END_POINT_X );
				_tmpArray.push( obj.END_POINT_Y );
				tmpArray.push(_tmpArray);
	
				__array.push( tmpArray );
				__arrayCd.push( obj.ROUTE_CD );
				
				//
				var ___array = new Array();
				___array.push( obj.ROUTE_CD );
				___array.push( __settings.cmCD );
				___array.push( __settings.cmHCD );
				___array.push( obj.ROUTE_WIDTH );
				___array.push( obj.ROUTE_COLOR );
				___array.push( obj.ROUTE_TYPE );
				___array.push( obj.START_POINT_X );
				___array.push( obj.START_POINT_Y );
				___array.push( obj.MID_POINT_X );
				___array.push( obj.MID_POINT_Y );
				___array.push( obj.END_POINT_X );
				___array.push( obj.END_POINT_Y );
				//------------------------------------------------
				// 13. 시작 Obj Name
				// 14. 종료 Obj Name
				//------------------------------------------------
				___array.push( obj.START_OBJ_CD );
				___array.push( obj.END_OBJ_CD );
				 
				__settings.routePosData.push(___array);
			});
			__settings.routePos = __array;
			__settings.routePosCd = __arrayCd; 
			
			console.debug( "--------------------------------------------------------------");
			console.debug( ">> routePos :: " + __settings.routePos );
			console.debug( ">> routePosCd :: " + __settings.routePosCd );
			console.debug( ">> routePosData :: " + __settings.routePosData );
			console.debug( "--------------------------------------------------------------");
			
			RouteData.loadRoute();
	    });
	    
	    // 빌딩 불러오기
	    //var url ="/routedesign/api/buildingByFcd/"+__settings.cmCD;
	    var url ="./result/smuSearch.jsp?pt=building&cd="+__settings.cmHCD;
	    fnGetApiData(url,function( data ){
			$(data.list).each(function (index, obj) {
			    RouteData.loadImg( obj );
			});
	    });
	    
	    // 구역 로드
	    resetArea();
	    var param = $(this).attr('id').split('-')[3];
	    setArea(param,m);	    
	});
	
	//
	var menuNameTxt = "#area-menutxt-"+i+"-"+ aMenu[i];
	$(menuNameTxt).on('click', function(e) {
	    //
	    var m = $(this).attr('id').split('-')[2];
	    __settings.cmCD = __settings.menuList[m].FESTIVAL_CD;
	    __settings.cmHCD = __settings.menuList[m].FESTIVAL_HALL_CD;
	    
	    // 캔버스 및 데이터 초기화
	    RouteFunction.clearStageAndData();
	    
	    // 도로 불러오기
	    //var url ="/routedesign/api/routeByFcd/"+__settings.cmCD;
	    var url ="./result/smuSearch.jsp?pt=route&cd="+__settings.cmHCD;
	    fnGetApiData(url,function(data){
			// RouteData
			//__settings.routePosData = data.list;
			
			var __array = new Array();
			var __arrayCd = new Array();
			
			$(data.list).each(function (index, obj) {
				var tmpArray = new Array();
				
				var _tmpArray = new Array();
				_tmpArray.push( obj.START_POINT_X );
				_tmpArray.push( obj.START_POINT_Y );
				tmpArray.push(_tmpArray);
				
				_tmpArray = new Array();
				_tmpArray.push( obj.MID_POINT_X );
				_tmpArray.push( obj.MID_POINT_Y );
				tmpArray.push(_tmpArray);
				
				_tmpArray = new Array();
				_tmpArray.push( obj.END_POINT_X );
				_tmpArray.push( obj.END_POINT_Y );
				tmpArray.push(_tmpArray);
	
				__array.push( tmpArray );
				__arrayCd.push( obj.ROUTE_CD );
				
				//
				var ___array = new Array();
				___array.push( obj.ROUTE_CD );
				___array.push( __settings.cmCD );
				___array.push( __settings.cmHCD );
				___array.push( obj.ROUTE_WIDTH );
				___array.push( obj.ROUTE_COLOR );
				___array.push( obj.ROUTE_TYPE );
				___array.push( obj.START_POINT_X );
				___array.push( obj.START_POINT_Y );
				___array.push( obj.MID_POINT_X );
				___array.push( obj.MID_POINT_Y );
				___array.push( obj.END_POINT_X );
				___array.push( obj.END_POINT_Y );
				//------------------------------------------------
				// 13. 시작 Obj Name
				// 14. 종료 Obj Name
				//------------------------------------------------
				___array.push( obj.START_OBJ_CD );
				___array.push( obj.END_OBJ_CD );
				 
				__settings.routePosData.push(___array);
			});
			__settings.routePos = __array;
			__settings.routePosCd = __arrayCd; 
			
			console.debug( "--------------------------------------------------------------");
			console.debug( ">> routePos :: " + __settings.routePos );
			console.debug( ">> routePosCd :: " + __settings.routePosCd );
			console.debug( ">> routePosData :: " + __settings.routePosData );
			console.debug( "--------------------------------------------------------------");
			
			RouteData.loadRoute();
	    });
	    
	    // 빌딩 불러오기
	    //var url ="/routedesign/api/buildingByFcd/"+__settings.cmCD;
	    var url ="./result/smuSearch.jsp?pt=building&cd="+__settings.cmHCD;
	    fnGetApiData(url,function( data ){
			$(data.list).each(function (index, obj) {
			    RouteData.loadImg( obj );
			});
	    });
	    
	    // 구역 로드
	    resetArea();
	    var param = $(this).attr('id').split('-')[3];
	    setArea(param,m);
	});	
	
    }

    // 전체메뉴
    $("#area-menu-all").on('click', function(e) {
	// 구역 로드
	resetArea();
	setArea("all");
	
	// 캔버스 및 데이터 초기화
	RouteFunction.clearStageAndData();
	
	// 전체구역을 로드한다.
	RouteData.loadAllArea(__settings.menuList);
    });
}


// 상단 메뉴 선택시 메뉴 활성화 부분
function setArea(strType, i) {
    if (strType == "all") {
	//
	$("#btnDelete").hide();
	$("#btnReset").hide();
	$("#tablist").hide();
	$("#tabcontentcontainer").hide();
	$("#saveForm #saveType").attr("value", "AllArea");
	$("#saveForm #fhCD").attr("value", __settings.cmHCD );
    } else {
	// 메뉴 리셋
	resetArea();
	//
	$("#btnDelete").show();
	$("#btnReset").show();
	$("#tablist").show();
	$("#tabcontentcontainer").show();	
	$("#saveForm #saveType").attr("value", "PartArea");
	$("#saveForm #fhCD").attr("value",  __settings.cmHCD);
	
	// 선택메뉴 활성화
	var menuArea = "#area-menu-" + i + "-" + strType;
	var submenuArea = "#area-sub-" + strType;
	var txtArea = "#area-txt-" + strType;
	
	console.log( menuArea );
	
	$(menuArea).attr("src", "../img/area_" + strType + "_on.gif");
	$(submenuArea).show(100);
	$(txtArea).show(100);
    }
}

// 상단 메뉴 선택시 전체메뉴 비활성화 부분
function resetArea() {
    // var aMenu = ["a","b","c","d","e","f","g","h"];
    for ( var i = 0; i < aMenu.length; i++) {
	var menuArea = "#area-menu-" + i + "-" + aMenu[i];
	var submenuArea = "#area-sub-" + aMenu[i];
	var txtArea = "#area-txt-" + aMenu[i];

	// console.log( ">> resetArea :: " + menuArea );

	$(menuArea).attr("src", "../img/area_" + aMenu[i] + "_off.gif");
	$(submenuArea).hide();
	$(txtArea).hide();
    }
}

//
function moveRightMenu(num) {
    var menuListVal = (parseInt($("#mainList").width()) + parseInt(num)) + "px";

    if (aMenu.length > 8) {
	$("#mainList").width(menuListVal);
	$("#menu").animate({
	    scrollLeft : menuListVal
	}, 'fast');
    } else {
	alert("항목이 8개 이상일때 움직입니다.", 3);
    }
}

function moveLeftMenu() {
    var leftPos = $('#menu').scrollLeft();
    $("#menu").animate({
	scrollLeft : leftPos - 80
    }, 'fast');
}

// 삭제메뉴
function menuDelete() {
    RouteFunction.deleteShape();
}

// 화면 초기화
function menuReset() {
    // 캔버스 및 데이터 초기화
    RouteFunction.clearStageAndData();
}

// 화면 저장
function menuSave() {
    // 캔버스 및 데이터 초기화
    // RouteFunction.clearStageAndData();

    // 데이터 세팅
    var buildInfo = new Array();
    var _saveType = $("#saveForm #saveType").attr("value");
    
    if (_saveType == "AllArea") {
	for (i = 0; i < __settings.buildPosCd.length; i++) {
	    buildInfo.push(__settings.buildPosCd[i][0]);
	    buildInfo.push(__settings.cmCD);

	    // buildInfo.push( __settings.cmHCD );
	    // buildInfo.push( __settings.buildPosCd[i][1] );

	    buildInfo.push(__settings.buildPos[i][0]);
	    buildInfo.push(__settings.buildPos[i][1]);
	}
    } else if (_saveType == "PartArea") {
	for (i = 0; i < __settings.buildPosCd.length; i++) {
	    buildInfo.push(__settings.buildPosCd[i][0]);
	    buildInfo.push(__settings.cmCD);
	    buildInfo.push(__settings.cmHCD);
	    buildInfo.push(__settings.buildPosCd[i][1]);
	    buildInfo.push(__settings.buildPos[i][0]);
	    buildInfo.push(__settings.buildPos[i][1]);
	}
    }

    //
    __settings.stage.toDataURL({
        callback: function(dataURL) {
            var re =/^data:image\/(png|jpg);base64,/;
            var re_after = "data:image/jpeg;base64,";
            dataURL = dataURL.replace(re, re_after);
            //window.open(dataURL);
            
            //__settings.imgData = dataURL;
            $("#saveForm #smu_imgData").attr("value", dataURL);
            $("#saveForm #smu_installation").attr("value", buildInfo);
            $("#saveForm #smu_route").attr("value", __settings.routePosData);
            
            $("#saveForm").submit();
            
        },
        mimeType: 'image/png',
        quality: 0.5    
    });
    
    /*
    //$("#saveForm #smu_imgData").attr("value", dataURLS);
    $("#saveForm #smu_installation").attr("value", buildInfo);
    $("#saveForm #smu_route").attr("value", __settings.routePosData);
    
    $("#saveForm").submit();
     */
}
