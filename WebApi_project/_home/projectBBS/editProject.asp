<%@ Language=JScript %>
<!--#include virtual="/Project/Auth/projectLog.inc"-->
<!--#include file="cmn.inc"-->
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

		<TITLE>�v���W�F�N�g�o�^</TITLE>
<%
   var userName = Session("userName");
   EMGLog.debug("projectBBS.txt","Start")
   
%>
<%

// T0:�q�於
// T1:�q�敔��
// T2:�q��S����
// T3:�c�ƒS����
// T4:����
// T5:�H��
// T6:�ꏊ


%>
		<LINK rel="stylesheet" type="text/css" href="dialog.css">
	</HEAD>
	<BODY background="back.gif">
		<TABLE ALIGN="center" border="0" cellPadding="2" cellSpacing="0" WIDTH="80%">
			<THEAD>
				<!--
			<TR>
			   <TD COLSPAN="3" ALIGN="RIGHT" ID="userName"></TD>
			</TR>
			//-->
				<TR>
					<TD COLSPAN="3" ALIGN="middle" ID="TitleName" class="prgEntry">&nbsp;</TD>
				</TR>
				<TR>
					<TD COLSPAN="3" ALIGN="middle" ID="TitleCode" class="PROJECT-NAME">&nbsp;</TD>
				</TR>
					<TD COLSPAN="3" ALIGN="middle" ID="TitleGuide">&nbsp;</TD>
				<TR>
				</TR>
					<TD COLSPAN="3" ALIGN="middle"><hr></TD>
				<TR>
				</TR>
				<TR>
					<TD COLSPAN="2"><INPUT type="button" value="�o�^" ID="regist"></TD>
					<TD align='right' WIDTH="1%" nowrap>
						<INPUT type="button" value="ؾ��" ID="reset"> <INPUT type="button" value="�I��" ID="exit">
					</TD>
				</TR>
			</THEAD>
			<TBODY>
				<TR>
					<TD nowrap class='textName'>��ۼު�Ė�</TD>
					<TD><INPUT class='textFont' ID="pName" size='60' maxlength="30"></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD nowrap class='textName' valign=top>�J���S���O���[�v</TD>
					<TD class='textFont' ALIGN='left' ID="groupBox"></TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>��Ж�</TD>
					<TD><INPUT type='hidden' ID="T0">
					<SELECT ID='corpSEL' newValue='' style='width:100%'>
					<OPTION selected>�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@</OPTION>
					</SELECT></TD>
					<TD ROWSPAN="8" WIDTH="30%" ALIGN="right" VALIGN="top">
						<TABLE border="0" cellPadding="0" cellSpacing="10" class='thingList'>
							<THEAD>
								<TR>
									<TH class='listHead' COLSPAN="2" nowrap>
										������</TH></TR>
							</THEAD>
							<TBODY ALIGN="middle">
								<TR>
									<TD WIDTH="1"><B><FONT COLOR="green">��</FONT></B></TD>
									<TD ALIGN="left" nowrap><input type="radio" ID="T_Stat" name="R_STAT" Value="0">������</TD>
								</TR>
								<TR>
									<TD WIDTH="1"><B><FONT COLOR="blue">��</FONT></B></TD>
									<TD ALIGN="left" nowrap><input type="radio" ID="T_Stat" name="R_STAT" Value="1">�J����</TD>
								</TR>
								<TR>
									<TD WIDTH="1"><B><FONT COLOR="gray">��</FONT></B></TD>
									<TD ALIGN="left" nowrap><input type="radio" ID="T_Stat" name="R_STAT" Value="4">�J���I��</TD>
								</TR>
								<TR>
									<TD WIDTH="1"><B><FONT COLOR="gray">��</FONT></B></TD>
									<TD ALIGN="left" nowrap><input type="radio" ID="T_Stat" name="R_STAT" Value="5">�I��</TD>
								</TR>
								<TR>
									<TD WIDTH="1"><B><FONT COLOR="gray">�~</FONT></B></TD>
									<TD ALIGN="left" nowrap><input type="radio" ID="T_Stat" name="R_STAT" Value="-1">�v</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>������</TD>
					<TD><INPUT class='textFont' ID="T1" size='45' maxlength="30" style='width:100%'></TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>�q��S����</TD>
					<TD><INPUT class='textFont' ID="T2" size='45' maxlength="20" style='width:100%'></TD>
				</TR>
				<TR style="display:none">
					<TD nowrap class='textName'>�J������X</TD>
					<TD><INPUT class='textFont' ID="T4" size='45' maxlength="20" style='width:100%'></TD>
				</TR>
				<TR style="display:none">
					<TD nowrap class='textName'>�J���K��X</TD>
					<TD><INPUT class='textFont' ID="T5" size='45' maxlength="20" style='width:100%'></TD>
				</TR>


				<TR>
					<TD nowrap class='textName'>�m�x</TD>
					<TD class='textFont' ALIGN='left' ID="T_fixLevel"></TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>���ޖ�</TD>
					<TD class='textFont' ALIGN='left' ID="T_kind"></TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>�V�K��</TD>
					<TD class='textFont' ALIGN='left' ID="T_kindNew"></TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>�J�e�S���[��1</TD>
					<TD><INPUT type='hidden' ID="T_kindCategory1">
					<SELECT ID='categorySEL1' newValue='' style='width:100%'>
					<OPTION selected>�@�@�@</OPTION>
					</SELECT></TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>�J�e�S���[��2</TD>
					<TD><INPUT type='hidden' ID="T_kindCategory2">
					<SELECT ID='categorySEL2' newValue='' style='width:100%'>
					<OPTION selected>�@�@�@</OPTION>
					</SELECT></TD>
				</TR>



				<TR style="display:none">
					<TD nowrap class='textName'>��ƏꏊX</TD>
					<TD><INPUT class='textFont' ID="T6" size='45' maxlength="20" style='width:100%'></TD>
				</TR>
				<TR>
					<TD nowrap class='textName'>�c�ƒS����</TD>
					<TD>
					<SPAN ID="salesManBox" width="100%"></SPAN><BR>
					<INPUT class='textFont' ID="T3" size='45' maxlength="20" style="display:none">
					</TD>
				</TR>
				<TR>
					<TD class='textName' nowrap valign='top'>�Ɩ����e�y�я���</TD>
					<TD colspan="2"><TEXTAREA class='textFont' ID="Content" rows="10" cols="55" WIDTH="100%" style="font-family:arial"></TEXTAREA></TD>
				</TR>
			</TBODY>
		</TABLE>
</BODY>
</HTML>

<SCRIPT LANGUAGE='JavaScript'>
var userName = "<%=userName%>"
var pNum
var result = false
var CategoryTab1 = ""
var CategoryTab2 = ""

</SCRIPT>
<SCRIPT FOR="NEW" EVENT="onclick" LANGUAGE="JavaScript">
	pNum = 0
   InitData()
</SCRIPT>
<SCRIPT FOR="window" EVENT="onload" LANGUAGE="JavaScript">
	try {
		pNum = window.dialogArguments.pNum
		InitData()

	} catch (e) {
		alert(e.message);
    }

</SCRIPT>
<SCRIPT FOR="window" EVENT="onunload" LANGUAGE="JavaScript">
	window.dialogArguments.pNum = pNum
	window.returnValue = result
</SCRIPT>
<SCRIPT LANGUAGE='JavaScript'>
function corpList(gID)
	{
	gID = 0				// �S�q��
	var aspObj = RSGetASPObject("bbsDB.asp")
	var cObj = aspObj.getCorpList(gID)
	var Tab = cObj.return_value
	return(Tab)
	}

function corpInit(Tab,corpName)
	{
	var n
	corpSEL.options.length = 1
	n = 1
	if( corpSEL.newValue != "" ){
		corpSEL.options[n] = new Option(corpSEL.newValue,"")
		corpSEL.options[n].style.color = "tomato"
		corpSEL.options[n].selected = ( corpSEL.newValue == corpName ? true : false )
		n++
		}
	corpSEL.options[n] = new Option("�����������@�q�於�쐬�@������������������������","�V�K")
	corpSEL.options[n].style.color = "cornflowerblue"
	n++
	for( var x in Tab ){
		corpSEL.options[n] = new Option(Tab[x],"")
		corpSEL.options[n].selected = ( Tab[x] == corpName ? true : false )
		n++
		}
	}
function inputCorp()
   {
   var Buff = new Object
	Buff["TITLE"] = "��Ж��ݒ�"
	Buff["HEAD"]  = "��Ж�����͂��Ă�������"
	Buff["VALUE"] = corpSEL.newValue
   var windowOption
   var value
   var posY = event.screenX - 100
   var posX = event.screenY - 20
   windowOption  = "dialogTop:" + posX + "px;dialogLeft:" + posY + "px;"
   windowOption += "dialogWidth:0px;dialogHeight:0px;"
   windowOption += "status:no;scroll:no;"
   value = window.showModalDialog("inputText.asp",Buff,windowOption)
	return(value)
   }


//================================================
function getKindList(kindName)
	{
	var aspObj = RSGetASPObject("bbsDB.asp")
	var cObj = aspObj.getKindList(kindName)
	var Tab = cObj.return_value
	return(Tab)
	}
function categoryInit(Tab,o_categorySEL,categoryName)
	{
	var n
	o_categorySEL.options.length = 1
	n = 1
	if( o_categorySEL.newValue != "" ){
		o_categorySEL.options[n] = new Option(o_categorySEL.newValue,"")
		o_categorySEL.options[n].style.color = "tomato"
		o_categorySEL.options[n].selected = ( o_categorySEL.newValue == categoryName ? true : false )
		n++
		}
	o_categorySEL.options[n] = new Option("�����������@�J�e�S���[���쐬�@������������������������","�V�K")
	o_categorySEL.options[n].style.color = "cornflowerblue"
	n++
	for( var x in Tab ){
		o_categorySEL.options[n] = new Option(Tab[x],"")
		o_categorySEL.options[n].selected = ( Tab[x] == categoryName ? true : false )
		n++
		}
	}
function inputCategory()
   {
   var Buff = new Object
	Buff["TITLE"] = "�J�e�S���[���ݒ�"
	Buff["HEAD"]  = "�J�e�S���[������͂��Ă�������"
	Buff["VALUE"] = categorySEL1.newValue
   var windowOption
   var value
   var posY = event.screenX - 100
   var posX = event.screenY - 20
   windowOption  = "dialogTop:" + posX + "px;dialogLeft:" + posY + "px;"
   windowOption += "dialogWidth:0px;dialogHeight:0px;"
   windowOption += "status:no;scroll:no;"
   value = window.showModalDialog("inputText.asp",Buff,windowOption)
	return(value)
   }


</SCRIPT>
<SCRIPT FOR="corpSEL" EVENT="onchange" LANGUAGE="JavaScript">
var selPos	 = this.selectedIndex
var value
if( this.options[selPos].value == "�V�K" ){
	value = inputCorp()
	if( value != "" ){
		this.newValue = value
		T0.value = value
		}
	corpInit(GrpSEL.Tab,T0.value)
	}
else if( selPos == 0 ){
	T0.value = ""
	}
else{
	T0.value = this.options[selPos].text
	}
</SCRIPT>
<SCRIPT FOR="categorySEL1" EVENT="onchange" LANGUAGE="JavaScript">
var selPos	 = this.selectedIndex
var value
if( this.options[selPos].value == "�V�K" ){
	value = inputCategory()
	if( value != "" ){
		this.newValue = value
		T_kindCategory1.value = value
		}
	categoryInit(CategoryTab1,this,T_kindCategory1.value)
	}
else if( selPos == 0 ){
	T_kindCategory1.value = ""
	}
else{
	T_kindCategory1.value = this.options[selPos].text
	}
</SCRIPT>

<SCRIPT FOR="categorySEL2" EVENT="onchange" LANGUAGE="JavaScript">
var selPos	 = this.selectedIndex
var value
if( this.options[selPos].value == "�V�K" ){
	value = inputCategory()
	if( value != "" ){
		this.newValue = value
		T_kindCategory2.value = value
		}
	categoryInit(CategoryTab2,this,T_kindCategory2.value)
	}
else if( selPos == 0 ){
	T_kindCategory2.value = ""
	}
else{
	T_kindCategory2.value = this.options[selPos].text
	}
</SCRIPT>

<SCRIPT FOR="kindSEL" EVENT="onchange" LANGUAGE="JavaScript">
var selPos = this.selectedIndex
T_kind.value   = this.options[selPos].value
</SCRIPT>
<SCRIPT FOR="kindNewSEL" EVENT="onchange" LANGUAGE="JavaScript">
var selPos = this.selectedIndex
T_kindNew.value   = this.options[selPos].value
</SCRIPT>

<SCRIPT FOR="fixLevelSEL" EVENT="onchange" LANGUAGE="JavaScript">
var selPos = this.selectedIndex
T_fixLevel.value   = this.options[selPos].value
</SCRIPT>


<SCRIPT FOR="GrpSEL" EVENT="onchange" LANGUAGE="JavaScript">
var selPos = this.selectedIndex
this.gID   = this.options[selPos].value
this.Tab   = corpList(this.gID)
corpInit(this.Tab,T0.value)

</SCRIPT>
<SCRIPT FOR="salesManSEL" EVENT="onchange" LANGUAGE="JavaScript">
var selPos = this.selectedIndex
T3.value   = this.options[selPos].text

</SCRIPT>

<SCRIPT LANGUAGE='JavaScript'>
function InitData()
	{
	var toDay = new Date()
	var yymm = (toDay.getFullYear() * 100) + (toDay.getMonth()+1)
	if( pNum == 0){
		// �f�[�^�������p���ō쐬
		var Tab = new Object
		Tab.Stat	 = 0
		Tab.pCode	 = 0
		Tab.pName	 = pName.value
		Tab.gID 	 = GrpSEL.gID
		Tab.corpName = T0.value
		Tab.Info1	 = T1.value
		Tab.Info2	 = T2.value
		Tab.Info3	 = T3.value
		Tab.Info4	 = T4.value
		Tab.Info5	 = T5.value
		Tab.Info6	 = T6.value


		Tab.kind          = T_kind.value
		Tab.kindNew       = T_kindNew.value
		Tab.kindCategory1 = T_kindCategory1.value
		Tab.kindCategory2 = T_kindCategory2.value
		Tab.fixLevel      = T_fixLevel.value


		Tab.Content  = escape(Content.value)							// ���s�R�[�h���܂܂�邽��
		Tab.makeDate = ""

		TitleName.innerHTML  =	"�V�K�v���W�F�N�g�쐬"			//"�v���W�F�N�g�R�[�h�쐬"
		TitleCode.innerHTML  = (makeYear() % 10) + "PJxxxx"
		TitleGuide.innerHTML = "�v���W�F�N�g���쐬���܂�".small().fontcolor("gray")

	  // �O���[�v�I���f�[�^�ݒ�
		groupBox.innerHTML = makeGrp("GrpSEL",Tab.gID,yymm)
		}
	else if(pNum == -1){
		// �V�K�쐬
		var aspObj = RSGetASPObject("bbsDB.asp")
		var cObj = aspObj.getProjectInfo(pNum)
		var Tab = cObj.return_value
		Tab.pName = unescape(Tab.pName)

		TitleName.innerHTML =	"�V�K�v���W�F�N�g�쐬"			//"�v���W�F�N�g�R�[�h�쐬"
		TitleCode.innerHTML = (makeYear() % 10) + "PJxxxx"
		TitleGuide.innerHTML = "�v���W�F�N�g���쐬���܂�".small().fontcolor("gray")
	  // �O���[�v�I���f�[�^�ݒ�
		groupBox.innerHTML = makeGrp("GrpSEL",Tab.gID,yymm)
		}
	else{
		// �f�[�^�X�V
		var aspObj = RSGetASPObject("bbsDB.asp")
		var cObj = aspObj.getProjectInfo(pNum)
		var Tab = cObj.return_value
		Tab.pName = unescape(Tab.pName)

		TitleName.innerHTML = "�v���W�F�N�g���e�C��"
		TitleCode.innerHTML = Tab.pCode
		TitleGuide.innerHTML = "<INPUT type='button' value='�V�K�쐬' ID='NEW' title='���e���p�����č쐬���܂�'>"
		groupBox.innerHTML = "<SPAN ID='GrpSEL' gID='" + Tab.gID + "' Tab=''></SPAN>" + Tab.gName
		}
	pName.value = Tab.pName
	T0.value = Tab.corpName
	T1.value = Tab.Info1
	T2.value = Tab.Info2
	T3.value = Tab.Info3
	T4.value = Tab.Info4
	T5.value = Tab.Info5
	T6.value = Tab.Info6

	T_kind.value          = Tab.kind
	T_kindNew.value       = Tab.kindNew
	T_kindCategory1.value = Tab.kindCategory1
	T_kindCategory2.value = Tab.kindCategory2
	T_fixLevel.value      = Tab.fixLevel
	Content.value = unescape(Tab.Content)							 // ���s�R�[�h���܂܂�邽��

	GrpSEL.Tab = corpList(Tab.gID)
	corpInit(GrpSEL.Tab,T0.value)

	CategoryTab1 = getKindList("�J�e�S���[��1")
	categoryInit(CategoryTab1,categorySEL1,T_kindCategory1.value)

	CategoryTab2 = getKindList("�J�e�S���[��2")
	categoryInit(CategoryTab2,categorySEL2,T_kindCategory2.value)

	T_fixLevel.innerHTML = makeKindSel("�m�x","fixLevelSEL",Tab.fixLevel)
	T_kindNew.innerHTML = makeKindSel("�V�K��","kindNewSEL",Tab.kindNew)
	T_kind.innerHTML = makeKindSel("���ޖ�","kindSEL",Tab.kind)

	// �c�ƒS���I�����X�g�{�b�N�X
	salesManBox.innerHTML = makeSalesMan(T3.value)

// �󋵐ݒ�
	var s = parseInt(Tab.Stat)
	var selNo
	switch(s){
		case 0:
			selNo = 0;				// ������
			break;	 
		case 1:
			selNo = 1;				// �J����
			break;	 
		case 4:
			selNo = 2;				// �J���I��
			break;	 
		case 5:
			selNo = 3;				// �I��
			break;	 
		case -1:
			selNo = 4;				// �v
			break;	 
		default:
			selNo = 0;				// ������
			break;	 
		}
	T_Stat[selNo].checked = true
	}


function makeKindSel(kindName,IDName,selName)
   {
   var aspObj = RSGetASPObject("bbsDB.asp")
   var cObj = aspObj.getKindList(kindName)
   var Tab	= cObj.return_value
   var Buff = ""
   var Code,Name
   Buff += "<SELECT ID='" + IDName + "'  style='width:100%'>"
   for(var n in Tab){
	  Name = Tab[n]
	  Buff += "<OPTION VALUE='" + Name + "'"
	  Buff += (Name == selName ? "selected" : "")
	  Buff += ">"
	  Buff += Name
	  Buff += "</OPTION>"
	  }
   Buff += "</SELECT>"
   return(Buff)
   }


function makeSalesMan(mName)
	{
//	var mName  = T3.value
	var aspObj = RSGetASPObject("bbsDB.asp")
	var cObj = aspObj.getMemberList("�c��",mName)
	var Tab  = cObj.return_value
	var Buff = ""
	Buff += "<SELECT id='salesManSEL' style='width:100%'>"
	Buff += "<OPTION value=''>�I�����Ă�������</OPTION>"
	var name,code
	for( var gID in Tab ){
		Buff += "<OPTGROUP label='" + Tab[gID].���O + "'>"
		for( var mID in Tab[gID].data ){
			name = Tab[gID].data[mID].���O
			mode = ( mName == name ? "selected" : "" )
			Buff += "<OPTION value='" + mID + "'" + mode + ">" + name
			Buff += "</OPTION>"
			}
		Buff += "</OPTGROUP>"
		}
	Buff += "</SELECT>"
	return(Buff)
	}
	
function makeGrp(IDName,gCode,yymm)
   {
   var aspObj = RSGetASPObject("bbsDB.asp")
   var cObj = aspObj.getGroupList(yymm)
   var Tab	= cObj.return_value

   var Buff = ""
   var Code,Name
   Buff += "<SELECT ID='" + IDName + "' gID='" + gCode + "' style='width:100%'>"
   Buff += "<OPTGROUP LABEL='�J���E�c��'>"
   for(var n in Tab){
	  Mode = Tab[n].mode
	  Code = Tab[n].code
	  Name = Tab[n].name
	  if( Mode == 2 ) continue;
	  Buff += "<OPTION VALUE='" + Code + "'"
	  Buff += (Code == gCode ? "selected" : "")
	  Buff += ">"
	  Buff += Name
	  }
   Buff += "</OPTGROUP>"
   Buff += "<OPTGROUP LABEL='�Ԑ�'>"
   for(var n in Tab){
	  Mode = Tab[n].mode
	  Code = Tab[n].code
	  Name = Tab[n].name
	  if( Mode != 2 ) continue;
	  Buff += "<OPTION VALUE='" + Code + "'"
	  Buff += (Code == gCode ? "selected" : "")
	  Buff += ">"
	  Buff += Name
	  }
   Buff += "</OPTGROUP>"
   Buff += "</SELECT>"
   return(Buff)
   }

function getGroupValue()
   {
   var value
   value = GrpSEL.options[GrpSEL.selectedIndex].value;
   return(value)
   }

function getStatValue()
   {

   var i,Obj
   Obj = T_Stat;
   for( i = 0; i < Obj.length; i++){
	  if(Obj[i].checked == true) return(Obj[i].value);
	  }
   }

function makeYear()
   {
   var toDay = new Date()
   var yy = toDay.getFullYear()
   var mm = toDay.getMonth()+1
   var Year
//	 Year = ( mm <= 3 ? yy - 1 : yy )
   Year = yy									// ���̔N���g�p
   return(Year)
   }

</SCRIPT>
<SCRIPT FOR='regist' EVENT='onclick()' LANGUAGE='JavaScript'>
	var P_pNum,P_pName,P_corpName,P_Title,P_Content,P_Stat,P_gID,P_Kind,P_salesManID

/*	
alert("�q�於�F"+T0.value)
alert("�q�敔�����F"+T1.value)
alert("�q��S���ҁF"+T2.value)
alert("�c�ƒS���ҁF"+T3.value)
alert("�J�����ԁF"+T4.value)
alert("�J���K�́F"+T5.value)
alert("�J���ꏊ�F"+T6.value)
*/

	var Work = new Array(T0.value,T1.value,T2.value,T3.value,T4.value,T5.value,T6.value);
	P_Title    = escape(Work.join("\n"));
	P_Content  = escape(Content.value)
	P_corpName = RTrim(corpSEL.options[corpSEL.selectedIndex].text)
	P_pNum	   = pNum
	P_pName    = RTrim(pName.value)
	P_Stat	   = getStatValue()


	P_kind          = T_kind.value
	P_kindNew       = T_kindNew.value
	P_kindCategory1 = T_kindCategory1.value
	P_kindCategory2 = T_kindCategory2.value
	P_fixLevel      = T_fixLevel.value

	P_salesManID = salesManSEL.options[salesManSEL.selectedIndex].value
	if(pNum <= 0){
		P_gID = getGroupValue() 				   // �V�K�쐬�̂Ƃ�
		}


	var Buff = []
	if( P_pName.length == 0 ) Buff.push("�v���W�F�N�g��")
	if( P_corpName.length == 0 ) Buff.push("�q�於")
	if( T3.value.length == 0 ) Buff.push("�c�ƒS����")
	if( P_Content.length == 0 ) Buff.push("�Ɩ����e")
	if( Buff.length > 0 ){
		alert("���L�̍��ڂ�ݒ肵�Ă�������\n\n" + "[" + Buff.join("]\n[") + "]")
		return
		}
	var cObj
	var aspObj = RSGetASPObject("bbsDB.asp")

	if(P_pNum > 0){
		cObj = aspObj.bbsEditList(P_pNum
								,P_pName
								,P_corpName
								,P_Title
								,P_Content
								,P_Stat
								,P_salesManID
								,P_kind
								,P_kindNew
								,P_kindCategory1
								,P_kindCategory2
								,P_fixLevel)
		}
	else{
		cObj = aspObj.bbsAddList(-1
								,P_pName
								,P_corpName
								,P_Title
								,P_Content
								,P_Stat
								,P_salesManID
								,P_gID
								,P_kind
								,P_kindNew
								,P_kindCategory1
								,P_kindCategory2
								,P_fixLevel)
		}
	if(cObj.status == 0){
		pNum = cObj.return_value
		result = true
		window.close()
		}
	else{
		result = false
		alert("�s���ȕ������܂܂�邩�A���͂��ꂽ�����̍��v����������\n\n�o�^�ł��܂���ł����B")
//		alert("�o�^�ł��܂���ł���(SSL-VPN�o�R�ł͓o�^�ł��܂���)�B")
//		alert("�o�^�ł��܂���ł����B")
		}
</SCRIPT>
<SCRIPT FOR='reset' EVENT='onclick()' LANGUAGE='JavaScript'>
InitData()
</SCRIPT>
<SCRIPT FOR='exit' EVENT='onclick()' LANGUAGE='JavaScript'>
window.close()
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript" src="cmn.js"></SCRIPT>
<SCRIPT LANGUAGE="VBScript" src="cmn.vbs"></SCRIPT>

<!--
<SCRIPT LANGUAGE="JavaScript" src="/_ScriptLibrary/RS_AJAX.Js"></SCRIPT>
-->
<SCRIPT LANGUAGE="JavaScript" src="/_ScriptLibrary/RS.Js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">RSEnableRemoteScripting("/_ScriptLibrary")</SCRIPT>
<!-- �����܂� -->
