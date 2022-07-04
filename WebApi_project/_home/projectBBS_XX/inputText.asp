<html>
<head>
	<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
	<META http-equiv="X-UA-Compatible" content="IE=5" />
	<title>入力</title>
	<LINK rel="stylesheet" type="text/css" href="dialog.css">
	<script src="/Project/_Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
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

$(function(){
    $(window).on('load', function() {
        var Value = parent.parent_Buff["VALUE"]
		TextBox.value = Value
    });
	$(window).on('beforeunload', function(){
		parent.childlen_ReturnValue = result
	});
});

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

<SCRIPT LANGUAGE='JavaScript'>
	$('#XX').keydown(function(){
		var keyCode = window.event.keyCode
		if(keyCode == 0x0d){
			result = TextBox.value
			parent.jQuery("#Dialog").dialog("close")
		}
		else if(keyCode == 0x1b){
			result = ""
			parent.jQuery("#Dialog").dialog("close")
		}
	});

	$('#OK').click(function(){
		result = TextBox.value
		parent.jQuery("#Dialog").dialog("close")
	});

	$('#CANCEL').click(function(){
		result = ""
		parent.jQuery("#Dialog").dialog("close")
	});
</SCRIPT>
