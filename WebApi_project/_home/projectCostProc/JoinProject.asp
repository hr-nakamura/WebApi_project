<%@ Language=JScript %>
<!--#include virtual="/Project/Auth/projectLog.inc"-->
<!--#include virtual="/inc/cmn.inc"-->
<!--#include virtual="/inc/dispXML.inc"-->
<%
try{

	var actual_yymm = (Request.QueryString("actual_yymm").Count  == 0 ? "" : Request.QueryString("actual_yymm").Item)

var pNum = "520158001,20162159,20162375"
//pNum = ""
	pNum = (Request.QueryString("pNum").Count  == 0 ? pNum : Request.QueryString("pNum").Item)

var JoinItem   = ""
var Join_mID   = "0"
    JoinItem   = (Request.QueryString("item").Count  == 0 ? JoinItem : Request.QueryString("item").Item)
    Join_mID   = (Request.QueryString("mID").Count  == 0 ? Join_mID : Request.QueryString("mID").Item)
    
    
//	var yymm   = (Request.QueryString("pNum").Count  == 0 ? 201110	 : Request.QueryString("yymm"))
//	var mCnt   = (Request.QueryString("pNum").Count  == 0 ? 12		 : Request.QueryString("mCnt"))

	var memberID = Session("memberID")

	var editMode = check_pNum(pNum)


}catch(e){pr(e.message)}

function check_pNum(pNum)
	{
	var pNumTab = String(pNum).split(",")
	if( pNumTab.length > 1 ) return(0)
	
	var DB = Server.CreateObject("ADODB.Connection")
	var RS = Server.CreateObject("ADODB.Recordset")

//===========================================================================================
	DB.Open( Session("ODBC") )
	DB.DefaultDatabase = "kansaDB"

	var SQL = ""
	var stat = 0
	SQL  = " SELECT"
	SQL += "    pNum"
	SQL += " FROM"
	SQL += "    projectNum"
	SQL += " WHERE"
	SQL += "    Project IN(0,1,2)"
	SQL += "    AND"
	SQL += "    pNum = '" + pNum + "'"
	RS = DB.Execute(SQL)
	if( !RS.EOF ){
		pNum = RS.Fields("pNum").Value
		stat = 1
		}
	RS.Close()
	return(stat)
	}

%>


<HTML>
<head>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

<link rel="stylesheet" type="text/css" href="cost.css"/>

<SCRIPT language="JavaScript" src="/Project/inc/xmlDebug.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/Project/inc/TreeLine.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/Project/inc/iFrame_Window.js"></SCRIPT>

<SCRIPT Language="JavaScript">
var actual_yymm    = "<%=actual_yymm%>"
var JoinItem       = "<%=JoinItem%>"
var Join_mID       = "<%=Join_mID%>"
var xsl_head	   = "xsl/projectDisp_Head.xsl"
var xsl_body_input = "xsl/projectDisp_Input.xsl"
var xsl_body_data  = "xsl/projectDisp_Data.xsl"
var xsl_body_status  = "xsl/projectDisp_Status.xsl"

var xml_main	   = "xml/projectInfo_XML_Join.asp"
var xmlDoc
var xslDoc

var xml_Detail	   = "xml/projectInfo_XML_Detail.asp"
var xsl_Detail	   = "xsl/projectDisp_Detail.xsl"
var xml_Detail2	   = "test/projectInfo_XML_Detail2.asp"
var xsl_Detail2	   = "test/projectDisp_Detail2.xsl"

var grph_asp	   = "grph/payCost_GRPH.asp"
var i_Window

var debugObj = null

//var xml_tree	   = "xml/projectTree_XML.asp"
//var xsl_tree	   = "xsl/projectTree.xsl"
var xml_tree	   = "/Project/common_data/dispProjectTree/projectTree_XML.asp"
var xsl_tree	   = "/Project/common_data/dispProjectTree/projectTree.xsl"


var editMode       = "<%=editMode%>"
var editName       = "editManPower/edit_作業工数.asp"
var eventInfoMode  = "0"
</SCRIPT>



