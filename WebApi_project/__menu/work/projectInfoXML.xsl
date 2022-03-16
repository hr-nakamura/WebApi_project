<?xml version="1.0" encoding="Shift_JIS" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:msxsl="urn:schemas-microsoft-com:xslt"
      xmlns:user="mynamespace">

	<!--      xmlns:user="http://mycompany.com/mynamespace">	-->

<xsl:template match="/">

<html>
<head>
<title>プロジェクト集計(詳細)</title>
<link rel="stylesheet" type="text/css" href="pSub.css"/>
</head>

<body background="bg.gif">
	<xsl:apply-templates select="root" />
</body>
</html>

</xsl:template>

<xsl:template match="root">
	<table class="disp" cellpadding="0" cellspacing="0">
<!--
	<caption>
		<xsl:value-of select="客先/名前"/>
	</caption>
	<caption>
		<xsl:value-of select="客先/プロジェクト/pCode"/>
	</caption>
	<caption>
		<xsl:value-of select="客先/プロジェクト/pNum"/>
	</caption>
-->
	<caption>
		<xsl:value-of select="客先/プロジェクト/名前"/> (<xsl:value-of select="客先/プロジェクト/pCode"/>)
	</caption>
	<thead>
			<xsl:apply-templates select="客先" mode="headerOut">
			</xsl:apply-templates>
	</thead>
	<tbody>
			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'売上予測'" />
				<xsl:with-param name="item" select="'売上予測'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

    <!--<xsl:apply-templates select="客先" mode="valueOut">
      <xsl:with-param name="title" select="'想定工数'" />
      <xsl:with-param name="item" select="'想定工数'" />
      <xsl:with-param name="unit" select="100" />
      <xsl:with-param name="form" select="'#,##0.00'" />
    </xsl:apply-templates>
    
    <xsl:apply-templates select="客先" mode="valueOut">
      <xsl:with-param name="title" select="'作業予定'" />
      <xsl:with-param name="item" select="'作業予定'" />
      <xsl:with-param name="unit" select="100" />
      <xsl:with-param name="form" select="'#,##0.00'" />
    </xsl:apply-templates>-->
  </tbody>
	<thead>
			<xsl:apply-templates select="客先" mode="headerOut">
			</xsl:apply-templates>
	</thead>
	<tbody>
			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'売上実績'" />
				<xsl:with-param name="item" select="'売上実績'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'業務費用'" />
				<xsl:with-param name="item" select="'業務費用'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'協力会社の費用'" />
				<xsl:with-param name="item" select="'協力費用'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

	</tbody>
	<thead>
			<xsl:apply-templates select="客先" mode="headerOut">
			</xsl:apply-templates>
	</thead>
	<tbody>
			<!--<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'社員の作業時間'" />
				<xsl:with-param name="item" select="'社員時間'" />
				<xsl:with-param name="unit" select="60" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'社員の作業日数'" />
				<xsl:with-param name="item" select="'社員日数'" />
				<xsl:with-param name="unit" select="1" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>-->

			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'社員の作業工数'" />
				<xsl:with-param name="item" select="'社員工数'" />
				<xsl:with-param name="unit" select="100" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>

			<!--<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'パート・契約社員の作業時間'" />
				<xsl:with-param name="item" select="'パート時間'" />
				<xsl:with-param name="unit" select="60" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'パート・契約社員の作業日数'" />
				<xsl:with-param name="item" select="'パート日数'" />
				<xsl:with-param name="unit" select="1" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>-->

			<xsl:apply-templates select="客先" mode="valueOut">
				<xsl:with-param name="title" select="'パート・契約社員の作業工数'" />
				<xsl:with-param name="item" select="'パート工数'" />
				<xsl:with-param name="unit" select="100" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>
		</tbody>
	</table>
</xsl:template>


<!--　　　　　　　　　　　　　　　　　　　　　　　　　　　-->
  <!--  指定項目の列出力　  -->
    <!--　title:　表の題名　  -->
    <!--　unit:単位　　　　   -->
    <!--　form:表示形式　　   -->
    <!--　item:処理する項目名 -->
