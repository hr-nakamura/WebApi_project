<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">	


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
          <xsl:for-each select="$����">
    <xsl:variable name="pos0" select="position()"/>
    <xsl:variable name="cnt1" select="count(uName/*)"/>
  <xsl:for-each select="uName/*">
    <xsl:variable name="pos1" select="position()"/>
            <xsl:call-template name="�q��">
              <xsl:with-param name="�q��" select="."/>
              <xsl:with-param name="pos0" select="$pos0"/>
              <xsl:with-param name="pos1" select="$pos1"/>
              <xsl:with-param name="cnt0" select="$cnt0"/>
              <xsl:with-param name="cnt1" select="$cnt1"/>
            </xsl:call-template>
          </xsl:for-each>
          </xsl:for-each>
  </xsl:template>


	<xsl:template name="�q��">
    <xsl:param name="�q��"/>
    <xsl:param name="pos0"/>
    <xsl:param name="pos1"/>
    <xsl:param name="cnt0"/>
    <xsl:param name="cnt1"/>

          <tr>
          <xsl:for-each select="$�q��">
          <td>
            <xsl:value-of select="$pos0"/>-
            <xsl:value-of select="$pos1"/>|
            <xsl:value-of select="$cnt0"/>-
            <xsl:value-of select="$cnt1"/>
            <xsl:value-of select="../../@_name_"/>
            <xsl:value-of select="@_name_"/>
            <xsl:value-of select="EMG"/>
            <xsl:value-of select="count(data/��)"/>
        </td>
          </xsl:for-each>
        </tr>

	</xsl:template>

  <!-- ########################################################### -->




</xsl:stylesheet>
