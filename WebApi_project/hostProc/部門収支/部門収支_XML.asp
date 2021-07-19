<%@ Language=JavaScript %>
<!--#include virtual="/Project/common_data/確定日付.inc"-->
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/dispXML.inc"-->
<%
try{
	var d = new Date()
	var yy = d.getFullYear()
	var mm = d.getMonth()+1
	var dd = d.getDate()
	var year = yy + (mm >= 10 ? 1 : 0)             // 10月以降は次年度を表示

//	year = 2015

//	var dispCmd = "統括配賦"
//	var dispCmd = "統括詳細"
//	var dispCmd = "部門配賦"


var secMode = "間接"
var dispCmd = "間接一覧"
var dispName = ""
var specialMode = ""								// 原価管理用

	var debugMode = "開発・部門一覧"
	switch(debugMode){
		case "EMG" :
			var dispCmd = "EMG"
			break;

		case "開発・統括一覧" :
			var dispCmd = "統括一覧"
			var secMode  = "開発"
			break;

		case "開発・部門一覧" :
			var dispCmd = "部門一覧"		
			var secMode  = "開発"
			break;
		case "開発・課一覧" :
			var dispCmd = "課一覧"		
			var secMode  = "開発"
			break;

		case "間接・部門一覧" :
			var dispCmd = "部門一覧"		
			var secMode  = "間接"
			break;
		case "間接・課一覧" :
			var dispCmd = "課一覧"		
			var secMode  = "間接"
			break;

		case "開発・統括詳細" :
			var dispCmd  = "統括詳細"
			var secMode  = "開発"
			var dispName = "事業開発本部"
			break;
		case "開発・部門詳細" :
			var dispCmd  = "部門詳細"
			var secMode  = "開発"
			var dispName = "開発本部第1開発部"
			break;
		case "開発・課詳細" :
			var dispCmd  = "課詳細"
			var secMode  = "開発"
			var dispName = 288
//			var dispName = 287
			break;

		case "間接・統括詳細" :
			var dispCmd  = "統括詳細"
			var secMode  = "間接"
			var dispName = "本社"
			break;
		case "間接・部門詳細" :
			var dispCmd  = "部門詳細"
			var secMode  = "間接"
			var dispName = "本社情報システム部"
			break;
		case "間接・課詳細" :
			var dispCmd  = "課詳細"
			var secMode  = "間接"
			var dispName = 25
			break;
		default :
			break;
			}		

//	事業開発本部(287)は業務支援課(288)も表示しないといけない
	
	year = ( Request.QueryString("year").Count == 0 ? year : Request.QueryString("year").Item)

	dispCmd  = (Request.QueryString("dispCmd").Count  == 0 ? dispCmd  : Request.QueryString("dispCmd").Item )

	dispName = (Request.QueryString("dispName").Count == 0 ? dispName : Request.QueryString("dispName").Item )
	secMode  = (Request.QueryString("secMode").Count  == 0 ? secMode  : Request.QueryString("secMode").Item )

	specialMode  = (Request.QueryString("specialMode").Count  == 0 ? specialMode  : Request.QueryString("specialMode").Item )

var work1 = paraOut(year,secMode,dispCmd,dispName)

EMGLog.Write("部門収支.txt","[引数]" , dispCmd, year, dispName, secMode, Request.QueryString())

	var fixStr = String(Request.QueryString("fix"))
	var fixLevel
	if(IsNumeric(fixStr)){
		fixLevel = (Math.floor(fixStr/10))*10
		if( fixLevel > 100 || fixLevel < 0 ) fixLevel = 70
		}
	else{
		fixLevel = 70
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
		}
	else{
		yosokuCnt = parseInt(Request.QueryString("yosoku") )
		if(yosokuCnt == 0){
			//	すべて計画
			actualCnt = 0
			yosokuCnt = 0
			}
		else if( yosokuCnt < 0 ){
			// 残り全て予測
			yosokuCnt = 12 - actualCnt
			}
		}

	var listMode,haifuMode

	switch(dispCmd){
		case "EMG" :
			dispMode = "全社"
			listMode = "詳細"
			haifuMode = false
			break;
		case "統括一覧" :
			dispMode = "統括"
			dispName = ""
			listMode = "一覧"
			haifuMode = true
			break;
		case "部門一覧" :
			dispMode = "部門"
			dispName = ""
			listMode = "一覧"
			haifuMode = ( secMode == "間接" ? false : true )
			break;
		case "課一覧" :
			dispMode = "グループ"
			dispName = dispName		// 部門の名前
			listMode = "一覧"
			haifuMode = true		// 課に対しては計算しない
			break;
		case "統括詳細" :
			dispMode = "統括"
			dispName = dispName		// 部門の名前
			listMode = "詳細"
			haifuMode = true
			break;
		case "部門詳細" :
			dispMode = "部門"
			dispName = dispName		// 部門の名前
			listMode = "詳細"
			haifuMode = true
			break;
		case "課詳細" :
			dispMode = "グループ"
			dispName = dispName		// 課のコード
			listMode = "詳細"
			haifuMode = true		// 課に対しては計算しない
			break;
//	配賦
		case "統括配賦" :
			dispMode = "統括"
			dispName = dispName
			listMode = "配賦"
			haifuMode = true
			break;
		case "部門配賦" :
			dispMode = "部門"
			dispName = dispName
			listMode = "配賦"
			haifuMode = true
			break;
		case "間接一覧" :
			dispMode = "グループ"
			dispName = ""
			listMode = "間接一覧"
			secMode  = "間接"
			haifuMode = false
			break;
		default :
			break;
		}
	

var work2 = paraOut(year,secMode,dispMode,listMode,dispName)

//EMGLog.Write("部門収支.txt","[work1]" , work1);
//EMGLog.Write("部門収支.txt","[work2]" , work2);
//===========================================
	var mCnt = 12
	var yymm = ((year-1)*100) + 10
	
//	mCnt = 0
	var DB = Server.CreateObject("ADODB.Connection")
	DB.Open( Session("ODBC") )
	DB.DefaultDatabase = "kansaDB"

	var Tab = initTab(DB,yymm,mCnt,dispMode,dispName,listMode,secMode)

	getAllData(DB,Tab,yymm,mCnt,dispMode,dispName,listMode,fixLevel)

	if( haifuMode ){
		本社費配賦(Tab,year,mCnt)
		}

	DB.Close()

	if( dispName != "本社" && listMode != "配賦" && (listMode == "詳細" || dispMode == "グループ" || dispMode == "部門" ) ){
		delete Tab["本社"]
		}

	delete Tab["直接"]

//pr(paraOut(listMode,dispMode,secMode,dispName))

//Response.End
//
//dispXML(""+listMode+"]["+dispMode+"]["+secMode+"]["+dispName,Tab)

//===========================================

	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false

	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)

	var main2 = xmlDoc.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='部門収支.xsl'") 
//	xmlDoc.appendChild(main2)

	var commnt = xmlDoc.createComment("指定期間の所属データ")
	xmlDoc.appendChild(commnt)

	var commnt = xmlDoc.createComment(dispCmd)
	xmlDoc.appendChild(commnt)

	var commnt = xmlDoc.createComment(work2)
	xmlDoc.appendChild(commnt)



	makeXML(xmlDoc,year,mCnt,actualCnt,yosokuCnt,Tab,dispMode,dispName,listMode,fixLevel)

	Response.CharSet	 = "SHIFT_JIS"
    Response.AddHeader("Access-Control-Allow-Origin", "*");
	Response.ContentType = "text/xml"
	xmlDoc.save(Response)

//	Response.End


}catch(e){
	EMGLog.debug("x.txt",e.message)
	}


