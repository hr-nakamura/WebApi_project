<%@ Language=JScript %>
<%
var memberID	= Session("memberID")
var userName	= Session("userName")
var managerMenu = ( Session("managerMenu") ? 1 : 0 )
Response.Write("OK["+memberID + "]");

%>
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

    <script src="/WebApi/Project/_home/_Content/_Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="/WebApi/Project/_home/_Content/_Scripts/jquery.my.Query.js" type="text/javascript"></script>
   <LINK rel="stylesheet" type="text/css" href="main.css">
   <TITLE></TITLE>
<STYLE>
td{
	white-space:nowrap;
	}
</STYLE>
</HEAD>

<BODY background="back.gif">

<table class='outsideFrame' ALIGN='CENTER' border="0" cellPadding="0" cellSpacing="0">
		 <CAPTION class='mainTitle'>プロジェクト引合状況</CAPTION>
<tr>
<td ALIGN="center" colspan="3"><INPUT type="button" value="新規登録" ID="registNew" disabled style="display:none"></td></tr>
<tr>
<td WIDTH="25%" ALIGN="left" VALIGN="bottom">
<TABLE ID="Tab_Code" BORDER=0>
<TBODY>
<TR><TD nowrap class="showNumber" ALIGN="left">表示数</TD><TD class='count' ALIGN="right"><SPAN ID="spanTotal"></SPAN></TD></TR>
<TR><TD nowrap class="searchName" ALIGN="right">ﾌﾟﾛｼﾞｪｸﾄｺｰﾄﾞ：</TD><TD><INPUT ID="inCode" size="10" maxlength="7" disabled NAME="inCode" class='searchPcode'></TD></TR>
<TR><TD nowrap class="searchName" ALIGN="left">ﾌﾟﾛｼﾞｪｸﾄ名：</TD><TD><INPUT ID="inName" size="10" maxlength="16" disabled NAME="inName" class='searchPcode'></TD></TR>
</TBODY>
</TABLE>
</td>
<td WIDTH="35%" ALIGN="middle" VALIGN="bottom">
<TABLE	ID="Tab_Stat" BORDER=0>
<TBODY>
<TR>
<TD nowrap class="radio"><INPUT type="radio" ID="Stat" name=radioX VALUE=0 checked>更新のみ</TD>
<TD nowrap class="radio"><INPUT type="radio" ID="Stat" name=radioX VALUE=1><FONT COLOR="green">▲</FONT>引合中</TD>
<TD nowrap class="radio"><INPUT type="radio" ID="Stat" name=radioX VALUE=2><FONT COLOR="blue">●</FONT>開発中</TD>
<TD nowrap class="radio"><INPUT type="radio" ID="Stat" name=radioX VALUE=3><FONT COLOR="gray">●</FONT>開発終了</TD>
<TD nowrap class="radio"><INPUT type="radio" ID="Stat" name=radioX VALUE=4><FONT COLOR="gray">★</FONT>終了</TD>
<TD nowrap class="radio"><INPUT type="radio" ID="Stat" name=radioX VALUE=5><FONT COLOR="gray">×</FONT>没</TD>
<TD nowrap class="radio"><INPUT type="radio" ID="Stat" name=radioX VALUE=6>すべて</TD>
</TR>

</TBODY>
</TABLE>

</td>
<td WIDTH="40%" ALIGN="left" VALIGN="bottom">
<TABLE ID="Tab_Group" BORDER="0" WIDTH="100%" CELLSPACING="0" CELLPADDING="1">
<TBODY>

