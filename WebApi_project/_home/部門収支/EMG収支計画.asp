<%@ Language=JavaScript %>
<!--#include virtual="/Project/Auth/projectLog.inc"-->
<!--#include virtual="/Project/common_data/確定日付.inc"-->
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/dispXML.inc"-->
<%

/*
	Session("memberName1") = "中村"
	Session("memberName2") = "博"
*/
var memberID = Session("memberID")

var limitYear = 2004
var dispCnt = 12
var dispMode = ""
//===========================================

	var dispCmd  = (Request.QueryString("dispCmd").Count  == 0 ? "EMG"	: Request.QueryString("dispCmd").Item)
//	var dispMode = (Request.QueryString("dispMode").Count == 0 ? "全社" : Request.QueryString("dispMode").Item)
	var fixStr = String(Request.QueryString("fix"))
	var fixLevel
	if(IsNumeric(fixStr)){
		fixLevel = (Math.floor(fixStr/10))*10
		if( fixLevel > 100 || fixLevel < 0 ) fixLevel = 70
		}
	else{
		fixLevel = 70
		}

	var year = String(Request.QueryString("year"))
	if( year == "undefined" ){
		var d = new Date()
		var yy = d.getFullYear()
		var mm = d.getMonth()+1
		var dd = d.getDate()
		var yymm = yy * 100 + mm						  // 今月のyymm

		var OKday = dayChk(d,adjustDayCnt)
		var yymm = ( parseInt(dd) < parseInt(OKday) ? yymmAdd(yymm, -1) : yymmAdd(yymm, 0)) 	 // データ有効月の計算(12日以前は前々月)
		yy = parseInt(yymm / 100)
		mm = yymm % 100

		year = yy + (mm >= 10 ? 1 : 0)			   // 10月以降は次年度を表示
		}

	if( year < limitYear ){
		year = limitYear
//		Response.End()
		}

	var yosokuCnt
	var d = new Date()
	var yy = d.getFullYear()
	var mm = d.getMonth()+1
	var dd = d.getDate()
	var yymm = yy * 100 + mm								// 今月のyymm

	var OKday = dayChk(d,adjustDayCnt)
	yymm = ( parseInt(dd) < parseInt(OKday) ? yymmAdd(yymm, -1) : yymmAdd(yymm, 0))		// データ有効月の計算(12日以前は前々月)

	var b_yymm = ((year-1)*100) + 10
	var actualCnt = yymmDiff( b_yymm, yymm )

	if(actualCnt >= 12) actualCnt = 12

	if(Request.QueryString("yosoku").count == 0){
		yosokuCnt = 12 - actualCnt
		yosokuCnt = 3
		}
	else{
		yosokuCnt = parseInt(Request.QueryString("yosoku") )
		}
	if(yosokuCnt == -1){
//	すべて計画
		actualCnt = 0
		yosokuCnt = 0
		}


//	パートの配賦は2008年度まで1/4  (0.25)
//				  2009年度から1/100(0.01)
//	var partUnit = ( year >= 2009 ? 100 : 4 )				

//	保存されたデータでない表を見たいとき
	var real = (Request.QueryString("real").Count == 0 ? 0 : Request.QueryString("real").Item)

	var o = new ActiveXObject("Scripting.FileSystemObject")
	var htmURL = "確定データ/EMG収支計画-" + year + ".htm"
	var htmPath = Server.MapPath(htmURL)
	var ret = o.FileExists(htmPath)
	if( ret == true && real != 1 ){
		Server.Transfer(htmURL)						// 保存データの表示(ファイルが存在して [ real ] の指定なし)
		}
//=============================================================================================================
	var htmlDoc = ""
%>
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />
<LINK rel="stylesheet" href="/Project/inc/account.css" type="text/css">

<title>EMG収支計画-<%=year%></title>

