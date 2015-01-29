function getLineLength( xP1, yP1, xP2, yP2){
	var dx = parseInt(xP2) - parseInt(xP1);
	var dy = parseInt(yP2) - parseInt(yP1);

	var value = Math.sqrt((dx*dx) + (dy*dy));
	return value;
};

function getAngleValue( x1,y1, x2,y2, x3,y3 ) {
	
	var va = getLineLength(x1,y1,x2,y2);		// b
	var vb = getLineLength(x2,y2,x3,y3);		// c
	var vc = getLineLength(x1,y1,x3,y3);		// a
	
	
	
	var cosVal =  ((va*va) +(vb*vb) - (vc*vc)) / (2*(va*vb))  ;
	
	var rad = Math.acos(cosVal);
	var deg = (rad*180)/Math.PI ; 


	return deg;
};