<TR>
<TD nowrap ALIGN="right" WIDTH="25%" class="selectTab">グループ名：</TD><TD><INPUT type="button" id="resetOpt1" disabled style="WIDTH: 14px; HEIGHT: 14px;color:gray;" NAME="resetOpt1" value="■"></TD>
<TD WIDTH="75%"><SPAN><SELECT class="selectName" size=1 id="Opt1" name="Group" disabled></SELECT></SPAN></TD>
</TR>
<TR>
<TD nowrap ALIGN="right" class="selectTab">会社名：</TD><TD><INPUT type="button" id="resetOpt2" disabled style="WIDTH: 14px; HEIGHT: 14px;color:gray" NAME="resetOpt2" value="■"></TD>
<TD ><SPAN><SELECT class="selectName" size=1 id="Opt2" name="Usr" disabled></SELECT></SPAN></TD>
</TR>
<TR>
<TD nowrap ALIGN="right" class="selectTab">登録者：</TD><TD><INPUT type="button" id="resetOpt3" disabled style="WIDTH: 14px; HEIGHT: 14px;color:gray" NAME="resetOpt3" value="■"></TD>
<TD><SPAN><SELECT class="selectName" size=1 id="Opt3" name="uName" disabled></SELECT></SPAN></TD>
</TR>

</TBODY>
</TABLE>
</td></tr>
<tr><td colspan="3">
	 <TABLE DATASRC="#DB" BORDER='1' ID='projectTab' CELLPADDING='2' CELLSPACING='0'>
		 <THEAD class='tableHead'>
			<TR>
			   <TH WIDTH="2%">
				  状態</TH>
			   <TH WIDTH="6%" noWrap>
				  ﾌﾟﾛｼﾞｪｸﾄ<BR>
				  ｺｰﾄﾞ</TH>
			   <TH WIDTH="23%">
				  ﾌﾟﾛｼﾞｪｸﾄ名</TH>
			   <TH WIDTH="10%">
				  会社名</TH>
			   <TH WIDTH="8%" style="display:none">
				  期間</TH>
			   <TH WIDTH="8%" style="display:none">
				  規模</TH>
			   <TH WIDTH="8%" style="display:none">
				  場所</TH>
			   <TH WIDTH="5%" nowrap>
				  営業担当</TH>
			   <TH WIDTH="3%">
				  修正日</TH>
			   <TH WIDTH="5%">
				  登録者</TH>
			   <TH WIDTH="7%">
				  グループ名</TH>
			</TR>
		 </THEAD>
		 <TBODY class="body" STYLE="CURSOR: hand">
			<TR ID="TabRow">
			   <TD ID="ViewCell" ALIGN="center"><SPAN DATAFLD="Mark" dataFormatAs="HTML">◎</SPAN></TD>
			   <TD ID="ViewCell" class="pCode-pName" ALIGN="center" nowrap><SPAN DATAFLD="pCode" dataFormatAs="HTML">　</SPAN></TD>
			   <TD ID="ViewCell" class="pCode-pName"><SPAN DATAFLD="プロジェクト名" dataFormatAs="HTML">　</SPAN></TD>
			   <TD ID="ViewCell"><SPAN DATAFLD="客先会社">　</SPAN></TD>
			   <TD ID="ViewCell" style="display:none"><SPAN DATAFLD="期間">　</SPAN></TD>
			   <TD ID="ViewCell" style="display:none"><SPAN DATAFLD="規模">　</SPAN></TD>
			   <TD ID="ViewCell" style="display:none"><SPAN DATAFLD="場所">　</SPAN></TD>
			   <TD ID="ViewCell" ALIGN="center"><SPAN DATAFLD="営業">　</SPAN></TD>
			   <TD ID="ViewCell" ALIGN="center"><SPAN DATAFLD="更新日">　</SPAN></TD>
			   <TD ID="EditCell" ALIGN="center"><SPAN DATAFLD="登録者">　</SPAN></TD>
			   <TD ID="GrpCell" ALIGN="center"><SPAN DATAFLD="グループ名">　</SPAN></TD>
			</TR>
		 </TBODY>
	  </TABLE>
