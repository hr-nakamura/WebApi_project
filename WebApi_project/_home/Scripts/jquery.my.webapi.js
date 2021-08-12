; (function ($) {
    /*
            var hostName = (window.location.hostname == "localhost" ? "" : "http://" + window.location.hostname);
            var x = window.location.pathname.split("/");
            //hostName = "http://kansa.in.eandm.co.jp";
            WebApi_url = hostName + "/WebApi/project/api/xml";
            WebApi_url_json = hostName + "/WebApi/project/api/json";
            WebApi_url_test = hostName + "/WebApi/project/api/test";

     */ 
    // 非同期実行
        $.asyncExecute = function (method, para) {
        // Promise を返す
            return new Promise(function () {
                setTimeout(function () {
                    method(para);
                }, 1);
            });
        },
        $.WebApi = function(mode, url, item, json, callback) {
            //WebApi_url = hostName + "/WebApi/project/api/xml";
            window.status = "call_ajax_api[" + mode + "]";
            var options = {
                Item: item,
                Json: JSON.stringify(json)
           };
            var result = $.ajax({
                url: url,
                type: mode,
                data: options,
                dataType: 'text',
                dataFilter: function (data, type) {
                    return (data);
                },
                async: false
            }).done(function (data, status, xhr) {
                returnValue = $.str2xml(data);
            }).fail(function (xhr, status, error) {
                returnValue = status;
                window.status = xhr.statusText;
                $.alert("call_ajax_api error:" + xhr.statusText);
            });
            return (returnValue);
        },
        $.WebApi_json = function(mode, url, item, json, callback) {
            //WebApi_url_json = hostName + "/WebApi/project/api/json";
            window.status = "call_ajax_api_json[" + mode + "]";
            var options = {
                Item: item,
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
                async: false
            }).done(function (data, status, xhr) {
                returnValue = data;
            }).fail(function (xhr, status, error) {
                returnValue = status;
                window.status = xhr.statusText;
                $.alert("call_ajax_api_json error:" + xhr.statusText);
            });
            return (returnValue);
        },
        $.WebApi_get = function(url, options) {
            //WebApi_url = hostName + "/WebApi/project/api/xml";
            window.status = "call_ajax_get";
            var result = $.ajax({
                url: url,
                type: "GET",
                data: options,
                dataType: 'text',
                dataFilter: function (data, type) {
                    return (data);
                },
                async: false
            }).done(function (data, status, xhr) {
                returnValue = $.str2xml(data);
            }).fail(function (xhr, status, error) {
                returnValue = status;
                //$.alert("error:" + xhr.statusText);
                window.status = "error:" + xhr.statusText;
            });
            return (returnValue);
        }
})(jQuery);
