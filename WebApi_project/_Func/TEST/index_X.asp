<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <META http-equiv="Content-Type" content="text/html; charset=SHIFT_JIS">
    <META http-equiv="X-UA-Compatible" content="IE=5" />

    <script src="/WebApi/Project/_home/_Content/_Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="/WebApi/Project/_home/_Content/_Scripts/jquery.my.Query.js" type="text/javascript"></script>
    <title></title>

    <script type="text/javascript">
        $(window).on("load", function () {
try{
            var a = 1;
            $.alert("onload",$(DB)[0].DataURL);
            //            alert("ABC");
}catch(e){
	alert(e.message);
}
        })
    </script>
    <script type="text/javascript">
        $(function () {
            $(".test").on("click", function () {
try{
                DB.Filter = "";
                DB.DataURL = "projectDataCsv.asp";
                DB.Reset();
		$.alert("click");
}catch(e){
alert(e.message);
}
            });

        });
    </script>
    <script type="text/javascript">
	; (function ($) {
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
    </script>
    <script type="text/javascript">

        //DB.ondatasetcomplete = function () {
        //    alert("XXX");
        //}
        $(function () {
            //    $(DB).on("datasetcomplete", function () {
            //        alert("XYZ");
            //        //alert(DB.recordset.recordCount)
            //        /*
            //           ondatasetchanged   ………データセットが変更されたとき
            //           ondataavailable	  ………レコードが1つ読み込まれたとき(ステータスバーに数値表示)
            //           ondatasetcomplete  ………データセットがキャッシュに保存されたとき
            //           onreadystatechange ………
            //           readyState
            //        */
            //        var Cnt = DB.recordset.recordCount

            //    })
        });
    </script>

</head>
<body>
    <input type="button" class="test" value="TEST" />
</body>
</html>
<OBJECT ID="DB" classid="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83">
    <PARAM NAME="UseHeader" VALUE="true">
    <PARAM NAME="FieldDelim" VALUE=",">
    <PARAM NAME="Sort" VALUE="-pNum">
    <PARAM NAME="Filter" VALUE="newFlag > 0">
    <PARAM NAME="CharSet" VALUE="shift_jis">
    <PARAM NAME="Language" VALUE="ja">
</OBJECT>
<SCRIPT FOR="DB" EVENT="ondatasetcomplete()" LANGUAGE="JavaScript">
    alert("zzz");
//    <PARAM NAME="DataURL" VALUE="project.csv">
</SCRIPT>

<script type="text/javascript">
    DB.ondatasetcomplete = function () {
        var Cnt = DB.recordset.recordCount;
        alert("XXX" + Cnt);
    }
    DB.ondatasetchanged = function () {
        var Cnt = DB.recordset.recordCount;
        alert("XXX" + Cnt);
    }
    DB.ondataavailable = function () {
        var Cnt = DB.recordset.recordCount;
        alert("XXX" + Cnt);
    }
    DB.onreadystatechange = function () {
        var Cnt = DB.recordset.recordCount;
        alert("XXX" + Cnt);
    }
</script>