function getAllData(DB,Tab,yymm,mCnt,dispMode,dispName,listMode,fixLevel)
	{
	if( mCnt == 0 ) return
	
	groupPlan(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)						// 計画・予測データ取得

	uriageYosoku(DB,Tab,yymm,mCnt,dispMode,dispName,listMode,fixLevel)			// 売上予測データ取得
	uriageActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// 売上実績データ取得

	accountActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// 費用実績データ取得
	accountCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// 費用付替

	salesCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)						// 売上付替

	if( dispMode != "全社" ){
		groupCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// 部門固定費データ取得
		}
	memberPlan(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
	memberActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)


	間接部門予算(Tab,mCnt)

	}



function makeXML(xmlDoc,year,dispCnt,actualCnt,yosokuCnt,Tab,dispMode,dispName,listMode,fixLevel)
	{
//================================================================

	var s_yymm = ((year-1)*100) + 10
	var e_yymm = yymmAdd(s_yymm,mCnt-1)

	var yyyy = parseInt(s_yymm / 100)
	var mm   = (s_yymm % 100)

		// 次回の確定日のお知らせ
	if( actualCnt >= 0 && actualCnt < dispCnt){
		var x_yymm = yymmAdd(s_yymm,actualCnt)
		var x_yy = parseInt(x_yymm/100)
		var x_mm = x_yymm%100
		var xx_yymm = yymmAdd(x_yymm,1)
		var xx_yy = parseInt(xx_yymm/100)
		var xx_mm = xx_yymm%100
		var xx_dd = dayChk(new Date(xx_yy+"/"+xx_mm+"/1"),adjustDayCnt)
		var Buff = (x_yy + "年" + x_mm + "月の実績表示は" + xx_mm + "月" + xx_dd + "日以降です")
		}
	else if(actualCnt == dispCnt){
		Buff = "(すべて実績データです)"
		}
	else{
		Buff = "実績データはありません"
		}

	var rootNode = xmlDoc.createElement("root")
	xmlDoc.appendChild(rootNode)

	var mainNode = xmlDoc.createElement("全体")
	rootNode.appendChild(mainNode)

	var Node = xmlDoc.createElement("年度")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(year)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("開始年")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(yyyy)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("開始月")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(mm)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("月数")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(mCnt)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("実績日付")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode( Buff )
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("確度")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(fixLevel)
	Node.appendChild(Text)

	var cDate = convertDateTime(new Date());

	var Node = xmlDoc.createElement("作成日付")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(cDate)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("確定日")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(adjustDayCnt)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("表示")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode("計画")
	Node.appendChild(Text)


/*
	=========== 統括・部門の場合 ==============
	本社費配賦のため全部門の費用は取得し計算する
	gName に部門名が入っている時、表示は指定された部門のみ
	gName に空白の時は全部門の一覧
	
	=========== EMGの場合 ==============
	一度に全部の集計を行う(gNameは空白)

	=========== 部門指定の場合 ==============
	gNameはグループコード、指定された部門のみ集計を行う

*/
	for( var sec in Tab ){									// sec = 部署名
		var xTab = Tab[sec]
		var mode = xTab["種別"]

		var groupNode = xmlDoc.createElement("グループ")
		groupNode.setAttribute("kind",mode)				// kind : 部門
		mainNode.appendChild(groupNode)

		var Node = xmlDoc.createElement("名前")
		groupNode.appendChild(Node)
		var Title = ( sec == "全社" ? "ＥＭＧ" : sec )
		var Text = xmlDoc.createTextNode(Title)
		Node.appendChild(Text)

		groupNode.setAttribute("name",sec)				// kind : 部門
		mainNode.appendChild(groupNode)

		var Node = xmlDoc.createElement("統括")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["部署名"]["統括"])
		Node.appendChild(Text)

		var Node = xmlDoc.createElement("部門")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["部署名"]["部門"])
		Node.appendChild(Text)

		var Node = xmlDoc.createElement("課")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["部署名"]["課"])
		Node.appendChild(Text)

		var Node = xmlDoc.createElement("部署コード")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["部署コード"].join(","))
		Node.appendChild(Text)

		planXML(xmlDoc,groupNode,xTab,"結合","計画・予測・実績",dispCnt,actualCnt,yosokuCnt)

		if( listMode == "詳細" ){
			planXML(xmlDoc,groupNode,xTab,"計画","計画",dispCnt,0,0)
			planXML(xmlDoc,groupNode,xTab,"予測","予測",dispCnt,0,dispCnt)
			planXML(xmlDoc,groupNode,xTab,"実績","実績",dispCnt,dispCnt,0)
			}
		else if( listMode == "配賦" || listMode == "間接一覧" ){
			planXML(xmlDoc,groupNode,xTab,"計画","計画",dispCnt,0,0)
			}
		else if( specialMode == "原価管理" ){
			planXML(xmlDoc,groupNode,xTab,"計画","計画",dispCnt,0,0)
			}
//		売上予測データ
		if( listMode != "配賦" ){
			yosokuXML(xmlDoc,groupNode,xTab,dispCnt)
			}
		}
	}



function planXML(xmlDoc,groupNode,Tab,mode,title,mCnt,actualCnt,yosokuCnt)
	{
	if( mCnt == 0 ) return
	
	var dataNode = xmlDoc.createElement("データ")
	dataNode.setAttribute("name",mode)				// mode : 計画・予測・実績
	groupNode.appendChild(dataNode)

	var titelNode = xmlDoc.createElement("表題")
	var Text = xmlDoc.createTextNode(title)
	titelNode.appendChild(Text)
	dataNode.appendChild(titelNode)

	// 実績・計画・計画
	var modeTab = new Array(12)
	for( var m = 0; m < mCnt; m++ ){
		if( m < actualCnt ){
			modeTab[m] = "実績"
			}
		else if ( m < (actualCnt + yosokuCnt) ){
			modeTab[m] = "予測"
			}
		else{
			modeTab[m] = "計画"
			}
		}

	var mNode = xmlDoc.createElement("月情報")
	dataNode.appendChild(mNode)
	for( var m = 0; m < mCnt; m++ ){
		var Text = xmlDoc.createTextNode(modeTab[m])
		var Node = xmlDoc.createElement("月")
		mNode.appendChild(Node)
		Node.setAttribute("m",m)
		Node.appendChild(Text)
		}

	for( var itemName in Tab["予測"]){										// itemName : 大項目(売上原価・販管費)
		if( itemName == "売上予測" ) continue;
		var haifuFlag = checkItem(Tab["種別"],itemName)
		if( haifuFlag == 9 ) continue										// 出力制御(部門により異なる)
		var disp = ( haifuFlag == 0 ? 0 : 1 )
		var itemNode = xmlDoc.createElement(itemName)
		itemNode.setAttribute("disp",disp)
		dataNode.appendChild(itemNode)
		for( var item in Tab["予測"][itemName]){							// item : 項目(仕入費・人件費)
			var subNode = xmlDoc.createElement("項目")
			subNode.setAttribute("name",item)
			itemNode.appendChild(subNode)
			for( var m = 0; m < mCnt; m++ ){								// m : 月
				var Node = xmlDoc.createElement("月")
				Node.setAttribute("m",m)
				subNode.appendChild(Node)
				mode = modeTab[m]				
				var Text = xmlDoc.createTextNode(Tab[mode][itemName][item][m])
				Node.appendChild(Text)
				}
			}
		}
	}

function yosokuXML(xmlDoc,groupNode,Tab,dispCnt)
	{
	if( dispCnt == 0 ) return
	
	var mode = "予測"
	var dataNode = xmlDoc.createElement("予測データ")
	groupNode.appendChild(dataNode)

	var itemName = "売上予測"
	var itemNode = xmlDoc.createElement(itemName)
	dataNode.appendChild(itemNode)

	for( var item in Tab["予測"][itemName]){								// item : 項目(仕入費・人件費)
		var subNode = xmlDoc.createElement("項目")
		subNode.setAttribute("name",item)
		itemNode.appendChild(subNode)
		for( var m = 0; m < dispCnt; m++ ){									// m : 月
			var Node = xmlDoc.createElement("月")
			Node.setAttribute("m",m)
			subNode.appendChild(Node)
			var Text = xmlDoc.createTextNode(Tab["予測"][itemName][item][m])
			Node.appendChild(Text)
			}
		}
	}


