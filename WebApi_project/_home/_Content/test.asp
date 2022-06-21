<%@ Language=JScript %>
<!--#include file="inc/cmn.inc"-->
<!--#include file="inc/json.inc"-->
<%
	var execStr = "";
	var func = "";
	var Info = {};
	var para = [];
	var cmd = [];
	var work = String(Request.QueryString()).split("&"); 
	for( var i in work ){
		var buff = work[i].split("=");
		if( i == 0 ) func = buff[1];
		else{
			para.push(buff[1]);
			cmd.push("para[" + (i-1) + "]")			
			}
		}

	execStr = func + "(" + cmd.join(",") + ")";

//pr(execStr)
	var Tab = eval(execStr);


	$JsonOut(Tab);

function xxxx(para1,para2,para3)
	{
	var Tab = {
		p1:para1,
		p2:para2,
		p3:para3
		}
	return(Tab)
	}



%>
