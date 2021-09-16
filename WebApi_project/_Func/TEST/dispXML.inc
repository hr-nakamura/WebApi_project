<%

function procTime(Title)
	{
	this.Title = ( String(Title) == "undefined" ? "時間測定" : Title )
	this.aTime = new Array()
	this.aTime[this.aTime.length] = {Item:"開始",Time:new Date()}
	return(this)
	}
procTime.prototype.check = function(str){
	this.aTime[this.aTime.length] = {Item:str,Time:new Date()}
	return
	}
procTime.prototype.disp = function(){
	var Buff
	for( var x = 0 ; x < this.aTime.length - 1; x++ ){
		Buff = this.Title + ":"
		Buff += "[ " + formatNum((this.aTime[x+1].Time - this.aTime[x].Time)/1000,3) + " 秒 ]"
//		Buff += "[ " + this.aTime[x].Item + " - "
		Buff += "[ " + this.aTime[x+1].Item + " ]　"
		Response.Write(Buff + "<BR>")
		}
	Buff = this.Title + ":"
	Buff += "[ " + formatNum((this.aTime[x].Time - this.aTime[0].Time)/1000,3) + " 秒 ]"
	Buff += "[ ※合計時間※ ]"
	Response.Write(Buff + "<BR>")
	}
procTime.prototype.message = function(){
	var CRLF = "\n"
	var Buff = ""
	var TitleBuff = ""
	for( var x = 0 ; x < this.aTime.length - 1; x++ ){
		Buff += "[ " + formatNum((this.aTime[x+1].Time - this.aTime[x].Time)/1000,3) + " 秒 ]"
//		Buff += "[ " + this.aTime[x].Item + " - "
		Buff += "[ " + this.aTime[x+1].Item + " ]　"
		Buff += CRLF
		}
	TitleBuff = CRLF + this.Title + ":" + CRLF
	TitleBuff += "[ " + formatNum((this.aTime[x].Time - this.aTime[0].Time)/1000,3) + " 秒 ]"
	TitleBuff += "[ ※合計時間※ ]" + CRLF
/*
	var x = this.aTime.length-1
	var Buff = ""
	Buff += "[ " + formatNum((this.aTime[x].Time - this.aTime[0].Time)/1000,3) + " 秒 ]"
	Buff += "[ ※合計時間※ ]"
*/
	return(TitleBuff + Buff)
	}

function dispXML(Title,Tab)
	{
	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false

	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)

	var ext = Title.split(".")
	if( ext.length > 1 && ext[1] == "xsl" ){
		var main2 = xmlDoc.createProcessingInstruction("xml-stylesheet", "type='text/xsl' href='" + Title + "'") 
		xmlDoc.appendChild(main2)
		}

	if( Title != "" ){
		var commnt = xmlDoc.createComment(Title)
		}
	else{
		var commnt = xmlDoc.createComment("XMLデータ")
		}
	xmlDoc.appendChild(commnt)

	var rootNode = xmlDoc.createElement("root")
	xmlDoc.appendChild(rootNode)

	dispXML_makeElement(xmlDoc,rootNode,Tab)

	Response.CharSet     = "SHIFT_JIS"
	Response.ContentType = "text/xml"
	xmlDoc.save(Response)

	Response.End()
//	return(xmlDoc)
	}

function saveXML(fName,Tab)
	{
	var xmlDoc = Server.CreateObject("Microsoft.XMLDom")
	xmlDoc.async=false

	var main1 = xmlDoc.createProcessingInstruction("xml", "version='1.0' encoding='Shift_JIS'")
	xmlDoc.appendChild(main1)

	if( fName != "" ){
		var fileName = Server.MapPath(fName)
		}
	else{
		var fileName = Server.MapPath("saveXML.xml")
		}

	var rootNode = xmlDoc.createElement("root")
	xmlDoc.appendChild(rootNode)

	dispXML_makeElement(xmlDoc,rootNode,Tab)

	Response.CharSet     = "SHIFT_JIS"
	Response.ContentType = "text/xml"
	xmlDoc.save(fileName)

	}

function dispXML_makeElement(xmlDoc,parentNode,Tab)
	{
try{
	if( "["+typeof(Tab.length)+"]" != "[number]" ){
//	if( isNaN(""+(Tab.length)+"") ){
		// Objectの時
		for( var eName in Tab ){
//			var Node = xmlDoc.createElement("o")
//X			var Text = xmlDoc.createTextNode(Tab[eName])
//			Node.setAttribute("type","O")
			var Node = xmlDoc.createElement("O")
			Node.setAttribute("name",eName)				// オブジェクト名

			parentNode.appendChild(Node)
			if( typeof(Tab[eName]) == "object" ){
				dispXML_makeElement(xmlDoc,Node,Tab[eName])
				}
			else if( typeof(Tab[eName]) == "undefined" ){
//X				Node.text = ""
				}
			else{
				Node.text = Tab[eName]
//X				Node.appendChild(Text)
				}

			}
		}
	else{
		// Arrayの時
		for( var n = 0; n < Tab.length; n++ ){
//			var Node = xmlDoc.createElement("o")
//X			var Text = xmlDoc.createTextNode(Tab[n])
//			Node.setAttribute("type","A")
			var Node = xmlDoc.createElement("A")
			Node.setAttribute("pos",n)					// 配列番号

			parentNode.appendChild(Node)
			if( typeof(Tab[n]) == "object" ){
				dispXML_makeElement(xmlDoc,Node,Tab[n])
				}
			else if( typeof(Tab[n]) == "undefined" ){
//X				Node.text = ""
				}
			else{
				Node.text = Tab[n]
//X				Node.appendChild(Text)
				}
			}
		}	
	return
	}catch(e){
		EMGLog.Write("dispXML.txt",e.message)
		}
	}

%>
