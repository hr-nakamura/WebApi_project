<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


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
      <table border="1" align="right">
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="'�f�[�^�͂���܂���]'"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>

    <xsl:if test="count(�S��/�O���[�v) > 0">
      <table border="1" align="right">
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


</xsl:stylesheet>
