
DocumentWindow = function () {
    var Cnt = arguments.length;
    this.maxCount = ( Cnt === 0 ? 32 : arguments[0]);
    this.windowTab = [];
    this.urlTab = [];
    this.windowName = "___documentWindow_";
    this.msg = "帳票画面の同時作業数は" + this.maxCount + "個です";
    this.open = function (url, settings) {
        if (this.urlTab.indexOf(url) >= 0) {
            //$.alert("OK", url);
        }
        else {
            this.urlTab.push(url);
            //$.alert("New", url);
        }
        var docId = "";
        var docType = "";
        if (typeof (settings) == "object") {
            docId = settings["docId"];
            docType = settings["docType"];
        }
        if ($.isNumeric(docId)) {
            var flag = false;
            for (var i = 0; i < this.windowTab.length; i++) {
                var elem = this.windowTab[i];
                if (elem.docId == docId) {
                    if (elem.id != null && !elem.id.closed) {
                        elem.id.focus();
                        //$.debug("フォーカス", docId, elem.docType);
                    }
                    else {
                        // この条件は発生しない（子ウインドを閉じた時点でクローズ処理が実行される）
                        var id = window.open(elem.url, elem.name, makePara());
                        this.windowTab[i].id = id;
                        this.windowTab[i].window = id;
                        //alert("redisp");
                        //$.debug("再表示", docId, elem.docType);
                    }
                    return("");
                }
            }
        }

        var cnt = this.windowTab.length;
        if (cnt >= this.maxCount) {
            return (this.msg);
        }
        var windowName = this.windowName;
        var dt = new Date();
        var TimeSpan = dt.getTime();
        if (docId === "") {
            windowName = windowName.concat(TimeSpan);
        } 
        else {
            //windowName = windowName.concat(docId);
            windowName = windowName.concat(TimeSpan);
        }
        if (typeof(settings) == "object") {
            var work = [];
            work.push("TimeSpan=" + TimeSpan);
            for (var name in settings) {
                if (settings[name] != "") work.push(name + "=" + settings[name]);
            }
            if (work.length > 0) {
                url += "?" + work.join("&");
            }
        }
        //$.debug("window open", docId, docType);
        var idx = window.open(url, windowName, makePara());
        this.windowTab.push({
            url: url,
            id: idx,
            window:idx,
            name: windowName,
            docId: docId,
            docType:docType
        });
        //id.status = "[" + docId + "][" + docType + "]";
        return (windowName);
    }
    this.close = function (name) {
        var obj = this;
        //$.debug("closeProc S", obj.windowTab.length);
        if (typeof (name) != "undefined") {
            closeProc(obj,name);
        }
        else {
            //$.debug("window close(All-0)", obj.windowTab.length);
            while (obj.windowTab.length > 0){
                $(this.windowTab).each(function (i, elem) {
                    closeProc(obj, elem.name);
                });
            }
            //$.debug("window close(All-2)", obj.windowTab.length);
        }
        //$.debug("closeProc E",obj.windowTab.length);
    }

    this.changeId = function (newId, oldId) {
        $.each(this.windowTab, function (i,elem) {
            if (elem.docId === oldId) {
                elem.docId = newId;
                return;
            }
        })    
    }
    this.window = function (winName) {
        var obj = null;
        $.each(this.windowTab, function (i, elem) {
            if (elem.name === winName) {
                obj = elem.id;
                return;
            }
        })   
        return (obj);
    }
    function closeProc(obj,name) {
        for (var i = 0; i < obj.windowTab.length; i++) {
            var elem = obj.windowTab[i];
            if (elem.name === name) {
                if (elem.id) {
                    if (!elem.id.closed) {
                        //elem.id.focus();
                        //$.debug("window close", i, elem.docId, elem.docType);
                        elem.id.close();
                        elem.id = null;
                        obj.windowTab.splice(i, 1);
                    }
                    else {
                        //$.debug("window close",i);
                        obj.windowTab.splice(i, 1);
                    }
                }
            }
        }
    }
    function makePara() {
        var para = [];
        para.push("toolbar=no");
        para.push("location=no");
        para.push("status=yes");
        para.push("menubar=no");
        para.push("scrollbars=yes");
        para.push("resizable=yes");
        //para.push("top=" + 0);
        //para.push("left=" + 0);
        para.push("width=" + "1400px");
        para.push("height=" + "900px");
        return (para.join(","));
    }
    return (this);
}
