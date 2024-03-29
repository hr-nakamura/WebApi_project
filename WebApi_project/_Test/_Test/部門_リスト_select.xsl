<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="Shift_JIS" indent="yes"/>

  <xsl:template match="/">
    <xsl:apply-templates select="root" />
  </xsl:template>

  <xsl:template match="root">
    <xsl:element name="select">
      <xsl:attribute name="ID">
        <xsl:value-of select="'H_name'"/>
      </xsl:attribute>
      <xsl:for-each select="全体/部署">
        <!--<xsl:sort select="gName" order="ascending"/>-->
          <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="全体/部署">
    <xsl:call-template name="選択">
      <xsl:with-param name="Item" select="@名前[not(. = preceding::名前)]"/>
      <xsl:with-param name="memberCnt" select="'count(グループ/メンバー)'"/>
      <xsl:with-param name="Name" select="concat(@統括,@部,@課)"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="選択">
    <xsl:param name="Name"/>
    <xsl:param name="Item"/>
    <xsl:param name="memberCnt"/>
    <xsl:param name="mode" select="@直間"/>
    <!--<xsl:if test="$Item!='間接'">-->
      <xsl:if test="$mode=0 or $mode=1 or $mode=2">
        <option>
        <xsl:attribute name="value">
          <xsl:value-of select="$Name"/>
        </xsl:attribute>
          <xsl:value-of select="$Name"/>
        </option>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