</td></tr>
<tr><td colspan="3">
	  <HR WIDTH="30%">
	  <TABLE ALIGN="CENTER">
		 <TR>
			<TD class='accountMark'>プロジェクトの内容を変更する時は<B>登録者名</B>をクリックしてください。</TD>
		 </TR>
		 <TR>
			<TD class='accountMark'>担当グループを変更する時は<B>グループ名</B>をクリックしてください。</TD>
		 </TR>
		 <TR>
			<TD><HR ALIGN="left" width='60%'>
			</TD>
		 </TR>
		 <TR>
			<TD class='accountMark'><IMG src='new7.gif'>：本日より１週間以内に更新された。</IMG></TD>
		 </TR>
		 <TR>
			<TD class='accountMark'><IMG src='new.gif'>：前回参照した時刻以降に更新された。</IMG></TD>
		 </TR>
		 <TR>
			<TD><HR ALIGN="left" width='60%'>
			</TD>
		 </TR>
		 <TR>
			<TD class='accountMark'><FONT COLOR="green">▲</FONT>：引合があり交渉中です</TD>
		 </TR>
		 <TR>
			<TD class='accountMark'><FONT COLOR="blue">●</FONT>：開発中</TD>
		 </TR>
		 <TR>
			<TD class='accountMark'><FONT COLOR="gray">●</FONT>：開発終了</TD>
		 </TR>
		 <TR>
			<TD class='accountMark'><FONT COLOR="gray">★</FONT>：終了(入金処理などすべて終了)</TD>
		 </TR>
		 <TR>
			<TD class='accountMark'><FONT COLOR="gray">×</FONT>：不成立となりました</TD>
		 </TR>
	  </TABLE>
</td></tr>
</table>
   </BODY>
</HTML>


<OBJECT ID="DB" classid="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" VIEWASTEXT>
   <PARAM NAME="UseHeader" VALUE="true">
   <PARAM NAME="FieldDelim" VALUE="&#9;">
   <PARAM NAME="Sort" VALUE="-pNum">
   <PARAM NAME="Filter" VALUE="newFlag > 0">
	<PARAM NAME="CharSet" VALUE="shift_jis">
	<PARAM NAME="Language" VALUE="ja">
	<PARAM NAME="DataURL" VALUE="projectDataCsv.asp">
</OBJECT>

<SCRIPT LANGUAGE="JavaScript">
var managerMenu = "<%=managerMenu%>"
var memberID	= "<%=memberID%>"
var userName	= "<%=userName%>"
var ROM = true
var curColor = ""
var selColor = "#cccc66"
var select_Line = ""
var select_pNum = ""
</SCRIPT>

<SCRIPT FOR="DB" EVENT="ondatasetcomplete()" LANGUAGE="JavaScript">
//alert(DB.recordset.recordCount)
/*
   ondatasetchanged   ………データセットが変更されたとき
   ondataavailable	  ………レコードが1つ読み込まれたとき(ステータスバーに数値表示)
   ondatasetcomplete  ………データセットがキャッシュに保存されたとき
   onreadystatechange ………
   readyState
*/
   var Cnt = DB.recordset.recordCount
   if(select_Line > Cnt) select_Line = ""
alert(Cnt);
   counterTotal(Cnt)
   setOptionData()
   curColor = "#ffaa66"

   disabledAction(false)

</SCRIPT>

<SCRIPT FOR="DB" EVENT="ondatasetchanged()" LANGUAGE="JavaScript">
//	 select_Line = ""						   // 選択行をクリア
   curColor = ""
</SCRIPT>

<SCRIPT FOR="registNew" EVENT="onclick()" LANGUAGE="JavaScript">
   if(JsIsNumeric(select_Line)){
	  var o = (DB.recordset.recordCount > 1 ? TabRow[select_Line - 1] : TabRow )
	  o.style.backgroundColor = ""										// 前の選択行を色をクリア
	  }
// プロジェクト内容の新規作成
select_Line = ""
editProject(-1)
</SCRIPT>
<SCRIPT FOR="EditCell" EVENT="onclick()" LANGUAGE="JavaScript">
   if(JsIsNumeric(select_Line)){
	  var o = (DB.recordset.recordCount > 1 ? TabRow[select_Line - 1] : TabRow )
	  o.style.backgroundColor = ""										// 前の選択行を色をクリア
	  }
   this.parentElement.style.backgroundColor = selColor												 // 新しい選択業の色を変える

   var RS = DB.recordset
   var n  = this.recordNumber
   select_Line = n

   RS.AbsolutePosition = n
   var pNum = RS.fields("pNum").Value
