
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
            $(element).data("tab", []);
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
//            $.debug(Buff);
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
