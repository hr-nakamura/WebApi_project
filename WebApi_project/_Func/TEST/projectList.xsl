<?xml version="1.0" encoding="Shift_JIS"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
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
            <xsl:value-of select="'���'"/>
          </th>
          <th class="pCode">
            <xsl:value-of select="'��ۼު��'"/>
            <br/>
            <xsl:value-of select="'����'"/>
          </th>
          <th class="pName">
            <xsl:value-of select="'��ۼު�Ė�'"/>
          </th>
          <th class="pUser">
            <xsl:value-of select="'��Ж�'"/>
          </th>
          <th class="pSales">
            <xsl:value-of select="'�c�ƒS��'"/>
          </th>
          <th class="pUpdate">
            <xsl:value-of select="'�C����'"/>
          </th>
          <th class="pRegist">
            <xsl:value-of select="'�o�^��'"/>
          </th>
          <th class="pGroup">
            <xsl:value-of select="'�O���[�v��'"/>
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
              <xsl:value-of select="'�Ǎ����ł�'"/>
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
          <xsl:value-of select="@�O���[�v��"/>
        </xsl:attribute>
        <xsl:attribute name="User">
          <xsl:value-of select="@�q����"/>
        </xsl:attribute>
        <xsl:attribute name="Regist">
          <xsl:value-of select="@�o�^��"/>
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
          <xsl:value-of select="@�q����"/>
        </td>
        <td class="pSales">
          <xsl:value-of select="@�c��"/>
        </td>
        <td class="pUpdate">
          <xsl:value-of select="@�X�V��"/>
        </td>
        <td class="pRegist">
          <xsl:value-of select="@�o�^��"/>
        </td>
        <td class="pGroup">
          <xsl:value-of select="@�O���[�v��"/>
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
        <FONT COLOR="green">��</FONT>
      </xsl:when>
      <xsl:when test="@Stat='1'">
        <FONT COLOR="blue">��</FONT>
      </xsl:when>
      <xsl:when test="@Stat='4'">
        <FONT COLOR="gray">��</FONT>
      </xsl:when>
      <xsl:when test="@Stat='5'">
        <FONT COLOR="gray">��</FONT>
      </xsl:when>
      <xsl:when test="@Stat='-1'">
        <FONT COLOR="gray">�~</FONT>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
