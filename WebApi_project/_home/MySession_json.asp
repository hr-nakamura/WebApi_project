<%@ Language="JavaScript" %>
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/Json.inc"-->

<%
	var sessionName = Request.QueryString("session");
	
    sessionName += "";
    var Tab = sessionName.split(',');
	
	var Json = {};
	for( var i = 0; i < Tab.length; i++){
		Json[Tab[i]] = Session(Tab[i]);
		}
		
      
	$JsonOut(Json);
	Response.End
%>
