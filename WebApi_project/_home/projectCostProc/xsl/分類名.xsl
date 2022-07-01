<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="Shift_JIS" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="root" />
  </xsl:template>

  <xsl:template match="root">
    <xsl:element name="root">
      <xsl:for-each select="全体/プロジェクト">
        <xsl:sort select="分類名" order="ascending"/>
          <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="プロジェクト">
    <xsl:call-template name="選択">
      <xsl:with-param name="Item" select="分類名[not(. = preceding::分類名)]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="選択">
    <xsl:param name="Item"/>
    <xsl:if test="$Item!=''">
      <xsl:element name="項目">
        <xsl:value-of select="$Item"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
