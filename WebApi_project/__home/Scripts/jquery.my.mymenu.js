(function ($) {
    $.fn.mymenu = function (method) {
        var methods = {
            init: function (value, options) {
                $(this).html("");
                if ($.isXMLDoc(value)) value = $.xml2str(value);
                if ($(value).find(">menu").length > 0) value = xml2menu(value);
                convertAttr(value);
                var div = $(value).addClass("bluemenu");
                this.append(div);
                var target = $(div).mnmenu();
                mymenu_init(target, options);
                return (target);
            },
            view: function (str) {
                var o_top = $("li.level-0", this);
                o_top.css("display", "none");
                var Tab = str.split(",");
                for (var i = 0; i < Tab.length; i++) {
                    var o = $(">li.level-0:contains('" + Tab[i] + "')", this);
					var reg = new RegExp("^" + Tab[i] + "$");
					var cnt = 0;
					$.each(o, function () {
                        var work = $(o[cnt]).html().split("<");
                        if (work[0].match(reg)) {
							$(o[cnt]).css("display", "");
						}
						cnt++;
                    });
                }
            }
        };

        function xml2menu(xmlDoc) {
            var node = $(xmlDoc).find(">menu");
            if (node.length == 0) return ("");
            var menu = $("<ul></ul>");
            $.each(node, function (i, elem) {
                var s_menu = $("<li></li>");
                var attrs = elem.attributes;
                for (var i = 0; i < attrs.length; i++) {
                    var name = attrs[i].name;
                    var value = attrs[i].value;
                    if (name == "name") {
                        $(s_menu).text(value);
                    }
                    else {
                        $(s_menu).attr(name, value);
                    }
                }
                $(menu).append(s_menu);
                if (elem.childNodes.length > 0) {
                    var work = cnvMenu_sub(elem);
                    $(s_menu).append(work);
                }
            });
            return (menu);
        }

        function cnvMenu_sub(menuNode) {
            var node = $(menuNode).find(">menu");
            if (node.length == 0) return ("");
            var menu = $("<ul></ul>");
            $.each(node, function (i, elem) {
                var s_menu = $("<li></li>");
                var attrs = elem.attributes;
                for (var i = 0; i < attrs.length; i++) {
                    var name = attrs[i].name;
                    var value = attrs[i].value;
                    if (name == "name") {
                        $(s_menu).text(value);
                    }
                    else {
                        $(s_menu).attr(name, value);
                    }
                }

                $(menu).append(s_menu);
                if (elem.childNodes.length > 0) {
                    var work = cnvMenu_sub(elem);
                    $(s_menu).append(work);
                }
            })
            return (menu);
        }
        function convertAttr(o) {
            $("li", o).each(function (i, elem) {
                set_attr(elem);
            })
        }
        function set_attr(elem) {
            var attrs = elem.attributes;
            var Tab = [];
            for (var i = 0; i < attrs.length; i++) {
                var name = attrs[i].name;
                var value = attrs[i].value;
                Tab.push({ name: name, value: value });
            }
            for (var i = 0; i < Tab.length; i++) {
                var name = Tab[i].name;
                var value = Tab[i].value;
                $(elem).removeAttr(name);
                //$.debug(name,value);
                if (name == "memo") {
                    $(elem).attr("title", value);
                }
                else if (name == "display") {
                    $(elem).css("display", value);
                }
                else {
                    $(elem).data(name, value);
                }
            }
        }

        //=========================================================================                
        if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);           // 指定がなければ[init]を実行する
        }
        else if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        else {
            $.alert("Method " + method + " この機能は設定されていません [ jquery.mymenu ]");
        }

        return (this);
    };


    //=========================================================================                

    function mymenu_init(target, my_options) {
        var options = {
            color_top_base: "",
            color_top_select: "",
            color_top_font: "white",
            color_top_font_select: "white",
            color_menu_base: "cornflowerblue",
            color_menu_select: "royalblue",
            color_menu_font: "white",
            color_menu_font_select: "white",
            click: ""
        };
        if (my_options) {
            $.extend(true, options, my_options);
        }

        var eventName = "";
        var className = $(target).parent().attr("class");
        var idName = $(target).parent().attr("id");

        if (typeof (idName) == "string") {
            eventName = "#" + idName + " ";
        }
        else if (typeof (className) == "string") {
            eventName = "." + className + " ";
        }
        else {
            return;
        }

        var top_height = $(target).parent().parent().css("height");
        $(eventName + ".bluemenu li.level-0").css("height", top_height);           // Top メニューの縦高さ
        $(eventName + ".bluemenu li.level-0").css("line-height", top_height);           // Top メニューの文字の縦位置

        if (options.color_top_base == "") options.color_top_base = $(target).parent().css("background-color");
        if (options.color_top_select == "") options.color_top_select = options.color_menu_select;

        var color_top_baseTab = [];
        var color_top_selectTab = [];
        var color_menu_baseTab = [];
        var color_menu_selectTab = [];

        color_top_baseTab.push(eventName + ".bluemenu li.level-0");
        color_menu_baseTab.push(eventName + ".bluemenu li.level-0 ul");



        $(color_top_baseTab.join(",")).css("background-color", options.color_top_base);            // Top メニュー
        $(color_menu_baseTab.join(",")).css("background-color", options.color_menu_base);          // sub メニュー
        $(color_top_baseTab.join(",")).css("color", options.color_top_font);                       // Top メニュー
        $(color_menu_baseTab.join(",")).css("color", options.color_menu_font);                     // sub メニュー



        // top hover
        $(eventName + ".bluemenu > li.level-0").hover(
            function () {
                $("span.arrow", this).css("border-bottom-color", options.color_menu_base);          // ▲マークの色
                $(this).css("background-color", options.color_top_select);
                $(this).css("color", options.color_top_font_select);
            },
            function () {
                $(this).css("background-color", options.color_top_base);
                $(this).css("color", options.color_top_font);
            }
        );
        // menu hover
        $(eventName + ".bluemenu li.level-0 li").hover(
            function () {
                $(this).css("background-color", options.color_menu_select);
                $(this).css("color", options.color_menu_font_select);
            },
            function () {
                $(this).css("background-color", options.color_menu_base);
                $(this).css("color", options.color_menu_font);
            }
        );
        // cursor
        $(eventName + ".bluemenu li").hover(
            function () {
                var o = $(this);
                if ($(o).children().length == 0) {
                    $(o).css("cursor", "pointer");
                }
            },
            function () {
                var o = $(this);
                if ($(o).children().length == 0) {
                    $(o).css("cursor", "auto");
                }
            }
        );

//        $("body").off("click", eventName + ".bluemenu li");
//        $("body").on("click", eventName + ".bluemenu li", function () {
        $(eventName + ".bluemenu li").click(function () {
            var o = $(this);
            if ($(o).children().length == 0) {
                //var execFunc = "menu_click";
                if (typeof (options.click) == "function") {
                    var obj = {
                        text: o.text()
                    };
                    var attrs = $(this).data();
                    $.each(attrs, function (name, elem) {
                        obj[name] = elem;
                    })
                    o.mouseleave();             // メニュを消す
                    options.click(obj);
                }
            }
        });
    };

})(jQuery);
