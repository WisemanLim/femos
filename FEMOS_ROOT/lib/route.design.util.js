/**
 * This file handles RouteDesign rendering and editor UI. It also
 * provides a simple API for setting RouteDesign size, colors and so on.
 *
 * Copyright (c) 2012 Anthony Kim(김재도), jaedoki@gmail.com
 */

//선의 길이 구하기
function getLineLength( xP1, yP1, xP2, yP2){
	var dx = parseInt(xP2) - parseInt(xP1);
	var dy = parseInt(yP2) - parseInt(yP1);

	var value = Math.sqrt((dx*dx) + (dy*dy));
	return value;
};

// 두 선의 각도 구하기
function getAngleValue( x1,y1, x2,y2, x3,y3 ) {
	
	var va = getLineLength(x1,y1,x2,y2);		// b
	var vb = getLineLength(x2,y2,x3,y3);		// c
	var vc = getLineLength(x1,y1,x3,y3);		// a
	
	// cos(A) = (b^2+C^2-a^2)/2bc
	// A = cos^-1{(b^2+C^2-a^2)/2bc}
	//console.debug( va + "," + vb + "," + vc );
	
	var cosVal =  ((va*va) +(vb*vb) - (vc*vc)) / (2*(va*vb))  ;
	
	var rad = Math.acos(cosVal);
	var deg = (rad*180)/Math.PI ; 

	//console.debug( ">>>> deg :: " + deg );
	
	return deg;
};

function cloneObject(source) {
    for (i in source) {
        if (typeof source[i] == 'source') {
            this[i] = new cloneObject(source[i]);
        }
        else{
            this[i] = source[i];
	}
    }
};

//
function removeByIndex(arrayName,arrayIndex){ 
    arrayName.splice(arrayIndex,1);
   // delete arrayName[ arrayIndex ];
};


