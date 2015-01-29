var lineConfig = {
    _type : function(num) {
	RouteFunction.setEventGridPosition("on");

	if (num == 1) {
	    // 라인
	    __settings.lineType = "01";
	}
	if (num == 2) {
	    // 대쉬
	    __settings.lineType = "02";
	}
	if (num == 3) {
	    // 대쉬
	    __settings.lineType = "03";
	}
	if (num == 4) {
	    // 대쉬
	    __settings.lineType = "04";
	}
    },

    _color : function(num) {
	//RouteFunction.setEventGridPosition("on");

	if (num == 1) {
	    // FFFFFF
	    __settings.routeColor = "#FFFFFF";
	}
	if (num == 2) {
	    // A6A6A6
	    __settings.routeColor = "#A6A6A6";
	}
	if (num == 3) {
	    // FF0000
	    __settings.routeColor = "#FF0000";
	}
	if (num == 4) {
	    // 22DC44
	    __settings.routeColor = "#22DC44";
	}
	if (num == 5) {
	    // 2085DF
	    __settings.routeColor = "#2085DF";
	}
	if (num == 6) {
	    // A020DF
	    __settings.routeColor = "#A020DF";
	}
    },

    _delete : function() {

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

    // ----------------------------------
    // :: Get Position
    // ----------------------------------
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

	////console.debug(">>>>> gx,gy :: " + gx + "," + gy);

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
		////console.debug(xPos + "," + yPos);

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
			////console.debug(">>>>>> abcd :: " + b[0] + "," + c[0]+ "," + b[1] + "," + c[1]);

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

    // ------------------------
    // 포지션 데이터 리셋
    // ------------------------
    stopPosition : function(gc) {
	gc.tmpPos = [];

	// Clear Children Node
	gc.pointLayer.clear();
	gc.pointLayer.removeChildren();
    },

    reset : function() {
	__settings.tmpPos = [];

	// Clear Children Node
	__settings.pointLayer.clear();
	__settings.pointLayer.removeChildren();
	__settings.routeLayer.clear();
	__settings.routeLayer.removeChildren();
    },

    // ----------------------------------
    // :: Rect
    // 선택된 그리드 색칠함
    // ----------------------------------
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
		RouteData.loadLine(value);
	    } else {
		// 커브모드
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
    loadLine : function(_array) {

	var gc = __settings;

	// ------------------------------
	// 배열에서 포인트를 빼온다
	// ------------------------------
	var pStart = new Array();
	var pEnd = new Array();

	pStart = _array[0];
	pEnd = _array[2];
	// ------------------------------
	// //console.debug( pStart + "," + pEnd);

	//
	var routeLine = new Kinetic.Line({
	    points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
	    stroke : gc.routeColor,
	    strokeWidth : parseInt(gc.strokeWidth, 10),
	    lineCap : "round",
	    lineJoin : "round",
	    id : "routeLine"
	});

	gc.lineMode = "Line";
	gc.routeLayer.add(routeLine);

	// 레이어 다시 그리기
	gc.routeLayer.draw();
    },
    // ----------------------------------
    //
    // ----------------------------------
    loadImg : function(_obj) {

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
	var aLength = pArray.length;

	var pStart = new Array();
	var pEnd = new Array();

	if (gc.lineMode == "Dash") {
	    pStart = pArray[(aLength - 3)];
	    pEnd = pArray[(aLength - 1)];
	} else {
	    pStart = pArray[(aLength - 2)];
	    pEnd = pArray[(aLength - 1)];
	}
	// ------------------------------
	//console.debug(">> drawLine :: " + pStart + "," + pEnd);
	
	var routeLine;

	if (gc.lineType == "01") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		id : "routeLine"
	    });
	} else if (gc.lineType == "02") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 10, 10 ],
		id : "routeLine"
	    });
	} else if (gc.lineType == "03") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 20, 20 ],
		id : "routeLine"
	    });
	} else if (gc.lineType == "04") {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		dashArray : [ 30, 30 ],
		id : "routeLine"
	    });
	} else {
	    routeLine = new Kinetic.Line({
		points : [ pStart[0], pStart[1], pEnd[0], pEnd[1] ],
		stroke : gc.routeColor,
		strokeWidth : parseInt(gc.strokeWidth, 10),
		lineCap : "round",
		lineJoin : "round",
		id : "routeLine"
	    });
	}

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

	var __array = new Array();
	__array.push(rpcd);
	__array.push(__settings.cmCD);
	__array.push(__settings.cmHCD);
	__array.push(__settings.strokeWidth);
	__array.push(__settings.routeColor);
	__array.push("line");
	__array.push(pStart[0]);
	__array.push(pStart[1]);
	__array.push(tArray[0]);
	__array.push(tArray[1]);
	__array.push(pEnd[0]);
	__array.push(pEnd[1]);
	gc.routePosData.push(__array);

	////console.debug( gc.routePos );
	////console.debug( gc.routePosCd );
	//console.debug(">>>>>" + gc.routePosData);
	//console.debug(">>>>> length :: " + gc.routePosData.length);

	// 레이어 다시 그리기
	gc.routeLayer.draw();
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
