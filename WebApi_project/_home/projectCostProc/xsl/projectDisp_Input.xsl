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
<title>プロジェクト</title>
<link rel="stylesheet" type="text/css" href="cost.css"/>
</head>

<body background="bg.gif">
  <xsl:if test="/root/全体/プロジェクト/月数!=''">
    <xsl:apply-templates select="root/全体" />
  </xsl:if>
</body>
</html>

</xsl:template>

  <xsl:variable name="actualColor">
    <xsl:value-of select="'actualColor'"/>
  </xsl:variable>
  <xsl:variable name="editColor">
    <xsl:value-of select="'editColor'"/>
  </xsl:variable>

  <xsl:variable name="actualCnt">
    <xsl:value-of select="//実績月数"/>
  </xsl:variable>

  <xsl:variable name="開始年">
    <xsl:value-of select="//開始年"/>
  </xsl:variable>
  <xsl:variable name="開始月">
    <xsl:value-of select="//開始月"/>
  </xsl:variable>
  <xsl:variable name="月数">
    <xsl:value-of select="//月数"/>
  </xsl:variable>

  <xsl:template match="全体">
    <table class="disp" cellpadding="0" cellspacing="0" width="100%">
      <thead>
        <xsl:apply-templates select="プロジェクト" mode="spaceOut">
          <xsl:with-param name="memo" select="'(売上：千円) (工数：人月)'" />
        </xsl:apply-templates>
      </thead>
      <thead>
        <xsl:apply-templates select="プロジェクト" mode="headerOut">
          <xsl:with-param name="title" select="'売上・予測'" />
        </xsl:apply-templates>
      </thead>
      <tbody>
        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'売上予測'" />
          <xsl:with-param name="item" select="'売上'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'契約工数'" />
          <xsl:with-param name="item" select="'契約工数'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'外部工数'" />
          <xsl:with-param name="item" select="'外部工数'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'見積工数'" />
          <xsl:with-param name="item" select="'見積工数'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>
      </tbody>
      <thead>
        <xsl:apply-templates select="プロジェクト" mode="spaceOut"/>
        <xsl:apply-templates select="プロジェクト" mode="spaceOut">
          <xsl:with-param name="memo" select="'工数：人月'" />
        </xsl:apply-templates>
      </thead>
      <thead>
        <xsl:apply-templates select="プロジェクト" mode="headerOut">
          <xsl:with-param name="title" select="'想定工数・予測'" />
        </xsl:apply-templates>
      </thead>
      <tbody>
        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'社員工数'" />
          <xsl:with-param name="item" select="'社員工数'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'パート工数'" />
          <xsl:with-param name="item" select="'パート工数'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'協力工数'" />
          <xsl:with-param name="item" select="'協力工数'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut_工数合計">
          <xsl:with-param name="title" select="'工数合計'" />
          <xsl:with-param name="item" select="'工数合計'" />
          <xsl:with-param name="mode" select="'実績'" />
          <xsl:with-param name="unit" select="100" />
          <xsl:with-param name="form" select="'#,##0.00'" />
        </xsl:apply-templates>
      </tbody>

      <thead>
        <xsl:apply-templates select="プロジェクト" mode="spaceOut"/>
        <xsl:apply-templates select="プロジェクト" mode="spaceOut">
          <xsl:with-param name="memo" select="'費用：千円'" />
        </xsl:apply-templates>
      </thead>

      <thead>
        <xsl:apply-templates select="プロジェクト" mode="headerOut">
          <xsl:with-param name="title" select="'費用・予測'" />
        </xsl:apply-templates>
      </thead>
      <tbody>
        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'業務費用'" />
          <xsl:with-param name="item" select="'業務費用'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'労務費'" />
          <xsl:with-param name="item" select="'労務費'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>

        <xsl:apply-templates select="プロジェクト" mode="valueOut">
          <xsl:with-param name="title" select="'協力費用'" />
          <xsl:with-param name="item" select="'協力費用'" />
          <xsl:with-param name="mode" select="'予測'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
        </xsl:apply-templates>

            <xsl:apply-templates select="プロジェクト" mode="valueOut_費用合計">
          <xsl:with-param name="title" select="'費用合計'" />
          <xsl:with-param name="item" select="'費用合計'" />
          <xsl:with-param name="mode" select="'実績'" />
          <xsl:with-param name="unit" select="1000" />
          <xsl:with-param name="form" select="'#,##0'" />
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
  <xsl:template match="プロジェクト" mode="valueOut">
    <xsl:param name="pNum" select="pNum"/>
    <xsl:param name="yymm" select="yymm"/>
    <xsl:param name="year" select="開始年"/>
    <xsl:param name="mm" select="開始月"/>
    <xsl:param name="mCnt" select="月数"/>
    <xsl:param name="title"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
      <xsl:variable name="cnt1" select="count(項目[@name=$item and @mode=$mode])"/>
      <xsl:for-each select="項目[@name=$item and @mode=$mode]">
        <tr>
          <xsl:attribute name="item">
            <xsl:value-of select="$item"/>
          </xsl:attribute>
          <xsl:attribute name="pNum">
            <xsl:value-of select="$pNum"/>
          </xsl:attribute>
          <xsl:attribute name="yymm">
            <xsl:value-of select="$yymm"/>
          </xsl:attribute>
          <xsl:attribute name="mode">
            <xsl:value-of select="$mode"/>
          </xsl:attribute>
          <td class="sItem">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="id">
              <xsl:value-of select="'Detail'"/>
            </xsl:attribute>
            <xsl:attribute name="item">
              <xsl:value-of select="$title"/>
            </xsl:attribute>
            <xsl:attribute name="mode">
              <xsl:value-of select="$mode"/>
            </xsl:attribute>
            <xsl:value-of select="$title"/>
          </td>
          <!--列の合計-->
          <td id="sumCell">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="sum(*)"/>
            </xsl:attribute>
            <xsl:value-of select="format-number(sum(*) div $unit,$form)"/>
          </td>
          <xsl:call-template name="valueOut_Loop">
            <xsl:with-param name="element" select="." />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="begin" select="0" />
            <xsl:with-param name="mCnt" select="$mCnt" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="form" select="$form" />
          </xsl:call-template>
        </tr>
      </xsl:for-each>
  </xsl:template>

  <!--　　　　　　　　　　　　　　　　　　　　　　　　　　　-->
  <!--  指定項目の列出力　  -->
  <!--　title:　表の題名　  -->
  <!--　unit:単位　　　　   -->
  <!--　form:表示形式　　   -->
  <!--　item:処理する項目名 -->
  <xsl:template match="プロジェクト" mode="valueOutOne">
    <xsl:param name="m" select="0"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
    <xsl:for-each select="項目[@name=$item and @mode=$mode]">
          <td id="Cell">
            <xsl:attribute name="class">
              <xsl:value-of select="$editColor"/>
            </xsl:attribute>
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="月[@m=$m]"/>
            </xsl:attribute>
            <xsl:attribute name="m">
              <xsl:value-of select="$m"/>
            </xsl:attribute>
            <xsl:value-of select="format-number(月[@m=$m] div $unit,$form)"/>
          </td>
      </xsl:for-each>
  </xsl:template>

  <!--　　　　　　　　　　　　　　　　　　　　　　　　　　　-->

