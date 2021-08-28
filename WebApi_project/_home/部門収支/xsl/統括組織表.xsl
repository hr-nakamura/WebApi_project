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
            <CAPTION>�W�v �P��</CAPTION>
            <thead>
              <tr style="background-color:aliceblue">
                <th style="display:block">����</th>
                <th>����</th>
                <th>������</th>
                <!--<th>�ʒu</th>-->
              </tr>
            </thead>
            <xsl:apply-templates select="EMG[@name='EMG']/����" />
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>
  <xsl:template match="����">
    <xsl:for-each select=".">
      <tbody>
        <xsl:variable name="name_����" select="@name" />
        <xsl:variable name="rowLoop_����" select="position()" />
        <xsl:variable name="rowSpan_����" select="count(�{��/�O���[�v)" />
        <xsl:for-each select="�{��">
          <xsl:variable name="name_�{��" select="@name" />
          <xsl:variable name="rowLoop_�{��" select="position()" />
          <xsl:variable name="rowSpan_�{��" select="count(�O���[�v)" />
          <xsl:for-each select="�O���[�v">
            <xsl:variable name="rowLoop_�O���[�v" select="position()" />
            <tr>
              <xsl:if test="$rowLoop_�{��=1 and $rowLoop_�O���[�v=1">
                <td style="display:block">
                  <xsl:attribute name="rowspan">
                    <xsl:value-of select="$rowSpan_����" />
                  </xsl:attribute>
                  <!--<xsl:value-of select="$rowSpan_����"/>-->
                  <xsl:call-template name="���O">
                    <xsl:with-param name="name" select="$name_����"/>
                  </xsl:call-template>
                  <!--<xsl:value-of select="$name_����" />-->
                </td>
              </xsl:if>
              <xsl:if test="$rowLoop_�O���[�v=1">
                <td>
                  <xsl:attribute name="rowspan">
                    <xsl:value-of select="$rowSpan_�{��" />
                  </xsl:attribute>
                  <!--<xsl:value-of select="$rowSpan_�{��"/>-->
                  <xsl:call-template name="���O">
                    <xsl:with-param name="name" select="$name_�{��"/>
                  </xsl:call-template>
                  <!--<xsl:value-of select="$name_�{��" />-->
                </td>
              </xsl:if>
              <td>
                <xsl:value-of select="@name" />
              </td>
              <!--<td>
                <xsl:value-of select="$rowLoop_����"/>-
                <xsl:value-of select="$rowLoop_�{��"/>-
                <xsl:value-of select="$rowLoop_�O���[�v"/>
              </td>-->
            </tr>
          </xsl:for-each>
        </xsl:for-each>
      </tbody>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="���O">
    <xsl:param name="name"/>
    <xsl:choose>
      <xsl:when test="$name = ''">
        <xsl:value-of select="'�@'"/>        
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--		-->
</xsl:stylesheet>