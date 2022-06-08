<%@ Language=JavaScript %>
<%
    var xmlDoc = Server.CreateObject("MSXML2.DOMDocument.6.0")
    xmlDoc.async = false

    var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
    xmlDoc.appendChild(main1)

    var commnt = xmlDoc.createComment("指定期間の所属データ")
    xmlDoc.appendChild(commnt)

    var commnt = xmlDoc.createComment(dispCmd)
    xmlDoc.appendChild(commnt)

    var commnt = xmlDoc.createComment(work2)
    xmlDoc.appendChild(commnt)




    //	var root = xmlDoc.selectSingleNode("root");
    //	$attachInfo(root,WorkTab);


    Response.CharSet = "SHIFT_JIS"
    Response.AddHeader("Access-Control-Allow-Origin", "*");
    Response.ContentType = "text/xml"
    xmlDoc.save(Response)
%>
<%

    function $queryInfoCheck(Info) {
        for (var key in Info) {
            if (Request.QueryString(key).Count == 1) Info[key] = Request.QueryString(key).Item;
            if (Request.QueryString("queryChk").Count == 1) {
                $JsonOut(Info);
            }
        }
        return (Info);
    }


    //	*必須* 	var xmlDoc = Server.CreateObject("MSXML2.DOMDocument.6.0")

    function $attachInfo(node, jsonTab) {

        var xmlDocWork = node.ownerDocument;
        var root = xmlDocWork.createElement("root");

        $Json2Xml(root, jsonTab);

        var Info = root.firstChild;

        var new_node = xmlDocWork.importNode(Info, true);

        node.insertBefore(new_node, node.firstChild)
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
                    var value = (typeof (obj[prop]) == "undefined" ? "" : obj[prop]);
                    node.setAttribute(attr_name, value);
                }
                else {
                    nodeName = prop;
                    new_node = xmlDoc.createElement(nodeName);
                    //							var value = (typeof(obj[prop]) == "undefined" ? "" : obj[prop]);
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

