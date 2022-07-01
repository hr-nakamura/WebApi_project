<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="Shift_JIS" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="root" />
  </xsl:template>

  <xsl:template match="root">
    <xsl:element name="root">
      <xsl:for-each select="グループ">
        <!--<xsl:sort select="gName" order="ascending"/>-->
          <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="グループ">
    <xsl:call-template name="選択">
      <xsl:with-param name="Item" select="$"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="選択">
    <xsl:param name="Item"/>
    <xsl:if test="$Item!=''">
      <xsl:element name="項目">
        <xsl:attribute name="mode">
          <xsl:value-of select="@mode"/>
        </xsl:attribute> 
        <xsl:element name="名前">
          <xsl:value-of select="$Item"/>
        </xsl:element>
        <xsl:element name="コード">
          <xsl:value-of select="gCode"/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