// 出力制御(部門により異なる)
function checkItem(kind,item)
	{
//EMGLog.Write("x.txt","[" + kind + "][" + item + "]")
	// 0 作成して非表示
	// 1 作成して表示
	// 9 作成しない
	var Tab = {}
	Tab["予算"] 	  = {"配賦":1,"開発":9,"営業":9,"間接":1,"全社":9,"会社":9,"直接":0}
	Tab["売上高"]	  = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":1,"会社":1,"直接":1}
	Tab["売上原価"]   = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":1,"会社":1,"直接":1}
	Tab["販管費"]	  = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":1,"会社":1,"直接":1}
	Tab["営業外収益"] = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":1,"会社":1,"直接":1}
	Tab["営業外費用"] = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":1,"会社":1,"直接":1}
	Tab["固定資産"]   = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":1,"会社":0,"直接":1}
	Tab["部門固定費"] = {"配賦":1,"開発":1,"営業":1,"間接":0,"全社":9,"会社":0,"直接":1}
	Tab["本社費配賦"] = {"配賦":1,"開発":1,"営業":1,"間接":0,"全社":9,"会社":0,"直接":0}
	Tab["売上付替"]   = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":9,"会社":0,"直接":1}
	Tab["費用付替"]   = {"配賦":9,"開発":1,"営業":1,"間接":1,"全社":9,"会社":0,"直接":1}
	Tab["要員数"]	  = {"配賦":1,"開発":1,"営業":1,"間接":1,"全社":1,"会社":1,"直接":1}
	if( !IsObject(Tab[item]) ) return(0)
	if( !IsObject(Tab[item][kind]) ) return(0)
	var ret = Tab[item][kind]
	return(ret)
	}



%>
<%
function initTab(DB,yymm,mCnt,dispMode,dispName,listMode,secMode)
	{
EMGLog.debug("部門収支.txt",dispMode,dispName,listMode,secMode)

	var Tab = {}
//	Tab["yymm"] = yymm
//	Tab["dispMode"] = dispMode
//	Tab["dispName"] = dispName
//	Tab["listMode"] = listMode
//	Tab["secMode"] = secMode

	if( dispMode == "全社" ){
		Tab["全社"] = makeTab(DB,mCnt,"全社")
		return(Tab)
		}
/*
	var RS = Server.CreateObject("ADODB.Recordset")
	var SQL = ""
	var d = new Date()
	var now_yymm = (d.getFullYear() * 100) + (d.getMonth()+1)

	var s_yymm,e_yymm,c_yymm
	s_yymm = yymm
	e_yymm = yymmAdd(yymm,mCnt-1)

	var s_Date = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var e_Date = DateAdd("m",mCnt,s_Date)
	e_Date     = convertDate(DateAdd("d",-1,e_Date) )

	if( secMode == "開発" ){
		SQL = ""
		SQL += " SELECT"
		SQL += "   直間  = TM.直間,"
		SQL += "   統括  = TM.統括,"
		SQL += "   部門  = TM.部門,"
		SQL += "   課    = TM.グループ,"
		SQL += "   gCode = TM.部署ID"
	 
		SQL += " FROM"
		SQL += "    統括本部マスタ TM"
		SQL += " WHERE"
		SQL += "    NOT(TM.開始 > '" + e_yymm + "' or TM.終了 < '" + s_yymm + "')"
		SQL += " AND"
		SQL += "    TM.直間 IN(0,1)"

		if(      listMode == "詳細" && dispMode == "統括" ){     SQL += " AND TM.統括         = '" + dispName + "'" }
		else if( listMode == "詳細" && dispMode == "部門" ){     SQL += " AND TM.統括+TM.部門 = '" + dispName + "'" }
		else if( listMode == "詳細" && dispMode == "グループ" ){ SQL += " AND TM.部署ID       = '" + dispName + "'" }
		else if( listMode == "一覧" && dispMode == "グループ" ){ SQL += " AND TM.統括+TM.部門 = '" + dispName + "'" }


		SQL += " ORDER BY"
		SQL += "    直間,"
		SQL += "    統括,"
		SQL += "    部門,"
		SQL += "    課"
		}
	else{
		SQL = ""
		SQL += " SELECT"
		SQL += "   直間  = TM.直間,"
		SQL += "   統括  = '',"
		SQL += "   部門  = '',"
		SQL += "   課    = TM.部署名,"
		SQL += "   gCode = TM.部署コード"
	 
		SQL += " FROM"
		SQL += "    EMG.dbo.部署マスタ TM"
		SQL += " WHERE"
		SQL += "    NOT(TM.開始 > '" + e_Date + "' or TM.終了 < '" + s_Date + "')"
		SQL += " AND"
		SQL += "    TM.ACCコード >= 0"
		SQL += " AND"
		SQL += "    TM.直間 IN(2)"
		if( listMode == "詳細" && dispMode == "グループ" ){ SQL += " AND TM.部署コード = '" + dispName + "'" }


		SQL += " ORDER BY"
		SQL += "    TM.ACCコード,"
		SQL += "    直間,"
		SQL += "    統括,"
		SQL += "    部門,"
		SQL += "    課"
		}
	RS = DB.Execute(SQL)

	var gCode,統括,部門,課,S_name
	while(!RS.EOF){
		直間  = RS.Fields("直間").Value
		統括  = RS.Fields("統括").Value
		部門  = RS.Fields("部門").Value
		課    = RS.Fields("課").Value
		gCode = RS.Fields("gCode").Value
		
//		if( 部門 == "-" ) 部門 = ""

		if( dispMode == "全社" ){          S_name = '全社'}
		else if( dispMode == "本社" ){     S_name = '本社'}
		else if( dispMode == "統括" ){     S_name = 統括 }
		else if( dispMode == "部門" ){     S_name = 統括+部門 }
		else if( dispMode == "グループ" ){ S_name = 統括+部門+課 }


		if( !IsObject(Tab[S_name]) ){
			Tab[S_name] = makeTab(DB,mCnt,S_name)

//			Tab[S_name] = {}

			Tab[S_name]["直間"] = 直間
			Tab[S_name]["部署名"] = {}
			Tab[S_name]["部署名"]["統括"] = 統括
			Tab[S_name]["部署名"]["部門"] = 部門
			Tab[S_name]["部署名"]["課"]   = 課
			Tab[S_name]["部署コード"] = []
			}
		Tab[S_name]["部署コード"].push(gCode)
		RS.MoveNext()
		}
	RS.Close()
*/

	var Tab = {}
	var dispTab = {統括:"統括",部門:"部",グループ:"課"}
	var secTab 	= {開発:"0,1",間接:"2",全社:"0,1,2"}
	var secName = ( IsObject(dispTab[dispMode]) ? dispTab[dispMode] : "" )
	var secStr = ( IsObject(secTab[secMode]) ? secTab[secMode] : "" )

	var xTab = getGroupInfo(yymm,secStr,secName)
	var S_name,gCode,直間,統括,部門,課,chk_name
	for( var i = 0; i < xTab.length; i++ ){	
		直間   = xTab[i].直間
		統括   = xTab[i].統括
		部門   = xTab[i].部
		課     = xTab[i].課
		gCode  = xTab[i].gCode

		if(      listMode == "詳細" && dispMode == "統括" ){     chk_name = 統括		}
		else if( listMode == "詳細" && dispMode == "部門" ){     chk_name = 統括+部門	}
		else if( listMode == "詳細" && dispMode == "グループ" ){ chk_name = gCode		}
		else if( listMode == "一覧" && dispMode == "グループ" ){ chk_name = 統括+部門	}

		if( dispName != "" && chk_name != dispName ) continue;
		S_name = 統括 + 部門 + 課
		if( !IsObject(Tab[S_name]) ){
			if( mCnt == 0 ){
				Tab[S_name] = {部署名:{}}
				}
			else{
				Tab[S_name] = makeTab(DB,mCnt,S_name)
				}
			}
		Tab[S_name]["直間"] = 直間
		Tab[S_name]["部署名"]["統括"] = 統括
		Tab[S_name]["部署名"]["部門"] = 部門
		Tab[S_name]["部署名"]["課"]   = 課
		Tab[S_name]["部署コード"] = xTab[i].codes.split(",")
		}
	
	for( var S_name in Tab ){
//		if( Tab[S_name]["部署コード"].length == 1 ){
			Tab[S_name]["種別"] = ( Tab[S_name]["直間"] == 2 ? "間接" : "開発" )
//			}
		}
		

	Tab["本社"] = makeTab(DB,mCnt,"本社")
	Tab["直接"] = makeTab(DB,mCnt,"直接")

	return(Tab)
	}

