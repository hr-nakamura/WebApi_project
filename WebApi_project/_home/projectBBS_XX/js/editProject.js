//--------------------------------
//inputText��ʕ\��
//--------------------------------
function dispInputText(url, para, myTitle, width, height){
    // Dialog�v�f�ǉ�
    $('body').append("<div id='Dialog'></div>");
    // showDialog.js����Ăяo��
    showDialog(url, para, myTitle, width, height, function() {    // ���A�����A�R�[���o�b�N�������w��
        // �_�C�A���O�ݒ�ǉ�
        $("#Dialog").dialog({
            closeOnEscape: false,            // Esc�L�[�ɂ��close����
            position: {my: "center top+5%", at: "center top+5%", of: window},
            // ��ʂ�����Ƃ��̏���
            close: function() {
                $("#frameDiv").remove();    // �O�̃R���e���c���폜
                $("#Dialog").remove();      // Dialog�v�f���폜
                switch (myTitle) {
                    case "��Ж��ݒ�":
                        if( childlen_ReturnValue != "" ){
                            corpSEL.newValue = childlen_ReturnValue
                            T0.value = childlen_ReturnValue
                        }
                        corpInit(GrpSEL.Tab,T0.value)
                        break;
                    case "�J�e�S���[��1�ݒ�":
                        if( childlen_ReturnValue != "" ){
                            categorySEL1.newValue = childlen_ReturnValue
                            T_kindCategory1.value = childlen_ReturnValue
                            }
                        categoryInit(CategoryTab1,categorySEL1,T_kindCategory1.value)
                        break;
                    case "�J�e�S���[��2�ݒ�":
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