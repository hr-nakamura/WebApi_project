<%

function $queryInfoCheck(Info)
	{
	var Tab = $getInfo(Request.QueryString);										// 送られた情報を取得
	delete Tab["queryChk"];
	for( var key in Tab ) Info[key] = Tab[key];
	if( Request.QueryString("queryChk").Count == 1 ){
		Info["queryString"] = Tab;
		Info["queryString"]["target_url"] = String(Request.ServerVariables("URL"));
		$JsonOut(Info);
		}
	return(Info);
	}
function $getInfo(target) {
	var Tab = {};
	var e = new Enumerator(target);
	e.moveFirst();
	while (e.atEnd() == false) {
		var key = e.item();
		Tab[key] = target(key) + "";
		e.moveNext();
		}
	return (Tab);
	}

function $stopWatch()
	{
	this.Buff = [];
	this.Work = [];
	this.check = function(msg){
		this.Buff.push({time:new Date(),msg:msg});
	}
	this.disp = function(msg){
		this.Buff.push({time:new Date(),msg:msg});
		for( var i = 0; i < this.Buff.length; i++){
			if( i > 0 ){	
				var tm = this.Buff[i].time - this.Buff[i-1].time;
				this.Work.push(('00' + Math.floor(tm / 1000)).slice(-2) + "." + ('000' + Math.round(tm % 1000)).slice(-3) + " : " + this.Buff[i-1].msg);
				}
			}
		var tm = this.Buff[this.Buff.length-1].time - this.Buff[0].time;
		this.Work.push(('00' + Math.floor(tm / 1000)).slice(-2) + "." + ('000' + Math.round(tm % 1000)).slice(-3) + " : " + "Total Time");
		return("\n" + this.Work.join("\n"));
		}
	return(this);
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
