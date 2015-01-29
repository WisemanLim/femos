function setMenu(cls,num)
{
	var str = '';
	for(var i = 1; i <= $("."+cls).length; i++)
	{
		
		if(i == num)
		{
			$('#'+cls+'_'+i).attr('src',$('#'+cls+'_'+i).attr('src').replace(/_off/gi, '_on'));
		}
		else
		{
			$('#'+cls+'_'+i).attr('src',$('#'+cls+'_'+i).attr('src').replace(/_on/gi, '_off'));
		}
	}
}
function CheckForm(objs,Msgs,inner_layer,color)
{
	var objs = objs.split(',');
	var Msg = Msgs.split(',');
	
	var ret = true;
	
	document.getElementById(inner_layer).innerHTML = '';
	
	for (var i = 0; i< objs.length ;i++)
	{
		tmpObj = document.getElementById(objs[i]);
		if(tmpObj)
		{
			if (tmpObj.value.length == 0)
			{
				document.getElementById(inner_layer).innerHTML = '<span style="color:'+color+'">'+Msg[i]+'</span>';
				tmpObj.focus();
				ret = false;
				break;
			}
		}
	}
	return ret;
}

function ValidNumber(obj)
{
	var str=obj.value;
	var strTemp = obj.value;
	
	if (str.length==0){
		return false;
	}
	
	for(var i=0; i<str.length; i++){
		if ( !('0'<=str.charAt(i) && str.charAt(i)<='9') ) {
			strTemp = strTemp.substr(0, i) + strTemp.substr(i+1, strTemp.length-i);			
		}
	}
	
	if( strTemp != str )
	{
		obj.value = strTemp;
		obj.focus();
		obj.select();
		return false;
	}
	return true;
}

function goPage(page)
{
	document.getElementById('page').value = page;
	document.getElementById('form1').submit();
}