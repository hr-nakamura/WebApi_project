<?xml version="1.0" encoding="shift_jis" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:user="mynamespace">

	<!--	xmlns:msxsl="urn:schemas-microsoft-com:xslt"	-->
	<!--      xmlns:user="http://mycompany.com/mynamespace">	-->

  <xsl:variable name="年度"><xsl:value-of select="/root/全体/年度"/></xsl:variable>
  <xsl:variable name="開始年"><xsl:value-of select="/root/全体/開始年"/></xsl:variable>
  <xsl:variable name="開始月"><xsl:value-of select="/root/全体/開始月"/></xsl:variable>
  <xsl:variable name="月数"><xsl:value-of select="/root/全体/月数"/></xsl:variable>
  <!--<xsl:variable name="営業日"><xsl:value-of select="/root/全体/営業日"/></xsl:variable>-->
  <xsl:variable name="partUnit"><xsl:value-of select="0.03"/></xsl:variable>

  <!--<xsl:variable name="対象">
    <xsl:value-of select="/root/全体/表示"/>
  </xsl:variable>-->
  <xsl:variable name="対象">
    <xsl:value-of select="'計画'"/>
  </xsl:variable>
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
    <xsl:if test="count(全体/グループ) = 0">
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="'データはありません'"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>

    <xsl:if test="count(全体/グループ) > 0">
      <center>
      <xsl:value-of select="$対象"/>
      </center>
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="本社費"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="80%" size="5" color="blue"/>
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="売上"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="売上付替"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="販管費">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="費用付替"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="売上原価">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="営業外収益">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="営業外費用">
                <xsl:with-param name="item" select="'*'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
    </xsl:if>

  </xsl:template>


  <!-- ########################################################### -->

  <xsl:template match="全体" mode="本社費">
    <xsl:variable name="element予算" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/予算/項目[@name='予算']" />
    <xsl:variable name="element売上" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/売上高/項目[@name='売上']" />
    <xsl:variable name="element売上付替" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/売上付替/項目[*]" />
    <xsl:variable name="element売上原価" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/売上原価/項目[*]" />
    <xsl:variable name="element販管費" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/販管費/項目[*]" />
    <xsl:variable name="element費用付替" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/費用付替/項目[*]" />
    <xsl:variable name="element営業外費用" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/営業外費用/項目[*]" />
    <xsl:variable name="element営業外収益" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/営業外収益/項目[*]" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'本社費配賦額'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--予算-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'本社費用・予算(計画)'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element予算" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--売上計画-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'本社売上(計画)'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element売上" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--売上付替-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'売上付替'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element売上付替" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--営業外収益-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'営業外収益'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element営業外収益" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--売上原価-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'売上原価'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element売上原価" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--販管費-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'販管費'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element販管費" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--費用付替-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'費用付替'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element費用付替" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--営業外費用-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'営業外費用'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="valueOut_Loop_項目">
            <xsl:with-param name="element" select="$element営業外費用" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--本社費-->
      <!--<tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'本社費計算'"/>
          </td>
          --><!-- データを表示--><!--
          <xsl:call-template name="本社費_valueOut_Loop_計算">
            <xsl:with-param name="element予算" select="$element予算" />
            <xsl:with-param name="element売上" select="$element売上" />
            <xsl:with-param name="element売上付替" select="$element売上付替" />
            <xsl:with-param name="element売上原価" select="$element売上原価" />
            <xsl:with-param name="element販管費" select="$element販管費" />
            <xsl:with-param name="element費用付替" select="$element費用付替" />
            <xsl:with-param name="element営業外費用" select="$element営業外費用" />
            <xsl:with-param name="element営業外収益" select="$element営業外収益" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>-->
    </table>
    <hr width="50%"/>

    <!--本社費-->
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'本社費配賦額'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
    <!--本社費-->
      <tbody>
        <tr class='userType'>
          <td colspan="2" style='text-align:left;'>
            <xsl:value-of select="'本社費出(売上原価+販管費-費用付替+営業外費用)'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="本社費_valueOut_Loop_計算_出">
            <xsl:with-param name="element予算" select="$element予算" />
            <xsl:with-param name="element売上" select="$element売上" />
            <xsl:with-param name="element売上付替" select="$element売上付替" />
            <xsl:with-param name="element売上原価" select="$element売上原価" />
            <xsl:with-param name="element販管費" select="$element販管費" />
            <xsl:with-param name="element費用付替" select="$element費用付替" />
            <xsl:with-param name="element営業外費用" select="$element営業外費用" />
            <xsl:with-param name="element営業外収益" select="$element営業外収益" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <tbody>
        <tr class='groupType'>
          <td colspan="2" style='text-align:left;'>
            <xsl:value-of select="'本社費入(売上+売上付替+営業外収益)'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="本社費_valueOut_Loop_計算_入">
            <xsl:with-param name="element予算" select="$element予算" />
            <xsl:with-param name="element売上" select="$element売上" />
            <xsl:with-param name="element売上付替" select="$element売上付替" />
            <xsl:with-param name="element売上原価" select="$element売上原価" />
            <xsl:with-param name="element販管費" select="$element販管費" />
            <xsl:with-param name="element費用付替" select="$element費用付替" />
            <xsl:with-param name="element営業外費用" select="$element営業外費用" />
            <xsl:with-param name="element営業外収益" select="$element営業外収益" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="valueOut_Loop_項目">
    <xsl:param name="element" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="yosoku">
          <xsl:variable name="sumVal" select="sum($element/月[@m=$m])" />
          <xsl:variable name="mode" select="$element/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="valueOut_Loop_項目">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($element/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="本社費_valueOut_Loop_計算">
    <xsl:param name="element予算" />
    <xsl:param name="element売上" />
    <xsl:param name="element売上付替" />
    <xsl:param name="element売上原価" />
    <xsl:param name="element販管費" />
    <xsl:param name="element費用付替" />
    <xsl:param name="element営業外費用" />
    <xsl:param name="element営業外収益" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td>
          <!--<xsl:variable name="sumVal予算" select="sum($element予算/月[@m=$m])" />-->
          <xsl:variable name="sumVal予算" select="0" />
          <xsl:variable name="sumVal入" select="sum($element売上/月[@m=$m])+sum($element売上付替/月[@m=$m])+sum($element営業外収益/月[@m=$m])" />
          <xsl:variable name="sumVal出" select="sum($element売上原価/月[@m=$m])+sum($element販管費/月[@m=$m])-sum($element費用付替/月[@m=$m])+sum($element営業外費用/月[@m=$m])" />
          <xsl:variable name="sumVal" select="$sumVal予算 + $sumVal入 - $sumVal出" />
          <xsl:variable name="mode" select="$element予算/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
