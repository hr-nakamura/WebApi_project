<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:import href="sub_cmn.xsl"/>
  
  <!--
  chrome [loadXMLDoc]からの場所  xsl/sub_cmn.xsl
  IE     [本体xsl]からの場所     sub_cmn.xsl
  -->
  
  <xsl:variable name="year">
    <xsl:value-of select="/root/情報/@year"/>
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
      <table class="table">
        <tbody>
          <xsl:for-each select="目標">
            <xsl:call-template name="客先">
              <xsl:with-param name="客先" select="*"/>
            </xsl:call-template>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>

  </xsl:template>



	<xsl:template name="客先2">
		<xsl:param name="客先"/>
		<xsl:value-of select="name()"/>
		<xsl:value-of select="count($客先)"/>
		<xsl:for-each select="$客先">
			<xsl:value-of select="@_name_"/>
		</xsl:for-each>
	</xsl:template>



	<xsl:template name="客先">
    <xsl:param name="客先"/>
    <xsl:param name="form" select="'#,###'"/>
    <tr class="sub_line">
		<th>グループ名</th>
		<th>項目</th>
		<xsl:call-template name="year_Loop">
        <xsl:with-param name="year" select="$year - 1"/>
        <xsl:with-param name="begin" select="10"/>
        <xsl:with-param name="mCnt" select="12"/>
      </xsl:call-template>
    </tr>
		<xsl:call-template name="全体X">
			<xsl:with-param name="全体" select="*"/>
		</xsl:call-template>
		
      <xsl:for-each select="*[name() != '全体' ]">
        <xsl:call-template name="グループ">
          <xsl:with-param name="グループ" select="."/>
         </xsl:call-template>
      </xsl:for-each>

  </xsl:template>

	<xsl:template name="全体X">
		<xsl:param name="全体"/>
		<tr>
			<tr class="sub_line">
				<td rowspan="9">EMG</td>

				<td>月</td>
				<xsl:call-template name="month_Loop">
					<xsl:with-param name="begin" select="10"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<td>目　標</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$全体[name() != '全体']/目標"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>実績・予測</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$全体[name() != '全体']/予実"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>前年度実績*</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$全体[name() = '全体']/前年"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>累計[目標](A)</td>
			<xsl:call-template name="item_Loop_累計">
				<xsl:with-param name="data" select="$全体[name() != '全体']/目標"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>累計[実予](B)</td>
			<xsl:call-template name="item_Loop_累計">
				<xsl:with-param name="data" select="$全体[name() != '全体']/予実"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>累計[前実]*</td>
			<xsl:call-template name="item_Loop_累計">
				<xsl:with-param name="data" select="$全体[name() = '全体']/前年"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>率 (B/A)</td>
			<xsl:call-template name="item_Loop_率">
				<xsl:with-param name="data_A" select="$全体[name() != '全体']/目標"/>
				<xsl:with-param name="data_B" select="$全体[name() != '全体']/予実"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>差 (B-A)</td>
			<xsl:call-template name="item_Loop_差">
				<xsl:with-param name="data_A" select="$全体[name() != '全体']/目標"/>
				<xsl:with-param name="data_B" select="$全体[name() != '全体']/予実"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
	</xsl:template>

	<xsl:template name="全体">
		<xsl:param name="全体"/>
			<tr class="sub_line">
				<td  class="onKind" rowspan="7">
					<xsl:value-of select="@_name_"/>
				</td>
				<td>月</td>
				<xsl:call-template name="month_Loop">
					<xsl:with-param name="begin" select="10"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'目　標'"/>
				</td>
				<xsl:call-template name="item_Loop">
					<xsl:with-param name="data" select="目標"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'実績・予測'"/>
				</td>
				<xsl:call-template name="item_Loop">
					<xsl:with-param name="data" select="予実"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'累計[目標] (A)'"/>
				</td>
				<xsl:call-template name="item_Loop_累計">
					<xsl:with-param name="data" select="目標"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'累計[実予] (B)'"/>
				</td>
				<xsl:call-template name="item_Loop_累計">
					<xsl:with-param name="data" select="予実"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'率 (B/A)'"/>
				</td>
				<xsl:call-template name="item_Loop_率">
					<xsl:with-param name="data_A" select="目標"/>
					<xsl:with-param name="data_B" select="予実"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'差 (B-A)'"/>
				</td>
				<xsl:call-template name="item_Loop_差">
					<xsl:with-param name="data_A" select="目標"/>
					<xsl:with-param name="data_B" select="予実"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>

	</xsl:template>
 
  <xsl:template name="グループ">
    <xsl:param name="グループ"/>
	  <xsl:for-each select="$グループ">
		  
	  <tr class="sub_line">
		  <td  class="onKind" rowspan="7">
			  <xsl:value-of select="@_name_"/>
		  </td>
		  <td>月</td>
		  <xsl:call-template name="month_Loop">
			  <xsl:with-param name="begin" select="10"/>
			  <xsl:with-param name="mCnt" select="12"/>
		  </xsl:call-template>
	  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'目　標'"/>
			  </td>
			  <xsl:call-template name="item_Loop">
				  <xsl:with-param name="data" select="目標"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'実績・予測'"/>
			  </td>
			  <xsl:call-template name="item_Loop">
				  <xsl:with-param name="data" select="予実"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'累計[目標] (A)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_累計">
				  <xsl:with-param name="data" select="目標"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'累計[実予] (B)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_累計">
				  <xsl:with-param name="data" select="予実"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'率 (B/A)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_率">
				  <xsl:with-param name="data_A" select="目標"/>
				  <xsl:with-param name="data_B" select="予実"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'差 (B-A)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_差">
				  <xsl:with-param name="data_A" select="目標"/>
				  <xsl:with-param name="data_B" select="予実"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
	  </xsl:for-each>

  </xsl:template>

	<xsl:template name="item_Loop">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="sum($data/月[@m=$cnt])"/>
			<td class="num">
				<xsl:attribute name="nowrap"/>
				<xsl:value-of select="format-number( $temp div 1000 ,$form)"/>
			</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="item_Loop_累計">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:param name="work" select="0"/>
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="sum($data/月[@m=$cnt])"/>
			<td class="num">
				<xsl:attribute name="nowrap"/>
				<xsl:value-of select="format-number( ($work + $temp) div 1000 ,'#,##0')"/>
			</td>
			<xsl:call-template name="item_Loop_累計">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work" select="$work + sum($data/月[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="item_Loop_差">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data_A" />
		<xsl:param name="data_B" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:param name="work_A" select="0"/>
		<xsl:param name="work_B" select="0"/>
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="($work_B + sum($data_B/月[@m=$cnt])) - ($work_A + sum($data_A/月[@m=$cnt]))"/>

			<td class="num">
				<xsl:attribute name="nowrap"/>
				<xsl:if test="$temp &lt; 0">
					<xsl:attribute name="style">
						<xsl:value-of select="'color:tomato;'"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="format-number( $temp div 1000 ,'#,##0')"/>
			</td>
			<xsl:call-template name="item_Loop_差">
				<xsl:with-param name="data_A" select="$data_A" />
				<xsl:with-param name="data_B" select="$data_B" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work_A" select="$work_A + sum($data_A/月[@m=$cnt])" />
				<xsl:with-param name="work_B" select="$work_B + sum($data_B/月[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="item_Loop_率">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data_A" />
		<xsl:param name="data_B" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:param name="work_A" select="0"/>
		<xsl:param name="work_B" select="0"/>
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="($work_B + sum($data_B/月[@m=$cnt])) div ($work_A + sum($data_A/月[@m=$cnt]))"/>
			<td class="num">
				<xsl:attribute name="nowrap"/>
				<xsl:choose>
					<xsl:when test="string($temp) = 'NaN'">
						<xsl:value-of select="'='"/>
					</xsl:when>
					<xsl:when test="string($temp) = 'Infinity'">
						<xsl:value-of select="'-'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number( $temp * 100 ,'##0.0')"/>
						<xsl:value-of select="'%'"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<xsl:call-template name="item_Loop_率">
				<xsl:with-param name="data_A" select="$data_A" />
				<xsl:with-param name="data_B" select="$data_B" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work_A" select="$work_A + sum($data_A/月[@m=$cnt])" />
				<xsl:with-param name="work_B" select="$work_B + sum($data_B/月[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>
