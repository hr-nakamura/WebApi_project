<%@ LANGUAGE="JavaScript" %>
<!--#include FILE="cmn.inc"-->
<%var public_description = new srvConst();RSDispatch();%>
<!--#INCLUDE VIRTUAL="/_ScriptLibrary/RS.ASP"-->

<SCRIPT RUNAT=SERVER LANGUAGE="JavaScript">
function srvConst()
   {
//EMGLog.Write("bbs.txt","==== bbsDB ====" + Session("memberName1") + Session("memberName2") )
// �v���W�F�N�g�ҏW�p
   this.bbsAddList     = bbsAddList;
   this.bbsEditList    = bbsEditList;

   this.bbsJoinAdd     = bbsJoinAdd;
   this.bbsJoinParent  = bbsJoinParent;
   this.bbsJoinRename  = bbsJoinRename;
   
// �O���[�v�ҏW�p
   this.regGrpEdit     = regGrpEdit;
   this.regGrpAdd      = regGrpAdd;
   this.regGrpDel      = regGrpDel;

// ���\���p
   this.getGroupList   = getGroupList;
   this.getProjectInfo = getProjectInfo;
   this.getHistoryInfo = getGroupHistoryInfo;
   this.getSalesInfo   = getSalesHistoryInfo;

   this.getCorpList    = getCorpList;
   this.getKindList    = getKindList;

   this.getMemberList  = getMemberList;


   }
</Script>

<%
function getMemberList(targetStr,memberName)
   {
try{
	var DB = Server.CreateObject("ADODB.Connection")
	var RS = Server.CreateObject("ADODB.Recordset")
	
	DB.Open( Session("ODBC") )
	DB.DefaultDatabase = "EMG"

	var mTab = new Object
	var zoku = 0
	var zName = ""

//=== �Ј�����(�w��O���[�v) =======
//	�w��O���[�v��擪�Ɏ����Ă���
	SQL  = " SELECT"
	SQL += "    Name1    = MAST.��,"
	SQL += "    Name2    = MAST.��,"
	SQL += "    Name1Y   = MAST.�����,"
	SQL += "    Name2Y   = MAST.�����,"
	SQL += "    memberID = MAST.�Ј��h�c,"
	SQL += "    Corp     = MAST.�А�,"
	SQL += "    Part     = MAST.�O��,"
	SQL += "    ZOKU     = ZOKU.����ID,"
	SQL += "    YAKU     = YAKU.��EID,"
	SQL += "    ZNAME    = ZMAST.������,"
	SQL += "    YNAME    = YMAST.��E�Ăі�"
	SQL += " FROM"
	SQL += "    �Ј���b�f�[�^ MAST LEFT JOIN �Ј���E�f�[�^ YAKU  ON MAST.�Ј�ID = YAKU.�Ј�ID"
	SQL += "                        LEFT JOIN �Ј������f�[�^ ZOKU  ON MAST.�Ј�ID = ZOKU.�Ј�ID"
	SQL += "                        LEFT JOIN �����}�X�^    ZMAST  ON ZOKU.����ID = ZMAST.�����R�[�h"
	SQL += "                        LEFT JOIN ��E�}�X�^    YMAST  ON YAKU.��EID = YMAST.��E�R�[�h"

	SQL += " WHERE"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN MAST.���ДN���� AND MAST.�ސE�N���� OR MAST.�ސE�N���� IS NULL)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.�J�n AND YAKU.�I�� AND YAKU.���� = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.�J�n AND YAKU.�I��)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.�J�n AND ZOKU.�I�� AND ZOKU.���� = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.�J�n AND ZOKU.�I��)"
	SQL += "    AND"
	SQL += "    (ZMAST.ACC�R�[�h >= -1 OR ZMAST.�����R�[�h=1)"
	SQL += "    AND"
	SQL += "    ZMAST.������ LIKE '%" + targetStr + "%'"
	SQL += " ORDER BY"
	SQL += "   ZMAST.����,"
	SQL += "   ZMAST.������,"
	SQL += "   YAKU.��EID,"
	SQL += "   MAST.�����,MAST.�����"
	RS = DB.Execute(SQL)
	while( !RS.EOF ){
		memberID = RS.Fields("memberID").Value
		name    = RS.Fields("Name1").Value  + "�@" + RS.Fields("Name2").Value
		yomi    = RS.Fields("Name1Y").Value  + "�@" + RS.Fields("Name2Y").Value
		part    = RS.Fields("Part").Value
		yaku    = RS.Fields("YAKU").Value
		zoku    = RS.Fields("ZOKU").Value
		yName   = RS.Fields("YNAME").Value
		zName   = RS.Fields("ZNAME").Value
		if( !IsObject(mTab[zoku]) ) mTab[zoku] = {���O:zName,data:new Object}
		mTab[zoku].data[memberID] = {mode:0,���O:name,��E:yName}
		RS.MoveNext()
		}
	RS.Close()

//=== �Ј����� =======
	SQL  = " SELECT"
	SQL += "    Name1    = MAST.��,"
	SQL += "    Name2    = MAST.��,"
	SQL += "    Name1Y   = MAST.�����,"
	SQL += "    Name2Y   = MAST.�����,"
	SQL += "    memberID = MAST.�Ј��h�c,"
	SQL += "    Corp     = MAST.�А�,"
	SQL += "    Part     = MAST.�O��,"
	SQL += "    ZOKU     = ZOKU.����ID,"
	SQL += "    YAKU     = YAKU.��EID,"
	SQL += "    ZNAME    = ZMAST.������,"
	SQL += "    YNAME    = YMAST.��E�Ăі�"
	SQL += " FROM"
	SQL += "    �Ј���b�f�[�^ MAST LEFT JOIN �Ј���E�f�[�^ YAKU  ON MAST.�Ј�ID = YAKU.�Ј�ID"
	SQL += "                        LEFT JOIN �Ј������f�[�^ ZOKU  ON MAST.�Ј�ID = ZOKU.�Ј�ID"
	SQL += "                        LEFT JOIN �����}�X�^    ZMAST  ON ZOKU.����ID = ZMAST.�����R�[�h"
	SQL += "                        LEFT JOIN ��E�}�X�^    YMAST  ON YAKU.��EID = YMAST.��E�R�[�h"

	SQL += " WHERE"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN MAST.���ДN���� AND MAST.�ސE�N���� OR MAST.�ސE�N���� IS NULL)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.�J�n AND YAKU.�I�� AND YAKU.���� = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN YAKU.�J�n AND YAKU.�I��)"
	SQL += "    AND"
