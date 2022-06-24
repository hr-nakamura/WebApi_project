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
function createElem(target_elem, elem_name, Tab) {
    for (var i in Tab) {
        var elem = document.createElement("div");
        elem.setAttribute("class", elem_name);
        elem.setAttribute("name", Tab[i]);
        elem.setAttribute("xmlDoc", {});
        elem.innerText = "data:" + Tab[i];
        var target = document.getElementById(target_elem);
        target.appendChild(elem);
    }

}
function deleteElem(elem_name) {
    do {
        var elems = document.getElementsByClassName(elem_name);
        for (var i = 0; i < elems.length; i++) {
            var e = elems[0];
            e.parentNode.removeChild(e);
        }
    } while (elems.length > 0);
}
function eventStart(elem_name, xml_name, xsl_name) {
    var elems = document.getElementsByClassName(elem_name);
    for (var i = 0; i < elems.length; i++) {
        elems[i].addEventListener('myEvent', function (event) {
            //alert('buttonB:' + event.isTrusted);
            var name = this.getAttribute("name");
            var xmlDoc = this.getAttribute("xmlDoc");
            xmlDoc = new ActiveXObject("Microsoft.XMLDom");
            xmlDoc.async = false;
            var ret = xmlDoc.load(xml_name);

            var xslDoc = new ActiveXObject("Microsoft.XMLDom");
            xslDoc.async = false;
            var ret = xslDoc.load(xsl_name);
            var Buff = xmlDoc.transformNode(xslDoc)
            this.innerHTML = Buff;
        });
        var evt = document.createEvent('MouseEvents');
        evt.initEvent('myEvent', false, true);
        elems[i].dispatchEvent(evt);
    }
}
