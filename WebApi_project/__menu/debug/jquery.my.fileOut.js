(function ($) {

    $.fileOut = function (fName,str) {
        var work = [];
        var Cnt = arguments.length;
        for (var i = 0; i < Cnt; i++) {
            work.push(arguments[i]);
        }
        alert(work.join("\n"));
        return (this);
    }
})(jQuery);
