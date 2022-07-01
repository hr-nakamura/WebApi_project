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
        <!--<xsl:sort select="gName" order="ascending"/>-->
        <xsl:sort select="PM�����" order="ascending" data-type="text"/>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="�v���W�F�N�g">
    <xsl:call-template name="�I��">
      <xsl:with-param name="Item" select="PM�����[not(. = preceding::PM�����)]"/>
      <xsl:with-param name="gCode" select="gCode"/>
      <xsl:with-param name="gName" select="gName"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="�I��">
    <xsl:param name="Item"/>
    <xsl:param name="gCode"/>
    <xsl:param name="gName"/>
    <xsl:if test="$Item!=''">
      <xsl:element name="�v���W�F�N�g">
        <xsl:attribute name="Yomi">
          <xsl:value-of select="substring($Item,1,1)"/>
        </xsl:attribute>
        <xsl:element name="����">
        <xsl:element name="���O">
          <xsl:value-of select="PM��"/>
        </xsl:element>
        <xsl:element name="�R�[�h">
          <xsl:value-of select="PMId"/>
        </xsl:element>
      </xsl:element>
      </xsl:element>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
