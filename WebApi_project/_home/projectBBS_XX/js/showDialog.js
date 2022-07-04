//-------------------------------------------
// ダイアログの表示
// URL      :表示するURLを指定(例：testDialog.asp)
// para     :送信パラメータ (例：?membID=111&yymm=201501)
// dWidth   :ダイアログの横幅を指定
// dHeight  :ダイアログの縦幅を指定
// fnc      :追加処理
//-------------------------------------------
function showDialog(URL,para,dTitle,dWidth,dHeight,fnc){
    var dialogID=jQuery("#Dialog");             // Dialog表示領域
    dialogID.append("<iframe id='frameDiv' "
        +"frameborder='0' scrolling='yes' ></iframe>");
    var frameID=jQuery("#frameDiv");            // iFrame表示領域
    /* ダイアログ処理 */
    dialogID.dialog({                          // ダイアログの呼び出し
        title : dTitle,                        // タイトル
        width : dWidth,                        // 横幅
        height : dHeight,                      // 縦幅
        modal: true,                           // モーダル機能(メイン画面の操作不可)の設定
        closeOnEscape: false,                  // ESCキーで閉じないように
        resizable: false,                      // マウスのドラッグでサイズ変更不可に
        position: {                            // ダイアログの表示位置
            my: 'center',
            at: 'center',
            of: window
            },
        /* ダイアログを開く */
        open : function(){
            openDialog(URL,para,frameID,fnc,jQuery);
            },
        /* ダイアログを閉じる前の処理 */
        beforeClose: function(event) {
            if(jQuery("#frameDiv").size() ==1 ){ // 要素が残っていれば削除
                frameID.prop("src", " ");
                frameID.remove();
                jQuery(this).dialog('destroy');
                }
            },
        /* ダイアログを閉じた時の処理 */
        close: function(event) {
            if(jQuery("#frameDiv").size() ==1 ){ // 要素が残っていれば削除
                frameID.prop("src", " ");
                frameID.remove();
                jQuery(this).dialog('destroy');
                }
            }
        });
    }

//-------------------------------------------
// 子要素からダイアログの表示(ダイアログ内からダイアログを表示する場合)
// frame内等、子要素から親要素を指定する場合に使用。
// URL      :表示するURLを指定(例：testDialog.asp)
// para     :送信パラメータ (例：?membID=111&yymm=201501)
// dWidth   :ダイアログの横幅を指定
// dHeight  :ダイアログの縦幅を指定
// fnc      :追加処理
//-------------------------------------------
function subShowDialog(URL,para,dTitle,dWidth,dHeight,fnc){
    jQuery = parent.jQuery;
    var subDialogID=jQuery("#subDialog");  // Dialog表示領域
    subDialogID.append("<iframe id='subFrameDiv' "
                +"frameborder='0' scrolling='no' ></iframe>");
    var subFrameID=jQuery("#subFrameDiv"); // iFrame表示領域
    /* ダイアログ処理 */
    subDialogID.dialog({                       // ダイアログの呼び出し
        title : dTitle,                        // タイトル
        width : dWidth,                        // 横幅
        height : dHeight,                      // 縦幅
        modal: true,                           // モーダル機能(メイン画面の操作不可)の設定
        closeOnEscape: false,                  // ESCキーで閉じないように
        resizable: false,                      // マウスのドラッグでサイズ変更不可に
        position: {                            // ダイアログの表示位置
            my: 'center',
            at: 'center',
            of: window
            },
        /* ダイアログを開く */
        open: function(e){
            openDialog(URL,para,subFrameID,fnc,jQuery);
            },
        /* ダイアログを閉じる */
        beforeClose: function(event) {
            if(jQuery("#subFrameDiv").size() ==1 ){// 要素が残っていれば削除
                subFrameID.prop("src", " ");
                subFrameID.remove();
                jQuery(this).dialog('destroy');
                }
            },
        close: function(event) {
            if(jQuery("#subFrameDiv").size() ==1 ){// 要素が残っていれば削除
                subFrameID.prop("src", " ");
                subFrameID.remove();
                jQuery(this).dialog('destroy');
                }
            }
        });
    }

//-------------------------------------------
// ダイアログ画面を表示する
//-------------------------------------------
function openDialog(URL,para,frameID,fnc,jQuery){
    var dTitle = jQuery(".ui-dialog-title");     // ダイアログタイトルUI
    var dTitleBtn = jQuery(".ui-icon");          // ダイアログタイトル(閉じるボタン)UI
    var wContent = jQuery(".ui-widget-content"); // ウィジットコンテナ

    // タイトルバーのサイズ・表示固定
    dTitle.css({"font-size": "12px",
        "height": "14px",
        "display": "block",
        "visibility":"visible"});
    // 閉じるボタン表示固定
    dTitleBtn.css({"display": "block", "visibility":"visible"});

    // ダイアログDiv要素表示固定
    jQuery("div.ui-dialog-titlebar, " +          // ダイアログタイトルバー
           "div.ui-widget-overlay," +            // ダイアログとメイン画面の間のシート
           "div.ui-widget-content")              // ダイアログ内表示領域
               .css({"display": "block", "visibility":"visible"});
    // ダイアログ画面表示レイアウト調整
    wContent.css({
        "padding": "0px",
        "margin": "0px",
        "overflow": "hidden"});                  // ダイアログレイアウト調整
    frameID.prop({                               // ダイアログに表示する画面
        src : URL+para,
        width : '100%',
        height : '100%'
        }).load(function(){                      // iFrame画面読み込み時の処理
            if(fnc!="" && fnc !='undefined'){    // ダイアログ表示後に追加処理がある場合
                fnc();                           // 追加処理を読み込む
                }
            });
    }

//-------------------------------------------
// ダイアログを閉じる処理
//-------------------------------------------
function closeDialog(){
    jQuery("#Dialog").dialog("close");
    }

//-------------------------------------------
// ダイアログを閉じる処理(フレーム内処理)
//-------------------------------------------
function parentCloseDialog(){
    parent.jQuery("#Dialog").dialog("close");
    }

//-------------------------------------------
// 子要素からダイアログを閉じる処理
//-------------------------------------------
function CloseSubDialog(){
    parent.jQuery("#subDialog").dialog("close");
    }