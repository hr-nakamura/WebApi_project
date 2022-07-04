<%@ Language=JScript %>
<!--#include virtual="/Project/Auth/projectLog.inc"-->
<!--#include file="cmn.inc"-->
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

<title>グループ履歴変更</title>

<LINK rel="stylesheet" type="text/css" href="dialog.css">

<SCRIPT LANGUAGE="JavaScript" src="cmn.js"></SCRIPT>
<SCRIPT LANGUAGE="VBScript" src="cmn.vbs"></SCRIPT>
<script src="/Project/_Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/themes/base/jquery.ui.all.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
<script src="js/showDialog.js" type="text/javascript"></script>

</head>
<body BackGround="back.gif">
	<FONT face="MS UI Gothic"></FONT>
	<BR>
	<TABLE ALIGN="center" BORDER="0">
		<TBODY>
			<TR>
				<TD><SPAN ID="projectBox"></SPAN></TD>
			</TR>
			<TR>
				<TD><hr></TD>
			</TR>

			<TR>
				<TD ID="FUNC1" ALIGN="middle" nowrap style="display:none">
				<font class='newLine-comment'>修正する行を選択して下さい</font>
				</TD>
			</TR>

			<TR>
				<TD ID="FUNC2" ALIGN="middle" nowrap style="display:none">
				<table>
					<tr>
					<td align=right width=50%><font class='titleChoice'>グループ選択&nbsp;</font><SPAN ID="yymmBox"></SPAN></td>
					<td align=left width=50%><SPAN ID="groupBox">&nbsp;</SPAN></td>
					</tr>
				</table>
				</TD>
			</TR>
			<TR>
				<TD ALIGN="center" nowrap>
				<INPUT type='button' value='更新' ID='EDIT' NAME="EDIT" style="display:none">
				<INPUT type='button' value='削除' ID='DEL' NAME="DEL" style="display:none">
				<INPUT type='button' value='追加' ID='ADD' NAME="ADD" style="display:none">
				<INPUT type='button' value='戻る' ID='CANCEL' NAME="CANCEL" style="display:none">
				</TD>
			</TR>
			<TR>
				<TD><SPAN ID="historyBox"></SPAN></TD>
			</TR>
			<TR>
				<TD><hr></TD>
			</TR>
			<TR>
				<TD><SPAN ID="salesBox"></SPAN></TD>
			</TR>

		</TBODY>
	</TABLE>


<SCRIPT LANGUAGE="JScript">
var pNum
var gCode
var result = false

$(function(){
    $(window).on('load', function() {
		pNum = parent.parent_pNum

		FUNC1.style.display = "block"
		FUNC2.style.display = "none"

		var o = RSGetASPObject("bbsDB.asp")
		var cObj		= o.getProjectInfo(pNum)
		var projectInfo = cObj.return_value
		var pBuff		= dispProject(projectInfo)

		var cObj		= o.getHistoryInfo(pNum)
		var HistoryInfo = cObj.return_value
		var hBuff		= dispHistory(HistoryInfo)

		var cObj		= o.getSalesInfo(pNum)
		var SalesInfo	= cObj.return_value
		var sBuff		= dispSales(SalesInfo)

		var len   = HistoryInfo.length
		var yymm  = HistoryInfo[len-1].s
		var gCode = HistoryInfo[len-1].gID

		//======================================================

		projectBox.innerHTML = pBuff
		historyBox.innerHTML = hBuff
		salesBox.innerHTML	 = sBuff
		//var sDate 		   = projectInfo.makeDate
		//yymmBox.innerHTML    = makeMonth(sDate,yymm)
		//groupBox.innerHTML   = makeGrp(gCode,yymm)

		CANCEL.style.display = "inline"
		DEL.style.display = "none"
		ADD.style.display = "none"
		EDIT.style.display = "none"
    });
	$(window).on('beforeunload', function(){
		var o = RSGetASPObject("bbsDB.asp")
		var cObj		= o.getHistoryInfo(pNum)
		var HistoryInfo = cObj.return_value
		var len   = HistoryInfo.length
		var yymm  = HistoryInfo[len-1].s
		var gCode = HistoryInfo[len-1].gID
		var gName = HistoryInfo[len-1].gName

		//window.dialogArguments.yymm = yymm
		//window.dialogArguments.gCode = gCode
		//window.dialogArguments.gName = gName

		parent.return_value = result
		parent.parent_pNum = pNum
	});
});
</SCRIPT>

