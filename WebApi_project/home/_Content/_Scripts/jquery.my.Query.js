    //===================================================================
; (function ($) {
    //$(window).on("ready", function () {
    //    var o = $.window.history;
    //    $.debug("onready (jquery.my.Query.js)", o.length);
    //    if (typeof (o[0].elem.key_F5) != "undefined") o[0].elem.key_F5 = null;

    //    window.focus();
    //});
    //$(document).keydown(function (event) {
    //    // クリックされたキーのコード
    //    var keyCode = event.keyCode;
    //    if (keyCode == 116) {
    //        var o = $.window.history;
    //        var o_top = o[0].elem;
    //        var o_cur = o[o.length-1].elem;
    //        $.debug(o_cur.location.pathname + "でF5が押されました",o.length);
    //        if (typeof (o_top.key_F5) == "object") o_top.key_F5 = "F5";
    //        //return false;
    //    }
    //});
})(jQuery);

; (function ($) {
        $.alert = function () {
            var work = [];
            var Cnt = arguments.length;
            for (var i = 0; i < Cnt; i++) {
                work.push(arguments[i]);
            }
            alert(work.join("\n"));
            return (this);
        },
            $.fn.alertB = function () {
                var work = $(this);
                $.each(work, function (i, o) {
                    $.alert(i, o.nodeValue, o.nodeName, o.textContent);
                });

                //alert($.xml2Str(work));
                return (this);
            },
            $.wait = function (msec) {
                // Deferredのインスタンスを作成
                var d = new $.Deferred;
                setTimeout(function () {
                    // 指定時間経過後にresolveしてdeferredを解決する
                    d.resolve(msec);
                }, msec);
                return d.promise();
            },
            $.xml2str = function (xmlNode) {
                var xmlString = "";
                var browser = $.getBrowser();
                try {
                    if (browser == "msie") {
                        //var xmlText = xmlNode.xml;
                        //var domP = new DOMParser();
                        //xmlNode = domP.parseFromString(xmlText, "text/xml");
                        xmlString = xmlNode.xml;
                    }
                    else {
                        xmlString = (new XMLSerializer()).serializeToString(xmlNode);
                        xmlString = xmlString.replace(/<\?xml .*\?>/gm, "");        // Crhomeのとき<?xmlを削除する
                    }
                    return (xmlString);
                } catch (e) {
                    alert('Xmlserializer not supported');
                    return false;
                }
            },
            $.str2xml = function (xmlText) {
                var xmlDoc = null;
                try {
                    xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlText);
                    return xmlDoc;
                } catch (e) {
                    try {
                        var parser = new DOMParser();
                        xmlDoc = parser.parseFromString(xmlText, "text/xml");
                        return xmlDoc;
                    } catch (e) {
                        $.debug("loadXMLText", e.message);
                    }
                }
            },
            $.call_hostProc = function(options, xmlDoc) {
                var Buff = {};
                for (var name in options) {
                    Buff[name] = options[name];
                }
                if ($.isXMLDoc(xmlDoc)) {
                    var xmlString = $.xml2str(xmlDoc);
                    //var work = xmlString.replace(/[+]/g, "╋");          // 「+」を誤変換するのでいったん「╋」に変換する
                    //Buff["xmlDoc"] = escape(work);
                    var work = encodeURIComponent(xmlString);               // escapeでは[+]が変換されないので
                    Buff["xmlDoc"] = work;
                }
                var url = "/Project/hostProc/Entry.ashx";
                var result = $.ajax({
                    url: url,
                    type: "POST",
                    dataType: 'text',
                    data: Buff,
                    async: false,
                    success: function (data) {
                    },
                    error: function (data) {
                        $.debug("$.call_hostProc:", data.statusText);
                        $.alert("$.call_hostProc:",Buff["class"],Buff["func"]);
                    }
                });
            var xmlDoc_return = $.str2xml(result.responseText);
            return (xmlDoc_return);
            },
            $.call_hostProc_ORG = function (options, xmlDoc) {
                //$.alert("call_hostProc",options.class,options.func);
                try {
                    var xmlDocPara;
                    if (!options) {
                        return;
                    }
                    if (typeof options === 'object') {
                        xmlDocPara = $.make_optionElement(options);
                    }
                    if (typeof xmlDoc === 'object' && $.isXMLDoc(xmlDoc)) {
                        // 登録するxmlDocumentが指定してある場合
                        //var xmlString = (typeof (xmlDoc.documentElement.xml) == "undefined" ? xmlDoc.documentElement.outerHTML : xmlDoc.documentElement.xml);
                        var xmlString = $.xml2str(xmlDoc);

                        //var work = xmlString.replace(/[+]/g, "╋");          // 「+」を誤変換するのでいったん「╋」に変換する
                        xmlString = encodeURIComponent(xmlString);                          // 文字コード変換

                        var cdata = xmlDocPara.createCDATASection(xmlString);
                        //var root = xmlDocPara.selectSingleNode("//root");
                        var root = $(xmlDocPara).find("root");
                        var data = xmlDocPara.createElement("document");
                        //data.appendChild(cdata);
                        //root.appendChild(data);
                        $(data).append(cdata);
                        $(root).append(data);
                    }
                    var URL = "/Pages/hostProc/Entry.aspx";
                    var xmlDoc1 = $.loadXMLDoc(URL, xmlDocPara);                               // リストのxml
                    if (xmlDoc1 == null) {
                        throw new Error("xmlDoc=null");
                    }
                    if (xmlDoc1.validateOnParse == false) {
                        //$.debug("call_hostProc", "xmlDoc", "変換");
                        //var x = $.xml2str(xmlDoc1);
                        //xmlDoc1 = $.str2xml(x);
                        xmlDoc1.validateOnParse = true;
                    }

                    return (xmlDoc1);
                } catch (e) {
                    $.alert("ERROR:call_hostProc", window.location.href, e.message, options.class, options.func);
                }
			},

            $.make_optionElement = function (options) {
            var work = [];
            if (typeof (options) == "object") {
                $.each(options, function (name, value) {
                    work.push(name + "='" + value + "'");
                });
            }
            var Buff = "<root><option " + work.join(" ") + "/></root>";
            var xmlDoc = $.str2xml(Buff);

            return (xmlDoc);
            },

        $.make_optionNode = function(options) {
            var work = [];
            if (typeof (options) == "object") {
                $.each(options, function (name, value) {
                    work.push(name + "='" + value + "'");
                });
            }
            var Buff = "<root><option " + work.join(" ") + "/></root>";
            var xmlDoc = $.str2xml(Buff);
            var optionNode = $(xmlDoc).find("option");
            return (optionNode);
/*
            var xmlDoc = $.make_optionElement();
            var optionNode = $(xmlDoc).find("option");
            if (options) optionNode.attr(options);
            return (optionNode);
*/
        },

            //====================================================================
            $.fn.transformNode = function (xslDoc) {
                try {
                    if (arguments.length === 2) {
                        if (typeof (arguments[1].params) == "object") {
                            $(xslDoc).setParameter(arguments[1]);
                        }
                    }

                    var xmlDoc = this[0];

                    if (xslDoc.validateOnParse === false) {
                        xslDoc.validateOnParse = true;
                    }
                    if (xmlDoc.validateOnParse === false) {
                        xmlDoc.validateOnParse = true;
                    }
                    var transformed = "";
                    // code for IE
                    if (window.ActiveXObject || "ActiveXObject" in window) {
                        transformed = xmlDoc.transformNode(xslDoc);
                    }
                    // code for Edge, Mozilla, Firefox, Opera, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        var xsltProcessor = new XSLTProcessor();
                        xsltProcessor.importStylesheet(xslDoc);

                        var xmlDom = xsltProcessor.transformToDocument(xmlDoc);
                        var serializer = new XMLSerializer();
                        transformed = serializer.serializeToString(xmlDom.documentElement);
                    }
                    else {
                        alert("NG");
                    }
                    return (transformed);
                } catch (e) { $.alert("transformNode:" + e.message) }
            },
            $.transformNode = function () {
                var xmlDoc = null;
                var xslDoc = null;
                var Cnt = arguments.length;
                if (Cnt >= 2) {
                    xmlDoc = arguments[0];
                    xslDoc = arguments[1];
                }
                if (Cnt === 3) {
                    if (typeof (arguments[2].params) === "object") {
                        $(xslDoc).setParameter(arguments[2]);
                    }
                }
                if (xslDoc.validateOnParse === false) {
                    xslDoc.validateOnParse = true;
                }
                if (xmlDoc.validateOnParse === false) {
                    xmlDoc.validateOnParse = true;
                }
                try {
                    //$.alert("transformNode",$.isXMLDoc(xmlDoc), $.isXMLDoc(xslDoc));
                    var transformed = "";
                    // code for IE
                    if (window.ActiveXObject || "ActiveXObject" in window) {
                        transformed = xmlDoc.transformNode(xslDoc);
                    }
                    // code for Edge, Mozilla, Firefox, Opera, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        var xsltProcessor = new XSLTProcessor();
                        xsltProcessor.importStylesheet(xslDoc);

                        var xmlDom = xsltProcessor.transformToDocument(xmlDoc);
                        //var xmlDom = xsltProcessor.transformToFragment(xmlDoc, document);

                        var serializer = new XMLSerializer();
                        transformed = serializer.serializeToString(xmlDom.documentElement);

                    }
                    else {
                        alert("NG");
                    }
                    return (transformed);
                } catch (e) { alert("transformNodeX:" + e.message) }
            },
            $.fn.setParameter = function () {
                var Tab = {};
                var Cnt = arguments.length;
                if (Cnt === 2) {
                    var name = arguments[0];
                    var value = arguments[1];
                    Tab[name] = value;
                }
                else if (Cnt === 1) {
                    if (typeof (arguments[0].params) == "object") {
                        $.each(arguments[0].params, function (name, value) {
                            Tab[name] = value;
                        });
                    }
                }
                else {
                    return;
                }
                var xslDoc = this[0];
                var nodes = "";
                try {
                    nodes = xslDoc.getElementsByTagNameNS("http://www.w3.org/1999/XSL/Transform", "param");
                } catch (e) {
                    //alert(e.message);
                    nodes = xslDoc.getElementsByTagName("xsl:param");
                }
                $.each(nodes, function (i, elem) {
                    var baseName = ($.getBrowser() === "msie" ? elem.parentNode.baseName : elem.parentNode.localName);
                    if (baseName === "stylesheet") {
                        var o = elem.getAttribute("name");
                        if (typeof (Tab[o]) === "string") {
                            elem.setAttribute("select", Tab[o]);
                            var result = Tab[o].match(/^'?(\w*)'?$/);
                            if (result !== null) elem.setAttribute("select", "'" + result[1] + "'");
                        }
                        else if (typeof (Tab[o]) === "number") {
                            elem.setAttribute("select", Tab[o]);
                        }
                    }
                });
            },
            $.loadXMLDoc = function (URL) {
            try {
                //$.alert("loadXMLDoc",URL);
                var ext = URL.match(/.+\.(xsl|xml)/);
                var mode = (ext == null ? "POST" : "GET");
                var xmlDoc = null;
                if (arguments.length == 2) {
                    xmlDoc = arguments[1];

                    var optionTab = [];
                    var option = $("option", xmlDoc);
                    $.each(option[0].attributes, function (i, elem) {
                        optionTab.push(elem.name + "=" + elem.value);
                        elem.value = encodeURIComponent(elem.value);
                    })
                    //$.debug(optionTab.join("]["));
                }
                var xmlhttp;
                var browser = $.getBrowser();
                if (window.ActiveXObject){
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                else {
                    xmlhttp = new XMLHttpRequest();

                }
                xmlhttp.open(mode, URL, false);
                if (browser == "msie") {
                    xmlhttp.responseType = "msxml-document";
                    //$.alert("IE",$.xml2str(xmlDoc));
                }
                xmlhttp.contentType = "charset=shift_jis";
                xmlhttp.send(xmlDoc);
                if (xmlhttp.readyState == 4) {
                    if (xmlhttp.status == 200) {
                        if (browser == "msie") {
                            //xmlDoc1 = xmlhttp.responseXML;
                            xmlDoc1 = $.str2xml(xmlhttp.responseText);
                        }
                        else {
                            var xmlDoc1 = new DOMParser().parseFromString(xmlhttp.responseText, 'text/xml');
                        }
                        if (xmlDoc1.validateOnParse == false) {
                            xmlDoc1.validateOnParse = true;
                        }
                        return (xmlDoc1);
                    }
                    else {
                        return (null);
                    }
                }
            } catch (e) {
                //$.debug.log("loadXMLDoc", e.message);
                alert("loadXMLDoc:" + e.message);
            }
        },
        $.getBrowser = function () {
            var ua = window.navigator.userAgent.toLowerCase();
            var browser = "";
            if (ua.indexOf("opr") > -1) {
                browser = "opera";
            }
            else if (ua.indexOf("edge") > -1) {
                browser = "edge";
            }
            else if (ua.indexOf("chrome") > -1) {
                browser = "chrome";
            }
            else if (ua.indexOf("safari") > -1) {
                browser = "safari";
            }
            else if (ua.indexOf("msie") > -1) {
                browser = "msie";
            }
            else if (ua.indexOf("trident") > -1) {
                browser = "msie";
            }
        return (browser);
        },
        $.executeUrl = function (URL, para) {
            if (typeof (para) == "string") URL += "?" + para;
            var o_execute = $('<iframe />').attr('id', 'execute').appendTo('body');         // iframeを追加
            $(o_execute).css("display", "block");
            $(o_execute).css("border", "1px solid green");
            $(o_execute).css("width", "500px");
            $(o_execute).css("height", "300px");
            $(o_execute).attr("src", URL);
            o_execute.remove();
        },


        $.csv_download = function (docList, fileName, URL ) {
            //var mail = $.session("loginMail");
            //var URL = "/Pages/hostProc/csvDoc.ashx";
            var mode = (fileName == "" ? "debug" : "text" );
            var result = $.ajax({
                url: URL,
                type: "post",
                async: false,
                dataType: "text",
                data: { mode: mode, docList: docList },
                success: function (data) {
                    //alert(data);
                    let bom = new Uint8Array([0xEF, 0xBB, 0xBF]);
                    let downloadData = new Blob([bom, data], { type: 'text/csv' });
                    if (fileName == "") {
                        return(data);
                    }
                    else {
                        if (window.navigator.msSaveBlob) {
                            // IEの時
                            window.navigator.msSaveBlob(downloadData, fileName);
                        } else {
                            // IE以外(Chrome,Edge)の時
                            let downloadUrl = (window.URL || window.webkitURL).createObjectURL(downloadData);
                            let link = document.createElement('a');
                            link.href = downloadUrl;
                            link.download = fileName;
                            link.click();
                            (window.URL || window.webkitURL).revokeObjectURL(downloadUrl);
                        }
                    }
                },
                error: function () {
                    $.alert("読み込み失敗");
                }
            });
            if (result.statusText == "OK") {
                return (result.responseText);
            }
        },
        $.fn.viewXml = function (winName,width,height) {
            if (typeof (winName) !== "string" || winName === "") {
                winName = "viewXml";
            }
            if (typeof (width) === "undefined") {
                width = "400";
            }
            if (typeof (height) === "undefined") {
                height = "400";
            }
            var w = window.open("", winName, "width=" + width + ", height=" + height + ", resizable=yes, scrollbars=yes");
            var xmlDoc = this[0];
            //var work = xmlDoc.xml.replace(/[+]/g, "╋");          // 「+」を誤変換するのでいったん「╋」に変換する
            var xmlStr = encodeURIComponent(xmlDoc.xml);
            var f = $('<form/>').append("<input type='hidden' name='xml'>").appendTo($('body'));
            $("input[name='xml']", f).val(xmlStr);
            f[0].action = "/Pages/hostProc/xmlDoc.ashx";
            f[0].method = "post";
            f[0].target = winName;
            f.submit();
            f.remove();
            w.focus();
        },
        $.queryString = function (s, defaultValue) {
            defaultValue = (typeof (defaultValue) == "undefined" ? "" : defaultValue);
            var para = {};
            var work = (window.location).search.split("?");
            if (work.length == 2) {
                work = work[1].split("&");
                for (var i = 0; i < work.length; i++) {
                    var w = work[i].split("=");
                    //para[w[0]] = unescape(w[1]);
                    para[w[0]] = decodeURI(w[1]);
                }
            }
            return (typeof (para[s]) == "undefined" ? defaultValue : para[s]);
        },
            $.UrlCheck = function (url) {
                var result = $.ajax({
                    url: url,
                    async: false
                })
                    .done(function () {
                        // exists code 
                        //return (true);
                    }).fail(function () {
                        // not exists code
                        //return (false);
                    })
                //alert("X");
                return ((result.status == 200 ? true : false));
            },
            $.isUrlFile = function (url) {
                var result = $.ajax({
                    url: url,
                    async: false
                })
                    .done(function () {
                        // exists code 
                        //return (true);
                    }).fail(function () {
                        // not exists code
                        //return (false);
                    })
                //alert("X");
                return ((result.status == 200 ? true : false));
            },
            $.getStyle = function () {
            var dedefualtValue = "";
                var result = "";
                if (arguments.length == 0) return (defualtValue);
                if (arguments.length == 2) defualtValue = arguments[1];
                var work = arguments[0].split("/");
                if (work.length != 3) return (defualtValue);
                var sheetName = work[0];
                var elementName = work[1];
                var styleName = work[2];
                var sheet = new RegExp(sheetName + "$");
                var elementText = elementName.replace(/\s+/g, "");
                var element = new RegExp("^" + elementText + "$");
                var o = document.styleSheets;
                var x = $.each(o, function (i, elem) {
                    //$.debug(typeof (elem.href));
                    if (sheetName != "" && typeof (elem.href) == "string") {
                        var href = $(elem).prop("href");
                        var a_sheet = href.match(sheet);                                          // cssファイルを検出
                        //$.debug("0", i, href, $(a_sheet).get(0));
                        if (a_sheet == null) return (true);
                    }
                    $.each(elem.rules, function (i1, elem1) {
                        var selectorText = elem1.selectorText.replace(/\s+/g, "");
                        var ret = selectorText.match(element);                      // エレメント名を検出
                        //$.debug("1",i1, selectorText, elementName,ret);
                        if (ret != null) {
                            //$.debug("2", i1, elem1.selectorText, styleName, typeof (elem1.style[styleName]), elem1.style[styleName]);
                            if (typeof (elem1.style[styleName]) == "string") {
                                result = elem1.style[styleName];
                                // false : 最初のエレメントで見つかったとき 
                                // true : 最後のエレメントで見つかったとき
                                return (true);
                            }
                        }
                    });
                });
                result = (result == "" ? defualtValue : result);
                return (result);
            },
            $.fn.getAttr = function (arg) {
                var attrTab = {};
                var str = this.get(0).getAttribute(arg);
                if (str === null) {
                    return (null);
                }
                else {
                    var item = str.split(",");
                    $(item).each(function (i, e) {
                        var val = e.split(":");
                        var name = val[0].toLowerCase();
                        var value = (isNaN(val[1]) ? val[1] : parseInt(val[1]));
                        attrTab[name] = value;
                    });
            }
            this.attr = function (arg) {
                var ret = "";
                var s = arg.toLowerCase();
                if (typeof (attrTab[s]) === "string") {
                    ret = attrTab[s];
                }
                return (ret);
            }
            return (this);
            },

            $.fn.atr2obj = function (arg) {
                var ret = {};
                var str = this.get(0).getAttribute(arg);
                if (str == null) return (null);
                var item = str.split(",");
                $(item).each(function (i, e) {
                    var val = e.split(":");
                    var name = val[0];
                    var value = (isNaN(val[1]) ? val[1] : parseInt(val[1]));
                    ret[name] = value;
                });
            return ret;
            },
            $.fn.attrAll = function () {
                var ret = {};
                var attrs = this.get(0).attributes;
                var attr;
                for (var i = 0, len = attrs.length; i < len; i++) {
                    attr = attrs[i];
                    ret[attr.name] = attr.value;
                }
                return ret;
            },
            $.window = {
                get top() {
                    var o = window.top;
                    while ((o.opener != null && o.opener)) o = o.opener.top;
                    return (o.top);
                },
                get history() {
                    var Tab = [];
                    var pElem = window;
                    var c_name, p_name, top;
                    var mode = "parent";
                    do {
                        c_name = pElem.location.pathname;
                        p_name = (pElem.opener ? pElem.opener.location.pathname : pElem.parent.location.pathname);
                        top = (p_name == c_name ? "top" : "");
                        Tab.push({ name: c_name, elem: pElem, mode: mode, top: top });
                        mode = (pElem.opener ? "opener" : "parent");
                        pElem = (pElem.opener ? pElem.opener : pElem.parent);
                    } while (mode != "parent" || top != "top");
                    Tab = Tab.reverse();
                    return (Tab);
                }
            },

            $.x_window = {
                get top() {
                    var o = window.top;
                    while ((o.opener != null && o.opener)) o = o.opener.top;
                    return (o.top);
                },
                get opener() {
                    var o = null;
                    if (window == window.parent) {
                        //$.debug("$.x_window.opener", "open");
                        // open
                        o = window.opener;
                    }
                    else {
                        //$.debug("$.x_window.opener", "ifream");
                        // ifream
                        o = window.parent.opener;
                    }
                    return (o);
                },
                get history() {
                    var Tab = [];
                    var pElem = window;
                    var c_name, p_name, top;
                    var mode = "parent";
                    do {
                        c_name = pElem.location.pathname;
                        p_name = (pElem.opener ? pElem.opener.location.pathname : pElem.parent.location.pathname);
                        top = (p_name == c_name ? "top" : "");
                        Tab.push({ name: c_name, elem: pElem, mode: mode, top: top });
                        mode = (pElem.opener ? "opener" : "parent");
                        pElem = (pElem.opener ? pElem.opener : pElem.parent);
                    } while ( mode != "parent" || top != "top" );
                    Tab = Tab.reverse();
                    return (Tab);
                }
            },
        $.ifream = {
            get mode() {
                // ifreameで立ち上げ:true
                // open   で立ち上げ:false
                return (window != window.parent);
            }
        },
        $.storage = function () {
            var key = arguments[0];
            var value = arguments[1];
            var Cnt = arguments.length;
            //$.alert(Cnt,key,value);
            if (Cnt == 1) {
                var return_value = window.localStorage.getItem(key);
                return_value = (return_value == "null" ? null : return_value);
                return (return_value);
            }
            else if (Cnt >= 2) {
                window.localStorage.setItem(key, value);
            }
        }


})(jQuery);

