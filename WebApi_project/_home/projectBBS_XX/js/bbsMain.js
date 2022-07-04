//--------------------------------
//editProject画面表示
//--------------------------------
function dispEditProject(url, para, myTitle, width, height){
    // Dialog要素追加
    $('body').append("<div id='Dialog'></div>");
    // showDialog.jsから呼び出し
    showDialog(url, para, myTitle, width, height, function() {    // 幅、高さ、コールバック処理を指定
        // ダイアログ設定追加
        $("#Dialog").dialog({
            closeOnEscape: false,            // Escキーによるclose許可
            // 画面を閉じたときの処理
            close: function() {
                $("#frameDiv").remove();    // 前のコンテンツを削除
                $("#Dialog").remove();      // Dialog要素を削除
                if(return_value) updateList(parent_pNum);
                }
            });
        });
    }