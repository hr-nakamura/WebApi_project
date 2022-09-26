; (function ($) {
    var hostName = (window.location.hostname == "localhost" ? "" : "http://" + window.location.hostname);
    var WebApi_url_xml = hostName + "/WebApi/project/api/xml";
    var WebApi_url_json = hostName + "/WebApi/project/api/json";
    var WebApi_url_test = hostName + "/WebApi/project/api/test";
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
// xml ====================================================================
        $.WebApi = function (item, json) {
            $.debug("$.WebApi(" + WebApi_url_xml + ") : item, json", item,json);
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
// json ====================================================================
        $.WebApi_json = function (item, json) {
            $.debug("$.WebApi_json(" + WebApi_url_json + ") : item, json", item, json);
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
// test ====================================================================
        $.WebApi_test = function (mode, className, methodName, json) {
            $.debug("$.WebApi_test(" + WebApi_url_test + ") : mode, className, methodName, json", mode, className, methodName, json);
            var options = {
                mode: mode,
                className: className,
                methodName: methodName,
                Json: (typeof (json) == "object" ? JSON.stringify(json) : json)
            };
            $.debug("XXX", mode, className, methodName);
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
                    returnValue = data;
                }
            }).fail(function (xhr, status, error) {
                returnValue = status;
                window.status = xhr.statusText;
                $.alert("WebApi_json error:" + xhr.statusText);
            });
            return (returnValue);
        },
        $.WebApi_menu = function (func) {
            $.debug("$.WebApi_menu(" + WebApi_url_test + ") : func", func);
            var options = {
                func: func
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
                returnValue = $.str2xml(data);
            }).fail(function (xhr, status, error) {
                returnValue = status;
                window.status = xhr.statusText;
                $.alert("WebApi_json error:" + xhr.statusText);
            });
            return (returnValue);
        },

// 使っていない
        $.WebApi_get = function (item, json) {
            $.debug("$.WebApi_get(" + WebApi_url_test + ") : item, json");
            window.status = "WebApi_get";
            var options = {
                Item: item,
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
                returnValue = $.str2xml(data);
            }).fail(function (xhr, status, error) {
                returnValue = status;
                //$.alert("error:" + xhr.statusText);
                window.status = "error:" + xhr.statusText;
            });
            return (returnValue);
        }

}) (jQuery);
