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
    <xsl:if test="count(全体) = 0">
      <table border="1" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="'データはありません'"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>

    <xsl:if test="count(全体) > 0">
      <table border="0" align="center">
        <tbody>
          <tr>
          <td>
              <xsl:apply-templates select="全体"/>
          </td>
          </tr>
        </tbody>
    </table>
    </xsl:if>

  </xsl:template>


	<xsl:template match="全体">
      <table border="1" align="center">
        <tbody>
          <xsl:for-each select="*">
            <tr>
          <td>
          <xsl:value-of select="@_name_"/>
          </td>
        </tr>
          </xsl:for-each>
        </tbody>
    </table>
	</xsl:template>

  <!-- ########################################################### -->




</xsl:stylesheet>
