<%@ Language=JavaScript %>
<!--#include virtual="/Project/common_data/�m����t.inc"-->
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/dispXML.inc"-->
<%
try{
	var d = new Date()
	var yy = d.getFullYear()
	var mm = d.getMonth()+1
	var dd = d.getDate()
	var year = yy + (mm >= 10 ? 1 : 0)             // 10���ȍ~�͎��N�x��\��

//	year = 2015

//	var dispCmd = "�����z��"
//	var dispCmd = "�����ڍ�"
//	var dispCmd = "����z��"


var secMode = "�Ԑ�"
var dispCmd = "�Ԑڈꗗ"
var dispName = ""
var specialMode = ""								// �����Ǘ��p

	var debugMode = "�J���E����ꗗ"
	switch(debugMode){
		case "EMG" :
			var dispCmd = "EMG"
			break;

		case "�J���E�����ꗗ" :
			var dispCmd = "�����ꗗ"
			var secMode  = "�J��"
			break;

		case "�J���E����ꗗ" :
			var dispCmd = "����ꗗ"		
			var secMode  = "�J��"
			break;
		case "�J���E�ۈꗗ" :
			var dispCmd = "�ۈꗗ"		
			var secMode  = "�J��"
			break;

		case "�ԐځE����ꗗ" :
			var dispCmd = "����ꗗ"		
			var secMode  = "�Ԑ�"
			break;
		case "�ԐځE�ۈꗗ" :
			var dispCmd = "�ۈꗗ"		
			var secMode  = "�Ԑ�"
			break;

		case "�J���E�����ڍ�" :
			var dispCmd  = "�����ڍ�"
			var secMode  = "�J��"
			var dispName = "���ƊJ���{��"
			break;
		case "�J���E����ڍ�" :
			var dispCmd  = "����ڍ�"
			var secMode  = "�J��"
			var dispName = "�J���{����1�J����"
			break;
		case "�J���E�ۏڍ�" :
			var dispCmd  = "�ۏڍ�"
			var secMode  = "�J��"
			var dispName = 288
//			var dispName = 287
			break;

		case "�ԐځE�����ڍ�" :
			var dispCmd  = "�����ڍ�"
			var secMode  = "�Ԑ�"
			var dispName = "�{��"
			break;
		case "�ԐځE����ڍ�" :
			var dispCmd  = "����ڍ�"
			var secMode  = "�Ԑ�"
			var dispName = "�{�Џ��V�X�e����"
			break;
		case "�ԐځE�ۏڍ�" :
			var dispCmd  = "�ۏڍ�"
			var secMode  = "�Ԑ�"
			var dispName = 25
			break;
		default :
			break;
			}		

//	���ƊJ���{��(287)�͋Ɩ��x����(288)���\�����Ȃ��Ƃ����Ȃ�
	
	year = ( Request.QueryString("year").Count == 0 ? year : Request.QueryString("year").Item)

	dispCmd  = (Request.QueryString("dispCmd").Count  == 0 ? dispCmd  : Request.QueryString("dispCmd").Item )

	dispName = (Request.QueryString("dispName").Count == 0 ? dispName : Request.QueryString("dispName").Item )
	secMode  = (Request.QueryString("secMode").Count  == 0 ? secMode  : Request.QueryString("secMode").Item )

	specialMode  = (Request.QueryString("specialMode").Count  == 0 ? specialMode  : Request.QueryString("specialMode").Item )

var work1 = paraOut(year,secMode,dispCmd,dispName)

EMGLog.Write("������x.txt","[����]" , dispCmd, year, dispName, secMode, Request.QueryString())

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
	var yymm = yy * 100 + mm								// ������yymm

	var OKday = dayChk(d,adjustDayCnt)
	yymm = ( parseInt(dd) < parseInt(OKday) ? yymmAdd(yymm, -1) : yymmAdd(yymm, 0))		// �f�[�^�L�����̌v�Z(12���ȑO�͑O�X��)

	var b_yymm = ((year-1)*100) + 10
	var actualCnt = yymmDiff( b_yymm, yymm )
	if(actualCnt >= 12) actualCnt = 12

	if(Request.QueryString("yosoku").count == 0){
		yosokuCnt = 12 - actualCnt
		}
	else{
		yosokuCnt = parseInt(Request.QueryString("yosoku") )
		if(yosokuCnt == 0){
			//	���ׂČv��
			actualCnt = 0
			yosokuCnt = 0
			}
		else if( yosokuCnt < 0 ){
			// �c��S�ė\��
			yosokuCnt = 12 - actualCnt
			}
		}

	var listMode,haifuMode

	switch(dispCmd){
		case "EMG" :
			dispMode = "�S��"
			listMode = "�ڍ�"
			haifuMode = false
			break;
		case "�����ꗗ" :
			dispMode = "����"
			dispName = ""
			listMode = "�ꗗ"
			haifuMode = true
			break;
		case "����ꗗ" :
			dispMode = "����"
			dispName = ""
			listMode = "�ꗗ"
			haifuMode = ( secMode == "�Ԑ�" ? false : true )
			break;
		case "�ۈꗗ" :
			dispMode = "�O���[�v"
			dispName = dispName		// ����̖��O
			listMode = "�ꗗ"
			haifuMode = true		// �ۂɑ΂��Ă͌v�Z���Ȃ�
			break;
		case "�����ڍ�" :
			dispMode = "����"
			dispName = dispName		// ����̖��O
			listMode = "�ڍ�"
			haifuMode = true
			break;
		case "����ڍ�" :
			dispMode = "����"
			dispName = dispName		// ����̖��O
			listMode = "�ڍ�"
			haifuMode = true
			break;
		case "�ۏڍ�" :
			dispMode = "�O���[�v"
			dispName = dispName		// �ۂ̃R�[�h
			listMode = "�ڍ�"
			haifuMode = true		// �ۂɑ΂��Ă͌v�Z���Ȃ�
			break;
//	�z��
		case "�����z��" :
			dispMode = "����"
			dispName = dispName
			listMode = "�z��"
			haifuMode = true
			break;
		case "����z��" :
			dispMode = "����"
			dispName = dispName
			listMode = "�z��"
			haifuMode = true
			break;
		case "�Ԑڈꗗ" :
			dispMode = "�O���[�v"
			dispName = ""
			listMode = "�Ԑڈꗗ"
			secMode  = "�Ԑ�"
			haifuMode = false
			break;
		default :
			break;
		}
	

var work2 = paraOut(year,secMode,dispMode,listMode,dispName)

//EMGLog.Write("������x.txt","[work1]" , work1);
//EMGLog.Write("������x.txt","[work2]" , work2);
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
		�{�Д�z��(Tab,year,mCnt)
		}

	DB.Close()

	if( dispName != "�{��" && listMode != "�z��" && (listMode == "�ڍ�" || dispMode == "�O���[�v" || dispMode == "����" ) ){
		delete Tab["�{��"]
		}

	delete Tab["����"]

//pr(paraOut(listMode,dispMode,secMode,dispName))

//Response.End
//
//dispXML(""+listMode+"]["+dispMode+"]["+secMode+"]["+dispName,Tab)

//===========================================

	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false

	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)

	var main2 = xmlDoc.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='������x.xsl'") 
//	xmlDoc.appendChild(main2)

	var commnt = xmlDoc.createComment("�w����Ԃ̏����f�[�^")
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
	
	groupPlan(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)						// �v��E�\���f�[�^�擾

	uriageYosoku(DB,Tab,yymm,mCnt,dispMode,dispName,listMode,fixLevel)			// ����\���f�[�^�擾
	uriageActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// ������уf�[�^�擾

	accountActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// ��p���уf�[�^�擾
	accountCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// ��p�t��

	salesCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)						// ����t��

	if( dispMode != "�S��" ){
		groupCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)					// ����Œ��f�[�^�擾
		}
	memberPlan(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
	memberActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)


	�Ԑڕ���\�Z(Tab,mCnt)

	}



