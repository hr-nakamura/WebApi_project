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

    var Tab1 = getInfo(Session.Contents)
    var Tab2 = getInfo(Request.ServerVariables)
    Json["Session"] = {};
    Json["ServerVariables"] = {};

    for (var key in Tab1) {
        Json["Session"][key] = Tab1[key];
    }


    for (var key in Tab2) {
        Json["ServerVariables"][key] = Tab2[key];
    }


    $JsonOut(Json);
    Response.End


    function getInfo(target) {
        var Tab = {};
        var e = new Enumerator(target);
        e.moveFirst();
        while (e.atEnd() == false) {
            var key = e.item();
            Tab[key] = target(key) + "";
            e.moveNext();
        }
        return (Tab);
    }

%>