//	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.�J�n AND ZOKU.�I�� AND ZOKU.���� = 0)"
	SQL += "    (CONVERT(char,GETDATE(),111) BETWEEN ZOKU.�J�n AND ZOKU.�I��)"
	SQL += "    AND"
	SQL += "    (ZMAST.ACC�R�[�h >= -1 OR ZMAST.�����R�[�h=1)"
	SQL += "    AND"
	SQL += "    YAKU.��EID < 85"
	SQL += "    AND"
	SQL += "    ZMAST.������ NOT LIKE '%" + targetStr + "%'"
	SQL += " ORDER BY"
	SQL += "   ZMAST.����,"
	SQL += "   ZMAST.������,"
	SQL += "   YAKU.��EID,"
	SQL += "   MAST.�����,MAST.�����"
	RS = DB.Execute(SQL)
	while( !RS.EOF ){
		memberID = RS.Fields("memberID").Value
		name    = RS.Fields("Name1").Value  + "�@" + RS.Fields("Name2").Value
		yomi    = RS.Fields("Name1Y").Value  + "�@" + RS.Fields("Name2Y").Value
		part    = RS.Fields("Part").Value
		yaku    = RS.Fields("YAKU").Value
		zoku    = RS.Fields("ZOKU").Value
		yName   = RS.Fields("YNAME").Value
		zName   = RS.Fields("ZNAME").Value
		if( !IsObject(mTab[zoku]) ) mTab[zoku] = {���O:zName,data:new Object}
		mTab[zoku].data[memberID] = {mode:0,���O:name,��E:yName}
		RS.MoveNext()
		}
	RS.Close()


//=== �Ј�����(�ސE�����Ј�) =======
	if( memberName != "" ){
		SQL  = " SELECT"
		SQL += "    Name1    = MAST.��,"
		SQL += "    Name2    = MAST.��,"
		SQL += "    Name1Y   = MAST.�����,"
		SQL += "    Name2Y   = MAST.�����,"
		SQL += "    memberID = MAST.�Ј��h�c,"
		SQL += "    Corp     = MAST.�А�,"
		SQL += "    Part     = MAST.�O��,"
		SQL += "    ZOKU     = ZOKU.����ID,"
		SQL += "    YAKU     = YAKU.��EID,"
		SQL += "    ZNAME    = ZMAST.������,"
		SQL += "    YNAME    = YMAST.��E�Ăі�"
		SQL += " FROM"
		SQL += "    �Ј���b�f�[�^ MAST LEFT JOIN �Ј���E�f�[�^ YAKU  ON MAST.�Ј�ID = YAKU.�Ј�ID"
		SQL += "                        LEFT JOIN �Ј������f�[�^ ZOKU  ON MAST.�Ј�ID = ZOKU.�Ј�ID"
		SQL += "                        LEFT JOIN �����}�X�^    ZMAST  ON ZOKU.����ID = ZMAST.�����R�[�h"
		SQL += "                        LEFT JOIN ��E�}�X�^    YMAST  ON YAKU.��EID = YMAST.��E�R�[�h"

		SQL += " WHERE"
		SQL += "   MAST.�ސE = 1"
		SQL += "   AND"
		SQL += "   (MAST.�� + MAST.��) = '" + memberName + "'"
		SQL += " ORDER BY"
		SQL += "   ZMAST.����,"
		SQL += "   ZMAST.������,"
		SQL += "   YAKU.��EID,"
		SQL += "   MAST.�����,MAST.�����"

		RS = DB.Execute(SQL)
		if( !RS.EOF ){
			memberID = RS.Fields("memberID").Value
			name    = RS.Fields("Name1").Value  + "�@" + RS.Fields("Name2").Value
			yomi    = RS.Fields("Name1Y").Value  + "�@" + RS.Fields("Name2Y").Value
			part    = RS.Fields("Part").Value
			yaku    = RS.Fields("YAKU").Value
			zoku    = RS.Fields("ZOKU").Value
			yName   = RS.Fields("YNAME").Value
			zName   = "�ݐЎЈ��ȊO"							// RS.Fields("ZNAME").Value	
			if( !IsObject(mTab[zoku]) ) mTab[zoku] = {���O:zName,data:new Object}
			mTab[zoku].data[memberID] = {mode:0,���O:name,��E:""}
			}
		RS.Close()

		}
	
	DB.Close()

	return(mTab)
}catch(e){return(e.message)}
	}

function getCorpList(groupID)
   {
   var SQL
   var DB = Server.CreateObject("ADODB.Connection");
   var RS = Server.CreateObject("ADODB.Recordset");

   DB.Open( Session("ODBC") );
   DB.DefaultDatabase = "kansaDB"

	var toDay = getDateTimeString()

   SQL  = " SELECT"
   SQL += "    �����R�[�h"
   SQL += " FROM"
   SQL += "    EMG.dbo.�����}�X�^"
	SQL += " WHERE"
    SQL += "(GETDATE() BETWEEN �J�n AND �I��) OR (DATEADD(year, -1, GETDATE()) BETWEEN �J�n AND �I��)"
//   SQL += "    '" + toDay + "' BETWEEN �J�n AND �I��"
   SQL += " GROUP BY"
   SQL += "    �����R�[�h"
   SQL += " ORDER BY"
   SQL += "    �����R�[�h"
   RS = DB.Execute(SQL)
	var grpTab = new Array()
	while( !RS.EOF ){
	   grpTab[grpTab.length] = RS.Fields("�����R�[�h").Value
		RS.MoveNext()
		}
   RS.Close()


   SQL  = " SELECT"
   SQL += "    corpName"
   SQL += " FROM"
   SQL += "    projectNum"
   SQL += " WHERE"
   SQL += "    corpName IS NOT NULL"
	SQL += "    AND"
	if( groupID > 0 ){
		SQL += "    ����ID = '" + groupID + "'"
		}
	else{
		SQL += "    ����ID IN(" + grpTab.join(",") + ")"
		}
   SQL += " GROUP BY"
   SQL += "    corpName"
   SQL += " ORDER BY"
   SQL += "    corpName"
   RS = DB.Execute(SQL)
	var Tab = new Array()
	while( !RS.EOF ){
	   Tab[Tab.length] = RS.Fields("corpName").Value
		RS.MoveNext()
		}
   RS.Close()
	DB.Close()
	return(Tab)
	}
function getKindList(kindName)
   {
   var SQL
	switch(kindName){
		case "�J�e�S���[��1" :
			SQL  = " SELECT"
			SQL += "    ���ޖ� = �J�e�S���[��1"
			SQL += " FROM"
			SQL += "    projectNum"
			SQL += " WHERE"
			SQL += "    �J�e�S���[��1 IS NOT NULL"
			SQL += " GROUP BY"
			SQL += "    �J�e�S���[��1"
			SQL += " ORDER BY"
			SQL += "    �J�e�S���[��1"
			break;
		case "�J�e�S���[��2" :
			SQL  = " SELECT"
			SQL += "    ���ޖ� = �J�e�S���[��2"
			SQL += " FROM"
			SQL += "    projectNum"
			SQL += " WHERE"
			SQL += "    �J�e�S���[��2 IS NOT NULL"
			SQL += " GROUP BY"
			SQL += "    �J�e�S���[��2"
			SQL += " ORDER BY"
			SQL += "    �J�e�S���[��2"
			break;
		case "�V�K��" :
			SQL  = " SELECT"
			SQL += "    ���ޖ� = ���ޖ�"
			SQL += " FROM"
			SQL += "    �Ɩ����ރ��X�g"
			SQL += " WHERE"
			SQL += "    mode = 2"
			SQL += " ORDER BY"
			SQL += "    �\����"
			break;
		case "���ޖ�" :
			SQL  = " SELECT"
			SQL += "    ���ޖ� = ���ޖ�"
			SQL += " FROM"
			SQL += "    �Ɩ����ރ��X�g"
			SQL += " WHERE"
			SQL += "    mode = 1"
			SQL += " ORDER BY"
			SQL += "    �\����"
			break;
		case "�m�x" :
			var Tab = ["100","90","80","70","50","30","10"]
			return(Tab)
			break;
		default:
			SQL = ""
			break;
			}			

   var DB = Server.CreateObject("ADODB.Connection");
   var RS = Server.CreateObject("ADODB.Recordset");

   DB.Open( Session("ODBC") );
   DB.DefaultDatabase = "kansaDB"

   RS = DB.Execute(SQL)
	var Tab = []
	Tab.push("")
	while( !RS.EOF ){
		Tab.push(RS.Fields("���ޖ�").Value)
		
		RS.MoveNext()
		}
   RS.Close()
	DB.Close()
	return(Tab)
	}