<SCRIPT>
function makeMonth(sDate,c_yymm)
   {
   var yymm,s_yymm,e_yymm
   var toDay = convertDate(new Date())
//	 var toDay="2001/04/01"
   s_yymm = (JsYear(sDate) * 100) + JsMonth(sDate)
   e_yymm = (JsYear(toDay) * 100) + JsMonth(toDay)
	e_yymm = yymmAdd(e_yymm,1)										// １月後のグループ選択を可能とする
   var Buff
   
   Buff = "<SELECT ID='yymmSel'>"
   for(yymm = e_yymm; yymm >= s_yymm; yymm = yymmAdd(yymm,-1)){
	  Buff += "<OPTION VALUE='" + yymm + "'"
	  Buff += (yymm == c_yymm ? "selected" : "")
	  Buff += ">"
	  Buff += strMonth(yymm)
	  }
   Buff += "</SELECT>"
   return(Buff)
   }

function makeGrp(gCode,yymm)
   {
   var o = RSGetASPObject("bbsDB.asp")
   var cObj = o.getGroupList(yymm)
   var Tab	= cObj.return_value
   var Buff = ""
   var Code,Name,Mode
   Buff += "<SELECT ID='GrpSel'>"
   Buff += "<OPTGROUP LABEL='開発・営業'>"
   for(var n in Tab){
	  Mode = Tab[n].mode
	  Code = Tab[n].code
	  Name = Tab[n].name
	  if( Mode == 2 ) continue;
	  Buff += "<OPTION VALUE='" + Code + "'"
	  Buff += (Code == gCode ? "selected" : "")
	  Buff += ">"
	  Buff += Name
	  }
   Buff += "</OPTGROUP>"
   Buff += "<OPTGROUP LABEL='間接'>"
   for(var n in Tab){
	  Mode = Tab[n].mode
	  Code = Tab[n].code
	  Name = Tab[n].name
	  if( Mode != 2 ) continue;
	  Name = Tab[n].name
	  Buff += "<OPTION VALUE='" + Code + "'"
	  Buff += (Code == gCode ? "selected" : "")
	  Buff += ">"
	  Buff += Name
	  }
   Buff += "</OPTGROUP>"
   Buff += "</SELECT>"
   return(Buff)
   }
</SCRIPT>


<SCRIPT LANGUAGE="VBScript">
Function JsIsNumeric(num)
   JsIsNumeric = IsNumeric(num)
End Function
</SCRIPT>

<SCRIPT LANGUAGE='JavaScript'>
	$(document).on('change', '#yymmSel', function() {
		var Obj    = this.options
		var selPos = this.selectedIndex
		var obj = GrpSel
		var n = obj.selectedIndex
		var gCode = obj.options[n].value

		yymm = Obj[selPos].value
		groupBox.innerHTML = makeGrp(gCode,yymm)
	});
</SCRIPT>

<SCRIPT LANGUAGE='JavaScript'>
	$('#ADD').click(function(){
		var obj = GrpSel
		var n = obj.selectedIndex
		var gCode = obj.options[n].value
		var gName = obj.options[n].text
		var obj = yymmSel
		var n = obj.selectedIndex
		var new_yymm = obj.options[n].value

		var o = RSGetASPObject("bbsDB.asp")
		var cObj  = o.regGrpAdd(pNum,gCode,new_yymm)		// 追加のための処理
		var value = cObj.return_value

		if( cObj.status==-1 ){
			alert("開始日付が同じレコードがあります、登録できませんでした。")
			result = false
			}
		else{
			result = true

			var cObj		= o.getHistoryInfo(pNum)
			var HistoryInfo = cObj.return_value
			var hBuff		= dispHistory(HistoryInfo)
			historyBox.innerHTML = hBuff

			var cObj		= o.getSalesInfo(pNum)
			var SalesInfo	= cObj.return_value
			var sBuff		= dispSales(SalesInfo)

			salesBox.innerHTML	 = sBuff
			}	

		DEL.style.display = "none"
		ADD.style.display = "none"
		FUNC1.style.display = "block"
		FUNC2.style.display = "none"

		selPos = ""
	});

	$('#EDIT').click(function(){
		var key_yymm = pNumRow[selPos].s_yymm				// Key
		var key_pNum = pNum
		var obj = GrpSel
		var n = obj.selectedIndex
		var new_Code = obj.options[n].value
		var new_gName = obj.options[n].text
		var obj = yymmSel
		var n = obj.selectedIndex
		var new_yymm = obj.options[n].value

		var o = RSGetASPObject("bbsDB.asp")
		var cObj = o.regGrpEdit(key_pNum,key_yymm,new_Code,new_yymm)
		var value = cObj.return_value

		if( cObj.status==-1 ){
			alert("開始日付が同じレコードがあります、登録できませんでした。")
			result = false
			}
		else{
			result = true
			}

		var cObj		= o.getHistoryInfo(pNum)
		var HistoryInfo = cObj.return_value
		var hBuff		= dispHistory(HistoryInfo)
		historyBox.innerHTML = hBuff

		pNumRow[selPos].style.backgroundColor = selColor

		var cObj		= o.getSalesInfo(pNum)
		var SalesInfo	= cObj.return_value
		var sBuff		= dispSales(SalesInfo)
		salesBox.innerHTML	 = sBuff
	});

	$('#DEL').click(function(){
		var obj = yymmSel
		var n = obj.selectedIndex
		var del_yymm = obj.options[n].value

		/*var obj = GrpSel
		var n = obj.selectedIndex
		var gCode = obj.options[n].value
		var gName = obj.options[n].text

		alert("del_yymm=["+del_yymm+"]　gCode=["+gCode+"]　gName=["+gName+"]")
		*/


		var o = RSGetASPObject("bbsDB.asp")
		var cObj  = o.regGrpDel(pNum,del_yymm)		  // 削除のための処理
		var value = cObj.return_value
		if( cObj.status==-1 ){
			alert("削除できませんでした。")
			result = false
			}
		else{
			result = true
			}

		var cObj		= o.getHistoryInfo(pNum)
		var HistoryInfo = cObj.return_value
		var hBuff		= dispHistory(HistoryInfo)
		historyBox.innerHTML = hBuff

		var cObj		= o.getSalesInfo(pNum)
		var SalesInfo	= cObj.return_value
		var sBuff		= dispSales(SalesInfo)

		salesBox.innerHTML	 = sBuff

		ADD.style.display = "none"
		EDIT.style.display = "none"
		DEL.style.display = "none"
		FUNC1.style.display = "block"
		FUNC2.style.display = "none"

		selPos = ""
	});

	$('#CANCEL').click(function(){
		parent.jQuery("#Dialog").dialog("close")
	});
