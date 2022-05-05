<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">	
    <xsl:variable name="form" select="'#,###'" />


  <xsl:template match="/">
    <html>
			<head>
				<title>収支状況</title>
				<link rel="stylesheet" type="text/css" href="account.css"/>
			</head>

			<body background="bg.gif">
				<xsl:apply-templates select="root" />
      </body>
		</html>

	</xsl:template>

	<xsl:template match="root">
    <xsl:if test="count(*) = 0">
              <xsl:value-of select="'データはありません'"/>

    </xsl:if>

    <xsl:if test="count(*) > 0">
      <table border="1" align="left">
        <tbody>
          <xsl:call-template name="分類">
              <xsl:with-param name="分類" select="*"/>
            </xsl:call-template>

        </tbody>
    </table>
    </xsl:if>

  </xsl:template>


	<xsl:template name="分類">
    <xsl:param name="分類"/>
    <xsl:variable name="cnt0" select="count($分類)"/>
    <tr>
      <th>
        <xsl:value-of select="'分類名'"/>
      </th>
      <th>
        <xsl:value-of select="'客先名'"/>
      </th>
      <th>
      </th>
      <xsl:call-template name="year_Loop">
        <xsl:with-param name="year" select="2021"/>
        <xsl:with-param name="begin" select="10"/>
        <xsl:with-param name="mCnt" select="12"/>
      </xsl:call-template>
    </tr>
    <xsl:for-each select="$分類">
      <tr>
        <th colspan="2">
        </th>
        <th>
          <xsl:value-of select="'合　計'"/>
        </th>
        <xsl:call-template name="month_Loop">
          <xsl:with-param name="begin" select="10"/>
          <xsl:with-param name="mCnt" select="12"/>
        </xsl:call-template>
        <th>
          <xsl:value-of select="'合　計'"/>
        </th>
        <th colspan="3">
        </th>
      </tr>
      <xsl:variable name="Cnt" select="count(uName/*)"/>
      <xsl:for-each select="uName/*">
        <xsl:variable name="Pos" select="position()"/>
        <xsl:call-template name="客先">
          <xsl:with-param name="客先" select="."/>
          <xsl:with-param name="Pos" select="$Pos"/>
          <xsl:with-param name="Cnt" select="$Cnt+2"/>
        </xsl:call-template>
      </xsl:for-each>
      <tr>
        <td>合計</td>
        <td class="value">
          <!--<xsl:value-of select="sum(uName/*/data/月)"/>-->
          <xsl:value-of select="format-number( sum(uName/*/data/月) ,$form)"/>
        </td>
        <xsl:call-template name="合計">
          <xsl:with-param name="data" select="uName/*/data/月"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
        <td class="value">
          <!--<xsl:value-of select="sum(uName/*/data/月)"/>-->
          <xsl:value-of select="format-number( sum(uName/*/data/月) ,$form)"/>
        </td>
        <th colspan="2">
          <xsl:value-of select="'合　計'"/>
        </th>
      </tr>
      <tr>
        <td>累計</td>
        <td></td>
        <xsl:call-template name="累計">
          <xsl:with-param name="data" select="uName/*/data/月"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
        <th></th>
        <th colspan="2">
          <xsl:value-of select="'累　計'"/>
        </th>
      </tr>

    </xsl:for-each>
    <tr>
      <th colspan="2">
      </th>
      <th>
        <xsl:value-of select="'合　計'"/>
      </th>
      <xsl:call-template name="month_Loop">
        <xsl:with-param name="begin" select="10"/>
        <xsl:with-param name="mCnt" select="12"/>
      </xsl:call-template>
    </tr>
    <tr>
      <td colspan="2">総　合 計</td>
      <td>
        <xsl:value-of select="format-number( sum($分類/uName/*/data/月) ,$form)"/>
      </td>
      <xsl:call-template name="合計">
        <xsl:with-param name="data" select="$分類/uName/*/data/月"/>
        <xsl:with-param name="begin" select="0"/>
        <xsl:with-param name="max" select="12"/>
      </xsl:call-template>
      <td>
        <xsl:value-of select="format-number( sum($分類/uName/*/data/月) ,$form)"/>
      </td>
      <th colspan="2">
        <xsl:value-of select="'総　合　計'"/>
      </th>
    </tr>
    <tr>
      <td colspan="2">総　累 計</td>
      <td></td>
      <xsl:call-template name="累計">
        <xsl:with-param name="data" select="$分類/uName/*/data/月"/>
        <xsl:with-param name="begin" select="0"/>
        <xsl:with-param name="max" select="12"/>
      </xsl:call-template>
      <th></th>
      <th colspan="2">
        <xsl:value-of select="'総　累　計'"/>
      </th>
    </tr>
  </xsl:template>


	<xsl:template name="合計">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
        <xsl:param name="form" select="'#,###'" />
		<xsl:if test="$cnt &lt; $max">
			<td class="value">

				<!--<xsl:value-of select="sum($data[@m=$cnt])"/>-->
                <xsl:value-of select="format-number( sum($data[@m=$cnt]) ,$form)"/>
			</td>
			<xsl:call-template name="合計">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  	<xsl:template name="累計">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
    <xsl:param name="work" select="0"/>
    <xsl:param name="form" select="'#,###'" />
		<xsl:if test="$cnt &lt; $max">
			<td class="value">
				<!--<xsl:value-of select="$work + sum($data[@m=$cnt])"/>-->
                <xsl:value-of select="format-number( $work + sum($data[@m=$cnt]) ,$form)"/>
			</td>
			<xsl:call-template name="累計">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work" select="$work + sum($data[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  
  <xsl:template name="客先">
    <xsl:param name="客先"/>
    <xsl:param name="Pos"/>
    <xsl:param name="Cnt"/>
    <xsl:param name="form" select="'#,###'" />

    <tr>
      <xsl:if test="$Pos = 1">
        <td>
          <xsl:attribute name="rowspan" >
            <xsl:value-of select="$Cnt"/>
          </xsl:attribute>
          <xsl:value-of select="$客先/../../@_name_"/>
        </td>
      </xsl:if>
      <td>
        <xsl:value-of select="@_name_"/>
      </td>

      <td class="value">
        <!--<xsl:value-of select="sum($客先/data/月)"/>-->
        <xsl:value-of select="format-number( sum($客先/data/月) ,$form)"/>
      </td>
      <xsl:for-each select="$客先/data/月">
        <td class="value">
			<xsl:if test=". != 0">
              <xsl:value-of select="format-number( . ,$form)"/>
			</xsl:if>

      </td>
      </xsl:for-each>
      <td class="value">
        <!--<xsl:value-of select="sum($客先/data/月)"/>-->
        <xsl:value-of select="format-number( sum($客先/data/月) ,$form)"/>
      </td>
      <td>
        <xsl:call-template name="EMG_mark">
          <xsl:with-param name="mark" select="EMG"/>
        </xsl:call-template>
      </td>
        <td>
          <xsl:value-of select="@_name_"/>
        </td>
      <xsl:if test="$Pos = 1">
        <td>
          <xsl:attribute name="rowspan" >
            <xsl:value-of select="$Cnt"/>
          </xsl:attribute>
          <xsl:value-of select="$客先/../../@_name_"/>
        </td>
      </xsl:if>
      </tr>
  </xsl:template>

  <!-- ########################################################### -->

  <!--		-->
  <xsl:template name="EMG_mark">
    <xsl:param name="mark" />
    <xsl:choose>
      <xsl:when test="$mark = 'EM'">
        <xsl:value-of select="'E'"/>
      </xsl:when>
      <xsl:when test="$mark = 'ACEL'">
        <xsl:value-of select="'A'"/>
      </xsl:when>
      <xsl:when test="$mark = 'PSL'">
        <xsl:value-of select="'P'"/>
      </xsl:when>
      <xsl:when test="'-'">
        <xsl:value-of select="'-'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'x'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="year_Loop">
  <xsl:param name="begin" />
  <xsl:param name="year" />
  <xsl:param name="mCnt" />
  <xsl:param name="cnt" select="12 - $begin + 1"/>
  <xsl:if test="$mCnt &gt; 0">
    <th>
      <xsl:attribute name="colspan">
        <xsl:if test="$cnt &gt;= $mCnt">
          <xsl:value-of select="$mCnt"/>
        </xsl:if>
        <xsl:if test="$cnt &lt; $mCnt">
          <xsl:value-of select="$cnt"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:value-of select="$year"/>
      <xsl:value-of select="'年'"/>
    </th>
    <xsl:call-template name="year_Loop">
      <xsl:with-param name="year" select="$year+1" />
      <xsl:with-param name="mCnt" select="$mCnt - $cnt" />
      <xsl:with-param name="cnt" select="12" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>


<!--	月の表示	-->
<!--	begin : 開始月	-->
<!--	mCnt  : 表示月数	-->
<!--
====使用例=============
<tr>
	<xsl:call-template name="month_Loop">
		<xsl:with-param name="begin" select="$mm" />
		<xsl:with-param name="mCnt" select="$mCnt" />
	</xsl:call-template>
</tr>
=======================
-->
<xsl:template name="month_Loop">
  <xsl:param name="begin" />
  <xsl:param name="mCnt" />
  <xsl:param name="max" select="$begin+$mCnt"/>
  <xsl:param name="cnt" select="$begin"/>
  <xsl:if test="$cnt &lt; $max">
    <th width="60">
      <xsl:attribute name="nowrap" />
      <xsl:if test="($cnt mod 12)>0">
        <xsl:value-of select="$cnt mod 12"/>
      </xsl:if>
      <xsl:if test="($cnt mod 12)=0">
        <xsl:value-of select="12"/>
      </xsl:if>
      <xsl:value-of select="'月'"/>
    </th>
    <xsl:call-template name="month_Loop">
      <xsl:with-param name="max" select="$max" />
      <xsl:with-param name="cnt" select="$cnt + 1" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
