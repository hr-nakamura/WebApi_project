<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="Shift_JIS" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="root" />
  </xsl:template>

  <xsl:template match="root">
    <xsl:element name="root">
      <xsl:for-each select="SÌ/vWFNg">
        <xsl:sort select="cÆS" order="ascending"/>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="vWFNg">
    <xsl:call-template name="Ið">
      <!--<xsl:with-param name="Item" select="cÆS[not(. = preceding::cÆS)]"/>-->
      <xsl:with-param name="Item" select="cÆS[not(. = preceding::cÆS)]"/>
      <xsl:with-param name="cÆS" select="cÆS"/>
      <xsl:with-param name="gCode" select="gCode"/>
      <xsl:with-param name="gName" select="gName"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="Ið">
    <xsl:param name="Item"/>
    <xsl:param name="cÆS"/>
    <xsl:param name="gCode"/>
    <xsl:param name="gName"/>
    <xsl:if test="$Item!=''">
      <xsl:element name="vWFNg">
        <xsl:attribute name="gCode">
          <xsl:value-of select="$gCode"/>
        </xsl:attribute>
        <xsl:attribute name="gName">
          <xsl:value-of select="$gName"/>
        </xsl:attribute>
        <xsl:element name="Ú">
        <xsl:element name="¼O">
          <xsl:value-of select="$cÆS"/>
        </xsl:element>
        <xsl:element name="R[h">
          <xsl:value-of select="cÆSId"/>
        </xsl:element>
      </xsl:element>
      </xsl:element>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
