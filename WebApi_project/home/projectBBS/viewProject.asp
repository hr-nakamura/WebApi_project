<%@ Language=JScript %>
<!--#include virtual="/Project/Auth/projectLog.inc"-->
<!--#include file="cmn.inc"-->
<html>

<head>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

<title>掲示内容表示</title>
<LINK rel="stylesheet" type="text/css" href="dialog.css">
</head>

<body background="back.gif">
<%
	var pNum = String(Request("pNum"));
	cr();
	if( !IsEmpty(pNum) && pNum != -1 ){
		main();
		}
%>
</body>
</html>

<%
function main()
	{
	var pNum = String(Request("pNum"));
	
	DB = Server.CreateObject("ADODB.Connection");
	DB.Open( Session("ODBC") );
	   DB.DefaultDatabase = "kansaDB"

	tableBegin("class='viewOutsideFrame' ALIGN='CENTER' border='0' cellpadding='0' cellspacing='0'");
	tableBodyBegin("");
	
// ここにプロジェクト情報＋グループ履歴を表示
	tableRowBegin("");
	tableDataCellBegin("");
	bbsTitle(DB,pNum);
	pn("<BR>");
	tableDataCellEnd();
	tableRowEnd();
	
// ここにグループ履歴を表示
	tableRowBegin("");
	tableDataCellBegin("");
	dispGroupHistory(DB,pNum);
	pn("<BR>");
	tableDataCellEnd();
	tableRowEnd();
	
// ここに売上履歴を表示
	tableRowBegin("");
	tableDataCellBegin("");
	dispSalesHistory(DB,pNum);
	pn("<BR>");
	tableDataCellEnd();
	tableRowEnd();
	
// ここに開発要員のる歴を表示
	tableRowBegin("");
	tableDataCellBegin("");
	dispMemberHistory(DB,pNum);
	pn("<BR>");
	tableDataCellEnd();
	tableRowEnd();
	
	tableBodyEnd();
	tableEnd();
	
	DB.Close();
	}	

//------------------------------------------------------------------------
//	ﾌﾟﾛｼﾞｪｸﾄ詳細
//------------------------------------------------------------------------