<SCRIPT LANGUAGE="JavaScript">
var limitYear = "<%=limitYear%>"
var dispCnt   = "<%=dispCnt%>"
var dispCmd   = "<%=dispCmd%>"
var year	  = "<%=year%>"
var fixLevel  = "<%=fixLevel%>"
var yosokuCnt = "<%=yosokuCnt%>"
var actualCnt = "<%=actualCnt%>"
</SCRIPT>
<SCRIPT FOR="window" EVENT="onload" Language="JavaScript">
//LoadComment(year)

var yymm = (parseInt(year)-1)*100 + 10
var Title = ( dispCmd == "EMG" ? "ＥＭＧ収支計画" : "部門収支計画" )
mainTitle.innerHTML = String(Title).big()
subTitle.innerHTML = "(" + strMonth(yymm) + "～" + strMonth(yymmAdd(yymm,dispCnt-1)) + ")"

if(parseInt(year) > parseInt(limitYear) ){
	prev.style.display=""
	}
next.style.display=""

var o = document.getElementsByName("section")
for( var i = 0; i < o.length; i++ ){
	if(o[i].value == dispCmd) o[i].checked = true
	}

var o = document.getElementsByName("level")
for( var i = 0; i < o.length; i++ ){
	if(o[i].value == fixLevel) o[i].checked = true
	}

//	すべて実績でないときはXMLで表示
//if( actualCnt < 12 ){
	reLoad()
//	}

window.focus()
</SCRIPT>
<SCRIPT FOR="window" EVENT="onunload" LANGUAGE="JavaScript">
winClose()
</SCRIPT>


<SCRIPT FOR="section" EVENT="onclick" LANGUAGE="JavaScript">
mainTitle.style.color = "tomato"
//this.parentElement.style.color = "tomato"

var pTab = []
pTab.push("dispCmd="  + dispCmd)
pTab.push("year="	  + year)
pTab.push("fix="	  + fixLevel)
pTab.push("yosoku="   + yosokuCnt)
window.location.replace(window.location.pathname + "?" + pTab.join("&") )
</SCRIPT>


<SCRIPT FOR="level" EVENT="onclick" LANGUAGE="JavaScript">
//mainTitle.style.color = "tomato"
//this.parentElement.style.color = "tomato"

	fixLevel = this.value
	levelChange(fixLevel)

</SCRIPT>


<SCRIPT FOR="prev" EVENT="onclick" LANGUAGE="JavaScript">
mainTitle.style.color = "tomato"

year	  = parseInt(year) - 1
var pTab = []
pTab.push("dispCmd="  + dispCmd)
pTab.push("year="	  + year)
pTab.push("fix="	  + fixLevel)
pTab.push("yosoku="   + yosokuCnt)
window.location.replace(window.location.pathname + "?" + pTab.join("&") )

</SCRIPT>
<SCRIPT FOR="next" EVENT="onclick" LANGUAGE="JavaScript">
mainTitle.style.color = "tomato"

year	  = parseInt(year) + 1
var pTab = []
pTab.push("dispCmd="  + dispCmd)
pTab.push("year="	  + year)
pTab.push("fix="	  + fixLevel)
pTab.push("yosoku="   + yosokuCnt)
window.location.replace(window.location.pathname + "?" + pTab.join("&") )
</SCRIPT>
<SCRIPT FOR="prev" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor = "hand"
</SCRIPT>
<SCRIPT FOR="prev" EVENT="onmouseleave" LANGUAGE="JavaScript">
this.style.cursor = ""
</SCRIPT>
<SCRIPT FOR="next" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor = "hand"
</SCRIPT>
<SCRIPT FOR="next" EVENT="onmouseleave" LANGUAGE="JavaScript">
this.style.cursor = ""
</SCRIPT>

<SCRIPT FOR="onUriage" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onUriage" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onUriage" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onUriage" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>

<SCRIPT FOR="onGenka" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onGenka" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onGenka" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onGenka" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>

<SCRIPT FOR="onSales" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onSales" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onSales" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onSales" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>

