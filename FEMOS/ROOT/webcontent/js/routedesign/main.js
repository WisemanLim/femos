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

		cmCD : null,
		cmHCD : null,
		menuList : null,
		
		contMatrix : null,
		
		stage : null,
		loadStage : null,
		
		// dimensions
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
		
		// manage layout
		gridLayer : null,
		baseLayer : null,
		pointLayer : null,
		routeLayer : null,
		guideLayer : null,
		imageLayer : null,
		
		// 그리기 모드 설정
		// s : 선택모드  , r : 루트모드 , i : 이미지모드
		mode : "s",
		lineType : "01"
		
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
	RouteFunction.setEventGridPosition("on");

	//------------------------------------------------
	// 데이터를 담아둔다.
	//------------------------------------------------
	// 메뉴데이터
	//var url ="/routedesign/api/menuList";
	var url ="/FEMOS/webcontent/plan_layout/result/menuList.jsp"; 
	fnGetApiData(url,scMenuInfo);
	
	// 건물데이터
	//var url ="/routedesign/api/buildingList"; 
	var url ="/FEMOS/webcontent/plan_layout/result/buildingList.jsp"; 
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
		strHtml += "<li><a href='#'><img id='area-menu-"+ index +"-" + strMenu
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

};

// 건물데이터를 담아둔다.
var scBuildingInfo = function(data){
	__settings.buildMetaInfo = data.list;
	
	var strHtml = "";
	$(data.list).each(function (index, obj) {
	    __settings.buildMetaInfo[index].SAVE_IMG_PATH = __contextPath+"/img/"+obj.SAVE_IMG_PATH;
	    strHtml += "<li><a href='#' onclick='RouteDraw.drawImg(\""+index+"\");'><img src='"+obj.SAVE_IMG_PATH+"' /><font>"+obj.INST_NM+"</font></a></li>";
	});
	
	$("#imgBooth").append(strHtml);
};



// ----------------------------------------------------------------------------------
// Menu Event Listener
//----------------------------------------------------------------------------------
function setMainPageEvent() {
    // var aMenu = ["a","b","c","d","e","f","g","h"];
    // //console.debug(  aMenu +"/"+ aMenu.length );
    
    for ( var i = 0; i < aMenu.length; i++) {
	// 구역 클릭
	var menuName = "#area-menu-"+i+"-" + aMenu[i];
	$(menuName).on('click', function(e) {
	    //
	    var m = $(this).attr('id').split('-')[2];
	    __settings.cmCD = __settings.menuList[m].FESTIVAL_CD;
	    __settings.cmHCD = __settings.menuList[m].FESTIVAL_HALL_CD;
	    
	    // 도로 불러오기
	    //var url ="/routedesign/api/routeByFcd/"+__settings.cmCD;
	    var url ="/FEMOS/webcontent/plan_layout/result/smuSearch.jsp?pt=route&cd="+__settings.cmHCD;
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
				___array.push( "" );
				___array.push( obj.START_POINT_X );
				___array.push( obj.START_POINT_Y );
				___array.push( obj.MID_POINT_X );
				___array.push( obj.MID_POINT_Y );
				___array.push( obj.END_POINT_X );
				___array.push( obj.END_POINT_Y );
				
				__settings.routePosData.push(___array);
			});
			__settings.routePos = __array;
			__settings.routePosCd = __arrayCd; 
			
			//console.debug( ">> " + __settings.routePosData );
			
			RouteData.loadRoute();
	    });
	    
	    // 빌딩 불러오기
	    //var url ="/routedesign/api/buildingByFcd/"+__settings.cmCD;
	    var url ="/FEMOS/webcontent/plan_layout/result/smuSearch.jsp?pt=building&cd="+__settings.cmHCD;
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
    });
}

//
function setArea(strType,i) {
    if (strType == "all") {
//	// var aMenu = ["a","b","c","d","e","f","g","h"];
//	for ( var i = 0; i < aMenu.length; i++) {
//	    var submenuArea = "#area-sub-" + aMenu[i];
//	    var txtArea = "#area-txt-" + aMenu[i];
//
//	    $(submenuArea).show((i * 150));
//	    $(txtArea).show((i * 150));
//	}
    } else {
	var menuArea = "#area-menu-"+ i +"-" + strType;
	var submenuArea = "#area-sub-" + strType;
	var txtArea = "#area-txt-" + strType;

	$(menuArea).attr("src", "../img/area_" + strType + "_on.gif");
	$(submenuArea).show(100);
	$(txtArea).show(100);
    }
}

//
function resetArea() {
    // var aMenu = ["a","b","c","d","e","f","g","h"];
    for ( var i = 0; i < aMenu.length; i++) {
	var menuArea = "#area-menu- "+ i +"-" + aMenu[i];
	var submenuArea = "#area-sub-" + aMenu[i];
	var txtArea = "#area-txt-" + aMenu[i];

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
    }else{
	alert( "항목이 8개 이상일때 움직입니다.",3);
    }
}

function moveLeftMenu() {
    var leftPos = $('#menu').scrollLeft();
    $("#menu").animate({
	scrollLeft : leftPos - 80
    }, 'fast');
}

// ----------------------------------------------------------------------------------
// Building Event Listener
// ----------------------------------------------------------------------------------

