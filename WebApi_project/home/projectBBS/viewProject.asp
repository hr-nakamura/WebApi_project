<%@ Language=JScript %>
<!--#include virtual="/Project/Auth/projectLog.inc"-->
<!--#include file="cmn.inc"-->
<html>

<head>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

<title>�f�����e�\��</title>
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
	
// �����Ƀv���W�F�N�g���{�O���[�v������\��
	tableRowBegin("");
	tableDataCellBegin("");
	bbsTitle(DB,pNum);
	pn("<BR>");
	tableDataCellEnd();
	tableRowEnd();
	
// �����ɃO���[�v������\��
	tableRowBegin("");
	tableDataCellBegin("");
	dispGroupHistory(DB,pNum);
	pn("<BR>");
	tableDataCellEnd();
	tableRowEnd();
	
// �����ɔ��㗚����\��
	tableRowBegin("");
	tableDataCellBegin("");
	dispSalesHistory(DB,pNum);
	pn("<BR>");
	tableDataCellEnd();
	tableRowEnd();
	
// �����ɊJ���v���̂����\��
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
//	��ۼު�ďڍ�
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
	SQL +=	  "�S��PM       = (SELECT �� + '�@' + �� FROM EMG.dbo.�Ј���b�f�[�^ WHERE �Ј�ID = �S��PM),"
	SQL +=	  "Title        = Title,"
	SQL +=	  "Content      = Content,"
	SQL +=	  "blockName    = '���O' "
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
		�S��PM		 = RS.Fields("�S��PM").Value
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
	
	var capStr_m = "�y�o�^�F" + mDate.toLocaleString() + "�z";
	var capStr_u = "�y�X�V�F" + eDate.toLocaleString() + "�z";
	
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
	tableDataCell("ALIGN='LEFT'",cnvStatMark(Stat));	// ������
	tableDataCell("class='entryDATE' align='right'",capStr_m);
	tableDataCell("class='renewalDATE' align='right'",newMark + capStr_u);
	tableRowEnd();
	tableBodyEnd();
	tableEnd();
	
//-----------------------------------------------------------------------------------

	tableBegin("class='insideFrameColor' ALIGN='CENTER'");
	
	tableHeadBegin("");
	tableRowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'");
	tableHeadCell("width='20%'","���@��");
	tableHeadCell("width='80%' colSpan='3'","���@�@�e");
	tableRowEnd();
	tableHeadEnd();
	
	tableFootBegin("");
	tableFootEnd();
	
	tableBodyBegin("bgcolor='snow'");
	
	usrWork = "<b>" + corpName + "</b><BR>�@" + Work[1] + "<BR>�@�@" + Work[2];	// ��Ж�+������+�q��S����
	
	tableRowBegin("valign='middle'");
	tableDataCell("ALIGN='CENTER'width='20%'","�q�於");
	tableDataCell("ALIGN='LEFT' colSpan='3'",usrWork);		// �q����
	tableRowEnd();
	
	tableRowBegin("valign='middle'");
	tableDataCell("ALIGN='CENTER'width='20%'","�J������");
	tableDataCell("ALIGN='LEFT'width='40%'",Work[4]);		// �J������
	tableDataCell("ALIGN='LEFT'width='20%'",Work[5]);		// �J���K��
	tableDataCell("ALIGN='LEFT'width='20%'",Work[6]);		// �J���ꏊ
	tableRowEnd();
	
//------------------------------

	tableRowBegin("valign='middle'");
	tableDataCell("ALIGN='CENTER'width='20%'","�T�v");
	tableDataCellBegin("ALIGN='LEFT' colSpan='3'");
	//p("<TT>");
	textOut( String(pContent) );
	//p("</TT>");
	tableDataCellEnd();
	tableRowEnd();

