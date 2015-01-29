// ActionScript Document


function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" ;
 }

function getCookie( name ) {
	  var nameOfCookie = name + "=";
	  var x = 0;
	  while ( x <= document.cookie.length )	{
	    var y = (x+nameOfCookie.length);
	    if ( document.cookie.substring( x, y ) == nameOfCookie ) {
	       if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
	          endOfCookie = document.cookie.length;
	       return unescape( document.cookie.substring( y, endOfCookie ) );
	    }
	    x = document.cookie.indexOf( " ", x ) + 1;
	    if ( x == 0 )
	      break;
	  }
	  return "";
	}

/* 
 * 2011 12 01 signal 
 * 시작 날짜와 끝 날짜의 일수 또는 개월수를 리턴하는 함수
 */
function dayDif(pStartDate, pEndDate, pType) { 
	// param : pStartDate - 시작일
	// param : pEndDate - 마지막일
	// param : pType - 'D':일수, 'M':개월수
	var strSDT = new Date(pStartDate.substring(0, 4), pStartDate
			.substring(4, 6) - 1, pStartDate.substring(6, 8));
	var strEDT = new Date(pEndDate.substring(0, 4),
			pEndDate.substring(4, 6) - 1, pEndDate.substring(6, 8));
	var strGapDT = 0;
	//var pType = 'D';

	if (pType == 'D' || pType == 'T' || pType == "M") { // 일수 차이
		strGapDT = (strEDT.getTime() - strSDT.getTime())
				/ (1000 * 60 * 60 * 24);
	} else { // 개월수 차이
		// 년도가 같으면 단순히 월을 마이너스 한다.
		// => 20090301-20090201 의 경우 아래 else의 로직으로는 정상적인 1이 리턴되지 않는다.
		if (pEndDate.substring(0, 4) == pStartDate.substring(0, 4)) {
			strGapDT = pEndDate.substring(4, 6) * 1
					- pStartDate.substring(4, 6) * 1;
		} else {
			strGapDT = Math.floor((strEDT.getTime() - strSDT.getTime())
					/ (1000 * 60 * 60 * 24 * 365.25 / 12));
		}
	}

	return strGapDT;

}