function bbsTitle(DB,pNum)
	{
	var pCode = "";
	var yymm
	
	yymm = (parseInt(pNum / 1000) * 100) + 04
	
	RS = Server.CreateObject("ADODB.Recordset")
	SQL  = "SELECT ";
	SQL +=	  "Stat         = Stat,"
	SQL +=	  "pNum         = pNum,"
	SQL +=	  "pCode        = pCode,"
	SQL +=	  "pName        = pName,"
	SQL +=	  "makeDate     = makeDate,"
	SQL +=	  "editDate     = editDate,"
	SQL +=	  "corpName     = corpName,"
	SQL +=	  "担当PM       = (SELECT 姓 + '　' + 名 FROM EMG.dbo.社員基礎データ WHERE 社員ID = 担当PM),"
	SQL +=	  "Title        = Title,"
	SQL +=	  "Content      = Content,"
	SQL +=	  "blockName    = '名前' "
	SQL += " FROM"
	SQL +=	 " projectNum"
	SQL += " WHERE"
	SQL += "   pNum = " + pNum
	
	RS = DB.Execute(SQL)
	
	if( !RS.EOF ){
		Stat		 = RS.Fields("Stat").Value
		pNum		 = RS.Fields("pNum").Value
		pCode		 = RS.Fields("pCode").Value
		pName		 = RS.Fields("pName").Value
		corpName	 = RS.Fields("corpName").Value
		担当PM		 = RS.Fields("担当PM").Value
		mDate		 = new Date(RS.Fields("makeDate").Value)
		eDate		 = new Date(RS.Fields("editDate").Value)
		
		pTitle		 = RS.Fields("Title").Value
		pContent	 = RS.Fields("Content").Value
		Work = pTitle.split("\n")
		}
	
	RS.Close();
	
//------------------------------------------------------------------------

	tableBegin("class='viewInsideFrame' ALIGN='CENTER' border='0' cellPadding='0' cellSpacing='0'");
	
	tableHeadBegin("");
	tableHeadEnd();
	
	tableFootBegin("");
	tableFootEnd();
	
	var capStr_m = "【登録：" + mDate.toLocaleString() + "】";
	var capStr_u = "【更新：" + eDate.toLocaleString() + "】";
	
	tableBodyBegin("");
	
	tableRowBegin("");
	tableDataCell("class='PROJECT-NAME' colSpan='3' nowrap",pCode);
	tableRowEnd();
	
	tableRowBegin("");
	tableDataCell("class='PROJECT-NAME' colSpan='3' nowrap",pName);
	tableRowEnd();
	
	newMark = "";
	if( eDate > new Date(session("beforBBS")) ) newMark = "<IMG src='new7.gif'>";
	if( eDate > new Date(session("visitBBS")) ) newMark = "<IMG src='new.gif'>";
/*	
	if(!IsEmpty(newMark)){
		tableRowBegin("valign='middle'");
		tableDataCell("","");
		tableDataCell("class='renewalDATE' align='right'",newMark + capStr_u);
		tableRowEnd();
		}
*/	
	tableRowBegin("valign='middle'");
	tableDataCell("ALIGN='LEFT'",cnvStatMark(Stat));	// 引合状況
	tableDataCell("class='entryDATE' align='right'",capStr_m);
	tableDataCell("class='renewalDATE' align='right'",newMark + capStr_u);
	tableRowEnd();
	tableBodyEnd();
	tableEnd();
	
//-----------------------------------------------------------------------------------

	tableBegin("class='insideFrameColor' ALIGN='CENTER'");
	
	tableHeadBegin("");
	tableRowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'");
	tableHeadCell("width='20%'","項　目");
	tableHeadCell("width='80%' colSpan='3'","内　　容");
	tableRowEnd();
	tableHeadEnd();
	
	tableFootBegin("");
	tableFootEnd();
	
	tableBodyBegin("bgcolor='snow'");
	
	usrWork = "<b>" + corpName + "</b><BR>　" + Work[1] + "<BR>　　" + Work[2];	// 会社名+部署名+客先担当者
	
	tableRowBegin("valign='middle'");
	tableDataCell("ALIGN='CENTER'width='20%'","客先名");
	tableDataCell("ALIGN='LEFT' colSpan='3'",usrWork);		// 客先情報
	tableRowEnd();
	
	tableRowBegin("valign='middle'");
	tableDataCell("ALIGN='CENTER'width='20%'","開発条件");
	tableDataCell("ALIGN='LEFT'width='40%'",Work[4]);		// 開発期間
	tableDataCell("ALIGN='LEFT'width='20%'",Work[5]);		// 開発規模
	tableDataCell("ALIGN='LEFT'width='20%'",Work[6]);		// 開発場所
	tableRowEnd();
	
//------------------------------

	tableRowBegin("valign='middle'");
	tableDataCell("ALIGN='CENTER'width='20%'","概要");
	tableDataCellBegin("ALIGN='LEFT' colSpan='3'");
	//p("<TT>");
	textOut( String(pContent) );
	//p("</TT>");
	tableDataCellEnd();
	tableRowEnd();

//------------------------------

	tableRowBegin("valign='middle' bgcolor='powderblue'");
	tableDataCell("ALIGN='CENTER'width='20%'","営業担当");
	tableDataCell("ALIGN='LEFT'colSpan='3'",Work[3]);				 // 営業担当
	tableRowEnd();
	
	tableRowBegin("valign='middle' bgcolor='powderblue'");
	tableDataCell("ALIGN='CENTER'width='20%'","担当PM");
	tableDataCell("ALIGN='LEFT'colSpan='3'",担当PM);				 // 営業担当
	tableRowEnd();
	

	tableBodyEnd();
	tableEnd();
	}

function cnvStatMark(stat)
	{
	var Str = "";
	switch(parseInt(stat)){
		case 0 :
			Str = "▲".fontcolor("green") + "引合中".big();
			break;
		case 1 :
			Str = "●".fontcolor("blue")  + "開発中".big();
			break;
		case 4 :
			Str = "●".fontcolor("gray")  + "開発終了".big();
			break;
		case 5 :
			Str = "★".fontcolor("gray")  + "終了".big();
			break;
		case -1 :
			Str = "×".fontcolor("gray")  + "没".big();
			break;
		default:
			Str = "";
		}
	return(Str);
	}
   

