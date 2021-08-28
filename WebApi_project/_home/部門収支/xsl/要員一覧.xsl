<?xml version="1.0" encoding="Shift_JIS"?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:user="mynamespace">
  <!--	xmlns:msxsl="urn:schemas-microsoft-com:xslt"	-->
  <!--      xmlns:user="http://mycompany.com/mynamespace">	-->

  <xsl:variable name="開始年">
    <xsl:value-of select="//開始年"/>
  </xsl:variable>
  <xsl:variable name="開始月">
    <xsl:value-of select="//開始月"/>
  </xsl:variable>
  <xsl:variable name="月数">
    <xsl:value-of select="//月数"/>
  </xsl:variable>

  <xsl:template match="/">
    <html>
      <head>
        <title>プロジェクト</title>
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
    <xsl:apply-templates select="全体" />
  </xsl:template>

  <xsl:template match="全体">
    <table BORDER="0" align='center' class='table' style='background-color:lightgrey;'>
      <thead class='mounth'>
        <tr>
          <th rowspan="2">
            <xsl:value-of select="'本部'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'グループ'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'名前'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
        <tr>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月"/>
            <xsl:with-param name="mCnt" select="$月数"/>
          </xsl:call-template>
        </tr>
      </thead>
      <tbody class='body'>
        <tr>
          <td class='userType' rowspan="7" align="center">
            <xsl:value-of select="'全体'"/>
          </td>
          <td class='userType' rowspan="7" align="center">
            <xsl:value-of select="'要員数'"/>
          </td>
          <td class='groupType'>
            <xsl:call-template name="資格">
              <xsl:with-param name="区分" select="0"/>
              <xsl:with-param name="休職" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'社員'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="区分" select="0"/>
            <xsl:with-param name="休職" select="0"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="資格">
              <xsl:with-param name="区分" select="0"/>
              <xsl:with-param name="休職" select="1"/>
            </xsl:call-template>
            <xsl:value-of select="'社員・休職'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="区分" select="0"/>
            <xsl:with-param name="休職" select="1"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="資格">
              <xsl:with-param name="区分" select="1"/>
              <xsl:with-param name="休職" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'パート'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="区分" select="1"/>
            <xsl:with-param name="休職" select="0"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="資格">
              <xsl:with-param name="区分" select="1"/>
              <xsl:with-param name="休職" select="1"/>
            </xsl:call-template>
            <xsl:value-of select="'パート・休職'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="区分" select="1"/>
            <xsl:with-param name="休職" select="1"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="資格">
              <xsl:with-param name="区分" select="2"/>
              <xsl:with-param name="休職" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'契約'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="区分" select="2"/>
            <xsl:with-param name="休職" select="0"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="資格">
              <xsl:with-param name="区分" select="2"/>
              <xsl:with-param name="休職" select="1"/>
            </xsl:call-template>
            <xsl:value-of select="'契約・休職'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="区分" select="2"/>
            <xsl:with-param name="休職" select="1"/>
          </xsl:call-template>
        </tr>
        <tr>
          <td class='groupType'>
            <xsl:call-template name="資格">
              <xsl:with-param name="区分" select="10"/>
              <xsl:with-param name="休職" select="0"/>
            </xsl:call-template>
            <xsl:value-of select="'派遣'"/>
          </td>
          <xsl:call-template name="sumOut_Loop">
            <xsl:with-param name="begin" select="0"/>
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="区分" select="10"/>
            <xsl:with-param name="休職" select="0"/>
          </xsl:call-template>
        </tr>
      </tbody>

      <xsl:apply-templates select="本部[@名前='所属無']" />
      <xsl:apply-templates select="本部[@名前!='所属無']" />
    </table>
  </xsl:template>

  <xsl:template match="本部">
    <tbody class='body'>
        <xsl:variable name="H_name" select="@名前"/>
        <xsl:variable name="menCountH" select="count(グループ/メンバー)"/>
        <xsl:for-each select="グループ">
          <xsl:variable name="menCount" select="count(メンバー)"/>
          <xsl:variable name="G_name" select="@名前"/>
          <xsl:variable name="G_pos" select="position()"/>
          <xsl:for-each select="メンバー">
            <xsl:variable name="M_pos" select="position()"/>
            <tr>
              <xsl:if test="$G_pos=1 and $M_pos=1">
                  <td class='userType' rowspan="{$menCountH}">
                  <xsl:call-template name="部門名">
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
                <xsl:value-of select="@名前"/>
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

  <!--　要員数行の表示　-->
  <xsl:template name="sumOut_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="区分" />
    <xsl:param name="休職" />
    <xsl:if test="$cnt &lt; $max">
      <td class='memberCount'>
        <xsl:attribute name="nowrap" />
        <xsl:attribute name="value">
          <xsl:value-of select="月[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:variable name="xCount" select="count(本部/グループ/メンバー/月[@m=$cnt and 区分=$区分 and 休職=$休職])"/>
        <xsl:if test="$xCount > 0">
          <xsl:value-of select="$xCount"/>
        </xsl:if>
      </td>
      <xsl:call-template name="sumOut_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
        <xsl:with-param name="区分" select="$区分" />
        <xsl:with-param name="休職" select="$休職" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--　データ行の表示　-->
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
          <xsl:value-of select="月[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:apply-templates select="月[@m=$cnt]/区分" />
      </td>
      <xsl:call-template name="valueOut_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="資格">
    <xsl:param name="区分" />
    <xsl:param name="休職" />
    <span>
      <xsl:choose>
        <xsl:when test="$区分=0 and $休職=0">
          <!--社員-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
        </xsl:when>
        <xsl:when test="$区分=1 and $休職=0">
          <!--パート・アルバイト-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'▲'"/>
        </xsl:when>
        <xsl:when test="$区分=2 and $休職=0">
          <!--契約社員-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'■'"/>
        </xsl:when>
        <xsl:when test="$区分=10 and $休職=0">
          <!--派遣社員-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
          </xsl:attribute>
          <xsl:value-of select="'★'"/>
        </xsl:when>
        <xsl:when test="$区分=0 and $休職=1">
          <!--社員-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'○'"/>
        </xsl:when>
        <xsl:when test="$区分=1 and $休職=1">
          <!--パート・アルバイト-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'△'"/>
        </xsl:when>
        <xsl:when test="$区分=2 and $休職=1">
          <!--契約社員-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'□'"/>
        </xsl:when>
        <xsl:when test="$区分=10 and $休職=1">
          <!--派遣社員-->
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:smaller;color:gray;'"/>
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'☆'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'-'"/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template match="区分">
    <xsl:variable name="休職" select="../休職"/>
    <span>
      <xsl:choose>
        <xsl:when test=".=0 and $休職=0">
          <!--社員-->
          <xsl:value-of select="'●'"/>
        </xsl:when>
        <xsl:when test=".=0 and $休職=1">
          <!--社員で休職-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'○'"/>
        </xsl:when>
        <xsl:when test=".=1 and $休職=0">
          <!--パート・アルバイト-->
          <xsl:value-of select="'▲'"/>
        </xsl:when>
        <xsl:when test=".=1 and $休職=1">
          <!--パート・アルバイトで休職-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'△'"/>
        </xsl:when>
        <xsl:when test=".=2 and $休職=0">
          <!--契約社員-->
          <xsl:value-of select="'■'"/>
        </xsl:when>
        <xsl:when test=".=2 and $休職=1">
          <!--契約社員で休職-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'□'"/>
        </xsl:when>
        <xsl:when test=".=10 and $休職=0">
          <!--派遣社員-->
          <xsl:value-of select="'★'"/>
        </xsl:when>
        <xsl:when test=".=10 and $休職=1">
          <!--派遣社員で休職-->
          <xsl:attribute name="style" >
            <xsl:value-of select="'color:red;'"/>
          </xsl:attribute>
          <xsl:value-of select="'☆'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
          <xsl:value-of select="'-'"/>
          <xsl:value-of select="$休職"/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template name="部門名">
    <xsl:param name="name"/>
      <xsl:choose>
        <xsl:when test="$name='間接'">
          <xsl:value-of select="'本社部門（他）'"/>
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