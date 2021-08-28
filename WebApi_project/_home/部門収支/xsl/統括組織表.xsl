<?xml version="1.0" encoding="Shift_JIS"?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:user="mynamespace">
  <!--	xmlns:msxsl="urn:schemas-microsoft-com:xslt"	-->
  <!--      xmlns:user="http://mycompany.com/mynamespace">	-->
  <xsl:template match="/">
    <xsl:apply-templates select="root" />
  </xsl:template>
  <xsl:template match="root">
    <table>
      <tr>
        <td>
          <table class="table" border="1" width="100%">
            <CAPTION>集計 単位</CAPTION>
            <thead>
              <tr style="background-color:aliceblue">
                <th style="display:block">統括</th>
                <th>部門</th>
                <th>部署名</th>
                <!--<th>位置</th>-->
              </tr>
            </thead>
            <xsl:apply-templates select="EMG[@name='EMG']/統括" />
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>
  <xsl:template match="統括">
    <xsl:for-each select=".">
      <tbody>
        <xsl:variable name="name_統括" select="@name" />
        <xsl:variable name="rowLoop_統括" select="position()" />
        <xsl:variable name="rowSpan_統括" select="count(本部/グループ)" />
        <xsl:for-each select="本部">
          <xsl:variable name="name_本部" select="@name" />
          <xsl:variable name="rowLoop_本部" select="position()" />
          <xsl:variable name="rowSpan_本部" select="count(グループ)" />
          <xsl:for-each select="グループ">
            <xsl:variable name="rowLoop_グループ" select="position()" />
            <tr>
              <xsl:if test="$rowLoop_本部=1 and $rowLoop_グループ=1">
                <td style="display:block">
                  <xsl:attribute name="rowspan">
                    <xsl:value-of select="$rowSpan_統括" />
                  </xsl:attribute>
                  <!--<xsl:value-of select="$rowSpan_統括"/>-->
                  <xsl:call-template name="名前">
                    <xsl:with-param name="name" select="$name_統括"/>
                  </xsl:call-template>
                  <!--<xsl:value-of select="$name_統括" />-->
                </td>
              </xsl:if>
              <xsl:if test="$rowLoop_グループ=1">
                <td>
                  <xsl:attribute name="rowspan">
                    <xsl:value-of select="$rowSpan_本部" />
                  </xsl:attribute>
                  <!--<xsl:value-of select="$rowSpan_本部"/>-->
                  <xsl:call-template name="名前">
                    <xsl:with-param name="name" select="$name_本部"/>
                  </xsl:call-template>
                  <!--<xsl:value-of select="$name_本部" />-->
                </td>
              </xsl:if>
              <td>
                <xsl:value-of select="@name" />
              </td>
              <!--<td>
                <xsl:value-of select="$rowLoop_統括"/>-
                <xsl:value-of select="$rowLoop_本部"/>-
                <xsl:value-of select="$rowLoop_グループ"/>
              </td>-->
            </tr>
          </xsl:for-each>
        </xsl:for-each>
      </tbody>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="名前">
    <xsl:param name="name"/>
    <xsl:choose>
      <xsl:when test="$name = ''">
        <xsl:value-of select="'　'"/>        
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--		-->
</xsl:stylesheet>