<SCRIPT FOR="TEST" EVENT="onclick" language="JavaScript">
try{
debugObj.xmlOut(xmlDoc)

}catch(e){alert(e.message)}
</SCRIPT>

<SCRIPT Language="JavaScript">
var updateFlag = false
var curColor="pink"

</SCRIPT>

<SCRIPT Language="JavaScript">
var aspObj	   = null
var updateFlag = false

var pNum	   = "<%=pNum%>"
var memberID   = "<%=memberID%>"
var mCnt	   = 4

var sub = null
var Detail_Tab = {売上実績:"売上実績",業務費用:"業務費用",協力費用:"協力費用",協力工数:"協力工数",社員工数:"社員工数",パート工数:"パート工数",協力工数:"協力工数",労務費:"労務費"}
var subWin = null
var subWinAspName = "itemWindow.asp"
var subWinName	  = "dispDetail"

function newWindow(winName,width,height)
   {
   this.ID = null
   this.name = winName
   this.misc = "scrollbars,resizable,status=no,width=10,height=10"
   }

newWindow.prototype.open = function(url)
   {
   this.ID = window.open(url,this.name,this.misc);
   }
   
newWindow.prototype.close = function()
   {
   if(this.ID != null && !this.ID.closed) this.ID.close();
   }
</SCRIPT>


<SCRIPT Language="JavaScript">
function loadXML(pNum,xml_name,actual_yymm)
	{
	var pTab = new Array()
	var para  = ""
	if( actual_yymm != "" ) pTab.push("actual_yymm="  + actual_yymm )
	if( pNum  != "" ) pTab.push("pNum="  + pNum )
	if( JoinItem  != "" ) pTab.push("item="  + JoinItem )
	if( Join_mID  != "" ) pTab.push("mID="  + Join_mID )
	
	var xml = xml_name + "?" + pTab.join("&")
	var xmlDoc = new ActiveXObject("Microsoft.XMLDom");
	xmlDoc.async = false;
	var ret = xmlDoc.load(xml);
	if( !ret ) alert("ERROR:" + xml) 

	return(xmlDoc)
	}

function convertXSL(xmlDoc,xsl_name)
	{
	xslDoc = new ActiveXObject("Microsoft.XMLDom");
	xslDoc.async = false;
	var ret = xslDoc.load(xsl_name);
	if( !ret ) alert("ERROR:" + xml) 
	var Buff = xmlDoc.transformNode(xslDoc)
	return( Buff );
	}

function grphDisp(xmlDoc)
	{
	var ret
	var httpObj = createXMLHttpRequest();
	if(httpObj){
		ret = httpObj.open("POST",grph_asp,false);
		ret = httpObj.send(xmlDoc);
		if( httpObj.status != 200){
			alert("エラー：" + httpObj.status )
			}
//alert((httpObj.responseText).length)
		grphBox.src = httpObj.responseText
		}

	}

function createXMLHttpRequest()
	{
	var XMLhttpObject = null;
	try{
		XMLhttpObject = new XMLHttpRequest();												// IE以外
		}catch(e){
			try{XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");					// IE6.0-
			}catch(e){
				try{XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");			// IE5.0-
				}catch(e){
					return(null)
					}
				}
			}
	return XMLhttpObject;
	}


</SCRIPT>

<SCRIPT Language="JavaScript">
function InputProc(oCell)
	{

	var oRow = oCell.parentNode
	var Tab = []
	Tab.push(oCell.getAttribute("m"))
	Tab.push(oRow.getAttribute("yymm"))
	Tab.push(oRow.getAttribute("item"))
	Tab.push(oRow.getAttribute("pNum"))
	Tab.push(oRow.getAttribute("mode"))
//	alert("[" + Tab.join("][") + "]")
	var pNum = oRow.getAttribute("pNum")
//	入力画面
	InputWindow(pNum)

	xmlDoc = loadXML(pNum,xml_main,actual_yymm)

	reDisp()

	updateFlag = true

	}

