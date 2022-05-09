<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


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
    <xsl:if test="count(全体/グループ) = 0">
      <table border="1" align="right">
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="'データはありません]'"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>

    <xsl:if test="count(全体/グループ) > 0">
      <table border="1" align="right">
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


  <!-- ########################################################### -->


</xsl:stylesheet>
