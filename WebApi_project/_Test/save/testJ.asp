<%@ Language=JScript %>
<!--#include file="inc/cmn.inc"-->
<!--#include file="inc/Jcmn.inc"-->
<!--#include file="inc/json.inc"-->

<%
EMGLog.Write("a.txt","ABCDEF");

    var queryInfo = {
		"year"        : 2022,
		"dispMode"    : "‰Û",
		"secMode"     : "ŠJ”­",
		"actual"      : "123"
		}
	$queryInfoCheck(queryInfo);


    $JsonOut(queryInfo);
    Response.End

%>