function makeTab(DB,mCnt,S_name)
	{

	var kindName,直間
	if( S_name == "全社" ){
		kindName = "全社"
		直間 = "0,1,2"
		}
	else if( S_name == "本社" ){
		kindName = "間接"
		直間 = "2"
		}
	else if( S_name == "直接" ){
		kindName = "直接"
		直間 = "0,1"
		}
	else{
		// S_name : 部門名
		kindName = "開発"
		直間 = ""
		}

	var work = []
	var RS = Server.CreateObject("ADODB.Recordset")
	var SQL
	SQL  = " SELECT"
	SQL += "    item = 項目"
	SQL += " FROM"
	SQL += "    収支項目マスタ"
	SQL += " WHERE"
	SQL += "    大項目 = '部門固定費'"
	SQL += " ORDER BY"
	SQL += "    item"
	RS = DB.Execute(SQL)
	while( !RS.EOF ){
		work.push(RS.Fields("item").Value)
		RS.MoveNext()
		}
	RS.Close()

	var str部門固定費 = work.join(",")

	var itemTab = new Object
	itemTab["予算"]           = "予算".split(",")
	itemTab["売上高"]         = "売上".split(",")
	itemTab["売上原価"]       = "外注費,仕入費,外注費・EMG間費用,仕入費・EMG間費用,期首棚卸,期末棚卸".split(",")
	itemTab["販管費"]         = "人件費,雑給,広告交際,交通費,通信費,発送費,備品,設備費,家賃,その他,EMG間費用".split(",")	
	itemTab["固定資産"]       = "機器・ソフト".split(",")
	itemTab["営業外収益"]     = "雑収入他,EMG間費用".split(",")
	itemTab["営業外費用"]     = "雑支出他,EMG間費用".split(",")

	itemTab["部門固定費"]     =  str部門固定費.split(",")
	itemTab["本社費配賦"]     = "本社費".split(",")

	itemTab["売上付替"]       = "収入,支出".split(",")
	itemTab["費用付替"]       = "収入,支出".split(",")
	itemTab["要員数"]         = "社員,パート,協力,契約,派遣,休職".split(",")
	itemTab["売上予測"]       = "確度70,確度50,確度30,確度10".split(",")


	var Tab = {種別:kindName,部署名:{},直間:直間,部署コード:[],計画:{},予測:{},実績:{}}
	for( var stat in Tab ){
		if( typeof(Tab[stat]) != "object" ) continue;
		for( var iTemp in itemTab){
			Tab[stat][iTemp] = new Object
			for( var n in itemTab[iTemp]){
				var kTemp = itemTab[iTemp][n]
				Tab[stat][iTemp][kTemp] = new Array(mCnt)
				for( var m = 0; m < mCnt; m++) Tab[stat][iTemp][kTemp][m] = 0
				}
			}
		}
	Tab["配賦"] = makeHaihuTab(mCnt)

	return(Tab)
	}

function makeHaihuTab(mCnt)
	{
	var itemTab = ["本社予算","売上","固定費合計","配賦対象","販管人件費","固定人件費","販管雑給","原価外注費","計算額","分配率"]
	var Tab = {計画:{},予測:{},実績:{}}
	for( var stat in Tab ){
		for( var i = 0; i < itemTab.length; i++){
			var item = itemTab[i]
			Tab[stat][item] = []
			for( var m = 0; m < mCnt; m++) Tab[stat][item][m] = 0
			}
		}
   return(Tab)
   }
%>
<%
function 本社費配賦(xTab,year,mCnt)
	{
	if( mCnt == 0 ) return
	
	for( var S_name in xTab ){
		if( S_name == "本社" ) calcTargetPlan(xTab[S_name],mCnt)
		}
	calcHaihu(xTab,year,mCnt)
	}

function 間接部門予算(xTab,mCnt)
	{
	for( var S_name in xTab ){
		if( S_name != "本社" && Tab[S_name]["種別"] == "間接" )	calcTargetPlan(xTab[S_name],mCnt)
		}
	}


//	本社費の目標値の計算（本社の費用を合計する）
function calcTargetPlan(Tab,mCnt)
	{
//	if( !IsObject(xTab["本社"]) ) return
//	var Tab = xTab["本社"]
	for(var m = 0; m < mCnt; m++ ){
		// 支出の部
		var itemStr = "売上原価,販管費,営業外費用".split(",")
		for(var iNum in itemStr){
			var item = itemStr[iNum]
			for( var kind in Tab["計画"][item]){
				Tab["計画"]["予算"]["予算"][m] += Tab["計画"][item][kind][m]
				Tab["予測"]["予算"]["予算"][m] += Tab["計画"][item][kind][m]
				Tab["実績"]["予算"]["予算"][m] += Tab["計画"][item][kind][m]
				}
			}
		// 収入の部
		var itemStr = "営業外収益,費用付替,売上付替".split(",")
		for(var iNum in itemStr){
			var item = itemStr[iNum]
			for( var kind in Tab["計画"][item]){
				Tab["計画"]["予算"]["予算"][m] -= Tab["計画"][item][kind][m]
				Tab["予測"]["予算"]["予算"][m] -= Tab["計画"][item][kind][m]
				Tab["実績"]["予算"]["予算"][m] -= Tab["計画"][item][kind][m]
				}
			}
		}
//	本社計画値から本社売上を引く
//	表示から売上を引いた数値にするため
	for(var m = 0; m < mCnt; m++ ){
		Tab["計画"]["予算"]["予算"][m] -= Tab["計画"]["売上高"]["売上"][m]
		Tab["予測"]["予算"]["予算"][m] -= Tab["計画"]["売上高"]["売上"][m]
		Tab["実績"]["予算"]["予算"][m] -= Tab["計画"]["売上高"]["売上"][m]
		}
	}