//=====================================
//	�W�v�p�̃v���W�F�N�g�e��ݒ�
//=====================================
function bbsJoinParent(pNum,Parent)
	{

//EMGLog.Write("bbs.txt","bbsJoinParent")
	try{
	var Year,yymm
	var pNum,maxNum,baseNum

	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ��ۼު�ē��e�̐ݒ�
	SQL  = " SELECT"
	SQL += "    Parent"
	SQL += " FROM"
	SQL += "    projectNum"
	SQL += " WHERE"
	SQL += "    Project = 2" 
	SQL += "    AND"
	SQL += "    pNum = " + pNum
	RS.Open( SQL, DB, 3, 3);
	if( !RS.EOF ){
		RS.Fields("Parent").Value = Parent;
		RS.Update()
		}
	
	RS.Close();
	DB.Close();

	return(true)

	}catch(e){
		return(e.message)
		}
	}

//=====================================
//	�W�v�p�̃v���W�F�N�g���ύX
//=====================================
function bbsJoinRename(pNum,pName)
	{

//EMGLog.Write("bbs.txt","bbsRenameJoin")
	try{
	var Year,yymm
	var pNum,maxNum,baseNum

	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ��ۼު�ē��e�̐ݒ�
	SQL  = " SELECT"
	SQL += "    pName"
	SQL += " FROM"
	SQL += "    projectNum"
	SQL += " WHERE"
	SQL += "    Project = 5" 
	SQL += "    AND"
	SQL += "    pNum = " + pNum
	RS.Open( SQL, DB, 3, 3);
	if( !RS.EOF ){
		RS.Fields("pName").Value = pName;
		RS.Update()
		}
	
	RS.Close();
	DB.Close();

	return(true)

	}catch(e){
		return(false)
		}
	}

//=====================================
//	�W�v�p�̃v���W�F�N�g�R�[�h�쐬
//=====================================
function bbsJoinAdd(pName)
	{
//EMGLog.Write("bbs.txt","bbsAddJoin",pName)
	var Year,yymm
	var pNum,maxNum,baseNum

	var userName = Session("userName");
	var pDate = getDateTimeString();
	
//=====================================================================
// �r������ݒ�
	Application.Lock
	Application("dummy") = 1
//---------------------------------------
   
	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ��ۼު�ĺ��ނ̐ݒ�
	SQL  = " SELECT maxNum = max(pNum)"
	SQL += " FROM projectNum"
	RS = DB.Execute(SQL)
	maxNum = parseInt(RS.Fields("maxNum").Value)
	RS.Close()

//--------------------------------
//	�V���� pNum �𑢂�
	pNum = pNum_Inc(DB,maxNum)
//--------------------------------

	if( pNum > maxNum ){							// �v���W�F�N�g�ԍ����I�[�o�[�������͐V�K�쐬���Ȃ�
//-- ��ۼު�ē��e�̐ݒ�
		var pCode = make_pCode(pNum,"JP")

try{
		SQL  = " SELECT *"
		SQL += " FROM projectNum"

		RS.Open( SQL, DB, 3, 3);
		RS.AddNew();

		RS.Fields("pNum").Value         = pNum;
		RS.Fields("pCode").Value        = pCode;
		RS.Fields("pName").Value        = pName;
		RS.Fields("corpName").Value     = "";
		RS.Fields("Content").Value      = "";

		RS.Fields("userName").Value     = userName;
		RS.Fields("makeDate").Value     = pDate;
		RS.Fields("editDate").Value     = pDate;
		RS.Fields("newDate").Value      = pDate;
		RS.Fields("Title").Value        = "";
		RS.Fields("Stat").Value         = 98;
		RS.Fields("Project").Value      = 5;							// ��ʁF5			0:�Ԑ� / 1:���� / 2:�J�� / 5�F����
		RS.Fields("Parent").Value       = 1;							// Parent : 1
		RS.Fields("����ID").Value       = 5;							// �����F5 (����)
		RS.Fields("�S���c��").Value     = 0

		RS.Update();
		RS.Close();

}catch(e){
	EMGLog.Write("bbs.txt","bbsAddJoin",e.message)
	}

/*
		var mDate = new Date(pDate)
		var yymm = (mDate.getFullYear() * 100) + (mDate.getMonth()+1)

		SQL  = " DELETE"
		SQL += " FROM �Ɩ������f�[�^"
		SQL += " WHERE pNum = '" + pNum + "'"
		DB.Execute(SQL)
   
		SQL  = " SELECT *"
		SQL += " FROM �Ɩ������f�[�^"
		SQL += " WHERE pNum = " + pNum
		RS.Open( SQL, DB, 3, 3)
		if( RS.EOF ){
			RS.AddNew()
			RS.Fields("pNum").Value   = pNum
			RS.Fields("�J�n").Value   = yymm
			RS.Fields("�I��").Value   = 205001
			RS.Fields("����ID").Value = 5
//EMGLog.Write("BBS.txt","�����v���W�F�N�g�V�K�쐬�@bbsAddJoin [" + pNum + "][" + yymm + "][" + gID + "]")
			}
		RS.Update();
		RS.Close();
// �Ɩ������f�[�^�̍œK��
//		var gCode = projectUpdate(DB,pNum)   
*/	

		}
	DB.Close();
//---------------------------------------
// �r���������
	Application.UnLock

	return(pNum);
	}

