//--------------------------------
//inputText画面表示
//--------------------------------
function dispInputText(url, para, myTitle, width, height){
    // Dialog要素追加
    $('body').append("<div id='Dialog'></div>");
    // showDialog.jsから呼び出し
    showDialog(url, para, myTitle, width, height, function() {    // 幅、高さ、コールバック処理を指定
        // ダイアログ設定追加
        $("#Dialog").dialog({
            closeOnEscape: false,            // Escキーによるclose許可
            position: {my: "center top+5%", at: "center top+5%", of: window},
            // 画面を閉じたときの処理
            close: function() {
                $("#frameDiv").remove();    // 前のコンテンツを削除
                $("#Dialog").remove();      // Dialog要素を削除
                switch (myTitle) {
                    case "会社名設定":
                        if( childlen_ReturnValue != "" ){
                            corpSEL.newValue = childlen_ReturnValue
                            T0.value = childlen_ReturnValue
                        }
                        corpInit(GrpSEL.Tab,T0.value)
                        break;
                    case "カテゴリー名1設定":
                        if( childlen_ReturnValue != "" ){
                            categorySEL1.newValue = childlen_ReturnValue
                            T_kindCategory1.value = childlen_ReturnValue
                            }
                        categoryInit(CategoryTab1,categorySEL1,T_kindCategory1.value)
                        break;
                    case "カテゴリー名2設定":
                        if( childlen_ReturnValue != "" ){
                            categorySEL2.newValue = childlen_ReturnValue
                            T_kindCategory2.value = childlen_ReturnValue
                            }
                        categoryInit(CategoryTab2,categorySEL2,T_kindCategory2.value)
                        break;
                    }
                }
            });
        });
    }