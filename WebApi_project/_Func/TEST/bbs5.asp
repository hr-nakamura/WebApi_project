<%@ Language=JScript %>
<!--#include file="cmn.inc"-->

<%
//<!--#include virtual="/Project/Auth/projectLog.inc"-->
%>
<%
// 引合情報用
   Session("visitBBS")	= readCookies("visitBBS");
   if(IsEmpty(session("visitBBS"))) Session("visitBBS") = new Date("1999/1/1");

   writeCookies("visitBBS",Date());
	Session("memberID") = 451862;
%>

<%
//----- 掲示板のNEWを出す日を設定----------------------------
var visitDay = new Date(session("visitBBS"));
var vDate = DateAdd( "n", -10, convertDateTime(visitDay) );
visitDay = new Date(vDate);

//----- 掲示板のNEWを出す日を設定----------------------------
var beforDay = new Date();
var bDate = DateAdd( "d", -7, convertDateTime(beforDay));
beforDay= new Date(bDate);
beforDay.setHours(0);
beforDay.setMinutes(0);
beforDay.setSeconds(0);
//------ 日付を合わす　---------------------------
if(visitDay < beforDay) visitDay = beforDay;
//---------------------------------
Session("visitBBS") = visitDay.toString();
Session("beforBBS") = beforDay.toString();
Session("dispMode") = "更新";

bc = Server.CreateObject("MSWC.BrowserType");
var browser = bc.browser;
var version = bc.version;
%>

<html>

<head>
<META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
<META http-equiv="X-UA-Compatible" content="IE=5" />

<title>プロジェクト引合状況</title>
</head>
  <frameset NAME="frmSet"  rows="100%,0">
	<frame NAME="bbsMain" SRC="bbsMain5.asp" scrolling="auto" >
  </frameset>

  <noframes>
  <body>
  <p>このページはフレームに対応したブラウザでのみアクセスできます。</p>
  </body>
  </noframes>

</frameset>

</html>
