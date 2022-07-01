<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:msxsl="urn:schemas-microsoft-com:xslt"
      xmlns:user="mynamespace">

	<!--      xmlns:user="http://mycompany.com/mynamespace">	-->

  <xsl:template match="/">
<html>
<head>
<title>�v���W�F�N�g</title>
<link rel="stylesheet" type="text/css" href="cost.css"/>
</head>

<body background="bg.gif">
  <xsl:if test="/root/�S��/�v���W�F�N�g/����!=''">
 
  <xsl:apply-templates select="root/�S��" />
  <br/>
  <hr/>
  <br/>
  <xsl:call-template name="help"/>
  </xsl:if>
</body>
</html>

</xsl:template>

  <xsl:variable name="actualColor">
    <xsl:value-of select="'actualColor'"/>
  </xsl:variable>
  <xsl:variable name="editColor">
    <xsl:value-of select="'editColor'"/>
  </xsl:variable>

  <xsl:variable name="actualCnt">
    <xsl:value-of select="//���ь���"/>
  </xsl:variable>

  <xsl:variable name="�Ј��P��">
    <xsl:value-of select="1"/>
  </xsl:variable>
  <xsl:variable name="�p�[�g�P��">
    <xsl:value-of select="111250000"/>
  </xsl:variable>
  <xsl:variable name="���͒P��">
    <xsl:value-of select="1"/>
  </xsl:variable>
  <xsl:variable name="�J�n�N">
    <xsl:value-of select="//�J�n�N"/>
  </xsl:variable>
  <xsl:variable name="�J�n��">
    <xsl:value-of select="//�J�n��"/>
  </xsl:variable>
  <xsl:variable name="����">
    <xsl:value-of select="//����"/>
  </xsl:variable>

  <xsl:template match="�S��">

    <table class="disp" cellpadding="0" cellspacing="0" width="100%">
      <thead>
        <xsl:apply-templates select="�v���W�F�N�g" mode="spaceOut"/>
        <xsl:apply-templates select="�v���W�F�N�g" mode="spaceOut">
          <xsl:with-param name="memo" select="'(�P�ʁF��~)'" />
        </xsl:apply-templates>
      </thead>

      <thead>
        <xsl:apply-templates select="�v���W�F�N�g" mode="headerOut">
          <xsl:with-param name="title" select="'����E����'" />
        </xsl:apply-templates>
      </thead>
      <tbody>
        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut">
          <xsl:with-param name="title" select="'�������'" />
          <xsl:with-param name="item" select="'����'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>
      </tbody>

      <thead>
        <xsl:apply-templates select="�v���W�F�N�g" mode="spaceOut"/>
        <xsl:apply-templates select="�v���W�F�N�g" mode="spaceOut">
          <xsl:with-param name="memo" select="'(�P�ʁF�l��)'" />
        </xsl:apply-templates>
      </thead>

      <thead>
        <xsl:apply-templates select="�v���W�F�N�g" mode="headerOut">
          <xsl:with-param name="title" select="'�H���E����'" />
        </xsl:apply-templates>
      </thead>
      <tbody>
        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut">
          <xsl:with-param name="title" select="'�Ј��H��'" />
          <xsl:with-param name="item" select="'�Ј��H��'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut">
          <xsl:with-param name="title" select="'�p�[�g�H��'" />
          <xsl:with-param name="item" select="'�p�[�g�H��'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut">
          <xsl:with-param name="title" select="'���͍H��'" />
          <xsl:with-param name="item" select="'���͍H��'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut_�H�����v">
          <xsl:with-param name="title" select="'�H�����v'" />
          <xsl:with-param name="item" select="'�H�����v'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>
      </tbody>

      <thead>
        <xsl:apply-templates select="�v���W�F�N�g" mode="spaceOut"/>
        <xsl:apply-templates select="�v���W�F�N�g" mode="spaceOut">
          <xsl:with-param name="memo" select="'(�P�ʁF��~)'" />
        </xsl:apply-templates>
      </thead>
      <thead>
        <xsl:apply-templates select="�v���W�F�N�g" mode="headerOut">
          <xsl:with-param name="title" select="'��p�E����'" />
        </xsl:apply-templates>
      </thead>
      <tbody>
        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut">
          <xsl:with-param name="title" select="'�Ɩ���p'" />
          <xsl:with-param name="item" select="'�Ɩ���p'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut_�J����">
          <xsl:with-param name="title" select="'�J����'" />
          <xsl:with-param name="item" select="'�J����'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut">
          <xsl:with-param name="title" select="'���͔�p'" />
          <xsl:with-param name="item" select="'���͔�p'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="�v���W�F�N�g" mode="valueOut_��p���v">
          <xsl:with-param name="title" select="'��p���v'" />
          <xsl:with-param name="item" select="'��p���v'" />
          <xsl:with-param name="mode" select="'����'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>
      </tbody>

    </table>
    <br/>
  </xsl:template>

    <!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->
  <!--  �w�荀�ڂ̗�o�́@  -->
  <!--�@title:�@�\�̑薼�@  -->
  <!--�@unit:�P�ʁ@�@�@�@   -->
  <!--�@form:�\���`���@�@   -->
  <!--�@item:�������鍀�ږ� -->
  <xsl:template match="�v���W�F�N�g" mode="valueOut">
    <xsl:param name="pNum" select="pNum"/>
    <xsl:param name="yymm" select="yymm"/>
    <xsl:param name="year" select="�J�n�N"/>
    <xsl:param name="mm" select="�J�n��"/>
    <xsl:param name="mCnt" select="����"/>
    <xsl:param name="title"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
      <xsl:variable name="cnt1" select="count(����[@name=$item and @mode=$mode])"/>
      <xsl:for-each select="����[@name=$item and @mode=$mode]">
        <tr>
          <xsl:attribute name="item">
            <xsl:value-of select="$item"/>
          </xsl:attribute>
          <xsl:attribute name="pNum">
            <xsl:value-of select="$pNum"/>
          </xsl:attribute>
          <xsl:attribute name="yymm">
            <xsl:value-of select="$yymm"/>
          </xsl:attribute>
          <xsl:attribute name="mode">
            <xsl:value-of select="$mode"/>
          </xsl:attribute>
          <td class="sItem">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="id">
              <xsl:value-of select="'Detail'"/>
            </xsl:attribute>
            <xsl:attribute name="item">
              <xsl:value-of select="$title"/>
            </xsl:attribute>
            <xsl:attribute name="mode">
              <xsl:value-of select="$mode"/>
            </xsl:attribute>
            <xsl:value-of select="$title"/>
          </td>
          <!--��̍��v-->
          <td id="sumCell">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="sum(*)"/>
            </xsl:attribute>
            <xsl:value-of select="format-number(sum(*) div $unit,$form)"/>
          </td>
          <xsl:call-template name="valueOut_Loop">
            <xsl:with-param name="element" select="." />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="begin" select="0" />
            <xsl:with-param name="mCnt" select="$mCnt" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="form" select="$form" />
          </xsl:call-template>
        </tr>
      </xsl:for-each>
  </xsl:template>

  <!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->
  <!--  �w�荀�ڂ̗�o�́@  -->
  <!--�@title:�@�\�̑薼�@  -->
  <!--�@unit:�P�ʁ@�@�@�@   -->
  <!--�@form:�\���`���@�@   -->
  <!--�@item:�������鍀�ږ� -->
  <xsl:template match="�v���W�F�N�g" mode="valueOutOne">
    <xsl:param name="m" select="0"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
    <xsl:for-each select="����[@name=$item and @mode=$mode]">
          <td id="Cell">
            <xsl:attribute name="class">
              <xsl:value-of select="$editColor"/>
            </xsl:attribute>
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="��[@m=$m]"/>
            </xsl:attribute>
            <xsl:attribute name="m">
              <xsl:value-of select="$m"/>
            </xsl:attribute>
            <xsl:value-of select="format-number(��[@m=$m] div $unit,$form)"/>
          </td>
      </xsl:for-each>
  </xsl:template>

  <!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->