function calcHaihu(xTab,year,mCnt)
	{
EMGLog.debug("部門収支.txt","calcHaihu",year,mCnt)
/*

[本社の全計画] - [本社の売上計画] - [部門の固定費合計] = [配布対象額]


人件費・雑給・原価外注費・固定費の人件費

[全部門の合計を分母とする]



部門固定費・人件費
販管費・人件費
販管費・雑給
売上原価・"外注費

*/



//	パートの配賦は2008年度まで1/4  (0.25)
//				  2009年度から1/100(0.01)

	var partUnit = 1
	var guestUnit = 1
	if( year <= 2008 ){								// - 2008
		partUnit = 0.25
		guestUnit = 0.25
		}
	else if( year >= 2009 && year <= 2010 ){		// 2009 - 2010
		partUnit = 0.01
		guestUnit = 0.01
		}
	else if( year >= 2011 && year <= 2015){			// 2011 - 2015
		partUnit = 0.03
		guestUnit = 0.03
		}
	else if( year >= 2016 ){						// 2016 -
		partUnit = 1.0
		guestUnit = 0.10
		}
	else{
		partUnit = 1.0
		guestUnit = 0.10
		}

	var modeTab = ["計画","予測","実績"]
	for( var i = 0; i < modeTab.length; i++ ){			// 実績・予測・計画
		var mode = modeTab[i]
		for( var m = 0; m < mCnt; m++ ){
			// 配賦対象額の作成
			xTab["本社"]["配賦"][mode]["本社予算"][m]   += xTab["本社"]["計画"]["予算"]["予算"][m]
			xTab["本社"]["配賦"][mode]["売上"][m]       += xTab["本社"]["計画"]["売上高"]["売上"][m]

			// 部門の固定費合計
			for( var item in xTab["直接"][mode]["部門固定費"] ){
				xTab["本社"]["配賦"][mode]["固定費合計"][m] += xTab["直接"][mode]["部門固定費"][item][m]
				}
			// 配賦対象額の算出
//	ここの本社予算は売上を引いた数値
//	ここで売上を引かないのが正しい
			xTab["本社"]["配賦"][mode]["配賦対象"][m] += xTab["本社"]["配賦"][mode]["本社予算"][m]
//			xTab["本社"]["配賦"][mode]["配賦対象"][m] -= xTab["本社"]["配賦"][mode]["売上"][m]
			xTab["本社"]["配賦"][mode]["配賦対象"][m] -= xTab["本社"]["配賦"][mode]["固定費合計"][m]
			

			// 部門の計算の分母作成
			xTab["本社"]["配賦"][mode]["販管人件費"][m] += xTab["直接"][mode]["販管費"]["人件費"][m]
			xTab["本社"]["配賦"][mode]["販管雑給"][m]   += xTab["直接"][mode]["販管費"]["雑給"][m]
			xTab["本社"]["配賦"][mode]["原価外注費"][m] += xTab["直接"][mode]["売上原価"]["外注費"][m]
			xTab["本社"]["配賦"][mode]["固定人件費"][m] += xTab["直接"][mode]["部門固定費"]["人件費"][m]

			// 部門の計算
			for( var secName in xTab ){
				if( secName == "本社" || secName == "直接" ) continue;
				xTab[secName]["配賦"][mode]["販管人件費"][m] += xTab[secName][mode]["販管費"]["人件費"][m]
				xTab[secName]["配賦"][mode]["固定人件費"][m] += xTab[secName][mode]["部門固定費"]["人件費"][m]
				xTab[secName]["配賦"][mode]["原価外注費"][m] += xTab[secName][mode]["売上原価"]["外注費"][m]
				xTab[secName]["配賦"][mode]["販管雑給"][m]   += xTab[secName][mode]["販管費"]["雑給"][m]
				}

			for( var secName in xTab ){
				if( secName == "直接" ) continue;
				xTab[secName]["配賦"][mode]["計算額"][m] += xTab[secName]["配賦"][mode]["販管人件費"][m]
				if( year >= 2013 ){
					xTab[secName]["配賦"][mode]["計算額"][m] += xTab[secName]["配賦"][mode]["固定人件費"][m]
					}
				xTab[secName]["配賦"][mode]["計算額"][m] += (xTab[secName]["配賦"][mode]["販管雑給"][m]*partUnit)
				xTab[secName]["配賦"][mode]["計算額"][m] += (xTab[secName]["配賦"][mode]["原価外注費"][m]*guestUnit)
				}
			// 分配の計算
			for( var secName in xTab ){
				if( secName == "本社" || secName == "直接" ) continue;
				xTab[secName]["配賦"][mode]["分配率"][m] = xTab[secName]["配賦"][mode]["計算額"][m] / xTab["本社"]["配賦"][mode]["計算額"][m]
				}
			// 分配の計算

			for( var secName in xTab ){
				if( secName == "本社" || secName == "直接" ) continue;
				var value = xTab["本社"]["配賦"][mode]["配賦対象"][m] * xTab[secName]["配賦"][mode]["分配率"][m]
				xTab[secName][mode]["本社費配賦"]["本社費"][m] = ( isNaN(value) ? 0 : value )
				}


			}
		}
	}

%>
<%
// 売上・実績データ取得
function uriageActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
   {
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;

	var RS = Server.CreateObject("ADODB.Recordset")

//	実績データ
	var SQL = ""
	var SQLTab = []

	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"
		SQL += "	  yymm   = DATA.yymm,"
		SQL += "	  amount = sum(DATA.金額)"
		SQL += " FROM"
		SQL += "	  営業売上データ DATA "
		SQL += "                     LEFT JOIN 業務部署データ BUSYO"
		SQL += "                          ON DATA.pNum    = BUSYO.pNum"
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate + "') )  MAST"
		SQL += "                          ON MAST.部署コード = BUSYO.部署ID"
		SQL += " WHERE"
		SQL += "      (DATA.yymm BETWEEN " + s_yymm + " and " + e_yymm + ")"
		SQL += "      AND"
		SQL += "	  (DATA.yymm Between BUSYO.開始 And BUSYO.終了)"
		SQL += "	  AND"
		SQL += "	  DATA.付替 = 0"
		SQL += "	  AND"
		SQL += "	  DATA.Flag = 0"
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    BUSYO.部署ID IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.直間,"
		SQL += "	  DATA.yymm"
		SQLTab.push(SQL)
		}
	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)

	var n,pNum,amount,Grp,c_yymm,mode
	while(!RS.EOF){
		S_name  = RS.Fields('S_name').Value
		直間    = RS.Fields('直間').Value
		c_yymm  = RS.Fields('yymm').Value
		amount  = RS.Fields('amount').Value

		if( S_name == null ){
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff( yymm, c_yymm )
		Tab[secName]["実績"]["売上高"]["売上"][n] += amount
		RS.MoveNext()
		}
	RS.Close()
	}

//	グループ毎の費用実績
function accountActual(DB,Tab,yymm,mCnt,dispMode,dispName)
	{
	var stat = "実績"
	var RS = Server.CreateObject("ADODB.Recordset")
	var SQL = ""

	var d = new Date()
	var now_yymm = (d.getFullYear() * 100) + (d.getMonth()+1)

	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm,e_yymm,c_yymm
	s_yymm = yymm
	e_yymm = yymmAdd(yymm,mCnt-1)
   
   
// 費用
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      直間    = MAST.直間,"
		SQL += "      大項目  = ITEM.大項目,"
		SQL += "      分類    = ITEM.分類,"
		SQL += "      KmkCode = DATA.科目,"
		SQL += "      yymm    = DATA.yymm,"
		SQL += "      EMG     = DATA.Flag,"
		SQL += "      amount  = Sum(DATA.金額)"
		SQL += " FROM"
		SQL += "    会計月データ DATA "
		SQL += "                 LEFT JOIN 会計項目マスタ ITEM"
		SQL += "                      ON DATA.科目 = ITEM.KmkCode AND DATA.Flag = ITEM.Flag"
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate + "') ) MAST"
		SQL += "                      ON DATA.部門 = MAST.ACCコード"
		SQL += " WHERE"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		SQL += "    AND"
		SQL += "    MAST.ACCコード >= 0"
		SQL += "    AND"
		SQL += "    NOT (DATA.科目 BETWEEN 211 AND 260)"				// 大項目 = 固定資産
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "    MAST.直間,"
		SQL += "    ITEM.大項目,"
		SQL += "    ITEM.分類,"
		SQL += "    DATA.科目,"
		SQL += "    DATA.yymm,"
		SQL += "    DATA.Flag"
		SQLTab.push(SQL)

		var iName = "固定資産"
		var kName = "機器・ソフト"
		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      直間    = MAST.直間,"

		SQL += "      大項目  = '" + iName + "',"
		SQL += "      分類    = '" + kName + "',"
		SQL += "      KmkCode = DATA.科目,"
		SQL += "      yymm    = DATA.yymm,"
		SQL += "      EMG     = DATA.Flag,"
		SQL += "      amount  = Sum(DATA.金額)"
		SQL += " FROM"
		SQL += "    会計月データ DATA "
		SQL += "                 LEFT JOIN 会計項目マスタ ITEM"
		SQL += "                      ON DATA.科目 = ITEM.KmkCode AND DATA.Flag = ITEM.Flag"
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate + "') ) MAST"
		SQL += "                      ON DATA.部門 = MAST.ACCコード"
		SQL += " WHERE"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		SQL += "    AND"
		SQL += "    MAST.ACCコード >= 0"
		SQL += "    AND"
		SQL += "    DATA.科目 BETWEEN 211 AND 260"				// 大項目 = 固定資産
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		SQL += " GROUP BY"
		SQL += "    MAST.直間,"
		SQL += "    ITEM.大項目,"
		SQL += "    ITEM.分類,"
		SQL += "    DATA.科目,"
		SQL += "    DATA.yymm,"
		SQL += "    DATA.Flag"
		SQLTab.push(SQL)

		}

	SQL = SQLTab.join(" UNION ALL ")

	RS = DB.Execute(SQL)
	var Grp,kind,item,yymm,amount,Cnt,mode,area
	while(!RS.EOF){
		直間    = RS.Fields('直間').Value
		S_name  = RS.Fields('S_name').Value
		item    = RS.Fields("大項目").Value
		kind    = RS.Fields("分類").Value
		yymm    = RS.Fields("yymm").Value
		amount  = RS.Fields("amount").Value
		flag    = RS.Fields("EMG").Value
		KmkCode = RS.Fields("KmkCode").Value

		if( S_name == null ){
			errorMsg("accountActual1")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		if( item != null && kind != null ){
			n = yymmDiff(s_yymm, yymm)
			if( flag == 1 ) amount = -amount
			Tab[secName][stat][item][kind][n] += amount
			}
		else{
			var work = "[" + yymm + "][" +  + KmkCode + "][" + amount + "]"
			EMGLog.Write("naka.txt", "[会計データ集計での不明科目データ]" + work)
			}
		RS.MoveNext()
		}
	RS.Close()

	}