function makeXML(xmlDoc,year,dispCnt,actualCnt,yosokuCnt,Tab,dispMode,dispName,listMode,fixLevel)
	{
//================================================================

	var s_yymm = ((year-1)*100) + 10
	var e_yymm = yymmAdd(s_yymm,mCnt-1)

	var yyyy = parseInt(s_yymm / 100)
	var mm   = (s_yymm % 100)

		// ����̊m����̂��m�点
	if( actualCnt >= 0 && actualCnt < dispCnt){
		var x_yymm = yymmAdd(s_yymm,actualCnt)
		var x_yy = parseInt(x_yymm/100)
		var x_mm = x_yymm%100
		var xx_yymm = yymmAdd(x_yymm,1)
		var xx_yy = parseInt(xx_yymm/100)
		var xx_mm = xx_yymm%100
		var xx_dd = dayChk(new Date(xx_yy+"/"+xx_mm+"/1"),adjustDayCnt)
		var Buff = (x_yy + "�N" + x_mm + "���̎��ѕ\����" + xx_mm + "��" + xx_dd + "���ȍ~�ł�")
		}
	else if(actualCnt == dispCnt){
		Buff = "(���ׂĎ��уf�[�^�ł�)"
		}
	else{
		Buff = "���уf�[�^�͂���܂���"
		}

	var rootNode = xmlDoc.createElement("root")
	xmlDoc.appendChild(rootNode)

	var mainNode = xmlDoc.createElement("�S��")
	rootNode.appendChild(mainNode)

	var Node = xmlDoc.createElement("�N�x")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(year)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("�J�n�N")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(yyyy)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("�J�n��")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(mm)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("����")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(mCnt)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("���ѓ��t")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode( Buff )
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("�m�x")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(fixLevel)
	Node.appendChild(Text)

	var cDate = convertDateTime(new Date());

	var Node = xmlDoc.createElement("�쐬���t")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(cDate)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("�m���")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode(adjustDayCnt)
	Node.appendChild(Text)

	var Node = xmlDoc.createElement("�\��")
	mainNode.appendChild(Node)
	var Text = xmlDoc.createTextNode("�v��")
	Node.appendChild(Text)


/*
	=========== �����E����̏ꍇ ==============
	�{�Д�z���̂��ߑS����̔�p�͎擾���v�Z����
	gName �ɕ��喼�������Ă��鎞�A�\���͎w�肳�ꂽ����̂�
	gName �ɋ󔒂̎��͑S����̈ꗗ
	
	=========== EMG�̏ꍇ ==============
	��x�ɑS���̏W�v���s��(gName�͋�)

	=========== ����w��̏ꍇ ==============
	gName�̓O���[�v�R�[�h�A�w�肳�ꂽ����̂ݏW�v���s��

*/
	for( var sec in Tab ){									// sec = ������
		var xTab = Tab[sec]
		var mode = xTab["���"]

		var groupNode = xmlDoc.createElement("�O���[�v")
		groupNode.setAttribute("kind",mode)				// kind : ����
		mainNode.appendChild(groupNode)

		var Node = xmlDoc.createElement("���O")
		groupNode.appendChild(Node)
		var Title = ( sec == "�S��" ? "�d�l�f" : sec )
		var Text = xmlDoc.createTextNode(Title)
		Node.appendChild(Text)

		groupNode.setAttribute("name",sec)				// kind : ����
		mainNode.appendChild(groupNode)

		var Node = xmlDoc.createElement("����")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["������"]["����"])
		Node.appendChild(Text)

		var Node = xmlDoc.createElement("����")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["������"]["����"])
		Node.appendChild(Text)

		var Node = xmlDoc.createElement("��")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["������"]["��"])
		Node.appendChild(Text)

		var Node = xmlDoc.createElement("�����R�[�h")
		groupNode.appendChild(Node)
		var Text = xmlDoc.createTextNode(xTab["�����R�[�h"].join(","))
		Node.appendChild(Text)

		planXML(xmlDoc,groupNode,xTab,"����","�v��E�\���E����",dispCnt,actualCnt,yosokuCnt)

		if( listMode == "�ڍ�" ){
			planXML(xmlDoc,groupNode,xTab,"�v��","�v��",dispCnt,0,0)
			planXML(xmlDoc,groupNode,xTab,"�\��","�\��",dispCnt,0,dispCnt)
			planXML(xmlDoc,groupNode,xTab,"����","����",dispCnt,dispCnt,0)
			}
		else if( listMode == "�z��" || listMode == "�Ԑڈꗗ" ){
			planXML(xmlDoc,groupNode,xTab,"�v��","�v��",dispCnt,0,0)
			}
		else if( specialMode == "�����Ǘ�" ){
			planXML(xmlDoc,groupNode,xTab,"�v��","�v��",dispCnt,0,0)
			}
//		����\���f�[�^
		if( listMode != "�z��" ){
			yosokuXML(xmlDoc,groupNode,xTab,dispCnt)
			}
		}
	}



