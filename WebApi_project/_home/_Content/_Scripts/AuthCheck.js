(function ($) {
    $(document).ready(function () {
        var __hostInfo__ = $.window.top.hostInfo;
        if (typeof (__hostInfo__) == "undefined" || __hostInfo__.mail == "") {
            alert('認証されていないので、実行できません\nログインしてください');
            window.open('about:blank', '_self').close();
        }
    })
})(window.jQuery);