// 費用付替・実績データ取得
function accountCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
   {
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;

	var RS = Server.CreateObject("ADODB.Recordset")

//	******費用付替******
// 支払い部署が指定してある
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      直間    = MAST.直間,"
		SQL += "      payMode = '支払',"

		SQL += "      部署    = COST.支払部署,"
		SQL += "      yymm    = COST.yymm,"
		SQL += "      金額    = COST.付替金額"
		SQL += " FROM"
		SQL += "      付替データ COST "
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                      ON COST.支払部署 = MAST.部署コード"

		SQL += " WHERE"
		SQL += "      COST.mode = 1"
		SQL += "      AND"
		SQL += "      COST.yymm BETWEEN " + s_yymm + " and " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}

		SQLTab.push(SQL)


		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      直間    = MAST.直間,"
		SQL += "      payMode = '受取',"

		SQL += "      部署     = COST.受取部署,"
		SQL += "      yymm     = COST.yymm,"
		SQL += "      金額     = COST.付替金額"
		SQL += " FROM"
		SQL += "      付替データ COST "
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                      ON COST.受取部署 = MAST.部署コード"

		SQL += " WHERE"
		SQL += "      COST.mode = 1"
		SQL += "      AND"
		SQL += "      COST.yymm BETWEEN " + s_yymm + " and " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}

		SQLTab.push(SQL)

		}
	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var n,pNum,amount,cost,c_yymm,mode1,mode2,src_Grp,dst_Grp
	while(!RS.EOF){
		payMode = RS.Fields('payMode').Value
		直間    = RS.Fields('直間').Value
		S_name  = RS.Fields('S_name').Value
		c_yymm  = RS.Fields('yymm').Value
		cost    = RS.Fields('金額').Value

		if( S_name == null ){
			errorMsg("accountCost")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
		}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff( yymm, c_yymm )
		if( payMode == "支払" ) Tab[secName]["実績"]["費用付替"]["支出"][n] -= cost
		if( payMode == "受取" ) Tab[secName]["実績"]["費用付替"]["収入"][n] += cost
		RS.MoveNext()
		}
	RS.Close()
	}



// 売上付替・実績データ取得
function salesCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
   {
//   return
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;

	var RS = Server.CreateObject("ADODB.Recordset")

//	*****売上付替(支払)*****
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "      pNum   = DATA.pNum,"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      付替   = DATA.付替,"
		SQL += "      金額   = sum(DATA.金額)"
		SQL += " FROM"
		SQL += "      営業売上データ DATA"
		SQL += "                     LEFT JOIN 業務部署データ BUSYO"
		SQL += "                          ON DATA.pNum    = BUSYO.pNum"
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                          ON BUSYO.部署ID = MAST.部署コード"
		SQL += " WHERE"
		SQL += "       DATA.付替 IN(1,2)"
		SQL += "       AND"
		SQL += "       DATA.yymm Between BUSYO.開始 And BUSYO.終了"
		SQL += "       AND"
		SQL += "       DATA.yymm BETWEEN " + s_yymm + " and " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.直間,"
		SQL += "      DATA.pNum,"
		SQL += "      DATA.yymm,"
		SQL += "      DATA.付替"

		SQLTab.push(SQL)
		}

	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var n,pNum,amount,cost,c_yymm,mode,mode2,Grp,dst_Grp,kind
	var secName
	while(!RS.EOF){
		直間    = RS.Fields('直間').Value
		S_name  = RS.Fields('S_name').Value
		c_yymm  = RS.Fields('yymm').Value
		kind    = RS.Fields('付替').Value
		cost    = RS.Fields('金額').Value
		if( S_name == null ){
			errorMsg("salesCost")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}
		if( !IsObject(Tab[secName]) ){
//			Tab[secName] = makeTab(DB,mCnt,secName)
			}
		n = yymmDiff( yymm, c_yymm )
		if( kind == 1 ) Tab[secName]["実績"]["売上付替"]["支出"][n] += cost
		if( kind == 2 ) Tab[secName]["実績"]["売上付替"]["収入"][n] += cost

		RS.MoveNext()
		}
	RS.Close()
	}


//	グループ毎の部門固定費データ
function groupCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
	{
//return
	var RS = Server.CreateObject("ADODB.Recordset")
	var SQL = ""

	var d = new Date()
	var now_yymm = (d.getFullYear() * 100) + (d.getMonth()+1)

	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm,e_yymm,c_yymm
	s_yymm = yymm
	e_yymm = yymmAdd(yymm,mCnt-1)



   
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "      大項目 = ITEM.大項目,"
		SQL += "      項目   = ITEM.項目,"
		SQL += "      種別   = (CASE WHEN DATA.種別 = 0 THEN '計画' ELSE '予測' END),"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      amount = Sum(DATA.数値)"
		SQL += " FROM"
		SQL += "      収支計画データ DATA "
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                          ON DATA.部署ID = MAST.部署コード"
		SQL += "                     LEFT JOIN 収支項目マスタ ITEM"
		SQL += "                          ON DATA.項目ID = ITEM.ID"
		SQL += " WHERE"
		SQL += "      ITEM.大項目 = '部門固定費'"
		SQL += "      AND"
		SQL += "      DATA.種別 IN(0,1)"				// 計画・予測
		SQL += "      AND"
		SQL += "      MAST.ACCコード >= 0"
		SQL += "      AND"
		SQL += "      DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.直間,"
		SQL += "      ITEM.大項目,"
		SQL += "      ITEM.項目,"
		SQL += "      DATA.種別,"
		SQL += "      DATA.yymm"
		SQLTab.push(SQL)

//	実績データ
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "      大項目 = ITEM.大項目,"
		SQL += "      項目   = ITEM.項目,"
		SQL += "      種別   = '実績',"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      amount = Sum(DATA.費用)"
		SQL += " FROM"
		SQL += "      部門固定費実績データ DATA "
		SQL += "                           LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                                ON DATA.部署ID = MAST.部署コード"
		SQL += "                           LEFT JOIN 収支項目マスタ ITEM"
		SQL += "                                ON DATA.項目ID = ITEM.ID"

		SQL += " WHERE"
		SQL += "      ITEM.大項目 = '部門固定費'"
		SQL += "      AND"
		SQL += "      MAST.ACCコード >= 0"
		SQL += "      AND"
		SQL += "      DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "    MAST.直間,"
		SQL += "    ITEM.大項目,"
		SQL += "    ITEM.項目,"
		SQL += "    DATA.yymm"
		SQLTab.push(SQL)

		}
	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	while(!RS.EOF){
		直間     = RS.Fields("直間").Value
		S_name   = RS.Fields("S_name").Value
		item     = RS.Fields("大項目").Value
		kind     = RS.Fields("項目").Value
		statName = RS.Fields("種別").Value
		yymm     = RS.Fields("yymm").Value
		amount   = RS.Fields("amount").Value

		if( S_name == null ){
			errorMsg("groupCost1")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff(s_yymm, yymm)
		Tab[secName][statName][item][kind][n] += amount * ( statName == "実績" ? 1 : 1000 )
		RS.MoveNext()
		}
	RS.Close()

	}

