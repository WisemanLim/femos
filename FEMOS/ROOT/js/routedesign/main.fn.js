/**
 * This file handles RouteDesign rendering and editor UI. It also
 * provides a simple API for setting RouteDesign size, colors and so on.
 *
 * Copyright (c) 2012 Anthony Kim(김재도), jaedoki@gmail.com
 */

var modeConfig = {
    _delete : function() {
	__settings.mode = "d";
	__settings.currentObj = "none";
	
	// 라인 이벤트 off
	RouteFunction.setEventGridPosition("off");
	// 라인 초기화
	lineConfig._resetSelect();
	lineConfig._resetColor();
	// 선택 초기화
	RouteDraw.resetLayerChildren();
    },
    _select : function() {
	__settings.mode = "s";
	__settings.currentObj = "none";
	
	// 라인 이벤트 off
	RouteFunction.setEventGridPosition("off");
	// 라인 초기화
	lineConfig._resetSelect();
	lineConfig._resetColor();
	// 선택 초기화
	RouteDraw.resetLayerChildren();
    },
    _construct : function() {
	__settings.mode = "c";
	__settings.currentObj = "none";
	
	// 라인 이벤트 off
	RouteFunction.setEventGridPosition("off");
	// 라인 초기화
	lineConfig._resetSelect();
	lineConfig._resetColor();
	// 선택 초기화
	RouteDraw.resetLayerChildren();
	RouteDraw.setImageLayerChildrenDnd("on");
    },
    _route : function() {
	
	if( __settings.buildPosCd.length < 2 ){
	    alert( "건물을 2개이상 위치시키지 않으면 루트를 그릴수 없습니다." );
	    return false;
	}
	
	__settings.mode = "r";
	__settings.currentObj = "none";
	
	// 라인 이벤트 on
	RouteFunction.setEventGridPosition("on");
	// 선택 초기화
	RouteDraw.resetLayerChildren();
	RouteDraw.setImageLayerChildrenDnd("off");
    }
};

var lineConfig = {
    _type : function(num) {
	//초기화
	this._resetSelect();
    
	// 라인 그리기 모드
	modeConfig._route();

	if (num == 1) {
	    // 라인
	    __settings.lineType = "01";
	    $("#lineConfig1").attr("style","background-color:yellow");
	    this._color(1);
	}
	if (num == 2) {
	    // 대쉬
	    __settings.lineType = "02";
	    $("#lineConfig2").attr("style","background-color:yellow");
	}
	if (num == 3) {
	    // 대쉬
	    __settings.lineType = "03";
	    $("#lineConfig3").attr("style","background-color:yellow");
	}
	if (num == 4) {
	    // 대쉬
	    __settings.lineType = "04";
	    $("#lineConfig4").attr("style","background-color:yellow");
	}
    },

    _color : function(num) {
	//초기화
	this._resetColor();
	
	// 라인 그리기 모드
	modeConfig._route();

	if (num == 1) {
	    __settings.routeColor = "#000000";
	    $("#lineColor1").attr("style","background-color:yellow");
	}
	if (num == 2) {
	    __settings.routeColor = "#A6A6A6";
	    $("#lineColor2").attr("style","background-color:yellow");
	}
	if (num == 3) {
	    __settings.routeColor = "#FF0000";
	    $("#lineColor3").attr("style","background-color:yellow");
	}
	if (num == 4) {
	    __settings.routeColor = "#22DC44";
	    $("#lineColor4").attr("style","background-color:yellow");
	}
	if (num == 5) {
	    __settings.routeColor = "#2085DF";
	    $("#lineColor5").attr("style","background-color:yellow");
	}
	if (num == 6) {
	    __settings.routeColor = "#A020DF";
	    $("#lineColor6").attr("style","background-color:yellow");
	}
    },

    _delete : function() {

    },
    
    _resetSelect : function(){
	    $("#lineConfig1").attr("style","background-color:white");
	    $("#lineConfig2").attr("style","background-color:white");
	    $("#lineConfig3").attr("style","background-color:white");
	    $("#lineConfig4").attr("style","background-color:white");
    },
    
    _resetColor : function(){
	    $("#lineColor1").attr("style","background-color:white");
	    $("#lineColor2").attr("style","background-color:white");
	    $("#lineColor3").attr("style","background-color:white");
	    $("#lineColor4").attr("style","background-color:white");
	    $("#lineColor5").attr("style","background-color:white");
	    $("#lineColor6").attr("style","background-color:white");
    }    
};

