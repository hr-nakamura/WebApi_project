<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

<title>入力</title>

<LINK rel="stylesheet" type="text/css" href="dialog.css">

</head>
<body ID="XX" BackGround="back.gif" leftmargin="0" topmargin="0">
	<table id='corpBase' align= center border=0>
	<tHead>
	<tr>
	<th colspan=2 id='TextHead'></th>
	</tr>
	</thead>
	<tBody>
	<tr>
	<td colspan=2><INPUT type='text' ID="TextBox" size='45' maxlength="30" NAME="TextBox"></td>
	</tr>
	<tr>
	<td align=right><INPUT type='button' ID="OK" value='設定' NAME="OK"></td><td align=left><INPUT type='button' ID="CANCEL" value='取消' NAME="CANCEL"></td>
	</tr>
	</tBody>
	</table>
</body>
</html>
<SCRIPT LANGUAGE="JavaScript">
var result = ""
function dispObj(obj)
	{
	var Buff = ""
	var i,pos
	pos = 0
	for( i in o = obj ){
		Buff += ("["+i + "]=" + o[i] + "　")
		if( ++pos % 5 == 0 ) Buff += "\n"
		}
	alert(Buff)
	}
</SCRIPT>
<SCRIPT FOR="window" EVENT="onload" LANGUAGE="JavaScript">
var Title = window.dialogArguments["TITLE"]
var Head  = window.dialogArguments["HEAD"]
var Value = window.dialogArguments["VALUE"]
window.document.title = Title
TextHead.innerHTML = Head
TextBox.value = Value

var sX = corpBase.offsetWidth + 40
var sY = corpBase.offsetHeight + 40
window.dialogHeight = sY  + "px"
window.dialogWidth	= sX  + "px"
</SCRIPT>
<SCRIPT FOR="window" EVENT="onunload" LANGUAGE="JavaScript">
	window.returnValue = result
</SCRIPT>
<SCRIPT FOR="XX" EVENT="onkeydown" LANGUAGE="JavaScript">
var keyCode = window.event.keyCode
if(keyCode == 0x0d){
	result = TextBox.value
   window.close()
   }
else if(keyCode == 0x1b){
	result = ""
   window.close()
   }
</SCRIPT>
<SCRIPT FOR="OK" EVENT="onclick" LANGUAGE="JavaScript">
result = TextBox.value
window.close()
</SCRIPT>
<SCRIPT FOR="CANCEL" EVENT="onclick" LANGUAGE="JavaScript">
result = ""
window.close()
</SCRIPT>