s            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="本社費_valueOut_Loop_計算">
          <xsl:with-param name="element予算" select="$element予算" />
          <xsl:with-param name="element売上" select="$element売上" />
          <xsl:with-param name="element売上付替" select="$element売上付替" />
          <xsl:with-param name="element売上原価" select="$element売上原価" />
          <xsl:with-param name="element販管費" select="$element販管費" />
          <xsl:with-param name="element費用付替" select="$element費用付替" />
          <xsl:with-param name="element営業外費用" select="$element営業外費用" />
          <xsl:with-param name="element営業外収益" select="$element営業外収益" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal予算" select="sum($element予算/月)" />-->
          <xsl:variable name="sumVal予算" select="0" />
          <xsl:variable name="sumVal入" select="sum($element売上/月)+sum($element売上付替/月)+sum($element営業外収益/月)" />
          <xsl:variable name="sumVal出" select="sum($element売上原価/月)+sum($element販管費/月)-sum($element費用付替/月)+sum($element営業外費用/月)" />
          <xsl:variable name="sumVal" select="$sumVal予算 + $sumVal入 - $sumVal出" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="本社費_valueOut_Loop_計算_入">
    <xsl:param name="element予算" />
    <xsl:param name="element売上" />
    <xsl:param name="element売上付替" />
    <xsl:param name="element売上原価" />
    <xsl:param name="element販管費" />
    <xsl:param name="element費用付替" />
    <xsl:param name="element営業外費用" />
    <xsl:param name="element営業外収益" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td>
          <!--<xsl:variable name="sumVal予算" select="sum($element予算/月[@m=$m])" />-->
          <xsl:variable name="sumVal予算" select="0" />
          <xsl:variable name="sumVal入" select="sum($element売上/月[@m=$m])+sum($element売上付替/月[@m=$m])+sum($element営業外収益/月[@m=$m])" />
          <xsl:variable name="sumVal出" select="0" />
          <xsl:variable name="sumVal" select="$sumVal出 - ($sumVal予算 + $sumVal入)" />
          <xsl:variable name="mode" select="$element予算/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="本社費_valueOut_Loop_計算_入">
          <xsl:with-param name="element予算" select="$element予算" />
          <xsl:with-param name="element売上" select="$element売上" />
          <xsl:with-param name="element売上付替" select="$element売上付替" />
          <xsl:with-param name="element売上原価" select="$element売上原価" />
          <xsl:with-param name="element販管費" select="$element販管費" />
          <xsl:with-param name="element費用付替" select="$element費用付替" />
          <xsl:with-param name="element営業外費用" select="$element営業外費用" />
          <xsl:with-param name="element営業外収益" select="$element営業外収益" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal予算" select="sum($element予算/月)" />-->
          <xsl:variable name="sumVal予算" select="0" />
          <xsl:variable name="sumVal入" select="sum($element売上/月)+sum($element売上付替/月)+sum($element営業外収益/月)" />
          <xsl:variable name="sumVal出" select="0" />
          <xsl:variable name="sumVal" select="$sumVal出 - ($sumVal予算 + $sumVal入)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="本社費_valueOut_Loop_計算_出">
    <xsl:param name="element予算" />
    <xsl:param name="element売上" />
    <xsl:param name="element売上付替" />
    <xsl:param name="element売上原価" />
    <xsl:param name="element販管費" />
    <xsl:param name="element費用付替" />
    <xsl:param name="element営業外費用" />
    <xsl:param name="element営業外収益" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td>
          <!--<xsl:variable name="sumVal予算" select="sum($element予算/月[@m=$m])" />-->
          <xsl:variable name="sumVal予算" select="0" />
          <xsl:variable name="sumVal入" select="0" />
          <xsl:variable name="sumVal出" select="sum($element売上原価/月[@m=$m])+sum($element販管費/月[@m=$m])-sum($element費用付替/月[@m=$m])+sum($element営業外費用/月[@m=$m])" />
          <xsl:variable name="sumVal" select="$sumVal出 - ($sumVal予算 + $sumVal入)" />
          <xsl:variable name="mode" select="$element予算/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="本社費_valueOut_Loop_計算_出">
          <xsl:with-param name="element予算" select="$element予算" />
          <xsl:with-param name="element売上" select="$element売上" />
          <xsl:with-param name="element売上付替" select="$element売上付替" />
          <xsl:with-param name="element売上原価" select="$element売上原価" />
          <xsl:with-param name="element販管費" select="$element販管費" />
          <xsl:with-param name="element費用付替" select="$element費用付替" />
          <xsl:with-param name="element営業外費用" select="$element営業外費用" />
          <xsl:with-param name="element営業外収益" select="$element営業外収益" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal予算" select="sum($element予算/月)" />-->
          <xsl:variable name="sumVal予算" select="0" />
          <xsl:variable name="sumVal入" select="0" />
          <xsl:variable name="sumVal出" select="sum($element売上原価/月)+sum($element販管費/月)-sum($element費用付替/月)+sum($element営業外費用/月)" />
          <xsl:variable name="sumVal" select="$sumVal出 - ($sumVal予算 + $sumVal入)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ########################################################### -->


  <xsl:template match="全体" mode="売上付替">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'売上付替'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--各部門のデータ表示-->
      <xsl:for-each select="グループ[(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="売上付替_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="売上付替_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="売上付替_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/売上付替/項目[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/月[@m=$m])" />
          <xsl:variable name="mode" select="$elementA/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="売上付替_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="全体" mode="営業外収益">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'営業外収益'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--各部門のデータ表示-->
      <xsl:for-each select="グループ[(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="営業外収益_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="営業外収益_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="営業外収益_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/営業外収益/項目[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/月[@m=$m])" />
          <xsl:variable name="mode" select="$elementA/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="営業外収益_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="全体" mode="営業外費用">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'営業外費用'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--各部門のデータ表示-->
      <xsl:for-each select="グループ[(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="営業外費用_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="営業外費用_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="営業外費用_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/営業外費用/項目[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/月[@m=$m])" />
          <xsl:variable name="mode" select="$elementA/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="営業外費用_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementA/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="全体" mode="販管費">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'販管費'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--各部門のデータ表示-->
      <xsl:for-each select="グループ[(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="販管費_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="販管費_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="販管費_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/販管費/項目" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/月[@m=$m])" />
          <xsl:variable name="mode" select="$elementX/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="販管費_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="item" select="$item" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="全体" mode="売上原価">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'売上原価'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--各部門のデータ表示-->
      <xsl:for-each select="グループ[(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="外注費_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="外注費_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="外注費_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/売上原価/項目" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/月[@m=$m])" />
          <xsl:variable name="mode" select="$elementX/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="外注費_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="item" select="$item" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="全体" mode="費用付替">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'費用付替'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--各部門のデータ表示-->
      <xsl:for-each select="グループ[(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="費用付替_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="費用付替_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="費用付替_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/費用付替/項目[*]" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/月[@m=$m])" />
          <xsl:variable name="mode" select="$elementX/../../月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$mode='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$mode='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="費用付替_valueOut_Loop">
          <xsl:with-param name="element" select="$element" />
          <xsl:with-param name="item" select="$item" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($elementX/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="全体" mode="売上">
    <xsl:param name="item" select="'売上'" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'売上'"/>
      </caption>
      <thead>
        <tr bgcolor='#aac2ea'>
          <th rowspan="2" colspan="2" width="160">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'項　目'"/>
          </th>
          <xsl:call-template name="year_Loop">
            <xsl:with-param name="year" select="$開始年" />
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
          <th rowspan="2" width="70">
            <xsl:attribute name="nowrap" />
            <xsl:value-of select="'合　計'"/>
          </th>
        </tr>
        <tr bgcolor='#aac2ea'>
          <xsl:call-template name="month_Loop">
            <xsl:with-param name="begin" select="$開始月" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </thead>
      <!--各部門のデータ表示-->
      <xsl:for-each select="グループ[(starts-with(名前,'本社'))]">
        <xsl:variable name="データ" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="valueOut_Loop">
              <xsl:with-param name="項目" select="$データ/売上高/項目[@name=$item]" />
              <xsl:with-param name="月情報" select="$データ/月情報" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="データ" select="グループ[(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
           <!--データを表示-->
          <xsl:call-template name="valueOut_Loop">
            <xsl:with-param name="項目" select="$データ/売上高/項目[@name=$item]" />
            <xsl:with-param name="月情報" select="$データ/月情報" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="valueOut_Loop">
    <xsl:param name="項目" />
    <xsl:param name="月情報" />
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="0" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="unit" select="1000" />
    <xsl:param name="form" select="'#,##0'"/>
    <xsl:choose>
      <xsl:when test="$m &lt; $max">
        <!-- 各月のデータを表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($項目/月[@m=$m])" />
          <xsl:variable name="modeValue" select="$月情報/月[@m=$m]" />
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$modeValue='実績'">
                <!-- - 実績-->
                <xsl:value-of select="'actual'"/>
              </xsl:when>
              <xsl:when test="$modeValue='予測'">
                <!-- - 予測-->
                <xsl:value-of select="'yosoku'"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- - 計画-->
                <xsl:value-of select="'target'"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="valueOut_Loop">
          <xsl:with-param name="項目" select="$項目" />
          <xsl:with-param name="月情報" select="$月情報" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <xsl:variable name="sumVal" select="sum($項目/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!--		-->
  <xsl:include href="sub_cmn.xsl"/>
  <xsl:include href="sub_JScript.xsl"/>

</xsl:stylesheet>