</SCRIPT>


<SCRIPT LANGUAGE="JavaScript">
function dispProject(Info)
   {
   var table = new makeTable()
   
   table.Begin("class='insideFrame' ALIGN='CENTER' border='0' cellpadding='0' cellspacing='0'");
   //table.Caption("class='SUB'","グループ情報");

   //table.HeadBegin("");
   //table.RowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'");
   //table.HeadCell("WIDTH='25%' nowrap","項目");
   //table.HeadCell("WIDTH='75%' nowrap","内容");
   //table.RowEnd();
   //table.HeadEnd();

   table.BodyBegin("");
   var pCode,pName,gName,makeDate


   table.RowBegin("")
   //table.DataCell("ALIGN='RIGHT' nowrap bgcolor='cornsilk'","プロジェクトコード")
   table.DataCell("class='PROJECT-NAME' nowrap",Info.pCode)
   table.RowEnd()
   table.RowBegin("")
   //table.DataCell("ALIGN='RIGHT' nowrap bgcolor='cornsilk'","プロジェクト名")
   table.DataCell("class='PROJECT-NAME' nowrap",Info.pName)
   table.RowEnd()
   //table.RowBegin("")
   //table.DataCell("ALIGN='RIGHT' nowrap bgcolor='cornsilk'","グループ名")
   //table.DataCell("ALIGN='LEFT' nowrap",Info.gName)
   //table.RowEnd()
   //table.RowBegin("")
   //table.DataCell("ALIGN='RIGHT' nowrap bgcolor='cornsilk'","作成日時")
   //table.DataCell("ALIGN='LEFT' nowrap",Info.makeDate)
   //table.RowEnd()
   //table.BodyEnd()
   table.End()

   return(table.GetData())
   }

function dispHistory(Tab)
   {
   var table = new makeTable()
   
   table.Begin("class='insideFrameColor' ALIGN='CENTER'");
   table.Caption("class='SUB'","グループ履歴");

   table.HeadBegin("");
   table.RowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'");
   table.HeadCell("WIDTH='25%' nowrap","開始");
   //table.HeadCell("WIDTH='25%' nowrap","終了");				//グループ別のプロジェクトの終了年月
   //table.HeadCell("WIDTH='50%' nowrap","グループ名");			//グループ別のプロジェクトの終了年月
   table.HeadCell("WIDTH='75%' nowrap","グループ名");
   table.RowEnd();
   table.HeadEnd();

   table.BodyBegin("bgcolor='snow'");
   var pCode,pName,gName,makeDate


   for( var n in Tab){
	  table.RowBegin("ID='pNumRow' s_yymm='" + Tab[n].s + "'" + " gCode='" + Tab[n].gID + "'")
	  table.DataCell("ALIGN='CENTER' nowrap",strMonth(Tab[n].s))
	  //table.DataCell("ALIGN='CENTER' nowrap",strMonth(Tab[n].e))		//グループ別のプロジェクトの終了年月
	  table.DataCell("ALIGN='LEFT' nowrap",Tab[n].gName)
	  table.RowEnd()
	  }
   
   table.RowBegin("ID='pNumRow' s_yymm='0' gCode='0'")
   table.DataCell("ALIGN='CENTER' nowrap colspan='3' class='newLine-comment'","追加の場合はこの行を指定して下さい。")
   table.RowEnd()


   table.BodyEnd()
   table.End()
   

   return(table.GetData())
   }