// プロジェクト内容の更新
   editProject(pNum)
</SCRIPT>
<SCRIPT FOR="GrpCell" EVENT="onclick()" LANGUAGE="JavaScript">
   if(JsIsNumeric(select_Line)){
	  var o = (DB.recordset.recordCount > 1 ? TabRow[select_Line - 1] : TabRow )
	  o.style.backgroundColor = ""										// 前の選択行を色をクリア
	  }
   this.parentElement.style.backgroundColor = selColor												 // 新しい選択業の色を変える

   var RS = DB.recordset
   var n  = this.recordNumber
   select_Line = n

   RS.AbsolutePosition = n
   var pNum = RS.fields("pNum").Value
// グループの更新
   editGroup(pNum)
</SCRIPT>

<SCRIPT FOR="ViewCell" EVENT="onclick()" LANGUAGE="JavaScript">
   if(JsIsNumeric(select_Line)){
	  var o = (DB.recordset.recordCount > 1 ? TabRow[select_Line - 1] : TabRow )
	  o.style.backgroundColor = ""										// 前の選択行を色をクリア
	  }
   this.parentElement.style.backgroundColor = selColor												 // 新しい選択業の色を変える
   var RS = DB.recordset
   var n  = this.recordNumber
   select_Line = n

   RS.AbsolutePosition = n
   var pNum = RS.fields("pNum").Value
   viewProject(pNum)

</SCRIPT>

</SCRIPT><SCRIPT FOR="EditCell" EVENT="onmouseover()" LANGUAGE="JavaScript">
   if( managerMenu != 1 ) return
   this.style.color = "blue"
   this.style.textDecoration = "underline"
</SCRIPT><SCRIPT FOR="EditCell" EVENT="onmouseout()" LANGUAGE="JavaScript">
   this.style.color = ""
   this.style.textDecoration = ""
</SCRIPT>
</SCRIPT><SCRIPT FOR="GrpCell" EVENT="onmouseover()" LANGUAGE="JavaScript">
   if( managerMenu != 1 ) return
   this.style.color = "blue"
   this.style.textDecoration = "underline"
</SCRIPT><SCRIPT FOR="GrpCell" EVENT="onmouseout()" LANGUAGE="JavaScript">
   this.style.color = ""
   this.style.textDecoration = ""
</SCRIPT>

<SCRIPT FOR="TabRow" EVENT="onmouseover()" LANGUAGE="JavaScript">
var n  = this.recordNumber
this.style.backgroundColor = ( n == parseInt(select_Line) ? selColor : curColor)
</SCRIPT>
<SCRIPT FOR="TabRow" EVENT="onmouseout()" LANGUAGE="JavaScript">
var n  = this.recordNumber
this.style.backgroundColor = ( n == parseInt(select_Line) ? selColor : "")
</SCRIPT>


<SCRIPT LANGUAGE="VBScript">
Function JsIsNumeric(num)
   JsIsNumeric = IsNumeric(num)
End Function
</SCRIPT>

<SCRIPT FOR="inCode" EVENT="onkeyup()" LANGUAGE="JavaScript">
// プロジェクトコード指定
chgCode()
</SCRIPT>
<SCRIPT FOR="inName" EVENT="onkeyup()" LANGUAGE="JavaScript">
// プロジェクトコード指定
chgName()
</SCRIPT>
<SCRIPT FOR="resetOpt1" EVENT="onclick()" LANGUAGE="JavaScript">
// グループ指定の解除
Opt1[0].selected = true
chgStatOption()
</SCRIPT>
<SCRIPT FOR="resetOpt2" EVENT="onclick()" LANGUAGE="JavaScript">
// 客先指定の解除
Opt2[0].selected = true
chgStatOption()
</SCRIPT>
<SCRIPT FOR="resetOpt3" EVENT="onclick()" LANGUAGE="JavaScript">
// 登録者指定の解除
Opt3[0].selected = true
chgStatOption()
</SCRIPT>

