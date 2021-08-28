(function (window, document, $, undefined) {
    /**
    * テキスト入力が確定したとき指定されたイベントハンドラを呼び出します。
    * @param    handler     {function}  イベントハンドラ。イベントハンドラは jQuery.Event を引数にとる。
    * @return   {jQuery}    jQueryオブジェクト
    */
    $.fn.complete = function (handler) {
        var ENTER_CHAR = "\n";
        var ENTER_KEY = 13;
        var CONVERT = 229;
        var keypressed = false;

        /**
        * keypressイベント発生時に呼び出されます。
        * @param    event   {jQuery.Event}  イベントオブジェクト
        */
        var onkeypress = function (e) {
            //eventOut(this, event);
            //$.debug("==onkeypress==", event.type, this.value, event.isComposing, event.key, event.code, event.char);
            //handler.call(this, event);
            return;
        };

        /**
        * keyupイベント発生時に呼び出されます。
        * @param    event   {jQuery.Event}  イベントオブジェクト
        */
        var onkeyup = function (e) {
            var keyTab = [
                3, // Cancel
                6, // Help
                9, // TAB
                15, // Command
                16, // Shift
                17, // Ctrl
                18, // Alt
                19, // Pause
                20, // Caps Lock
                21, // KANA
                22, // Mac"英数" キー
                23, // JUNJA
                24, // FINAL
                25, // KANJI
                27, // Esc
                28, // 「前候補・変換」
                29, // 「無変換」
                30, // ACCEPT
                31, // MODECHANGE
                33, // Page Up
                34, // Page Down
                35, // End
                36, // Home
                37, 38, 39, 40, // 矢印
                41, // SELECT
                42, // PRINT
                43, // EXECUTE
                44, // Print Screen
                45, // Ins
                91, // 左Windowsキー
                92, // 右Windowsキー
                93, // 右クリックキー
                95, // SLEEP
                112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, // ファンクションキー
                124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, // ファンクションキー
                144, // Num Lock
                145, // Scroll Lock
                224, // Command
                225, // AltGr
                240, 241, // Caps Lock
                242, // 「カタカナ・ひらがな」
                243, 244  // 「半角・全角」
            ];

            //eventOut(this, event);
            //$.debug("==onkeyup==", event.type, this.value, event.isComposing, event.key, event.code, event.char);
            //if (event.keyCode === ENTER_KEY && keypressed) {
            if (event.keyCode && (event.char == ENTER_CHAR || event.code == "Enter")) {
                //$.debug("入力確定", event.type, this.value, event.keyCode, event.char, event.code, event.key);
                keypressed = false;
                // 入力確定のイベントを発生させます。
                handler.call(this, event);
                return;
            }
            else if (keypressed) {
                //$.debug("変換中", event.type, this.value, event.keyCode, keypressed);
                // 変換中
                return;
            }
            else if ($.inArray(event.keyCode, keyTab) >= 0) {
                //$.debug("onkeyup", "制御文字", event.type, this.value, event.keyCode);
                // 制御文字
                return;
            }
            //$.debug("onkeyup", event.type, this.value, event.keyCode);
            handler.call(this, event);
            return;
        };
        var onkeydown = function (e) {
            //eventOut(this, event);
            //$.debug("==onkeydown==", event.type, this.value, event.isComposing, event.key, event.code, event.char);
            if (event.keyCode === CONVERT) {
                //$.debug("変換中", event.type, this.value, event.keyCode);
                keypressed = true;
            }
        };
        var a = 1;
        // 各要素に対してイベントを付与します。
        return this.each(function (index) {
            $(this).on('keypress', onkeypress).on('keyup', onkeyup).on('keydown', onkeydown);
        });
    };
    function eventOut($this, e, para) {
        var keyInfo = {
            type: event.type,
            key: event.key,
            code: event.code,
            char: event.char,
            keyCode: event.keyCode,
            which: event.which,
            value: $this.value
            //id: $this.id,
            //class: $this.className,
            //tag: $this.tagName
        }
        if (typeof (para) == "object") {
            $.extend(keyInfo, para);
        }
        $.debug(JSON.stringify(keyInfo, null, 2));
    }
})(window, document, jQuery);