function ExecProc()
	{
	updateFlag = true


	var Buff = arguments[0]
//	for( var x in Buff ){
//		alert(x + "][" + Buff[x])
//		}
	var name  = Buff["mode"]
	var pNum  = Buff["pNum"]
	var yymm  = Buff["yymm"]
	var value = Buff["value"]

	registData(name,pNum,yymm,value)

	var ret = setItemValue(xmlDoc,name,pNum,yymm,value)

	if( ret ){
		reDisp()
		}

	}

function setItemValue(xmlDoc,name,pNum,yymm,value)
	{
	var o = xmlDoc.selectSingleNode("//プロジェクト[@pNum='" + pNum + "']/yymm")
	if( o == null ) return(false)
	s_yymm = o.text
	var m = sub.yymmDiff(s_yymm,yymm)

	// 変更項目のデータを [xmlDoc] に反映させる
	var o = xmlDoc.selectNodes("//プロジェクト[@pNum='" + pNum + "']/項目[@name='" + name + "' and @mode='予測']/月[@m='" + m + "']")
	for( var i = 0; i < o.length; i++ ){
		o[i].text = value
		}
	return(true)
	}

function setTanka(xmlDoc,name,pNum,value)
	{
//		単価情報設定
	var tankaTab = {社員単価:"",パート単価:"",協力単価:""}
	if( typeof(tankaTab[name]) == "undefined") return			// 処理不要

	xmlDoc.selectSingleNode("//プロジェクト[@pNum='" + pNum + "']/" + name + "/業務").text = value

	var tankaObj = xmlDoc.selectSingleNode("//プロジェクト[@pNum='" + pNum + "']/" + name)
	var tankaObj2 = tankaObj.selectNodes("*")
	for( var i = 0; i < tankaObj2.length; i++ ){
		if( parseInt(tankaObj2[i].text) > 0 ){
			tankaObj.setAttribute("金額",tankaObj2[i].text)
			break;
			}
		}
	}

function InputWindow(pNum)
	{
	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var para = []
	para.push("TimeStamp=" + TimeStamp)
	para.push("pNum=" + pNum)
	
	var aspName = editName

	var URL = aspName + "?" + para.join("&")

	var Buff = {}
	var windowOption
	var value
	Buff.pNum  = pNum
	windowOption  = "dialogWidth:750px;dialogHeight:650px;"
	windowOption += "status=1;scroll=1;resizable=1;"
	value = window.showModalDialog(URL,Buff,windowOption)
	}

</SCRIPT>

<SCRIPT Language="JavaScript">
function update_yymmList(pNum,mCnt)
	{
	var o = getProjectInfo(pNum)
	var s_yymm = sub.yymmAdd(o.e,2)
	var e_yymm = o.ex

	obj_yymmList.innerHTML = makeMonth(s_yymm,e_yymm,mCnt)
	obj_s_yymm.innerHTML   = sub.strMonth(o.sx)
	}	

function makeMonth(s_yymm,e_yymm,mCnt)
	{
	var c_yymm = e_yymm
	var e_yymm = sub.yymmAdd(e_yymm,mCnt)
//====================================
	var yymmList,pos,opt
	yymmList = document.createElement("select")
	for(var yymm = s_yymm; yymm <= e_yymm; yymm = sub.yymmAdd(yymm,1)){
		opt = new Option(sub.strMonth(yymm),yymm)
		pos = yymmList.options.length
		yymmList.options[pos] = opt
		yymmList.options[pos].selected = (yymm == c_yymm ? true : false)
		}
	yymmList.id = "yymmList"
	return(yymmList.outerHTML)
	}

function getProjectInfo(pNum)
	{
	var ret,cObj
	if( aspObj == null ) aspObj = RSGetASPObject("/Project/_RemoteScript/売上_工数/planDB.asp")
	var cObj   = aspObj.getProjectInfo(pNum)
	var obj    = cObj.return_value
	return(obj)

	}

function setProjectLast(pNum,yymm)
	{

	var ret,cObj
	if( aspObj == null ) aspObj = RSGetASPObject("/Project/_RemoteScript/売上_工数/planDB.asp")

	var cObj   = aspObj.setProjectLast(pNum,yymm)
	var ret    = cObj.status

	return(ret)

	}
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var LineColor = "#cccccc"
var treeLine = null