<SCRIPT FOR="Opt1" EVENT="onchange()" LANGUAGE="JavaScript">
// グループ指定
chgStatOption()
</SCRIPT>
<SCRIPT FOR="Opt2" EVENT="onchange()" LANGUAGE="JavaScript">
// 客先指定
chgStatOption()
</SCRIPT>
<SCRIPT FOR="Opt3" EVENT="onchange()" LANGUAGE="JavaScript">
// 登録者指定
chgStatOption()
</SCRIPT>
<SCRIPT FOR="Stat" EVENT="onclick()" LANGUAGE="JavaScript">
// 状態指定
chgStatOption()
</SCRIPT>



<SCRIPT LANGUAGE="JavaScript">
// 状態とグループでの絞込み
function chgStatOption()
   {
   var Buff = new Array()
   var Filter1 = getOption()
   var Filter2 = getStat()

   if( Filter1 != "" ) Buff[Buff.length] = "(" + Filter1 + ")"
   if( Filter2 != "" ) Buff[Buff.length] = "(" + Filter2 + ")"

   DB.Filter = Buff.join("&")
   DB.Reset()											  // リロードしない
   inCode.innerText = ""							   // ｺｰﾄﾞ入力域をクリア
   inName.innerText = ""							   // ｺｰﾄﾞ入力域をクリア
   }
   
// オプションデータの作り直し
function setOptionData()
   {
   var Name = Array("グループ名","客先会社","登録者")
   var Tab1 = new Object
   var Tab2 = new Object
   var Tab3 = new Object
   var d1,d2,d3
	  
   if(Opt1.selectedIndex != -1) d1 = Opt1[Opt1.selectedIndex].value
   if(Opt2.selectedIndex != -1) d2 = Opt2[Opt2.selectedIndex].value
   if(Opt3.selectedIndex != -1) d3 = Opt3[Opt3.selectedIndex].value
/*****************************************************************/   
   var RS = DB.recordset
   var n

	if( RS.recordCount == 0 ) return
	if( RS.recordCount > 0){
	   RS.MoveFirst()
	   while(!RS.EOF){
		  value = RS.fields(Name[0]).Value
		  if( !IsObject(Tab1[value]) && value != "　") Tab1[value] = value
		  value = RS.fields(Name[1]).Value
		  if( !IsObject(Tab2[value]) && value != "　") Tab2[value] = value
		  value = RS.fields(Name[2]).Value
		  if( !IsObject(Tab3[value]) && value != "　") Tab3[value] = value
		  RS.MoveNext()
		  }
		}
/*****************************************************************/   
   var Obj,i,d
   Obj = Opt1.options
   var Tab = new Array()
   for( var n in Tab1) Tab[Tab.length] = Tab1[n]
   Tab.sort()
   Obj.length = 0
   Obj[0]=new Option("","")
   for(var i = 0; i < Tab.length; i++ ){
	  d = Tab[i]
	  n = Obj.length
	  Obj[n]=new Option(d,d)
	  if( d == d1 ) Obj[n].selected = true
	  }

   Obj = Opt2.options
   var Tab = new Array()
   for( var n in Tab2) Tab[Tab.length] = Tab2[n]
   Tab.sort()
   Obj.length = 0
   Obj[0]=new Option("","")
   for(var i = 0; i < Tab.length; i++ ){
	  d = Tab[i]
	  n = Obj.length
	  Obj[n]=new Option(d,d)
	  if( d == d2 ) Obj[n].selected = true
	  }

   Obj = Opt3.options
   var Tab = new Array()
   for( var n in Tab3) Tab[Tab.length] = Tab3[n]
   Tab.sort()
   Obj.length = 0
   Obj[0]=new Option("","")
   for(var i = 0; i < Tab.length; i++ ){
	  d = Tab[i]
	  n = Obj.length
	  Obj[n]=new Option(d,d)
	  if( d == d3 ) Obj[n].selected = true
	  }
   }
	
