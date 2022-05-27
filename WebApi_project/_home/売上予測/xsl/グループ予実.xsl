<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:import href="xsl/sub_cmn.xsl"/>
  <xsl:template match="nbsp">
    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
  </xsl:template>
  <!--
  chrome [loadXMLDoc]からの場所  xsl/sub_cmn.xsl
  IE     [本体xsl]からの場所     sub_cmn.xsl
  -->

	<xsl:variable name="kind">
		<xsl:value-of select="/root/情報/@kind"/>
	</xsl:variable>
	<xsl:variable name="yymm">
		<xsl:value-of select="/root/情報/@yymm"/>
	</xsl:variable>
	<xsl:variable name="s_year">
		<xsl:value-of select="floor($yymm div 100)"/>
	</xsl:variable>
	<xsl:variable name="e_year">
		<xsl:value-of select="floor($yymm div 100) + 1"/>
	</xsl:variable>
	<xsl:variable name="actual">
    <xsl:value-of select="/root/情報/@actual"/>
  </xsl:variable>

  <xsl:template match="/">
    <html>
			<head>
				<title>収支状況</title>
			</head>

			<body background="bg.gif">
				<xsl:apply-templates select="root" />
      </body>
		</html>

	</xsl:template>

	<xsl:template match="root/データ">
    
    
    <xsl:if test="count(*) = 0">
              <xsl:value-of select="'データはありません'"/>

    </xsl:if>

    <xsl:if test="count(*) > 0">
      <table>
		  <caption style="text-align:left">
			  <xsl:value-of select="'【'" />
			  <xsl:value-of select="$kind"/>
			  <xsl:value-of select="'】の売上実績・予測'"/>
		  </caption>
		  <caption style="text-align:left">
			  <xsl:value-of select="'（'"/>
			  <xsl:value-of select="$s_year"/>
			  <xsl:value-of select="'年10月～'"/>
			  <xsl:value-of select="$e_year"/>
			  <xsl:value-of select="'年09月）'"/>
		  </caption>
      </table>
      <table class="table">
        <thead>
        <tr class="sub_line">
          <th>客先名</th>
          <th>プロジェクト名</th>
          <th>プロジェクト<br/>コード</th>
          <th>予測<br/>確度</th>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="mCnt" select="12"/>
            <xsl:with-param name="begin" select="10"/>
          </xsl:call-template>
          <th>
            予測<br/>確度
          </th>
          <th>
            プロジェクト<br/>コード
          </th>
          <th>プロジェクト名</th>
          <th>客先名</th>
        </tr>
        </thead>
        <tbody>
          <xsl:for-each select="*">
             <xsl:call-template name="分類">
              <xsl:with-param name="分類" select="*"/>
            </xsl:call-template>
          </xsl:for-each>

			<tr>
				<td colspan="4">
					<xsl:value-of select="name(*/*/*/実績)"/>
				</td>
				<xsl:call-template name="item_Loop1">
					<xsl:with-param name="mCnt" select="12"/>
					<xsl:with-param name="data" select="*" />
					<xsl:with-param name="mode" select="'予測'" />
				</xsl:call-template>
				<td colspan="4">
					<xsl:value-of select="name(*/*/*/実績)"/>
				</td>			</tr>
			<tr>
				<td colspan="4">
					<xsl:value-of select="name(*/*/*/実績)"/>
				</td>
				<xsl:call-template name="item_Loop2">
					<xsl:with-param name="mCnt" select="12"/>
					<xsl:with-param name="data" select="*" />
					<xsl:with-param name="mode" select="'実績'" />
				</xsl:call-template>
				<td colspan="4">aa</td>
			</tr>
		</tbody>
      </table>
    </xsl:if>

  </xsl:template>


	<xsl:template name="分類">
    <xsl:for-each select="*">
      <xsl:variable name="Cnt" select="count(*)"/>
      <xsl:variable name="Pos1" select="position()"/>
      <xsl:for-each select="*">
        <xsl:variable name="Pos2" select="position()"/>
        <xsl:for-each select="*[name()='予測' or name() = '実績']">
          <xsl:variable name="Pos3" select="position()"/>
          <tr>
              <xsl:if test="$Pos2=1 and $Pos3=1">
              <td>
                <xsl:attribute name="rowspan">
                  <xsl:value-of select="$Cnt*2"/>
                </xsl:attribute>
                <xsl:value-of select="../../@_name_"/>
              </td>
              </xsl:if>

              <xsl:if test="$Pos3=1">
                <td>
                  <xsl:attribute name="rowspan">
                    <xsl:value-of select="2"/>
                  </xsl:attribute>
                  <xsl:value-of select="../name"/>
              </td>
              </xsl:if>
              <xsl:if test="$Pos3=1">
                <td>
                  <xsl:attribute name="rowspan">
                    <xsl:value-of select="2"/>
                  </xsl:attribute>
                  <xsl:value-of select="../pCode"/>
                </td>
              </xsl:if>
              <xsl:if test="$Pos3=1">
                <td>
					<xsl:value-of select="../level"/>
                </td>
                <xsl:call-template name="item_Loop">
                  <xsl:with-param name="mCnt" select="12"/>
					<xsl:with-param name="data" select="予測" />
					<xsl:with-param name="mode" select="'予測'" />
				</xsl:call-template>
              </xsl:if>
              <xsl:if test="$Pos3=2">
                <td>
                  <xsl:call-template name="EMG_mark">
                    <xsl:with-param name="mark" select="../Corp"/>
                  </xsl:call-template>
                </td>
                <xsl:call-template name="item_Loop">
                  <xsl:with-param name="mCnt" select="12"/>
                  <xsl:with-param name="data" select="実績" />
					<xsl:with-param name="mode" select="'実績'" />
				</xsl:call-template>
              </xsl:if>

            <xsl:if test="$Pos3=1">
              <td>
                <xsl:value-of select="../level"/>
              </td>
            </xsl:if>
            <xsl:if test="$Pos3=2">
              <td>
                <xsl:value-of select="../Corp"/>
              </td>
            </xsl:if>
            <xsl:if test="$Pos3=1">
              <td>
                <xsl:attribute name="rowspan">
                  <xsl:value-of select="2"/>
                </xsl:attribute>
                <xsl:value-of select="../pCode"/>
              </td>
            </xsl:if>
            <xsl:if test="$Pos3=1">
              <td>
                <xsl:attribute name="rowspan">
                  <xsl:value-of select="2"/>
                </xsl:attribute>
                <xsl:value-of select="../name"/>
              </td>
            </xsl:if>
            <xsl:if test="$Pos2=1 and $Pos3=1">
              <td>
                <xsl:attribute name="rowspan">
                  <xsl:value-of select="$Cnt*2"/>
                </xsl:attribute>
                <xsl:value-of select="../../@_name_"/>
              </td>
            </xsl:if>
          </tr>
          </xsl:for-each>
        </xsl:for-each>
	</xsl:for-each>
	</xsl:template>

	<xsl:template name="item_Loop1">
		<xsl:param name="data" />
		<xsl:param name="mCnt" />
		<xsl:param name="mode" />
		<xsl:param name="begin" select="0"/>
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />

		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="sum(*/*/*/予測/月[@m=$cnt])"/>
			<td class="num">
				<xsl:if test="$mode ='予測'">
					<xsl:attribute name="class">
						<xsl:value-of select="'yosoku'"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="nowrap"/>
				<xsl:if test="$temp &gt; 0">
					<xsl:value-of select="format-number( $temp ,$form)"/>
				</xsl:if>
			</td>
			<xsl:call-template name="item_Loop1">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="mode" select="$mode" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="item_Loop2">
		<xsl:param name="data" />
		<xsl:param name="mCnt" />
		<xsl:param name="mode" />
		<xsl:param name="begin" select="0"/>
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />

		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="sum(*/*/*/実績/月[@m=$cnt])"/>
			<td class="num">
				<xsl:if test="$mode ='予測'">
					<xsl:attribute name="class">
						<xsl:value-of select="'yosoku'"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="nowrap"/>
				<xsl:if test="$temp &gt; 0">
					<xsl:value-of select="format-number( $temp ,$form)"/>
				</xsl:if>
			</td>
			<xsl:call-template name="item_Loop2">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="mode" select="$mode" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<xsl:template name="item_Loop">
    <xsl:param name="data" />
	<xsl:param name="mCnt" />
	<xsl:param name="mode" />
    <xsl:param name="begin" select="0"/>
	<xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="form" select="'#,###'" />
    <xsl:if test="$cnt &lt; $max">
      <xsl:variable name="temp" select="sum(月[@m=$cnt])"/>
      <td class="num">
		  <xsl:if test="$mode ='予測'">
    		  <xsl:attribute name="class">
	    		  <xsl:value-of select="'yosoku'"/>
		      </xsl:attribute>
		  </xsl:if>
		  <xsl:attribute name="nowrap"/>
		  <xsl:if test="$temp &gt; 0">
          <xsl:value-of select="format-number( $temp ,$form)"/>
        </xsl:if>
      </td>
      <xsl:call-template name="item_Loop">
    	  <xsl:with-param name="data" select="$data" />
          <xsl:with-param name="mode" select="$mode" />
		  <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="cnt" select="$cnt + 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template name="EMG_mark">
    <xsl:param name="mark" />
    <xsl:choose>
      <xsl:when test="$mark = 'EM'">
        <xsl:value-of select="'EM'"/>
      </xsl:when>
      <xsl:when test="$mark = 'ACEL'">
        <xsl:value-of select="'ACEL'"/>
      </xsl:when>
      <xsl:when test="$mark = 'PSL'">
        <xsl:value-of select="'PSL'"/>
      </xsl:when>
      <xsl:when test="'-'">
        <xsl:text>&#160;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'x'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>