// 売上予測データ取得
function uriageYosoku(DB,Tab,yymm,mCnt,dispMode,dispName,listMode,fixLevel)
	{
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;


	var RS = Server.CreateObject("ADODB.Recordset")


//	予測データ
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "	  level  = PNUM.fix_level,"
		SQL += "	  yymm   = DATA.yymm,"
		SQL += "	  amount = sum(DATA.sales) * 1000"
		SQL += " FROM"
		SQL += "	  営業予測データ DATA "
		SQL += "                     LEFT JOIN 業務部署データ BUSYO"
		SQL += "                          ON DATA.pNum       = BUSYO.pNum"
		SQL += "	                 LEFT JOIN projectNum     PNUM"
		SQL += "                          ON DATA.pNum       = PNUM.pNum"
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate + "') )  MAST"
		SQL += "                          ON MAST.部署コード = BUSYO.部署ID"

		SQL += " WHERE"
		SQL += "	  PNUM.stat IN(0,1,4,5)"
		SQL += "      and"
		SQL += "      PNUM.fix_level >= 10"
		SQL += "	  AND"
		SQL += "	  (DATA.yymm Between BUSYO.開始 And BUSYO.終了)"
		SQL += "	  AND"
		SQL += "      (DATA.yymm BETWEEN " + s_yymm + " and " + e_yymm + ")"

		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    BUSYO.部署ID IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.直間,"
		SQL += "      PNUM.fix_level,"
		SQL += "      DATA.yymm"

		SQLTab.push(SQL)
		}

	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var n,pNum,amount,Grp,c_yymm,mode
	var secName
	while(!RS.EOF){
		直間    = RS.Fields('直間').Value
		S_name  = RS.Fields('S_name').Value
		level   = parseInt(RS.Fields('level').Value)
		c_yymm  = RS.Fields('yymm').Value
		amount  = RS.Fields('amount').Value

		if( S_name == null ){
			errorMsg("uriageYosoku")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}
		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff( yymm, c_yymm )
		if( level >= 70 ) Tab[secName]["予測"]["売上予測"]["確度70"][n] += amount
		if( level >= 50 ) Tab[secName]["予測"]["売上予測"]["確度50"][n] += amount
		if( level >= 30 ) Tab[secName]["予測"]["売上予測"]["確度30"][n] += amount
		if( level >= 10 ) Tab[secName]["予測"]["売上予測"]["確度10"][n] += amount
		RS.MoveNext()
		}
	RS.Close()

	for( var secName in Tab ){
		for( var m = 0; m < mCnt; m++ ){
			Tab[secName]["予測"]["売上高"]["売上"][m] = Tab[secName]["予測"]["売上予測"]["確度" + fixLevel][m]
			}
		}
	}

//	グループ毎の計画データ
function groupPlan(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
   {
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL = ""
   var d = new Date()
   var now_yymm = (d.getFullYear() * 100) + (d.getMonth()+1)

   var s_yymm,e_yymm,c_yymm
   s_yymm = yymm
   e_yymm = yymmAdd(yymm,mCnt-1)

	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "      大項目 = ITEM.大項目,"
		SQL += "      項目   = ITEM.項目,"
		SQL += "      種別   = (CASE WHEN DATA.種別 = 0 THEN '計画' ELSE '予測' END),"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      amount = Sum(DATA.数値)"
		SQL += " FROM"
		SQL += "      収支計画データ DATA "
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                          ON DATA.部署ID = MAST.部署コード"
		SQL += "                     LEFT JOIN 収支項目マスタ ITEM"
		SQL += "                          ON DATA.項目ID = ITEM.ID"
		SQL += " WHERE"
		SQL += "      ITEM.大項目 NOT IN('部門固定費','要員数')"
		SQL += "      AND"
		SQL += "      DATA.種別 IN(0,1)"				// 計画・予測
		SQL += "      AND"
		SQL += "      MAST.ACCコード >= 0"
		SQL += "      AND"
		SQL += "      DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.直間,"
		SQL += "      ITEM.大項目,"
		SQL += "      ITEM.項目,"
		SQL += "      DATA.種別,"
		SQL += "      DATA.yymm"
		SQLTab.push(SQL)
		}
	SQL = SQLTab.join(" UNION ALL ")

	RS = DB.Execute(SQL)
	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	var secName

	while(!RS.EOF){
		S_name   = RS.Fields("S_name").Value
		直間	 = RS.Fields("直間").Value
		item	 = RS.Fields("大項目").Value
		kind	 = RS.Fields("項目").Value
		statName =  RS.Fields("種別").Value
		yymm	 = RS.Fields("yymm").Value
		amount   = RS.Fields("amount").Value


		if( S_name == null ){
			errorMsg("groupPlan")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}
		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		if( item == "売上付替" && kind =="支出" ) amount = -amount
		if( item == "費用付替" && kind =="支出" ) amount = -amount
		if( item == "売上原価" && kind =="期末棚卸" ) amount = -amount

//		
		if( !IsObject(Tab[secName][statName][item][kind]) ){
			Tab[secName][statName][item][kind] = new Array(mCnt)
			for( var m = 0; m < mCnt; m++ ) Tab[secName][statName][item][kind][m] = 0
			}
		// 売上予測は別のところで集計
		if( !(statName == "予測" && kind == "売上") ){
			n = yymmDiff(s_yymm, yymm)
			if( item == "要員数" ){
				Tab[secName][statName][item][kind][n] += amount
				}
			else if( item == "売上原価" && statName == "予測" && (kind =="期末棚卸" || kind =="期首棚卸") ){
//				if( kind =="期末棚卸" ) amount = -amount
				Tab[secName]["予測"][item][kind][n] += amount * 1000
				Tab[secName]["実績"][item][kind][n] += amount * 1000
				}
			else{
				Tab[secName][statName][item][kind][n] += amount * 1000
				}
			}

		RS.MoveNext()
		}

	RS.Close()

	}
   


function errorMsg(s)
	{
	EMGLog.Write("naka.txt","ERROR: "+s)
	}