// グループでの絞込み
function getOption()
   {
   var Dic,Tab
   var Name = Array("グループ名","客先会社","登録者")
   var Buff = Array()
   var value

   value = ( Opt1.selectedIndex >= 0 ? Opt1[Opt1.selectedIndex].value : "" )
   if(value != ""){
	  Buff[Buff.length] = Name[0] + "=" + value
	  }
   value = ( Opt2.selectedIndex >= 0 ? Opt2[Opt2.selectedIndex].value : "" )
   if(value != ""){
	  Buff[Buff.length] = Name[1] + "=" + value
	  }
   value = ( Opt3.selectedIndex >= 0 ? Opt3[Opt3.selectedIndex].value : "" )
   if(value != ""){
	  Buff[Buff.length] = Name[2] + "=" + value
	  }

   value = Buff.join("&")
   return(value)
   }

// 状態指定での絞込み
function getStat()
   {
   var Buff,flag

   for(var i = 0; i < Stat.length; i++ ){
	  if(Stat[i].checked == true) break;
	  }

   switch(Stat[i].value){
	  case "0":
		 Buff = "newFlag > 0"			// 更新のみ
		 break;   
	  case "1":
		 Buff = "Stat=0";				// 引合中
		 break;   
	  case "2":
		 Buff = "Stat=1";				// 開発中
		 break;   
	  case "3":
		 Buff = "Stat=4";				// 開発終了
		 break;   
	  case "4":
		 Buff = "Stat=5";				// 終了
		 break;   
	  case "5":
		 Buff = "Stat=-1";				// 没
		 break;   
	  case "6":
		 Buff = "Stat=*";				// すべて
		 break;   
	  default:
		 Buff = "";						// すべて
		 break;   
		 }
   return(Buff)
   }

//====================================================================
// コード指定での絞込み
function chgCode()
   {
   var Buff
   Buff = (inCode.value).toUpperCase()	 
   inCode.value = Buff

   Buff = "pCode = " + Buff + "*"
   DB.Filter = Buff
   DB.Reset()										// リロードしない

   inName.innerText = ""
   Stat[6].checked = true							// 状況をすべてに
   Opt1[0].selected = true							// グループﾘｾｯﾄ
   Opt2[0].selected = true							// グループﾘｾｯﾄ
   Opt3[0].selected = true							// グループﾘｾｯﾄ
   }
   
// コード指定での絞込み
function chgName()
   {
   var Buff
   Buff = inName.value
   inName.value = Buff

   Buff = "プロジェクト名 = *" + Buff + "*"
   DB.Filter = Buff
   DB.Reset()										// リロードしない

   inCode.innerText = ""
   Stat[6].checked = true							// 状況をすべてに
   Opt1[0].selected = true							// グループﾘｾｯﾄ
   Opt2[0].selected = true							// グループﾘｾｯﾄ
   Opt3[0].selected = true							// グループﾘｾｯﾄ
   }
   
function selOption(Opt,value)
   {
   for( i = 0; i < Opt.length; i++ ){
	  if(Opt[i].value == value){
		 Opt[i].selected = true
		 return
		 }
	  }
   Opt[0].selected = true
   }

function IsObject(o)
   {
   if( typeof(o) != "undefined" ) return(true)
   return(false)
   }

</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function counterTotal(recCnt){
   spanTotal.innerText = recCnt;
   }
function disabledAction(mode)
   {
   registNew.value = (mode == true ? "登録中" : "新規登録")
   registNew.disabled = mode
   inCode.disabled = mode
   inName.disabled = mode
//	 Tab_Stat.disabled = mode
   Opt1.disabled = mode
   Opt2.disabled = mode
   Opt3.disabled = mode
   resetOpt1.disabled = mode
   resetOpt2.disabled = mode
   resetOpt3.disabled = mode
   }
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
// 詳細表示処理を呼ぶ
function viewProject(pNum)
   {
	if( managerMenu != 1 ) return
   var strCmd;
   strCmd = "?pNum=" + pNum;
   subWin.open("viewProject.asp" + strCmd)
   }
