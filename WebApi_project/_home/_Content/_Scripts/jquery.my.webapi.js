; (function ($) {
        var hostName = (window.location.hostname == "localhost" ? "" : "http://" + window.location.hostname);
        var x = window.location.pathname.split("/");
    //hostName = "http://kansa.in.eandm.co.jp";

    // 非同期実行
        $.asyncExecute = function (method, para) {
        // Promise を返す
            return new Promise(function () {
                setTimeout(function () {
                    method(para);
                }, 1);
            });
        },
        $.WebApi = function(item, json) {
            var WebApi_url_xml = hostName + "/WebApi/project/api/xml";

            $.debug("_home/WebApi", WebApi_url_xml);
            var options = {
                Item: item,
                Json: (typeof(json) == "object" ? JSON.stringify(json) : json)
           };
            var result = $.ajax({
                url: WebApi_url_xml,
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
                window.status = xhr.statusText;
                $.alert("WebApi error:" + xhr.statusText);
            });
            return (returnValue);
        },
            $.WebApi_json = function (item, json) {
                var WebApi_url_json = hostName + "/WebApi/project/api/json";
                $.debug("_home/WebApi_json", WebApi_url_json);
                var options = {
                    Item: item,
                    Json: (typeof (json) == "object" ? JSON.stringify(json) : json)
                };
                var result = $.ajax({
                    url: WebApi_url_json,
                    type: "GET",
                    data: options,
                    dataType: 'text',
                    dataFilter: function (data, type) {
                        return (data);
                    },
                    async: false
                }).done(function (data, status, xhr) {
                    returnValue = JSON.parse(data);
                }).fail(function (xhr, status, error) {
                    returnValue = status;
                    window.status = xhr.statusText;
                    $.alert("WebApi_json error:" + xhr.statusText);
                });
                return (returnValue);
            },
            $.WebApi_test = function (mode, className, methodName, json) {
                var WebApi_url_test = hostName + "/WebApi/project/api/test";
                $.debug("_home/WebApi_test", WebApi_url_test,mode,className,methodName,json);
                var options = {
                    mode: mode,
                    className: className,
                    methodName:methodName,
                    Json: (typeof (json) == "object" ? JSON.stringify(json) : json)
                };
                var result = $.ajax({
                    url: WebApi_url_test,
                    type: "GET",
                    data: options,
                    dataType: 'text',
                    dataFilter: function (data, type) {
                        return (data);
                    },
                    async: false
                }).done(function (data, status, xhr) {
                    if (mode == "xml") {
                        returnValue = $.str2xml(data);
                    }
                    else {
                        returnValue = JSON.parse(data);
                    }
                }).fail(function (xhr, status, error) {
                    returnValue = status;
                    window.status = xhr.statusText;
                    $.alert("WebApi_json error:" + xhr.statusText);
                });
                return (returnValue);
            },
        $.WebApi_get = function(url, options) {
            //WebApi_url = hostName + "/WebApi/project/api/xml";
            $.debug.no("_home/WebApi_get");
            window.status = "WebApi_get";
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