function txtOut(Str)
   {
   len = Str.length;
   pCount = 0;
   for(i = 0; i < len; i++){
	  c = Str.charAt(i);
	  u = escape(c);
	  if( u.substring(0,2) == "%u" ){
		 if(u.substring(2,4) != "FF" ){
			pCount++;
			}
		 }
	  p(c);
	  pCount++;
	  if( c == "\n" ){
		 pCount = 0;
		 }
	  else if(pCount >= 60){
		 p("\n");	
		 pCount = 0;
		 }
	  }
   }
  
function getNewItem(DB,iName,chkDate)
   {
   var num = new Array();
   var i = 0;
   var strDate = convertDate(chkDate) + " " + convertTime(chkDate);

   var RS = Server.CreateObject("ADODB.Recordset");

   SQL	= "SELECT " + iName;
   SQL += " FROM projectBBS";
   SQL += " WHERE editDate > '" + strDate + "'";
   RS.Open( SQL, DB, 3, 3);
   while( !RS.EOF ){
	  num[i++] = RS.Fields(iName).Value;
	  RS.MoveNext();
	  }
   RS.Close();

   num.sort()

   return(num);
   }

function chkNewItem(item,chkItem)
   {
   var chkStr = chkItem;
   var Len = item.length;
   for( i = 0; i < Len; i++){
	  if( item[i] == chkItem ) return(true);
	  }
   return(false)
   }

function getNewItemX(DB,iName,chkDate)
   {
   var num = new Array();
   var i = 0;
   var strDate = convertDate(chkDate) + " " + convertTime(chkDate);

   var RS = Server.CreateObject("ADODB.Recordset");

   SQL	= "SELECT " + iName;
   SQL += " FROM projectBBS";
   SQL += " WHERE editDate > '" + strDate + "'";
   RS.Open( SQL, DB, 3, 3);
   while( !RS.EOF ){
	  num[i++] = "[" + RS.Fields(iName).Value + "]";
	  RS.MoveNext();
	  }
   RS.Close();

   num.sort()

   return(num);
   }

function chkNewItemX(s,chkItem)
   {
   var chkStr = "[" + chkItem + "]";
   if(s.indexOf(chkStr) < 0) return(false);
   return(true);
   }
   

// ここにグループ履歴を表示
//------------------------------------------------------------------------
//	グループ履歴
//------------------------------------------------------------------------
function dispGroupHistory(DB,pNum)
   {
	var Tab = getGroupHistoryInfo(DB,pNum)
	
	tableBegin("class='insideFrameColor' ALIGN='CENTER'")
	tableCaption("class='SUB'","グループ履歴")
	
	tableHeadBegin("")
	tableRowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'")
	tableHeadCell("ALIGN='CENTER' nowrap　WIDTH='30%'","開始年月");
	tableHeadCell("ALIGN='CENTER' colspan='3' nowrap WIDTH='70%'","開発グループ");
	tableRowEnd()
	tableHeadEnd()
	
	var gName,s
	
	tableBodyBegin("bgcolor='snow'");
	tableRowBegin("");
	for( n in Tab){
	  s = Tab[n].s
	  gName = Tab[n].gName
	  tableDataCell("ALIGN='CENTER'",strMonth(s))
	  tableDataCell("colspan='3'",gName)
	  tableRowEnd()
	  }
	
	tableRowEnd()
	tableBodyEnd()
	tableEnd()
	}
		
//------------------------------------------------------------------------
//	売上履歴
//------------------------------------------------------------------------
function dispSalesHistory(DB,pNum)
   {
   var Tab = getSalesHistoryInfo(DB,pNum)

   tableBegin("class='insideFrameColor' ALIGN='CENTER'")
   tableCaption("class='SUB'","売上履歴")
  
   tableHeadBegin("")
   tableRowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'")
   tableHeadCell("WIDTH='30%' nowrap","月")
   tableHeadCell("WIDTH='30%' nowrap","グループ名");
   tableHeadCell("WIDTH='20%' nowrap","予測");
   tableHeadCell("WIDTH='20%' nowrap","実績");
   tableRowEnd()
   tableHeadEnd()
  
   tableBodyBegin("bgcolor='snow'");
   var pCode,pName,gName

   var yymm,gName,plan,actual
   for( yymm in Tab){
	  gName = Tab[yymm].gName
	  plan = Tab[yymm].plan
	  actual = Tab[yymm].actual
	  tableRowBegin("")
	  tableDataCell("ALIGN='CENTER'",strMonth(yymm))
	  tableDataCell("",gName)
	  tableDataCell(" ALIGN='RIGHT'",(plan == 0 ? "　" : formatNum(plan,0)) )
	  tableDataCell(" ALIGN='RIGHT'",(actual == 0 ? "　" : formatNum(actual,0)) )
	  tableRowEnd()
	  }
   tableBodyEnd()
   tableEnd()
   }

