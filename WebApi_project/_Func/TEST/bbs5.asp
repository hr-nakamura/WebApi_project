<%@ Language=JScript %>
<!--#include file="cmn.inc"-->

<%
//<!--#include virtual="/Project/Auth/projectLog.inc"-->
%>
<%
// �������p
   Session("visitBBS")	= readCookies("visitBBS");
   if(IsEmpty(session("visitBBS"))) Session("visitBBS") = new Date("1999/1/1");

   writeCookies("visitBBS",Date());
	Session("memberID") = 451862;
%>

<%
//----- �f����NEW���o������ݒ�----------------------------
var visitDay = new Date(session("visitBBS"));
var vDate = DateAdd( "n", -10, convertDateTime(visitDay) );
visitDay = new Date(vDate);

//----- �f����NEW���o������ݒ�----------------------------
var beforDay = new Date();
var bDate = DateAdd( "d", -7, convertDateTime(beforDay));
beforDay= new Date(bDate);
beforDay.setHours(0);
beforDay.setMinutes(0);
beforDay.setSeconds(0);
//------ ���t�����킷�@---------------------------
if(visitDay < beforDay) visitDay = beforDay;
//---------------------------------
Session("visitBBS") = visitDay.toString();
Session("beforBBS") = beforDay.toString();
Session("dispMode") = "�X�V";

bc = Server.CreateObject("MSWC.BrowserType");
var browser = bc.browser;
var version = bc.version;
%>

<html>

<head>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

<title>�v���W�F�N�g������</title>
</head>
  <frameset NAME="frmSet"  rows="100%,0">
	<frame NAME="bbsMain" SRC="bbsMain5.asp" scrolling="auto" >
  </frameset>

  <noframes>
  <body>
  <p>���̃y�[�W�̓t���[���ɑΉ������u���E�U�ł̂݃A�N�Z�X�ł��܂��B</p>
  </body>
  </noframes>

</frameset>

</html>
