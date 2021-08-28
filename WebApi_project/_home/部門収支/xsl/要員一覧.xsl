<?xml version="1.0" encoding="Shift_JIS"?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:user="mynamespace">
  <!--	xmlns:msxsl="urn:schemas-microsoft-com:xslt"	-->
  <!--      xmlns:user="http://mycompany.com/mynamespace">	-->

  <xsl:variable name="�J�n�N">
    <xsl:value-of select="//�J�n�N"/>
  </xsl:variable>
  <xsl:variable name="�J�n��">
    <xsl:value-of select="//�J�n��"/>
  </xsl:variable>
  <xsl:variable name="����">
    <xsl:value-of select="//����"/>
  </xsl:variable>

  <xsl:template match="/">
    <html>
      <head>
        <title>�v���W�F�N�g</title>
      </head>

      <body background="bg.gif">
        <xsl:apply-templates select="root" />
        <br/>
        <hr/>
        <br/>
      </body>
    </html>


  </xsl:template>
  <xsl:template match="root">
    <xsl:apply-templates select="�S��" />
  </xsl:template>

  <xsl:template match="�S��">
    <table BORDER="0" align='center' class='table' style='background-color:lightgrey;'>
      <thead class='mounth'>
        <tr>
          <th rowspan="2">
            <xsl:value-of select="'�{��'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'�O���[�v'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'���O'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$�J�n�N" />
            <xsl:with-param name="begin" select="$�J�n��" />
            <xsl:with-param name="mCnt" select="$����" />
          </xsl:call-template>
        </tr>
        <tr>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$�J�n��"/>
            <xsl:with-param name="mCnt" select="$����"/>
          </xsl:call-template>
        </tr>
      </thead>
      <tbody class='body'>
        <tr>
          <td class='userType' rowspan="7" align="center">
            <xsl:value-of select="'�S��'"/>
          </td>
          <td class='userType' rowspan="7" align="center">
            <xsl:value-of select="'�v����'"/>
          </td>
          <td class='groupType'>
            <xsl:call-template name="���i">
              <xsl:with-param name="�敪" select="0"/>
              <xsl:with-param name="�x�E" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'�Ј�'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="�敪" select="0"/>
            <xsl:with-param name="�x�E" select="0"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="���i">
              <xsl:with-param name="�敪" select="0"/>
              <xsl:with-param name="�x�E" select="1"/>
            </xsl:call-template>
            <xsl:value-of select="'�Ј��E�x�E'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="�敪" select="0"/>
            <xsl:with-param name="�x�E" select="1"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="���i">
              <xsl:with-param name="�敪" select="1"/>
              <xsl:with-param name="�x�E" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'�p�[�g'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="�敪" select="1"/>
            <xsl:with-param name="�x�E" select="0"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="���i">
              <xsl:with-param name="�敪" select="1"/>
              <xsl:with-param name="�x�E" select="1"/>
            </xsl:call-template>
            <xsl:value-of select="'�p�[�g�E�x�E'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="�敪" select="1"/>
            <xsl:with-param name="�x�E" select="1"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="���i">
              <xsl:with-param name="�敪" select="2"/>
              <xsl:with-param name="�x�E" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'�_��'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="�敪" select="2"/>
            <xsl:with-param name="�x�E" select="0"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="���i">
              <xsl:with-param name="�敪" select="2"/>
              <xsl:with-param name="�x�E" select="1"/>
            </xsl:call-template>
            <xsl:value-of select="'�_��E�x�E'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="�敪" select="2"/>
            <xsl:with-param name="�x�E" select="1"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="���i">
              <xsl:with-param name="�敪" select="10"/>
              <xsl:with-param name="�x�E" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'�h��'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="�敪" select="10"/>
            <xsl:with-param name="�x�E" select="0"/>
          </xsl:call-template>
        </tr>
      </tbody>

      <xsl:apply-templates select="�{��[@���O='������']" />
      <xsl:apply-templates select="�{��[@���O!='������']" />
    </table>
  </xsl:template>

  <xsl:template match="�{��">
    <tbody class='body'>
        <xsl:variable name="H_name" select="@���O"/>
        <xsl:variable name="menCountH" select="count(�O���[�v/�����o�[)"/>
        <xsl:for-each select="�O���[�v">
          <xsl:variable name="menCount" select="count(�����o�[)"/>
          <xsl:variable name="G_name" select="@���O"/>
          <xsl:variable name="G_pos" select="position()"/>
          <xsl:for-each select="�����o�[">
            <xsl:variable name="M_pos" select="position()"/>
            <tr>
              <xsl:if test="$G_pos=1 and $M_pos=1">
                  <td class='userType' rowspan="{$menCountH}">
                  <xsl:call-template name="���喼">
                    <xsl:with-param name="name" select="$H_name"/>
                  </xsl:call-template>
                </td>
              </xsl:if>
              <xsl:if test="$M_pos=1">
                <td class='userType' rowspan="{$menCount}">
                  <!--<xsl:value-of select="$G_pos"/>-
                  <xsl:value-of select="$M_pos"/>:-->
                  <xsl:value-of select="$G_name"/>
                </td>
              </xsl:if>
              <td class='groupType'>
                <xsl:value-of select="@���O"/>
              </td>
            <xsl:call-template name="valueOut_Loop">
              <xsl:with-param name="begin" select="0"/>
              <xsl:with-param name="mCnt" select="12"/>
            </xsl:call-template>
            </tr>
          </xsl:for-each>
        </xsl:for-each>
  </tbody>
  </xsl:template>

  <!--�@�v�����s�̕\���@-->
  <xsl:template name="sumOut_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="�敪" />
    <xsl:param name="�x�E" />
    <xsl:if test="$cnt &lt; $max">
      <td class='memberCount'>
        <xsl:attribute name="nowrap" />
        <xsl:attribute name="value">
          <xsl:value-of select="��[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:variable name="xCount" select="count(�{��/�O���[�v/�����o�[/��[@m=$cnt and �敪=$�敪 and �x�E=$�x�E])"/>
        <xsl:if test="$xCount > 0">
          <xsl:value-of select="$xCount"/>
        </xsl:if>
      </td>
      <xsl:call-template name="sumOut_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
        <xsl:with-param name="�敪" select="$�敪" />
        <xsl:with-param name="�x�E" select="$�x�E" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--�@�f�[�^�s�̕\���@-->
  <xsl:template name="valueOut_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:if test="$cnt &lt; $max">
      <td nowrap="" class='memberMark'>
        <xsl:attribute name="nowrap" />
        <xsl:attribute name="value">
          <xsl:value-of select="��[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:apply-templates select="��[@m=$cnt]/�敪" />
      </td>
      <xsl:call-template name="valueOut_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="���i">
    <xsl:param name="�敪" />
    <xsl:param name="�x�E" />
    <span>
      <xsl:choose>
        <xsl:when test="$�敪=0 and $�x�E=0">
          <!--�Ј�-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test="$�敪=1 and $�x�E=0">
          <!--�p�[�g�E�A���o�C�g-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test="$�敪=2 and $�x�E=0">
          <!--�_��Ј�-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test="$�敪=10 and $�x�E=0">
          <!--�h���Ј�-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test="$�敪=0 and $�x�E=1">
          <!--�Ј�-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test="$�敪=1 and $�x�E=1">
          <!--�p�[�g�E�A���o�C�g-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test="$�敪=2 and $�x�E=1">
          <!--�_��Ј�-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test="$�敪=10 and $�x�E=1">
          <!--�h���Ј�-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'-'"/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="�敪">
    <xsl:variable name="�x�E" select="../�x�E"/>
    <span>
      <xsl:choose>
        <xsl:when test=".=0 and $�x�E=0">
          <!--�Ј�-->
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test=".=0 and $�x�E=1">
          <!--�Ј��ŋx�E-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test=".=1 and $�x�E=0">
          <!--�p�[�g�E�A���o�C�g-->
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test=".=1 and $�x�E=1">
          <!--�p�[�g�E�A���o�C�g�ŋx�E-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test=".=2 and $�x�E=0">
          <!--�_��Ј�-->
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test=".=2 and $�x�E=1">
          <!--�_��Ј��ŋx�E-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test=".=10 and $�x�E=0">
          <!--�h���Ј�-->
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:when test=".=10 and $�x�E=1">
          <!--�h���Ј��ŋx�E-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
          <xsl:value-of select="'-'"/>
          <xsl:value-of select="$�x�E"/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template name="���喼">
    <xsl:param name="name"/>
      <xsl:choose>
        <xsl:when test="$name='�Ԑ�'">
          <xsl:value-of select="'�{�Е���i���j'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$name"/>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <!--		-->
  <xsl:include href="sub_cmn.xsl"/>
  <xsl:include href="sub_JScript.xsl"/>

</xsl:stylesheet>