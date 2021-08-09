<?xml version="1.0" encoding="shift_jis" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">	


	<!--	年の表示	-->
	<!---->
	<!--	year  : 開始年	-->
	<!--	begin : 開始月	-->
	<!--	mCnt  : 表示月数	-->
	<!--
====使用例=============
<tr>
	<xsl:call-template name="year_Loop">
	<xsl:with-param name="year" select="$year" />
	<xsl:with-param name="begin" select="$mm" />
	<xsl:with-param name="mCnt" select="$mCnt" />
	</xsl:call-template>
</tr>
=======================
-->
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