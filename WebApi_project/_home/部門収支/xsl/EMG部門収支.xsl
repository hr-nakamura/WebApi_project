<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">	


  <xsl:variable name="�N�x"><xsl:value-of select="/root/�S��/�N�x"/></xsl:variable>
  <xsl:variable name="�J�n�N"><xsl:value-of select="/root/�S��/�J�n�N"/></xsl:variable>
  <xsl:variable name="�J�n��"><xsl:value-of select="/root/�S��/�J�n��"/></xsl:variable>
  <xsl:variable name="����"><xsl:value-of select="/root/�S��/����"/></xsl:variable>
  <xsl:variable name="�c�Ɠ�"><xsl:value-of select="/root/�S��/�c�Ɠ�"/></xsl:variable>
  <xsl:variable name="���ѓ��t"><xsl:value-of select="/root/�S��/���ѓ��t"/></xsl:variable>
  <xsl:variable name="�m�x"><xsl:value-of select="/root/�S��/�m�x"/></xsl:variable>
  <xsl:template match="/">
    <html>
			<head>
				<title>���x��</title>
				<link rel="stylesheet" type="text/css" href="account.css"/>
			</head>

			<body background="bg.gif">
				<xsl:apply-templates select="root" />
      </body>
		</html>

	</xsl:template>

	<xsl:template match="root">
    <xsl:if test="count(�S��/�O���[�v) = 0">
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="'�f�[�^�͂���܂���'"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>

    <xsl:if test="count(�S��/�O���[�v) > 0">
      <table border="0" align="center">
        <tbody>
        <tr>
          <td>
            <xsl:apply-templates select="�S��"/>
          </td>
        </tr>
      </tbody>
    </table>
    </xsl:if>

  </xsl:template>


  <!-- ########################################################### -->


  <xsl:template match="�S��">
    <xsl:apply-templates select="�O���[�v"/>
  </xsl:template>

  <xsl:template match="�O���[�v">
    <xsl:apply-templates select="�f�[�^"/>
    <xsl:if test="position() != last()">
      <br/>
      <hr width="70%"/>
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="�f�[�^">
    <xsl:variable name="���O">
      <xsl:value-of select="../���O"/>
    </xsl:variable>
    <xsl:variable name="�����R�[�h">
      <xsl:value-of select="../�����R�[�h"/>
    </xsl:variable>
    <xsl:variable name="���">
      <xsl:value-of select="../@kind"/>
    </xsl:variable>
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption ID="GRP">
        <xsl:attribute name="dispName">
          <xsl:value-of select="$���O"/>
        </xsl:attribute>
        <xsl:attribute name="gCode">
          <xsl:value-of select="$�����R�[�h"/>
        </xsl:attribute>
        <big>
          <strong>
            <xsl:if test="@name = '����'">
              <xsl:value-of select="$���O"/>
              <br/>
            </xsl:if>
            <xsl:value-of select="$�N�x"/>�N�x
            <xsl:value-of select="�\��"/>
            <xsl:call-template name="�����N"/>
          </strong>
        </big>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'���@��'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$�J�n�N" />
            <xsl:with-param name="begin" select="$�J�n��" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'���@�v'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$�J�n��" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="�\�Z"/>
      </tbody>
      <tbody id="onUriage">
        <xsl:apply-templates select="���㍂"/>
      </tbody>
      <tbody id="onUriage" mode="�݌v" style="display:none">
        <xsl:apply-templates select="���㍂" mode="�݌v"/>
      </tbody>
      <tbody id="onCost1">
        <xsl:apply-templates select="����t��"/>
      </tbody>
      <tbody id="onCost1" mode="�ڍ�" style="display:none">
        <xsl:apply-templates select="����t��" mode="�ڍ�"/>
      </tbody>
      <xsl:if test="����t��">
        <tbody id="onSales" name="���㍇�v">
          <xsl:call-template name="���㍇�v"/>
        </tbody>
        <tbody id="onSales" name="���㍇�v" mode="�ڍ�" style="display:none">
          <xsl:call-template name="���㍇�v_�ڍ�"/>
        </tbody>
      </xsl:if>
      <tbody id="onGenka">
        <xsl:apply-templates select="���㌴��"/>
      </tbody>
      <tbody id="onGenka" mode="�ڍ�" style="display:none">
        <xsl:apply-templates select="���㌴��" mode="�ڍ�"/>
      </tbody>
      <tbody id="onKei1">
        <xsl:call-template name="���㑍���v"/>
      </tbody>
      <tbody id="onKei1" mode="�ڍ�" style="display:none">
        <xsl:call-template name="���㑍���v_�ڍ�"/>
      </tbody>
      <tbody id="onKanriHi">
        <xsl:apply-templates select="�̊ǔ�"/>
      </tbody>
      <tbody id="onKanriHi" mode="�ڍ�" style="display:none">
        <xsl:apply-templates select="�v����"/>
        <xsl:apply-templates select="�̊ǔ�" mode="�ڍ�"/>
      </tbody>
      <tbody id="onCost2">
        <xsl:apply-templates select="��p�t��"/>
      </tbody>
      <tbody id="onCost2" mode="�ڍ�" style="display:none">
        <xsl:apply-templates select="��p�t��" mode="�ڍ�"/>
      </tbody>
      <tbody>
        <xsl:apply-templates select="����Œ��"/>
      </tbody>
      <tbody id="onKei2">
        <xsl:call-template name="�c�Ɨ��v"/>
      </tbody>
      <tbody id="onKei2" mode="�ڍ�" style="display:none">
        <xsl:call-template name="�c�Ɨ��v_�ڍ�"/>
      </tbody>
      <tbody>
        <xsl:apply-templates select="�c�ƊO���v"/>
        <xsl:apply-templates select="�c�ƊO��p"/>
      </tbody>
      <tbody>
        <xsl:apply-templates select="�{�Д�z��"/>
      </tbody>
      <tbody id="onKei3">
        <xsl:call-template name="�o�험�v"/>
      </tbody>
      <tbody id="onKei3" mode="�ڍ�" style="display:none">
        <xsl:call-template name="�o�험�v_�ڍ�"/>
      </tbody>
      <tbody>
        <xsl:call-template name="�o�험�v_�݌v"/>
      </tbody>
    </table>
    <xsl:if test="@name='����'">
      <table align="center" CELLPADDING="0" CELLSPACING="0" >
        <tbody>
          <tr>
            <td class="actual">
              <small>
                <xsl:value-of select="'���сF���̐���'"/>
              </small>
            </td>
            <td class="yosoku">
              <small>
                <xsl:value-of select="'�\���F�̐���'"/>
              </small>
            </td>
            <td class="target">
              <small>
                <xsl:value-of select="'�v��F�΂̐���'"/>
              </small>
            </td>
          </tr>
        </tbody>
        <tbody>
          <tr>
            <td colspan="3" align="center">
              <small>
                <xsl:value-of select="$���ѓ��t"/>
              </small>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
    <xsl:if test="position() != last()">
      <br/>
      <hr width="50%"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="�����N">
    <xsl:choose>
      <xsl:when test="$�m�x=30">
        <xsl:value-of select="'�@�i�b�j'"/>
      </xsl:when>
      <xsl:when test="$�m�x=50">
        <xsl:value-of select="'�@�i�a�j'"/>
      </xsl:when>
      <xsl:when test="$�m�x=70">
        <!--<xsl:value-of select="'�@�i�`�j'"/>-->
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <!--<xsl:value-of select="$�m�x"/>-->
  </xsl:template>


  <!-- �P�s�̕\��(�e���{���v) -->
  <xsl:template name="���ڍs">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="mode" />
    <xsl:for-each select="����[1]">
      <xsl:for-each select="��">
        <td>
          <xsl:apply-templates select=".">
            <xsl:with-param name="form" select="$form" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="m" select="@m" />
            <xsl:with-param name="mode" select="$mode" />
          </xsl:apply-templates>
        </td>
      </xsl:for-each>
    </xsl:for-each>
    <td class='secTotal'>
      <xsl:call-template name="���ڌv">
        <xsl:with-param name="form" select="$form" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="item" select="$item" />
        <xsl:with-param name="mode" select="$mode" />
      </xsl:call-template>
    </td>
  </xsl:template>

  <!-- �P�s�̕\��(�e���{���v) -->
  <xsl:template name="���ڍs_�݌v">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="mode" />
    <xsl:param name="before" select="0" />
    <xsl:for-each select="����[1]">
      <xsl:for-each select="��">
        <td>
          <xsl:apply-templates select="." mode="�݌v">
            <xsl:with-param name="form" select="$form" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="m" select="@m" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="before" select="$before" />
          </xsl:apply-templates>
        </td>
      </xsl:for-each>
    </xsl:for-each>
    <td class='secTotal'>
      <xsl:call-template name="���ڌv">
        <xsl:with-param name="form" select="$form" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="item" select="$item" />
        <xsl:with-param name="mode" select="$mode" />
      </xsl:call-template>
    </td>
  </xsl:template>

  <!-- �s�̍��v -->
  <xsl:template name="���ڌv">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="mode" />
    <!--<xsl:attribute name="style">
        <xsl:value-of select="'color:tomato'"/>
    </xsl:attribute>-->
    <!--<xsl:value-of select="$item"/>-->
    <!--<xsl:value-of select="local-name()"/>-->
    <xsl:variable name="���l">
      <xsl:value-of select="format-number((sum(����[starts-with(@name,$item)]/��) div $unit) * number($mode),$form)"/>
    </xsl:variable>
    <xsl:if test="$���l=''">
      <xsl:value-of select="'0'"/>
    </xsl:if>
    <xsl:value-of select="$���l"/>
  </xsl:template>

  <!-- �s�̊e�� -->
  <xsl:template match="��">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="m" />
    <xsl:param name="mode" />
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="../../../�����/��[@m=$m]='����' and $item != '�\�Z'">
          <!-- - ����-->
          <xsl:value-of select="'actual'"/>
        </xsl:when>
        <xsl:when test="../../../�����/��[@m=$m]='�\��' and $item != '�\�Z'">
          <!-- - �\��-->
          <xsl:value-of select="'yosoku'"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- - �v��-->
          <xsl:value-of select="'target'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:variable name="���l">
      <xsl:value-of select="format-number((sum(../../����[starts-with(@name,$item)]/��[@m=$m]) div $unit) * number($mode),$form)"/>
    </xsl:variable>
    <xsl:if test="$���l=''">
      <xsl:value-of select="'�@'"/>
    </xsl:if>
    <xsl:value-of select="$���l"/>

  </xsl:template>

  <xsl:template match="��" mode="�݌v">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="m" />
    <xsl:param name="mode" />
    <xsl:param name="before" />
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="../../../�����/��[@m=$m]='����' and $item != '�\�Z'">
          <!-- - ����-->
          <xsl:value-of select="'actual'"/>
        </xsl:when>
        <xsl:when test="../../../�����/��[@m=$m]='�\��' and $item != '�\�Z'">
          <!-- - �\��-->
          <xsl:value-of select="'yosoku'"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- - �v��-->
          <xsl:value-of select="'target'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:variable name="���l">
      <xsl:value-of select="format-number((sum(../../����[starts-with(@name,$item)]/��[@m &lt;= $m]) div $unit) * number($mode),$form)"/>
    </xsl:variable>
    <xsl:if test="$���l=''">
      <xsl:value-of select="'�@'"/>
    </xsl:if>
    <xsl:value-of select="$���l"/>

  </xsl:template>


  <xsl:template match="�\�Z">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'�\�Z(�v��)'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�\�Z'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="���㍂">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'���㍂'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="���㍂" mode="�݌v">
    <tr>
      <td class='userType' colspan="2" rowspan="2">
        <xsl:value-of select="'���㍂'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <xsl:call-template name="���ڍs_�݌v">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <!-- �ڍו\���s-->
  <xsl:template match="����t��" mode="�ڍ�">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' rowspan="3">
        <xsl:value-of select="'����t��'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�o'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�x�o'" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,##0'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <!-- �ȈՕ\���s-->
  <xsl:template match="����t��">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'����t��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="��p�t��" mode="�ڍ�">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <!-- �ڍו\���s-->
    <tr>
      <td class='userType' rowspan="3">
        <xsl:value-of select="'��p�t��'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�o'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�x�o'" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,##0'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>

  </xsl:template>
  <!-- �ȈՕ\���s-->

  <xsl:template match="��p�t��">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'��p�t��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="���㌴��" mode="�ڍ�">
    <!-- �ڍו\���s-->
    <tr>
      <td class='userType' rowspan="5">
        <xsl:value-of select="'���㌴��'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'�O����'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�O����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�d����'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�d����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'����I��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'����I��'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�����I��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�����I��'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,##0'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <!-- �ȈՕ\���s-->
  <xsl:template match="���㌴��">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'���㌴��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="�v����">
    <tr>
      <td class='userType' rowspan="2">
        <xsl:value-of select="'�v����'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'�Ј�'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="item" select="'�Ј�'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�p�[�g'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="item" select="'�p�[�g'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>


  <xsl:template match="�̊ǔ�" mode="�ڍ�">
    <!-- �ڍו\���s-->
    <tr>
      <td class='userType' rowspan="12">
        <xsl:value-of select="'�̊ǔ�'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'�l����'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�l����'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�G��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�G��'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�L�����۔�'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�L������'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�����ʔ�'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'��ʔ�'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�ʐM��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�ʐM��'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�ב�������'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'������'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'���i�E�}�V��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'���i'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�ݔ��E���[�X��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�ݔ���'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'�ƒ���'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'�ƒ�'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'���̑�'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'���̑�'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'EMG�Ԕ�p'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'EMG�Ԕ�p'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

    <tr>
      <td class='userType'>
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="�̊ǔ�">
    <!-- �ȈՕ\���s-->
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'�̊ǔ�'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="����Œ��">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'����Œ��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="�{�Д�z��">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'�{�Д�z��'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="�c�ƊO���v">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'�c�ƊO���v'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="�c�ƊO��p">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'�c�ƊO��p'"/>
      </td>
      <xsl:call-template name="���ڍs">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>


  <!-- *****�@�W�v�̍s ****************** -->

  <!-- ########## ���㍇�v #########-->
  <xsl:template name="���㍇�v_�ڍ�">
    <xsl:variable name="���㍇�v_4-1">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 0])+sum(���㍂/*/��[floor(@m div 3) = 0])+sum(����t��/*/��[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="���㍇�v_4-2">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 1])+sum(���㍂/*/��[floor(@m div 3) = 1])+sum(����t��/*/��[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="���㍇�v_4-3">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 2])+sum(���㍂/*/��[floor(@m div 3) = 2])+sum(����t��/*/��[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="���㍇�v_4-4">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 3])+sum(���㍂/*/��[floor(@m div 3) = 3])+sum(����t��/*/��[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="���㍇�v_6-1">
      <xsl:value-of select="$���㍇�v_4-1 + $���㍇�v_4-2"/>
    </xsl:variable>
    <xsl:variable name="���㍇�v_6-2">
      <xsl:value-of select="$���㍇�v_4-3 + $���㍇�v_4-4"/>
    </xsl:variable>
    <xsl:variable name="���㍇�v_�v">
      <xsl:value-of select="$���㍇�v_6-1 + $���㍇�v_6-2"/>
    </xsl:variable>
    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'���㍇�v'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="���㍇�v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$���㍇�v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($���㍇�v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'�l�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="���㍇�v">
    <!-- �ȈՕ\���s-->
    <xsl:variable name="���㍇�v_�v">
      <xsl:value-of select="sum(�\�Z/*/��)+sum(���㍂/*/��)+sum(����t��/*/��)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'���㍇�v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="���㍇�v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$���㍇�v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($���㍇�v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$���㍇�v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㍇�v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>


  </xsl:template>


  <!-- ########## ���㑍���v #########-->
  <xsl:template name="���㑍���v_�ڍ�">
    <xsl:variable name="���㑍���v_4-1">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 0])+sum(���㍂/*/��[floor(@m div 3) = 0])+sum(����t��/*/��[floor(@m div 3) = 0])-sum(���㌴��/*/��[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="���㑍���v_4-2">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 1])+sum(���㍂/*/��[floor(@m div 3) = 1])+sum(����t��/*/��[floor(@m div 3) = 1])-sum(���㌴��/*/��[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="���㑍���v_4-3">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 2])+sum(���㍂/*/��[floor(@m div 3) = 2])+sum(����t��/*/��[floor(@m div 3) = 2])-sum(���㌴��/*/��[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="���㑍���v_4-4">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 3])+sum(���㍂/*/��[floor(@m div 3) = 3])+sum(����t��/*/��[floor(@m div 3) = 3])-sum(���㌴��/*/��[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="���㑍���v_6-1">
      <xsl:value-of select="$���㑍���v_4-1 + $���㑍���v_4-2"/>
    </xsl:variable>
    <xsl:variable name="���㑍���v_6-2">
      <xsl:value-of select="$���㑍���v_4-3 + $���㑍���v_4-4"/>
    </xsl:variable>
    <xsl:variable name="���㑍���v_�v">
      <xsl:value-of select="$���㑍���v_6-1 + $���㑍���v_6-2"/>
    </xsl:variable>
    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'���㑍���v'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="���㑍���v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])-sum(../../���㌴��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$���㑍���v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($���㑍���v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'�l�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="���㑍���v">
    <!-- �ȈՕ\���s-->
    <xsl:variable name="���㑍���v_�v">
      <xsl:value-of select="sum(�\�Z/*/��)+sum(���㍂/*/��)+sum(����t��/*/��)-sum(���㌴��/*/��)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'���㑍���v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="���㑍���v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])-sum(../../���㌴��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$���㑍���v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($���㑍���v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$���㑍���v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($���㑍���v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>


  </xsl:template>


  <!-- ########## �c�Ɨ��v #########-->
  <xsl:template name="�c�Ɨ��v_�ڍ�">
    <!-- �ڍו\���s-->
    <xsl:variable name="�c�Ɨ��v_4-1">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 0])+sum(���㍂/*/��[floor(@m div 3) = 0])+sum(����t��/*/��[floor(@m div 3) = 0])-sum(���㌴��/*/��[floor(@m div 3) = 0])-sum(�̊ǔ�/*/��[floor(@m div 3) = 0])+sum(��p�t��/*/��[floor(@m div 3) = 0])-sum(����Œ��/*/��[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="�c�Ɨ��v_4-2">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 1])+sum(���㍂/*/��[floor(@m div 3) = 1])+sum(����t��/*/��[floor(@m div 3) = 1])-sum(���㌴��/*/��[floor(@m div 3) = 1])-sum(�̊ǔ�/*/��[floor(@m div 3) = 1])+sum(��p�t��/*/��[floor(@m div 3) = 1])-sum(����Œ��/*/��[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="�c�Ɨ��v_4-3">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 2])+sum(���㍂/*/��[floor(@m div 3) = 2])+sum(����t��/*/��[floor(@m div 3) = 2])-sum(���㌴��/*/��[floor(@m div 3) = 2])-sum(�̊ǔ�/*/��[floor(@m div 3) = 2])+sum(��p�t��/*/��[floor(@m div 3) = 2])-sum(����Œ��/*/��[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="�c�Ɨ��v_4-4">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 3])+sum(���㍂/*/��[floor(@m div 3) = 3])+sum(����t��/*/��[floor(@m div 3) = 3])-sum(���㌴��/*/��[floor(@m div 3) = 3])-sum(�̊ǔ�/*/��[floor(@m div 3) = 3])+sum(��p�t��/*/��[floor(@m div 3) = 3])-sum(����Œ��/*/��[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="�c�Ɨ��v_6-1">
      <xsl:value-of select="$�c�Ɨ��v_4-1 + $�c�Ɨ��v_4-2"/>
    </xsl:variable>
    <xsl:variable name="�c�Ɨ��v_6-2">
      <xsl:value-of select="$�c�Ɨ��v_4-3 + $�c�Ɨ��v_4-4"/>
    </xsl:variable>
    <xsl:variable name="�c�Ɨ��v_�v">
      <xsl:value-of select="$�c�Ɨ��v_6-1 + $�c�Ɨ��v_6-2"/>
    </xsl:variable>
    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'�c�Ɨ��v'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="�c�Ɨ��v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])-sum(../../���㌴��/*/��[@m=$m])-sum(../../�̊ǔ�/*/��[@m=$m])+sum(../../��p�t��/*/��[@m=$m])-sum(../../����Œ��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$�c�Ɨ��v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($�c�Ɨ��v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'�l�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="�c�Ɨ��v">
    <!-- �ȈՕ\���s-->
    <xsl:variable name="�c�Ɨ��v_�v">
      <xsl:value-of select="sum(�\�Z/*/��)+sum(���㍂/*/��)+sum(����t��/*/��)-sum(���㌴��/*/��)-sum(�̊ǔ�/*/��)+sum(��p�t��/*/��)-sum(����Œ��/*/��)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'�c�Ɨ��v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="�c�Ɨ��v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])-sum(../../���㌴��/*/��[@m=$m])-sum(../../�̊ǔ�/*/��[@m=$m])+sum(../../��p�t��/*/��[@m=$m])-sum(../../����Œ��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$�c�Ɨ��v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($�c�Ɨ��v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$�c�Ɨ��v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�c�Ɨ��v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <!-- ########## �o�험�v #########-->
  <xsl:template name="�o�험�v_�ڍ�">
    <!-- �ڍו\���s-->
    <xsl:variable name="�o�험�v_4-1">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 0])+sum(���㍂/*/��[floor(@m div 3) = 0])+sum(����t��/*/��[floor(@m div 3) = 0])-sum(���㌴��/*/��[floor(@m div 3) = 0])-sum(�̊ǔ�/*/��[floor(@m div 3) = 0])+sum(��p�t��/*/��[floor(@m div 3) = 0])-sum(����Œ��/*/��[floor(@m div 3) = 0])+sum(�c�ƊO���v/*/��[floor(@m div 3) = 0])-sum(�c�ƊO��p/*/��[floor(@m div 3) = 0])-sum(�{�Д�z��/*/��[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="�o�험�v_4-2">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 1])+sum(���㍂/*/��[floor(@m div 3) = 1])+sum(����t��/*/��[floor(@m div 3) = 1])-sum(���㌴��/*/��[floor(@m div 3) = 1])-sum(�̊ǔ�/*/��[floor(@m div 3) = 1])+sum(��p�t��/*/��[floor(@m div 3) = 1])-sum(����Œ��/*/��[floor(@m div 3) = 1])+sum(�c�ƊO���v/*/��[floor(@m div 3) = 1])-sum(�c�ƊO��p/*/��[floor(@m div 3) = 1])-sum(�{�Д�z��/*/��[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="�o�험�v_4-3">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 2])+sum(���㍂/*/��[floor(@m div 3) = 2])+sum(����t��/*/��[floor(@m div 3) = 2])-sum(���㌴��/*/��[floor(@m div 3) = 2])-sum(�̊ǔ�/*/��[floor(@m div 3) = 2])+sum(��p�t��/*/��[floor(@m div 3) = 2])-sum(����Œ��/*/��[floor(@m div 3) = 2])+sum(�c�ƊO���v/*/��[floor(@m div 3) = 2])-sum(�c�ƊO��p/*/��[floor(@m div 3) = 2])-sum(�{�Д�z��/*/��[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="�o�험�v_4-4">
      <xsl:value-of select="sum(�\�Z/*/��[floor(@m div 3) = 3])+sum(���㍂/*/��[floor(@m div 3) = 3])+sum(����t��/*/��[floor(@m div 3) = 3])-sum(���㌴��/*/��[floor(@m div 3) = 3])-sum(�̊ǔ�/*/��[floor(@m div 3) = 3])+sum(��p�t��/*/��[floor(@m div 3) = 3])-sum(����Œ��/*/��[floor(@m div 3) = 3])+sum(�c�ƊO���v/*/��[floor(@m div 3) = 3])-sum(�c�ƊO��p/*/��[floor(@m div 3) = 3])-sum(�{�Д�z��/*/��[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="�o�험�v_6-1">
      <xsl:value-of select="$�o�험�v_4-1 + $�o�험�v_4-2"/>
    </xsl:variable>
    <xsl:variable name="�o�험�v_6-2">
      <xsl:value-of select="$�o�험�v_4-3 + $�o�험�v_4-4"/>
    </xsl:variable>
    <xsl:variable name="�o�험�v_�v">
      <xsl:value-of select="$�o�험�v_6-1 + $�o�험�v_6-2"/>
    </xsl:variable>

    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'�o�험�v'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'���@�v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="�o�험�v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])-sum(../../���㌴��/*/��[@m=$m])-sum(../../�̊ǔ�/*/��[@m=$m])+sum(../../��p�t��/*/��[@m=$m])-sum(../../����Œ��/*/��[@m=$m])+sum(../../�c�ƊO���v/*/��[@m=$m])-sum(../../�c�ƊO��p/*/��[@m=$m])-sum(../../�{�Д�z��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$�o�험�v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($�o�험�v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'�l�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>

      <td align="right">
        <xsl:value-of select="'�����@�v'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="�o�험�v">
    <!-- �ȈՕ\���s-->
    <xsl:variable name="�o�험�v_�v">
      <xsl:value-of select="sum(�\�Z/*/��)+sum(���㍂/*/��)+sum(����t��/*/��)-sum(���㌴��/*/��)-sum(�̊ǔ�/*/��)+sum(��p�t��/*/��)-sum(����Œ��/*/��)+sum(�c�ƊO���v/*/��)-sum(�c�ƊO��p/*/��)-sum(�{�Д�z��/*/��)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'�o�험�v'"/>
      </td>
      <xsl:for-each select="�����/��">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="�o�험�v_��">
          <xsl:value-of select="sum(../../�\�Z/*/��[@m=$m])+sum(../../���㍂/*/��[@m=$m])+sum(../../����t��/*/��[@m=$m])-sum(../../���㌴��/*/��[@m=$m])-sum(../../�̊ǔ�/*/��[@m=$m])+sum(../../��p�t��/*/��[@m=$m])-sum(../../����Œ��/*/��[@m=$m])+sum(../../�c�ƊO���v/*/��[@m=$m])-sum(../../�c�ƊO��p/*/��[@m=$m])-sum(../../�{�Д�z��/*/��[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$�o�험�v_�� &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($�o�험�v_�� div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="�o�험�v_�݌v">
    <tr class='groupType'>
      <td rowspan="2" colspan="2">
        <xsl:value-of select="'�o�험�v'"/>
        <br/>
        <xsl:value-of select="'(�݌v)'"/>
      </td>
      <xsl:call-template name="month_LoopX">
        <xsl:with-param name="begin" select="$�J�n��" />
        <xsl:with-param name="mCnt" select="$����" />
      </xsl:call-template>
      <td width="70">
        <xsl:attribute name="nowrap" />
        <xsl:value-of select="'���@�v'"/>
        </td>
    </tr>

    <tr class='groupType'>
      <!-- �P�Q�J�����̗݌v��\��-->
      <xsl:call-template name="valueOut_Loop_Sum">
        <xsl:with-param name="element" select="." />
        <xsl:with-param name="item" select="'$item'" />
        <xsl:with-param name="mCnt" select="$����" />
        <xsl:with-param name="unit" select="'$unit'" />
        <xsl:with-param name="form" select="'$form'" />
      </xsl:call-template>
      <td class='lastTarget'>
        <xsl:variable name="�o�험�v_�v">
          <xsl:value-of select="sum(�\�Z/*/��)+sum(���㍂/*/��)+sum(����t��/*/��)-sum(���㌴��/*/��)-sum(�̊ǔ�/*/��)+sum(��p�t��/*/��)-sum(����Œ��/*/��)+sum(�c�ƊO���v/*/��)-sum(�c�ƊO��p/*/��)-sum(�{�Д�z��/*/��)"/>
        </xsl:variable>
        <xsl:attribute name="style">
          <xsl:if test="$�o�험�v_�v &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($�o�험�v_�v div 1000 ,'#,##0')"/>
      </td>
    </tr>
  </xsl:template>


  <!--�@�f�[�^(�o�험�v�̌��̗݌v)�s�̕\���@-->
  <xsl:template name="valueOut_Loop_Sum">
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="1" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="sumVal" select="(sum(�\�Z/*/��[@m=0])+sum(���㍂/*/��[@m=0])+sum(����t��/*/��[@m=0])-sum(���㌴��/*/��[@m=0])-sum(�̊ǔ�/*/��[@m=0])+sum(��p�t��/*/��[@m=0])-sum(����Œ��/*/��[@m=0])+sum(�c�ƊO���v/*/��[@m=0])-sum(�c�ƊO��p/*/��[@m=0])-sum(�{�Д�z��/*/��[@m=0]))" />
    <xsl:param name="unit" />
    <xsl:param name="form"/>
    <xsl:if test="$m &lt; $max">
      <td class="groupTypeData">
        <xsl:attribute name="style">
          <xsl:if test="$sumVal &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($sumVal div 1000 ,'#,##0')"/>
      </td>
      <xsl:call-template name="valueOut_Loop_Sum">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="m" select="$m + 1" />
        <xsl:with-param name="sumVal" select="$sumVal + (sum(�\�Z/*/��[@m=$m])+sum(���㍂/*/��[@m=$m])+sum(����t��/*/��[@m=$m])-sum(���㌴��/*/��[@m=$m])-sum(�̊ǔ�/*/��[@m=$m])+sum(��p�t��/*/��[@m=$m])-sum(����Œ��/*/��[@m=$m])+sum(�c�ƊO���v/*/��[@m=$m])-sum(�c�ƊO��p/*/��[@m=$m])-sum(�{�Д�z��/*/��[@m=$m]))" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="form" select="$form" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="month_LoopX">
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:if test="$cnt &lt; $max">
      <td class="m" width='50'>
        <xsl:if test="($cnt mod 12)>0">
          <xsl:value-of select="$cnt mod 12"/>
        </xsl:if>
        <xsl:if test="($cnt mod 12)=0">
          <xsl:value-of select="12"/>
        </xsl:if>
        <xsl:value-of select="'��'"/>
      </td>
      <xsl:call-template name="month_LoopX">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--		-->
  <xsl:include href="/Project/home/_inc/sub_cmn.xsl"/>
	
</xsl:stylesheet>