//----- �V�K��ۼު�Ēǉ� ------
function bbsAddList(dummy
					,pName
					,corpName
					,V_Title
					,V_Content
					,Stat
					,salesManID
					,gID
					,P_kind
					,P_kindNew
					,P_kindCategory1
					,P_kindCategory2
					,P_fixLevel
					)
	{

	if( Stat == "" ) Stat = "0"
	if( P_fixLevel == "" ) P_fixLevel = "10" 

	var Year,yymm
	var pNum,maxNum,baseNum
	var Content = unescape(V_Content)
	var Title   = unescape(V_Title)
// �g�p����āuHTML�v�ō��镶�����C��
    Title = VB_Replace(Title, "\"", "�h")
    //Title = VB_Replace(Title, "\"", "�f")
	Title = VB_Replace(Title,"\'","�f")
	Title = VB_Replace(Title,"(","�i")
	Title = VB_Replace(Title,")","�j")
	Title = VB_Replace(Title,"&","��")


//EMGLog.Write("bbs.txt","bbsAddList",Content.length,pName.length,corpName.length)
	if( Content.length == 0 || pName.length == 0 || corpName.length == 0){
		return(-1);
		}

	P_kind = (P_kind == "" ? null : P_kind)
	P_kindNew = (P_kindNew == "" ? null : P_kindNew)
	P_kindCategory1 = (P_kindCategory1 == "" ? null : P_kindCategory1)
	P_kindCategory2 = (P_kindCategory2 == "" ? null : P_kindCategory2)

	var userName = Session("userName");
	var pDate = getDateTimeString();

//=====================================================================
// �r������ݒ�
	Application.Lock
	Application("dummy") = 1
//---------------------------------------

try{
   
	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ��ۼު�ĺ��ނ̐ݒ�
	SQL  = " SELECT maxNum = max(pNum)"
	SQL += " FROM projectNum"
	RS = DB.Execute(SQL)
	maxNum = parseInt(RS.Fields("maxNum").Value)
	RS.Close()

//--------------------------------
//	�V���� pNum �𑢂�
	pNum = pNum_Inc(DB,maxNum)
//--------------------------------

	if( pNum > maxNum ){							// �v���W�F�N�g�ԍ����I�[�o�[�������͐V�K�쐬���Ȃ�
//-- ��ۼު�ē��e�̐ݒ�
		var pCode = make_pCode(pNum,"PJ")

		SQL  = " SELECT *"
		SQL += " FROM projectNum"
		RS.Open( SQL, DB, 3, 3);
		RS.AddNew();

		RS.Fields("pNum").Value          = pNum;
		RS.Fields("pCode").Value         = pCode;

		if( pName != "" )			RS.Fields("pName").Value         = pName;
		if( corpName != "" )		RS.Fields("corpName").Value      = corpName;
		if( Content != "" )			RS.Fields("Content").Value       = Content;
		if( userName != "" )		RS.Fields("userName").Value      = userName;
		if( Title != "" )			RS.Fields("Title").Value         = Title;
		if( Stat != "" )			RS.Fields("Stat").Value          = parseInt(Stat);
		if( gID != "" )				RS.Fields("����ID").Value        = gID;
		if( salesManID != "" )		RS.Fields("�S���c��").Value      = salesManID
		if( P_fixLevel != "" )		RS.Fields("fix_level").Value     = P_fixLevel;
		if( P_kind != "" )			RS.Fields("���ޖ�").Value		 = P_kind;
		if( P_kindNew != "" )		RS.Fields("�V�K��").Value	 	 = P_kindNew;
		if( P_kindCategory1 != "" )	RS.Fields("�J�e�S���[��1").Value = P_kindCategory1;
		if( P_kindCategory2 != "" )	RS.Fields("�J�e�S���[��2").Value = P_kindCategory2;

		RS.Fields("makeDate").Value      = pDate;
		RS.Fields("editDate").Value      = pDate;
		RS.Fields("newDate").Value       = pDate;
		RS.Fields("Project").Value       = 2;
		RS.Fields("Parent").Value        = 0;

		RS.Update();
		RS.Close();

		var mDate = new Date(pDate)
		var yymm = (mDate.getFullYear() * 100) + (mDate.getMonth()+1)

		SQL  = " DELETE"
		SQL += " FROM �Ɩ������f�[�^"
		SQL += " WHERE pNum = '" + pNum + "'"

		DB.Execute(SQL)
   
		SQL  = " SELECT *"
		SQL += " FROM �Ɩ������f�[�^"
		SQL += " WHERE pNum = " + pNum

		RS.Open( SQL, DB, 3, 3)
		if( RS.EOF ){
			RS.AddNew()
			RS.Fields("pNum").Value   = pNum
			RS.Fields("�J�n").Value   = yymm
			RS.Fields("����ID").Value = gID
//EMGLog.Write("BBS.txt","�v���W�F�N�g�V�K�쐬�@bbsAddList ", pNum , yymm , gID)
			}
		RS.Update();
		RS.Close();
	
// �Ɩ������f�[�^�̍œK��
		var gCode = projectUpdate(DB,pNum)   

		}
	DB.Close();
}catch(e){
	EMGLog.Write("BBS.txt",e.message,"bbsAddList error" ,pNum , yymm , gID )
	}
//---------------------------------------
// �r���������
	Application.UnLock

	return(pNum);
	}


//----- ��ۼު�ĕҏW ------
function bbsEditList(pNum
					,pName
					,corpName
					,V_Title
					,V_Content
					,Stat
					,salesManID
					,P_kind
					,P_kindNew
					,P_kindCategory1
					,P_kindCategory2
					,P_fixLevel)
	{
	var Content = unescape(V_Content)
	var Title   = unescape(V_Title)

// �g�p����āuHTML�v�ō��镶�����C��
	Title = VB_Replace(Title,"\"","�h")
	Title = VB_Replace(Title,"\'","�f")
	Title = VB_Replace(Title,"(","�i")
	Title = VB_Replace(Title,")","�j")
	Title = VB_Replace(Title,"&","��")

//EMGLog.Write("bbs.txt","bbsEditList",Content.length,pName.length,corpName.length)

	if( Content.length == 0 || pName.length == 0 || corpName.length == 0){
		return(-1);
		}

	P_kind = (P_kind == "" ? null : P_kind)
	P_kindNew = (P_kindNew == "" ? null : P_kindNew)
	P_kindCategory1 = (P_kindCategory1 == "" ? null : P_kindCategory1)
	P_kindCategory2 = (P_kindCategory2 == "" ? null : P_kindCategory2)

	var userName = Session("userName");
	var pDate = getDateTimeString();
   
	DB = Server.CreateObject("ADODB.Connection");
	RS = Server.CreateObject("ADODB.Recordset");

	DB.Open( Session("ODBC") );
	DB.DefaultDatabase = "kansaDB"

//-- ��ۼު�ē��e�̐ݒ�
	SQL  = " SELECT *"
	SQL += " FROM projectNum"
	SQL += " WHERE pNum = " + pNum;
	RS.Open( SQL, DB, 3, 3);
	if( !RS.EOF){
		RS.Fields("pName").Value         = pName;
		RS.Fields("corpName").Value      = corpName;
		RS.Fields("Content").Value       = Content;

		RS.Fields("userName").Value      = userName;
		RS.Fields("Title").Value         = Title;
		RS.Fields("editDate").Value      = pDate;
		RS.Fields("newDate").Value       = pDate;
		RS.Fields("Stat").Value          = parseInt(Stat);

		RS.Fields("�S���c��").Value      = salesManID

		RS.Fields("fix_level").Value     = P_fixLevel;
		RS.Fields("���ޖ�").Value		 = P_kind;
		RS.Fields("�V�K��").Value		 = P_kindNew;
		RS.Fields("�J�e�S���[��1").Value = P_kindCategory1;
		RS.Fields("�J�e�S���[��2").Value = P_kindCategory2;

		RS.Update();
		}
	RS.Close();

	DB.Close();

	return(pNum);
	}



