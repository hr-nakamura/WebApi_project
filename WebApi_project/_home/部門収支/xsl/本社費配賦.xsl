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

  <xsl:variable name="�Ώ�"><xsl:value-of select="/root/�S��/�\��"/></xsl:variable>
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
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="�{�Д�z�������z"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="����Œ��"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <!--<xsl:apply-templates select="�S��" mode="�{�Д�z��">
                <xsl:with-param name="item" select="'�{�Д�'" />
              </xsl:apply-templates>-->
              <xsl:apply-templates select="�S��" mode="�{�Д�z�z"/>
            </td>
          </tr>
        </tbody>
      </table>
      <br/>
      <br/>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="�{�Д�Ώ۔�p"/>
            </td>
          </tr>
        </tbody>
      </table>
      <br/>
      <br/>
      <hr width="80%" size="4" color="blue"/>
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="�S��" mode="�̊ǔ�">
                <xsl:with-param name="item" select="'�l����'" />
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
              <xsl:apply-templates select="�S��" mode="�Œ��">
                <xsl:with-param name="item" select="'�l����'" />
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
              <xsl:apply-templates select="�S��" mode="�̊ǔ�">
              <xsl:with-param name="item" select="'�G��'" />
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
              <xsl:apply-templates select="�S��" mode="���㌴��">
                <xsl:with-param name="item" select="'�O����'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>

  </xsl:template>


  <!-- ########################################################### -->



  <xsl:template match="�S��" mode="�{�Д�Ώ۔�p">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�{�Д�Ώ۔�p'"/>
        <br/>
        <xsl:value-of select="'(�̊ǔ�̐l����~1.0)�{(����Œ��̐l����~1.0)�{(�̊ǔ�̎G���~0.03)�{(���㌴���̊O����~0.03)'"/>
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
      <xsl:for-each select="�O���[�v[not(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="�{�Д�Ώ۔�p_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[not(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�{�Д�Ώ۔�p_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="�{�Д�Ώ۔�p_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/�̊ǔ�/����[@name='�l����']" />
    <xsl:param name="elementB" select="$element/����Œ��/����[@name='�l����']" />
    <xsl:param name="elementC" select="$element/�̊ǔ�/����[@name='�G��']" />
    <xsl:param name="elementD" select="$element/���㌴��/����[@name='�O����']" />
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
          <xsl:variable name="sumVal" select="sum($elementA/��[@m=$m])+sum($elementB/��[@m=$m])+(sum($elementC/��[@m=$m])*$partUnit)+(sum($elementD/��[@m=$m])*$partUnit)" />
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
        <xsl:call-template name="�{�Д�Ώ۔�p_valueOut_Loop">
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
          <xsl:variable name="sumVal" select="sum($elementA/��)+sum($elementB/��)+(sum($elementC/��)*$partUnit)+(sum($elementD/��)*$partUnit)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose> 
  </xsl:template>

  <xsl:template match="�S��" mode="����Œ��">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'����Œ��'"/>
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
      <xsl:for-each select="�O���[�v[not(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="����Œ��_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[not(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="����Œ��_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="����Œ��_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/����Œ��/����[*]" />
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
        <xsl:call-template name="����Œ��_valueOut_Loop">
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


  <xsl:template match="�S��" mode="�{�Д�z�������z">
    <xsl:variable name="elementA" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/�\�Z/����[@name='�\�Z']" />
    <xsl:variable name="elementB" select="�O���[�v[(starts-with(���O,'�{��'))]/�f�[�^[@name='�v��']/���㍂/����[@name='����']" />
    <xsl:variable name="elementC" select="�O���[�v[not(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]/����Œ��/����[*]" />
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
          <xsl:call-template name="�v��_valueOut_Loop_����">
            <xsl:with-param name="element" select="$elementA" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--����v��-->
      <!--<tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'�{�Д���(�v��)'"/>
          </td>
          <xsl:call-template name="�v��_valueOut_Loop_����">
            <xsl:with-param name="element" select="$elementB" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>-->
      <!--����Œ��-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'����Œ��'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="����Œ��_valueOut_Loop_����">
            <xsl:with-param name="element" select="$elementC" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--�{�Д�-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'�{�Д�z���z'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z">
            <xsl:with-param name="elementA" select="$elementA" />
            <!--<xsl:with-param name="elementB" select="$elementB" />-->
            <xsl:with-param name="elementC" select="$elementC" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="�v��_valueOut_Loop_����">
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
        <td class="target">
          <xsl:variable name="sumVal" select="sum($element/��[@m=$m])" />
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'�@'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="�v��_valueOut_Loop_����">
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

  <xsl:template name="����Œ��_valueOut_Loop_����">
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
        <xsl:call-template name="����Œ��_valueOut_Loop_����">
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
    <xsl:param name="elementA" />
    <xsl:param name="elementB" />
    <xsl:param name="elementC" />
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
          <!--<xsl:variable name="sumVal" select="sum($elementA/��[@m=$m])-sum($elementB/��[@m=$m])-sum($elementC/��[@m=$m])" />-->
          <xsl:variable name="sumVal" select="sum($elementA/��[@m=$m])-sum($elementC/��[@m=$m])" />
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
        <xsl:call-template name="�{�Д�_valueOut_Loop_�v�Z">
          <xsl:with-param name="elementA" select="$elementA" />
          <xsl:with-param name="elementB" select="$elementB" />
          <xsl:with-param name="elementC" select="$elementC" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- �P�Q�J�����̍��v��\��-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal" select="sum($elementA/��)-sum($elementB/��)-sum($elementC/��)" />-->
          <xsl:variable name="sumVal" select="sum($elementA/��)-sum($elementC/��)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="�S��" mode="�̊ǔ�">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�̊ǔ��'"/>
        <xsl:value-of select="$item"/>
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
      <xsl:for-each select="�O���[�v[not(starts-with(���O,'�{��'))]">
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
        <xsl:variable name="element" select="�O���[�v[not(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
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
    <xsl:param name="elementX" select="$element/�̊ǔ�/����[@name=$item]" />
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
        <xsl:value-of select="'���㌴����'"/>
        <xsl:value-of select="$item"/>
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
      <xsl:for-each select="�O���[�v[not(starts-with(���O,'�{��'))]">
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
        <xsl:variable name="element" select="�O���[�v[not(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
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
    <xsl:param name="elementX" select="$element/���㌴��/����[@name=$item]" />
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

  <xsl:template match="�S��" mode="�Œ��">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'����Œ���'"/>
        <xsl:value-of select="$item"/>
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
      <xsl:for-each select="�O���[�v[not(starts-with(���O,'�{��'))]">
        <xsl:variable name="element" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="�Œ��_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="element" select="�O���[�v[not(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
          <!-- �f�[�^��\��-->
          <xsl:call-template name="�Œ��_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="�Œ��_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/����Œ��/����[@name=$item]" />
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
        <xsl:call-template name="�Œ��_valueOut_Loop">
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

  <xsl:template match="�S��" mode="�{�Д�z�z">
    <xsl:param name="item" select="'�{�Д�'" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'�{�Д�z�z'"/>
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
      <xsl:for-each select="�O���[�v[not(starts-with(���O,'�{��'))]">
        <xsl:variable name="�f�[�^" select="�f�[�^[@name=$�Ώ�]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="���O"/>
            </td>
            <!-- �f�[�^��\��-->
            <xsl:call-template name="valueOut_Loop">
              <xsl:with-param name="����" select="$�f�[�^/�{�Д�z��/����[@name=$item]" />
              <xsl:with-param name="�����" select="$�f�[�^/�����" />
              <xsl:with-param name="mCnt" select="$����" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--�S����̍��v-->
      <tbody>
        <xsl:variable name="�f�[�^" select="�O���[�v[not(starts-with(���O,'�{��'))]/�f�[�^[@name=$�Ώ�]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'���@�v'"/>
          </td>
           <!--�f�[�^��\��-->
          <xsl:call-template name="valueOut_Loop">
            <xsl:with-param name="����" select="$�f�[�^/�{�Д�z��/����[@name=$item]" />
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