function projectTreeDisp(pNum)
	{
try{
	var work = pNum.split(",")
	var Top_pNum = work[0]

	var p = []
	if( Top_pNum  != "" ) p.push("pNum=" + Top_pNum)
	if( JoinItem  != "" ) p.push("item="  + JoinItem )
	if( Join_mID  != "" ) p.push("mID="  + Join_mID )

	var xURL = xml_tree + "?" + p.join("&")
	var xmlDoc = new ActiveXObject("Microsoft.XMLDom");
	xmlDoc.async = false;
	var ret = xmlDoc.load(xURL)
	var xslDoc = new ActiveXObject("Microsoft.XMLDom");
	xslDoc.async = false;
	var ret = xslDoc.load(xsl_tree)

	var Buff = xmlDoc.transformNode(xslDoc)
	projectTree.innerHTML = Buff

	treeLine = new TreeLine()

	treeLine.dispLine("dispLineObject","D_CELL",LineColor)

}catch(e){alert(e.message)}
	return(Buff)
	}
</SCRIPT>

<SCRIPT Language="JavaScript">
function registData(mode,pNum,yymm,value)
	{
	var ret,cObj
	if( aspObj == null ) aspObj = RSGetASPObject("/Project/_RemoteScript/売上_工数/planDB.asp")
	if( value == 0 ) value = ""
	switch(mode){
		case "売上" :
			cObj = aspObj.regist_salesPlan(pNum,yymm,value)
			ret = cObj.status
			break;
//	想定・契約・見積工数の変更
		case "社員単価" :
		case "パート単価" :
		case "協力単価" :
//			cObj = aspObj.regist_AssumptionOne(mode,pNum,value)
//			ret = cObj.status
			break;
		case "見積工数" :
		case "契約工数" :
		case "外部工数" :
			cObj = aspObj.regist_Assumption(mode,pNum,yymm,value)
			ret = cObj.status
			break;
		case "想定工数" :
		case "パート工数" :
		case "協力工数" :
		case "業務費用" :
			cObj = aspObj.regist_Assumption(mode,pNum,yymm,value)
			ret = cObj.status
			break;
		default :
			break;
		}			
	}

function updateInfo(pNum,name,value)
	{
	var Tab = {"estimate":"見積","contract":"契約","fix_level":"確度"}
	if( typeof(Tab[name]) == "undefined" ) return
	
	if( aspObj == null ) aspObj = RSGetASPObject("/Project/_RemoteScript/売上_工数/planDB.asp")
	var cObj  = aspObj.registInfo(pNum,name,value)
	var ret = cObj.return_value
	if( cObj.status == 0 && ret == "OK" ){
		// XML　データ更新
		var Node = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/" + Tab[name])
		Node.text = value
		}
	}

function alert_p()
	{
	var Tab = []
	for( var i = 0; i < arguments.length; i++ ){
		Tab.push(arguments[i])
		}
	alert( "[" + Tab.join("][") + "]")
	}

function reDisp()
	{

//	情報表示
	headXML.innerHTML	   = convertXSL(xmlDoc,xsl_head)
	bodyInputXML.innerHTML = convertXSL(xmlDoc,xsl_body_input)		// 入力の表
	bodyDataXML.innerHTML  = convertXSL(xmlDoc,xsl_body_data)		// 実績の表
	bodyStatusXML.innerHTML  = convertXSL(xmlDoc,xsl_body_status)		// 実績の表
// 結合ツリー表示
	projectTreeDisp(pNum)
//	if( editMode != 1 ) projectTreeDisp(pNum)
//	表示情報初期化
	yymmEditBlock.style.display = ( editMode == 1 ? "block" : "none" )
	if( editMode == 1 ) update_yymmList(pNum,mCnt)

//	グラフ表示
	grphDisp(xmlDoc)

// イベントのリストを縮める
	eventInfoCheck.checked = ( eventInfoMode == 1 ? true : false )
	eventInfoCheck.click()

	editTitle.innerHTML = ( editMode == 1 ? "　(データ設定可)" : "" )
	}
