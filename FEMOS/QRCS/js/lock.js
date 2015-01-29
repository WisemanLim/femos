
function nocontextmenu() {   // IE
   event.cancelBubble = true;
   event.returnValue = false;
   return false;
}

function norightclick(e)    // Others
{
     if (event.button == 2 || event.button == 3){
         event.cancelBubble = true;
         event.returnValue = false;
         return false;
      } 
}

document.oncontextmenu = nocontextmenu;
document.onmousedown = norightclick;
document.onselectstart=new Function("return false");
document.ondragstart=new Function("return false");