var RouteFunction = {

    // ----------------------------------------------------------------------------------
    // Function Area
    // ----------------------------------------------------------------------------------
    setEventGridPosition : function(mode) {

	//console.debug("xPos :: " + __settings.xPos);

	if (mode == "on") {

	    $("#container").on('click', function(e) {
		// //console.debug("- 싱글클릭 -");
		RouteFunction.getPosition(e, __settings);
	    });

	    // 우클릭시 저장 데이터는 clean
	    $("#container").rightClick(function(e) {
		// //console.debug("- 우클릭 -");
		RouteFunction.stopPosition(__settings);
	    });

	} else if (mode == "off") {
	    // //console.debug("- 우클릭 -");
	    $("#container").off();
	    RouteFunction.stopPosition(__settings);
	}
    },
    
    //----------------------------------------------------------------------------------
    // :: Get Position
    //----------------------------------------------------------------------------------
    getPosition : function(event, gc) {
	var x = new Number();
	var y = new Number();

	// Stage를 활용한 Position 체크
	var mousePos = gc.stage.getMousePosition();
	x = mousePos.x;
	y = mousePos.y;

	// calculate grid square numbers
	var gx = Math.floor((x / parseInt(gc.cellSize)));
	var gy = Math.floor((y / parseInt(gc.cellSize)));

	// 선택하면 해당 그리드에 dot그리기
	var yPos = (gy * gc.cellSize) + gc.halfCellSize;
	var xPos = (gx * gc.cellSize) + gc.halfCellSize;

	//console.debug(">>>>> gx,gy :: " + gx + "," + gy);

	var oMatrix = gc.contMatrix;

	// 그리드 범위 체크
	if ((xPos < gc.stage.getWidth()) && (yPos < gc.stage.getHeight())) {
	    
	    // Obj를 선택해야만 선이 그려져야 하므로
	    if( gc.tmpPosObj.length > 0 ){
		    // 그리드 선택시 true설정(임시)
		    oMatrix[gy][gx] = true;
		    // console.debug(xPos + "," + yPos);

		    // dot위치를 배열에 담아둔다.
		    var pArray = [ xPos, yPos ];
		    gc.tmpPos.push(pArray);

		    if (gc.tmpPosObj.length == 2) {
			RouteDraw.drawLine(gc);
		    }
	    }
	    
	    // 그리드 위치
	    // console.debug("xy: " + x + "," + y + " / gn xy: " + gx + ","+ gy);
	}


	// ------------------------
	// 데이터저장 및 로드
	// ------------------------
	// var json = gc.stage.toJSON();

	// 기타저장은 haspMap을 사용하여 저장.
	// 맵은 파일로 저장하고
	// 이벤트는 hashMap을 기반으로 다시 add
	// //console.debug(json);
	// loadStage.load(json);
    },
    
    //----------------------------------------------------------------------------------
    // :: Get Position with Curve
    //----------------------------------------------------------------------------------
    getPositionWithCurve : function(event, gc) {
	var x = new Number();
	var y = new Number();

	// Stage를 활용한 Position 체크
	var mousePos = gc.stage.getMousePosition();
	x = mousePos.x;
	y = mousePos.y;

	// calculate grid square numbers
	var gx = Math.floor((x / parseInt(gc.cellSize)));
	var gy = Math.floor((y / parseInt(gc.cellSize)));

	// 선택하면 해당 그리드에 dot그리기
	var yPos = (gy * gc.cellSize) + gc.halfCellSize;
	var xPos = (gx * gc.cellSize) + gc.halfCellSize;

	//console.debug(">>>>> gx,gy :: " + gx + "," + gy);

	var oMatrix = gc.contMatrix;
	// 이미 선택된 그리드 선택시
	if (oMatrix[gy][gx]) {
	    // 그리드 범위 체크
            //	    if ((xPos < gc.stage.getWidth()) && (yPos < gc.stage.getHeight())) {
            //		RouteDraw.drawAnchor(xPos, yPos, gc);
            //		// 대쉬라인
            //		RouteDraw.drawLine(gc);
            //	    }
	} else {
	    // 그리드 범위 체크
	    if ((xPos < gc.stage.getWidth()) && (yPos < gc.stage.getHeight())) {
		// 그리드 선택시 true설정(임시)
		oMatrix[gy][gx] = true;
		//console.debug(xPos + "," + yPos);

		// dot위치를 배열에 담아둔다.
		var pArray = [ xPos, yPos ];
		gc.tmpPos.push(pArray);

		//console.debug( ">> gc.tmpPos : " + gc.tmpPos +"/"+ gc.tmpPos.length );
		//console.debug( ">> gc.routePos : " + gc.routePos +"/"+ gc.routePos.length );

		if (gc.tmpPos.length > 2) {

		    var pLength = gc.tmpPos.length;
		    // //console.debug( "pLength :: " + pLength );
		    // //console.debug("성공!!" + gc.tmpPos[pLength - 2][0] + "," + xPos);
		    // //console.debug("성공!!" + gc.tmpPos[pLength - 2][1] + "," + yPos);

		    var a = gc.tmpPos[pLength - 3];
		    var b = gc.tmpPos[pLength - 2];
		    var c = gc.tmpPos[pLength - 1];

		    var angleVal = parseInt(getAngleValue(a[0], a[1], b[0],
			    b[1], c[0], c[1]), 10);

		    //alert("angleVal :: " + angleVal + " / " + gc.lineMode);

		    // 0도나 180도가 아니면 곡선 그리기
		    var numError = 20;
		    if (((angleVal > (180 - numError)) && (angleVal < (180 + numError)))
			    || (angleVal < (0 + numError))) {
			RouteDraw.drawAnchor(xPos, yPos, gc);
			RouteDraw.drawLine(gc);
		    } else {
			// 같은곳을 클릭시
			//console.debug(">>>>>> abcd :: " + b[0] + "," + c[0]+ "," + b[1] + "," + c[1]);

			if ((b[0] == c[0]) && (b[1] == c[1])) {
			    RouteDraw.drawAnchor(xPos, yPos, gc);
			    RouteDraw.drawLine(gc);
			} else {
			    RouteDraw.drawAnchorRedDash(xPos, yPos, gc);
			    RouteDraw.drawLineDash(gc);
			}

			// 커브모드면 커브를 시작
			if (gc.lineMode == "Curve") {
			    RouteDraw.drawLineCurve(gc);
			}
		    }
		} else {
		    RouteDraw.drawAnchor(xPos, yPos, gc);

		    // dot위치를 배열이 2보다 크면 라인을 그리기 시작
		    if (gc.tmpPos.length > 1) {
			RouteDraw.drawLine(gc);
		    }
		}

		// 그리드 위치
		//console.debug("xy: " + x + "," + y + " / gn xy: " + gx + ","+ gy);
	    }
	}

	// ------------------------
	// 데이터저장 및 로드
	// ------------------------
	// var json = gc.stage.toJSON();

	// 기타저장은 haspMap을 사용하여 저장.
	// 맵은 파일로 저장하고
	// 이벤트는 hashMap을 기반으로 다시 add
	// //console.debug(json);
	// loadStage.load(json);
    },

    //----------------------------------------------------------------------------------
    // 포지션 데이터 리셋
    //----------------------------------------------------------------------------------
    stopPosition : function(gc) {
	gc.tmpPos = [];
	gc.tmpPosObj = [];
	
	// Clear Children Node
	gc.pointLayer.clear();
	gc.pointLayer.removeChildren();
    },

    reset : function() {
	__settings.tmpPos = [];
	__settings.tmpPosObj = [];
	
	// Clear Children Node
	__settings.pointLayer.clear();
	__settings.pointLayer.removeChildren();
	__settings.routeLayer.clear();
	__settings.routeLayer.removeChildren();
    },
    
    clearStageAndData : function() {
	// Canvas Clear
	__settings.pointLayer.clear();
	__settings.pointLayer.removeChildren();
	__settings.imageLayer.clear();
	__settings.imageLayer.removeChildren();	
	__settings.routeLayer.clear();
	__settings.routeLayer.removeChildren();
	
	// Array Clear	
	__settings.tmpPos = [];
	__settings.tmpPosObj = [];

	__settings.buildPos = [];
	__settings.buildPosCd = [];

	__settings.routePos = [];
	__settings.routePosCd = [];
	__settings.routePosData = [];
	
	__settings.currentObj = "none";
    },
    
    //----------------------------------------------------------------------------------
    // :: Rect
    // 선택된 그리드 색칠함
    //----------------------------------------------------------------------------------
    fill : function(s, gx, gy, gc) {

	var rectLayer = new Kinetic.Layer();
	var iLineSpacing = parseInt(gc.cellSize);

	var config = {
	    x : 0,
	    y : 0,
	    width : 0,
	    height : 0,
	    fill : "#000000",
	    stroke : "black",
	    strokeWidth : 1
	};

	config.fill = s;
	config.x = parseInt(gx * iLineSpacing);
	config.y = parseInt(gy * iLineSpacing);
	config.width = iLineSpacing;
	config.height = iLineSpacing;
	var rect = new Kinetic.Rect(config);

	// add the shape to the layer
	rectLayer.add(rect);
	gc.stage.add(rectLayer);
    },
    
    //----------------------------------------------------------------------------------
    // 선택된 Shape 삭제 및 데이터 삭제
    //----------------------------------------------------------------------------------
    deleteShape : function(){
	
	if(( __settings.currentObj == "none" ) && ( __settings.currentObj == "" )) {
	    return false;
	}
	
	var objName = "." + __settings.currentObj;
	var shapes = __settings.stage.get(objName);

	shapes.apply('setWidth', 0);
	shapes.apply('setHidth', 0);
	shapes.apply("hide", true);

	__settings.routeLayer.draw();
	__settings.imageLayer.draw();
	
	//------------------------------------------------
	// 데이터 삭제
	//------------------------------------------------
	// 1. 루트일경우 (ROU)
	// 2. 도형일경우 (OBJ)
	//------------------------------------------------
	var statusType = objName.substr(1,3);
	if(statusType == "OBJ"){

	    // 빌딩 데이터 제거
	    $.each(__settings.buildPosCd, function(index, value) {
		if( value != undefined ){
		    console.log( ">>OBJ -- value[0] :: " + value[0] );
		    
			if (value[0].toString() == __settings.currentObj.toString()) {
			    removeByIndex(__settings.buildPos, index);
			    removeByIndex(__settings.buildPosCd, index);
			}			    
		} 
	    });

	    // 관련된 라인 전부 제거
	    var tmpData = new cloneObject( __settings.routePosData );
	    $.each(tmpData, function(idx, value) {
		
		if (value != undefined) {
		    
		    console.log(value[12] + "/" + value[13]);
		    console.log(__settings.currentObj);
		    
		    if (value[12] == __settings.currentObj) {

			console.log(">>> value[12]");

			var objName = "." + value[0];
			var shapes = __settings.stage.get(objName);
			shapes.apply("hide", true);
			__settings.routeLayer.draw();
			__settings.imageLayer.draw();
			
			delete __settings.routePosData[ idx ];
			//removeByIndex(__settings.routePosData, idx);

			console.log(">>> objName :: " + objName);
			console.debug(">>> drawLine :: " + __settings.routePosData);
			console.debug(">>> drawLine-length :: " + __settings.routePosData.length);

		    } else if (value[13] == __settings.currentObj) {

			console.log(">>> value[13]");

			var objName = "." + value[0];
			var shapes = __settings.stage.get(objName);
			shapes.apply("hide", true);
			__settings.routeLayer.draw();
			__settings.imageLayer.draw();

			delete __settings.routePosData[ idx ];
			//removeByIndex(__settings.routePosData, idx);
			
			console.log(">>> objName :: " + objName);
			console.debug(">>> drawLine :: " + __settings.routePosData);
			console.debug(">>> drawLine-length :: " + __settings.routePosData.length);
		    }
		}
	    });
	    
	    //clean array
	    __settings.routePosData = __settings.routePosData.filter(Boolean);

	    //console.log(" CLEAN ---------------------------------");
	    //console.debug(">>> drawLine :: " + __settings.routePosData);
	    //console.debug(">>> drawLine-length :: " + __settings.routePosData.length);
	     
	}else if(statusType == "ROU"){
	    // 라인 데이터 제거
	    $.each(__settings.routePosData, function(index, value) {
		console.log( ">>ROU -- value[0] :: " + value[0] );
		if (value != undefined) {
		    if (value[0] == __settings.currentObj) {
			removeByIndex(__settings.routePosData, index);
		    }
		}
	    });
	    
	    console.debug(">>> drawLine :: " + __settings.routePosData);
	    console.debug(">>> drawLine-length :: " + __settings.routePosData.length);
	}
	
	// 초기화 세팅
	__settings.currentObj = "none";
    }

};