</SCRIPT>


<SCRIPT FOR="window" EVENT="onload" language=JavaScript>
if( Join_mID == 451862 ) TEST.style.display = ""
if( aspObj == null ) aspObj = RSGetASPObject("/Project/_RemoteScript/売上_工数/planDB.asp")
subWin   = new newWindow(subWinName)
debugObj = new xmlDebug("debug")

try{
i_Window = new iFrame_Window()

// 入力可能な領域を設定

if( editMode == 1 ){
	sub      = new sub()

// 入力終了で呼ばれる
	sub.setCompleteFunc(ExecProc)
	sub.setMode("売上",1000,0,true)
	sub.setMode("業務費用",1000,0,true)
	sub.setMode("契約工数",100,2,true)
	sub.setMode("見積工数",100,2,true)
	sub.setMode("外部工数",100,2,true)

	sub.setInputFunc(InputProc)
	sub.setMode("社員工数",0,0,true)
	sub.setMode("パート工数",0,0,true)
	sub.setMode("協力工数",0,0,true)

	}

//	表示情報取得
xmlDoc = loadXML(pNum,xml_main,actual_yymm)

reDisp()

window_resize(dispBLOCK)

window.focus()

}catch(e){
	alert(e.message)
	}


</SCRIPT>


<SCRIPT For = eventInfoCheck EVENT = onclick LANGUAGE = JavaScript>
var mode
var o = document.getElementsByName("eventInfo")
var n = o.length
eventInfoMode = ( this.checked ? 0 : 1 )
for( var i = 0; i < n; i++ ){
	mode = o[i].getAttribute("mode")
	if( mode == 1 ) o[i].style.display = ( eventInfoMode == 1 ? "" : "none" )
	}

</SCRIPT>


<SCRIPT For = window EVENT = onunload LANGUAGE = JavaScript>
//	親のデータを更新する
if( updateFlag == true && typeof(opener.parent_updateList) == "object" ) opener.parent_updateList(pNum)

subWin.close()
</SCRIPT>


<SCRIPT For = "Detail" EVENT = "onclick" LANGUAGE = "JavaScript">
var item = this.item
var mode = this.mode
var func = Detail_Tab[item]
if( mode == "実績" && typeof(func) == "string" ){
	//	詳細情報取得
	var xmlDoc_Detail = loadXML(pNum,xml_Detail,actual_yymm)

	var nodes = xmlDoc_Detail.selectNodes("//表示項目/*")
	for( var i = 0; i < nodes.length; i++ ){
		nodes.item(i).text = ( nodes(i).tagName == func ? 1 : 0 )
		}
	var xslDoc_Detail = new ActiveXObject("Microsoft.XMLDom");
	xslDoc_Detail.async = false;
	var ret = xslDoc_Detail.load(xsl_Detail);
	detailXML.innerHTML = xmlDoc_Detail.transformNode(xslDoc_Detail)
	subWin.open(subWinAspName)
	}
else{
	}
</SCRIPT>
<SCRIPT For = "Detail" EVENT = "oncontextmenu" LANGUAGE = "JavaScript">
var item = this.item
var mode = this.mode
var func = Detail_Tab[item]
if( mode == "実績" && typeof(func) == "string" ){
	//	詳細情報取得
	var xmlDoc_Detail = loadXML(pNum,xml_Detail2,actual_yymm)

	var nodes = xmlDoc_Detail.selectNodes("//表示項目/*")
	for( var i = 0; i < nodes.length; i++ ){
		nodes.item(i).text = ( nodes(i).tagName == func ? 1 : 0 )
		}
	var xslDoc_Detail = new ActiveXObject("Microsoft.XMLDom");
	xslDoc_Detail.async = false;
	var ret = xslDoc_Detail.load(xsl_Detail2);
	detailXML.innerHTML = xmlDoc_Detail.transformNode(xslDoc_Detail)
	subWin.open(subWinAspName)
	}
