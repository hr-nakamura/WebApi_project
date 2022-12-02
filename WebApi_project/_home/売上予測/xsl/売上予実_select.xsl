<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:template match="/">
				<xsl:apply-templates select="root" />
	</xsl:template>

  <xsl:template match="root">
    <xsl:element name="select">
      <xsl:attribute name="ID">
        <xsl:value-of select="'H_name'"/>
      </xsl:attribute>
      <xsl:for-each select="*">
        <option>
          <xsl:attribute name="value">
            <xsl:value-of select="gCode"/>
          </xsl:attribute>
          <xsl:value-of select="gName"/>
          <xsl:value-of select="gCode"/>
        </option>
      </xsl:for-each>

</xsl:element>
  </xsl:template>


</xsl:stylesheet>