<xsl:template match="客先" mode="valueOut">
	<xsl:param name="pNum" select="プロジェクト/pNum"/>
	<xsl:param name="yymm" select="プロジェクト/yymm"/>
	<xsl:param name="year" select="開始年"/>
	<xsl:param name="mm" select="開始月"/>
	<xsl:param name="mCnt" select="月数"/>
	<xsl:param name="title"/>
	<xsl:param name="item"/>
	<xsl:param name="unit"/>
	<xsl:param name="form"/>
	<xsl:for-each select="プロジェクト">
		<xsl:variable name="cnt1" select="count(項目[@name=$item]/詳細)"/>
		<xsl:for-each select="項目[@name=$item]">
			<xsl:for-each select="詳細">
				<tr>
					<xsl:attribute name="item"><xsl:value-of select="$item"/></xsl:attribute>
					<xsl:attribute name="pNum"><xsl:value-of select="$pNum"/></xsl:attribute>
					<xsl:attribute name="yymm"><xsl:value-of select="$yymm"/></xsl:attribute>
				<td class="sItem">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="$title"/>
        </td>
				<!--列の合計-->
				<td id="sumCell">
					<xsl:attribute name="nowrap" />
          <xsl:attribute name="value"><xsl:value-of select="sum(*)"/></xsl:attribute>
					<xsl:value-of select="format-number(sum(*) div $unit,$form)"/>
				</td>
					<xsl:call-template name="valueOut_Loop">
						<xsl:with-param name="element" select="." />
						<xsl:with-param name="item" select="$item" />
						<xsl:with-param name="begin" select="0" />
						<xsl:with-param name="mCnt" select="$mCnt" />
						<xsl:with-param name="mode" select="''" />
						<xsl:with-param name="unit" select="$unit" />
						<xsl:with-param name="form" select="$form" />
					</xsl:call-template>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<!--　　　　　　　　　　　　　　　　　　　　　　　　　　　-->

<!--　　　　　　　　　　　　　　　　　　　　　　　　　　　-->
  <!--  年月のヘッダーの表出力　  -->
<xsl:template match="客先" mode="headerOut">
	<xsl:param name="year" select="開始年"/>
	<xsl:param name="mm" select="開始月"/>
	<xsl:param name="mCnt" select="月数"/>
		<thead>
			<tr>
				<th rowspan="2">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="'項目名'"/>
				</th>
				<th  rowspan="2">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="'合計'"/>
				</th>
					<xsl:call-template name="year_Loop">
						<xsl:with-param name="year" select="$year" />
						<xsl:with-param name="begin" select="$mm" />
						<xsl:with-param name="mCnt" select="$mCnt" />
					</xsl:call-template>
				</tr>
				<tr>
					<xsl:call-template name="month_Loop">
						<xsl:with-param name="begin" select="$mm" />
						<xsl:with-param name="mCnt" select="$mCnt" />
					</xsl:call-template>
				</tr>
			</thead>
	</xsl:template>

<!--　　　　　　　　　　　　　　　　　　　　　　　　　　　-->


<!--　データ行の表示　-->
<xsl:template name="valueOut_Loop">
  <xsl:param name="item" />
  <xsl:param name="begin" />
  <xsl:param name="mCnt" />
	<xsl:param name="max" select="$begin+$mCnt"/>
	<xsl:param name="cnt" select="$begin"/>
	<xsl:param name="mode" />
	<xsl:param name="unit" />
	<xsl:param name="form"/>
	<xsl:if test="$cnt &lt; $max">
		<td id='Cell'>
			<xsl:attribute name="nowrap" />
			<xsl:attribute name="value"><xsl:value-of select="sum(月[@m=$cnt])"/></xsl:attribute>
			<xsl:attribute name="m"><xsl:value-of select="$cnt"/></xsl:attribute>
			<xsl:if test="sum(月[@m=$cnt])>0 or $mode = 0">
				<xsl:value-of select="format-number(sum(月[@m=$cnt]) div $unit,$form)"/>
			</xsl:if>
<!--
			<xsl:if test="sum(月[@m=$cnt])=0 or $mode = 0">
				<xsl:value-of select="'0'"/>
			</xsl:if>
-->
		</td>
			<xsl:call-template name="valueOut_Loop">
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="mode" select="$mode" />
				<xsl:with-param name="unit" select="$unit" />
				<xsl:with-param name="form" select="$form" />
			</xsl:call-template>
	</xsl:if>
</xsl:template>




  <!--	年の表示	-->
	
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
			<xsl:value-of select="$year"/>年
			</th>
				<xsl:call-template name="year_Loop">
					<xsl:with-param name="year" select="$year+1" />
					<xsl:with-param name="mCnt" select="$mCnt - $cnt" />
					<xsl:with-param name="cnt" select="12" />
				</xsl:call-template>
		</xsl:if>
	</xsl:template>

	
<!--	月の表示	-->
	<xsl:template name="month_Loop">
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:if test="$cnt &lt; $max">
			<th class="m">
			<xsl:attribute name="nowrap" />
				<xsl:if test="($cnt mod 12)>0">
					<xsl:value-of select="$cnt mod 12"/>月
				</xsl:if>
				<xsl:if test="($cnt mod 12)=0">
					<xsl:value-of select="12"/>月
				</xsl:if>
			</th>
				<xsl:call-template name="month_Loop">
					<xsl:with-param name="max" select="$max" />
					<xsl:with-param name="cnt" select="$cnt + 1" />
				</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
