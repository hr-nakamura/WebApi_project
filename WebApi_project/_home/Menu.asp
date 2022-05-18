<%@ Language=JScript %>
<%
//Response.Write("メンテナンスしています<BR>")
//Response.Write("しばらくお待ちください")
//Response.End
    var mailAddr = "";

    try {
        mailAddr = Session("mailAddress");
    } catch (e) {
        mailAddr = e.message;
    }
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
            mailAddr: "test@eandm.co.jp"
        };
        var memberInfo = {};
        var hostInfo = {
            "name": "テスト　データ",
            "mail": "test@eandm.co.jp",
            "Tag": ["F_TEST"]
        }
        var docWin;
        var viewXmlWindow;
        $(window).ready(function () {
            try {
                var hostName = (window.location.hostname == "localhost" ? "" : "http://" + window.location.hostname);

                if ( mailAddress != "" ) {
                    mailPara.mailAddr = mailAddress;
                }
                docWin = new DocumentWindow();

                memberInfo = $.WebApi_json("projectInfo/memberInfo_json", mailPara);

                hostInfo.Tag.forEach(function (elem) { memberInfo.Tag.push(elem); });

                $(".debug").JsonOut(memberInfo);


            } catch (e) {
                $.alert("onready", e.message);
            }


        });
    </script>
    <script type="text/javascript">
        window.onload = function () {
            try {
                $.debug("onload Start");

                if (typeof (memberInfo) == "undefined" || memberInfo.mail == "") {
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
        }
        window.onunload = function () {
            docWin.close();
        }
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
            if (url) {
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
        <textarea class="debug">
        </textarea>
    </div>
</body>
</html>