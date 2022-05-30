;(function ($) {
        $.alert = function () {
            var work = [];
            var Cnt = arguments.length;
            for (var i = 0; i < Cnt; i++) {
                work.push(arguments[i]);
            }
            alert(work.join("\n"));
            return (this);
        },
        $.alert.json = function () {
            var message = JSON.stringify(arguments[0], null, 2);
            alert(message);

        },
        $.isJSON = function( arg ) {
                arg = (typeof arg === "function") ? arg() : arg;
                if (typeof arg !== "string") {
                    return false;
                }
                try {
                    arg = (!JSON) ? eval("(" + arg + ")") : JSON.parse(arg);
                    return true;
                } catch (e) {
                    return false;
                }
            },
        $.xml2str = function (xmlNode) {
            var xmlString = "";
            var browser = $.Browser.name;
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
                    $.debug.note("loadXMLText", e.message);
                }
            }
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
        //====================================================================
        $.fn.transformNode = function (xslDoc) {
            var xmlDoc = this[0];
            var transformed;
            if (arguments.length === 1) {
                transformed = $.transformNode(xmlDoc, xslDoc);
            }
            else if (arguments.length === 2 && arguments[1].params === "object") {
                transformed = $.transformNode(xmlDoc, xslDoc, arguments[1]);
            }
            return (transformed);
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
            try {
                var Cnt = arguments.length;
                if (Cnt >= 2) {
                    xmlDoc = arguments[0];
                    xslDoc = arguments[1];
                    if (xmlDoc === null) throw new Error("xml Document Is Null");
                    if (xslDoc === null) throw new Error("xsl Document Is Null");
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
            } catch (e) {
                $.alert("[$.transformNode]", e.message);
            }
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
        $.loadXMLDoc = function () {
            // ①　$.loadXMLDoc("/aaa/bbb/abc.asp?p1=1&p2=2&p3=3");
            // ②　$.loadXMLDoc("/aaa/bbb/abc.asp","p1=1&p2=2&p3=3");
            // ③　$.loadXMLDoc(url,para1,para2,para3,.......);
            var asyncMode = false;
            var doneProc = null;
            var Buff = {};
            var xmlDoc = null;
            try {
                var nvc = new $.NameValueCollection();

                // URL　にパラメータがついている場合①
                var Work = arguments[0].split("?");
                Buff["Url"] = Work[0];
                //$.debug(Buff["Url"] ,"loadXMLDoc start");
                if (Work.length > 1) {
                    nvc.Add(Work[1]);
                }
                if (arguments.length > 1 && (typeof (arguments[1]) == "function")) {
                    asyncMode = true;
                    doneProc = arguments[1];
                    arguments = Array.prototype.slice.call(arguments, 1);
                }
                //パラメータを別に指定した場合②③
                if (arguments.length > 1) {
                    for (var i = 1; i < arguments.length; i++) {
                        if (typeof (arguments[i]) == "string") {
                            nvc.Add(arguments[i]);
                        }
                    }
                }
                Buff["Arg"] = nvc.ToEncodeString();
                var returnValue = "";

                if ((window.ActiveXObject || "ActiveXObject" in window) && Buff["Url"].match(/.+\.(xslt|xsl)$/i)) {
                    // IEでxslの時ActiveXで読み込む
                    //$.debug("IE and xsl", Buff["Url"]);
                    var xslDoc = new ActiveXObject("Microsoft.XMLDom");
                    xslDoc.async = false;
                    xslDoc.load(Buff["Url"]);
                    return (xslDoc);
                }
                else {
                    //$.debug("Not IE", Buff["Url"]);
                    $.ajax({
                        url: Buff["Url"],
                        type: "GET",
                        data: Buff["Arg"],
                        contentType: "text/plain",
                        cache: false,
                        async: asyncMode
                    }).done(function (data, status, xhr) {
                        if (asyncMode == true) {
                            //$.debug(Buff["Url"],"async done");
                            xmlDoc = $.str2xml(xhr.responseText);
                            doneProc(xmlDoc);
                        }
                        else {
                            //$.debug(Buff["Url"],"sync done");
                            returnValue = xhr.responseText;
                        }
                    }).fail(function (xhr, status, error) {
                        //$.debug("error");
                        throw new Error(xhr.statusText);
                    }).always(function () {
                        //$.debug(Buff["Url"],"always");
                    });
                    //$.debug(Buff["Url"],"end");
                    xmlDoc = $.str2xml(returnValue);
                    return (xmlDoc);
                }
            } catch (e) {
                $.alert("[loadXMLDoc]", e.message, Buff["Url"]);
                return (null);
            }
        },
        $.loadText = function () {
            // ①　$.loadXMLDoc("/aaa/bbb/abc.asp?p1=1&p2=2&p3=3");
            // ②　$.loadXMLDoc("/aaa/bbb/abc.asp","p1=1&p2=2&p3=3");
            // ③　$.loadXMLDoc(url,p1=1,para2,para3,.......);
            var Buff = {};
            var xmlDoc = null;
            try {
                var nvc = new $.NameValueCollection();

                // URL　にパラメータがついている場合①
                var Work = arguments[0].split("?");
                Buff["Url"] = Work[0];
                if (Work.length > 1) {
                    nvc.Add(Work[1]);
                }

                //パラメータを別に指定した場合②③
                if (arguments.length > 1) {
                    for (var i = 1; i < arguments.length; i++) {
                        if (typeof (arguments[i]) == "string") {
                            nvc.Add(arguments[i]);
                        }
                    }
                }
                Buff["Arg"] = nvc.ToEncodeString();
                var returnValue = "";
                $.ajax({
                    url: Buff["Url"],
                    type: "GET",
                    data: Buff["Arg"],
                    contentType: "text/plain",
                    cache: false,
                    async: false
                }).done(function (data, status, xhr) {
                    returnValue = data;
                }).fail(function (xhr, status, error) {
                    throw new Error(xhr.statusText);
                }).always(function () {
                    $.debug("always");
                });
                return (returnValue);
            } catch (e) {
                $.alert("[loadText]", e.message, Buff["Url"]);
                return (null);
            }
        },
        $.loadJSONDoc = function (url) {
                // ①　$.loadXMLDoc("/aaa/bbb/abc.asp?p1=1&p2=2&p3=3");
                // ②　$.loadXMLDoc(url,"p1=1&p2=2&p3=3");
                // ③　$.loadXMLDoc(url,para1,para2,para3,.......);
                // ④　$.loadXMLDoc(url,{p1:"p1",p2:"p2",.....});

                var Buff = {};
                var xmlDoc = null;
                try {
                    var nvc = new $.NameValueCollection();

                    // URL　にパラメータがついている場合①
                    var Work = arguments[0].split("?");
                    Buff["Url"] = Work[0];
                    if (Work.length > 1) {
                        nvc.Add(Work[1]);
                    }

                    if (arguments.length == 2 && typeof (arguments[1]) == "object") {
                        Buff["Arg"] = arguments[1];
                    }
                    //パラメータを別に指定した場合②③
                    else if (arguments.length >= 2) {
                        for (var i = 1; i < arguments.length; i++) {
                            if (typeof (arguments[i]) == "string") {
                                nvc.Add(arguments[i]);
                            }
                        }
                        Buff["Arg"] = nvc.ToEncodeString();
                        //Buff["Arg"] = nvc.ToString();
                    }

                var returnValue = "";
                $.ajax({
                    url: Buff["Url"],
                    type: "GET",
                    data: Buff["Arg"],
                    contentType: "application/json",
                    cache: false,
                    async: false,
                    timeout: 10
                }).done(function (data, status, xhr) {
                    returnValue = data;
                }).fail(function (xhr, status, error) {
                    throw new Error(xhr.statusText);
                }).always(function () {
                    //$.alert("always");
                });
            } catch (e) {
                $.debug("loadJSON", e.message, url);
            }
            return (returnValue);
        },
        $.ValueCollection = function (para) {
            this.Tab = [];
            for (var key in para) {
                if (para[key] != "") this.Tab.push("".concat(key, "=", para[key]));
            }
            this.Add = function (key, value) {
                if (value != "") this.Tab.push("".concat(key, "=", value));
            }
            this.ToString = function () {
                return (this.Tab.join("&"));
            }
            return (this);
        },

        $.queryString = function () {
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
            if (arguments.length == 0) {
                return (para);
            }
            else {
                var s = arguments[0];
                var defaultValue = arguments[1];
                defaultValue = (typeof (defaultValue) == "undefined" ? "" : defaultValue);
                return (typeof (para[s]) == "undefined" ? defaultValue : para[s]);
                }
            },
        $.convertAbsUrl = function (url) {
            return $("<a>").attr("href", url).get(0).href;
        },
        $.encodeing = function (str) {
            var unicodeArray = [];
            for (let i = 0; i < str.length; i++) {
                unicodeArray.push(str.charCodeAt(i));
            }
            var sjisArray = Encoding.convert(unicodeArray, {
                to: 'SJIS',
                from: 'UNICODE',
                type: 'array'
            });
            var sjisString = Encoding.urlEncode(sjisArray);
            return (sjisString);
        },
        $.UrlValueCollection = function () {
            this.Tab = {};
            this.Add = function () {
                if (arguments.length == 1) {
                    var work = arguments[0].split("&");
                    for (var n = 0; n < work.length; n++) {
                        var x = work[n].split("=");
                        if (x.length == 2) {
                            var key = x[0];
                            var value = x[1];
                            this.Tab[key] = value;
                        }
                    }
                }
                else if (arguments.length == 2) {
                    var key = arguments[0];
                    var value = arguments[1];
                    if (value != "") this.Tab[key] = value;
                }
            }
            this.Check = function (name) {
                var outTab = [];
                for (var key in this.Tab) {
                    outTab.push(key + "=" + this.Tab[key]);
                }
                var work = outTab.join("\n")
                var rep = new RegExp("".concat("(", name, ")=(.*)"), "i");
                var result = work.match(rep);
                var value = (result == null ? "" : result[2]);
                return (value);
            }
        },
        $.NameValueCollection = function() {
            this.Tab = {};
            this.Add = function () {
                if (arguments.length == 1) {
                    var work = arguments[0].split("&");
                    for (var n = 0; n < work.length; n++) {
                        var x = work[n].split("=");
                        if (x.length == 2) {
                            var key = x[0];
                            var value = x[1];
                            this.Tab[key] = value;
                        }
                    }
                }
                else if (arguments.length == 2) {
                    var key = arguments[0];
                    var value = arguments[1];
                    if (value != "") this.Tab[key] = value;
                }
            }
        this.Check = function (key) {
            var value = this.Tab[key];
            value = (typeof (value) == "undefined" ? "" : value);
            return (value);
        }
        this.ToEncodeString = function () {
            var outTab = [];
            for (var key in this.Tab) {
                outTab.push(key + "=" + unicode2sjis(this.Tab[key]));
            }
            return (outTab.join("&"));
        }
        this.ToString = function () {
            var outTab = [];
            for (var key in this.Tab) {
                outTab.push(key + "=" + this.Tab[key]);
            }
            return (outTab.join("&"));
        }
        function unicode2sjis(str) {
            var unicodeArray = [];
            for (let i = 0; i < str.length; i++) {
                unicodeArray.push(str.charCodeAt(i));
            }
            var sjisArray = Encoding.convert(unicodeArray, {
                to: 'SJIS',
                from: 'UNICODE',
                type: 'array'
            });
            //var sjisArray = unicode2sjis(para);
            var sjisString = Encoding.urlEncode(sjisArray);
            return (sjisString);
            }
        },

        $.strMonth = function(yymm) {
            var strYYMM = "";
            if (yymm != "undefined") {
                yy = parseInt(yymm / 100, 10);
                mm = parseInt(yymm % 100, 10);
                strYYMM = yy + "年" + $.numZ(mm, 2) + "月";
            }
            return (strYYMM);
        },
        $.numZ = function(num, width) {
            var n = 1;
            var w = width;
            var s = "";

            while (w-- != 0) {
                n = n * 10;
            }

            if (num >= n) {
                return (String(num));
            }

            s = String(num + n);
            return (s.substr(1, width));
        },
        $.yymmAdd = function(yymm, value) {
            var yy, mm, ym
            yy = parseInt(yymm / 100, 10);
            mm = parseInt(yymm % 100, 10);

            ym = (yy * 12) + mm;
            ym += value;
            yy = parseInt(ym / 12, 10);
            mm = parseInt(ym % 12, 10);
            if (mm == 0) { yy--; mm = 12; }
            return ((yy * 100) + mm)
        }

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

; (function ($) {
    $.fn.JsonOut = function (JsonInfo) {
        var Buff = JSON.stringify(JsonInfo, null, 2);
        $(this[0]).text(Buff);
    },
        $.Browser = {
            get name() {
                var ua = window.navigator.userAgent.toLowerCase();
                var browser = "";
                if (ua.indexOf("opera") > -1) {
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
            }
        },
        $.TimeStamp = {
        get get() {
                var now = new Date().valueOf();
                var TimeStamp = String(now);
                return (TimeStamp);
                }
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
; (function ($) {
    // 非同期実行
    $.asyncExecute = function (method, para) {
        // Promise を返す
        return new Promise(function () {
            setTimeout(function () {
                method(para);
            }, 1);
        });
    }
})(jQuery);