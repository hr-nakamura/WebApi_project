(function ($) {

    $.fileOut = function (fName,str) {
        var sendObj = {
            Name: fName,
            Str: str
        }

        send_PostMessage(sendObj);
        return (this);
    }
    function send_PostMessage(sendObj) {
        try {
            var debugUrl = "/WebApi/project/__menu/debug/fileOut.ashx";     // + para.join("&");
            var stat;
            //$.alert(sendObj.LogData);

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
                    $.alert("send_PostMessage", "error:", stat);
                }
            }
            );
        } catch (e) {
            $.alert("send_PostMessage", e.message)
        }
    }
})(jQuery);
