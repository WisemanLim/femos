// tab -->
// show DIV
function showLayer(lname) {
	eval(layerref + '["' + lname + '"]' + styleref + 'display="block"');
}

// hide DIV
function hideLayer(lname) {
	eval(layerref+'["'+lname+'"]'+styleref+'display="none"');
}


if (document.all)  { 
	layerref = 'document.all';
	styleref = '.style.';
} else if (document.layers) { 
	layerref = 'document.layers';
	styleref = '.';
}

//링크점선없애기-->

function bluring(){ 
if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") document.body.focus(); 
} 
document.onfocusin=bluring; 
// -->

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


// 퀵메뉴 -->

function initMoving(target, position, topLimit, btmLimit) {
    if (!target)
        return false;

    var obj = target;
    obj.initTop = position;
    obj.topLimit = topLimit;
    obj.bottomLimit = document.documentElement.scrollHeight - btmLimit;

    obj.style.position = "absolute";
    obj.top = obj.initTop;
    obj.left = obj.initLeft;

    if (typeof(window.pageYOffset) == "number") {
        obj.getTop = function() {
            return window.pageYOffset;
        }
    } else if (typeof(document.documentElement.scrollTop) == "number") {
        obj.getTop = function() {
            return document.documentElement.scrollTop;
        }
    } else {
        obj.getTop = function() {
            return 0;
        }
    }

    if (self.innerHeight) {
        obj.getHeight = function() {
            return self.innerHeight;
        }
    } else if(document.documentElement.clientHeight) {
        obj.getHeight = function() {
            return document.documentElement.clientHeight;
        }
    } else {
        obj.getHeight = function() {
            return 500;
        }
    }

    obj.move = setInterval(function() {
        if (obj.initTop > 0) {
            pos = obj.getTop() + obj.initTop;
        } else {
            pos = obj.getTop() + obj.getHeight() + obj.initTop;
            //pos = obj.getTop() + obj.getHeight() / 2 - 15;
        }

        if (pos > obj.bottomLimit)
            pos = obj.bottomLimit;
        if (pos < obj.topLimit)
            pos = obj.topLimit;

        interval = obj.top - pos;
        obj.top = obj.top - interval / 9;
        obj.style.top = obj.top + "px";
    }, 30) /*시작점*/
}



// 사이트맵 -->

function init() {
      contents.style.visibility = "visible";
}

function mouseAction(overOrout) {
      myTable = contents.style;
      if (overOrout) {
            actionCheck = 1;
            setTimeout("animationMenu(1);", 1);
      }
      else {
            actionCheck = 0;
            setTimeout("animationMenu(0);", 1);
      }
}
function animationMenu(overOrout) {
      if (overOrout && actionCheck) {
            if (myTable.pixelTop < -10) {
                myTable.pixelTop += 10;
                setTimeout("animationMenu(1)",1);
            }
      }
      else {
            if (!actionCheck && myTable.pixelTop > -224) {
                myTable.pixelTop -= 10;
                setTimeout("animationMenu(0)",1);
            }
      }
}

// 플래시 -->

function flash(c,d,e) {
 var flash_tag = "";
 flash_tag = '<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" ';
 flash_tag +='codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" ';
 flash_tag +='WIDTH="'+c+'" HEIGHT="'+d+'" >';
 flash_tag +='<param name="wmode" value="transparent">'; 
 // 배경을 투명으로 설정
 flash_tag +='<param name="movie" value="'+e+'">';
 flash_tag +='<param name="quality" value="high">';
 flash_tag +='<embed src="'+e+'" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" ';
 flash_tag +='type="application/x-shockwave-flash"  WIDTH="'+c+'" HEIGHT="'+d+'"></embed></object>'
 document.write(flash_tag);
}