<SCRIPT FOR="onCost" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onCost" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onCost" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onCost" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>

<SCRIPT FOR="onKanriHi" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onKanriHi" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onKanriHi" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onKanriHi" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>

<SCRIPT FOR="onKei0" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onKei0" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onKei0" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onKei0" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>
<SCRIPT FOR="onKei1" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onKei1" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onKei1" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onKei1" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>
<SCRIPT FOR="onKei2" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onKei2" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onKei2" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onKei2" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>
<SCRIPT FOR="onKei3" EVENT="onmouseover" LANGUAGE="JavaScript">
this.style.cursor="hand"
</SCRIPT>
<SCRIPT FOR="onKei3" EVENT="onmouseout" LANGUAGE="JavaScript">
this.style.cursor=""
</SCRIPT>
<SCRIPT FOR="onKei3" EVENT="onclick" LANGUAGE="JavaScript">
var oBody = this.parentElement.tBodies
var Cnt = oBody.length
for( var i = 0; i < Cnt; i++){
	if( oBody[i].id == "onKei3" )	oBody[i].style.display = (oBody[i].style.display == "none" ? "" : "none")
	}
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
var newWin = null;
function winOpen(aspName)
	{
	newWin = window.open(aspName,"planWin","width=900,height=600,scrollbars,resizable,status=no");
	}
	
function winClose()
	{
	if(newWin != null && !newWin.closed) newWin.close();
	}
</SCRIPT>

<SCRIPT FOR="X_GRP" EVENT="onmouseenter" LANGUAGE="JavaScript">
this.style.backgroundColor = "lightgrey"
this.style.cursor = "hand"
</SCRIPT>
<SCRIPT FOR="X_GRP" EVENT="onmouseleave" LANGUAGE="JavaScript">
this.style.backgroundColor = ""
this.style.cursor = ""
</SCRIPT>
<SCRIPT FOR="X_GRP" EVENT="onclick" LANGUAGE="JavaScript">
	var gName = this.getAttribute("gName")
	var pTab = []
	pTab.push("dispCmd="  + dispCmd)
	pTab.push("dispName=" + dispName)
	pTab.push("year="	  + year)
	pTab.push("fix="	  + fixLevel)
	pTab.push("yosoku="   + yosokuCnt)
	winOpen("個別収支計画.asp?" + pTab.join("&"))

</SCRIPT>


<SCRIPT LANGUAGE="JavaScript" src="xmlProc.js"></SCRIPT>
<SCRIPT Language="JavaScript">
var xml_name1 = "xml/部門収支_XML.asp"				// 地域別
var xsl_name1 = "xsl/EMG部門収支.xsl"				

var xml_proc
var source = "ABC"

function reLoad()
	{
	mainTitle.style.color = "tomato"

	var pTab = []
	pTab.push("dispCmd="  + dispCmd)
	pTab.push("year="	  + year)
	pTab.push("fix="	  + fixLevel)
	pTab.push("yosoku="   + yosokuCnt)


	var xsl = xsl_name1
	var xml = xml_name1 + "?" + pTab.join("&")

	xml_proc = new xmlProc()
	xml_proc.loadXML(source,xml,xml_func)
	}
function levelChange(level)
	{
	mainTitle.style.color = "tomato"
//	dataBlock.style.display="none"
//	helpBlock.style.display="none"

//	売上予測データの変更

	yosokuSet(source,level)

	var xsl = xsl_name1
	xml_proc.transfor(source,xsl,xsl_func)

	}
	
function xml_func(xmlDoc)
	{
	var xsl = xsl_name1
	xml_proc.transfor(xmlDoc,xsl,xsl_func)
	source = xmlDoc
	}

function xsl_func(Buff)
	{
	dataG.innerHTML = Buff

	dataBlock.style.display="block"
	helpBlock.style.display="block"
	mainTitle.style.color = ""
	comment.style.display="block"
	}
	
