<%@ Language=JScript %>
<!--#include virtual="/Project/inc/cmn.inc"-->
<!--#include virtual="/Project/inc/json.inc"-->

<%

	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false
	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)




    var xTab = { 情報  : {"@year": 2022,
						  "@fix":70,
						  "@actual":7
						 }
			  };
			  
//var output = eval("OBJtoXML("+xTab+");")
var xmlStr = OBJtoXML(xTab);


xmlDoc.loadXML("<?xml version='1.0' encoding='Shift_JIS'?><root>" + xmlStr + "</root>");


	Response.CharSet	 = "SHIFT_JIS"
    Response.AddHeader("Access-Control-Allow-Origin", "*");
	Response.ContentType = "text/xml"
	xmlDoc.save(Response)


	
	Response.End();
	


	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false
	
	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)

	var main2 = xmlDoc.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='../xsl/GRP_リスト_Select.xsl'") 
//	xmlDoc.appendChild(main2)

	var commnt = xmlDoc.createComment(xmlStr)
	xmlDoc.appendChild(commnt)

	var rootNode = xmlDoc.createElement("root")
	xmlDoc.appendChild(rootNode)
	var kindNode = xmlDoc.createElement("情報")
	rootNode.appendChild(kindNode)
//	kindNode.text(xmlStr);
//pr(xmlDoc.xml)


pr(xmlDoc.xml);
/*
	Response.CharSet	 = "SHIFT_JIS"
    Response.AddHeader("Access-Control-Allow-Origin", "*");
	Response.ContentType = "text/xml"
	xmlDoc.save(Response)
*/	
function jj(Tab)
	{
	for( var name in Tab ){
		pr_p(name,Tab[name])
		if( typeof(Tab[name]) == "object"){
			jj(Tab[name])
			}
		}
	}
        

function OBJtoXML(obj) {
	try{
    var xml = '';
    var nodeName = "";
    for (var prop in obj) {
		if(prop.indexOf('@') == 0){
			nodeName = prop.slice(1)
		}
		else{
			nodeName = prop;
		}
        xml += "<" + nodeName + ">";
        if(obj[prop] instanceof Array) {
            for (var array in obj[prop]) {
                xml += OBJtoXML(new Object(obj[prop][array]));
            }
        } else if (typeof obj[prop] == "object") {
            xml += OBJtoXML(new Object(obj[prop]));
        } else {
            xml += obj[prop];			// 内容
        }
        xml += "</" + nodeName + ">";
    }
    var xml = xml.replace(/<\/?[0-9]{1,}>/g,'');
    
}catch(e){
	pr_p("ERROR",e.message)
	}
    return (xml)
}
function OBJtoXML_XX(obj) {
	try{
    var xml = '';
    for (var prop in obj) {
        xml += "<" + prop + ">";
        if(obj[prop] instanceof Array) {
            for (var array in obj[prop]) {
                xml += OBJtoXML(new Object(obj[prop][array]));
            }
        } else if (typeof obj[prop] == "object") {
            xml += OBJtoXML(new Object(obj[prop]));
        } else {
            xml += obj[prop];
        }
        xml += "</" + prop + ">";
    }
    var xml = xml.replace(/<\/?[0-9]{1,}>/g,'');
    
}catch(e){
	pr_p("ERROR",e.message)
	}
    return (xml)
}
%>
