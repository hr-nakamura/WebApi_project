(function ($) {
    $.UrlExists = function (url) {
        var http = new XMLHttpRequest();
        http.open('HEAD', url, false);
        http.send();
        return http.status != 404;
    }
    var debugUrl = "/WebApi/project/__home/debug/debug.ashx";     // + para.join("&");
    var fileName = getFileName();
    if (typeof (window.debugTab) === "undefined") window.debugTab = {};
    if (typeof (window.debugTab[fileName]) === "undefined") window.debugTab[fileName] = 0;
    //if (typeof (window.debug_mode) === "undefined") window.debug_mode = true;
    var debug_mode = ($.UrlExists(debugUrl) ? true : false);

    var methods = {

        init: function (options) {
            return;
        },


        func: function (o) {
            return;
        },
        Abandon: function () {
            send_hostMessage({ mode: "Session.Abandon" });
            return;
        },
        off: function () {
            $.window.top.debug_mode = false;
            send_hostMessage({ mode: "off" });
            return;
        },
        on: function () {
            $.window.top.debug_mode = true;
            send_hostMessage({ mode: "on" });
            return;
        },
        clear: function () {
            $.window.top.debug_mode = true;
            send_hostMessage({ mode: "clear" });
            return;
        },
        debug: function () {
            try {
                if (debug_mode != true) return;
                var o = this;
                var fCnt = [window.debugTab[fileName]++];
                fCnt = ("000".concat(fCnt)).substr(-3);
                var work = [];
                work.push(fCnt);

                var Cnt = arguments.length;
                for (var i = 0; i < Cnt; i++) {
                    work.push(arguments[i]);
                }
                var str = "[" + fileName + "]\t[" + work.join("][") + "]";
                //var message = encodeURIComponent(str);
                var message = (str);
                var sendObj = {
                    Name: "debug",
                    LogData: message
                }
                send_PostMessage(sendObj);
            }
            catch (e) {
                alert("log error" + e.message);
            }
        },
        log: function () {
            try {
                if (debug_mode != true) return;
                var loginMail = "";//$.session("loginMail");
                var o = this;
                var fCnt = [window.debugTab[fileName]++];
                fCnt = ("000".concat(fCnt)).substr(-3);
                var work = [];
                work.push(fCnt);

                var Cnt = arguments.length;
                for (var i = 0; i < Cnt; i++) {
                    work.push(arguments[i]);
                }
                var str = "[" + fileName + "]\t[" + work.join("][") + "]";
                //var message = encodeURIComponent(str);
                var message = (str);
                var sendObj = {
                    Name: "log",
                    LogData: message
                }

                send_PostMessage(sendObj);
            }
            catch (e) {
                //alert("log error");
            }
        },
        note: function () {
            try {
                if (debug_mode != true) return;
                var o = this;
                var fCnt = [window.debugTab[fileName]++];
                fCnt = ("000".concat(fCnt)).substr(-3);
                var work = [];
                work.push(fCnt);

                var Cnt = arguments.length;
                for (var i = 0; i < Cnt; i++) {
                    work.push(arguments[i]);
                }
                var str = "[" + fileName + "]\t[" + work.join("][") + "]";
                //var message = encodeURIComponent(str);
                var message = (str);
                var sendObj = {
                    Name: "note",
                    LogData: message
                }

                send_PostMessage(sendObj);
            }
            catch (e) {
                //alert("log error");
            }
        },
        json: function () {
            try {
                if (debug_mode != true) return;
                var o = this;
                var fCnt = [window.debugTab[fileName]++];
                fCnt = ("000".concat(fCnt)).substr(-3);
                var work = [];
                work.push(fCnt);
                var Cnt = arguments.length;
                var str = "[" + fileName + "]\t[" + work.join("][") + "]";
                str += "\n" + "[" + arguments[0] + "]";
                str += "\n" + JSON.stringify(arguments[1], null, 2);
                var message = (str);
 
                var sendObj = {
                    Name: "note",
                    LogData: message
                }

                send_PostMessage(sendObj);
            }
            catch (e) {
                //alert("log error");
            }
        }

    };

    function send_PostMessage(sendObj) {
        try {
            if (debug_mode == false) return;
            var stat;
            $.ajax({
                url: debugUrl,
                async: false,
                data: sendObj,
                type: 'POST',                  //GET,POSTを指定してHTTPの通信タイプを決定
                dataType: 'text',               //json,jsonp,html,text,script,xmlが指定できます。
                //processData: false,
                success: function (response) {    //成功した場合に走る関数です。
                    stat = "OK" + response;
                },
                error: function (response) {
                    stat = "NG" + response.responseText;
                    $.alert("send_PostMessage","error:", stat);
                }
            }
            );
        } catch (e) {
            $.alert("send_PostMessage", e.message)
        }
    }

    function getFileName() {
        var str = $(location).attr('pathname');
        var name = str.slice(str.lastIndexOf("/") + 1);
        return (name);
    }
    function getFunctionName(func, argsType, args) {
        var re = /^function\s*(\w*)(\s*\(.*\))/;
        var arr = re.exec(func.toString());

        if (argsType === 1) {
            //  get function name and dummy arguments
            return arr[1] + arr[2];
        } else if (argsType === 2) {
            // get function name and actual arguments
            var argsX = (args.length === 1 ? [args[0]] : Array.apply(null, args));
            return arr[1] + "(" + argsX + ")";
        } else {
            // get only function name
            return arr[1];
        }
    }
    $.debug = function (method) {
        if (window.location.port == "") return;             // デバック以外の時実行しない
        var work = [];
        var Cnt = arguments.length;
        for (var i = 0; i < Cnt; i++) {
            work.push(arguments[i]);
        }
        //alert(work.join("\n"));
        //return (this);
        //===========================================
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);           // 指定がなければ[init]を実行する
        }
        else {
            return methods["debug"].apply(this, Array.prototype.slice.call(arguments, 0));
            //$.alert("Method " + method + " この機能は設定されていません [ jQuery.tooltip ]");
        }

        //return (this);
    };
    $.debug.json = function () {
        return methods["json"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.debug.note = function () {
        return methods["note"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.debug.log = function () {
        return methods["log"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.debug.on = function () {
        return methods["on"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.debug.off = function () {
        return methods["off"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.debug.clear = function () {
        return methods["clear"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.debug.Abandon = function () {
        return methods["Abandon"].apply(this, Array.prototype.slice.call(arguments, 0));
    }
    $.alert = function () {
        var work = [];
        var Cnt = arguments.length;
        for (var i = 0; i < Cnt; i++) {
            work.push(arguments[i]);
        }
        alert(work.join("\n"));
        return (this);
    }
})(jQuery);