function planXML(xmlDoc,groupNode,Tab,mode,title,mCnt,actualCnt,yosokuCnt)
	{
	if( mCnt == 0 ) return
	
	var dataNode = xmlDoc.createElement("�f�[�^")
	dataNode.setAttribute("name",mode)				// mode : �v��E�\���E����
	groupNode.appendChild(dataNode)

	var titelNode = xmlDoc.createElement("�\��")
	var Text = xmlDoc.createTextNode(title)
	titelNode.appendChild(Text)
	dataNode.appendChild(titelNode)

	// ���сE�v��E�v��
	var modeTab = new Array(12)
	for( var m = 0; m < mCnt; m++ ){
		if( m < actualCnt ){
			modeTab[m] = "����"
			}
		else if ( m < (actualCnt + yosokuCnt) ){
			modeTab[m] = "�\��"
			}
		else{
			modeTab[m] = "�v��"
			}
		}

	var mNode = xmlDoc.createElement("�����")
	dataNode.appendChild(mNode)
	for( var m = 0; m < mCnt; m++ ){
		var Text = xmlDoc.createTextNode(modeTab[m])
		var Node = xmlDoc.createElement("��")
		mNode.appendChild(Node)
		Node.setAttribute("m",m)
		Node.appendChild(Text)
		}

	for( var itemName in Tab["�\��"]){										// itemName : �區��(���㌴���E�̊ǔ�)
		if( itemName == "����\��" ) continue;
		var haifuFlag = checkItem(Tab["���"],itemName)
		if( haifuFlag == 9 ) continue										// �o�͐���(����ɂ��قȂ�)
		var disp = ( haifuFlag == 0 ? 0 : 1 )
		var itemNode = xmlDoc.createElement(itemName)
		itemNode.setAttribute("disp",disp)
		dataNode.appendChild(itemNode)
		for( var item in Tab["�\��"][itemName]){							// item : ����(�d����E�l����)
			var subNode = xmlDoc.createElement("����")
			subNode.setAttribute("name",item)
			itemNode.appendChild(subNode)
			for( var m = 0; m < mCnt; m++ ){								// m : ��
				var Node = xmlDoc.createElement("��")
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
	
	var mode = "�\��"
	var dataNode = xmlDoc.createElement("�\���f�[�^")
	groupNode.appendChild(dataNode)

	var itemName = "����\��"
	var itemNode = xmlDoc.createElement(itemName)
	dataNode.appendChild(itemNode)

	for( var item in Tab["�\��"][itemName]){								// item : ����(�d����E�l����)
		var subNode = xmlDoc.createElement("����")
		subNode.setAttribute("name",item)
		itemNode.appendChild(subNode)
		for( var m = 0; m < dispCnt; m++ ){									// m : ��
			var Node = xmlDoc.createElement("��")
			Node.setAttribute("m",m)
			subNode.appendChild(Node)
			var Text = xmlDoc.createTextNode(Tab["�\��"][itemName][item][m])
			Node.appendChild(Text)
			}
		}
	}


// �o�͐���(����ɂ��قȂ�)
function checkItem(kind,item)
	{
//EMGLog.Write("x.txt","[" + kind + "][" + item + "]")
	// 0 �쐬���Ĕ�\��
	// 1 �쐬���ĕ\��
	// 9 �쐬���Ȃ�
	var Tab = {}
	Tab["�\�Z"] 	  = {"�z��":1,"�J��":9,"�c��":9,"�Ԑ�":1,"�S��":9,"���":9,"����":0}
	Tab["���㍂"]	  = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":1,"���":1,"����":1}
	Tab["���㌴��"]   = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":1,"���":1,"����":1}
	Tab["�̊ǔ�"]	  = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":1,"���":1,"����":1}
	Tab["�c�ƊO���v"] = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":1,"���":1,"����":1}
	Tab["�c�ƊO��p"] = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":1,"���":1,"����":1}
	Tab["�Œ莑�Y"]   = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":1,"���":0,"����":1}
	Tab["����Œ��"] = {"�z��":1,"�J��":1,"�c��":1,"�Ԑ�":0,"�S��":9,"���":0,"����":1}
	Tab["�{�Д�z��"] = {"�z��":1,"�J��":1,"�c��":1,"�Ԑ�":0,"�S��":9,"���":0,"����":0}
	Tab["����t��"]   = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":9,"���":0,"����":1}
	Tab["��p�t��"]   = {"�z��":9,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":9,"���":0,"����":1}
	Tab["�v����"]	  = {"�z��":1,"�J��":1,"�c��":1,"�Ԑ�":1,"�S��":1,"���":1,"����":1}
	if( !IsObject(Tab[item]) ) return(0)
	if( !IsObject(Tab[item][kind]) ) return(0)
	var ret = Tab[item][kind]
	return(ret)
	}



%>
<%
function initTab(DB,yymm,mCnt,dispMode,dispName,listMode,secMode)
	{
EMGLog.debug("������x.txt",dispMode,dispName,listMode,secMode)

	var Tab = {}
//	Tab["yymm"] = yymm
//	Tab["dispMode"] = dispMode
//	Tab["dispName"] = dispName
//	Tab["listMode"] = listMode
//	Tab["secMode"] = secMode

	if( dispMode == "�S��" ){
		Tab["�S��"] = makeTab(DB,mCnt,"�S��")
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

	if( secMode == "�J��" ){
		SQL = ""
		SQL += " SELECT"
		SQL += "   ����  = TM.����,"
		SQL += "   ����  = TM.����,"
		SQL += "   ����  = TM.����,"
		SQL += "   ��    = TM.�O���[�v,"
		SQL += "   gCode = TM.����ID"
	 
		SQL += " FROM"
		SQL += "    �����{���}�X�^ TM"
		SQL += " WHERE"
		SQL += "    NOT(TM.�J�n > '" + e_yymm + "' or TM.�I�� < '" + s_yymm + "')"
		SQL += " AND"
		SQL += "    TM.���� IN(0,1)"

		if(      listMode == "�ڍ�" && dispMode == "����" ){     SQL += " AND TM.����         = '" + dispName + "'" }
		else if( listMode == "�ڍ�" && dispMode == "����" ){     SQL += " AND TM.����+TM.���� = '" + dispName + "'" }
		else if( listMode == "�ڍ�" && dispMode == "�O���[�v" ){ SQL += " AND TM.����ID       = '" + dispName + "'" }
		else if( listMode == "�ꗗ" && dispMode == "�O���[�v" ){ SQL += " AND TM.����+TM.���� = '" + dispName + "'" }


		SQL += " ORDER BY"
		SQL += "    ����,"
		SQL += "    ����,"
		SQL += "    ����,"
		SQL += "    ��"
		}
	else{
		SQL = ""
		SQL += " SELECT"
		SQL += "   ����  = TM.����,"
		SQL += "   ����  = '',"
		SQL += "   ����  = '',"
		SQL += "   ��    = TM.������,"
		SQL += "   gCode = TM.�����R�[�h"
	 
		SQL += " FROM"
		SQL += "    EMG.dbo.�����}�X�^ TM"
		SQL += " WHERE"
		SQL += "    NOT(TM.�J�n > '" + e_Date + "' or TM.�I�� < '" + s_Date + "')"
		SQL += " AND"
		SQL += "    TM.ACC�R�[�h >= 0"
		SQL += " AND"
		SQL += "    TM.���� IN(2)"
		if( listMode == "�ڍ�" && dispMode == "�O���[�v" ){ SQL += " AND TM.�����R�[�h = '" + dispName + "'" }


		SQL += " ORDER BY"
		SQL += "    TM.ACC�R�[�h,"
		SQL += "    ����,"
		SQL += "    ����,"
		SQL += "    ����,"
		SQL += "    ��"
		}
	RS = DB.Execute(SQL)

	var gCode,����,����,��,S_name
	while(!RS.EOF){
		����  = RS.Fields("����").Value
		����  = RS.Fields("����").Value
		����  = RS.Fields("����").Value
		��    = RS.Fields("��").Value
		gCode = RS.Fields("gCode").Value
		
//		if( ���� == "-" ) ���� = ""

		if( dispMode == "�S��" ){          S_name = '�S��'}
		else if( dispMode == "�{��" ){     S_name = '�{��'}
		else if( dispMode == "����" ){     S_name = ���� }
		else if( dispMode == "����" ){     S_name = ����+���� }
		else if( dispMode == "�O���[�v" ){ S_name = ����+����+�� }


		if( !IsObject(Tab[S_name]) ){
			Tab[S_name] = makeTab(DB,mCnt,S_name)

//			Tab[S_name] = {}

			Tab[S_name]["����"] = ����
			Tab[S_name]["������"] = {}
			Tab[S_name]["������"]["����"] = ����
			Tab[S_name]["������"]["����"] = ����
			Tab[S_name]["������"]["��"]   = ��
			Tab[S_name]["�����R�[�h"] = []
			}
		Tab[S_name]["�����R�[�h"].push(gCode)
		RS.MoveNext()
		}
	RS.Close()
*/

	var Tab = {}
	var dispTab = {����:"����",����:"��",�O���[�v:"��"}
	var secTab 	= {�J��:"0,1",�Ԑ�:"2",�S��:"0,1,2"}
	var secName = ( IsObject(dispTab[dispMode]) ? dispTab[dispMode] : "" )
	var secStr = ( IsObject(secTab[secMode]) ? secTab[secMode] : "" )

	var xTab = getGroupInfo(yymm,secStr,secName)
	var S_name,gCode,����,����,����,��,chk_name
	for( var i = 0; i < xTab.length; i++ ){	
		����   = xTab[i].����
		����   = xTab[i].����
		����   = xTab[i].��
		��     = xTab[i].��
		gCode  = xTab[i].gCode

		if(      listMode == "�ڍ�" && dispMode == "����" ){     chk_name = ����		}
		else if( listMode == "�ڍ�" && dispMode == "����" ){     chk_name = ����+����	}
		else if( listMode == "�ڍ�" && dispMode == "�O���[�v" ){ chk_name = gCode		}
		else if( listMode == "�ꗗ" && dispMode == "�O���[�v" ){ chk_name = ����+����	}

		if( dispName != "" && chk_name != dispName ) continue;
		S_name = ���� + ���� + ��
		if( !IsObject(Tab[S_name]) ){
			if( mCnt == 0 ){
				Tab[S_name] = {������:{}}
				}
			else{
				Tab[S_name] = makeTab(DB,mCnt,S_name)
				}
			}
		Tab[S_name]["����"] = ����
		Tab[S_name]["������"]["����"] = ����
		Tab[S_name]["������"]["����"] = ����
		Tab[S_name]["������"]["��"]   = ��
		Tab[S_name]["�����R�[�h"] = xTab[i].codes.split(",")
		}
	
	for( var S_name in Tab ){
//		if( Tab[S_name]["�����R�[�h"].length == 1 ){
			Tab[S_name]["���"] = ( Tab[S_name]["����"] == 2 ? "�Ԑ�" : "�J��" )
//			}
		}
		

	Tab["�{��"] = makeTab(DB,mCnt,"�{��")
	Tab["����"] = makeTab(DB,mCnt,"����")

	return(Tab)
	}

function makeTab(DB,mCnt,S_name)
	{

	var kindName,����
	if( S_name == "�S��" ){
		kindName = "�S��"
		���� = "0,1,2"
		}
	else if( S_name == "�{��" ){
		kindName = "�Ԑ�"
		���� = "2"
		}
	else if( S_name == "����" ){
		kindName = "����"
		���� = "0,1"
		}
	else{
		// S_name : ���喼
		kindName = "�J��"
		���� = ""
		}

	var work = []
	var RS = Server.CreateObject("ADODB.Recordset")
	var SQL
	SQL  = " SELECT"
	SQL += "    item = ����"
	SQL += " FROM"
	SQL += "    ���x���ڃ}�X�^"
	SQL += " WHERE"
	SQL += "    �區�� = '����Œ��'"
	SQL += " ORDER BY"
	SQL += "    item"
	RS = DB.Execute(SQL)
	while( !RS.EOF ){
		work.push(RS.Fields("item").Value)
		RS.MoveNext()
		}
	RS.Close()

	var str����Œ�� = work.join(",")

	var itemTab = new Object
	itemTab["�\�Z"]           = "�\�Z".split(",")
	itemTab["���㍂"]         = "����".split(",")
	itemTab["���㌴��"]       = "�O����,�d����,�O����EEMG�Ԕ�p,�d����EEMG�Ԕ�p,����I��,�����I��".split(",")
	itemTab["�̊ǔ�"]         = "�l����,�G��,�L������,��ʔ�,�ʐM��,������,���i,�ݔ���,�ƒ�,���̑�,EMG�Ԕ�p".split(",")	
	itemTab["�Œ莑�Y"]       = "�@��E�\�t�g".split(",")
	itemTab["�c�ƊO���v"]     = "�G������,EMG�Ԕ�p".split(",")
	itemTab["�c�ƊO��p"]     = "�G�x�o��,EMG�Ԕ�p".split(",")

	itemTab["����Œ��"]     =  str����Œ��.split(",")
	itemTab["�{�Д�z��"]     = "�{�Д�".split(",")

	itemTab["����t��"]       = "����,�x�o".split(",")
	itemTab["��p�t��"]       = "����,�x�o".split(",")
	itemTab["�v����"]         = "�Ј�,�p�[�g,����,�_��,�h��,�x�E".split(",")
	itemTab["����\��"]       = "�m�x70,�m�x50,�m�x30,�m�x10".split(",")


	var Tab = {���:kindName,������:{},����:����,�����R�[�h:[],�v��:{},�\��:{},����:{}}
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
	Tab["�z��"] = makeHaihuTab(mCnt)

	return(Tab)
	}

function makeHaihuTab(mCnt)
	{
	var itemTab = ["�{�З\�Z","����","�Œ��v","�z���Ώ�","�̊ǐl����","�Œ�l����","�̊ǎG��","�����O����","�v�Z�z","���z��"]
	var Tab = {�v��:{},�\��:{},����:{}}
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
function �{�Д�z��(xTab,year,mCnt)
	{
	if( mCnt == 0 ) return
	
	for( var S_name in xTab ){
		if( S_name == "�{��" ) calcTargetPlan(xTab[S_name],mCnt)
		}
	calcHaihu(xTab,year,mCnt)
	}

function �Ԑڕ���\�Z(xTab,mCnt)
	{
	for( var S_name in xTab ){
		if( S_name != "�{��" && Tab[S_name]["���"] == "�Ԑ�" )	calcTargetPlan(xTab[S_name],mCnt)
		}
	}


//	�{�Д�̖ڕW�l�̌v�Z�i�{�Ђ̔�p�����v����j
function calcTargetPlan(Tab,mCnt)
	{
//	if( !IsObject(xTab["�{��"]) ) return
//	var Tab = xTab["�{��"]
	for(var m = 0; m < mCnt; m++ ){
		// �x�o�̕�
		var itemStr = "���㌴��,�̊ǔ�,�c�ƊO��p".split(",")
		for(var iNum in itemStr){
			var item = itemStr[iNum]
			for( var kind in Tab["�v��"][item]){
				Tab["�v��"]["�\�Z"]["�\�Z"][m] += Tab["�v��"][item][kind][m]
				Tab["�\��"]["�\�Z"]["�\�Z"][m] += Tab["�v��"][item][kind][m]
				Tab["����"]["�\�Z"]["�\�Z"][m] += Tab["�v��"][item][kind][m]
				}
			}
		// �����̕�
		var itemStr = "�c�ƊO���v,��p�t��,����t��".split(",")
		for(var iNum in itemStr){
			var item = itemStr[iNum]
			for( var kind in Tab["�v��"][item]){
				Tab["�v��"]["�\�Z"]["�\�Z"][m] -= Tab["�v��"][item][kind][m]
				Tab["�\��"]["�\�Z"]["�\�Z"][m] -= Tab["�v��"][item][kind][m]
				Tab["����"]["�\�Z"]["�\�Z"][m] -= Tab["�v��"][item][kind][m]
				}
			}
		}
//	�{�Ќv��l����{�Д��������
//	�\�����甄������������l�ɂ��邽��
	for(var m = 0; m < mCnt; m++ ){
		Tab["�v��"]["�\�Z"]["�\�Z"][m] -= Tab["�v��"]["���㍂"]["����"][m]
		Tab["�\��"]["�\�Z"]["�\�Z"][m] -= Tab["�v��"]["���㍂"]["����"][m]
		Tab["����"]["�\�Z"]["�\�Z"][m] -= Tab["�v��"]["���㍂"]["����"][m]
		}
	}

function calcHaihu(xTab,year,mCnt)
	{
EMGLog.debug("������x.txt","calcHaihu",year,mCnt)
/*

[�{�Ђ̑S�v��] - [�{�Ђ̔���v��] - [����̌Œ��v] = [�z�z�Ώۊz]


�l����E�G���E�����O����E�Œ��̐l����

[�S����̍��v�𕪕�Ƃ���]



����Œ��E�l����
�̊ǔ�E�l����
�̊ǔ�E�G��
���㌴���E"�O����

*/



//	�p�[�g�̔z����2008�N�x�܂�1/4  (0.25)
//				  2009�N�x����1/100(0.01)

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

	var modeTab = ["�v��","�\��","����"]
	for( var i = 0; i < modeTab.length; i++ ){			// ���сE�\���E�v��
		var mode = modeTab[i]
		for( var m = 0; m < mCnt; m++ ){
			// �z���Ώۊz�̍쐬
			xTab["�{��"]["�z��"][mode]["�{�З\�Z"][m]   += xTab["�{��"]["�v��"]["�\�Z"]["�\�Z"][m]
			xTab["�{��"]["�z��"][mode]["����"][m]       += xTab["�{��"]["�v��"]["���㍂"]["����"][m]

			// ����̌Œ��v
			for( var item in xTab["����"][mode]["����Œ��"] ){
				xTab["�{��"]["�z��"][mode]["�Œ��v"][m] += xTab["����"][mode]["����Œ��"][item][m]
				}
			// �z���Ώۊz�̎Z�o
//	�����̖{�З\�Z�͔�������������l
//	�����Ŕ���������Ȃ��̂�������
			xTab["�{��"]["�z��"][mode]["�z���Ώ�"][m] += xTab["�{��"]["�z��"][mode]["�{�З\�Z"][m]
//			xTab["�{��"]["�z��"][mode]["�z���Ώ�"][m] -= xTab["�{��"]["�z��"][mode]["����"][m]
			xTab["�{��"]["�z��"][mode]["�z���Ώ�"][m] -= xTab["�{��"]["�z��"][mode]["�Œ��v"][m]
			

			// ����̌v�Z�̕���쐬
			xTab["�{��"]["�z��"][mode]["�̊ǐl����"][m] += xTab["����"][mode]["�̊ǔ�"]["�l����"][m]
			xTab["�{��"]["�z��"][mode]["�̊ǎG��"][m]   += xTab["����"][mode]["�̊ǔ�"]["�G��"][m]
			xTab["�{��"]["�z��"][mode]["�����O����"][m] += xTab["����"][mode]["���㌴��"]["�O����"][m]
			xTab["�{��"]["�z��"][mode]["�Œ�l����"][m] += xTab["����"][mode]["����Œ��"]["�l����"][m]

			// ����̌v�Z
			for( var secName in xTab ){
				if( secName == "�{��" || secName == "����" ) continue;
				xTab[secName]["�z��"][mode]["�̊ǐl����"][m] += xTab[secName][mode]["�̊ǔ�"]["�l����"][m]
				xTab[secName]["�z��"][mode]["�Œ�l����"][m] += xTab[secName][mode]["����Œ��"]["�l����"][m]
				xTab[secName]["�z��"][mode]["�����O����"][m] += xTab[secName][mode]["���㌴��"]["�O����"][m]
				xTab[secName]["�z��"][mode]["�̊ǎG��"][m]   += xTab[secName][mode]["�̊ǔ�"]["�G��"][m]
				}

			for( var secName in xTab ){
				if( secName == "����" ) continue;
				xTab[secName]["�z��"][mode]["�v�Z�z"][m] += xTab[secName]["�z��"][mode]["�̊ǐl����"][m]
				if( year >= 2013 ){
					xTab[secName]["�z��"][mode]["�v�Z�z"][m] += xTab[secName]["�z��"][mode]["�Œ�l����"][m]
					}
				xTab[secName]["�z��"][mode]["�v�Z�z"][m] += (xTab[secName]["�z��"][mode]["�̊ǎG��"][m]*partUnit)
				xTab[secName]["�z��"][mode]["�v�Z�z"][m] += (xTab[secName]["�z��"][mode]["�����O����"][m]*guestUnit)
				}
			// ���z�̌v�Z
			for( var secName in xTab ){
				if( secName == "�{��" || secName == "����" ) continue;
				xTab[secName]["�z��"][mode]["���z��"][m] = xTab[secName]["�z��"][mode]["�v�Z�z"][m] / xTab["�{��"]["�z��"][mode]["�v�Z�z"][m]
				}
			// ���z�̌v�Z

			for( var secName in xTab ){
				if( secName == "�{��" || secName == "����" ) continue;
				var value = xTab["�{��"]["�z��"][mode]["�z���Ώ�"][m] * xTab[secName]["�z��"][mode]["���z��"][m]
				xTab[secName][mode]["�{�Д�z��"]["�{�Д�"][m] = ( isNaN(value) ? 0 : value )
				}


			}
		}
	}

%>
<%
// ����E���уf�[�^�擾
function uriageActual(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
   {
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;

	var RS = Server.CreateObject("ADODB.Recordset")

//	���уf�[�^
	var SQL = ""
	var SQLTab = []

	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      ����   = MAST.����,"
		SQL += "	  yymm   = DATA.yymm,"
		SQL += "	  amount = sum(DATA.���z)"
		SQL += " FROM"
		SQL += "	  �c�Ɣ���f�[�^ DATA "
		SQL += "                     LEFT JOIN �Ɩ������f�[�^ BUSYO"
		SQL += "                          ON DATA.pNum    = BUSYO.pNum"
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate + "') )  MAST"
		SQL += "                          ON MAST.�����R�[�h = BUSYO.����ID"
		SQL += " WHERE"
		SQL += "      (DATA.yymm BETWEEN " + s_yymm + " and " + e_yymm + ")"
		SQL += "      AND"
		SQL += "	  (DATA.yymm Between BUSYO.�J�n And BUSYO.�I��)"
		SQL += "	  AND"
		SQL += "	  DATA.�t�� = 0"
		SQL += "	  AND"
		SQL += "	  DATA.Flag = 0"
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    BUSYO.����ID IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.����,"
		SQL += "	  DATA.yymm"
		SQLTab.push(SQL)
		}
	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)

	var n,pNum,amount,Grp,c_yymm,mode
	while(!RS.EOF){
		S_name  = RS.Fields('S_name').Value
		����    = RS.Fields('����').Value
		c_yymm  = RS.Fields('yymm').Value
		amount  = RS.Fields('amount').Value

		if( S_name == null ){
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
			}
		else{
			secName = S_name
			}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff( yymm, c_yymm )
		Tab[secName]["����"]["���㍂"]["����"][n] += amount
		RS.MoveNext()
		}
	RS.Close()
	}

//	�O���[�v���̔�p����
function accountActual(DB,Tab,yymm,mCnt,dispMode,dispName)
	{
	var stat = "����"
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
   
   
// ��p
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      ����    = MAST.����,"
		SQL += "      �區��  = ITEM.�區��,"
		SQL += "      ����    = ITEM.����,"
		SQL += "      KmkCode = DATA.�Ȗ�,"
		SQL += "      yymm    = DATA.yymm,"
		SQL += "      EMG     = DATA.Flag,"
		SQL += "      amount  = Sum(DATA.���z)"
		SQL += " FROM"
		SQL += "    ��v���f�[�^ DATA "
		SQL += "                 LEFT JOIN ��v���ڃ}�X�^ ITEM"
		SQL += "                      ON DATA.�Ȗ� = ITEM.KmkCode AND DATA.Flag = ITEM.Flag"
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate + "') ) MAST"
		SQL += "                      ON DATA.���� = MAST.ACC�R�[�h"
		SQL += " WHERE"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		SQL += "    AND"
		SQL += "    MAST.ACC�R�[�h >= 0"
		SQL += "    AND"
		SQL += "    NOT (DATA.�Ȗ� BETWEEN 211 AND 260)"				// �區�� = �Œ莑�Y
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "    MAST.����,"
		SQL += "    ITEM.�區��,"
		SQL += "    ITEM.����,"
		SQL += "    DATA.�Ȗ�,"
		SQL += "    DATA.yymm,"
		SQL += "    DATA.Flag"
		SQLTab.push(SQL)

		var iName = "�Œ莑�Y"
		var kName = "�@��E�\�t�g"
		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      ����    = MAST.����,"

		SQL += "      �區��  = '" + iName + "',"
		SQL += "      ����    = '" + kName + "',"
		SQL += "      KmkCode = DATA.�Ȗ�,"
		SQL += "      yymm    = DATA.yymm,"
		SQL += "      EMG     = DATA.Flag,"
		SQL += "      amount  = Sum(DATA.���z)"
		SQL += " FROM"
		SQL += "    ��v���f�[�^ DATA "
		SQL += "                 LEFT JOIN ��v���ڃ}�X�^ ITEM"
		SQL += "                      ON DATA.�Ȗ� = ITEM.KmkCode AND DATA.Flag = ITEM.Flag"
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate + "') ) MAST"
		SQL += "                      ON DATA.���� = MAST.ACC�R�[�h"
		SQL += " WHERE"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		SQL += "    AND"
		SQL += "    MAST.ACC�R�[�h >= 0"
		SQL += "    AND"
		SQL += "    DATA.�Ȗ� BETWEEN 211 AND 260"				// �區�� = �Œ莑�Y
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		SQL += " GROUP BY"
		SQL += "    MAST.����,"
		SQL += "    ITEM.�區��,"
		SQL += "    ITEM.����,"
		SQL += "    DATA.�Ȗ�,"
		SQL += "    DATA.yymm,"
		SQL += "    DATA.Flag"
		SQLTab.push(SQL)

		}

	SQL = SQLTab.join(" UNION ALL ")

	RS = DB.Execute(SQL)
	var Grp,kind,item,yymm,amount,Cnt,mode,area
	while(!RS.EOF){
		����    = RS.Fields('����').Value
		S_name  = RS.Fields('S_name').Value
		item    = RS.Fields("�區��").Value
		kind    = RS.Fields("����").Value
		yymm    = RS.Fields("yymm").Value
		amount  = RS.Fields("amount").Value
		flag    = RS.Fields("EMG").Value
		KmkCode = RS.Fields("KmkCode").Value

		if( S_name == null ){
			errorMsg("accountActual1")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
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
			EMGLog.Write("naka.txt", "[��v�f�[�^�W�v�ł̕s���Ȗڃf�[�^]" + work)
			}
		RS.MoveNext()
		}
	RS.Close()

	}


// ��p�t�ցE���уf�[�^�擾
function accountCost(DB,Tab,yymm,mCnt,dispMode,dispName,listMode)
   {
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;

	var RS = Server.CreateObject("ADODB.Recordset")

//	******��p�t��******
// �x�����������w�肵�Ă���
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      ����    = MAST.����,"
		SQL += "      payMode = '�x��',"

		SQL += "      ����    = COST.�x������,"
		SQL += "      yymm    = COST.yymm,"
		SQL += "      ���z    = COST.�t�֋��z"
		SQL += " FROM"
		SQL += "      �t�փf�[�^ COST "
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                      ON COST.�x������ = MAST.�����R�[�h"

		SQL += " WHERE"
		SQL += "      COST.mode = 1"
		SQL += "      AND"
		SQL += "      COST.yymm BETWEEN " + s_yymm + " and " + e_yymm
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}

		SQLTab.push(SQL)


		SQL  = " SELECT"
		SQL += "      S_name  = '" + S_name + "',"
		SQL += "      ����    = MAST.����,"
		SQL += "      payMode = '���',"

		SQL += "      ����     = COST.��敔��,"
		SQL += "      yymm     = COST.yymm,"
		SQL += "      ���z     = COST.�t�֋��z"
		SQL += " FROM"
		SQL += "      �t�փf�[�^ COST "
		SQL += "                 LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                      ON COST.��敔�� = MAST.�����R�[�h"

		SQL += " WHERE"
		SQL += "      COST.mode = 1"
		SQL += "      AND"
		SQL += "      COST.yymm BETWEEN " + s_yymm + " and " + e_yymm
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}

		SQLTab.push(SQL)

		}
	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var n,pNum,amount,cost,c_yymm,mode1,mode2,src_Grp,dst_Grp
	while(!RS.EOF){
		payMode = RS.Fields('payMode').Value
		����    = RS.Fields('����').Value
		S_name  = RS.Fields('S_name').Value
		c_yymm  = RS.Fields('yymm').Value
		cost    = RS.Fields('���z').Value

		if( S_name == null ){
			errorMsg("accountCost")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
			}
		else{
			secName = S_name
		}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff( yymm, c_yymm )
		if( payMode == "�x��" ) Tab[secName]["����"]["��p�t��"]["�x�o"][n] -= cost
		if( payMode == "���" ) Tab[secName]["����"]["��p�t��"]["����"][n] += cost
		RS.MoveNext()
		}
	RS.Close()
	}



// ����t�ցE���уf�[�^�擾
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

//	*****����t��(�x��)*****
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      ����   = MAST.����,"

		SQL += "      pNum   = DATA.pNum,"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      �t��   = DATA.�t��,"
		SQL += "      ���z   = sum(DATA.���z)"
		SQL += " FROM"
		SQL += "      �c�Ɣ���f�[�^ DATA"
		SQL += "                     LEFT JOIN �Ɩ������f�[�^ BUSYO"
		SQL += "                          ON DATA.pNum    = BUSYO.pNum"
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                          ON BUSYO.����ID = MAST.�����R�[�h"
		SQL += " WHERE"
		SQL += "       DATA.�t�� IN(1,2)"
		SQL += "       AND"
		SQL += "       DATA.yymm Between BUSYO.�J�n And BUSYO.�I��"
		SQL += "       AND"
		SQL += "       DATA.yymm BETWEEN " + s_yymm + " and " + e_yymm
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.����,"
		SQL += "      DATA.pNum,"
		SQL += "      DATA.yymm,"
		SQL += "      DATA.�t��"

		SQLTab.push(SQL)
		}

	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var n,pNum,amount,cost,c_yymm,mode,mode2,Grp,dst_Grp,kind
	var secName
	while(!RS.EOF){
		����    = RS.Fields('����').Value
		S_name  = RS.Fields('S_name').Value
		c_yymm  = RS.Fields('yymm').Value
		kind    = RS.Fields('�t��').Value
		cost    = RS.Fields('���z').Value
		if( S_name == null ){
			errorMsg("salesCost")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
			}
		else{
			secName = S_name
			}
		if( !IsObject(Tab[secName]) ){
//			Tab[secName] = makeTab(DB,mCnt,secName)
			}
		n = yymmDiff( yymm, c_yymm )
		if( kind == 1 ) Tab[secName]["����"]["����t��"]["�x�o"][n] += cost
		if( kind == 2 ) Tab[secName]["����"]["����t��"]["����"][n] += cost

		RS.MoveNext()
		}
	RS.Close()
	}


//	�O���[�v���̕���Œ��f�[�^
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
		SQL += "      ����   = MAST.����,"

		SQL += "      �區�� = ITEM.�區��,"
		SQL += "      ����   = ITEM.����,"
		SQL += "      ���   = (CASE WHEN DATA.��� = 0 THEN '�v��' ELSE '�\��' END),"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      amount = Sum(DATA.���l)"
		SQL += " FROM"
		SQL += "      ���x�v��f�[�^ DATA "
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                          ON DATA.����ID = MAST.�����R�[�h"
		SQL += "                     LEFT JOIN ���x���ڃ}�X�^ ITEM"
		SQL += "                          ON DATA.����ID = ITEM.ID"
		SQL += " WHERE"
		SQL += "      ITEM.�區�� = '����Œ��'"
		SQL += "      AND"
		SQL += "      DATA.��� IN(0,1)"				// �v��E�\��
		SQL += "      AND"
		SQL += "      MAST.ACC�R�[�h >= 0"
		SQL += "      AND"
		SQL += "      DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.����,"
		SQL += "      ITEM.�區��,"
		SQL += "      ITEM.����,"
		SQL += "      DATA.���,"
		SQL += "      DATA.yymm"
		SQLTab.push(SQL)

//	���уf�[�^
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      ����   = MAST.����,"

		SQL += "      �區�� = ITEM.�區��,"
		SQL += "      ����   = ITEM.����,"
		SQL += "      ���   = '����',"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      amount = Sum(DATA.��p)"
		SQL += " FROM"
		SQL += "      ����Œ����уf�[�^ DATA "
		SQL += "                           LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                                ON DATA.����ID = MAST.�����R�[�h"
		SQL += "                           LEFT JOIN ���x���ڃ}�X�^ ITEM"
		SQL += "                                ON DATA.����ID = ITEM.ID"

		SQL += " WHERE"
		SQL += "      ITEM.�區�� = '����Œ��'"
		SQL += "      AND"
		SQL += "      MAST.ACC�R�[�h >= 0"
		SQL += "      AND"
		SQL += "      DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "    MAST.����,"
		SQL += "    ITEM.�區��,"
		SQL += "    ITEM.����,"
		SQL += "    DATA.yymm"
		SQLTab.push(SQL)

		}
	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	while(!RS.EOF){
		����     = RS.Fields("����").Value
		S_name   = RS.Fields("S_name").Value
		item     = RS.Fields("�區��").Value
		kind     = RS.Fields("����").Value
		statName = RS.Fields("���").Value
		yymm     = RS.Fields("yymm").Value
		amount   = RS.Fields("amount").Value

		if( S_name == null ){
			errorMsg("groupCost1")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
			}
		else{
			secName = S_name
			}

		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff(s_yymm, yymm)
		Tab[secName][statName][item][kind][n] += amount * ( statName == "����" ? 1 : 1000 )
		RS.MoveNext()
		}
	RS.Close()

	}

// ����\���f�[�^�擾
function uriageYosoku(DB,Tab,yymm,mCnt,dispMode,dispName,listMode,fixLevel)
	{
	var sDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
	var eDate = DateAdd("m",mCnt,sDate)
	eDate = convertDate(DateAdd("d",-1,eDate) )

	var s_yymm = yymm;
	var e_yymm = yymmAdd(yymm,mCnt - 1);
	var cur_yymm;


	var RS = Server.CreateObject("ADODB.Recordset")


//	�\���f�[�^
	var SQL = ""
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      ����   = MAST.����,"

		SQL += "	  level  = PNUM.fix_level,"
		SQL += "	  yymm   = DATA.yymm,"
		SQL += "	  amount = sum(DATA.sales) * 1000"
		SQL += " FROM"
		SQL += "	  �c�Ɨ\���f�[�^ DATA "
		SQL += "                     LEFT JOIN �Ɩ������f�[�^ BUSYO"
		SQL += "                          ON DATA.pNum       = BUSYO.pNum"
		SQL += "	                 LEFT JOIN projectNum     PNUM"
		SQL += "                          ON DATA.pNum       = PNUM.pNum"
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate + "') )  MAST"
		SQL += "                          ON MAST.�����R�[�h = BUSYO.����ID"

		SQL += " WHERE"
		SQL += "	  PNUM.stat IN(0,1,4,5)"
		SQL += "      and"
		SQL += "      PNUM.fix_level >= 10"
		SQL += "	  AND"
		SQL += "	  (DATA.yymm Between BUSYO.�J�n And BUSYO.�I��)"
		SQL += "	  AND"
		SQL += "      (DATA.yymm BETWEEN " + s_yymm + " and " + e_yymm + ")"

		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    BUSYO.����ID IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.����,"
		SQL += "      PNUM.fix_level,"
		SQL += "      DATA.yymm"

		SQLTab.push(SQL)
		}

	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)
	var n,pNum,amount,Grp,c_yymm,mode
	var secName
	while(!RS.EOF){
		����    = RS.Fields('����').Value
		S_name  = RS.Fields('S_name').Value
		level   = parseInt(RS.Fields('level').Value)
		c_yymm  = RS.Fields('yymm').Value
		amount  = RS.Fields('amount').Value

		if( S_name == null ){
			errorMsg("uriageYosoku")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
			}
		else{
			secName = S_name
			}
		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		n = yymmDiff( yymm, c_yymm )
		if( level >= 70 ) Tab[secName]["�\��"]["����\��"]["�m�x70"][n] += amount
		if( level >= 50 ) Tab[secName]["�\��"]["����\��"]["�m�x50"][n] += amount
		if( level >= 30 ) Tab[secName]["�\��"]["����\��"]["�m�x30"][n] += amount
		if( level >= 10 ) Tab[secName]["�\��"]["����\��"]["�m�x10"][n] += amount
		RS.MoveNext()
		}
	RS.Close()

	for( var secName in Tab ){
		for( var m = 0; m < mCnt; m++ ){
			Tab[secName]["�\��"]["���㍂"]["����"][m] = Tab[secName]["�\��"]["����\��"]["�m�x" + fixLevel][m]
			}
		}
	}

//	�O���[�v���̌v��f�[�^
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
		SQL += "      ����   = MAST.����,"

		SQL += "      �區�� = ITEM.�區��,"
		SQL += "      ����   = ITEM.����,"
		SQL += "      ���   = (CASE WHEN DATA.��� = 0 THEN '�v��' ELSE '�\��' END),"
		SQL += "      yymm   = DATA.yymm,"
		SQL += "      amount = Sum(DATA.���l)"
		SQL += " FROM"
		SQL += "      ���x�v��f�[�^ DATA "
		SQL += "                     LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                          ON DATA.����ID = MAST.�����R�[�h"
		SQL += "                     LEFT JOIN ���x���ڃ}�X�^ ITEM"
		SQL += "                          ON DATA.����ID = ITEM.ID"
		SQL += " WHERE"
		SQL += "      ITEM.�區�� NOT IN('����Œ��','�v����')"
		SQL += "      AND"
		SQL += "      DATA.��� IN(0,1)"				// �v��E�\��
		SQL += "      AND"
		SQL += "      MAST.ACC�R�[�h >= 0"
		SQL += "      AND"
		SQL += "      DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}
		SQL += " GROUP BY"
		SQL += "      MAST.����,"
		SQL += "      ITEM.�區��,"
		SQL += "      ITEM.����,"
		SQL += "      DATA.���,"
		SQL += "      DATA.yymm"
		SQLTab.push(SQL)
		}
	SQL = SQLTab.join(" UNION ALL ")

	RS = DB.Execute(SQL)
	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	var secName

	while(!RS.EOF){
		S_name   = RS.Fields("S_name").Value
		����	 = RS.Fields("����").Value
		item	 = RS.Fields("�區��").Value
		kind	 = RS.Fields("����").Value
		statName =  RS.Fields("���").Value
		yymm	 = RS.Fields("yymm").Value
		amount   = RS.Fields("amount").Value


		if( S_name == null ){
			errorMsg("groupPlan")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
			}
		else{
			secName = S_name
			}
		if( !IsObject(Tab[secName]) ) Tab[secName] = makeTab(DB,mCnt,secName)

		if( item == "����t��" && kind =="�x�o" ) amount = -amount
		if( item == "��p�t��" && kind =="�x�o" ) amount = -amount
		if( item == "���㌴��" && kind =="�����I��" ) amount = -amount

//		
		if( !IsObject(Tab[secName][statName][item][kind]) ){
			Tab[secName][statName][item][kind] = new Array(mCnt)
			for( var m = 0; m < mCnt; m++ ) Tab[secName][statName][item][kind][m] = 0
			}
		// ����\���͕ʂ̂Ƃ���ŏW�v
		if( !(statName == "�\��" && kind == "����") ){
			n = yymmDiff(s_yymm, yymm)
			if( item == "�v����" ){
				Tab[secName][statName][item][kind][n] += amount
				}
			else if( item == "���㌴��" && statName == "�\��" && (kind =="�����I��" || kind =="����I��") ){
//				if( kind =="�����I��" ) amount = -amount
				Tab[secName]["�\��"][item][kind][n] += amount * 1000
				Tab[secName]["����"][item][kind][n] += amount * 1000
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
//	�O���[�v���̗v���v��E�\��
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
		SQL += "      ����   = MAST.����,"

		SQL += "    �區�� = ITEM.�區��,"
		SQL += "    ����   = ITEM.����,"
		SQL += "    ���   = DATA.���,"
		SQL += "    yymm   = DATA.yymm,"
		SQL += "    value  = Sum(DATA.���l)"
		SQL += " FROM"
		SQL += "    ���x�v��f�[�^ DATA"
		SQL += "                   LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                        ON DATA.����ID     = MAST.�����R�[�h"
		SQL += "                   LEFT JOIN (SELECT * FROM �����{���}�X�^     WHERE NOT(�J�n > '" + e_yymm + "' or �I�� < '" + s_yymm + "') ) TM"
		SQL += "                        ON MAST.�����R�[�h = TM.����ID"
		SQL += "                   LEFT JOIN ���x���ڃ}�X�^     ITEM ON DATA.����ID = ITEM.ID"


		SQL += " WHERE"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		SQL += "    AND"
		SQL += "    DATA.��� IN(0,1)"				// �v��E�\��
		SQL += "    AND"
		SQL += "    ITEM.�區�� = '�v����'"
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}

		SQL += " GROUP BY"
		SQL += "    MAST.����,"
		SQL += "    ITEM.�區��,"
		SQL += "    ITEM.����,"
		SQL += "    DATA.���,"
		SQL += "    DATA.yymm"
		SQLTab.push(SQL)
//EMGLog.Write("x.txt",SQL)

		}

	SQL = SQLTab.join(" UNION ALL ")
	RS = DB.Execute(SQL)

	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	while(!RS.EOF){
		����    = RS.Fields('����').Value
		S_name  = RS.Fields('S_name').Value
		item    = RS.Fields("�區��").Value
		kind    = RS.Fields("����").Value
		stat    = RS.Fields("���").Value
		yymm    = RS.Fields("yymm").Value
		value   = RS.Fields("value").Value
		statName = (stat == 0 ? "�v��" : "�\��")

		if( S_name == null ){
			errorMsg("accountActual2")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
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

//	�O���[�v���̎��їv����
function memberActual(DB,xTab,yymm,mCnt,dispMode,dispName)
	{
//	�敪 (0:�Ј�,1:�p�[�g,2:�_��,10:�h��)

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
 1 : �В�
 2 : �����
34 : ���
35 : �����ꖱ
37 : �ō��Ɩ����s�ӔC��
38 : �
39 : ���s�������В�
40 : ����𕛉
41 : ���s�����ꖱ
42 : ���s�����햱
43 : CA
44 : ��������s�����ꖱ
45 : ���s����			 XXX ���A��c
46 : ��������s�����햱�@XXX ����
88 : �ږ�
*/

   
	var yakuStr = "1,2,34,35,37,38,39,40,41,42,43,44,88"
	var SQLTab = []
	for( var S_name in Tab ){
		SQL  = " SELECT"
		SQL += "      S_name = '" + S_name + "',"
		SQL += "      ����   = MAST.����,"

		SQL += "    yymm   = DATA.yymm,"
		SQL += "    �敪   = DATA.�敪,"
		SQL += "    value  = count(DATA.memberID)"

		SQL += " FROM"
		SQL += "    �v�������f�[�^ DATA"
		SQL += "           LEFT JOIN (SELECT * FROM EMG.dbo.�����}�X�^ WHERE NOT(�J�n > '" + eDate  + "' or �I�� < '" + sDate  + "') ) MAST"
		SQL += "                ON DATA.����ID     = MAST.�����R�[�h"
		SQL += "           LEFT JOIN (SELECT * FROM �����{���}�X�^     WHERE NOT(�J�n > '" + e_yymm + "' or �I�� < '" + s_yymm + "') ) TM"
		SQL += "                ON MAST.�����R�[�h = TM.����ID"

		SQL += " WHERE"
		SQL += "    DATA.�敪 IN(0,1,2)"
		SQL += "    AND"
		SQL += "    DATA.yymm BETWEEN " + s_yymm + " AND " + e_yymm
		if( Tab[S_name]["�����R�[�h"].length > 0 ){
			SQL += "    AND"
			SQL += "    MAST.�����R�[�h IN(" + Tab[S_name]["�����R�[�h"].join(",") + ")"
			}
		if( Tab[S_name]["����"] != "" ){
			SQL += "    AND"
			SQL += "    MAST.���� IN(" + Tab[S_name]["����"] + ")"
			}

		SQL += " GROUP BY"
		SQL += "    MAST.����,"
		SQL += "    DATA.yymm,"
		SQL += "    DATA.�敪"
		
		SQLTab.push(SQL)
		}

	SQL = SQLTab.join(" UNION ALL ")		
	RS = DB.Execute(SQL)

	var statName = "����"
	var item = "�v����"
//	var kindTab = {0:"�Ј�",1:"�p�[�g",2:"�_��",10:"�h��"}
	var kindTab = {0:"�Ј�",1:"�p�[�g",2:"�Ј�"}
	var Grp,kind,item,yymm,amount,n,mode,area,Scale
	while(!RS.EOF){
		����    = RS.Fields('����').Value
		S_name  = RS.Fields('S_name').Value
		kind    = RS.Fields("�敪").Value
		yymm    = RS.Fields("yymm").Value
		value   = RS.Fields("value").Value

		kindName = ( IsObject(kindTab[kind]) ? kindTab[kind] : "" )

		if( S_name == null ){
			errorMsg("accountActual2")
			secName = "�s��"
			}
		else if( dispMode == "�S��" ){
			secName = "�S��"
			}
		else if( dispMode == "�{��" ){
			secName = ( ���� == 2 ? "�{��" : "����" )
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
			secMode = "�J��"
			break;
		case "2" :
			secMode = "�Ԑ�"
			break;
		case "0,1,2" :
			secMode = ""
			break;
		default :
			secMode = ""
			break;
			}

	var serverName = "http://" + Request.ServerVariables("SERVER_NAME")
	var sURL = serverName + "/Project/common_data/xmlProc/���僊�X�g_XML.asp"

	var para = []
	para.push("year=" + year)
	para.push("secMode=" + secMode)
//	para.push("dispMode=" + "��")
//	para.push("dispMode=" + "��")
	para.push("dispMode=" + dispMode)
	sURL += "?" + para.join("&")
		
//	EMGLog.Write("x.txt",sURL)

	var httpObj = Server.CreateObject("Microsoft.XMLHTTP");
	httpObj.open("POST",sURL,false);
	httpObj.send(null);
	if( httpObj.status != 200) throw new Error("xml �G���[[" + httpObj.status + "]�F" + sURL)

	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false
	var ret = xmlDoc.load(httpObj.responseXML)

//	EMGLog.Write("x.txt",ret)

	var modeTab = ["�J��","�c��","�Ԑ�"]

	var Nodes = xmlDoc.selectNodes("//����")

//	EMGLog.Write("x.txt",Nodes.length)

	var Tab = []
	var Cnt = Nodes.length
	for( var i = 0; i < Cnt; i++ ){
		var T_name = Nodes[i].getAttribute("����")
		var B_name = Nodes[i].getAttribute("��")
		var K_name = Nodes[i].getAttribute("��")
		var mode   = Nodes[i].getAttribute("����")
		var gCode  = Nodes[i].getAttribute("����R�[�h")
		var codes  = Nodes[i].getAttribute("codes")
		var gName  = T_name + B_name + K_name
		Tab.push({����:mode,gCode:gCode,���O:gName,����:T_name,��:B_name,��:K_name,codes:codes})
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
