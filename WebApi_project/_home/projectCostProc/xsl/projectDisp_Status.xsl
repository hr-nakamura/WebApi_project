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
<title>プロジェクト</title>
<link rel="stylesheet" type="text/css" href="cost.css"/>
</head>

<body background="bg.gif">
  <table>
    <tr>
      <td>
        <IMG ID="grphBox" src="grph/payCostGrph.gif">
          <xsl:attribute name="style">
            <xsl:choose>
              <xsl:when test="/root/全体/プロジェクト/月数!=''">
                <xsl:value-of select="'display:block;'"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="'display:none;'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </IMG>
      </td>
    </tr>
  </table>

  <xsl:if test="/root/全体/プロジェクト/月数!=''">
  <table>
    <tr>
      <td nowrap="">
        <SPAN ID="dispProjectList" style="cursor:hand;border-style:outset;background-color:lightgray;">クリックするとプロジェクトの状態表示</SPAN>
      </td>
    </tr>
    <tr>
      <td nowrap="">
        <SPAN ID="memberWorkList" style="cursor:hand;border-style:outset;;background-color:lightgray;">クリックすると作業要員の状態表示</SPAN>
      </td>
    </tr>
    <tr>
      <td nowrap="">
        <SPAN ID="projectBBS" style="cursor:hand;border-style:outset;;background-color:lightgray;">クリックするとプロジェクト掲示板の表示</SPAN>
      </td>
    </tr>
  </table>

  </xsl:if>
</body>
</html>

  </xsl:template>

</xsl:stylesheet>
