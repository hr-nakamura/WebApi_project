(function ($) {
    $.showModalDialog = function(){
        if (arguments.length == 3 && typeof (arguments[0]) == "string") {
            $.showDialog1(arguments[0], arguments[1], arguments[2]);
        }
        else if (arguments.length == 2 && typeof (arguments[0]) == "object") {
            $.showDialog2(arguments[0], arguments[1]);

        }
    }

    $.showDialog1 = function (url, para, callBack) {
        if ($(".iFBox").dialog("isOpen") == true) return;
        var work = [];
        work.push("return_elementName=iFBox");
        work.push(para);
        var src_str = "".concat(url, "?", work.join("&"));
        $("<iframe class='iFBox'></iframe>").dialog({
            dialogClass: "wkDialogClassMain",
            closeOnEscape: true,
            modal: true,
            minHeight: 660,
            minWidth: 640,
            autoOpen: true,
            title: 'タイトル',
            height: 660,
            width: 640,
            open: function () {
                set_returnProc(this);
                $(this).css("width", "100%");
                $(this).css("padding", "0px");
                $(this).attr({ "src": src_str });
            },
            close: function () {
                $(this).dialog('destroy');

            }
        });

        // 終了処理
        function set_returnProc($this) {
            //$($this).append("<span />");
            $($this).on("click", function () {
                var ret = JSON.parse($($this).text());
                var para = $($this).attr("status");
                callBack(ret);

                $($this).dialog('close');
            });

        }
    }

    $.showDialog2 = function (Buff, callBack) {
        if ($(".iFBox").dialog("isOpen") == true) return;
        var Work = [];
        Work.push(Buff.HEAD);
        Work.push("<input type='text' class='inputText' value='" + Buff.VALUE + "' />");
        Work = Work.join("<br>");
        var retVal = "";
        $("<div class='iFBox'></div>").dialog({
            dialogClass: "wkDialogClass",
            closeOnEscape: false,
            autoOpen: true,
            modal: true,
            title: Buff.TITLE,
            height: "auto",
            width: "auto",
            buttons: [
                {
                    text: "登録",
                    class: "wkBtnOk",
                    click: function () {
                        retVal = $(".inputText", $(this)).val();
                        $(this).dialog("close");
                    }
                },
                {
                    text: "取消",
                    class: "wkBtnNg",
                    click: function () {
                        retVal = "";
                        $(this).dialog("close");
                    }
                }],
            open: function () {
                $(this).html(Work);
                $(".inputText").focus();
            },
            close: function () {
                $(this).dialog('destroy');

                // 終了処理を実行
                callBack(retVal);
            }
        });
    }

})(window.jQuery);