//------------------------------------------------------------------------
//	グループ履歴
//------------------------------------------------------------------------
function dispMemberHistory(DB,pNum)
	{
	var Tab = getMemberHitory(DB,pNum)
	
	tableBegin("class='insideFrameColor' ALIGN='CENTER'")
	
	tableCaption("class='SUB'","作業人員")
		
	tableHeadBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'")
	tableRowBegin("")
	tableHeadCell("WIDTH='30%' nowrap","名前")
	tableHeadCell("WIDTH='50%' nowrap colspan='2'","作業期間")
	tableHeadCell("WIDTH='20%' nowrap","作業日数")
	tableRowEnd()
	tableHeadEnd()
	
	tableBodyBegin("bgcolor='snow'")
	
	var yymm, name, period, days
	for( yymm in Tab){
		name = Tab[yymm].name
		period = Tab[yymm].period
		days = Tab[yymm].days
		tableRowBegin("")
		tableDataCell("ALIGN='CENTER' nowrap",name)
		tableDataCell("ALIGN='CENTER' nowrap colspan='2'",period)
		tableDataCell("ALIGN='CENTER'",days)
		tableRowEnd()
		}
		
	tableBodyEnd()
	tableEnd()
	}

//---------------------------------------------------------------------------------

function textOut(Str)
   {
   var c;
   var len = Str.length;

   for( var i = 0; i < len; i++){
	  c = Str.charAt(i);
	  if( c == "\n" ) Response.Write("<BR>");
	  else			  Response.Write(c);
	  }
   }
%>
<%
function getGroupHistoryInfo(DB,pNum)
   {
   var toDay = new Date()
   var yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)
   
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL

   var Tab = new Array()
   
   SQL	= " SELECT"
   SQL +=	" 開始 = 業務部署データ.開始,"
   SQL +=	" 終了 = 業務部署データ.終了,"
   SQL +=	" 部署 = 業務部署データ.部署ID,"
   SQL +=	" 名前 = 部署マスタ.部署名"
   SQL += " FROM"
   SQL +=	" 業務部署データ inner join 部署マスタ on 業務部署データ.部署ID = 部署マスタ.部署コード"
   SQL += " WHERE"
   SQL += "   業務部署データ.pNum = " + pNum
   SQL += " ORDER BY"
   SQL += "   業務部署データ.開始 DESC"

   RS = DB.Execute(SQL)
   var n,s_yymm,e_yymm,gName,gID
   while(!RS.EOF){
	  s_yymm = RS.Fields('開始').Value
	  e_yymm = RS.Fields('終了').Value
	  gID	 = RS.Fields('部署').Value
	  gName  = RS.Fields('名前').Value
	  n = Tab.length
	  Tab[n] = new Object
	  Tab[n].s	   = s_yymm
	  Tab[n].e	   = e_yymm
	  Tab[n].gID   = gID
	  Tab[n].gName = gName
	  RS.MoveNext()
	  }

   RS.Close()
   return(Tab)
   }

function getSalesHistoryInfo(DB,pNum)
   {
   var Dic = new getGroupDic(DB)
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL

   SQL = ""
   SQL += " SELECT"
   SQL += "    yymm   = 売上予測実績データ.yymm,"
   SQL += "    mode   = 売上予測実績データ.mode,"
   SQL += "    gCode  = 業務部署データ.部署ID,"
   SQL += "    amount = Sum(売上予測実績データ.金額)"
   SQL += " FROM"
   SQL += " 	(売上予測実績データ INNER JOIN 業務部署データ ON 売上予測実績データ.pNum = 業務部署データ.pNum)"
   SQL += " WHERE"
   SQL += "    売上予測実績データ.pNum = '" + pNum + "'"
   SQL += "    AND"
   SQL += "    (売上予測実績データ.yymm Between 業務部署データ.開始 And 業務部署データ.終了)"
   SQL += " GROUP BY"
   SQL += "    売上予測実績データ.yymm,"
   SQL += "    売上予測実績データ.mode,"
   SQL += "    業務部署データ.部署ID"
   SQL += " ORDER BY"
   SQL += "    売上予測実績データ.yymm DESC,"
   SQL += "    業務部署データ.部署ID"

   RS = DB.Execute(SQL)
   var n,pNum,amount,gCode,c_yymm,mode
   var Tab = new Object
   while(!RS.EOF){
	  c_yymm  = RS.Fields('yymm').Value
	  mode	  = RS.Fields('mode').Value
	  gCode   = RS.Fields('gCode').Value
	  amount  = RS.Fields('amount').Value

	  if( !IsObject(Tab[c_yymm]) ){
		 Tab[c_yymm] = new Object
		 Tab[c_yymm].gName	= Dic.Item(gCode)
		 Tab[c_yymm].plan	= 0
		 Tab[c_yymm].actual = 0
		 }
	  if( mode == 0 ) Tab[c_yymm].actual= amount
	  else			  Tab[c_yymm].plan	= amount

	  RS.MoveNext()
	  }

   RS.Close()
   Dic = null
   
   return(Tab)

   }

