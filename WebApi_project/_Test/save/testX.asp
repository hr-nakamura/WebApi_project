<%@ Language=JScript %>
<!--#include file="inc/cmn.inc"-->
<!--#include file="inc/Jcmn.inc"-->
<!--#include file="inc/json.inc"-->
<!--#include file="inc/dispXML.inc"-->
<!--#include file="inc/xml_save.inc"-->

<%

    var queryInfo = {
		"year"        : 2022,
		"dispMode"    : "部",
		"secMode"     : "開発",
		"actual"      : "123"
		}
	$queryInfoCheck(queryInfo);



	var result = JSON.stringify(queryInfo, null, 2);

	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false


	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)


	var commnt = xmlDoc.createComment("指定期間の所属データ")
	xmlDoc.appendChild(commnt)

	var rootNode = xmlDoc.createElement("root")
	xmlDoc.appendChild(rootNode)

	var mainNode = xmlDoc.createElement("全体")
	rootNode.appendChild(mainNode)

	var Node = xmlDoc.createElement("queryString")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(result)
	Node.appendChild(Text)


	Response.CharSet	 = "SHIFT_JIS"
//	Response.ContentType = "text/xml"


Response.Write(xmlDoc.outerXML);
	xmlDoc.save(Response)

	Response.End

%>
