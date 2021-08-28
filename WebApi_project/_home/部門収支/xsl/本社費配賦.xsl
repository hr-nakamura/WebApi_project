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

  <xsl:variable name="対象"><xsl:value-of select="/root/全体/表示"/></xsl:variable>
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
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="本社費配賦元金額"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="部門固定費"/>
            </td>
          </tr>
        </tbody>
      </table>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <!--<xsl:apply-templates select="全体" mode="本社費配賦">
                <xsl:with-param name="item" select="'本社費'" />
              </xsl:apply-templates>-->
              <xsl:apply-templates select="全体" mode="本社費分配額"/>
            </td>
          </tr>
        </tbody>
      </table>
      <br/>
      <br/>
      <hr width="50%" />
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="本社費対象費用"/>
            </td>
          </tr>
        </tbody>
      </table>
      <br/>
      <br/>
      <hr width="80%" size="4" color="blue"/>
      <table border="0" align="center">
        <tbody>
          <tr>
            <td>
              <xsl:apply-templates select="全体" mode="販管費">
                <xsl:with-param name="item" select="'人件費'" />
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
              <xsl:apply-templates select="全体" mode="固定費">
                <xsl:with-param name="item" select="'人件費'" />
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
              <xsl:apply-templates select="全体" mode="販管費">
              <xsl:with-param name="item" select="'雑給'" />
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
              <xsl:apply-templates select="全体" mode="売上原価">
                <xsl:with-param name="item" select="'外注費'" />
              </xsl:apply-templates>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>

  </xsl:template>


  <!-- ########################################################### -->



  <xsl:template match="全体" mode="本社費対象費用">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'本社費対象費用'"/>
        <br/>
        <xsl:value-of select="'(販管費の人件費×1.0)＋(部門固定費の人件費×1.0)＋(販管費の雑給×0.03)＋(売上原価の外注費×0.03)'"/>
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
      <xsl:for-each select="グループ[not(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="本社費対象費用_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[not(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="本社費対象費用_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="本社費対象費用_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/販管費/項目[@name='人件費']" />
    <xsl:param name="elementB" select="$element/部門固定費/項目[@name='人件費']" />
    <xsl:param name="elementC" select="$element/販管費/項目[@name='雑給']" />
    <xsl:param name="elementD" select="$element/売上原価/項目[@name='外注費']" />
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
          <xsl:variable name="sumVal" select="sum($elementA/月[@m=$m])+sum($elementB/月[@m=$m])+(sum($elementC/月[@m=$m])*$partUnit)+(sum($elementD/月[@m=$m])*$partUnit)" />
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
        <xsl:call-template name="本社費対象費用_valueOut_Loop">
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
          <xsl:variable name="sumVal" select="sum($elementA/月)+sum($elementB/月)+(sum($elementC/月)*$partUnit)+(sum($elementD/月)*$partUnit)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose> 
  </xsl:template>

  <xsl:template match="全体" mode="部門固定費">
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'部門固定費'"/>
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
      <xsl:for-each select="グループ[not(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="部門固定費_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="'$item'" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[not(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="部門固定費_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="部門固定費_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="elementA" select="$element/部門固定費/項目[*]" />
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
        <xsl:call-template name="部門固定費_valueOut_Loop">
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


  <xsl:template match="全体" mode="本社費配賦元金額">
    <xsl:variable name="elementA" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/予算/項目[@name='予算']" />
    <xsl:variable name="elementB" select="グループ[(starts-with(名前,'本社'))]/データ[@name='計画']/売上高/項目[@name='売上']" />
    <xsl:variable name="elementC" select="グループ[not(starts-with(名前,'本社'))]/データ[@name=$対象]/部門固定費/項目[*]" />
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
          <xsl:call-template name="計画_valueOut_Loop_項目">
            <xsl:with-param name="element" select="$elementA" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--売上計画-->
      <!--<tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'本社売上(計画)'"/>
          </td>
          <xsl:call-template name="計画_valueOut_Loop_項目">
            <xsl:with-param name="element" select="$elementB" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>-->
      <!--部門固定費-->
      <tbody>
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'部門固定費'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="部門固定費_valueOut_Loop_項目">
            <xsl:with-param name="element" select="$elementC" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
      <!--本社費-->
      <tbody>
        <tr class='userType'>
          <td colspan="2">
            <xsl:value-of select="'本社費配賦額'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="本社費_valueOut_Loop_計算">
            <xsl:with-param name="elementA" select="$elementA" />
            <!--<xsl:with-param name="elementB" select="$elementB" />-->
            <xsl:with-param name="elementC" select="$elementC" />
            <xsl:with-param name="item" select="'$item'" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="計画_valueOut_Loop_項目">
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
        <td class="target">
          <xsl:variable name="sumVal" select="sum($element/月[@m=$m])" />
          <xsl:choose>
            <xsl:when test="$sumVal = 0">
              <xsl:value-of select="'　'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <xsl:call-template name="計画_valueOut_Loop_項目">
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

  <xsl:template name="部門固定費_valueOut_Loop_項目">
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
        <xsl:call-template name="部門固定費_valueOut_Loop_項目">
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
    <xsl:param name="elementA" />
    <xsl:param name="elementB" />
    <xsl:param name="elementC" />
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
          <!--<xsl:variable name="sumVal" select="sum($elementA/月[@m=$m])-sum($elementB/月[@m=$m])-sum($elementC/月[@m=$m])" />-->
          <xsl:variable name="sumVal" select="sum($elementA/月[@m=$m])-sum($elementC/月[@m=$m])" />
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
        <xsl:call-template name="本社費_valueOut_Loop_計算">
          <xsl:with-param name="elementA" select="$elementA" />
          <xsl:with-param name="elementB" select="$elementB" />
          <xsl:with-param name="elementC" select="$elementC" />
          <xsl:with-param name="max" select="$max" />
          <xsl:with-param name="m" select="$m + 1" />
          <xsl:with-param name="unit" select="$unit" />
          <xsl:with-param name="form" select="$form" />
        </xsl:call-template>

      </xsl:when>
      <xsl:otherwise>
        <!-- １２カ月分の合計を表示-->
        <td class="groupTypeData">
          <!--<xsl:variable name="sumVal" select="sum($elementA/月)-sum($elementB/月)-sum($elementC/月)" />-->
          <xsl:variable name="sumVal" select="sum($elementA/月)-sum($elementC/月)" />
          <xsl:value-of select="format-number($sumVal div $unit ,$form)"/>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="全体" mode="販管費">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'販管費の'"/>
        <xsl:value-of select="$item"/>
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
      <xsl:for-each select="グループ[not(starts-with(名前,'本社'))]">
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
        <xsl:variable name="element" select="グループ[not(starts-with(名前,'本社'))]/データ[@name=$対象]" />
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
    <xsl:param name="elementX" select="$element/販管費/項目[@name=$item]" />
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
        <xsl:value-of select="'売上原価の'"/>
        <xsl:value-of select="$item"/>
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
      <xsl:for-each select="グループ[not(starts-with(名前,'本社'))]">
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
        <xsl:variable name="element" select="グループ[not(starts-with(名前,'本社'))]/データ[@name=$対象]" />
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
    <xsl:param name="elementX" select="$element/売上原価/項目[@name=$item]" />
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

  <xsl:template match="全体" mode="固定費">
    <xsl:param name="item" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'部門固定費の'"/>
        <xsl:value-of select="$item"/>
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
      <xsl:for-each select="グループ[not(starts-with(名前,'本社'))]">
        <xsl:variable name="element" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="固定費_valueOut_Loop">
              <xsl:with-param name="element" select="$element" />
              <xsl:with-param name="item" select="$item" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="element" select="グループ[not(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
          <!-- データを表示-->
          <xsl:call-template name="固定費_valueOut_Loop">
            <xsl:with-param name="element" select="$element" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="mCnt" select="$月数" />
          </xsl:call-template>
        </tr>
      </tbody>
    </table>
  </xsl:template>


  <xsl:template name="固定費_valueOut_Loop">
    <xsl:param name="element" />
    <xsl:param name="item" />
    <xsl:param name="elementX" select="$element/部門固定費/項目[@name=$item]" />
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
        <xsl:call-template name="固定費_valueOut_Loop">
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

  <xsl:template match="全体" mode="本社費分配額">
    <xsl:param name="item" select="'本社費'" />
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption>
        <xsl:value-of select="'本社費分配額'"/>
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
      <xsl:for-each select="グループ[not(starts-with(名前,'本社'))]">
        <xsl:variable name="データ" select="データ[@name=$対象]" />
        <tbody>
          <tr class='groupType'>
            <td colspan="2" style="text-align:left;">
              <xsl:value-of select="名前"/>
            </td>
            <!-- データを表示-->
            <xsl:call-template name="valueOut_Loop">
              <xsl:with-param name="項目" select="$データ/本社費配賦/項目[@name=$item]" />
              <xsl:with-param name="月情報" select="$データ/月情報" />
              <xsl:with-param name="mCnt" select="$月数" />
            </xsl:call-template>
          </tr>
        </tbody>
      </xsl:for-each>
      <!--全部門の合計-->
      <tbody>
        <xsl:variable name="データ" select="グループ[not(starts-with(名前,'本社'))]/データ[@name=$対象]" />
        <tr class='groupType'>
          <td colspan="2">
            <xsl:value-of select="'合　計'"/>
          </td>
           <!--データを表示-->
          <xsl:call-template name="valueOut_Loop">
            <xsl:with-param name="項目" select="$データ/本社費配賦/項目[@name=$item]" />
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