<!--　　　　　　　　　　　　　　　　　　　　　　　　　　　-->
  <!--  年月のヘッダーの表出力　  -->
<xsl:template match="プロジェクト" mode="headerOut">
  <xsl:param name="title"/>
  <xsl:param name="year" select="開始年"/>
  <xsl:param name="mm" select="開始月"/>
	<xsl:param name="mCnt" select="月数"/>
			<tr>
				<th rowspan="2">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="$title"/>
				</th>
				<th class="m" rowspan="2">
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
	</xsl:template>

  <!--  　  -->
  <xsl:template match="プロジェクト" mode="spaceOut">
    <xsl:param name="memo"/>
    <xsl:param name="mCnt" select="月数"/>
    <tr style="background-color:transparent;border:0 0 0 0;">
          <xsl:choose>
            <xsl:when test="$memo = ''">
              <th colspan="{$mCnt+2}">
                <xsl:attribute name="style">
                <xsl:value-of select="'border:0 0 0 0;'"/>
              </xsl:attribute>
              <hr/>
              </th>
            </xsl:when>
            <xsl:otherwise>
              <td colspan="{$mCnt+2}">
                <xsl:attribute name="style">
                <xsl:value-of select="'border:0 0 0 0;text-align:right;'"/>
              </xsl:attribute>
              <xsl:value-of select="$memo"/>
              </td>
            </xsl:otherwise>
          </xsl:choose>
      </tr>
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
		<td class="$editColor">
      <xsl:choose>
        <xsl:when test="$mode='予測'">
          <xsl:attribute name="id">
            <xsl:value-of select="'Cell'"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$cnt&lt;$actualCnt">
              <xsl:attribute name="class">
                <xsl:value-of select="$actualColor"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">
                <xsl:value-of select="$editColor"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$mode='実績'">
          <xsl:attribute name="id">
            <xsl:value-of select="'viewCell'"/>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$cnt&lt;$actualCnt">
              <xsl:attribute name="class">
                <xsl:value-of select="$actualColor"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">
                <xsl:value-of select="$editColor"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="id">
            <xsl:value-of select="'viewCell'"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="nowrap" />
      <xsl:attribute name="value"><xsl:value-of select="月[@m=$cnt]"/></xsl:attribute>
			<xsl:attribute name="m"><xsl:value-of select="$cnt"/></xsl:attribute>
			<xsl:if test="sum(月[@m=$cnt]) != 0">
				<xsl:value-of select="format-number(月[@m=$cnt] div $unit,$form)"/>
			</xsl:if>
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

  <!--  指定項目の列出力　  -->
  <!--　title:　表の題名　  -->
  <!--　unit:単位　　　　   -->
  <!--　form:表示形式　　   -->
  <!--　item:処理する項目名 -->
  <xsl:template match="プロジェクト" mode="valueOut_費用合計">
    <xsl:param name="pNum" select="pNum"/>
    <xsl:param name="yymm" select="yymm"/>
    <xsl:param name="year" select="開始年"/>
    <xsl:param name="mm" select="開始月"/>
    <xsl:param name="mCnt" select="月数"/>
    <xsl:param name="title"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
      <!--<xsl:variable name="cnt1" select="count(項目[@name=$item and @mode=$mode])"/>-->
      <xsl:for-each select="項目[@name=$item and @mode=$mode]">
        <tr>
          <xsl:attribute name="item">
            <xsl:value-of select="$item"/>
          </xsl:attribute>
          <xsl:attribute name="pNum">
            <xsl:value-of select="$pNum"/>
          </xsl:attribute>
          <xsl:attribute name="yymm">
            <xsl:value-of select="$yymm"/>
          </xsl:attribute>
          <xsl:attribute name="mode">
            <xsl:value-of select="$mode"/>
          </xsl:attribute>
          <td class="sItem">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:gainsboro;'"/>
            </xsl:attribute>
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="$title"/>
          </td>
          <!--列の合計-->
          <td  id="sumCell">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="sum(*)"/>
            </xsl:attribute>
            <xsl:variable name="労務費" select="sum(../項目[@name='労務費' and @mode='予測']/月)"/>
            <xsl:variable name="業務費用" select="sum(../項目[@name='業務費用' and @mode='予測']/月)"/>
            <xsl:variable name="協力費用" select="sum(../項目[@name='協力費用' and @mode='予測']/月)"/>
            <xsl:variable name="費用合計" select="$労務費 + $業務費用 + $協力費用"/>
            <xsl:if test="$費用合計 >= 0">
              <xsl:value-of select="format-number($費用合計 div $unit,$form)"/>
            </xsl:if>
          </td>
          <xsl:call-template name="valueOut_費用合計_Loop">
            <xsl:with-param name="element" select="." />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="begin" select="0" />
            <xsl:with-param name="mCnt" select="$mCnt" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="form" select="$form" />
          </xsl:call-template>
        </tr>
      </xsl:for-each>
  </xsl:template>

  <!--　データ行の表示　-->
  <xsl:template name="valueOut_費用合計_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="mode" />
    <xsl:param name="unit" />
    <xsl:param name="form"/>
    <xsl:if test="$cnt &lt; $max">
      <td id="sumCell">
        <xsl:attribute name="nowrap" />
        <xsl:attribute name="value">
          <xsl:value-of select="月[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:variable name="労務費" select="sum(../項目[@name='労務費' and @mode='予測']/月[@m=$cnt])"/>
        <xsl:variable name="業務費用" select="sum(../項目[@name='業務費用' and @mode='予測']/月[@m=$cnt])"/>
        <xsl:variable name="協力費用" select="sum(../項目[@name='協力費用' and @mode='予測']/月[@m=$cnt])"/>
        <xsl:variable name="費用合計" select="$労務費 + $業務費用 + $協力費用"/>
        <xsl:if test="$費用合計 >= 0">
          <xsl:value-of select="format-number($費用合計 div $unit ,$form)"/>
        </xsl:if>
      </td>
      <xsl:call-template name="valueOut_費用合計_Loop">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
        <xsl:with-param name="mode" select="$mode" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="form" select="$form" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--  指定項目の列出力　  -->
  <!--　title:　表の題名　  -->
  <!--　unit:単位　　　　   -->
  <!--　form:表示形式　　   -->
  <!--　item:処理する項目名 -->
  <xsl:template match="プロジェクト" mode="valueOut_工数合計">
    <xsl:param name="pNum" select="pNum"/>
    <xsl:param name="yymm" select="yymm"/>
    <xsl:param name="year" select="開始年"/>
    <xsl:param name="mm" select="開始月"/>
    <xsl:param name="mCnt" select="月数"/>
    <xsl:param name="title"/>
    <xsl:param name="item"/>
    <xsl:param name="mode"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
      <xsl:variable name="cnt1" select="count(項目[@name=$item and @mode=$mode])"/>
      <xsl:for-each select="項目[@name=$item and @mode=$mode]">
        <tr>
          <xsl:attribute name="item">
            <xsl:value-of select="$item"/>
          </xsl:attribute>
          <xsl:attribute name="pNum">
            <xsl:value-of select="$pNum"/>
          </xsl:attribute>
          <xsl:attribute name="yymm">
            <xsl:value-of select="$yymm"/>
          </xsl:attribute>
          <xsl:attribute name="mode">
            <xsl:value-of select="$mode"/>
          </xsl:attribute>
          <td class="sItem">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:gainsboro;'"/>
            </xsl:attribute>
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="$title"/>
          </td>
          <!--列の合計-->
          <td id="sumCell">
            <xsl:attribute name="nowrap" />
            <xsl:attribute name="value">
              <xsl:value-of select="sum(*)"/>
            </xsl:attribute>
            <xsl:variable name="社員工数" select="sum(../項目[@name='社員工数' and @mode='予測']/月)"/>
            <xsl:variable name="パート工数" select="sum(../項目[@name='パート工数' and @mode='予測']/月)"/>
            <xsl:variable name="協力工数" select="sum(../項目[@name='協力工数' and @mode='予測']/月)"/>
            <xsl:variable name="工数合計" select="$社員工数 + $パート工数 + $協力工数"/>
            <xsl:if test="$工数合計 >= 0">
              <xsl:value-of select="format-number($工数合計 div $unit,$form)"/>
            </xsl:if>
          </td>
          <xsl:call-template name="valueOut_工数合計_Loop">
            <xsl:with-param name="element" select="." />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="begin" select="0" />
            <xsl:with-param name="mCnt" select="$mCnt" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="form" select="$form" />
          </xsl:call-template>
        </tr>
      </xsl:for-each>
  </xsl:template>

  <!--　データ行の表示　-->
  <xsl:template name="valueOut_工数合計_Loop">
    <xsl:param name="item" />
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:param name="mode" />
    <xsl:param name="unit" />
    <xsl:param name="form"/>
    <xsl:if test="$cnt &lt; $max">
      <td id="sumCell">
        <xsl:attribute name="nowrap" />
        <xsl:attribute name="value">
          <xsl:value-of select="月[@m=$cnt]"/>
        </xsl:attribute>
        <xsl:attribute name="m">
          <xsl:value-of select="$cnt"/>
        </xsl:attribute>
        <xsl:variable name="社員工数" select="sum(../項目[@name='社員工数' and @mode='予測']/月[@m=$cnt])"/>
        <xsl:variable name="パート工数" select="sum(../項目[@name='パート工数' and @mode='予測']/月[@m=$cnt])"/>
        <xsl:variable name="協力工数" select="sum(../項目[@name='協力工数' and @mode='予測']/月[@m=$cnt])"/>
        <xsl:variable name="工数合計" select="$社員工数 + $パート工数 + $協力工数"/>
        <xsl:if test="$工数合計 >= 0">
          <xsl:value-of select="format-number($工数合計 div $unit,$form)"/>
        </xsl:if>
      </td>
      <xsl:call-template name="valueOut_工数合計_Loop">
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


  <xsl:template name="value_Out">
    <xsl:param name="form" />
    <xsl:param name="value" />
    <xsl:choose>
      <xsl:when test="$value = 0">
        <xsl:value-of select="'　'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="format-number($value,$form)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
