function xmlProc()
	{
	this.loadXML = function(xmlDoc,xml,execFunc)
		{
		xmlDoc = new ActiveXObject("Microsoft.XMLDom");

		// 非同期にする
		xmlDoc.async = false;
		xmlDoc.onreadystatechange = function (){
			//alert(xmlDoc.readyState);
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
		// 非同期にする
		xslDoc.async = false;
		xslDoc.onreadystatechange = function () {
			//alert(xslDoc.readyState);
			if( xslDoc.readyState == 4 ){
				var Buff = xmlDoc.transformNode(xslDoc)
				execFunc(Buff)
				}
			}
		var ret = xslDoc.load(xsl);
		}
	return(this)
	}