%>
<%
//	グループ毎の要員計画・予測
function memberPlan(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
	{
	var RS = Server.CreateObject("ADODB.Recordset")
	var SQL = ""

	var d = new Date()
	var now_yymm = (d.getFullYear() * 100) + (d.getMonth()+1)

	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm,e_yymm,c_yymm
	s_yymm = yymm
	e_yymm = yymmAdd(yymm,mCnt-1)
   
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "    大項目 = ITEM.大項目,"
		SQL += "    項目   = ITEM.項目,"
		SQL += "    種別   = DATA.種別,"
		SQL += "    yymm   = DATA.yymm,"
		SQL += "    value  = Sum(DATA.数値)"
		SQL += " FROM"
		SQL += "    収支計画データ DATA"
		SQL += "                   LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                        ON DATA.部署ID     = MAST.部署コード"
		SQL += "                   LEFT JOIN (SELECT * FROM 統括本部マスタ     WHERE NOT(開始 > '" + e_yymm + "' or 終了 < '" + s_yymm + "') ) TM"
		SQL += "                        ON MAST.部署コード = TM.部署ID"
		SQL += "                   LEFT JOIN 収支項目マスタ     ITEM ON DATA.項目ID = ITEM.ID"


		SQL += " WHERE"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		SQL += "    AND"
		SQL += "    DATA.種別 IN(0,1)"				// 計画・予測
		SQL += "    AND"
		SQL += "    ITEM.大項目 = '要員数'"
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}

		SQL += " GROUP BY"
		SQL += "    MAST.直間,"
		SQL += "    ITEM.大項目,"
		SQL += "    ITEM.項目,"
		SQL += "    DATA.種別,"
		SQL += "    DATA.yymm"
		SQLTab.push(SQL)
//EMGLog.Write("x.txt",SQL)

		}

	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)

	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	while(!RS.EOF){
		直間    = RS.Fields('直間').Value
		S_name  = RS.Fields('S_name').Value
		item    = RS.Fields("大項目").Value
		kind    = RS.Fields("項目").Value
		stat    = RS.Fields("種別").Value
		yymm    = RS.Fields("yymm").Value
		value   = RS.Fields("value").Value
		statName = (stat == 0 ? "計画" : "予測")

		if( S_name == null ){
			errorMsg("accountActual2")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)


		n = yymmDiff(s_yymm, yymm)
		Tab[secName][statName][item][kind][n] += value

		RS.MoveNext()
		}
	RS.Close()
	}

//	グループ毎の実績要員数
function memberActual(DB,xTab,yymm,mCnt,dispMode,dispName)
	{
//	区分 (0:社員,1:パート,2:契約,10:派遣)

	var RS = Server.CreateObject("ADODB.Recordset")
	var SQL = ""

	var d = new Date()
	var now_yymm = (d.getFullYear() * 100) + (d.getMonth()+1)

	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm,e_yymm,c_yymm
	s_yymm = yymm
	e_yymm = yymmAdd(yymm,mCnt-1)

/*
 1 : 社長
 2 : 取締役
34 : 副会長
35 : 取締役専務
37 : 最高業務執行責任者
38 : 会長
39 : 執行役員副社長
40 : 取締役副会長
41 : 執行役員専務
42 : 執行役員常務
43 : CA
44 : 取締役執行役員専務
45 : 執行役員			 XXX 井上、野田
46 : 取締役執行役員常務　XXX 小原
88 : 顧問
*/

   
	var yakuStr = "1,2,34,35,37,38,39,40,41,42,43,44,88"
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      直間   = MAST.直間,"

		SQL += "    yymm   = DATA.yymm,"
		SQL += "    区分   = DATA.区分,"
		SQL += "    value  = count(DATA.memberID)"

		SQL += " FROM"
		SQL += "    要員所属データ DATA"
		SQL += "           LEFT JOIN (SELECT * FROM EMG.dbo.部署マスタ WHERE NOT(開始 > '" + eDate  + "' or 終了 < '" + sDate  + "') ) MAST"
		SQL += "                ON DATA.部署ID     = MAST.部署コード"
		SQL += "           LEFT JOIN (SELECT * FROM 統括本部マスタ     WHERE NOT(開始 > '" + e_yymm + "' or 終了 < '" + s_yymm + "') ) TM"
		SQL += "                ON MAST.部署コード = TM.部署ID"

		SQL += " WHERE"
		SQL += "    DATA.区分 IN(0,1,2)"
		SQL += "    AND"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["部署コード"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.部署コード IN(" + Tab[S_name]["部署コード"].join(",") + ")"
			}
		if( Tab[S_name]["直間"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.直間 IN(" + Tab[S_name]["直間"] + ")"
			}

		SQL += " GROUP BY"
		SQL += "    MAST.直間,"
		SQL += "    DATA.yymm,"
		SQL += "    DATA.区分"
		
		SQLTab.push(SQL)
		}

	SQL = SQLTab.join(" UNION ALL ")		
	RS = DB.Execute(SQL)

	var statName = "実績"
	var item = "要員数"
//	var kindTab = {0:"社員",1:"パート",2:"契約",10:"派遣"}
	var kindTab = {0:"社員",1:"パート",2:"社員"}
	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	while(!RS.EOF){
		直間    = RS.Fields('直間').Value
		S_name  = RS.Fields('S_name').Value
		kind    = RS.Fields("区分").Value
		yymm    = RS.Fields("yymm").Value
		value   = RS.Fields("value").Value

		kindName = ( IsObject(kindTab[kind]) ? kindTab[kind] : "" )

		if( S_name == null ){
			errorMsg("accountActual2")
			secName = "不明"
			}
		else if( dispMode == "全社" ){
			secName = "全社"
			}
		else if( dispMode == "本社" ){
			secName = ( 直間 == 2 ? "本社" : "直接" )
			}
		else{
			secName = S_name
			}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff(s_yymm, yymm)
		Tab[secName][statName][item][kindName][n] += value
		RS.MoveNext()
		}
	RS.Close()

	}

%>
<%
function getGroupInfo(yymm,secStr,dispMode)
   {
try{
	var yy = parseInt(yymm / 100)
	var mm = yymm % 100
	var year = yy + ( mm < 10 ? 0 : 1 )
	var secMode
	
	switch(secStr){
		case "0,1" :
			secMode = "開発"
			break;
		case "2" :
			secMode = "間接"
			break;
		case "0,1,2" :
			secMode = ""
			break;
		default :
			secMode = ""
			break;
			}

	var serverName = "http://" + Request.ServerVariables("SERVER_NAME")
	var sURL = serverName + "/Project/common_data/xmlProc/部門リスト_XML.asp"

	var para = []
	para.push("year=" + year)
	para.push("secMode=" + secMode)
//	para.push("dispMode=" + "部")
//	para.push("dispMode=" + "課")
	para.push("dispMode=" + dispMode)
	sURL += "?" + para.join("&")
		
//	EMGLog.Write("x.txt",sURL)

	var httpObj = Server.CreateObject("Microsoft.XMLHTTP");
	httpObj.open("POST",sURL,false);
	httpObj.send(null);
	if( httpObj.status != 200) throw new Error("xml エラー[" + httpObj.status + "]：" + sURL)

	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false
	var ret = xmlDoc.load(httpObj.responseXML)

//	EMGLog.Write("x.txt",ret)

	var modeTab = ["開発","営業","間接"]

	var Nodes = xmlDoc.selectNodes("//部署")

//	EMGLog.Write("x.txt",Nodes.length)

	var Tab = []
	var Cnt = Nodes.length
	for( var i = 0; i < Cnt; i++ ){
		var T_name = Nodes[i].getAttribute("統括")
		var B_name = Nodes[i].getAttribute("部")
		var K_name = Nodes[i].getAttribute("課")
		var mode   = Nodes[i].getAttribute("直間")
		var gCode  = Nodes[i].getAttribute("部門コード")
		var codes  = Nodes[i].getAttribute("codes")
		var gName  = T_name + B_name + K_name
		Tab.push({直間:mode,gCode:gCode,名前:gName,統括:T_name,部:B_name,課:K_name,codes:codes})
		}
   return(Tab);
}catch(e){
	EMGLog.debug("x.txt",e.message)
	}
	}
	
function paraOut()
	{
	var Tab = []
	var Cnt = arguments.length
	for( var i = 0; i < Cnt; i++ ){
		Tab.push(arguments[i])
		}
	return("[" + Tab.join("][") + "]")
	}


%>
