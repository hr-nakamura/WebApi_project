//--------------------------------
//editProject��ʕ\��
//--------------------------------
function dispEditProject(url, para, myTitle, width, height){
    // Dialog�v�f�ǉ�
    $('body').append("<div id='Dialog'></div>");
    // showDialog.js����Ăяo��
    showDialog(url, para, myTitle, width, height, function() {    // ���A�����A�R�[���o�b�N�������w��
        // �_�C�A���O�ݒ�ǉ�
        $("#Dialog").dialog({
            closeOnEscape: false,            // Esc�L�[�ɂ��close����
            // ��ʂ�����Ƃ��̏���
            close: function() {
                $("#frameDiv").remove();    // �O�̃R���e���c���폜
                $("#Dialog").remove();      // Dialog�v�f���폜
                if(return_value) updateList(parent_pNum);
                }
            });
        });
    }