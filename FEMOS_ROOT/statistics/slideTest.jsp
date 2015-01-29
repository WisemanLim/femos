<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>

<script src="animatedcollapse.js" type="text/javascript">
/***********************************************
* Animated Collapsible DIV- ⓒ Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for this script and 100s more
***********************************************/
</script>
</head>

<body>

<p><b>Example 1:</b></p>

<a href="javascript:collapse1.slidedown()">Slide Down</a> || <a href="javascript:collapse1.slideup()">Slide Up</a>
<div id="dog" style="width: 300px; height: 110px; background-color: #99E0FB;">

<!--Your DIV content as follows -->
<h3>Content inside DIV!</h3>
<h4>Note: CSS height attribute defined</h4>

</div>

<script type="text/javascript">

//Syntax: var uniquevar=new animatedcollapse("DIV_id", animatetime_milisec, enablepersist(true/fase))
var collapse1=new animatedcollapse("dog", 1000, false)

</script>



<p><b>Example 2:</b></p>

<a href="javascript:collapse2.slideit()">Shoe/ Hide Content</a>
<div id="cat" style="width: 300px; background-color: #99E0FB;">

<!--Your DIV content as follows. Note to add CSS padding or margins, do it inside a DIV within the Collapsible DIV -->
<div style="padding: 0 5px">
<h3>Content inside DIV!</h3>
<h3>Content inside DIV!</h3>
<h4>Note: No CSS height attribute defined. Persistence enabled.</h4>
                <table  class="table1">
                	<colgroup>
                		<col width="100px"/>
						<col width="550px"/>
						<col width="*"/>
                	</colgroup>
                	<tr>
                		<th>설문번호</th>
						<th>설문내용</th>
						<th>&nbsp;</th>
                	</tr>
                </table>   
</div>

</div>

<script type="text/javascript">

//Syntax: var uniquevar=new animatedcollapse("DIV_id", animatetime_milisec, enablepersist(true/fase))
var collapse2=new animatedcollapse("cat", 800, true)

</script>

</body>
</html>