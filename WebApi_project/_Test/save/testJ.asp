<%@ Language=JScript %>
<!--#include file="inc/cmn.inc"-->
<!--#include file="inc/Jcmn.inc"-->
<!--#include file="inc/json.inc"-->

<%
    var queryInfo = {
		"year"        : 2022,
		"dispMode"    : "��",
		"secMode"     : "�J��",
		"actual"      : "123"
		}
	queryInfo = $queryInfoCheck(queryInfo);

    $JsonOut(queryInfo);
    Response.End


%>