function yosokuSet(xmlDoc,level)
	{
try{
	var yosokuInfo = []
	var mCnt  = xmlDoc.selectSingleNode("//月数").text
	var group = xmlDoc.selectNodes("//グループ")
	var levelNode = xmlDoc.selectSingleNode("//確度")
	levelNode.text = level
	
	for( var g = 0; g < group.length; g++ ){
		var yosoku = group[g].selectNodes("予測データ/売上予測/項目[@name='確度" + level + "']/月")
		var data   = group[g].selectNodes("データ")
		for( var d = 0; d < data.length; d++ ){
			for( var m = 0; m < mCnt; m++ ){
				var x = data[d].selectSingleNode("月情報/月[@m=" + m + "]").text
				var z = data[d].selectSingleNode("売上高/項目[@name='売上']/月[@m=" + m + "]")
				if( x == "予測" ){
					z.text= yosoku[m].text
					}
				}
			}
		}
	return(xmlDoc)
}catch(e){alert(e.message)}
	}

</SCRIPT>

<SCRIPT LANGUAGE="JavaScript" src="cmn.js"></SCRIPT>
<SCRIPT LANGUAGE="VBScript" src="cmn.vbs"></SCRIPT>


<!--Script End-->

</HEAD>


	<body background="bg00.gif">
		<table ALIGN="center" ID="Table1">
		<caption><SPAN id="mainTitle"></SPAN></caption>
<%if(actualCnt < 12){%>
		<TR>
			<td>
				<TABLE ALIGN="center" ID="Table2">
					<TR>
						<TD ALIGN="left"><INPUT type="radio" id="level" name="level" value="70">Ａ</TD>
						<TD ALIGN="left"><INPUT type="radio" id="level" name="level" value="50">Ｂ</TD>
						<TD ALIGN="left"><INPUT type="radio" id="level" name="level" value="30">Ｃ</TD>
					</TR>
				</TABLE>
			</td>
		</TR>
<%}%>
		<TR>
			<td>
				<TABLE ALIGN="center" ID="Table2">
					<TR>
						<TD ALIGN="left"><IMG SRC="arrow_l1.gif" id="prev" border="0" TITLE="前の期" STYLE="DISPLAY: none"></TD>
						<TD ALIGN="middle"><SPAN ID="subTitle">　</SPAN></TD>
						<TD ALIGN="right"><IMG SRC="arrow_r1.gif" id="next" border="0" TITLE="次の期" STYLE="DISPLAY: none"></TD>
					</TR>
				</TABLE>
			</td>
		</TR>
		<TR>
		<TD>
		<table id="dataBlock" align='center' width='70%' BORDER='0' style="display:block">
		<TR>
			<TD>
			<DIV><%=htmlDoc%></DIV>
			<DIV ID="dataG"></DIV>
			</TD>
		</TR>
		<TR>
			<TD align="right">作成日付( <%=convertDateTime(new Date())%> )</TD>
		</TR>
		</table>
			<table id="helpBlock" align='center' width='70%' BORDER='0' style="display:none">
				<tr>
					<td ALIGN='left' >
						<font size=-1>
						◎この表について
						<LI>
							このデータは<font color='tomato'>社外秘</font>です、取り扱いには十分注意してください。
						<LI>
						売上は請求書発行データを使用しています。(実際の入金は翌月・翌々月・手形など客先により違います)
						<LI>
						データの確定はEM・ACEL・PSL３社の経費データがほぼ揃った時点( <%=String(adjustDayCnt)%> 営業日)で、売上・費用とも確定とします。
						<LI>
						営業外費用の主な項目として借入金の金利支払いを含みます(借入金の返済は含まれていません)。
						<LI>
						この表の経常利益は、入金・資金計画などを考慮していません。
						</font>
					</td>
				</tr>
			</table>
		</TD>
		</TR>
		<TR>
		<TD align="center">
			<SPAN ID="comment"></SPAN>
		</TD>
		</TR>
		</table>
	</body>
</HTML>

