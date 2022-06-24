<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:user="mynamespace">

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
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="'データはありません'"/>
            </td>
          </tr>
        </tbody>
      </table>
  </xsl:template>
</xsl:stylesheet>
