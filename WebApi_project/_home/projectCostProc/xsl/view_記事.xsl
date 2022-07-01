<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:user="mynamespace">

	<!--	xmlns:msxsl="urn:schemas-microsoft-com:xslt"	-->
	<!--      xmlns:user="http://mycompany.com/mynamespace">	-->

  <xsl:template match="記事/*">
    <table class="BBS" width="99%" style="border:none;border-collapse:collapse;">
      <tbody>
        <xsl:for-each select=".">
          <tr>
            <td class="mark">
              <xsl:attribute name="style">
                <xsl:choose>
                <xsl:when test="@mode=1">
                    <xsl:value-of select="'background-color:lemonchiffon;border:none;'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'background-color:gainsboro;border:none;'"/>
                </xsl:otherwise>
              </xsl:choose>
                <xsl:if test="@yymm=user:yymmNow()">
                  <!--<xsl:value-of select="'border-top:inset 1pt red dashed;'"/>-->
                  <xsl:value-of select="'border-left:inset 1pt red dashed;'"/>
                  <xsl:value-of select="'border-bottom:inset 1pt red dashed;'"/>
                </xsl:if>
              </xsl:attribute>
              <xsl:apply-templates select="mark"/>
            </td>
            <td class="contentHead">
              <xsl:attribute name="style">
                <xsl:choose>
                  <xsl:when test="@mode=1">
                    <xsl:value-of select="'background-color:lemonchiffon;border:none;'"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="'background-color:gainsboro;border:none;'"/>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="@yymm=user:yymmNow()">
                  <!--<xsl:value-of select="'border-top:inset 1pt red dashed;'"/>-->
                  <xsl:value-of select="'border-right:inset 1pt red dashed;'"/>
                  <xsl:value-of select="'border-bottom:inset 1pt red dashed;'"/>
                </xsl:if>
              </xsl:attribute>
              <xsl:attribute name="title">
                <xsl:value-of select="'('"/>
                <xsl:value-of select="作成日付"/>
                <xsl:value-of select="')'"/>
              </xsl:attribute>
              <xsl:value-of select="user:yymmAddStr(@yymm,0)"/>
              <xsl:value-of select="'　　'"/>
              <xsl:value-of select="作成者"/>
            </td>
          </tr>
          <tr>
            <td style="border:none;">
            </td>
            <td align="center" class="content" style="border:none;">
              <xsl:value-of select="内容" disable-output-escaping="yes"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template match="mark">
    <SPAN>
    <xsl:choose>
      <xsl:when test=". = 0">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:green;text-align:center;border:none;'"/>
        </xsl:attribute>
        <xsl:value-of select="'■'"/>
      </xsl:when>
      <xsl:when test=". = 1">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:red;text-align:center;border:none;'"/>
        </xsl:attribute>
        <xsl:value-of select="'●'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="style">
          <xsl:value-of select="'color:red;text-align:center;border:none;'"/>
        </xsl:attribute>
        <xsl:value-of select="'▲'"/>
      </xsl:otherwise>
    </xsl:choose>
    </SPAN>
  </xsl:template>


</xsl:stylesheet>
