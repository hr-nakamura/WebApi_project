<%@ Language=JScript %>
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/json.inc"-->

<%

	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false
	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)

    var root = xmlDoc.createElement("root");
    xmlDoc.appendChild(root);


    var xTab = { î•ñ  : {"@year": 2022,
						  "@fix":70,
						  "@actual":7
						 }
			  };
			  
    Json2Xml(root,xTab);




	Response.CharSet	 = "SHIFT_JIS"
    Response.AddHeader("Access-Control-Allow-Origin", "*");
	Response.ContentType = "text/xml"
	xmlDoc.save(Response)


	
	Response.End();
	
    function Json2Xml(node, obj) {
        try {
            var xmlDoc = node.ownerDocument;
            var new_node, text, attr_name;
            for (var prop in obj) {
                if (obj[prop] instanceof Array) {
                    for (var array in obj[prop]) {
                        //new_node = xmlDoc.createElement(prop);
                        //node.appendChild(new_node);
                        //Json2Xml(new_node, new Object(obj[prop][array]));
                    }
                }
                else if (typeof obj[prop] == "object") {
                    new_node = xmlDoc.createElement(prop);
                    node.appendChild(new_node);
                    Json2Xml(new_node, new Object(obj[prop]));
                }
                else if (prop.indexOf('@') == 0) {
                    attr_name = prop.slice(1)
                    node.setAttribute(attr_name, obj[prop]);
                }
                else {
                    nodeName = prop;
                    new_node = xmlDoc.createElement(nodeName);
                    var text = xmlDoc.createTextNode(obj[prop]);
                    new_node.appendChild(text);
                    node.appendChild(new_node);

                }
            }

        } catch (e) {
            pr_p("ERROR", e.message)
        }
    }

%>
