(function ($) {
    let $this = null;
    let $type = null;
    let $targetInfo = null;
    let $theadInfo = null;
    let $headerInfo = [];
    var settings = {
        border: "none",
        margin: 0,
        padding: 0
        };
    var methods = {
        Info: function (p1, p2) {
            //getInfo($this); 
        },
        src: function (p1, p2) {
            if ($type == "IFRAME") {
                $($this).attr("src", p1);
            }
        },
        html: function (html) {
            if ($type == "DIV") {
                //var o2 = $.stopwatch();

                //$(o2).stopwatch("html load");
                $($this).html(html);
                if ($targetInfo == null) {
                    //$.debug("init $targetInfo");
                    $targetInfo = $($this).Info();
                }
                if ($theadInfo == null) {
                    //$.debug("init $theadInfo");
                    $theadInfo = $("thead", $this).Info();
                }

                //$(o2).stopwatch("table_resize");
                table_resize($this);


                //$(o2).stopwatch("設定１");
                //$("table", $this).css("border-collapse", "collapse");
                //$("table thead", $this).css({ "display": "block", "overflow-y": "hidden" });
                //$("table tbody", $this).css({ "display": "block", "overflow-y": "scroll" });
                //$("table th", $this).css("table-layout", "fixed");
                //$("table td", $this).css("table-layout", "fixed");
                var len = $("table th", $this).length;
                if (len > 0 ) {
                    var total = 0;
                    //$(o2).stopwatch("設定2-1");
                    if ($headerInfo.length == 0) {
                        $("table th", $this).each(function (i, elem) {
                            //$(o2).stopwatch("設定2-2" + "][" + i + "][" + elem.className + "][" + elem.clientWidth);
                            $headerInfo.push(elem.clientWidth);
                        });
                    }
                    $($headerInfo).each(function (index,value) {
                        total += value;
                    });

                    //$(o2).stopwatch("設定2-3");
                    //total += ($targetInfo.margin.left);    
                    //$($this).css("width", total);
                }
                //var Buff = $(o2).stopwatch();
                //$.debug("html", Buff);

            }
        },
        init: function (options) {
            if (typeof (options) == "object") {
                settings = $.extend(settings, options);
            }
            if (this.length == 0) {
                return;
            }
            $type = $(this)[0].nodeName;
            if ($type == "DIV") {
                $this = $(this);
                $this.css(settings);
                $("body").css("overflow", "hidden");
                frame_init($this);
                frame_resize($this);
                //table_resize($(".target"));

                //return ($this);
            }
            else if ($type == "IFRAME") {
                $this = $(this);
                $this.css(settings);
                $("body").css("overflow", "hidden");
                frame_init($this);
                iframe_resize($this);
            }
        }
    }
    function frame_init(o) {
        //$.debug("frame_init");
        //var o2 = $.stopwatch();
        //$(o2).stopwatch("frame_init start");
        var target_name = $(o)[0].className;
        var parentElem = $(o).parent();
        var headerElem = $("<div/>");
        var footerElem = $("<div/>");
        $(headerElem).attr("class", target_name + "_header");
        $(footerElem).attr("class", target_name + "_footer");
        $(headerElem).css("background", "");
        $(footerElem).css("background", "");
        var childElem = $(parentElem).children();
        // targetまではheaderElemに入れてそれ以降はfooterElemに入れる
        var currentElem = headerElem;
        $(childElem).each(function (i, elem) {
            var Info = $(elem).Info();
            if (Info.name.class == target_name) {
                currentElem = footerElem;
            }
            else {
                $(currentElem).append(elem);
            }
        });
        $(parentElem).prepend(headerElem);
        $(parentElem).append(footerElem);
        //var Buff = $(o2).stopwatch();
        //$.debug("frame_init", Buff);
    }
    function frame_resize(o) {
        //$.debug.json("frame_resize", o);
        //var o2 = $.stopwatch();
        //$(o2).stopwatch("frame_resize start");
        var target_name = $(o)[0].className;
        var parentElem = $(o).parent();
        var targetHeight = window.innerHeight;
        //var targetHeight = $("html").Info().client.height;
        var childElem = $(parentElem).children();
        var total = 0;
        $(childElem).each(function (i, elem) {
            var Info = $(elem).Info();
            if ( Info.name.class != target_name ) {
                var sum = 0;
                sum += (Info.content.height);
                sum += (Info.margin.top + Info.margin.bottom);
                sum += (Info.padding.top + Info.padding.bottom);
                sum += (Info.border.top + Info.border.bottom);
                total += sum;
            }
        });
        // body
        var body = $("body").Info();
        var body_size = 0;
        body_size += (body.margin.top + body.margin.bottom);
        body_size += (body.padding.top + body.padding.bottom);
        body_size += (body.border.top + body.border.bottom);

        // target
        var target = $(o).Info();           
        var target_size = 0;
        target_size += (target.margin.top + target.margin.bottom);
        target_size += (target.padding.top + target.padding.bottom);
        target_size += (target.border.top + target.border.bottom);
        var adjust = 1;         //16;
        var newHeight = targetHeight - ( total + body_size + target_size) - adjust;
        $(o).css("height", newHeight);
        $table = $("table", o);
        if ($table.length == 1) {
            table_resize($table);
        }
        //var Buff = $(o2).stopwatch();
        //$.debug("frame_resize", Buff);
    }
    function iframe_resize(o) {
        //$.debug.json("iframe_resize", o);
        //var o2 = $.stopwatch();
        //$(o2).stopwatch("iframe_resize start");
        var target_name = $(o)[0].className;
        var parentElem = $(o).parent();
        var targetHeight = window.innerHeight;
        //var targetHeight = $("html").Info().client.height;
        var x = $(parentElem).children();
        var total = 0;
        $(x).each(function (i, elem) {
            var Info = $(elem).Info();
            if ( Info.name.class != target_name ) {
                var sum = 0;
                sum += (Info.content.height);
                sum += (Info.margin.top + Info.margin.bottom);
                sum += (Info.padding.top + Info.padding.bottom);
                sum += (Info.border.top + Info.border.bottom);
                total += sum;
//                $.debug("==========",sum);
            }
        });
        // body
        var bodyInfo = $("body").Info();
        var body_size = 0;
        body_size += (bodyInfo.margin.top + bodyInfo.margin.bottom);
        body_size += (bodyInfo.padding.top + bodyInfo.padding.bottom);
        body_size += (bodyInfo.border.top + bodyInfo.border.bottom);
        // target
        var targetInfo = $(o).Info();
        var target_size = 0;
        target_size += (targetInfo.margin.top + targetInfo.margin.bottom);
        target_size += (targetInfo.padding.top + targetInfo.padding.bottom);
        target_size += (targetInfo.border.top + targetInfo.border.bottom);
        var adjust = 0;         //30;
        var newHeight = targetHeight - ( total + body_size + target_size) - adjust;
        var width = bodyInfo.client.width - (targetInfo.border.left + targetInfo.border.right);
        $(o).css("height", newHeight).css("width", width);
        //var Buff = $(o2).stopwatch();
        //$.debug("iframe_resize", Buff);
    }
    function table_resize(o) {
        //$.debug.json("table_resize", o);
        var work = [];
        //var o2 = $.stopwatch();
        //$(o2).stopwatch("table_resize start");
        //if ($targetInfo == null) {
            //$(o2).stopwatch("$targetInfo");
            $targetInfo = $($this).Info();
        //}
        //if ($theadInfo == null) {
            //$(o2).stopwatch("$theadInfo");
            $theadInfo = $("thead", $this).Info();
        //}

        var targetHeight = $targetInfo.client.height;
        var tableHeight = 0;
        var theadHeight = 0;
        var thead = $theadInfo;
        // theadの高さ情報
        theadHeight += thead.margin.top + thead.margin.bottom;
        theadHeight += thead.border.top + thead.border.bottom;
        theadHeight += thead.padding.top + thead.padding.bottom;
        theadHeight += thead.client.height;
        // tbodyの高さ設定
        var adjust = 0;
        var bodyHeight = targetHeight - theadHeight - adjust;
        $("tbody", o).css("height", bodyHeight);
        //var Buff = $(o2).stopwatch();
        //$.debug("table_resize", Buff);
        work.push({ "11": thead.client.height });       //33
        work.push({ "12": targetHeight });
        work.push({ "15": bodyHeight });
        //$.debug.json("AAA", work);
    }

    $.fn.frame = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === "object" || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error("Method " + method + " does not exist on jQuery.my.frame");
        }
    };
    $(window).on("resize", function () {
        //$.debug("main resize" ,this.innerHeight,this.innerWidth);
        if ($this != null) {
            if ($type == "DIV") {
                $targetInfo = null;
                $theadInfo = null;
                frame_resize($this);
            }
            else {
                iframe_resize($this);
            }
        }
        return (false);
    });
    $.fn.Info = function () {
        var o2 = $.stopwatch();
        $(o2).stopwatch("1");
        var a = 1;
        var Info = {
            name: {
                class: "",
                tag: ""
            },
            position: {
                top: 0,
                left: 0
            },
            offset: {
                top: 0,
                left: 0,
                width: 0,
                height: 0
            },
            content: {
                width: 0,
                height: 0,
                text: ""
            },
            scroll: {
                top: 0,
                left: 0,
                width: 0,
                height: 0
            },
            client: {
                top: 0,
                left: 0,
                width: 0,
                height: 0
            },
            margin: {
                top: 0,
                bottom: 0,
                left: 0,
                right: 0
            },
            border: {
                top: 0,
                bottom: 0,
                left: 0,
                right: 0
            },
            padding: {
                top: 0,
                bottom: 0,
                left: 0,
                right: 0
            }
        }
        $(o2).stopwatch("2");
        if ($(this).length > 0) {
            $.each($(this), function () {
                var a = 1;
                Info.position = {
                    top: $(this).position().top,
                    left: $(this).position().left
                };
                Info.margin = {
                    top: Number($(this).css('margin-top').replace('px', '')),
                    bottom: Number($(this).css('margin-bottom').replace('px', '')),
                    left: Number($(this).css('margin-left').replace('px', '')),
                    right: Number($(this).css('margin-right').replace('px', ''))
                };
                Info.border = {
                    top: Number($(this).css('border-top-width').replace('px', '')),
                    bottom: Number($(this).css('border-bottom-width').replace('px', '')),
                    left: Number($(this).css('border-left-width').replace('px', '')),
                    right: Number($(this).css('border-right-width').replace('px', ''))
                };
                Info.padding = {
                    top: Number($(this).css('padding-top').replace('px', '')),
                    bottom: Number($(this).css('padding-bottom').replace('px', '')),
                    left: Number($(this).css('padding-left').replace('px', '')),
                    right: Number($(this).css('padding-right').replace('px', ''))
                };
                Info.client = {
                    top: Number($(this)[0].clientTop),
                    left: Number($(this)[0].clientLeft),
                    width: Number($(this)[0].clientWidth),
                    height: Number($(this)[0].clientHeight)
                };
                Info.scroll = {
                    top: Number($(this)[0].scrollTop),
                    left: Number($(this)[0].scrollLeft),
                    width: Number($(this)[0].scrollWidth),
                    height: Number($(this)[0].scrollHeight)
                };
                Info.offset = {
                    top: Number($(this)[0].offsetTop),
                    left: Number($(this)[0].offsetLeft),
                    width: Number($(this)[0].offsetWidth),
                    height: Number($(this)[0].offsetHeight)
                };
                Info.content = {
                    width: Number($(this).css('width').replace('px', '')),
                    height: Number($(this).css('height').replace('px', ''))
                };
                Info.name = {
                    class: $(this)[0].className,
                    tag: $(this)[0].tagName
                };
            });
        }
        else {
            var x = 1;
        }
        $(o2).stopwatch("3");

        //$.debug("ABCDEFG", typeof (Info));
        if (typeof (Info) == "undefined") {
            var a = 1;
        }
        $(o2).stopwatch("4");
        var Buff = $(o2).stopwatch();
        if ($(this).length > 0) {
            $.debug("Info", $(this)[0].localName, $(this)[0].className, Buff);
        }

        return Info;
    }
})(window.jQuery);