else{
	}
	return(false)
</SCRIPT>
<SCRIPT FOR="yymmList" EVENT="onchange" language=JavaScript>
var obj = this
var n = obj.selectedIndex
var yymm = obj.options[n].value

//	新しい最終年月を設定
setProjectLast(pNum,yymm)

xmlDoc = loadXML(pNum,xml_main,actual_yymm)

reDisp()

</SCRIPT>



<SCRIPT Language="JavaScript">
function editProc(oCell)
	{
	var mode = oCell.mode
	switch(mode){
		case "見積" :
			//	見積状態の更新
			var Tab = new Array(0,1)
			oCell.value = cnvValue(Tab,oCell.value)
			updateInfo(pNum,"estimate",oCell.value)
			break;
		case "契約" :
			//	契約状態の更新
			var Tab = new Array(0,1)
			oCell.value = cnvValue(Tab,oCell.value)
			updateInfo(pNum,"contract",oCell.value)
			break;
		case "確度" :
			//	確度の更新
			var Tab = new Array(10,30,50,70,80,90,100)
			oCell.value = cnvValue(Tab,oCell.value)
			updateInfo(pNum,"fix_level",oCell.value)
			break;
		case "状態" :
			editStat(oCell,pNum)
			break;
		case "PM名" :
			editPM(oCell,pNum)
			break;
		case "分類名" :
			editKind(oCell,pNum)
			break;
		case "営業担当" :
			editSalesMan(oCell,pNum)
			break;
		case "イベント" :
			editCompDate(oCell,pNum)
			break;
		case "xx" :
			break;
		default :
			break;
			}

	// 再表示
	reDisp()

	updateFlag = true
	}

//	状態の編集
function editStat(oCell,pNum)
	{
	var Stat = oCell.value
	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var URL = "editStat/editStat.asp"
	URL += "?TimeStamp=" + TimeStamp

	var Buff = new Object
	var windowOption
	var value
	Buff.pNum	= pNum
	Buff.状態	= Stat
	windowOption  = "dialogWidth:500px;dialogHeight:300px;"
	windowOption += "status:no;scroll:yes;"

	value = window.showModalDialog(URL,Buff,windowOption)
	if(value){
		// XML　データ更新
		var Node = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/状態")
		Node.text = Buff.状態
		}

	}

//	分類名の編集
function editKind(oCell,pNum)
	{
	var kindName = oCell.value
	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var URL = "editKind/editKind.asp"
	URL += "?TimeStamp=" + TimeStamp

	var Buff = new Object
	var windowOption
	var value
	Buff.pNum	= pNum
	Buff.分類名 = kindName
	windowOption  = "dialogWidth:500px;dialogHeight:350px;"
	windowOption += "status:no;scroll:yes;"

	value = window.showModalDialog(URL,Buff,windowOption)
	if(value){
		// XML　データ更新
		var Node = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/分類名")
		Node.text = Buff.分類名
		}

	}

//	担当PMの編集
function editPM(oCell,pNum)
	{
	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var URL = "editPM/editPM.asp"
	URL += "?TimeStamp=" + TimeStamp

	var Buff = new Object
	var windowOption
	var value
	Buff.pNum  = pNum
	windowOption  = "dialogWidth:500px;dialogHeight:350px;"
	windowOption += "status:no;scroll:yes;"

	value = window.showModalDialog(URL,Buff,windowOption)
	if(value){
		// XML　データ更新
		var Node = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/PM名")
		Node.text = Buff.mName
		var Node = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/PMId")
		Node.text = Buff.mID
		}
	}

//	担当営業の編集
function editSalesMan(oCell,pNum)
	{
	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var URL = "editSalesMan/editSalesMan.asp"
	URL += "?TimeStamp=" + TimeStamp

	var Buff = new Object
	var windowOption
	var value
	Buff.pNum  = pNum
	windowOption  = "dialogWidth:500px;dialogHeight:350px;"
	windowOption += "status:no;scroll:yes;"

	value = window.showModalDialog(URL,Buff,windowOption)
	if(value){
		// XML　データ更新
		var Node = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/営業担当")
		Node.text = Buff.mName
		var Node = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/営業担当Id")
		Node.text = Buff.mID
		}
	}