//===========================================================================================
function getGroupDic(DB)
   {
//	 if(!dic.Exists(key))		   //未登録ならば抜ける
//	 pr(dic.Item(key))			   //値を表示する
   this.dic = new ActiveXObject("Scripting.Dictionary")
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL
   SQL	= " SELECT"
   SQL += "    gCode = 部署コード,"
   SQL += "    gName = 部署名"
   SQL += " FROM"
   SQL +=	" EMG.dbo.部署マスタ"
   SQL += " ORDER BY"
   SQL += "    部署コード"
   RS = DB.Execute(SQL)
   var gCode,gName
   while(!RS.EOF){
	  gCode  = RS.Fields('gCode').Value
	  gName  = RS.Fields('gName').Value
	  this.dic.Add(gCode,gName)
	  RS.MoveNext()
	  }
   RS.Close()
   return(this.dic)
   }
function IsObject(o)
   {
   if( typeof(o) != "undefined" ) return(true)
   return(false)
   }


function getMemberHitory(DB,pNum)
	{
	RS = Server.CreateObject("ADODB.Recordset");
	
	var SQL
	var Tab = new Array()
	
	SQL = ""
	SQL += " SELECT"
	SQL +=		" 姓 = EMG.dbo.社員基礎データ.姓,"
	SQL +=		" 名 = EMG.dbo.社員基礎データ.名,"
	SQL +=		" 開始 = MIN(EMG.dbo.勤務日データ.日付),"
	SQL +=		" 終了 = MAX(EMG.dbo.勤務日データ.日付),"
	SQL +=		" 日数 = COUNT(EMG.dbo.勤務日データ.memberID)"
	
	SQL += " FROM"
	SQL +=			" (EMG.dbo.勤務日データ INNER JOIN projectNum             ON EMG.dbo.勤務日データ.pNum     = projectNum.pNum)"
	SQL +=			"                       INNER JOIN EMG.dbo.社員基礎データ ON EMG.dbo.勤務日データ.memberID = EMG.dbo.社員基礎データ.社員ID"
	
	SQL += " WHERE"
	SQL += "	projectNum.pNum = " + pNum
		
	SQL += " GROUP BY"
	SQL += "	EMG.dbo.社員基礎データ.姓,"
	SQL += "	EMG.dbo.社員基礎データ.名"
	
	SQL += " ORDER BY"
	SQL +=		" MIN(EMG.dbo.勤務日データ.日付),"
	SQL +=		" MAX(EMG.dbo.勤務日データ.日付)"
	RS = DB.Execute(SQL)

	var n, lName, oName, sDate, eDate, days
	while(!RS.EOF){
		lName = RS.Fields('姓').Value
		oName = RS.Fields('名').Value
		sDate = JsFormatDateTime(RS.Fields('開始').Value, 2)
		eDate = JsFormatDateTime(RS.Fields('終了').Value, 2)
		days = RS.Fields('日数').Value
		n = Tab.length
		Tab[n] = new Object
		Tab[n].name = lName + "　" + oName
		Tab[n].period = sDate + "　～　" + eDate
		Tab[n].days = days
		RS.MoveNext()
		}
	
	RS.Close()
	return(Tab)
	}
	
%>


<SCRIPT FOR="window" EVENT="onload()" LANGUAGE="JavaScript">
window.focus()
</SCRIPT>