//--------------------------------------------------------------------
function pNum_Inc(DB,pNum)
	{
	var pNum_STEP = 3
	var NumMax = 9995

	var Year = makeYear()								// �쐬����R�[�h�̔N�x
	var baseNum = parseInt(Year) * 10000;
	if(baseNum > pNum){									// �N���ς�����Ƃ�
		pNum = makeEMG_Area(DB,baseNum);				// ���ʗ̈�̍쐬
		}
//	pNum�𑝉�����
// ���܂܂ł�CheckSum��4���łō쐬����
/*
	var work = parseInt(pNum /10) + 1
	var num  = parseInt(work % 1000);
	var year = parseInt(work / 1000);
	var nen  = parseInt(year % 10);
	pNum = (work*10) + checkSum(nen,num)
*/
//*******
	if( pNum < (baseNum + NumMax)){
		pNum += pNum_STEP
		}
	return(pNum)
	}

//-- ��ۼު�ċ��ʗ̈�̍쐬
function makeEMG_Area(DB,baseNum)
	{
	var RS = Server.CreateObject("ADODB.Recordset");
	var JE_BEGIN = 10
	var JE_STEP = 1

	var BU_BEGIN = 200
	var BU_STEP  = 6

	var PJ_BEGIN = 1000
	var PJ_STEP = 3

	var SQL
	var pNum,i,nn,year,nen,num

	SQL  = " SELECT *"
	SQL += " FROM projectNum"
	RS.Open( SQL, DB, 3, 3);

	var year = parseInt(baseNum / 10000);
	for( i = JE_BEGIN; i < BU_BEGIN; i += JE_STEP){   
		nn    = parseInt(i /10)
		num   = parseInt(nn % 1000);
		nen   = parseInt(year % 10);
		pNum  = parseInt(year)*10000 + i
		pCode = make_pCode(pNum,"JE")
		RS.AddNew();
		RS.Fields("pNum").Value    = pNum;
		RS.Fields("pCode").Value   = pCode;
		RS.Fields("Project").Value = 0;
		RS.Fields("makeDate").Value = year + "/01/01";
		RS.Update();
//		pr(pCode + "][" + pNum)
		}
	for( i = BU_BEGIN; i < PJ_BEGIN; i += BU_STEP){   
		nn    = parseInt(i /10)
		num   = parseInt(nn % 1000);
		nen   = parseInt(year % 10);
//		pNum  = parseInt(year + numZ(num,3) + checkSum(nen,num))
		pNum  = parseInt(year)*10000 + i
		pCode = make_pCode(pNum,"BU")
		RS.AddNew();
		RS.Fields("pNum").Value    = pNum;
		RS.Fields("pCode").Value   = pCode;
		RS.Fields("Project").Value = 1;
		RS.Fields("makeDate").Value = year + "/01/01";
		RS.Update();
//		pr(pCode + "][" + pNum + "][" + nen + "][" + num)
		}
	RS.Close();

	var year = parseInt(baseNum / 10000);
	nen  = parseInt(year % 10);
	num  = parseInt(year % 100) + PJ_STEP;
	pNum = baseNum + PJ_BEGIN + checkSum(nen,num)
	pNum = pNum - PJ_STEP								// �P���Ȃ��l��ݒ�
	return(pNum)
	}

//-- ��ۼު�ċ��ʗ̈�̍쐬
function OLD_makeEMG_Area(DB,baseNum)
	{
	var RS = Server.CreateObject("ADODB.Recordset");
	var JE_BEGIN = 10
	var BU_BEGIN = 200
	var PJ_BEGIN = 1000
	var BASE_STEP = 10
	var pNum_STEP = 3
   var SQL
   var pNum,i

   SQL  = " SELECT *"
   SQL += " FROM projectNum"
   RS.Open( SQL, DB, 3, 3);

	var year = parseInt(baseNum / 10000);
   for( i = JE_BEGIN; i < PJ_BEGIN; i += BASE_STEP){   
		nn = parseInt(i /10)
		var num  = parseInt(nn % 1000);
		var nen  = parseInt(year % 10);
	   pNum = parseInt(year + numZ(num,3) + checkSum(nen,num))
		if( i < BU_BEGIN ){
			pCode = make_pCode(pNum,"JE")
			}
		else{
			pCode = make_pCode(pNum,"BU")
			}
		
      RS.AddNew();
      RS.Fields("pNum").Value    = pNum;
      RS.Fields("pCode").Value   = pCode;
      RS.Fields("Project").Value = 0;
      RS.Update();
      }
   RS.Close();
	var nen  = parseInt(year % 10);
	pNum = baseNum + (PJ_BEGIN + nen) - pNum_STEP
	return(pNum)
   }
   
function make_pCode(pNum,Name)
   {
	var pNum4mode = ( pNum > 10000000 ? true : false )
	var pNum4value = ( pNum4mode ? 10000 : 1000 )
	var pCode = ""
	var num  = parseInt(pNum % pNum4value);
	var year = parseInt(pNum / pNum4value);
	var nen  = parseInt(year % 10);
	if( pNum4mode ){
	   pCode = nen + Name + numZ(num,4)
		}
	else{
	   pCode = nen + Name + numZ(num,3) + checkSum(nen,num);
		}
   return(pCode);   
   }

function checkSum(y, i)
    {
    var s;
    
    s = y;
    s = s + (digit(i, 100) * 3);
    s = s + (digit(i, 10) * 5);
    s = s + ((i % 10) * 7);
    return(s % 10);
    }

function digit(i, d)
    {
    var x;
    
    x = i % (d * 10);
    x = Math.floor(x / d);
    return( x );
    }

//--------------------------------------------------------------------
function getDateTimeString()
   {
   var cDate = new Date();
   var strTime
   strTime  = cDate.getFullYear() + "/";
   strTime += (cDate.getMonth() + 1) + "/";
   strTime += cDate.getDate() + " ";
   strTime += cDate.getHours() + ":";
   strTime += cDate.getMinutes() + ":";
   strTime += cDate.getSeconds();

   return(strTime);
   }

// �쐬����R�[�h�̔N�x�쐬   
function makeYear()
   {
   var toDay = new Date()
   var yy = toDay.getFullYear()
   var mm = toDay.getMonth()+1
   var Year = yy									// ���̔N���g�p
   return(Year)
   }

//=====================================================================
function projectNew(DB,pNum,gCode)
   {
//EMGLog.Write("BBS.txt","projectNew")
//-- ��ۼު�ē��e�̐ݒ�
   var SQL
   SQL  = " UPDATE projectNum"
   SQL += " SET"
   SQL += "    ����ID = '" + gCode + "'"
   if(false){
      var userName = Session("userName");
      var pDate = getDateTimeString();
      SQL += ",userName = '" + userName + "'"
      SQL += ",editDate = '" + pDate + "'"
      SQL += ",newDate  = '" + pDate + "'"
      }
   SQL += " WHERE"
   SQL += "    pNum = '" + pNum + "'"
   DB.Execute(SQL)
   }