//	完了日の編集
function editCompDate(oCell,pNum)
	{
	var tm = new Date()
	var TimeStamp = String(parseInt(Date.UTC(tm)/1000000))

	var URL = "editCompDate/editCompDate.asp"
	URL += "?TimeStamp=" + TimeStamp

	var Buff = new Object
	var windowOption
	var value
	Buff.pNum  = pNum

	windowOption  = "dialogWidth:500px;dialogHeight:450px;"
	windowOption += "status:yes;scroll:yes;"
	value = window.showModalDialog(URL,Buff,windowOption)
	if(value){
		var new_xmlDoc = Buff.eventInfo

		// XML　データ更新
		var parentNode = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]")

		var o_Org = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/イベント")
		var o_New = new_xmlDoc.selectSingleNode("//イベント")
		parentNode.replaceChild(o_New,o_Org)

		var o_Org = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/イベント開始")
		var o_New = new_xmlDoc.selectSingleNode("//イベント開始")
		parentNode.replaceChild(o_New,o_Org)

		var o_Org = xmlDoc.selectSingleNode("//プロジェクト[@pNum=" + pNum + "]/イベント終了")
		var o_New = new_xmlDoc.selectSingleNode("//イベント終了")
		parentNode.replaceChild(o_New,o_Org)

		}
	}

</SCRIPT>


<SCRIPT for="editCell" event="onclick">
if( editMode == 1 ){
	editProc(this)
	}
</SCRIPT>
<SCRIPT for="editCell" event="onmouseover">
if( editMode == 1 ){
	this.style.cursor = "hand"
	this.style.backgroundColor = curColor
	}
</SCRIPT>
<SCRIPT for="editCell" event="onmouseleave">
if( editMode == 1 ){
	this.style.cursor = ""
	this.style.backgroundColor = ""
	}
</SCRIPT>


<SCRIPT>
function cnvValue(Tab,value)
	{
	var len = Tab.length
	var i
	for( i = 0; i < len; i++)	{
		if(value == Tab[i]) break
		}
	i++
	if( i >= len )	 i = 0
	return(Tab[i])	
	}

function cnvMark(val){
	var str;
	if(val == 1) str = "●"
	else		 str = "&nbsp;"
	return(str)
	}

function cnvStat(val){
	var str;
	switch(val){
		case 0 :
			str = "▲".fontcolor("green") + " 引合中"
			break;
		case 1 :
			str = "●".fontcolor("blue") + " 開発中"
			break;
		case 4 :
//			str = "◎".fontcolor("green") + " 開発終了"
			str = "●".fontcolor("gray") + " 開発終了"
			break;
		case 5 :
			str = "★".fontcolor("gray") + " 終了"
			break;
		case -1 :
			str = "×".fontcolor("green") + " 没"
			break;
		default :
			str = "&nbsp;"
			break;
		}
	return(str)
	}

function window_resize(obj)
	{
	var sizeX = obj.offsetWidth  + 100
	var sizeY = obj.offsetHeight + 120

	var minX = 300 
	var minY = 200

	var maxX = screen.availWidth  - 200
	var maxY = screen.availHeight - 200

	if( sizeX < minX ) sizeX = minX
	if( sizeY < minY ) sizeY = minY
	if( sizeX > maxX ) sizeX = maxX
	if( sizeY > maxY ) sizeY = maxY

	window.resizeTo(sizeX,sizeY)

	}
