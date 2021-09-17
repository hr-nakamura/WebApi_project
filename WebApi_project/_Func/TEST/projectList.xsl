<?xml version="1.0" encoding="Shift_JIS"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
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
        <style type="text/css">
          .table {
          border-collapse:collapse;
          border: 0px solid gray;
          padding: 0px;
          margin: 0px;
          font-size: smaller;
          width: 100%;
          }

          .table thead {
          display: block;
          background-color: powderblue;
          }

          .table tbody {
          display: block;
          overflow: hidden;
          overflow-y: scroll;
          background-color: mintcream;
          }

          .table th {
          border-top: none;
          border-right: 1px solid gray;
          border-bottom: none;
          border-left: 1px solid gray;
          text-align: center;
          }

          .table td {
          border: 1px solid gray;
          }
          <!--   ******************* -->
          .pStat {
          min-width: 30px;
          text-align: center;
          }

          .pCode {
          min-width: 60px;
          text-align: center;
          }

          .pName {
          min-width: 400px;
          text-align: left;
          }

          .pUser {
          min-width: 400px;
          text-align: left;
          }

          .pSales {
          min-width: 80px;
          text-align: left;
          }

          .pUpdate {
          min-width: 50px;
          text-align: center;
          }

          .pRegist {
          min-width: 80px;
          text-align: left;
          }

          .pGroup {
          width: 100%;
          min-width: 200px;
          text-align: left;
          }
        </style>
      </head>
      <body>
        <xsl:apply-templates select="root" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="root">
    <xsl:apply-templates select="projectList" />
  </xsl:template>

  <xsl:template match="projectList">
    <table class='table'>
      <thead>
        <tr>
          <th class="pStat">
            <xsl:value-of select="'状態'"/>
          </th>
          <th class="pCode">
            <xsl:value-of select="'ﾌﾟﾛｼﾞｪｸﾄ'"/>
            <br/>
            <xsl:value-of select="'ｺｰﾄﾞ'"/>
          </th>
          <th class="pName">
            <xsl:value-of select="'ﾌﾟﾛｼﾞｪｸﾄ名'"/>
          </th>
          <th class="pUser">
            <xsl:value-of select="'会社名'"/>
          </th>
          <th class="pSales">
            <xsl:value-of select="'営業担当'"/>
          </th>
          <th class="pUpdate">
            <xsl:value-of select="'修正日'"/>
          </th>
          <th class="pRegist">
            <xsl:value-of select="'登録者'"/>
          </th>
          <th class="pGroup">
            <xsl:value-of select="'グループ名'"/>
          </th>
          <!--<th class="dummy">
				<xsl:value-of select="''"/>
			</th>-->
        </tr>
      </thead>
      <tbody>
        <xsl:if test="count(pNum) = 0">
          <tr class="pNumLine">
            <td class="pStat"></td>
            <td class="pCode">
            </td>
            <td class="pName">
              <xsl:value-of select="'読込中です'"/>
            </td>
            <td class="pUser">
            </td>
            <td class="pSales">
            </td>
            <td class="pUpdate">
            </td>
            <td class="pRegist">
            </td>
            <td class="pGroup">
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="count(pNum) > 0">
          <xsl:apply-templates select="pNum"/>
        </xsl:if>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="pNum">
    <xsl:for-each select=".">
      <tr class="pNumLine">
        <xsl:attribute name="pNum">
          <xsl:value-of select="@pNum"/>
        </xsl:attribute>
        <xsl:attribute name="Stat">
          <xsl:value-of select="@Stat"/>
        </xsl:attribute>
        <xsl:attribute name="newFlag">
          <xsl:value-of select="@newFlag"/>
        </xsl:attribute>
        <xsl:attribute name="Group">
          <xsl:value-of select="@グループ名"/>
        </xsl:attribute>
        <xsl:attribute name="User">
          <xsl:value-of select="@客先会社"/>
        </xsl:attribute>
        <xsl:attribute name="Regist">
          <xsl:value-of select="@登録者"/>
        </xsl:attribute>
        <td class="pStat">
          <xsl:call-template name="mark"></xsl:call-template>
        </td>
        <td class="pCode">
          <xsl:value-of select="@pCode"/>
        </td>
        <td class="pName">
          <xsl:value-of select="@pName"/>
          <xsl:choose>
            <xsl:when test="@newFlag='1'">
              <img src="new.gif"></img>
            </xsl:when>
            <xsl:when test="@newFlag='2'">
              <img src="new7.gif"></img>
            </xsl:when>
          </xsl:choose>

        </td>
        <td class="pUser">
          <xsl:value-of select="@客先会社"/>
        </td>
        <td class="pSales">
          <xsl:value-of select="@営業"/>
        </td>
        <td class="pUpdate">
          <xsl:value-of select="@更新日"/>
        </td>
        <td class="pRegist">
          <xsl:value-of select="@登録者"/>
        </td>
        <td class="pGroup">
          <xsl:value-of select="@グループ名"/>
        </td>
        <!--<td class="dummy">
					  <xsl:value-of select="''"/>
				  </td>-->
      </tr>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="mark">
    <xsl:choose>
      <xsl:when test="@Stat='0'">
        <FONT COLOR="green">▲</FONT>
      </xsl:when>
      <xsl:when test="@Stat='1'">
        <FONT COLOR="blue">●</FONT>
      </xsl:when>
      <xsl:when test="@Stat='4'">
        <FONT COLOR="gray">●</FONT>
      </xsl:when>
      <xsl:when test="@Stat='5'">
        <FONT COLOR="gray">★</FONT>
      </xsl:when>
      <xsl:when test="@Stat='-1'">
        <FONT COLOR="gray">×</FONT>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
