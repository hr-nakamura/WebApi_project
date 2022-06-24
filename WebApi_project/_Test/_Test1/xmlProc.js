function xmlProc()
	{
	this.loadXML = function(xmlDoc,xml,execFunc)
		{
		xmlDoc = new ActiveXObject("Microsoft.XMLDom");

		// ”ñ“¯Šú‚É‚·‚é
		xmlDoc.async = true;
		xmlDoc.onreadystatechange = function (){
			if( xmlDoc.readyState == 4 ){
//				var Buff = xmlDoc.xml
				execFunc(xmlDoc);
				}
			}
		var ret = xmlDoc.load(xml);
		},
	this.transfor = function(xmlDoc,xsl,execFunc)
		{
		var xslDoc = new ActiveXObject("Microsoft.XMLDom");
		// ”ñ“¯Šú‚É‚·‚é
		xslDoc.async = true;
		var ret = xslDoc.load(xsl);
		xslDoc.onreadystatechange = function (){
			if( xslDoc.readyState == 4 ){
				var Buff = xmlDoc.transformNode(xslDoc)
				execFunc(Buff)
				}
			}
		}
	return(this)
	}