/*
function window_resize()
	{
// ウインドウの最低の大きさにする取得
//	window.resizeTo(0,0)
	var baseX = document.body.clientWidth  + 120
	var baseY = document.body.clientHeight + 120
	var baseX = 50
	var baseY = 120

// 画面の左上に移動
	var posX = 0
	var posY = 0
//	window.moveTo(posX,posY)


	var minX = 300 
	var minY = 200
	var maxX = screen.availWidth
	var maxY = 600				//screen.height

//	表の大きさ取得
	var sizeX = window.mainTable.clientWidth  + baseX + 100
	var sizeY = window.mainTable.clientHeight + baseY

	if( sizeX < minX ) sizeX = minX
	if( sizeY < minY ) sizeY = minY
	if( sizeX > maxX ) sizeX = maxX
	if( sizeY > maxY ) sizeY = maxY

	window.resizeTo(sizeX,sizeY)


	var windowX = screen.availWidth
	var windowY = screen.availHeight

	var posX = windowX - sizeX
	var posY = windowY - sizeY
	posX = 0
//	window.moveTo(posX,posY)

	}
*/

function i_Window_Load(xURL,target)
	{
	i_window.target = target
	i_window.action = xURL
	i_window.submit()
	}

</SCRIPT>
<SCRIPT FOR="dispProjectList" EVENT="onclick" LANGUAGE="JavaScript">
var xURL = "/Project/common_data/dispProjectList/dispProjectList.asp?pNum=" + pNum
var target = "dispProjectList" 
i_Window.load(xURL,target)

//this.innerText = ""
</SCRIPT>

<SCRIPT FOR="memberWorkList" EVENT="onclick" LANGUAGE="JavaScript">
var xURL = "/Project/common_data/memberWorkList/memberWorkList.asp?pNum=" + pNum
var target = "memberWorkList" 
i_Window.load(xURL,target)

//this.innerText = ""
</SCRIPT>

<SCRIPT FOR="projectBBS" EVENT="onclick" LANGUAGE="JavaScript">
var xURL = "状況掲示板/viewBBS_Sum.asp?pNum=" + pNum
var target = "projectBBS" 
i_Window.load(xURL,target)

//this.innerText = ""
</SCRIPT>

<SCRIPT FOR="Cell" EVENT="onmouseenter" LANGUAGE="JavaScript">sub.cellMouse(this,"enter")</SCRIPT>
<SCRIPT FOR="Cell" EVENT="onmouseleave" LANGUAGE="JavaScript">sub.cellMouse(this,"leave")</SCRIPT>
<SCRIPT FOR="Cell" EVENT="onclick"		LANGUAGE="JavaScript">sub.cellBegin(this)</SCRIPT>

<title>プロジェクト情報</title>
</head>

<BODY background="bg.gif" ID="xBODY">
<SPAN style="display:none"><textarea rows=30 cols=80 id="responseText"></textarea></SPAN>
<INPUT type="button" value="Button" id="TEST" style="display:none">

<DIV ID="dispBLOCK">
<table border=0 ID="mainTable">
<caption><span nowrap><b>プロジェクト情報</b></span><span id="editTitle"></span></caption>
<tr>
<td><SPAN ID="headXML"></SPAN></td>
</tr>
</table>

<table>
<tr>
<td>
<table ID="yymmEditBlock" align="right" style="display:none">
<tr>
<td>
<fieldset>
<legend>入力可能年月の設定</legend>
<SPAN ID="obj_s_yymm"></SPAN>～<SPAN ID="obj_yymmList"></SPAN>
</fieldset>
</td>
</tr>
</table>

</td>
</tr>
<tr>
<td><SPAN ID="bodyInputXML"></SPAN></td>
</tr>
<tr>
<td><SPAN ID="bodyDataXML"></SPAN></td>
</tr>
<tr>
<td><hr></td>
</tr>
<tr>
<td><SPAN ID="bodyStatusXML"></SPAN></td>
</tr>
</table>








</DIV>

<SPAN ID="detailXML" style="display:none"></SPAN>

<form id="i_window" name="i_window" method="post"></form>

</BODY>
</HTML>

<SCRIPT LANGUAGE="JavaScript" src="/_ScriptLibrary/RS.Js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">RSEnableRemoteScripting("/_ScriptLibrary")</SCRIPT>

<SCRIPT LANGUAGE="JavaScript" src="sub/subEdit.js"></SCRIPT>
<SCRIPT LANGUAGE="VBScript"   src="sub/subEdit.vbs"></SCRIPT>

