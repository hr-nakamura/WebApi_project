<%@ Language=JScript %>
<%
//Response.Write("メンテナンスしています<BR>")
//Response.Write("しばらくお待ちください")
//Response.End
    var mailAddr = "";
        mailAddr = Session("mailAddress");
    if( mailAddr + "" == "undefined" ) mailAddr = "nakamura@eandm.co.jp";
    //Response.Write(mailAddr);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="shift_jis" />
    <title></title>
    <script src="_Content/_Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="_Content/_Scripts/jquery.my.webapi.js" type="text/javascript"></script>
    <script src="_Content/_Scripts/jquery.kansa.Query.js" type="text/javascript"></script>
    <script src="_Content/_Scripts/DocumentWindow.js" type="text/javascript"></script>
    <script src="_Content/_Scripts/json2.js" type="text/javascript"></script>
    <link href="_Content/_menu/menu.css" rel="stylesheet" type="text/css" />

    <script src="_Content/_debug/jquery.my.debug.js" type="text/javascript"></script>
    <script type="text/javascript">
		var mailAddress = "<%=mailAddr%>"
        var debug_mode = true;
        var mailPara = {
            mailAddr: mailAddress
        };
        var memberInfo = {};
        var hostInfo = {
            "name": "テスト　データ",
            "mail": "test@eandm.co.jp",
            "Tag": ["F_OK"]
        }
        var docWin;
        var viewXmlWindow;
        $(window).on("ready",function () {
            try {
                var hostName = (window.location.hostname == "localhost" ? "" : "http://" + window.location.hostname);

                $.debug("window.ready Start", mailAddress, hostName);

                if (mailAddress != "") {
                    mailPara.mailAddr = mailAddress;
                }
                docWin = new DocumentWindow();

                memberInfo = $.WebApi_json("projectInfo/memberInfo_json", mailPara);

                hostInfo.Tag.forEach(function (elem) { memberInfo.Tag.push(elem); });

                memberInfo["hostName"] = window.location.hostname;

                $(".debug").JsonOut(memberInfo);
                if (mailAddress == mailAddress) {
                    $(".debug").css("display", "block");
                }


            } catch (e) {
                $.alert("onready", e.message);
            }


        });
    </script>
    <script type="text/javascript">
        $(window).on("load",function () {
            try {
                $.debug("on.load Start", mailAddress);

                if (typeof (memberInfo) == "undefined" || memberInfo.name == null) {
                    alert("認証されていません、ログインしてください");
                    //window.open('about:blank', '_self').close();
                }
                else {
                    $(".memberName").text("【" + memberInfo.name + "】");
                    dispMenu();
                }
            } catch (e) {
                $.alert("onload", e.message);
            }
        });
        $(window).on("unload",function () {
            docWin.close();
        });
    </script>
    <script type="text/javascript">
        function dispMenu() {
            //var Tab = new $.UrlValueCollection();


            var xmlDoc = $.loadXMLDoc("_Content/_menu/menu.xml");
            var xslDoc = $.loadXMLDoc("_Content/_menu/menu.xslt");

            var root = $(xmlDoc).find("root");
            var modeInfo = xmlDoc.createElement("modeInfo");
            var modeText = xmlDoc.createTextNode("[" + memberInfo.Tag.join("][") + "]");
            modeInfo.appendChild(modeText);

            root.prepend(modeInfo);

            var Buff = $(xmlDoc).transformNode(xslDoc);
            $(".menu").html(Buff);

            //hostInfo["url"] = Tab;


            // 有効なメニューだけを表示
            $(".menu").find("a").each(function (i, elem) {
                $(elem).parents("div[class='content'],div[class='block'],div[class='列']").each(function (i2, elem2) {
                    var value = (elem2.className == "列" ? "table-cell" : "block");
                    $(elem2).css("display", value);
                });
            });

            // a の中の[mode属性]を削除
            $(".menu a").removeAttr('mode');
            // div の中の[display:none]を削除
            $(".menu div[style='display: none;']").remove();

            // メニュー選択時の動作
            $(".menu").find("a").each(function (i, elem) {
                elem.style.color = fColor;
                $(elem).on("click", menu_click);
                $(elem).on("mouseenter", mouseenter);
                $(elem).on("mouseleave", mouseleave);
            });


            // メニュー全体の表示
            $(".main").css("display", "block");

        }
    </script>
    <script type="text/javascript">
        var windowTab = [];
        var fColor = "royalblue"
        var sColor = "red"

        function menu_click() {
            var url = this.getAttribute("url");
            var randomh = Math.random();
            url += "?ts=" + randomh;
            if (url) {
                alert(url);
                docWin.open(url);
                //w_open(url);
            }
            return (false);
        }

        function mouseenter() {
            var url = this.getAttribute("url");
            if (url) {
                this.style.backgroundColor = "";
                this.style.color = sColor;
                this.style.cursor = "pointer"
                this.style.textDecoration = "underline";
            }
            window.status = url;
        }
        function mouseleave() {
            this.style.backgroundColor = "";
            this.style.color = fColor;
            this.style.cursor = "";
            this.style.textDecoration = "";
            window.status = "";
        }

        function w_open(url) {
            try {
                var sizeX = parent.document.body.clientWidth;
                var sizeY = parent.document.body.clientHeight;
                window.status = "[" + sizeX + "][" + sizeY + "]";
                var para = [];
                //                if (typeof (sizeX) == "number") para.push("width =" + sizeX);
                //                if (typeof (sizeY) == "number") para.push("height=" + sizeY);
                para.push("directories=no");
                para.push("location=yes");
                para.push("menubar=yes");
                para.push("toolbar=no");
                para.push("status=no");
                para.push("scrollbars=yes");
                para.push("resizable=yes");

                var Cnt = windowTab.length;
                var winName = this.name + String(Cnt);
                windowTab.push(window.open(url, winName, para.join(",")));
            } catch (e) { alert(e.message) }
        }
        function w_close() {
            var Cnt = windowTab.length
            for (var n = 0; n < Cnt; n++) {
                if (windowTab[n] != null && !windowTab[n].closed) windowTab[n].close();
            }
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $("a", document).on("mouseenter", function (e) {
                alert("X");
            });
        });
    </script>

    <script type="text/javascript">
            $.loadJSONDocX = function (url) {
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
//                        Buff["Arg"] = nvc.ToEncodeString();
                        Buff["Arg"] = nvc.ToString();
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
        }
    </script>
    <style type="text/css">
        body {
            overflow: hidden;
            background: url(_Content/_images/bg00.gif);
        }

        div.main {
            display: none;
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            border: 0px solid green;
        }

        div.menu {
            font-size: x-small;
            display: table;
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            border: 0px solid yellow;
        }

        div.列 {
            vertical-align: top;
            display: table;
            margin-left: auto;
            margin-right: auto;
            border: 0px solid blue;
        }

        div.block {
            display: table;
            margin-left: auto;
            margin-right: auto;
            padding: 4px;
            border: 0px solid green;
        }

        div fieldset {
            border: 1px solid skyblue;
        }

        div.content {
            font-size: small;
            *display: table;
            padding: 4px;
            margin-left: auto;
            margin-right: auto;
            border: 0px solid green;
        }


        div > label {
            display: block;
            padding: 1px 20px;
            white-space: nowrap;
            margin-left: auto;
            margin-right: auto;
            border: 0px solid skyblue;
        }

        div > a {
            display: block;
            padding: 1px 10px;
            white-space: nowrap;
            margin-left: auto;
            margin-right: auto;
            /*border: 0px solid pink;*/
        }
    </style>
</head>
<body>

    <div class="main">
        <h4><STRONG>ＥＭＧ プロジェクト情報</STRONG></h4>
        <div>
            <span class="memberName" />
        </div>

        <div class="menu" />
    </div>
    <div style="vertical-align:bottom;text-align:left;">
        <textarea class="debug" style="display:none;">
        </textarea>
    </div>
</body>
</html>
