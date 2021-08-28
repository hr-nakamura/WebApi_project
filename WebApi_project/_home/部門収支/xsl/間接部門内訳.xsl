<?xml version="1.0" encoding="shift_jis" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:user="mynamespace">

	<!--	xmlns:msxsl="urn:schemas-microsoft-com:xslt"	-->
	<!--      xmlns:user="http://mycompany.com/mynamespace">	-->

  <xsl:variable name="�N�x"><xsl:value-of select="/root/�S��/�N�x"/></xsl:variable>
  <xsl:variable name="�J�n�N"><xsl:value-of select="/root/�S��/�J�n�N"/></xsl:variable>
  <xsl:variable name="�J�n��"><xsl:value-of select="/root/�S��/�J�n��"/></xsl:variable>
  <xsl:variable name="����"><xsl:value-of select="/root/�S��/����"/></xsl:variable>
  <!--<xsl:variable name="�c�Ɠ�"><xsl:value-of select="/root/�S��/�c�Ɠ�"/></xsl:variable>-->
  <xsl:variable name="partUnit"><xsl:value-of select="0.03"/></xsl:variable>

  <!--<xsl:variable name="�Ώ�">
    <xsl:value-of select="/root/�S��/�\��"/>
  </xsl:variable>-->
  <xsl:variable name="�Ώ�">
    <xsl:value-of select="'�v��'"/>
  </xsl:variable>
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
      <center>
      <xsl:value-of select="$�Ώ�"/>
      </center>
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="�{�Д�"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="80%" size="5" color="blue"/>
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="����"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="����t��"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="�̊ǔ�">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="��p�t��"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="���㌴��">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="�c�ƊO���v">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="�c�ƊO��p">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
    </xsl:if>

  </xsl:template>


  <!-- ########################################################### -->

  <xsl:template match="�S��" mode="�{�Д�">
    <xsl:variable name="element�\�Z" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/�\�Z/����[@name='�\�Z']" />
    <xsl:variable name="element����" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/���㍂/����[@name='����']" />
    <xsl:variable name="element����t��" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/����t��/����[*]" />
    <xsl:variable name="element���㌴��" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/���㌴��/����[*]" />
    <xsl:variable name="element�̊ǔ�" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/�̊ǔ�/����[*]" />
    <xsl:variable name="element��p�t��" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/��p�t��/����[*]" />
    <xsl:variable name="element�c�ƊO��p" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/�c�ƊO��p/����[*]" />
    <xsl:variable name="element�c�ƊO���v" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/�c�ƊO���v/����[*]" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�{�Д�z���z'"/>
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
      <!--�\�Z-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'�{�Д�p�E�\�Z(�v��)'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element�\�Z" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--����v��-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'�{�Д���(�v��)'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element����" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--����t��-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'����t��'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element����t��" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--�c�ƊO���v-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'�c�ƊO���v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element�c�ƊO���v" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--���㌴��-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'���㌴��'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element���㌴��" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--�̊ǔ�-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'�̊ǔ�'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element�̊ǔ�" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--��p�t��-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'��p�t��'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element��p�t��" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--�c�ƊO��p-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'�c�ƊO��p'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop_����">
            <xsl:with-param name="element" select="$element�c�ƊO��p" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--�{�Д�-->
      <!--<tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'�{�Д�v�Z'"/>
          </td>
          --><!-- �f�[�^��\��--><!--
          <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z">
            <xsl:with-param name="element�\�Z" select="$element�\�Z" />
            <xsl:with-param name="element����" select="$element����" />
            <xsl:with-param name="element����t��" select="$element����t��" />
            <xsl:with-param name="element���㌴��" select="$element���㌴��" />
            <xsl:with-param name="element�̊ǔ�" select="$element�̊ǔ�" />
            <xsl:with-param name="element��p�t��" select="$element��p�t��" />
            <xsl:with-param name="element�c�ƊO��p" select="$element�c�ƊO��p" />
            <xsl:with-param name="element�c�ƊO���v" select="$element�c�ƊO���v" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>-->
    </table>
    <hr width="50%"/>

    <!--�{�Д�-->
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�{�Д�z���z'"/>
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
    <!--�{�Д�-->
      <tbody>
        <tr class='userType'>
          <td colspan="2" style='text-align:left;'>
            <xsl:value-of select="'�{�Д�o(���㌴��+�̊ǔ�-��p�t��+�c�ƊO��p)'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z_�o">
            <xsl:with-param name="element�\�Z" select="$element�\�Z" />
            <xsl:with-param name="element����" select="$element����" />
            <xsl:with-param name="element����t��" select="$element����t��" />
            <xsl:with-param name="element���㌴��" select="$element���㌴��" />
            <xsl:with-param name="element�̊ǔ�" select="$element�̊ǔ�" />
            <xsl:with-param name="element��p�t��" select="$element��p�t��" />
            <xsl:with-param name="element�c�ƊO��p" select="$element�c�ƊO��p" />
            <xsl:with-param name="element�c�ƊO���v" select="$element�c�ƊO���v" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <tbody>
        <tr class='groupType'>
          <td colspan="2" style='text-align:left;'>
            <xsl:value-of select="'�{�Д��(����+����t��+�c�ƊO���v)'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z_��">
            <xsl:with-param name="element�\�Z" select="$element�\�Z" />
            <xsl:with-param name="element����" select="$element����" />
            <xsl:with-param name="element����t��" select="$element����t��" />
            <xsl:with-param name="element���㌴��" select="$element���㌴��" />
            <xsl:with-param name="element�̊ǔ�" select="$element�̊ǔ�" />
            <xsl:with-param name="element��p�t��" select="$element��p�t��" />
            <xsl:with-param name="element�c�ƊO��p" select="$element�c�ƊO��p" />
            <xsl:with-param name="element�c�ƊO���v" select="$element�c�ƊO���v" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="valueOut_Loop_����">
    <xsl:param name="element" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="yosoku">
          <xsl:variable name="sumVal" select="sum($element/��[@m=$m])" />
          <xsl:variable name="mode" select="$element/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="valueOut_Loop_����">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($element/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="�{�Д�_valueOut_Loop_�v�Z">
    <xsl:param name="element�\�Z" />
    <xsl:param name="element����" />
    <xsl:param name="element����t��" />
    <xsl:param name="element���㌴��" />
    <xsl:param name="element�̊ǔ�" />
    <xsl:param name="element��p�t��" />
    <xsl:param name="element�c�ƊO��p" />
    <xsl:param name="element�c�ƊO���v" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td>
          <!--<xsl:variable name="sumVal�\�Z" select="sum($element�\�Z/��[@m=$m])" />-->
          <xsl:variable name="sumVal�\�Z" select="0" />
          <xsl:variable name="sumVal��" select="sum($element����/��[@m=$m])+sum($element����t��/��[@m=$m])+sum($element�c�ƊO���v/��[@m=$m])" />
          <xsl:variable name="sumVal�o" select="sum($element���㌴��/��[@m=$m])+sum($element�̊ǔ�/��[@m=$m])-sum($element��p�t��/��[@m=$m])+sum($element�c�ƊO��p/��[@m=$m])" />
          <xsl:variable name="sumVal" select="$sumVal�\�Z + $sumVal�� - $sumVal�o" />
          <xsl:variable name="mode" select="$element�\�Z/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
s            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z">
          <xsl:with-param name="element�\�Z" select="$element�\�Z" />
          <xsl:with-param name="element����" select="$element����" />
          <xsl:with-param name="element����t��" select="$element����t��" />
          <xsl:with-param name="element���㌴��" select="$element���㌴��" />
          <xsl:with-param name="element�̊ǔ�" select="$element�̊ǔ�" />
          <xsl:with-param name="element��p�t��" select="$element��p�t��" />
          <xsl:with-param name="element�c�ƊO��p" select="$element�c�ƊO��p" />
          <xsl:with-param name="element�c�ƊO���v" select="$element�c�ƊO���v" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal�\�Z" select="sum($element�\�Z/��)" />-->
          <xsl:variable name="sumVal�\�Z" select="0" />
          <xsl:variable name="sumVal��" select="sum($element����/��)+sum($element����t��/��)+sum($element�c�ƊO���v/��)" />
          <xsl:variable name="sumVal�o" select="sum($element���㌴��/��)+sum($element�̊ǔ�/��)-sum($element��p�t��/��)+sum($element�c�ƊO��p/��)" />
          <xsl:variable name="sumVal" select="$sumVal�\�Z + $sumVal�� - $sumVal�o" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="�{�Д�_valueOut_Loop_�v�Z_��">
    <xsl:param name="element�\�Z" />
    <xsl:param name="element����" />
    <xsl:param name="element����t��" />
    <xsl:param name="element���㌴��" />
    <xsl:param name="element�̊ǔ�" />
    <xsl:param name="element��p�t��" />
    <xsl:param name="element�c�ƊO��p" />
    <xsl:param name="element�c�ƊO���v" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td>
          <!--<xsl:variable name="sumVal�\�Z" select="sum($element�\�Z/��[@m=$m])" />-->
          <xsl:variable name="sumVal�\�Z" select="0" />
          <xsl:variable name="sumVal��" select="sum($element����/��[@m=$m])+sum($element����t��/��[@m=$m])+sum($element�c�ƊO���v/��[@m=$m])" />
          <xsl:variable name="sumVal�o" select="0" />
          <xsl:variable name="sumVal" select="$sumVal�o - ($sumVal�\�Z + $sumVal��)" />
          <xsl:variable name="mode" select="$element�\�Z/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z_��">
          <xsl:with-param name="element�\�Z" select="$element�\�Z" />
          <xsl:with-param name="element����" select="$element����" />
          <xsl:with-param name="element����t��" select="$element����t��" />
          <xsl:with-param name="element���㌴��" select="$element���㌴��" />
          <xsl:with-param name="element�̊ǔ�" select="$element�̊ǔ�" />
          <xsl:with-param name="element��p�t��" select="$element��p�t��" />
          <xsl:with-param name="element�c�ƊO��p" select="$element�c�ƊO��p" />
          <xsl:with-param name="element�c�ƊO���v" select="$element�c�ƊO���v" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal�\�Z" select="sum($element�\�Z/��)" />-->
          <xsl:variable name="sumVal�\�Z" select="0" />
          <xsl:variable name="sumVal��" select="sum($element����/��)+sum($element����t��/��)+sum($element�c�ƊO���v/��)" />
          <xsl:variable name="sumVal�o" select="0" />
          <xsl:variable name="sumVal" select="$sumVal�o - ($sumVal�\�Z + $sumVal��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="�{�Д�_valueOut_Loop_�v�Z_�o">
    <xsl:param name="element�\�Z" />
    <xsl:param name="element����" />
    <xsl:param name="element����t��" />
    <xsl:param name="element���㌴��" />
    <xsl:param name="element�̊ǔ�" />
    <xsl:param name="element��p�t��" />
    <xsl:param name="element�c�ƊO��p" />
    <xsl:param name="element�c�ƊO���v" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td>
          <!--<xsl:variable name="sumVal�\�Z" select="sum($element�\�Z/��[@m=$m])" />-->
          <xsl:variable name="sumVal�\�Z" select="0" />
          <xsl:variable name="sumVal��" select="0" />
          <xsl:variable name="sumVal�o" select="sum($element���㌴��/��[@m=$m])+sum($element�̊ǔ�/��[@m=$m])-sum($element��p�t��/��[@m=$m])+sum($element�c�ƊO��p/��[@m=$m])" />
          <xsl:variable name="sumVal" select="$sumVal�o - ($sumVal�\�Z + $sumVal��)" />
          <xsl:variable name="mode" select="$element�\�Z/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z_�o">
          <xsl:with-param name="element�\�Z" select="$element�\�Z" />
          <xsl:with-param name="element����" select="$element����" />
          <xsl:with-param name="element����t��" select="$element����t��" />
          <xsl:with-param name="element���㌴��" select="$element���㌴��" />
          <xsl:with-param name="element�̊ǔ�" select="$element�̊ǔ�" />
          <xsl:with-param name="element��p�t��" select="$element��p�t��" />
          <xsl:with-param name="element�c�ƊO��p" select="$element�c�ƊO��p" />
          <xsl:with-param name="element�c�ƊO���v" select="$element�c�ƊO���v" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal�\�Z" select="sum($element�\�Z/��)" />-->
          <xsl:variable name="sumVal�\�Z" select="0" />
          <xsl:variable name="sumVal��" select="0" />
          <xsl:variable name="sumVal�o" select="sum($element���㌴��/��)+sum($element�̊ǔ�/��)-sum($element��p�t��/��)+sum($element�c�ƊO��p/��)" />
          <xsl:variable name="sumVal" select="$sumVal�o - ($sumVal�\�Z + $sumVal��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ########################################################### -->


  <xsl:template match="�S��" mode="����t��">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'����t��'"/>
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
      <!--�e����̃f�[�^�\��-->
      <xsl:for-each select="�O���[�v[(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="����t��_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="����t��_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="����t��_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/����t��/����[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/��[@m=$m])" />
          <xsl:variable name="mode" select="$elementA/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="����t��_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�S��" mode="�c�ƊO���v">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�c�ƊO���v'"/>
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
      <!--�e����̃f�[�^�\��-->
      <xsl:for-each select="�O���[�v[(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="�c�ƊO���v_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�c�ƊO���v_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="�c�ƊO���v_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/�c�ƊO���v/����[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/��[@m=$m])" />
          <xsl:variable name="mode" select="$elementA/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�c�ƊO���v_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�S��" mode="�c�ƊO��p">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�c�ƊO��p'"/>
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
      <!--�e����̃f�[�^�\��-->
      <xsl:for-each select="�O���[�v[(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="�c�ƊO��p_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�c�ƊO��p_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="�c�ƊO��p_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/�c�ƊO��p/����[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/��[@m=$m])" />
          <xsl:variable name="mode" select="$elementA/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�c�ƊO��p_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�S��" mode="�̊ǔ�">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�̊ǔ�'"/>
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
      <!--�e����̃f�[�^�\��-->
      <xsl:for-each select="�O���[�v[(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="�̊ǔ�_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�̊ǔ�_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="�̊ǔ�_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/�̊ǔ�/����" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/��[@m=$m])" />
          <xsl:variable name="mode" select="$elementX/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�̊ǔ�_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="item" select="$item" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="�S��" mode="���㌴��">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'���㌴��'"/>
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
      <!--�e����̃f�[�^�\��-->
      <xsl:for-each select="�O���[�v[(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="�O����_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�O����_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="�O����_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/���㌴��/����" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/��[@m=$m])" />
          <xsl:variable name="mode" select="$elementX/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�O����_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="item" select="$item" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�S��" mode="��p�t��">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'��p�t��'"/>
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
      <!--�e����̃f�[�^�\��-->
      <xsl:for-each select="�O���[�v[(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="��p�t��_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="��p�t��_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="��p�t��_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/��p�t��/����[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/��[@m=$m])" />
          <xsl:variable name="mode" select="$elementX/../../�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="��p�t��_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="item" select="$item" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�S��" mode="����">
    <xsl:param name="item" select="'����'" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'����'"/>
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
      <!--�e����̃f�[�^�\��-->
      <xsl:for-each select="�O���[�v[(starts-with(���O,'�{��'))]">
        <xsl:variable name="�f�[�^" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="valueOut_Loop">
              <xsl:with-param name="����" select="$�f�[�^/���㍂/����[@name=$item]" />
              <xsl:with-param name="�����" select="$�f�[�^/�����" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="�f�[�^" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
           <!--�f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop">
            <xsl:with-param name="����" select="$�f�[�^/���㍂/����[@name=$item]" />
            <xsl:with-param name="�����" select="$�f�[�^/�����" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="valueOut_Loop">
    <xsl:param name="����" />
    <xsl:param name="�����" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- �e���̃f�[�^��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($����/��[@m=$m])" />
          <xsl:variable name="modeValue" select="$�����/��[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$modeValue='����'">
                <!-- - ����-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$modeValue='�\��'">
                <!-- - �\��-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - �v��-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="valueOut_Loop">
          <xsl:with-param name="����" select="$����" />
          <xsl:with-param name="�����" select="$�����" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($����/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!--		-->
  <xsl:include href="sub_cmn.xsl"/>
  <xsl:include href="sub_JScript.xsl"/>

</xsl:stylesheet>
