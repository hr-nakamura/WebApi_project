<%@ Language=JavaScript %>
<!--#include file   ="部門リスト_List.inc"-->
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/Jcmn.inc"-->
<!--#include virtual="/Project/inc/json.inc"-->
<!--#include virtual="/Project/inc/dispXML.inc"-->
<%
try{

    var queryInfo = {
		"year"        : 2022,
		"dispMode"    : "部",
		"secMode"     : "開発"
		}
	$queryInfoCheck(queryInfo);

	var d = new Date()
	var yy = d.getFullYear()
	var mm = d.getMonth()+1
	var dd = d.getDate()
	var year = yy + (mm >= 10 ? 1 : 0)             // 10月以降は次年度を表示
//	var secMode = ""
	var secMode = "開発"
//	var secMode = "間接"
//	var dispMode = "課"
	var dispMode = "部"
//	var dispMode = "統括"
	var secMode = ""

	year      = ( Request.QueryString("year").Count == 0 ? year : Request.QueryString("year").Item)
	dispMode  = ( Request.QueryString("dispMode").Count  == 0 ? dispMode : Request.QueryString("dispMode").Item )

	secMode   = ( Request.QueryString("secMode").Count  == 0 ? secMode : Request.QueryString("secMode").Item )


    var InfoTab = { "情報" :{
						"@year"     : year,
						"@dispMode" : dispMode,
						"@secMode"  : secMode,
						"queryInfo" : queryInfo
						 }
					};

	var paraMemo = argOut(year,secMode,dispMode)
	
	var Tab = sectionList(year,secMode,dispMode)

//Response.End

//	dispXML(""+year,Tab)

	var xmlDoc = Server.CreateObject("MSXML2.DOMDocument.6.0")
	xmlDoc.async=false

	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)

	var main2 = xmlDoc.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='../xsl/GRP_リスト_Select.xsl'") 
//	xmlDoc.appendChild(main2)

	var commnt = xmlDoc.createComment("指定期間の所属データ")
//	xmlDoc.appendChild(commnt)

	var commnt = xmlDoc.createComment(paraMemo)
	xmlDoc.appendChild(commnt)

	makeXML(xmlDoc,Tab,year)
	
	var root = xmlDoc.selectSingleNode("root");
	$attachInfo(root,InfoTab);

	Response.CharSet	 = "SHIFT_JIS"
	Response.ContentType = "text/xml"
	xmlDoc.save(Response)

	Response.End


}catch(e){
	EMGLog.Write("naka.txt",e.message)
	}




function makeXML(xmlDoc,Tab,year)
	{
	var yymm = ((year-1) * 100) + 10
//=============================================================================================================
//================================================================

	var rootNode = xmlDoc.createElement("root")
	xmlDoc.appendChild(rootNode)

	var mainNode = xmlDoc.createElement("全体")
	rootNode.appendChild(mainNode)

	var Node = xmlDoc.createElement("年度")
	Node.setAttribute("year",year)
	mainNode.appendChild(Node)


	for( var i = 0; i < Tab.length; i++ ){
		var 部署_Node = xmlDoc.createElement("部署")
		部署_Node.setAttribute("統括",Tab[i].統括)
		部署_Node.setAttribute("部",Tab[i].部)
		部署_Node.setAttribute("課",Tab[i].課)

		部署_Node.setAttribute("名前",Tab[i].名前)
		部署_Node.setAttribute("直間",Tab[i].直間)
		部署_Node.setAttribute("部門コード",Tab[i].部門コード)
		部署_Node.setAttribute("codes",Tab[i].codes)

//		var 名前_Node = xmlDoc.createElement("名前")
//		var Text = xmlDoc.createTextNode(Tab[i].Name)
//		名前_Node.appendChild(Text)
//		部署_Node.appendChild(名前_Node)
		mainNode.appendChild(部署_Node)

		}
	}
%>
<%
function argOut()
	{
	var Tab = []
	var Cnt = arguments.length
	for( var i = 0; i < Cnt; i++ ){
		Tab.push(arguments[i])
		}
	return("["+Tab.join("][")+"]")
	}
%>
