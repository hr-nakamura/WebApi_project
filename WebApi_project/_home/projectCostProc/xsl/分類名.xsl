<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="Shift_JIS" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="root" />
  </xsl:template>

  <xsl:template match="root">
    <xsl:element name="root">
      <xsl:for-each select="�S��/�v���W�F�N�g">
        <xsl:sort select="���ޖ�" order="ascending"/>
          <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="�v���W�F�N�g">
    <xsl:call-template name="�I��">
      <xsl:with-param name="Item" select="���ޖ�[not(. = preceding::���ޖ�)]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="�I��">
    <xsl:param name="Item"/>
    <xsl:if test="$Item!=''">
      <xsl:element name="����">
        <xsl:value-of select="$Item"/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
