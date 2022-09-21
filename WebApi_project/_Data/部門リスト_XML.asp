<%@ Language=JavaScript %>
<!--#include file   ="���僊�X�g_List.inc"-->
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/Jcmn.inc"-->
<!--#include virtual="/Project/inc/json.inc"-->
<!--#include virtual="/Project/inc/dispXML.inc"-->
<%
try{

    var queryInfo = {
		"year"        : 2022,
		"dispMode"    : "��",
		"secMode"     : "�J��"
		}
	$queryInfoCheck(queryInfo);

	var d = new Date()
	var yy = d.getFullYear()
	var mm = d.getMonth()+1
	var dd = d.getDate()
	var year = yy + (mm >= 10 ? 1 : 0)             // 10���ȍ~�͎��N�x��\��
//	var secMode = ""
	var secMode = "�J��"
//	var secMode = "�Ԑ�"
//	var dispMode = "��"
	var dispMode = "��"
//	var dispMode = "����"
	var secMode = ""

	year      = ( Request.QueryString("year").Count == 0 ? year : Request.QueryString("year").Item)
	dispMode  = ( Request.QueryString("dispMode").Count  == 0 ? dispMode : Request.QueryString("dispMode").Item )

	secMode   = ( Request.QueryString("secMode").Count  == 0 ? secMode : Request.QueryString("secMode").Item )


    var InfoTab = { "���" :{
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

	var main2 = xmlDoc.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='../xsl/GRP_���X�g_Select.xsl'") 
//	xmlDoc.appendChild(main2)

	var commnt = xmlDoc.createComment("�w����Ԃ̏����f�[�^")
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

	var mainNode = xmlDoc.createElement("�S��")
	rootNode.appendChild(mainNode)

	var Node = xmlDoc.createElement("�N�x")
	Node.setAttribute("year",year)
	mainNode.appendChild(Node)


	for( var i = 0; i < Tab.length; i++ ){
		var ����_Node = xmlDoc.createElement("����")
		����_Node.setAttribute("����",Tab[i].����)
		����_Node.setAttribute("��",Tab[i].��)
		����_Node.setAttribute("��",Tab[i].��)

		����_Node.setAttribute("���O",Tab[i].���O)
		����_Node.setAttribute("����",Tab[i].����)
		����_Node.setAttribute("����R�[�h",Tab[i].����R�[�h)
		����_Node.setAttribute("codes",Tab[i].codes)

//		var ���O_Node = xmlDoc.createElement("���O")
//		var Text = xmlDoc.createTextNode(Tab[i].Name)
//		���O_Node.appendChild(Text)
//		����_Node.appendChild(���O_Node)
		mainNode.appendChild(����_Node)

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
