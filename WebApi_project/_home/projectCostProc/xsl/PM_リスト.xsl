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
        <!--<xsl:sort select="gName" order="ascending"/>-->
        <xsl:sort select="PM名よみ" order="ascending" data-type="text"/>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="プロジェクト">
    <xsl:call-template name="選択">
      <xsl:with-param name="Item" select="PM名よみ[not(. = preceding::PM名よみ)]"/>
      <xsl:with-param name="gCode" select="gCode"/>
      <xsl:with-param name="gName" select="gName"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="選択">
    <xsl:param name="Item"/>
    <xsl:param name="gCode"/>
    <xsl:param name="gName"/>
    <xsl:if test="$Item!=''">
      <xsl:element name="プロジェクト">
        <xsl:attribute name="Yomi">
          <xsl:value-of select="substring($Item,1,1)"/>
        </xsl:attribute>
        <xsl:element name="項目">
        <xsl:element name="名前">
          <xsl:value-of select="PM名"/>
        </xsl:element>
        <xsl:element name="コード">
          <xsl:value-of select="PMId"/>
        </xsl:element>
      </xsl:element>
      </xsl:element>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