function dispSales(Tab)
   {
   var table = new makeTable()
   
   table.Begin("class='insideFrameColor' ALIGN='CENTER'");
   table.Caption("class='SUB'","売上履歴");

   table.HeadBegin("");
   table.RowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'");
   table.HeadCell("WIDTH='25%' nowrap","月");
   table.HeadCell("WIDTH='35%' nowrap","グループ名");
   table.HeadCell("WIDTH='20%' nowrap","予測");
   table.HeadCell("WIDTH='20%' nowrap","実績");
   table.RowEnd();
   table.HeadEnd();

   table.BodyBegin("bgcolor='snow'");
   var pCode,pName,gName


   for( var yymm in Tab){
	  table.RowBegin("")
	  table.DataCell("ALIGN='CENTER' nowrap",strMonth(yymm))
	  table.DataCell("ALIGN='LEFT' nowrap",Tab[yymm].gName)
	  table.DataCell("ALIGN='RIGHT' nowrap",formatNum(Tab[yymm].plan,0))
	  table.DataCell("ALIGN='RIGHT' nowrap",formatNum(Tab[yymm].actual,0))
	  table.RowEnd()
	  }
   table.BodyEnd()
   table.End()

   return(table.GetData())
   }
</SCRIPT>

<SCRIPT Language="JavaScript">
var selColor = "#cccc66"
var selPos = ""
</SCRIPT>

<SCRIPT LANGUAGE='JavaScript'>
	$(document).on('click', '#pNumRow', function() {
		var obj = this.parentElement.rows
		var n  = this.sectionRowIndex
		if( JsIsNumeric(selPos) ) obj[selPos].style.backgroundColor = ""

		this.style.backgroundColor = selColor
		selPos = n

		var b_yymm = parseInt(obj[0].s_yymm)							// プロジェクトの最初の年月日を得る
		var sDate = (parseInt(b_yymm/100)) + "/" + (b_yymm%100) + "/1"

		FUNC1.style.display = "none"
		FUNC2.style.display = "block"

		if(obj[selPos].s_yymm == 0){							
			var toDay = new Date()
			now_yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)		//今の年月を得る

			yymmBox.innerHTML	 = makeMonth(sDate,now_yymm)
			groupBox.innerHTML	 = makeGrp(obj[selPos].gCode, now_yymm)
			
			DEL.style.display = "none"
			ADD.style.display = "inline"
			EDIT.style.display = "none"
			yymmSel.disabled = false
			GrpSel.disabled = false
			}
		else if( n == 0 ){
			yymmBox.innerHTML	 = makeMonth(sDate,this.s_yymm)
			groupBox.innerHTML	 = makeGrp(obj[selPos].gCode, this.s_yymm)

			DEL.style.display = "none"
			ADD.style.display = "none"
			EDIT.style.display = "inline"
			yymmSel.disabled = true
			GrpSel.disabled = false
			}
		else{
			yymmBox.innerHTML	 = makeMonth(sDate,this.s_yymm)
			groupBox.innerHTML	 = makeGrp(obj[selPos].gCode, this.s_yymm)
			
			DEL.style.display = "inline"
			ADD.style.display = "none"
			EDIT.style.display = "inline"
			yymmSel.disabled = false
			GrpSel.disabled = false
			}
	});
	$(document).on('mouseover', '#pNumRow', function() {
		var n  = this.sectionRowIndex
		window.status = "[" + selPos + "][" + n + "]"
		this.style.cursor = "hand"
		this.style.backgroundColor = "#ffaa66"
	});
	$(document).on('mouseleave', '#pNumRow', function() {
		this.style.cursor = ""
		var n  = this.sectionRowIndex
		window.status = "[" + selPos + "][" + n + "]"
		var c = ( n == parseInt(selPos) ? selColor : "")
		this.style.backgroundColor = c
	});
</SCRIPT>

<!-- ここから -->
<!--
<SCRIPT LANGUAGE="JavaScript" src="/_ScriptLibrary/RS_AJAX.Js"></SCRIPT>
-->
<SCRIPT LANGUAGE="JavaScript" src="/_ScriptLibrary/RS.Js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">RSEnableRemoteScripting("/_ScriptLibrary")</SCRIPT>
<!-- ここまで -->
