; (function ($) {
    $.call_ajax_api = function(mode, url, item, func, json, callback) {
        //$.alert("call_ajax_mode[" + mode + "]", url);
        window.status = "call_ajax_api[" + mode + "]";
        var options = {
            Item: item,
            Func: func,
            Json: JSON.stringify(json)
        };
        var result = $.ajax({
            url: url,
            type: mode,
            data: options,
            dataType: 'text',
            dataFilter: function (data, type) {
                data = data.replace(/\\/g, "").replace(/\"$/, "").replace(/^\"/, "");
                return (data);
            },
            //contentType: "application/json",
            //contentType: "application/xml",
            //contentType: "text/plain",
            async: false
        }).done(function (data, status, xhr) {
            returnValue = data;
            //$.alert(returnValue);
        }).fail(function (xhr, status, error) {
            returnValue = status;
            window.status = xhr.statusText;
            $.alert("call_ajax_api error:" + xhr.statusText);
        });
        return (returnValue);
    }
    $.call_ajax_api_json = function(mode, url, item, func, json, callback) {
        //$.alert("call_ajax_api_json[" + mode + "]", url);
        window.status = "call_ajax_api_json[" + mode + "]";
        var options = {
            Item: item,
            Func: func,
            Json: JSON.stringify(json)
        };
        var result = $.ajax({
            url: url,
            type: mode,
            data: options,
            dataType: 'json',
            dataFilter: function (data, type) {
                return (data);
            },
            //contentType: "application/json",
            //contentType: "application/xml",
            //contentType: "text/plain",
            async: false
        }).done(function (data, status, xhr) {
            returnValue = data;
        }).fail(function (xhr, status, error) {
            returnValue = status;
            window.status = xhr.statusText;
            $.alert("call_ajax_api_json error:" + xhr.statusText);
        });
        return (returnValue);
    }
    $.call_ajax_get = function(url, options) {

        // 受信側でidを指定したときは設定しないとエラーとなる
        // 漢字は渡せない
        //url += "?name5=漢字&Mssage=ABCDEF";
        // ajax:dataで渡したらモデュールでも受信できるが引数指定でも受信できる
        // 漢字も OK
        // Get では「data」を替えると複数のパラメータで呼べる

        $.debug("call_ajax_get", url);
        window.status = "call_ajax_get";
        var result = $.ajax({
            url: url,
            type: "GET",
            data: options,
            dataType: 'text',
            dataFilter: function (data, type) {
                return (data);
            },
            //contentType: "application/xml",
            //contentType: "text/plain",
            async: false
        }).done(function (data, status, xhr) {
            returnValue = data.replace(/\"$/, "").replace(/^\"/, "");
            //$.alert(returnValue);
        }).fail(function (xhr, status, error) {
            returnValue = status;
            //$.alert("error:" + xhr.statusText);
            window.status = "error:" + xhr.statusText;
        });
        return (returnValue);
    }
})(jQuery);