<!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->
  <!--  �N���̃w�b�_�[�̕\�o�́@  -->
<xsl:template match="�v���W�F�N�g" mode="headerOut">
  <xsl:param name="title"/>
  <xsl:param name="year" select="�J�n�N"/>
  <xsl:param name="mm" select="�J�n��"/>
	<xsl:param name="mCnt" select="����"/>
			<tr>
				<th rowspan="2">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="$title"/>
				</th>
				<th class="m" rowspan="2">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="'���v'"/>
				</th>
					<xsl:call-template name="year_Loop">
						<xsl:with-param name="year" select="$year" />
						<xsl:with-param name="begin" select="$mm" />
						<xsl:with-param name="mCnt" select="$mCnt" />
					</xsl:call-template>
				</tr>
				<tr>
					<xsl:call-template name="month_Loop">
						<xsl:with-param name="begin" select="$mm" />
						<xsl:with-param name="mCnt" select="$mCnt" />
					</xsl:call-template>
				</tr>
	</xsl:template>

  <!--  �@  -->
  <xsl:template match="�v���W�F�N�g" mode="spaceOut">
    <xsl:param name="memo"/>
    <xsl:param name="mCnt" select="����"/>
    <tr style="background-color:transparent;border:0 0 0 0;">
          <xsl:choose>
            <xsl:when test="$memo = ''">
              <th colspan="{$mCnt+2}">
                <xsl:attribute name="style">
                <xsl:value-of select="'border:0 0 0 0;'"/>
              </xsl:attribute>
              <hr/>
              </th>
            </xsl:when>
            <xsl:otherwise>
              <td colspan="{$mCnt+2}">
                <xsl:attribute name="style">
                <xsl:value-of select="'border:0 0 0 0;text-align:right;'"/>
              </xsl:attribute>
              <xsl:value-of select="$memo"/>
              </td>
            </xsl:otherwise>
          </xsl:choose>
      </tr>
  </xsl:template>
  <!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->


<!--�@�f�[�^�s�̕\���@-->
<xsl:template name="valueOut_Loop">
  <xsl:param name="item" />
  <xsl:param name="begin" />
  <xsl:param name="mCnt" />
	<xsl:param name="max" select="$begin+$mCnt"/>
	<xsl:param name="cnt" select="$begin"/>
	<xsl:param name="mode" />
	<xsl:param name="unit" />
	<xsl:param name="form"/>
	<xsl:if test="$cnt &lt; $max">
		<td>
      <xsl:choose>
        <xsl:when test="$mode='�\��'">
          <xsl:attribute name="id">
            <xsl:value-of select="'Cell'"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$cnt&lt;$actualCnt">
              <xsl:attribute name="class">
                <xsl:value-of select="$actualColor"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">
                <xsl:value-of select="$editColor"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$mode='����'">
          <xsl:attribute name="id">
            <xsl:value-of select="'viewCell'"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$cnt&lt;$actualCnt">
              <xsl:attribute name="class">
                <xsl:value-of select="$actualColor"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">
                <xsl:value-of select="$editColor"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="id">
            <xsl:value-of select="'viewCell'"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="nowrap" />
      <xsl:attribute name="value"><xsl:value-of select="��[@m=$cnt]"/></xsl:attribute>
			<xsl:attribute name="m"><xsl:value-of select="$cnt"/></xsl:attribute>
			<xsl:if test="sum(��[@m=$cnt])!=0">
        <xsl:value-of select="format-number(��[@m=$cnt] div $unit,$form)"/>
      </xsl:if>
		</td>
			<xsl:call-template name="valueOut_Loop">
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="mode" select="$mode" />
				<xsl:with-param name="unit" select="$unit" />
				<xsl:with-param name="form" select="$form" />
			</xsl:call-template>
	</xsl:if>
</xsl:template>


  <!--  �w�荀�ڂ̗�o�́@  -->
  <!--�@title:�@�\�̑薼�@  -->
  <!--�@unit:�P�ʁ@�@�@�@   -->
  <!--�@form:�\���`���@�@   -->
  <!--�@item:�������鍀�ږ� -->
  <xsl:template match="�v���W�F�N�g" mode="valueOut_�J����">
    <xsl:param name="pNum" select="pNum"/>
    <xsl:param name="yymm" select="yymm"/>
    <xsl:param name="year" select="�J�n�N"/>
    <xsl:param name="mm" select="�J�n��"/>
    <xsl:param name="mCnt" select="����"/>
    <xsl:param name="title"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
      <xsl:variable name="cnt1" select="count(����[@name=$item and @mode=$mode])"/>
      <xsl:for-each select="����[@name=$item and @mode=$mode]">
        <tr>
          <xsl:attribute name="item">
            <xsl:value-of select="$item"/>
          </xsl:attribute>
          <xsl:attribute name="pNum">
            <xsl:value-of select="$pNum"/>
          </xsl:attribute>
          <xsl:attribute name="yymm">
            <xsl:value-of select="$yymm"/>
          </xsl:attribute>
          <xsl:attribute name="mode">
            <xsl:value-of select="$mode"/>
          </xsl:attribute>
          <td class="sItem">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="id">
              <xsl:value-of select="'Detail'"/>
            </xsl:attribute>
            <xsl:attribute name="item">
              <xsl:value-of select="$title"/>
            </xsl:attribute>
            <xsl:attribute name="mode">
              <xsl:value-of select="$mode"/>
            </xsl:attribute>
            <xsl:value-of select="$title"/>
          </td>
          <!--��̍��v-->
          <td id="sumCell">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="sum(*)"/>
            </xsl:attribute>
            <xsl:variable name="�J����" select="sum(../����[@name='�J����' and @mode='����']/��)"/>
            <xsl:if test="($�J����) != 0">
              <xsl:value-of select="format-number(($�J����) div $unit,$form)"/>
            </xsl:if>
          </td>
          <xsl:call-template name="valueOut_�J����_Loop">
            <xsl:with-param name="element" select="." />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="begin" select="0" />
            <xsl:with-param name="mCnt" select="$mCnt" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="form" select="$form" />
          </xsl:call-template>
        </tr>
      </xsl:for-each>
  </xsl:template>

  <!--�@�f�[�^�s�̕\���@-->
  <xsl:template name="valueOut_�J����_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="mode" />
    <xsl:param name="unit" />
    <xsl:param name="form"/>
    <xsl:if test="$cnt &lt; $max">
      <td id="viewCell">
        <xsl:attribute name="nowrap" />
        <xsl:choose>
          <xsl:when test="$cnt&lt;$actualCnt">
            <xsl:attribute name="class">
              <xsl:value-of select="$actualColor"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">
              <xsl:value-of select="$editColor"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:attribute name="value">
          <xsl:value-of select="��[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:variable name="�J����" select="sum(../����[@name='�J����' and @mode='����']/��[@m=$cnt])"/>
        <xsl:if test="$�J���� != 0">
          <xsl:value-of select="format-number($�J���� div $unit,$form)"/>
        </xsl:if>
      </td>
      <xsl:call-template name="valueOut_�J����_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
        <xsl:with-param name="mode" select="$mode" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="form" select="$form" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>



  <!--  �w�荀�ڂ̗�o�́@  -->
  <!--�@title:�@�\�̑薼�@  -->
  <!--�@unit:�P�ʁ@�@�@�@   -->
  <!--�@form:�\���`���@�@   -->
  <!--�@item:�������鍀�ږ� -->
  <xsl:template match="�v���W�F�N�g" mode="valueOut_��p���v">
    <xsl:param name="pNum" select="pNum"/>
    <xsl:param name="yymm" select="yymm"/>
    <xsl:param name="year" select="�J�n�N"/>
    <xsl:param name="mm" select="�J�n��"/>
    <xsl:param name="mCnt" select="����"/>
    <xsl:param name="title"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
      <!--<xsl:variable name="cnt1" select="count(����[@name=$item and @mode=$mode])"/>-->
      <xsl:for-each select="����[@name=$item and @mode=$mode]">
        <tr>
          <xsl:attribute name="item">
            <xsl:value-of select="$item"/>
          </xsl:attribute>
          <xsl:attribute name="pNum">
            <xsl:value-of select="$pNum"/>
          </xsl:attribute>
          <xsl:attribute name="yymm">
            <xsl:value-of select="$yymm"/>
          </xsl:attribute>
          <xsl:attribute name="mode">
            <xsl:value-of select="$mode"/>
          </xsl:attribute>
          <td class="sItem">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:gainsboro;'"/>
            </xsl:attribute>
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="$title"/>
          </td>
          <!--��̍��v-->
          <td  id="sumCell">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="sum(*)"/>
            </xsl:attribute>
            <xsl:variable name="�J����" select="sum(../����[@name='�J����' and @mode='����']/��)"/>
            <xsl:variable name="�Ɩ���p" select="sum(../����[@name='�Ɩ���p' and @mode='����']/��)"/>
            <xsl:variable name="���͔�p" select="sum(../����[@name='���͔�p' and @mode='����']/��)"/>
            <xsl:variable name="��p���v" select="$�J���� + $�Ɩ���p + $���͔�p"/>
            <xsl:if test="$��p���v >= 0">
              <xsl:value-of select="format-number($��p���v div $unit,$form)"/>
            </xsl:if>
          </td>
          <xsl:call-template name="valueOut_��p���v_Loop">
            <xsl:with-param name="element" select="." />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="begin" select="0" />
            <xsl:with-param name="mCnt" select="$mCnt" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="form" select="$form" />
          </xsl:call-template>
        </tr>
      </xsl:for-each>
  </xsl:template>

  <!--�@�f�[�^�s�̕\���@-->
  <xsl:template name="valueOut_��p���v_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="mode" />
    <xsl:param name="unit" />
    <xsl:param name="form"/>
    <xsl:if test="$cnt &lt; $max">
      <td id="sumCell">
        <xsl:attribute name="nowrap" />
        <xsl:attribute name="value">
          <xsl:value-of select="��[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:variable name="�J����" select="sum(../����[@name='�J����' and @mode='����']/��[@m=$cnt])"/>
        <xsl:variable name="�Ɩ���p" select="sum(../����[@name='�Ɩ���p' and @mode='����']/��[@m=$cnt])"/>
        <xsl:variable name="���͔�p" select="sum(../����[@name='���͔�p' and @mode='����']/��[@m=$cnt])"/>
        <xsl:variable name="��p���v" select="$�J���� + $�Ɩ���p + $���͔�p"/>
        <xsl:if test="$��p���v >= 0">
          <xsl:value-of select="format-number($��p���v div $unit ,$form)"/>
        </xsl:if>
      </td>
      <xsl:call-template name="valueOut_��p���v_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
        <xsl:with-param name="mode" select="$mode" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="form" select="$form" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--  �w�荀�ڂ̗�o�́@  -->
  <!--�@title:�@�\�̑薼�@  -->
  <!--�@unit:�P�ʁ@�@�@�@   -->
  <!--�@form:�\���`���@�@   -->
  <!--�@item:�������鍀�ږ� -->
  <xsl:template match="�v���W�F�N�g" mode="valueOut_�H�����v">
    <xsl:param name="pNum" select="pNum"/>
    <xsl:param name="yymm" select="yymm"/>
    <xsl:param name="year" select="�J�n�N"/>
    <xsl:param name="mm" select="�J�n��"/>
    <xsl:param name="mCnt" select="����"/>
    <xsl:param name="title"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
      <xsl:variable name="cnt1" select="count(����[@name=$item and @mode=$mode])"/>
      <xsl:for-each select="����[@name=$item and @mode=$mode]">
        <tr>
          <xsl:attribute name="item">
            <xsl:value-of select="$item"/>
          </xsl:attribute>
          <xsl:attribute name="pNum">
            <xsl:value-of select="$pNum"/>
          </xsl:attribute>
          <xsl:attribute name="yymm">
            <xsl:value-of select="$yymm"/>
          </xsl:attribute>
          <xsl:attribute name="mode">
            <xsl:value-of select="$mode"/>
          </xsl:attribute>
          <td class="sItem">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:gainsboro;'"/>
            </xsl:attribute>
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="$title"/>
          </td>
          <!--��̍��v-->
          <td id="sumCell">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="sum(*)"/>
            </xsl:attribute>
            <xsl:variable name="�Ј��H��" select="sum(../����[@name='�Ј��H��' and @mode='����']/��)"/>
            <xsl:variable name="�p�[�g�H��" select="sum(../����[@name='�p�[�g�H��' and @mode='����']/��)"/>
            <xsl:variable name="���͍H��" select="sum(../����[@name='���͍H��' and @mode='����']/��)"/>
            <xsl:variable name="�H�����v" select="$�Ј��H�� + $�p�[�g�H�� + $���͍H��"/>
            <xsl:if test="$�H�����v >= 0">
              <xsl:value-of select="format-number($�H�����v div $unit,$form)"/>
            </xsl:if>
          </td>
          <xsl:call-template name="valueOut_�H�����v_Loop">
            <xsl:with-param name="element" select="." />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="begin" select="0" />
            <xsl:with-param name="mCnt" select="$mCnt" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="form" select="$form" />
          </xsl:call-template>
        </tr>
      </xsl:for-each>
  </xsl:template>

  <!--�@�f�[�^�s�̕\���@-->
  <xsl:template name="valueOut_�H�����v_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="mode" />
    <xsl:param name="unit" />
    <xsl:param name="form"/>
    <xsl:if test="$cnt &lt; $max">
      <td id="sumCell">
        <xsl:attribute name="nowrap" />
        <xsl:attribute name="value">
          <xsl:value-of select="��[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:variable name="�Ј��H��" select="sum(../����[@name='�Ј��H��' and @mode='����']/��[@m=$cnt])"/>
        <xsl:variable name="�p�[�g�H��" select="sum(../����[@name='�p�[�g�H��' and @mode='����']/��[@m=$cnt])"/>
        <xsl:variable name="���͍H��" select="sum(../����[@name='���͍H��' and @mode='����']/��[@m=$cnt])"/>
        <xsl:variable name="�H�����v" select="$�Ј��H�� + $�p�[�g�H�� + $���͍H��"/>
        <xsl:if test="$�H�����v >= 0">
          <xsl:value-of select="format-number($�H�����v div $unit,$form)"/>
        </xsl:if>
      </td>
      <xsl:call-template name="valueOut_�H�����v_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
        <xsl:with-param name="mode" select="$mode" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="form" select="$form" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--	�N�̕\��	-->
	
	<xsl:template name="year_Loop">
		<xsl:param name="begin" />
		<xsl:param name="year" />
		<xsl:param name="mCnt" />
		<xsl:param name="cnt" select="12 - $begin + 1"/>
		<xsl:if test="$mCnt &gt; 0">
			<th>
			<xsl:attribute name="colspan">
				<xsl:if test="$cnt &gt;= $mCnt">
					<xsl:value-of select="$mCnt"/>
				</xsl:if>
				<xsl:if test="$cnt &lt; $mCnt">
					<xsl:value-of select="$cnt"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:value-of select="$year"/>�N
			</th>
				<xsl:call-template name="year_Loop">
					<xsl:with-param name="year" select="$year+1" />
					<xsl:with-param name="mCnt" select="$mCnt - $cnt" />
					<xsl:with-param name="cnt" select="12" />
				</xsl:call-template>
		</xsl:if>
	</xsl:template>

	
<!--	���̕\��	-->
	<xsl:template name="month_Loop">
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:if test="$cnt &lt; $max">
			<th class="m">
			<xsl:attribute name="nowrap" />
				<xsl:if test="($cnt mod 12)>0">
					<xsl:value-of select="$cnt mod 12"/>��
				</xsl:if>
				<xsl:if test="($cnt mod 12)=0">
					<xsl:value-of select="12"/>��
				</xsl:if>
			</th>
				<xsl:call-template name="month_Loop">
					<xsl:with-param name="max" select="$max" />
					<xsl:with-param name="cnt" select="$cnt + 1" />
				</xsl:call-template>
		</xsl:if>
	</xsl:template>

  <xsl:template name="help">
    <table class="disp">
      <thead>
        <tr>
          <th rowspan="2">
            <xsl:value-of select="'����'"/>
          </th>
          <th colspan="2">
            <xsl:value-of select="'���@��'"/>
          </th>
        </tr>
        <tr>
          <th>
            <xsl:value-of select="'����'"/>
          </th>
          <th>
            <xsl:value-of select="'�\��'"/>
          </th>
        </tr>
        </thead>
      <tbody>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'����'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'����s�f�[�^'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'�č����̓f�[�^�i��~�j'"/>
          </td>
        </tr>
      </tbody>
      <tbody>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'�Ɩ���p'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'��v�f�[�^(�w���`�[�E���z)'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'�č����̓f�[�^�i��~�j'"/>
          </td>
        </tr>
      </tbody>
      <tbody>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'���͍H��'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'��v�f�[�^(�w���`�[�E�H��)'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'�č����͍H��'"/>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'���͔�p'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'��v�f�[�^(�w���`�[�E���z)'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'(�č����͍H�� �� ���̓O���[�h�P�� ) '"/>
          </td>
        </tr>
      </tbody>
      <tbody>
            <tr>
          <td class="sItem">
            <xsl:value-of select="'�J����(�Ј�)'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'(�Ζ��f�[�^ �� �Ј��O���[�h�P�� ) �{ �t�є� '"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'(�č����͍H�� �� �Ј��O���[�h�P�� ) �{ �t�є� '"/>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'�J����(�p�[�g)'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'(�Ζ��f�[�^ �� �p�[�g�O���[�h�P��) �{ �t�є� '"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'(�č����͍H�� �� �p�[�g�O���[�h�P��) �{ �t�є� '"/>
          </td>
        </tr>
      </tbody>
      <thead>
        <tr>
          <th>
            <xsl:value-of select="'���с{�\��'"/>
          </th>
          <th colspan="2">
            <xsl:value-of select="'���ь��� �{ �\������'"/>
          </th>
        </tr>
      </thead>
      <tbody>
          <tr>
            <td class="sItem">
              <xsl:value-of select="'�J����'"/>
            </td>
            <td colspan="2" class="l_Item">
              <xsl:value-of select="'�J����(�Ј�) �{ �J����(�p�[�g)'"/>
            </td>
          </tr>
          <tr>
            <td class="sItem">
              <xsl:value-of select="'����'"/>
            </td>
            <td colspan="2" class="l_Item">
              <xsl:value-of select="'�J���� �{ ���͔�p �{ �Ɩ���p'"/>
            </td>
          </tr>
          <tr>
          <td class="sItem">
            <xsl:value-of select="'���v'"/>
          </td>
          <td colspan="2" class="l_Item">
            <xsl:value-of select="'���� �\ ����'"/>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'������'"/>
          </td>
          <td colspan="2" class="l_Item">
            <xsl:value-of select="'���� �� ����'"/>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template name="value_Out">
    <xsl:param name="form" />
    <xsl:param name="value" />
    <xsl:choose>
      <xsl:when test="$value = 0">
        <xsl:value-of select="'�@'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="format-number($value,$form)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