var RouteData = {

    // ------------------------------------------------------------------------
    // 데이터 로드
    // ------------------------------------------------------------------------
    loadRoute : function() {
	// Clear Children Node
	// __settings.routeLayer.clear();
	// __settings.routeLayer.removeChildren();
	// //console.debug( ">> loadRoute :: " + __settings.routePos );

	$.each(__settings.routePos, function(index, value) {
	    if ((value[1][0] == "null") || (value[1][0] == "0")) {
		// 라인모드
		//console.log( "라인모드 호출----------------" );
		RouteData.loadLine( value, __settings.routePosCd[index], __settings.routePosData[index][5], __settings.routePosData[index][4], __settings.routePosData[index][3] );
	    } else {
		// 커브모드
		//console.log( "커브모드 호출----------------" );
		RouteData.loadLineCurve(value);
	    }
	});
    },

    loadBuilding : function() {
	$.each(__settings.buildPos, function(index, value) {
	    RouteData.drawImgData(value);
	});
    },

    // ----------------------------------
    // :: line
    // 선택된 그리드 색칠함(로드용)
    // ----------------------------------
    loadLineCurve : function(_array) {

	var gc = __settings;

	// ------------------------------
	// 배열에서 포인트를 빼온다
	// ------------------------------
	var pCurvePoint = new Array();
	var pStart = new Array();
	var pEnd = new Array();

	pStart = _array[0];
	pCurvePoint = _array[1];
	pEnd = _array[2];

	//
	var routeLineCurve = new Kinetic.Curve({
	    points : [ pStart[0], pStart[1], pCurvePoint[0], pCurvePoint[1],
		    pEnd[0], pEnd[1] ],
	    stroke : gc.routeColor,
	    strokeWidth : parseInt(gc.strokeWidth),
	    lineCap : "round",
	    lineJoin : "round",
	    id : "routeLine"
	});

	gc.lineMode = "Curve";
	gc.routeLayer.add(routeLineCurve);

	// 레이어 다시 그리기
	gc.routeLayer.draw();
    },

    // ----------------------------------
    // :: line
    // 선택된 그리드 색칠함
    // ----------------------------------
    loadLine : function(_array,oName,oType,oColor,oStrokeWidth) {

	var gc = __settings;

	console.debug( " ------------------------------------------------------------------------------");
	console.debug( " >> loadLine array :: " +oStrokeWidth+"/" +oColor+"/" +oName+"/"+oType+"/"+ _array);
	console.debug( " ------------------------------------------------------------------------------");
	
	// ------------------------------
	// 배열에서 포인트를 빼온다
	// ------------------------------
	var pStart = new Array();
	var pEnd = new Array();

	pStart = _array[0];
	pEnd = _array[2];
	// ------------------------------
	// console.debug( pStart + "," + pEnd);

	var routeLine;
	if (oType == "01") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : oColor,
		strokeWidth : parseInt(oStrokeWidth),
		lineCap : "round",
		lineJoin : "round",
		name : oName
	    });
	} else if (oType == "02") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : oColor,
		strokeWidth : parseInt(oStrokeWidth),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 10, 10 ],
		name : oName
	    });
	} else if (oType == "03") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : oColor,
		strokeWidth : parseInt(oStrokeWidth),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 20, 20 ],
		name : oName
	    });
	} else if (oType == "04") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : oColor,
		strokeWidth : parseInt(oStrokeWidth),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 30, 30 ],
		name : oName
	    });
	} else {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : oColor,
		strokeWidth : parseInt(oStrokeWidth),
		lineCap : "round",
		lineJoin : "round",
		name : oName
	    });
	}
	
	//-----------------------------------------------------
	//
	//-----------------------------------------------------
	routeLine.on("click", function() {
	    __settings.currentObj = this.getName();
	    
	    if (__settings.currentObj != "none") {
		// 서택된 루트라인 초기화
		RouteDraw.resetLayerChildren();
		
		//
		var objName = "." + __settings.currentObj;
		var shapes = __settings.routeLayer.get(objName);
		shapes.apply("setOpacity", 0.5);
		__settings.routeLayer.draw();
		
		console.log("--------------------------------------------------------------");
		console.log(">> routeLine click - mode(r) :: " + __settings.currentObj );
		console.log("--------------------------------------------------------------");
	    }
	});

	//-----------------------------------------------------
	//
	//-----------------------------------------------------
	routeLine.on("mouseover", function() {
	    document.body.style.cursor = "pointer";
	    //__settings.currentObj = this.getName();

	    console.debug(">>> drawLine :: " + gc.routePosData);
	    console.debug(">>> drawLine-length :: " + gc.routePosData.length);	    
	});

	//-----------------------------------------------------
	//
	//-----------------------------------------------------
	routeLine.on("mouseout", function() {
	    document.body.style.cursor = "default";
	    //__settings.currentObj = "none";
	});	
	
	gc.lineMode = "Line";
	gc.routeLayer.add(routeLine);

	// 레이어 다시 그리기
	gc.routeLayer.draw();
    },
    
    //--------------------------------------------------------------------
    // 건물(시설물) 이미지를 로드한다
    //--------------------------------------------------------------------
    loadImg : function(_obj) {

	// 이미지 모드
	modeConfig._construct();

	var gc = __settings;
	var objCd = _obj.OBJ_CD;
	var imgUrl = __contextPath + "/img/" + _obj.SAVE_IMG_PATH;
	//console.debug(imgUrl);

	var imageObj = new Image();

	imageObj.onload = function() {
	};
	imageObj.src = imgUrl;

	//console.debug(_obj.INST_SIZE);

	var imgRect = new Kinetic.Rect({
	    x : parseInt(_obj.INST_X),
	    y : parseInt(_obj.INST_Y),
	    width : parseInt(_obj.INST_SIZE),
	    height : parseInt(_obj.INST_SIZE),
	    fill : {
		image : imageObj
	    },
	    draggable : true,
	    dragBounds : {
		top : 0,
		right : (gc.stage.getWidth() - parseInt(_obj.INST_SIZE)),
		bottom : (gc.stage.getHeight() - parseInt(_obj.INST_SIZE)),
		left : 0
	    },
	    name : objCd
	});

	var __array = new Array();
	__array.push(_obj.INST_X);
	__array.push(_obj.INST_Y);
	gc.buildPos.push(__array);
	
	var __arrayCd = new Array();
	__arrayCd.push(_obj.OBJ_CD);
	__arrayCd.push(_obj.INST_CD);
	gc.buildPosCd.push(__arrayCd);
	
	//-------------------------------------------------------------------
	// add styling
	//-------------------------------------------------------------------
	imgRect.on("click", function(evt) {
	    __settings.currentObj = this.getName();
	    
	    console.log( "<< currentObj :: " + __settings.currentObj +"/ this.getName :: "+ this.getName());
	    
	    // Set Styling
	    if (__settings.mode == "r") {
		//
		this.setStroke('blue');
		this.setStrokeWidth(5);
		__settings.imageLayer.draw();
		
		//
		__settings.tmpPosObj.push(this.getName());
		
		console.log("--------------------------------------------------------------");
		console.log(">> imgRect click - mode(r) :: " + __settings.tmpPosObj);
		console.log("--------------------------------------------------------------");
	    } else {
		// 선택 초기화
		RouteDraw.resetLayerChildren();
		
		console.log("--------------------------------------------------------------");
		console.log( ">> currentObj :: " + __settings.currentObj +"/ this.getName :: "+ this.getName());
		console.log("--------------------------------------------------------------");
		
		//
		this.setStroke('red');
		this.setStrokeWidth(5);
		__settings.imageLayer.draw();
	    }
	    
	    // console.log( this.getName() + " :: " + this.getX() + "/" + this.getY() );
	    // console.log( __settings.mode );

	    
	    // 삭제모드일 경우에만.
	    if (__settings.mode == "d") {
		console.log("선택된 obj :: " + __settings.currentObj);
		
		if (__settings.currentObj != "none") {
		    var objName = "." + __settings.currentObj;
		    var shapes = __settings.stage.get(objName);
		    
		    // Event remove
		    //shapes.off("mouseout");
		    //shapes.off("mouseover");
		   
		    shapes.apply("hide", true);
		    __settings.routeLayer.draw();
		    __settings.imageLayer.draw();
		    
		    // 빌딩 데이터 제거
		    $.each(__settings.buildPosCd, function(index, value) {
			console.log( ">> value :: " + value );
			if( value != undefined ){
				if ( value[0].toString() == __settings.currentObj.toString() ) {
				    removeByIndex(__settings.buildPos, index);
				    removeByIndex(__settings.buildPosCd, index);
				}			    
			} 
		    });
		    
		}
	    }	    
	});
	
	imgRect.on("mouseover", function() {
	    document.body.style.cursor = "pointer";
	    //__settings.currentObj = this.getName();
	});

	imgRect.on("mouseout", function() {
	    document.body.style.cursor = "default";

	    var objName = this.attrs.name;
	    var posX = this.attrs.x;
	    var posY = this.attrs.y;

	    $.each(__settings.buildPosCd, function(index, value) {
		if (value != undefined) {
		    if (value[0] === objName) {
			var __array = new Array();
			__array.push(posX);
			__array.push(posY);
			gc.buildPos[index] = __array;
		    }
		}
	    });

	    console.debug(gc.buildPos);
	    console.debug(gc.buildPosCd);
	});

	gc.imageLayer.add(imgRect);
	gc.imageLayer.draw();
	
    },
    
    //--------------------------------------------------------------------
    // 전체 메뉴(구역)를 로드한다
    //--------------------------------------------------------------------
    loadAllArea : function( __menuData ){
	// 이미지 모드
	modeConfig._construct();
	
	$(__menuData).each(function(index, obj) {
	    RouteData.loadAreaBase( obj );
	});
    },
    
    // --------------------------------------------------------------------
    // 구역을 로드한다
    //--------------------------------------------------------------------
    loadAreaBase : function(_obj) {

	var gc = __settings;
	var objCd = _obj.FESTIVAL_HALL_CD;
	//var imgUrl = __contextPath + "/plan_layout/upload/" + _obj.SAVE_IMG_PATH;
	var imgUrl =  "./upload/" + _obj.SAVE_IMG_PATH;
	
	console.log("loadAreaBase --------------------------------");
	console.log(">> imgUrl :: " + imgUrl + "/" + _obj.FESTIVAL_HALL_NM);
	console.log("-------------------------------------------------");

	var imgRect;
	//if( _obj.SAVE_IMG_PATH == null ){
	        imgRect = new Kinetic.Text({
		    x : parseInt(_obj.MAP_X),
		    y : parseInt(_obj.MAP_Y),
	            stroke: '#555',
	            strokeWidth: 5,
	            fill: '#ddd',
	            text: _obj.FESTIVAL_HALL_NM,
	            fontSize: 14,
	            fontFamily: 'Calibri',
	            textFill: '#555',
	            width : (parseInt(_obj.GRID_WIDTH) / 6),
	            height : (parseInt(_obj.GRID_HEIGHT) / 6),
	            padding: 30,
	            align: 'center',
	            valign: 'middle',
	            fontStyle: 'bold',
	            shadow: {
	              color: 'black',
	              blur: 1,
	              offset: [10, 10],
	              opacity: 0.2
	            },
	            cornerRadius: 10,
		    draggable : true,
		    dragBounds : {
			top : 0,
			right : (gc.stage.getWidth() - parseInt(_obj.GRID_CELL_SIZE)),
			bottom : (gc.stage.getHeight() - parseInt(_obj.GRID_CELL_SIZE)),
			left : 0
		    },
		    name : objCd	            
	          });
	//}else{
	        /*
		var imageObj = new Image();

		imageObj.onload = function() {
		};
		imageObj.src = imgUrl;
		
		console.log(">> imgUrl :: " + imgUrl );
		
		imgRect = new Kinetic.Rect({
		    x : parseInt(_obj.MAP_X),
		    y : parseInt(_obj.MAP_Y),
		    width : (parseInt(_obj.GRID_WIDTH) / 3),
		    height : (parseInt(_obj.GRID_HEIGHT) / 3),
		    fill : {
			image : imageObj
		    },
		    draggable : true,
		    dragBounds : {
			top : 0,
			right : (gc.stage.getWidth() - parseInt(_obj.GRID_CELL_SIZE)),
			bottom : (gc.stage.getHeight() - parseInt(_obj.GRID_CELL_SIZE)),
			left : 0
		    },
		    name : objCd
		});
		*/
	//}

	var __array = new Array();
	__array.push(_obj.MAP_X);
	__array.push(_obj.MAP_Y);
	gc.buildPos.push(__array);
	
	var __arrayCd = new Array();
	__arrayCd.push(_obj.FESTIVAL_HALL_CD);
	__arrayCd.push(_obj.FESTIVAL_CD);
	gc.buildPosCd.push(__arrayCd);
	
	//-------------------------------------------------------------------
	// add styling
	//-------------------------------------------------------------------
	/*
	imgRect.on("click", function(evt) {
	    __settings.currentObj = this.getName();
	    
	    console.log( "<< currentObj :: " + __settings.currentObj +"/ this.getName :: "+ this.getName());
	    
	    // Set Styling
	    if (__settings.mode == "r") {
		//
		this.setStroke('blue');
		this.setStrokeWidth(5);
		__settings.imageLayer.draw();
		
		//
		__settings.tmpPosObj.push(this.getName());
		
		console.log("--------------------------------------------------------------");
		console.log(">> imgRect click - mode(r) :: " + __settings.tmpPosObj);
		console.log("--------------------------------------------------------------");
	    } else {
		// 선택 초기화
		RouteDraw.resetLayerChildren();
		
		console.log("--------------------------------------------------------------");
		console.log( ">> currentObj :: " + __settings.currentObj +"/ this.getName :: "+ this.getName());
		console.log("--------------------------------------------------------------");
		
		//
		this.setStroke('red');
		this.setStrokeWidth(5);
		__settings.imageLayer.draw();
	    }
	    
	    // console.log( this.getName() + " :: " + this.getX() + "/" + this.getY() );
	    // console.log( __settings.mode );

	    
	    // 삭제모드일 경우에만.
	    if (__settings.mode == "d") {
		console.log("선택된 obj :: " + __settings.currentObj);
		
		if (__settings.currentObj != "none") {
		    var objName = "." + __settings.currentObj;
		    var shapes = __settings.stage.get(objName);
		    
		    // Event remove
		    //shapes.off("mouseout");
		    //shapes.off("mouseover");
		   
		    shapes.apply("hide", true);
		    __settings.routeLayer.draw();
		    __settings.imageLayer.draw();
		    
		    // 빌딩 데이터 제거
		    $.each(__settings.buildPosCd, function(index, value) {
			console.log( ">> value :: " + value );
			if( value != undefined ){
				if ( value[0].toString() == __settings.currentObj.toString() ) {
				    removeByIndex(__settings.buildPos, index);
				    removeByIndex(__settings.buildPosCd, index);
				}			    
			} 
		    });
		    
		}
	    }	    
	});
	*/
	
	imgRect.on("mouseover", function() {
	    document.body.style.cursor = "pointer";
	    //__settings.currentObj = this.getName();
	});

	imgRect.on("mouseout", function() {
	    document.body.style.cursor = "default";

	    var objName = this.attrs.name;
	    var posX = this.attrs.x;
	    var posY = this.attrs.y;

	    $.each(__settings.buildPosCd, function(index, value) {
		if (value != undefined) {
		    if (value[0] === objName) {
			var __array = new Array();
			__array.push(posX);
			__array.push(posY);
			gc.buildPos[index] = __array;
		    }
		}
	    });

	    console.debug(gc.buildPos);
	    console.debug(gc.buildPosCd);
	});

	gc.imageLayer.add(imgRect);
	gc.imageLayer.draw();
	
    },
    
    //--------------------------------------------------------------------
    //
    //--------------------------------------------------------------------
    loadImg_old : function(_obj) {

	// Stop Line mode
	RouteFunction.setEventGridPosition("off");

	// 이미지 모드
	__settings.mode = "i";

	var gc = __settings;
	var objCd = _obj.OBJ_CD;
	var imgUrl = __contextPath + "/img/" + _obj.SAVE_IMG_PATH;
	//console.debug(imgUrl);

	var imageObj = new Image();

	imageObj.onload = function() {
	};
	imageObj.src = imgUrl;

	//console.debug(_obj.INST_SIZE);

	var imgRect = new Kinetic.Rect({
	    x : parseInt(_obj.INST_X),
	    y : parseInt(_obj.INST_Y),
	    width : parseInt(_obj.INST_SIZE),
	    height : parseInt(_obj.INST_SIZE),
	    fill : {
		image : imageObj
	    },
	    draggable : true,
	    dragBounds : {
		top : 0,
		right : (gc.stage.getWidth() - parseInt(_obj.INST_SIZE)),
		bottom : (gc.stage.getHeight() - parseInt(_obj.INST_SIZE)),
		left : 0
	    },
	    name : objCd
	});

	//console.debug(_obj.INST_X);

	// add styling
	imgRect.on("mouseover", function() {
	    document.body.style.cursor = "pointer";
	    this.setStrokeWidth(1);
	    __settings.imageLayer.draw();

	    // 선택모드
	    __settings.mode = "s";
	});

	imgRect.on("mouseout", function() {
	    document.body.style.cursor = "default";
	    this.setStrokeWidth(0);
	    __settings.imageLayer.draw();

	    var objName = this.attrs.name;
	    var posX = this.attrs.x;
	    var posY = this.attrs.y;

	    $.each(__settings.buildPosCd, function(index, value) {
		if (value == objName) {
		    var __array = new Array();
		    __array.push(posX);
		    __array.push(posY);
		    gc.buildPos[index] = __array;
		}
	    });

	    //console.debug(this.attrs.x + "/" + this.attrs.y + "/" + this.attrs.name);
	    //console.debug(gc.buildPos);
	    //console.debug(gc.buildPosCd);

	    // 선택모드
	    __settings.mode = "s";
	});

	gc.imageLayer.add(imgRect);
	gc.imageLayer.draw();
    }

};

