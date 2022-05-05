<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">	
    <xsl:variable name="form" select="'#,###'" />


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
    <xsl:if test="count(*) = 0">
              <xsl:value-of select="'�f�[�^�͂���܂���'"/>

    </xsl:if>

    <xsl:if test="count(*) > 0">
      <table border="1" align="left">
        <tbody>
            <xsl:call-template name="����">
              <xsl:with-param name="����" select="*"/>
            </xsl:call-template>
        </tbody>
    </table>
    </xsl:if>

  </xsl:template>


	<xsl:template name="����">
    <xsl:param name="����"/>
    <xsl:variable name="cnt0" select="count($����)"/>
          <tr>
        <th>
          <xsl:value-of select="'���ޖ�'"/>
        </th>
        <th>
          <xsl:value-of select="'�q�於'"/>
        </th>
        <th>
        </th>
        <xsl:call-template name="year_Loop">
          <xsl:with-param name="year" select="2021"/>
          <xsl:with-param name="begin" select="10"/>
          <xsl:with-param name="mCnt" select="12"/>
        </xsl:call-template>
    </tr>
    <xsl:for-each select="$����">
      <tr>
        <th colspan="2">
        </th>
        <th>
          <xsl:value-of select="'���@�v'"/>
        </th>
        <xsl:call-template name="month_Loop">
          <xsl:with-param name="begin" select="10"/>
          <xsl:with-param name="mCnt" select="12"/>
        </xsl:call-template>
      </tr>
      <xsl:variable name="pos0" select="position()"/>
      <xsl:variable name="cnt1" select="count(uName/*)"/>
      <xsl:for-each select="uName/*">
        <xsl:variable name="pos1" select="position()"/>
        <xsl:call-template name="�q��">
          <xsl:with-param name="�q��" select="."/>
          <xsl:with-param name="pos0" select="$pos0"/>
          <xsl:with-param name="pos1" select="$pos1"/>
          <xsl:with-param name="cnt0" select="$cnt0"/>
          <xsl:with-param name="cnt1" select="$cnt1+2"/>
        </xsl:call-template>
      </xsl:for-each>
      <tr>
        <td>���v</td>
        <td class="value">
          <!--<xsl:value-of select="sum(uName/*/data/��)"/>-->
          <xsl:value-of select="format-number( sum(uName/*/data/��) ,$form)"/>
        </td>
        <xsl:call-template name="���v">
          <xsl:with-param name="data" select="uName/*/data/��"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
      </tr>
      <tr>
        <td>�݌v</td>
        <td></td>
        <xsl:call-template name="�݌v">
          <xsl:with-param name="data" select="uName/*/data/��"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
      </tr>

    </xsl:for-each>
  </xsl:template>


	<xsl:template name="���v">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
        <xsl:param name="form" select="'#,###'" />
		<xsl:if test="$cnt &lt; $max">
			<td class="value">

				<!--<xsl:value-of select="sum($data[@m=$cnt])"/>-->
                <xsl:value-of select="format-number( sum($data[@m=$cnt]) ,$form)"/>
			</td>
			<xsl:call-template name="���v">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  	<xsl:template name="�݌v">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
        <xsl:param name="work" select="sum($data[@m=$cnt])"/>
        <xsl:param name="form" select="'#,###'" />
		<xsl:if test="$cnt &lt; $max">
			<td class="value">
				<!--<xsl:value-of select="$work"/>-->
                <xsl:value-of select="format-number( $work ,$form)"/>
			</td>
			<xsl:call-template name="�݌v">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work" select="$work + sum($data[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  
  <xsl:template name="�q��">
    <xsl:param name="�q��"/>
    <xsl:param name="pos0"/>
    <xsl:param name="pos1"/>
    <xsl:param name="cnt0"/>
    <xsl:param name="cnt1"/>
    <xsl:param name="form" select="'#,###'" />

    <tr>
      <xsl:if test="$pos1 = 1">
        <td>
          <xsl:attribute name="rowspan" >
            <xsl:value-of select="$cnt1"/>
          </xsl:attribute>
          <xsl:value-of select="$�q��/../../@_name_"/>
        </td>
      </xsl:if>
      <td>
        <xsl:value-of select="@_name_"/>
      </td>

      <td class="value">
        <!--<xsl:value-of select="sum($�q��/data/��)"/>-->
        <xsl:value-of select="format-number( sum($�q��/data/��) ,$form)"/>
      </td>
      <xsl:for-each select="$�q��/data/��">
        <td class="value">
			<xsl:if test=". != 0">
              <xsl:value-of select="format-number( . ,$form)"/>
			</xsl:if>

      </td>
      </xsl:for-each>
            <td>
        <xsl:value-of select="EMG"/>
      </td>
        <td>
          <xsl:value-of select="@_name_"/>
        </td>
      <!--<td>
          <xsl:value-of select="$pos0"/>-
          <xsl:value-of select="$pos1"/>|
          <xsl:value-of select="$cnt0"/>-
          <xsl:value-of select="$cnt1"/>
        </td>-->
      </tr>
  </xsl:template>

  <!-- ########################################################### -->

  <!--		-->
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
      <xsl:value-of select="$year"/>
      <xsl:value-of select="'�N'"/>
    </th>
    <xsl:call-template name="year_Loop">
      <xsl:with-param name="year" select="$year+1" />
      <xsl:with-param name="mCnt" select="$mCnt - $cnt" />
      <xsl:with-param name="cnt" select="12" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>


<!--	���̕\��	-->
<!--	begin : �J�n��	-->
<!--	mCnt  : �\������	-->
<!--
====�g�p��=============
<tr>
	<xsl:call-template name="month_Loop">
		<xsl:with-param name="begin" select="$mm" />
		<xsl:with-param name="mCnt" select="$mCnt" />
	</xsl:call-template>
</tr>
=======================
-->
<xsl:template name="month_Loop">
  <xsl:param name="begin" />
  <xsl:param name="mCnt" />
  <xsl:param name="max" select="$begin+$mCnt"/>
  <xsl:param name="cnt" select="$begin"/>
  <xsl:if test="$cnt &lt; $max">
    <th width="60">
      <xsl:attribute name="nowrap" />
      <xsl:if test="($cnt mod 12)>0">
        <xsl:value-of select="$cnt mod 12"/>
      </xsl:if>
      <xsl:if test="($cnt mod 12)=0">
        <xsl:value-of select="12"/>
      </xsl:if>
      <xsl:value-of select="'��'"/>
    </th>
    <xsl:call-template name="month_Loop">
      <xsl:with-param name="max" select="$max" />
      <xsl:with-param name="cnt" select="$cnt + 1" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
