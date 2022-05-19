<%@ Language="JavaScript" %>
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/Json.inc"-->

<%
    var sessionName = Request.QueryString("session");

    sessionName += "";
    var Tab = sessionName.split(',');

    var Json = {};
    for (var i = 0; i < Tab.length; i++) {
        Json[Tab[i]] = Session(Tab[i]);
    }

    Json["http_host"] = "[" + Request.ServerVariables("HTTP_HOST") + "]";
    Json["server_name"] = "[" + Request.ServerVariables("SERVER_NAME") + "]";
    Json["local_addr"] = "[" + Request.ServerVariables("LOCAL_ADDR") + "]";
    Json["remote_addr"] = "[" + Request.ServerVariables("REMOTE_ADDR") + "]";

    $JsonOut(Json);
    Response.End
%>