var RouteDraw = {
    // ----------------------------------
    // :: Matrix
    // 그리드를 생성한다.
    // ----------------------------------
    drawMatrix : function(gc) {

	numHorizontalLines = parseInt(gc.cntHorizontalLine);
	numVerticalLines = parseInt(gc.cntVerticalLine);

	// ----------------------------------
	// 그리드 라인 그리기(y축)
	// ----------------------------------
	for ( var i = 0; i <= numHorizontalLines; i++) {
	    gc.yPos = i * gc.cellSize;
	    var pointsY = [ 0, gc.yPos, gc.stage.getWidth(), gc.yPos ];

	    var yLine = new Kinetic.Line({
		points : pointsY,
		stroke : "#eeeeee",
		strokeWidth : 1,
		lineCap : "round",
		lineJoin : "round"
	    });

	    gc.gridLayer.add(yLine);
	}

	// ----------------------------------
	// 그리드 라인 그리기(x축)
	// ----------------------------------
	for ( var i = 0; i <= numVerticalLines; i++) {
	    gc.xPos = i * gc.cellSize;
	    var pointsX = [ gc.xPos, 0, gc.xPos, gc.stage.getHeight() ];

	    var xLine = new Kinetic.Line({
		points : pointsX,
		stroke : "#eeeeee",
		strokeWidth : 1,
		lineCap : "round",
		lineJoin : "round"
	    });

	    gc.gridLayer.add(xLine);
	}
    },

    // ----------------------------------
    // :: Anchor
    // 선택된 그리드 색칠함
    // ----------------------------------
    drawAnchor : function(x, y, gc) {

	var anchor = new Kinetic.Circle({
	    x : x,
	    y : y,
	    radius : 5,
	    stroke : "#666",
	    fill : "#ddd",
	    strokeWidth : 2,
	    name : "oAnchor"
	});

	// add hover styling
	/*
	 * anchor.on("mouseover", function() { document.body.style.cursor =
	 * "pointer"; this.setStrokeWidth(4); layer.draw(); });
	 * anchor.on("mouseout", function() { document.body.style.cursor =
	 * "default"; this.setStrokeWidth(2); layer.draw(); });
	 */

	gc.pointLayer.add(anchor);
	gc.pointLayer.draw();
    },

    // ----------------------------------
    // :: Anchor
    // 선택된 그리드 색칠함
    // ----------------------------------
    drawAnchorRedDash : function(x, y, gc) {

	var anchor = new Kinetic.Circle({
	    x : x,
	    y : y,
	    radius : 5,
	    stroke : "#666",
	    fill : "#FF5555",
	    strokeWidth : 2,
	    name : "oAnchor"
	});

	// add hover styling
	/*
	 * anchor.on("mouseover", function() { document.body.style.cursor =
	 * "pointer"; this.setStrokeWidth(4); layer.draw(); });
	 * anchor.on("mouseout", function() { document.body.style.cursor =
	 * "default"; this.setStrokeWidth(2); layer.draw(); });
	 */

	gc.pointLayer.add(anchor);
	gc.pointLayer.draw();
    },

    // ----------------------------------
    // :: line
    // 선택된 그리드 색칠함
    // ----------------------------------
    drawLine : function(gc) {

	// ------------------------------
	// 배열에서 포인트를 빼온다
	// ------------------------------
	var pArray = gc.tmpPos;
	var pObjArray = gc.tmpPosObj;
	var aLength = pArray.length;
	var pStart = new Array();
	var pEnd = new Array();

	//---------------------------------
	// 시작 Obj Name
	//pObjArray[0]
	// 종료 Obj Name
	//pObjArray[1]
	
	var shapes = __settings.imageLayer.getChildren();
	$.each(shapes, function(index, value) {
	    if (value != undefined) {
		// Start Obj
		if( value.getName() ==  pObjArray[0] ){
		    pStart.push( value.getX() );
		    pStart.push( value.getY() );		    
		}
		// End Obj
		if( value.getName() ==  pObjArray[1] ){
		    pEnd.push( value.getX() );
		    pEnd.push( value.getY() );		    
		}
	    }
	});

	// ------------------------------
	//console.debug(">> drawLine :: " + pStart + "," + pEnd + "/" + gc.routeColor );
	
	var lineID = "ROU" + __smuRMax;
	var routeLine;

	if (gc.lineType == "01") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		name : lineID
	    });
	} else if (gc.lineType == "02") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 10, 10 ],
		name : lineID
	    });
	} else if (gc.lineType == "03") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 20, 20 ],
		name : lineID
	    });
	} else if (gc.lineType == "04") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 30, 30 ],
		name : lineID
	    });
	} else {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		name : lineID
	    });
	}
	
	//-----------------------------------------------------
	//
	//-----------------------------------------------------
	routeLine.on("click", function() {
	    __settings.currentObj = this.getName();
	    
	    if (__settings.currentObj != "none") {
		// 서택된 루트라인 초기화
		RouteDraw.resetLayerChildren();
		
		//
		var objName = "." + __settings.currentObj;
		var shapes = __settings.routeLayer.get(objName);
		shapes.apply("setOpacity", 0.5);
		__settings.routeLayer.draw();
		
		console.log("--------------------------------------------------------------");
		console.log(">> routeLine click - mode(r) :: " + __settings.currentObj );
		console.log("--------------------------------------------------------------");
	    }
	    
	    // 삭제모드일 경우에만.
	    /*
	    if (__settings.mode == "d") {
		console.log("선택된 obj :: " + __settings.currentObj);

		if (__settings.currentObj != "none") {
		    var objName = "." + __settings.currentObj;
		    var shapes = __settings.stage.get(objName);

		    shapes.apply('setWidth', 0);
		    shapes.apply('setHidth', 0);
		    shapes.apply("hide", true);

		    __settings.routeLayer.draw();
		    __settings.imageLayer.draw();

		    // 라인 데이터 제거
		    $.each(__settings.routePosData, function(index, value) {
			if (value[0] == __settings.currentObj) {
			    removeByIndex(__settings.routePosData, index);
			}
		    });
		    
		    console.debug(">>> drawLine :: " + gc.routePosData);
		    console.debug(">>> drawLine-length :: " + gc.routePosData.length);
		}
	    }
	    */
	    
	});

	//-----------------------------------------------------
	//
	//-----------------------------------------------------
	routeLine.on("mouseover", function() {
	    document.body.style.cursor = "pointer";
	    //__settings.currentObj = this.getName();

	    console.debug(">>> drawLine :: " + gc.routePosData);
	    console.debug(">>> drawLine-length :: " + gc.routePosData.length);	    
	});

	//-----------------------------------------------------
	//
	//-----------------------------------------------------
	routeLine.on("mouseout", function() {
	    document.body.style.cursor = "default";
	    //__settings.currentObj = "none";
	});	
	
	
	//-----------------------------------------------------
	//
	//-----------------------------------------------------
	gc.lineMode = "Line";
	gc.routeLayer.add(routeLine);

	// 중간 임시 좌표
	var tArray = new Array();
	tArray.push("0");
	tArray.push("0");

	// 저장할 라인 좌표
	var tmpArray = new Array();
	tmpArray.push(pStart);
	tmpArray.push(tArray);
	tmpArray.push(pEnd);

	// 라인정보 저장.
	gc.routePos.push(tmpArray);

	var rpcd = "ROU" + __smuRMax;
	gc.routePosCd.push(rpcd);
	__smuRMax = parseInt(__smuRMax) + 1;

	
	/*---------------------------------
	 * ->> 저장정보
	 * ---------------------------------
	 *  1. 루트ID
	 *  2. FESTIVAL_CD
	 *  3. FESTIVAL_HALL_CD
	 *  4. StrokeWidth
	 *  5. LineColor
	 *  6. Line Type
	 *  7~12. 시작점(x,y), 중간점, 끝점
	 *  13. 시작 Obj Name
	 *  14. 종료 Obj Name
	 */ 
	var __array = new Array();
	__array.push(rpcd);
	__array.push(__settings.cmCD);
	__array.push(__settings.cmHCD);
	__array.push(__settings.strokeWidth);
	__array.push(__settings.routeColor);
	__array.push(gc.lineType);
	__array.push(pStart[0]);
	__array.push(pStart[1]);
	__array.push(tArray[0]);
	__array.push(tArray[1]);
	__array.push(pEnd[0]);
	__array.push(pEnd[1]);
	
	//---------------------------------
	// 시작 Obj Name
	__array.push(pObjArray[0]);
	//---------------------------------
	// 종료 Obj Name
	__array.push(pObjArray[1]);
	
	//---------------------------------
	gc.routePosData.push(__array);

	console.debug(">>> drawLine :: " + gc.routePos + " / " + gc.routePosCd );
	console.debug(">>> drawLine :: " + gc.routePosData);
	console.debug(">>> drawLine-length :: " + gc.routePosData.length);

	// 레이어 다시 그리기
	gc.routeLayer.draw();
	
	// 라인 그리기 종료
	RouteFunction.stopPosition(gc);
	
	// 선택된 오브젝트 초기화
	__settings.currentObj = "none";
	
	// 선택 해제
	this.resetImageLayerChildren();	
	
	// 선택모드 변경
	modeConfig._select();
    },

    // ----------------------------------
    // :: line
    // 선택된 그리드 색칠함
    // ----------------------------------
    drawLineDash : function(gc) {

	// ------------------------------
	// 배열에서 포인트를 빼온다
	// ------------------------------
	var pArray = gc.tmpPos;

	var aLength = pArray.length;

	var pStarted = new Array();
	var pStart = new Array();
	var pEnd = new Array();

	pStart = pArray[(aLength - 2)];
	pEnd = pArray[(aLength - 1)];
	// ------------------------------
	// //console.debug(">> drawLineDash :: " + pStart + "," + pEnd);

	//
	var routeLine = new Kinetic.Line({
	    points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
	    stroke : "#FF39B0",
	    strokeWidth : 2,
	    lineCap : "round",
	    lineJoin : "round",
	    dashArray : [ 10, 10 ],
	    id : "routeLine"
	});

	// 대쉬가 끝나면 커브를 그린다.
	if (gc.lineMode == "Dash") {
	    gc.lineMode = "Curve";
	} else {
	    gc.lineMode = "Dash";
	}

	gc.pointLayer.add(routeLine);

	// 레이어 다시 그리기
	gc.routeLayer.draw();
	gc.pointLayer.draw();
    },

    // ----------------------------------
    // :: line
    // 선택된 그리드 색칠함
    // ----------------------------------
    drawLineCurve : function(gc) {

	// ------------------------------
	// 배열에서 포인트를 빼온다
	// ------------------------------
	var pArray = gc.tmpPos;

	var aLength = pArray.length;

	var pCurvePoint = new Array();
	var pStart = new Array();
	var pEnd = new Array();

	pStart = pArray[(aLength - 3)];
	pCurvePoint = pArray[(aLength - 2)];
	pEnd = pArray[(aLength - 1)];
	// ------------------------------
	// //console.debug( pStart + "," + pEnd);

	var routeLineCurve = new Kinetic.Curve({
	    points : [ pStart[0], pStart[1], pCurvePoint[0], pCurvePoint[1],
		    pEnd[0], pEnd[1] ],
	    stroke : gc.routeColor,
	    strokeWidth : parseInt(gc.strokeWidth),
	    lineCap : "round",
	    lineJoin : "round",
	    id : "routeLine"
	});

	gc.lineMode = "Curve";
	gc.routeLayer.add(routeLineCurve);

	// 저장할 라인 좌표
	var tmpArray = new Array();
	tmpArray.push(pStart);
	tmpArray.push(pCurvePoint);
	tmpArray.push(pEnd);

	// 라인정보 저장.
	gc.routePos.push(tmpArray);
	var rpcd = "ROU" + __smuRMax;
	gc.routePosCd.push(rpcd);
	__smuRMax = parseInt(__smuRMax) + 1;

	var __array = new Array();
	__array.push(rpcd);
	__array.push(__settings.cmCD);
	__array.push(__settings.cmHCD);
	__array.push(__settings.strokeWidth);
	__array.push(__settings.routeColor);
	__array.push("curve");
	__array.push(pStart[0]);
	__array.push(pStart[1]);
	__array.push(pCurvePoint[0]);
	__array.push(pCurvePoint[1]);
	__array.push(pEnd[0]);
	__array.push(pEnd[1]);
	gc.routePosData.push(__array);

	// 레이어 다시 그리기
	gc.routeLayer.draw();
    },

    // ----------------------------------
    // :: Image
    // ----------------------------------
    drawImg : function(_idx) {

	// Stop Line mode
	RouteFunction.setEventGridPosition("off");

	// 이미지 모드
	__settings.mode = "i";

	var gc = __settings;
	var data = gc.buildMetaInfo[_idx];

	var objCd = "OBJ" + __smuOMax;
	
	//
	//console.log( objCd );
	
	__smuOMax = parseInt(__smuOMax) + 1;

	var imgUrl = data.SAVE_IMG_PATH;
	//console.debug(imgUrl);

	var imageObj = new Image();

	imageObj.onload = function() {
	};
	imageObj.src = imgUrl;

	var imgRect = new Kinetic.Rect({
	    x : 220,
	    y : gc.stage.getHeight() / 2,
	    width : parseInt(data.INST_SIZE),
	    height : parseInt(data.INST_SIZE),
	    fill : {
		image : imageObj
	    },
	    draggable : true,
	    dragBounds : {
		top : 0,
		right : (gc.stage.getWidth() - parseInt(data.INST_SIZE)),
		bottom : (gc.stage.getHeight() - parseInt(data.INST_SIZE)),
		left : 0
	    },
	    name : objCd
	});

	//
	var __array = new Array();
	__array.push(200);
	__array.push(parseInt(gc.stage.getHeight() / 2));

	gc.buildPos.push(__array);
	gc.buildPosCd.push(objCd);

	//-------------------------------------------------------------------
	// add styling
	//-------------------------------------------------------------------
	imgRect.on("click", function(evt) {
	    //alert( this.getName() + " :: " + this.getX() + "/" + this.getY()  );
	    
	});
	
	imgRect.on("mouseover", function() {
	    document.body.style.cursor = "pointer";
	    this.setStrokeWidth(1);
	    __settings.imageLayer.draw();

	    // 선택모드
	    __settings.mode = "s";
	});

	imgRect.on("mouseout", function() {
	    document.body.style.cursor = "default";
	    this.setStrokeWidth(0);
	    __settings.imageLayer.draw();

	    var objName = this.attrs.name;
	    var posX = this.attrs.x;
	    var posY = this.attrs.y;

	    $.each(__settings.buildPosCd, function(index, value) {
		if (value == objName) {
		    var __array = new Array();
		    __array.push(posX);
		    __array.push(posY);
		    gc.buildPos[index] = __array;
		}
	    });

	    //console.debug(this.attrs.x + "/" + this.attrs.y + "/" + this.attrs.name);
	    //console.debug(gc.buildPos);
	    //console.debug(gc.buildPosCd);

	    // 선택모드
	    __settings.mode = "s";
	});

	gc.imageLayer.add(imgRect);
	gc.imageLayer.draw();
    },

    //-------------------------------------------------
    // :: DrawImg For Stage with animation
    //-------------------------------------------------
    drawImgForStage : function(_idx) {

	// 이미지 모드
	modeConfig._construct();

	//
	var gc = __settings;
	var data = gc.buildMetaInfo[_idx];
	var objCd = "OBJ" + __smuOMax;
	
	//
	//console.log( objCd );
	
	__smuOMax = parseInt(__smuOMax) + 1;

	var imgUrl = data.SAVE_IMG_PATH;
	//console.debug(imgUrl);

	var imageObj = new Image();

	imageObj.onload = function() {
	};
	imageObj.src = imgUrl;

	var imgRect = new Kinetic.Rect({
	    x : gc.stage.getWidth(),
	    y : gc.stage.getHeight() / 2,
	    width : parseInt(data.INST_SIZE),
	    height : parseInt(data.INST_SIZE),
	    fill : {
		image : imageObj
	    },
	    draggable : true,
	    dragBounds : {
		top : 0,
		right : (gc.stage.getWidth() - parseInt(data.INST_SIZE)),
		bottom : (gc.stage.getHeight() - parseInt(data.INST_SIZE)),
		left : 0
	    },
	    name : objCd
	});
        
	//
	var __array = new Array();
	__array.push(200);
	__array.push(parseInt(gc.stage.getHeight() / 2));
	//
	gc.buildPos.push(__array);
	
	var __arrayCd = new Array();
	__arrayCd.push(objCd);
	__arrayCd.push(data.INST_CD);
	//
	gc.buildPosCd.push(__arrayCd);

	//-------------------------------------------------------------------
	// add styling
	//-------------------------------------------------------------------
	imgRect.on("click", function(evt) {
	    __settings.currentObj = this.getName();
	    
	    console.log( "<< currentObj :: " + __settings.currentObj +"/ this.getName :: "+ this.getName());
	    
	    // Set Styling
	    if (__settings.mode == "r") {
		//
		this.setStroke('blue');
		this.setStrokeWidth(5);
		__settings.imageLayer.draw();
		
		//
		__settings.tmpPosObj.push(this.getName());
		
		console.log("--------------------------------------------------------------");
		console.log(">> imgRect click - mode(r) :: " + __settings.tmpPosObj);
		console.log("--------------------------------------------------------------");
	    } else {
		// 선택 초기화
		RouteDraw.resetLayerChildren();
		
		console.log("--------------------------------------------------------------");
		console.log( ">> currentObj :: " + __settings.currentObj +"/ this.getName :: "+ this.getName());
		console.log("--------------------------------------------------------------");
		
		//
		this.setStroke('red');
		this.setStrokeWidth(5);
		__settings.imageLayer.draw();
	    }
	    
	    // console.log( this.getName() + " :: " + this.getX() + "/" + this.getY() );
	    // console.log( __settings.mode );

	    
	    // 삭제모드일 경우에만.
	    if (__settings.mode == "d") {
		console.log("선택된 obj :: " + __settings.currentObj);
		
		if (__settings.currentObj != "none") {
		    var objName = "." + __settings.currentObj;
		    var shapes = __settings.stage.get(objName);
		    
		    // Event remove
		    //shapes.off("mouseout");
		    //shapes.off("mouseover");
		   
		    shapes.apply("hide", true);
		    __settings.routeLayer.draw();
		    __settings.imageLayer.draw();
		    
		    // 빌딩 데이터 제거
		    $.each(__settings.buildPosCd, function(index, value) {
			console.log( ">> value :: " + value );
			if( value != undefined ){
				if ( value[0].toString() == __settings.currentObj.toString() ) {
				    removeByIndex(__settings.buildPos, index);
				    removeByIndex(__settings.buildPosCd, index);
				}			    
			} 
		    });
		    
		}
	    }	    
	});
	
	imgRect.on("mouseover", function() {
	    document.body.style.cursor = "pointer";
	    //__settings.currentObj = this.getName();
	});

	imgRect.on("mouseout", function() {
	    document.body.style.cursor = "default";

	    var objName = this.attrs.name;
	    var posX = this.attrs.x;
	    var posY = this.attrs.y;

	    $.each(__settings.buildPosCd, function(index, value) {
		if (value != undefined) {
		    if (value[0] === objName) {
			var __array = new Array();
			__array.push(posX);
			__array.push(posY);
			gc.buildPos[index] = __array;
		    }
		}
	    });

	    // console.debug(this.attrs.x + "/" + this.attrs.y + "/" +
	    // this.attrs.name);
	    
	    console.debug(gc.buildPos);
	    console.debug(gc.buildPosCd);
	    
	    //__settings.currentObj = "none";
	});

	gc.imageLayer.add(imgRect);
	gc.imageLayer.draw();
	
        /*
         * wait one second before starting the
         * transition
         */
        setTimeout(function() {
            imgRect.transitionTo({
        	x: gc.stage.getWidth() / 2,
            	duration: 0.5
            });
        }, 1000);
        
    },
    
    //--------------------------------------------------------------
    //  이미지 / 루트 레이어의 개체들 보더값조정
    //--------------------------------------------------------------
    resetLayerChildren : function() {
	RouteDraw.resetImageLayerChildren();
	RouteDraw.resetRouteLayerChildren();
    },
    
    resetImageLayerChildren : function() {
	// 이미지 선택 해제
	var shapes = __settings.imageLayer.getChildren();
	$.each(shapes, function(index, value) {
	    if (value != undefined) {
		var shp = eval(value);
		shp.setStroke('');
		shp.setStrokeWidth(0);
	    }
	});
	__settings.imageLayer.draw();
    },
   
    resetRouteLayerChildren : function() {
	// 이미지 선택 해제
	var shapes = __settings.routeLayer.getChildren();
	$.each(shapes, function(index, value) {
	    if (value != undefined) {
		var shp = eval(value);
		shp.setOpacity(1);
	    }
	});
	__settings.routeLayer.draw();	
    },
    
    //--------------------------------------------------------------
    // 이미지 레이어의 개체들 드래그 on/off
    //-------------------------------------------------------------- 
    setImageLayerChildrenDnd : function(status) {
	if (status == "on") {
	    
	    $.each(__settings.routePosData, function(idx, value) {
		if (value != undefined) {		    
		    console.log(value[12] + "/" + value[13]);
		}
	    });
	    
	    // 이미지 선택 해제
	    var shapes = __settings.imageLayer.getChildren();
	    $.each(shapes, function(index, value) {
		if (value != undefined) {
		    var shp = eval(value);
		    
		    console.log( ">> shp name :: " + shp.getName() );
		    $.each(__settings.routePosData, function(idx, value) {
			if (value != undefined) {
			    if(( value[12] == shp.getName() ) || ( value[13] == shp.getName() )) {
				shp.setDraggable(false);
				return false;
			    } else {
				shp.setDraggable(true);
			    }
			}
		    });
		    
		}
	    });
	} else if (status == "off") {
	    // 이미지 선택 해제
	    var shapes = __settings.imageLayer.getChildren();
	    $.each(shapes, function(index, value) {
		if (value != undefined) {
		    var shp = eval(value);
		    shp.setDraggable(false);
		}
	    });
	}

	__settings.imageLayer.draw();
    }   
};