function regGrpEdit(pNum,yymm,new_gCode,new_yymm)
   {
//EMGLog.Write("BBS.txt","regGrpEdit:" + pNum + "][" + new_gCode + "]["  + yymm + "][" + new_yymm)
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"


//EMGLog.Write("BBS.txt","�O���[�v�R�[�h�̍X�V�@regGrpEdit [" + pNum + "][" + yymm + "][" + new_gCode + "]")

//-- �J�n�E�O���[�v�R�[�h�̍X�V
   SQL  = " UPDATE"
   SQL += "    �Ɩ������f�[�^"
   SQL += " SET"
   SQL += "    �J�n   = '" + new_yymm + "',"
   SQL += "    ����ID = '" + new_gCode + "'"
   SQL += " WHERE"
   SQL += "    pNum = '" + pNum + "'"
   SQL += "    AND"
   SQL += "    �J�n = '" + yymm + "'"
   DB.Execute(SQL)


// �I���̍œK��
   var gCode = projectUpdate(DB,pNum)

// �v���W�F�N�g���X�V��Ԃɂ���
   projectNew(DB,pNum,gCode)

   DB.Close();

   return(true);
   }

function regGrpAdd(pNum,gCode,yymm)
   {
//EMGLog.Write("BBS.txt","regGrpAdd")
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"


//EMGLog.Write("BBS.txt","�O���[�v�̒ǉ��@regGrpAdd [" + pNum + "][" + yymm + "][" + gCode + "]")

//-- �v���W�F�N�g�̒ǉ�
   SQL  = "INSERT INTO �Ɩ������f�[�^"
   SQL += " (pNum,�J�n,����ID)"
   SQL += " VALUES(" + pNum + "," + yymm + "," + gCode + ")"
   DB.Execute(SQL)
   

// �I���̍œK��
   var gCode = projectUpdate(DB,pNum)

// �v���W�F�N�g���X�V��Ԃɂ���
   projectNew(DB,pNum,gCode)

   DB.Close();

   return(true);
   }

function regGrpDel(pNum,yymm)
   {
//EMGLog.Write("bbs.txt","regGrpDel:" + pNum + "][" + yymm)
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

// �폜
   SQL  = " DELETE"
   SQL += " FROM �Ɩ������f�[�^"
   SQL += " WHERE"
   SQL += "   pNum = '" + pNum + "'"
   SQL += "   AND"
   SQL += "   �J�n = '" + yymm + "'"
   DB.Execute(SQL)

// �I���̍œK��
   var gCode = projectUpdate(DB,pNum)

// �v���W�F�N�g���X�V��Ԃɂ���
   projectNew(DB,pNum,gCode)

   DB.Close();

   return(true);
   }

//=====================================================================
function getProjectInfo(pNum)
{
	var Tab = new Object
	Tab.makeDate = ""
	Tab.Stat     = 0
	Tab.pCode    = 0
	Tab.pName    = ""
	Tab.Content  = ""
	Tab.gID      = 5
	Tab.gName    = "����"
	Tab.Info0    = ""                 // T0:�q�於
	Tab.Info1    = ""                 // T1:�q�敔��
	Tab.Info2    = ""                 // T2:�q��S����
	Tab.Info3    = ""                 // T3:�c�ƒS����
	Tab.Info4    = ""                 // T4:����
	Tab.Info5    = ""                 // T5:�H��
	Tab.Info6    = ""                 // T6:�ꏊ
	Tab.kind         = ""
	Tab.kindNew      = ""
	Tab.kindCategory1 = ""
	Tab.kindCategory2 = ""
	Tab.fixLevel     = "30"

	if( parseInt(pNum) > 0 ){
		var Title,Work,Content
		var SQL
		var DB = Server.CreateObject("ADODB.Connection")
		var RS = Server.CreateObject("ADODB.Recordset")
		DB.Open( Session("ODBC") )
		DB.DefaultDatabase = "kansaDB"

		SQL  = " SELECT"
		SQL += "   Stat         = PNUM.Stat,"
		SQL += "   pCode        = PNUM.pCode,"
		SQL += "   pName        = PNUM.pName,"
		SQL += "   CorpName     = PNUM.corpName,"
		SQL += "   ����id       = PNUM.����ID,"
		SQL += "   salesManID   = PNUM.�S���c��,"
		SQL += "   ���ޖ�       = PNUM.���ޖ�,"
		SQL += "   �V�K��       = PNUM.�V�K��,"
		SQL += "   �J�e�S���[��1 = PNUM.�J�e�S���[��1,"
		SQL += "   �J�e�S���[��2 = PNUM.�J�e�S���[��2,"
		SQL += "   fix_level    = PNUM.fix_level,"
		SQL += "   salesMan     = (SELECT ��+�� FROM EMG.dbo.�Ј���b�f�[�^ WHERE �Ј�ID = PNUM.�S���c��),"
		SQL += "   makeDate = CONVERT(char(10),PNUM.makeDate,111),"
		SQL += "   Content  = PNUM.Content,"
		SQL += "   Title    = PNUM.Title"
		SQL += " FROM projectNum PNUM"
		SQL += " WHERE PNUM.pNum = '" + pNum + "'"
		RS = DB.Execute(SQL)	
		if( !RS.EOF ){
			Tab.Stat          = RS.Fields("Stat").Value
			Tab.pCode         = RS.Fields("pCode").Value
			Tab.pName         = String(RS.Fields("pName").Value)
			Tab.corpName      = RS.Fields("corpName").Value
			Tab.salesManID    = RS.Fields("salesManID").Value
			Tab.salesMan      = RS.Fields("salesMan").Value
			Tab.gID           = RS.Fields("����ID").Value
			Tab.makeDate      = RS.Fields("makeDate").Value
			Content           = String(RS.Fields("Content").Value)
			Title             = String(RS.Fields("Title").Value)

			Tab.kind          = RS.Fields("���ޖ�").Value
			Tab.kindNew       = RS.Fields("�V�K��").Value
			Tab.kindCategory1 = RS.Fields("�J�e�S���[��1").Value
			Tab.kindCategory2 = RS.Fields("�J�e�S���[��2").Value
			Tab.fixLevel      = RS.Fields("fix_level").Value

			Tab.kind          = ( Tab.kind         == null ? "" : Tab.kind)
			Tab.kindNew       = ( Tab.kindNew      == null ? "" : Tab.kindNew)
			Tab.kindCategory1 = ( Tab.kindCategory1 == null ? "" : Tab.kindCategory1)
			Tab.kindCategory2 = ( Tab.kindCategory2 == null ? "" : Tab.kindCategory2)
			Tab.fixLevel      = ( Tab.fixLevel     == null ? "" : Tab.fixLevel)

			Tab.salesMan   = ( Tab.salesMan   == null ? "" : Tab.salesMan)
			Tab.salesManID = ( Tab.salesManID == null ? 0  : Tab.salesManID)
		
//			Tab.pName   = escape(Tab.pName)
			Tab.Content = escape(Content)                            // ���s�R�[�h���܂܂�邽��
			Tab.pName   = Tab.pName
			Tab.Content = Tab.Content.replace(/\n/g, "<br/>")                            // ���s�R�[�h���܂܂�邽��
            Tab.Content = Tab.Content.replace(/\"/g, "�h")
			Work = Title.split("\n");
			for( var i = 0; i < Work.length; i++){
				Tab["Info" + i] = (Work[i].length == 0 ? "" : Work[i])
				}
			}


//      Tab["Info0"] = String(RS.Fields("corpName").Value)
		RS.Close();

		SQL  = " SELECT"
		SQL += "    ������"
		SQL += " FROM"
		SQL += "    �����}�X�^"
		SQL += " WHERE"
		SQL += "    �����R�[�h = '" + Tab.gID + "'"
		RS = DB.Execute(SQL)
		if( !RS.EOF) Tab.gName = RS.Fields("������").Value
		RS.Close();

		DB.Close();
	}
    //EMGLog.Write("bbs1.txt", Tab.Content,Tab.Content.replace(/\"/g, "\�h"))
	//EMGLog.Join("bbs_Json.txt", Tab);
	return(Tab)
	}

function getGroupHistoryInfo(pNum)
   {
try{
//EMGLog.Write("bbs.txt","getGroupHistoryInfo")
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

   var toDay = new Date()
   var yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)
   
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL

   var Tab = new Array()
   
   SQL  = " SELECT"
   SQL +=   " �J�n = �Ɩ������f�[�^.�J�n,"
   SQL +=   " �I�� = �Ɩ������f�[�^.�I��,"
   SQL +=   " ���� = �Ɩ������f�[�^.����ID,"
   SQL +=   " ���O = �����}�X�^.������"
   SQL += " FROM"
   SQL +=   " �Ɩ������f�[�^ inner join �����}�X�^ on �Ɩ������f�[�^.����ID = �����}�X�^.�����R�[�h"
   SQL += " WHERE"
   SQL += "   �Ɩ������f�[�^.pNum = " + pNum
   SQL += " ORDER BY"
   SQL += "   �Ɩ������f�[�^.�J�n"

   RS = DB.Execute(SQL)
   var n,s_yymm,e_yymm,gName,gID
   while(!RS.EOF){
      s_yymm = RS.Fields('�J�n').Value
      e_yymm = RS.Fields('�I��').Value
      gID    = RS.Fields('����').Value
      gName  = RS.Fields('���O').Value
      n = Tab.length
      Tab[n] = new Object
      Tab[n].s     = s_yymm
      Tab[n].e     = e_yymm
      Tab[n].gID   = gID
      Tab[n].gName = gName
      RS.MoveNext()
      }

   RS.Close()
   DB.Close()
   
	return(Tab)
}catch(e){EMGLog.Write("bbs.txt","getGroupHistoryInfo:" + e.message)}
   }