//------------------------------

	tableRowBegin("valign='middle' bgcolor='powderblue'");
	tableDataCell("ALIGN='CENTER'width='20%'","�c�ƒS��");
	tableDataCell("ALIGN='LEFT'colSpan='3'",Work[3]);				 // �c�ƒS��
	tableRowEnd();
	
	tableRowBegin("valign='middle' bgcolor='powderblue'");
	tableDataCell("ALIGN='CENTER'width='20%'","�S��PM");
	tableDataCell("ALIGN='LEFT'colSpan='3'",�S��PM);				 // �c�ƒS��
	tableRowEnd();
	

	tableBodyEnd();
	tableEnd();
	}

function cnvStatMark(stat)
	{
	var Str = "";
	switch(parseInt(stat)){
		case 0 :
			Str = "��".fontcolor("green") + "������".big();
			break;
		case 1 :
			Str = "��".fontcolor("blue")  + "�J����".big();
			break;
		case 4 :
			Str = "��".fontcolor("gray")  + "�J���I��".big();
			break;
		case 5 :
			Str = "��".fontcolor("gray")  + "�I��".big();
			break;
		case -1 :
			Str = "�~".fontcolor("gray")  + "�v".big();
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
   

// �����ɃO���[�v������\��
//------------------------------------------------------------------------
//	�O���[�v����
//------------------------------------------------------------------------
function dispGroupHistory(DB,pNum)
   {
	var Tab = getGroupHistoryInfo(DB,pNum)
	
	tableBegin("class='insideFrameColor' ALIGN='CENTER'")
	tableCaption("class='SUB'","�O���[�v����")
	
	tableHeadBegin("")
	tableRowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'")
	tableHeadCell("ALIGN='CENTER' nowrap�@WIDTH='30%'","�J�n�N��");
	tableHeadCell("ALIGN='CENTER' colspan='3' nowrap WIDTH='70%'","�J���O���[�v");
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
//	���㗚��
//------------------------------------------------------------------------
function dispSalesHistory(DB,pNum)
   {
   var Tab = getSalesHistoryInfo(DB,pNum)

   tableBegin("class='insideFrameColor' ALIGN='CENTER'")
   tableCaption("class='SUB'","���㗚��")
  
   tableHeadBegin("")
   tableRowBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'")
   tableHeadCell("WIDTH='30%' nowrap","��")
   tableHeadCell("WIDTH='30%' nowrap","�O���[�v��");
   tableHeadCell("WIDTH='20%' nowrap","�\��");
   tableHeadCell("WIDTH='20%' nowrap","����");
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
	  tableDataCell(" ALIGN='RIGHT'",(plan == 0 ? "�@" : formatNum(plan,0)) )
	  tableDataCell(" ALIGN='RIGHT'",(actual == 0 ? "�@" : formatNum(actual,0)) )
	  tableRowEnd()
	  }
   tableBodyEnd()
   tableEnd()
   }

//------------------------------------------------------------------------
//	�O���[�v����
//------------------------------------------------------------------------
function dispMemberHistory(DB,pNum)
	{
	var Tab = getMemberHitory(DB,pNum)
	
	tableBegin("class='insideFrameColor' ALIGN='CENTER'")
	
	tableCaption("class='SUB'","��Ɛl��")
		
	tableHeadBegin("valign='middle' bordercolor='black' bgcolor='#aac2ea'")
	tableRowBegin("")
	tableHeadCell("WIDTH='30%' nowrap","���O")
	tableHeadCell("WIDTH='50%' nowrap colspan='2'","��Ɗ���")
	tableHeadCell("WIDTH='20%' nowrap","��Ɠ���")
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
   SQL +=	" �J�n = �Ɩ������f�[�^.�J�n,"
   SQL +=	" �I�� = �Ɩ������f�[�^.�I��,"
   SQL +=	" ���� = �Ɩ������f�[�^.����ID,"
   SQL +=	" ���O = �����}�X�^.������"
   SQL += " FROM"
   SQL +=	" �Ɩ������f�[�^ inner join �����}�X�^ on �Ɩ������f�[�^.����ID = �����}�X�^.�����R�[�h"
   SQL += " WHERE"
   SQL += "   �Ɩ������f�[�^.pNum = " + pNum
   SQL += " ORDER BY"
   SQL += "   �Ɩ������f�[�^.�J�n DESC"

   RS = DB.Execute(SQL)
   var n,s_yymm,e_yymm,gName,gID
   while(!RS.EOF){
	  s_yymm = RS.Fields('�J�n').Value
	  e_yymm = RS.Fields('�I��').Value
	  gID	 = RS.Fields('����').Value
	  gName  = RS.Fields('���O').Value
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
   SQL += "    yymm   = ����\�����уf�[�^.yymm,"
   SQL += "    mode   = ����\�����уf�[�^.mode,"
   SQL += "    gCode  = �Ɩ������f�[�^.����ID,"
   SQL += "    amount = Sum(����\�����уf�[�^.���z)"
   SQL += " FROM"
   SQL += " 	(����\�����уf�[�^ INNER JOIN �Ɩ������f�[�^ ON ����\�����уf�[�^.pNum = �Ɩ������f�[�^.pNum)"
   SQL += " WHERE"
   SQL += "    ����\�����уf�[�^.pNum = '" + pNum + "'"
   SQL += "    AND"
   SQL += "    (����\�����уf�[�^.yymm Between �Ɩ������f�[�^.�J�n And �Ɩ������f�[�^.�I��)"
   SQL += " GROUP BY"
   SQL += "    ����\�����уf�[�^.yymm,"
   SQL += "    ����\�����уf�[�^.mode,"
   SQL += "    �Ɩ������f�[�^.����ID"
   SQL += " ORDER BY"
   SQL += "    ����\�����уf�[�^.yymm DESC,"
   SQL += "    �Ɩ������f�[�^.����ID"

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
//	 if(!dic.Exists(key))		   //���o�^�Ȃ�Δ�����
//	 pr(dic.Item(key))			   //�l��\������
   this.dic = new ActiveXObject("Scripting.Dictionary")
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL
   SQL	= " SELECT"
   SQL += "    gCode = �����R�[�h,"
   SQL += "    gName = ������"
   SQL += " FROM"
   SQL +=	" EMG.dbo.�����}�X�^"
   SQL += " ORDER BY"
   SQL += "    �����R�[�h"
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
	SQL +=		" �� = EMG.dbo.�Ј���b�f�[�^.��,"
	SQL +=		" �� = EMG.dbo.�Ј���b�f�[�^.��,"
	SQL +=		" �J�n = MIN(EMG.dbo.�Ζ����f�[�^.���t),"
	SQL +=		" �I�� = MAX(EMG.dbo.�Ζ����f�[�^.���t),"
	SQL +=		" ���� = COUNT(EMG.dbo.�Ζ����f�[�^.memberID)"
	
	SQL += " FROM"
	SQL +=			" (EMG.dbo.�Ζ����f�[�^ INNER JOIN projectNum             ON EMG.dbo.�Ζ����f�[�^.pNum     = projectNum.pNum)"
	SQL +=			"                       INNER JOIN EMG.dbo.�Ј���b�f�[�^ ON EMG.dbo.�Ζ����f�[�^.memberID = EMG.dbo.�Ј���b�f�[�^.�Ј�ID"
	
	SQL += " WHERE"
	SQL += "	projectNum.pNum = " + pNum
		
	SQL += " GROUP BY"
	SQL += "	EMG.dbo.�Ј���b�f�[�^.��,"
	SQL += "	EMG.dbo.�Ј���b�f�[�^.��"
	
	SQL += " ORDER BY"
	SQL +=		" MIN(EMG.dbo.�Ζ����f�[�^.���t),"
	SQL +=		" MAX(EMG.dbo.�Ζ����f�[�^.���t)"
	RS = DB.Execute(SQL)

	var n, lName, oName, sDate, eDate, days
	while(!RS.EOF){
		lName = RS.Fields('��').Value
		oName = RS.Fields('��').Value
		sDate = JsFormatDateTime(RS.Fields('�J�n').Value, 2)
		eDate = JsFormatDateTime(RS.Fields('�I��').Value, 2)
		days = RS.Fields('����').Value
		n = Tab.length
		Tab[n] = new Object
		Tab[n].name = lName + "�@" + oName
		Tab[n].period = sDate + "�@�`�@" + eDate
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