/*
$.session("session Name","session Value")
value = $.session("session Name")
$.session.log()
$.session.Abandon()
*/
;(function ($) {
    var methods = {
        init: function (options) {
            return;
        },
        func: function (o) {
            return;
        },
        Check: function () {
            var work = send_hostMessage({ func: "Check", name:"loginMail" });
            return(work);
        },
        Abandon: function () {
            send_hostMessage({ func: "Abandon" });
            return;
        },
        exec: function () {
            try {
                var key = arguments[0];
                var value = arguments[1];
                var Cnt = arguments.length;
                //$.alert(Cnt,key,value);
                if (Cnt == 1) {
                    value = window.sessionStorage.getItem(key);
                    value = (value == "null" ? null : value);
                    return (value);
                }
                else if (Cnt == 2) {
                    window.sessionStorage.setItem(key, value);
                }
            }
            catch (e) {
                alert("$.session exec error" + e.message);
            }
        },
        log: function () {
            try {
                var loginMail = $.session("loginMail");

                var Cnt = arguments.length;
                var work = [];
                for (var i = 0; i < Cnt; i++) {
                    work.push(arguments[i]);
                }
                var str = work.join(",");
                send_hostMessage({
                    func : "log",
                    mail : loginMail,
                    message: str
                });


            }
            catch (e) {
                //alert("log error");
            }
        }
    };

    function send_hostMessage(sendObj) {
        try {
            var url = "/Pages/hostProc/sessionProc.ashx";     // + para.join("&"); 
            var stat = "";
            var result = $.ajax({
                url: url,
                async: false,
                data: sendObj,
                type: 'POST',                  //GET,POSTを指定してHTTPの通信タイプを決定
                dataType: 'text',               //json,jsonp,html,text,script,xmlが指定できます。
                //processData: false,
                success: function (response) {    //成功した場合に走る関数です。
                    stat = "OK" + response;
                },
                error: function (response) {
                    stat = "NG" + response;
                    $.alert("error:", stat);
                }
            });
            return (result.responseText);
        } catch (e) { $.alert("send_hostMessage", e.message) }
    }

    $.session = function (method) {
        //===========================================
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);           // 指定がなければ[init]を実行する
        }
        else {
            return methods["exec"].apply(this, Array.prototype.slice.call(arguments, 0));
            //$.alert("Method " + method + " この機能は設定されていません [ jQuery.tooltip ]");
        }

        //return (this);
    };
    $.session.log = function () {
        return methods["log"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.session.Abandon = function () {
        return methods["Abandon"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.session.Check = function () {
        return methods["Check"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
})(jQuery);
; (function ($) {
    $.fn.getElementsByTagName = function (name) {
        var ptn1 = /xsl:(\S+)/i;
        var work = name.match(ptn1);
        var xslDoc = this[0];
        if (work == null) return (null);
        var nodes = "";
        try {
            nodes = xslDoc.getElementsByTagNameNS("http://www.w3.org/1999/XSL/Transform", work[1]);
        } catch (e) {
            //alert(e.message);
            nodes = xslDoc.getElementsByTagName(work[0]);
        }
        return (nodes);
    },
        $.fn.setSortParameter = function (name, Tab) {
            var xslDoc = this[0];
            var nodes = "";
            try {
                nodes = xslDoc.getElementsByTagNameNS("http://www.w3.org/1999/XSL/Transform", "sort");
            } catch (e) {
                //alert(e.message);
                nodes = xslDoc.getElementsByTagName("xsl:sort");
            }
            $.each(nodes, function (i, elem) {
                if (elem.parentNode.getAttribute("select") == name) {
                    $.each(Tab, function (i, e) {
                        elem.setAttribute(i, e);
                    })
                }
            })
        };
})(jQuery);

; (function ($) {
    // <xsl:variable name="list_title" >仮払の申請伝票</xsl:variable >
    // xslDoc.selectSingleNode("//xsl:variable[name='list_tile']")
    // $(xslDoc).selectSingleNode("//xsl:variable[name='list_tile']");
    $.fn.selectSingleNode = function (str) {
        var nodes = this.selectNodes(str);
        if (nodes == null) return (null);

        var ptn1 = /xsl:(\w+)(\[@(\w+)='(\w+)'\])*/i;
        var work = str.match(ptn1);
        if (work == null || work.length <= 2) return (nodes[0]);
        var tagName = work[1];
        var attrName = work[3];
        var attrValue = work[4];
        var node = null;
        $.each(nodes, function (i, elem) {
            var n = $(elem).attr(attrName);
            if (n == attrValue) {
                node = elem;
                return (false);
            }
        });
        return (node);
    };
    $.fn.selectNodes = function (str) {
        var ptn1 = /xsl:(\w+)(\[@(\w+)='(\w+)'\])*/i;
        var work = str.match(ptn1);
        var nodes = null;
        if (work == null) {
            nodes = this[0].getElementsByTagName(str);
        }
        else {
            var tagName = work[1];
            try {
                nodes = this[0].getElementsByTagNameNS("http://www.w3.org/1999/XSL/Transform", tagName);
            } catch (e) {
                //alert(e.message);
                nodes = this[0].getElementsByTagName("xsl:" + tagName);
            }
        }
        return (nodes);
    };
})(jQuery);

/*
    var o1 = $.stopwatch();
    $(o1).stopwatch("AAA");
    $(o1).stopwatch("BBB");
    var Buff = $(o1).stopwatch();
    alert(Buff);
*/
; (function ($) {
    $.stopwatch = function (message) {
        var o = $.window.top;
        if (message === "on") {
            o.stopwatch_mode = true;
        }
        else if (message === "off") {
            o.stopwatch_mode = false;
        }
        else {
            if (typeof (o.stopwatch_mode) === "undefined") o.stopwatch_mode = true;
            if( o.stopwatch_mode === false ) return(null);
            //                var div = document.body.appendChild(document.createElement("stopwatch"));
            var element = $("<stopwatch/>");
            if (typeof (message) != "undefined") {
                $(element).addClass(message);
                $(element).data("tab", []);
                $(element).data("tab").push({ time: new Date(), message: "計測開始" });
            }
            return (element);
        }
    };

    $.stopwatch_sub = function (element, message) { this.init(element, message); };
    $.extend($.stopwatch_sub.prototype, {
        settings: {
        },
        init: function (element, message) {
            //this.settings = $.extend({}, this.settings, options);
            //$(element).data("tab", []);
            if (typeof (message) == "undefined") {
                $(element).data("tab").push({ time: new Date(), message: "計測終了" });
                ret = this.disp(element);
            }
                $(element).data("tab").push({ time: new Date(), message: message });
        },

        execute: function (element, message) {
            var ret = "";
            if (typeof (message) == "undefined") {
                $(element).data("tab").push({ time: new Date(), message: "計測終了" });
                ret = this.disp(element);
            }
            else {
                $(element).data("tab").push({ time: new Date(), message: message });
            }
            return (ret);
        },
        disp: function (element) {
            //$(element).data("tab").push({ time: new Date(), message: "計測終了" });
            var Tab = $(element).data("tab");
            var className = (typeof ($(element).attr("class")) == "undefined" ? "" : "【" + $(element).attr("class") + "】");
            var work = [];
            work.push("");
            work.push("〓〓 時間計測" + className + "〓〓");
            //work.push("時間計測");
            //work.push("――――――――");
            var o1, o2, tm;
            for (var i = 0; i < Tab.length - 1; i++) {
                //msg = "【" + Tab[i].message + "】→【" + Tab[i + 1].message + "】";
                msg = "【" + Tab[i].message + "】→";
                o1 = Tab[i];
                o2 = Tab[i + 1];
                tm = o2.time - o1.time;
                work.push(('00' + Math.floor(tm / 1000)).slice(-2) + "." + ('000' + Math.round(tm % 1000)).slice(-3) + " ： " + msg);
            }
            work.push("――――――――");
            o1 = Tab[0];
            o2 = Tab[i];
            tm = o2.time - o1.time;
            work.push(('00' + Math.floor(tm / 1000)).slice(-2) + "." + ('000' + Math.round(tm % 1000)).slice(-3) + " ： " + "【総時間】");
            work.push("");

            var Buff = work.join("\n");
            $(element).data("tab").length = 0;
            $.debug(Buff);
            return (Buff);
        }
    });
    $.fn.stopwatch = function (message) {
        var o = $.window.top;
        if (o.stopwatch_mode === false) return;
        var ret = "";
        this.each(function (i, elem) {
            if ($(this).data("stopwatch")) {
                ret = $(this).data("stopwatch").execute(this, message);
            } else if (this.tagName == "STOPWATCH") {
                $(this).data("stopwatch", new $.stopwatch_sub(this, message));
            }
        });
        return ret;
    };


})(jQuery);
    //====================================================================