function getSalesHistoryInfo(pNum)
   {
try{
//EMGLog.Write("bbs.txt","getSalesHistoryInfo")
   var DB = Server.CreateObject("ADODB.Connection")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

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
   SQL += "    ����\�����уf�[�^.yymm,"
   SQL += "    �Ɩ������f�[�^.����ID"

   RS = DB.Execute(SQL)
   var n,pNum,amount,gCode,c_yymm,mode
   var Tab = new Object
   while(!RS.EOF){
      c_yymm  = RS.Fields('yymm').Value
      mode    = RS.Fields('mode').Value
      gCode   = RS.Fields('gCode').Value
      amount  = RS.Fields('amount').Value

      if( !IsObject(Tab[c_yymm]) ){
         Tab[c_yymm] = new Object
         Tab[c_yymm].gName  = Dic.Item(gCode)
         Tab[c_yymm].plan   = 0
         Tab[c_yymm].actual = 0
         }
      if( mode == 0 ) Tab[c_yymm].actual= amount
      else            Tab[c_yymm].plan  = amount

      RS.MoveNext()
      }

   RS.Close()
   DB.Close()
   Dic = null
   
   return(Tab)

}catch(e){EMGLog.Write("bbs.txt","getSalesHistoryInfo:" + e.message)}
   }

//===========================================================================================
function getGroupList(yymm)
   {
//EMGLog.Write("bbs.txt","getGroupList")
   var cDate = parseInt(yymm/100) + "/" + (yymm%100) + "/1"
   var SQL
   var DB = Server.CreateObject("ADODB.Connection")
   var RS = Server.CreateObject("ADODB.Recordset")
   DB.Open( Session("ODBC") )
   DB.DefaultDatabase = "kansaDB"

   SQL  = " SELECT"
   SQL += "   Mode  = ����,"
   SQL +=   " Code  = �����R�[�h,"
   SQL +=   " Name  = ������"
   SQL += " FROM"
   SQL +=   " EMG.dbo.�����}�X�^"
   SQL += " WHERE"
   SQL += "   ���� IN(0,1,2)"
   SQL += "   AND '" + cDate + "' BETWEEN �J�n AND �I��"
// SQL += "   AND ACC�R�[�h >= 0"
   SQL += " ORDER BY"
   SQL += "   ����,"
   SQL +=   " ������,"
   SQL += "   �I�� DESC,"
   SQL += "   �J�n"
   RS = DB.Execute(SQL)

   var Tab = new Array()
   var n,Mode,Code,Name
   while(!RS.EOF){
      Mode    = RS.Fields('Mode').Value
      Code    = RS.Fields('Code').Value
      Name    = RS.Fields('Name').Value
      n = Tab.length
      Tab[n] = new Object
      Tab[n].mode = Mode
      Tab[n].code = Code
      Tab[n].name = Name
      RS.MoveNext()
      }
   RS.Close()
   DB.Close()

   return(Tab)
   }