// 登録処理を呼ぶ
function editProject(pNum)
   {
	if( managerMenu != 1 ) return
	if( userName == "不明" ){
		alert("ログイン者が不明です")
		return
		}

   subWin.close()

	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var URL = "editProject.asp"
	URL += "?TimeStamp=" + TimeStamp

   var Buff = new Object
   var windowOption
   var value
   Buff.pNum  = pNum
   windowOption  = "dialogWidth:750px;dialogHeight:650px;"
   windowOption += "status:no;scroll:yes;"
   value = window.showModalDialog(URL,Buff,windowOption)
   pNum = Buff.pNum
//alert(value + "][" + pNum)
   if( value ) updateList(pNum)
   }
function editGroup(pNum)
   {
	if( managerMenu != 1 ) return
	if( userName == "不明" ){
		alert("ログイン者が不明です")
		return
		}

   subWin.close()

	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var URL = "editGroup.asp"
	URL += "?TimeStamp=" + TimeStamp

   var Buff = new Object
   var windowOption
   var value
   Buff.pNum  = pNum
   windowOption  = "dialogWidth:700px;dialogHeight:600px;"
   windowOption += "status:no;scroll:yes;"
   value = window.showModalDialog(URL,Buff,windowOption)
   pNum = Buff.pNum
   if( value ) updateList(pNum)
   }


// 登録後の処理
function updateList(pNum)
   {
   if( pNum > 0 ){
	  disabledAction(true)								// すべての操作を禁止


	  select_pNum = pNum
	  DB.Filter = ""
	  DB.DataURL = DB.DataURL
	  DB.Reset()										// リロードする

	  chgStatOption()

	  }
   }

function selectLine()
   {
   var selPos = ""
   var RS = DB.recordset
   var Cnt = RS.recordCount
   for( var i = 1; i <= Cnt; i++){
	  if(RS.fields("pNum").Value == select_pNum) selPos = i
	  }
   if(JsIsNumeric(selPos)){
	  TabRow[selPos-1].style.backgroundColor = selColor 			   // 選択状態を解除
	  }
   }

function dispObj(obj)
   {
   var Buff = ""
   var i,pos
   pos = 0
   for( i in o = obj ){
	  Buff += ("["+i + "]=" + o[i] + "　")
	  if( ++pos % 3 == 0 ) Buff += "\n"
	  }
   alert(Buff)
   }

</SCRIPT>
<SCRIPT Language="JavaScript">
var subWin
function newWindow(winName,width,height)
   {
$.alert("newWindow");
   this.ID = null
   this.name = winName
   this.width = width
   this.height = height
   this.misc = "scrollbars,resizable,status=no"
   }

newWindow.prototype.open = function(url)
   {
$.alert("open");
   var attrib
   attrib  = " width="	+ this.width 
   attrib += " height=" + this.height
   attrib += " "		+ this.misc
   this.ID = window.open(url,this.winName,attrib);
   }
   
newWindow.prototype.close = function()
   {
$.alert("close");
   if(this.ID != null && !this.ID.closed) this.ID.close();
   }
</SCRIPT>
<SCRIPT FOR="window" EVENT="onload()" LANGUAGE="JavaScript">
try{
$.alert("ブラウザ：",$.getBrowser());

   if( managerMenu == 1 ) registNew.style.display = ""
$.alert("onload")
   subWin = new newWindow("viewWindow",600,700)
alert("onload1")
   disabledAction(false)								// すべての操作を許可
alert("onload5")

}catch(e){
$.alert(e.message)
}
</SCRIPT>

<SCRIPT FOR="window" EVENT="onunload()" LANGUAGE="JavaScript">
   subWin.close()
</SCRIPT>


