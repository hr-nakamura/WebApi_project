<%
function $queryInfoCheck(Info)
	{
	var queryData = queryString2Json();
	for( var key in queryData ) Info[key] = queryData[key];
	if( Request.QueryString("queryChk").Count == 1 ){
		delete Info["queryChk"];
		Info["url"] = "http://" + String(Request.ServerVariables("SERVER_NAME")) + String(Request.ServerVariables("URL"));
		Info["queryString"] = String(Request.ServerVariables("QUERY_STRING"));
		$JsonOut(Info);
		}
	return(Info);
	}

//	*必須* 	var xmlDoc = Server.CreateObject("MSXML2.DOMDocument.6.0")

function $attachInfo(node,jsonTab)
	{

	var xmlDocWork = node.ownerDocument;
    var root = xmlDocWork.createElement("root");

    $Json2Xml(root,jsonTab);

    var Info = root.firstChild;

    var new_node = xmlDocWork.importNode(Info,true);

	node.insertBefore(new_node,node.firstChild)
	}


 function $Json2Xml(node, obj) {
        try {
            var xmlDoc = node.ownerDocument;
            var new_node, text, attr_name;
            for (var prop in obj) {
                if (obj[prop] instanceof Array) {
                    for (var array in obj[prop]) {
                        //new_node = xmlDoc.createElement(prop);
                        //node.appendChild(new_node);
                        //$Json2Xml(new_node, new Object(obj[prop][array]));
                    }
                }
                else if (typeof obj[prop] == "object") {
                    new_node = xmlDoc.createElement(prop);
                    node.appendChild(new_node);
                    $Json2Xml(new_node, new Object(obj[prop]));
                }
                else if (prop.indexOf('@') == 0) {
                    attr_name = prop.slice(1)
						  var value = (typeof(obj[prop]) =="undefined" ? "" : obj[prop]);
                    node.setAttribute(attr_name, value);
                }
                else {
                    nodeName = prop;
                    new_node = xmlDoc.createElement(nodeName);
 						  var value = (typeof(obj[prop]) == "undefined" ? "" : obj[prop]);
                    var text = xmlDoc.createTextNode(value);
                    new_node.appendChild(text);
                    node.appendChild(new_node);

                }
            }

        } catch (e) {
            Response.Write(e.message)
        }
    }

%>
<script Language="JScript" RUNAT="Server">
function queryString2Json()
	{
	var Tab = getQueryInfo();
	var json = {};
	for( var i = 0; i < Tab.Count; i++){
		var work = Tab(i).split("＠");
		var key   = work[0];
		var value = work[1];
		json[key] = value
		}
	return(json);
}

</script>

<script Language="VBScript" RUNAT="Server">
Function getQueryInfo()
	Dim array
	Set array = CreateObject("System.Collections.ArrayList")
	Dim myDictionary
	Set myDictionary = CreateObject("Scripting.Dictionary")
	Dim work
	For Each Key In Request.QueryString
		' 配列から取得した値を表示
      If Not IsNULL(Request.QueryString(key)) Then
			array.add( key & "＠" & Request.QueryString(key) )
		End If
	Next
	array.Sort
	Set getQueryInfo = array
End Function
</script>