//==============================================================================
function getGroupDic(DB)
   {
//   if(!dic.Exists(key))          //���o�^�Ȃ�Δ�����
//   pr(dic.Item(key))             //�l��\������
   this.dic = new ActiveXObject("Scripting.Dictionary")
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL
   SQL  = " SELECT"
   SQL += "    gCode = �����R�[�h,"
   SQL += "    gName = ������"
   SQL += " FROM"
   SQL +=   " EMG.dbo.�����}�X�^"
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


//====================================================================
function projectUpdate(DB,pNum)
   {
//EMGLog.Write("bbs.txt","projectUpdate")

   var toDay = new Date()
   var yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)
   yymm = yymmAdd(yymm,-3)                                  // 3�����O����̃f�[�^
   yymm = 0                                                 // ���ׂ�

// ����f�[�^�̒��o
   var sTab = getSalesData(DB,pNum,yymm)

// �p�~�O���[�v�̒��o
   var rTab = getGroupData_retire(DB)
   
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL = ""

// �J�n��蔄�オ�������̏C��
   SQL  = " SELECT"
   SQL += "     pNum    = pNum,"
   SQL += "     groupID = ����ID,"
   SQL += "     �J�n    = �J�n"
   SQL += " FROM"
   SQL += "     �Ɩ������f�[�^"
   SQL += " WHERE"
   SQL += "     pNum = '" + pNum + "'"
   SQL += " ORDER BY"
   SQL += "     pNum,"
   SQL += "     �J�n"

   RS.Open(SQL,DB,3,3)
   var pNum,groupID,s_yymm,e_yymm,w_yymm,u_yymm,new_yymm
   var saveNum = -1
   while(!RS.EOF){
      pNum     = RS.Fields("pNum").Value
      groupID  = RS.Fields("groupID").Value
      s_yymm   = RS.Fields("�J�n").Value
      if( pNum != saveNum ){
         saveNum = pNum                                                    // �ŏ��̃f�[�^
         if(IsObject(sTab[pNum]) && sTab[pNum].s < s_yymm ){
            RS.Fields("�J�n").Value = sTab[pNum].s
            RS.Update()
//pr("[" + pNum + "][" + s_yymm + "][" + sTab[pNum].s + "]")
            }
         }
      RS.MoveNext()
      }
   RS.Close()

   var lastGroupID = groupID                                               // �ŐV�̃O���[�vID

   // [�J�n]�̓��t����[�I��]�̓��t�𐳂�������
   
   SQL  = " SELECT"
   SQL += "     pNum    = pNum,"
   SQL += "     groupID = ����ID,"
   SQL += "     �J�n    = �J�n,"
   SQL += "     �I��    = �I��"
   SQL += " FROM"
   SQL += "     �Ɩ������f�[�^"
   SQL += " WHERE"
   SQL += "     pNum = '" + pNum + "'"
   SQL += " ORDER BY"
   SQL += "     pNum,"
   SQL += "     �J�n DESC"

   RS.Open(SQL,DB,3,3)
   var pNum,groupID,s_yymm,e_yymm,w_yymm,u_yymm,new_yymm
   var saveNum = -1
   while(!RS.EOF){
      pNum     = RS.Fields("pNum").Value
      groupID  = RS.Fields("groupID").Value
      s_yymm   = RS.Fields("�J�n").Value
      e_yymm   = RS.Fields("�I��").Value
      if( pNum != saveNum ){
         saveNum = pNum                                                    // �ŏ��̃f�[�^
//pr("---------------------------------------")
         new_yymm = yymmAdd(s_yymm,11)                                     // �O���[�v�̗L��������1�N�ɐݒ�
         if(IsObject(rTab[groupID]) && new_yymm > rTab[groupID]){          // �p�~�O���[�v�̎��I��yymm��ݒ�
            new_yymm = rTab[groupID]
            if(s_yymm > new_yymm) new_yymm = s_yymm                        // �p�~�����J�n���x����
            }
         if(IsObject(sTab[pNum])){
            u_yymm = yymmAdd(sTab[pNum].e,3)                               // 3������������
            if( new_yymm < u_yymm) new_yymm = u_yymm                       // ����yymm��ݒ�
            }
         if( new_yymm > e_yymm ) e_yymm = new_yymm                         // �O��X�V�ς͂��̂܂�
         }
      else{
         e_yymm = yymmAdd(w_yymm,-1)                                       // 2��ڈȍ~�̏I����ݒ�
         }
      w_yymm = s_yymm
      RS.Fields("�I��").Value = e_yymm
      RS.Update()
//      pr("[" + pNum + "][" + groupID + "][" + s_yymm + "][" + e_yymm + "]")
      RS.MoveNext()
      }
   RS.Close()
//EMGLog.Write("bbs.txt","projectUpdate end")

   return(lastGroupID)
   }


function getGroupData_retire(DB)
   {
//EMGLog.Write("bbs.txt","getGroupData_retire")
   var toDay = new Date()
   var Tab = new Object
   var RS = Server.CreateObject("ADODB.Recordset")
   var SQL
   SQL  = " SELECT"
   SQL += "     gName   = ������,"
   SQL += "     groupID = �����R�[�h,"
   SQL += "     rDate   = CONVERT(char(10),�I��,111)"
   SQL += " FROM"
   SQL += "     �����}�X�^"
   SQL += " WHERE"
   SQL += "     �I�� < '" + convertDate(toDay) + "'"              // �{�����O�ɔp�~�ɂȂ����O���[�v
   SQL += " ORDER BY"
   SQL += "     �����R�[�h"
   RS = DB.Execute(SQL)
   var groupID,rDate
   while(!RS.EOF){
      gName   = RS.Fields("gName").Value
      groupID = RS.Fields("groupID").Value
      rDate   = RS.Fields("rDate").Value
      Tab[groupID] = (JsDatePart("yyyy",rDate) * 100) + JsDatePart("m",rDate)
//pr("[" + groupID + "][" + rDate + "][" + gName + "]")
      RS.MoveNext()
      }
   RS.Close()
//EMGLog.Write("bbs.txt","getGroupData_retire end")
   return(Tab)
   }

function getSalesData(DB,pNum,yymm)
   {
//EMGLog.Write("bbs.txt","getSalesData")
   var Tab = new Object
   var SQL
   var RS = Server.CreateObject("ADODB.Recordset")

   SQL = ""
   SQL += " SELECT"
   SQL += "    pNum   = pNum,"
   SQL += "    s_yymm = min(yymm),"
   SQL += "    e_yymm = max(yymm)"
   SQL += " FROM"
   SQL += "    �c�Ɣ���f�[�^"
   SQL += " WHERE"
   SQL += "    Flag = 0"
   SQL += "    AND"
   SQL += "    pNum = '" + pNum + "'"
   if( yymm != 0){
      SQL += "    AND"
      SQL += "    yymm >= '" + yymm + "'"
      }
   SQL += " GROUP BY"
   SQL += "    pNum"
   SQL += " ORDER BY"
   SQL += "    pNum"
   RS = DB.Execute(SQL)

   var pNum,x_yymm
   while(!RS.EOF){
      pNum   = RS.Fields("pNum").Value
      s_yymm = RS.Fields("s_yymm").Value
      e_yymm = RS.Fields("e_yymm").Value
      if( !IsObject(Tab[pNum]) ){
         Tab[pNum] = new Object
         Tab[pNum].s = s_yymm
         Tab[pNum].e = e_yymm
         }
      else{
         if( s_yymm < Tab[pNum].s ) Tab[pNum].s = s_yymm
         if( e_yymm > Tab[pNum].e ) Tab[pNum].e = e_yymm
         }
      RS.MoveNext()
      }

   RS.Close()

// ����\���f�[�^
   SQL = ""
   SQL += " SELECT"
   SQL += "    pNum   = pNum,"
   SQL += "    s_yymm = min(yymm),"
   SQL += "    e_yymm = max(yymm)"
   SQL += " FROM"
   SQL += "    �c�Ɨ\���f�[�^"
   SQL += " WHERE"
   SQL += "    pNum = '" + pNum + "'"
   if( yymm != 0){
      SQL += "    AND"
      SQL += "    yymm >= '" + yymm + "'"
      }
   SQL += " GROUP BY"
   SQL += "    pNum"
   SQL += " ORDER BY"
   SQL += "    pNum"
   RS = DB.Execute(SQL)

   var pNum,x_yymm
   while(!RS.EOF){
      pNum   = RS.Fields("pNum").Value
      s_yymm = RS.Fields("s_yymm").Value
      e_yymm = RS.Fields("e_yymm").Value
      if( !IsObject(Tab[pNum]) ){
         Tab[pNum] = new Object
         Tab[pNum].s = s_yymm
         Tab[pNum].e = e_yymm
         }
      else{
         if( s_yymm < Tab[pNum].s ) Tab[pNum].s = s_yymm
         if( e_yymm > Tab[pNum].e ) Tab[pNum].e = e_yymm
         }
      RS.MoveNext()
      }

   RS.Close()
//	EMGLog.Write("bbs.txt","getSalesData end")
   return(Tab)
   }



function IsObject(o)
   {
   if( typeof(o) != "undefined" ) return(true)
   return(false)
   }

%>
<Script language="VBScript"  runat="server">
Function VB_Replace(Buff,oldChr,newChr)
VB_Replace = Replace(Buff,oldChr,newChr)
End Function
</Script>

