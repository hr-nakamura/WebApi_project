viewXmlWindow = function () {
    this.entryFunc = null;;
    this.url = "/Pages/util/viewXML/viewXML.html";
    this.winName = "viewXMLDocWindow"
    this.win = null;
    this.eventName = "Event_viewEntry";
    this.sH = 400;
    this.sW = 400;
    this.top = 0;
    this.left = screen.width - (this.sW + 16);
    this.location = window.location;
    //$.debug("new ====",this.location);

    this.init = function (o_viewWindow, func_viewEntry) {
        this.entryFunc = func_viewEntry;
        //　viewWindow側で呼ぶ「init」
        //$.debug("init");
        if (o_viewWindow.opener) {
            //$.debug("trigger");
            $(o_viewWindow.opener).trigger(this.eventName, func_viewEntry);         // ①発火
        }
    },

    this.view = function (xmlDoc) {
        //$.debug("view");
        var xmlStr = (typeof(xmlDoc) == "string" ? xmlDoc : $.xml2str(xmlDoc) );
        if (!this.win || this.win.closed) {
            //$.debug("open");
            this.win = window.open(this.url, this.winName, makePara(this));
            $(window).one(this.eventName, function (e, func_viewEntry) {            // ①からの発火を受ける
                //$.debug("event","opener:viewEntry", e.type);
                //(func_viewEntry)("set", xmlStr);        // 一番最初のxmlデータ表示
                (this.viewXmlWindow).entryFunc("set", xmlStr);
            });
            $(window).one("resize focus blur beforeunload", function (e) {
                // this は親
                //$.debug("event", "opener", e.type);
                switch (e.type) {
                    case "beforeunload":
                        window.viewXmlWindow.close();
                        break;
                    default:
                        var a = 1;
                        break;
                }
            });
        }
        else {
            this.win.viewEntry("set", xmlStr);
        }
    },
    this.close = function () {
        setInitInfo({top:this.top,left:this.left,sW:this.sW,sH:this.sH});
        if (this.win && !this.win.closed) {
            this.win.close();
        }
    },
    this.setInfo = function (para) {
        //$.debug("set Info",para.top,para.left,para.sW,para.sH);
        this.sW = para.sW;
        this.sH = para.sH;
        this.top = para.top;
        this.left = para.left;
    }
    var para = getInitInfo();
    this.setInfo(para);
    var a = 1;
    return (this);

    function getInitInfo() {
        var work = $.storage("viewXmlWindow");
        var size = 400;
        var para = { sH: size, sW: size, top: 0, left: screen.width - (size + 16) };
        if (work != null) {
            para = JSON.parse(work);
        }
        return (para);
    }
    function setInitInfo(para) {
        var work = JSON.stringify(para);
        $.storage("viewXmlWindow", work);
    }
    //centerscreen
    function makePara(o) {
        var para = [];
        para.push("toolbar=no");
        para.push("location=no");
        para.push("status=no");
        para.push("menubar=no");
        para.push("scrollbars=yes");
        para.push("resizable=yes");
        para.push("top=" + o.top);
        para.push("left=" + o.left);
        para.push("width=" + o.sW);
        para.push("height=" + o.sH);
        //para.push("centerscreen");


        return (para.join(","));
    }
}