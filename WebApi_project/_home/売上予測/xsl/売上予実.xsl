<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">	


  <xsl:template match="/">
    <html>
			<head>
				<title>収支状況</title>
				<link rel="stylesheet" type="text/css" href="account.css"/>
			</head>

			<body background="bg.gif">
				<xsl:apply-templates select="root" />
      </body>
		</html>

	</xsl:template>

	<xsl:template match="root">
    <xsl:if test="count(*) = 0">
              <xsl:value-of select="'データはありません'"/>

    </xsl:if>

    <xsl:if test="count(*) > 0">
      <table border="1" align="left">
        <tbody>
            <xsl:call-template name="分類">
              <xsl:with-param name="分類" select="*"/>
            </xsl:call-template>
        </tbody>
    </table>
    </xsl:if>

  </xsl:template>


	<xsl:template name="分類">
    <xsl:param name="分類"/>
    <xsl:variable name="cnt0" select="count($分類)"/>
    <xsl:for-each select="$分類">
      <xsl:variable name="pos0" select="position()"/>
      <xsl:variable name="cnt1" select="count(uName/*)"/>
      <xsl:for-each select="uName/*">
        <xsl:variable name="pos1" select="position()"/>
        <xsl:call-template name="客先">
          <xsl:with-param name="客先" select="."/>
          <xsl:with-param name="pos0" select="$pos0"/>
          <xsl:with-param name="pos1" select="$pos1"/>
          <xsl:with-param name="cnt0" select="$cnt0"/>
          <xsl:with-param name="cnt1" select="$cnt1+2"/>
        </xsl:call-template>
      </xsl:for-each>
      <tr>
        <td>合計</td>
        <td>
          <xsl:value-of select="sum(uName/*/data/月)"/>
        </td>
        <xsl:call-template name="合計">
          <xsl:with-param name="data" select="uName/*/data/月"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
      </tr>
      <tr>
        <td>累計</td>
        <td></td>
        <xsl:call-template name="累計">
          <xsl:with-param name="data" select="uName/*/data/月"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
      </tr>

    </xsl:for-each>
  </xsl:template>


	<xsl:template name="合計">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:if test="$cnt &lt; $max">
			<td>

				<xsl:value-of select="sum($data[@m=$cnt])"/>
			</td>
			<xsl:call-template name="合計">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  	<xsl:template name="累計">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
    <xsl:param name="work" select="sum($data[@m=$cnt])"/>
		<xsl:if test="$cnt &lt; $max">
			<td>
				<xsl:value-of select="$work"/>
			</td>
			<xsl:call-template name="累計">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work" select="$work + sum($data[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  
  <xsl:template name="客先">
    <xsl:param name="客先"/>
    <xsl:param name="pos0"/>
    <xsl:param name="pos1"/>
    <xsl:param name="cnt0"/>
    <xsl:param name="cnt1"/>
    <tr>
      <xsl:if test="$pos1 = 1">
        <td>
          <xsl:attribute name="rowspan" >
            <xsl:value-of select="$cnt1"/>
          </xsl:attribute>
          <xsl:value-of select="$客先/../../@_name_"/>
        </td>
      </xsl:if>
      <td>
        <xsl:value-of select="@_name_"/>
      </td>

      <td>
        <xsl:value-of select="sum($客先/data/月)"/>
      </td>
      <xsl:for-each select="$客先/data/月">
        <td>
          <xsl:value-of select="."/>
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




</xsl:stylesheet>
