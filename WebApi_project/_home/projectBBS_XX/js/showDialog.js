//-------------------------------------------
// �_�C�A���O�̕\��
// URL      :�\������URL���w��(��FtestDialog.asp)
// para     :���M�p�����[�^ (��F?membID=111&yymm=201501)
// dWidth   :�_�C�A���O�̉������w��
// dHeight  :�_�C�A���O�̏c�����w��
// fnc      :�ǉ�����
//-------------------------------------------
function showDialog(URL,para,dTitle,dWidth,dHeight,fnc){
    var dialogID=jQuery("#Dialog");             // Dialog�\���̈�
    dialogID.append("<iframe id='frameDiv' "
        +"frameborder='0' scrolling='yes' ></iframe>");
    var frameID=jQuery("#frameDiv");            // iFrame�\���̈�
    /* �_�C�A���O���� */
    dialogID.dialog({                          // �_�C�A���O�̌Ăяo��
        title : dTitle,                        // �^�C�g��
        width : dWidth,                        // ����
        height : dHeight,                      // �c��
        modal: true,                           // ���[�_���@�\(���C����ʂ̑���s��)�̐ݒ�
        closeOnEscape: false,                  // ESC�L�[�ŕ��Ȃ��悤��
        resizable: false,                      // �}�E�X�̃h���b�O�ŃT�C�Y�ύX�s��
        position: {                            // �_�C�A���O�̕\���ʒu
            my: 'center',
            at: 'center',
            of: window
            },
        /* �_�C�A���O���J�� */
        open : function(){
            openDialog(URL,para,frameID,fnc,jQuery);
            },
        /* �_�C�A���O�����O�̏��� */
        beforeClose: function(event) {
            if(jQuery("#frameDiv").size() ==1 ){ // �v�f���c���Ă���΍폜
                frameID.prop("src", " ");
                frameID.remove();
                jQuery(this).dialog('destroy');
                }
            },
        /* �_�C�A���O��������̏��� */
        close: function(event) {
            if(jQuery("#frameDiv").size() ==1 ){ // �v�f���c���Ă���΍폜
                frameID.prop("src", " ");
                frameID.remove();
                jQuery(this).dialog('destroy');
                }
            }
        });
    }

//-------------------------------------------
// �q�v�f����_�C�A���O�̕\��(�_�C�A���O������_�C�A���O��\������ꍇ)
// frame�����A�q�v�f����e�v�f���w�肷��ꍇ�Ɏg�p�B
// URL      :�\������URL���w��(��FtestDialog.asp)
// para     :���M�p�����[�^ (��F?membID=111&yymm=201501)
// dWidth   :�_�C�A���O�̉������w��
// dHeight  :�_�C�A���O�̏c�����w��
// fnc      :�ǉ�����
//-------------------------------------------
function subShowDialog(URL,para,dTitle,dWidth,dHeight,fnc){
    jQuery = parent.jQuery;
    var subDialogID=jQuery("#subDialog");  // Dialog�\���̈�
    subDialogID.append("<iframe id='subFrameDiv' "
                +"frameborder='0' scrolling='no' ></iframe>");
    var subFrameID=jQuery("#subFrameDiv"); // iFrame�\���̈�
    /* �_�C�A���O���� */
    subDialogID.dialog({                       // �_�C�A���O�̌Ăяo��
        title : dTitle,                        // �^�C�g��
        width : dWidth,                        // ����
        height : dHeight,                      // �c��
        modal: true,                           // ���[�_���@�\(���C����ʂ̑���s��)�̐ݒ�
        closeOnEscape: false,                  // ESC�L�[�ŕ��Ȃ��悤��
        resizable: false,                      // �}�E�X�̃h���b�O�ŃT�C�Y�ύX�s��
        position: {                            // �_�C�A���O�̕\���ʒu
            my: 'center',
            at: 'center',
            of: window
            },
        /* �_�C�A���O���J�� */
        open: function(e){
            openDialog(URL,para,subFrameID,fnc,jQuery);
            },
        /* �_�C�A���O����� */
        beforeClose: function(event) {
            if(jQuery("#subFrameDiv").size() ==1 ){// �v�f���c���Ă���΍폜
                subFrameID.prop("src", " ");
                subFrameID.remove();
                jQuery(this).dialog('destroy');
                }
            },
        close: function(event) {
            if(jQuery("#subFrameDiv").size() ==1 ){// �v�f���c���Ă���΍폜
                subFrameID.prop("src", " ");
                subFrameID.remove();
                jQuery(this).dialog('destroy');
                }
            }
        });
    }

//-------------------------------------------
// �_�C�A���O��ʂ�\������
//-------------------------------------------
function openDialog(URL,para,frameID,fnc,jQuery){
    var dTitle = jQuery(".ui-dialog-title");     // �_�C�A���O�^�C�g��UI
    var dTitleBtn = jQuery(".ui-icon");          // �_�C�A���O�^�C�g��(����{�^��)UI
    var wContent = jQuery(".ui-widget-content"); // �E�B�W�b�g�R���e�i

    // �^�C�g���o�[�̃T�C�Y�E�\���Œ�
    dTitle.css({"font-size": "12px",
        "height": "14px",
        "display": "block",
        "visibility":"visible"});
    // ����{�^���\���Œ�
    dTitleBtn.css({"display": "block", "visibility":"visible"});

    // �_�C�A���ODiv�v�f�\���Œ�
    jQuery("div.ui-dialog-titlebar, " +          // �_�C�A���O�^�C�g���o�[
           "div.ui-widget-overlay," +            // �_�C�A���O�ƃ��C����ʂ̊Ԃ̃V�[�g
           "div.ui-widget-content")              // �_�C�A���O���\���̈�
               .css({"display": "block", "visibility":"visible"});
    // �_�C�A���O��ʕ\�����C�A�E�g����
    wContent.css({
        "padding": "0px",
        "margin": "0px",
        "overflow": "hidden"});                  // �_�C�A���O���C�A�E�g����
    frameID.prop({                               // �_�C�A���O�ɕ\��������
        src : URL+para,
        width : '100%',
        height : '100%'
        }).load(function(){                      // iFrame��ʓǂݍ��ݎ��̏���
            if(fnc!="" && fnc !='undefined'){    // �_�C�A���O�\����ɒǉ�����������ꍇ
                fnc();                           // �ǉ�������ǂݍ���
                }
            });
    }

//-------------------------------------------
// �_�C�A���O����鏈��
//-------------------------------------------
function closeDialog(){
    jQuery("#Dialog").dialog("close");
    }

//-------------------------------------------
// �_�C�A���O����鏈��(�t���[��������)
//-------------------------------------------
function parentCloseDialog(){
    parent.jQuery("#Dialog").dialog("close");
    }

//-------------------------------------------
// �q�v�f����_�C�A���O����鏈��
//-------------------------------------------
function CloseSubDialog(){
    parent.jQuery("#subDialog").dialog("close");
    }