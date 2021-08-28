<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">	


  <xsl:variable name="年度"><xsl:value-of select="/root/全体/年度"/></xsl:variable>
  <xsl:variable name="開始年"><xsl:value-of select="/root/全体/開始年"/></xsl:variable>
  <xsl:variable name="開始月"><xsl:value-of select="/root/全体/開始月"/></xsl:variable>
  <xsl:variable name="月数"><xsl:value-of select="/root/全体/月数"/></xsl:variable>
  <xsl:variable name="営業日"><xsl:value-of select="/root/全体/営業日"/></xsl:variable>
  <xsl:variable name="実績日付"><xsl:value-of select="/root/全体/実績日付"/></xsl:variable>
  <xsl:variable name="確度"><xsl:value-of select="/root/全体/確度"/></xsl:variable>
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
      <table border="0" align="center">
        <tbody>
        <tr>
          <td>
            <xsl:apply-templates select="全体"/>
          </td>
        </tr>
      </tbody>
    </table>
    </xsl:if>

  </xsl:template>


  <!-- ########################################################### -->


  <xsl:template match="全体">
    <xsl:apply-templates select="グループ"/>
  </xsl:template>

  <xsl:template match="グループ">
    <xsl:apply-templates select="データ"/>
    <xsl:if test="position() != last()">
      <br/>
      <hr width="70%"/>
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="データ">
    <xsl:variable name="名前">
      <xsl:value-of select="../名前"/>
    </xsl:variable>
    <xsl:variable name="部署コード">
      <xsl:value-of select="../部署コード"/>
    </xsl:variable>
    <xsl:variable name="種別">
      <xsl:value-of select="../@kind"/>
    </xsl:variable>
    <table class="table" width="100%" border="1" CELLPADDING="0" CELLSPACING="0">
      <caption ID="GRP">
        <xsl:attribute name="dispName">
          <xsl:value-of select="$名前"/>
        </xsl:attribute>
        <xsl:attribute name="gCode">
          <xsl:value-of select="$部署コード"/>
        </xsl:attribute>
        <big>
          <strong>
            <xsl:if test="@name = '結合'">
              <xsl:value-of select="$名前"/>
              <br/>
            </xsl:if>
            <xsl:value-of select="$年度"/>年度
            <xsl:value-of select="表題"/>
            <xsl:call-template name="ランク"/>
          </strong>
        </big>
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
      <tbody>
        <xsl:apply-templates select="予算"/>
      </tbody>
      <tbody id="onUriage">
        <xsl:apply-templates select="売上高"/>
      </tbody>
      <tbody id="onUriage" mode="累計" style="display:none">
        <xsl:apply-templates select="売上高" mode="累計"/>
      </tbody>
      <tbody id="onCost1">
        <xsl:apply-templates select="売上付替"/>
      </tbody>
      <tbody id="onCost1" mode="詳細" style="display:none">
        <xsl:apply-templates select="売上付替" mode="詳細"/>
      </tbody>
      <xsl:if test="売上付替">
        <tbody id="onSales" name="売上合計">
          <xsl:call-template name="売上合計"/>
        </tbody>
        <tbody id="onSales" name="売上合計" mode="詳細" style="display:none">
          <xsl:call-template name="売上合計_詳細"/>
        </tbody>
      </xsl:if>
      <tbody id="onGenka">
        <xsl:apply-templates select="売上原価"/>
      </tbody>
      <tbody id="onGenka" mode="詳細" style="display:none">
        <xsl:apply-templates select="売上原価" mode="詳細"/>
      </tbody>
      <tbody id="onKei1">
        <xsl:call-template name="売上総損益"/>
      </tbody>
      <tbody id="onKei1" mode="詳細" style="display:none">
        <xsl:call-template name="売上総損益_詳細"/>
      </tbody>
      <tbody id="onKanriHi">
        <xsl:apply-templates select="販管費"/>
      </tbody>
      <tbody id="onKanriHi" mode="詳細" style="display:none">
        <xsl:apply-templates select="要員数"/>
        <xsl:apply-templates select="販管費" mode="詳細"/>
      </tbody>
      <tbody id="onCost2">
        <xsl:apply-templates select="費用付替"/>
      </tbody>
      <tbody id="onCost2" mode="詳細" style="display:none">
        <xsl:apply-templates select="費用付替" mode="詳細"/>
      </tbody>
      <tbody>
        <xsl:apply-templates select="部門固定費"/>
      </tbody>
      <tbody id="onKei2">
        <xsl:call-template name="営業利益"/>
      </tbody>
      <tbody id="onKei2" mode="詳細" style="display:none">
        <xsl:call-template name="営業利益_詳細"/>
      </tbody>
      <tbody>
        <xsl:apply-templates select="営業外収益"/>
        <xsl:apply-templates select="営業外費用"/>
      </tbody>
      <tbody>
        <xsl:apply-templates select="本社費配賦"/>
      </tbody>
      <tbody id="onKei3">
        <xsl:call-template name="経常利益"/>
      </tbody>
      <tbody id="onKei3" mode="詳細" style="display:none">
        <xsl:call-template name="経常利益_詳細"/>
      </tbody>
      <tbody>
        <xsl:call-template name="経常利益_累計"/>
      </tbody>
    </table>
    <xsl:if test="@name='結合'">
      <table align="center" CELLPADDING="0" CELLSPACING="0" >
        <tbody>
          <tr>
            <td class="actual">
              <small>
                <xsl:value-of select="'実績：黒の数字'"/>
              </small>
            </td>
            <td class="yosoku">
              <small>
                <xsl:value-of select="'予測：青の数字'"/>
              </small>
            </td>
            <td class="target">
              <small>
                <xsl:value-of select="'計画：緑の数字'"/>
              </small>
            </td>
          </tr>
        </tbody>
        <tbody>
          <tr>
            <td colspan="3" align="center">
              <small>
                <xsl:value-of select="$実績日付"/>
              </small>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
    <xsl:if test="position() != last()">
      <br/>
      <hr width="50%"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="ランク">
    <xsl:choose>
      <xsl:when test="$確度=30">
        <xsl:value-of select="'　（Ｃ）'"/>
      </xsl:when>
      <xsl:when test="$確度=50">
        <xsl:value-of select="'　（Ｂ）'"/>
      </xsl:when>
      <xsl:when test="$確度=70">
        <!--<xsl:value-of select="'　（Ａ）'"/>-->
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <!--<xsl:value-of select="$確度"/>-->
  </xsl:template>


  <!-- １行の表示(各月＋合計) -->
  <xsl:template name="項目行">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="mode" />
    <xsl:for-each select="項目[1]">
      <xsl:for-each select="月">
        <td>
          <xsl:apply-templates select=".">
            <xsl:with-param name="form" select="$form" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="m" select="@m" />
            <xsl:with-param name="mode" select="$mode" />
          </xsl:apply-templates>
        </td>
      </xsl:for-each>
    </xsl:for-each>
    <td class='secTotal'>
      <xsl:call-template name="項目計">
        <xsl:with-param name="form" select="$form" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="item" select="$item" />
        <xsl:with-param name="mode" select="$mode" />
      </xsl:call-template>
    </td>
  </xsl:template>

  <!-- １行の表示(各月＋合計) -->
  <xsl:template name="項目行_累計">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="mode" />
    <xsl:param name="before" select="0" />
    <xsl:for-each select="項目[1]">
      <xsl:for-each select="月">
        <td>
          <xsl:apply-templates select="." mode="累計">
            <xsl:with-param name="form" select="$form" />
            <xsl:with-param name="unit" select="$unit" />
            <xsl:with-param name="item" select="$item" />
            <xsl:with-param name="m" select="@m" />
            <xsl:with-param name="mode" select="$mode" />
            <xsl:with-param name="before" select="$before" />
          </xsl:apply-templates>
        </td>
      </xsl:for-each>
    </xsl:for-each>
    <td class='secTotal'>
      <xsl:call-template name="項目計">
        <xsl:with-param name="form" select="$form" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="item" select="$item" />
        <xsl:with-param name="mode" select="$mode" />
      </xsl:call-template>
    </td>
  </xsl:template>

  <!-- 行の合計 -->
  <xsl:template name="項目計">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="mode" />
    <!--<xsl:attribute name="style">
        <xsl:value-of select="'color:tomato'"/>
    </xsl:attribute>-->
    <!--<xsl:value-of select="$item"/>-->
    <!--<xsl:value-of select="local-name()"/>-->
    <xsl:variable name="数値">
      <xsl:value-of select="format-number((sum(項目[starts-with(@name,$item)]/月) div $unit) * number($mode),$form)"/>
    </xsl:variable>
    <xsl:if test="$数値=''">
      <xsl:value-of select="'0'"/>
    </xsl:if>
    <xsl:value-of select="$数値"/>
  </xsl:template>

  <!-- 行の各月 -->
  <xsl:template match="月">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="m" />
    <xsl:param name="mode" />
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="../../../月情報/月[@m=$m]='実績' and $item != '予算'">
          <!-- - 実績-->
          <xsl:value-of select="'actual'"/>
        </xsl:when>
        <xsl:when test="../../../月情報/月[@m=$m]='予測' and $item != '予算'">
          <!-- - 予測-->
          <xsl:value-of select="'yosoku'"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- - 計画-->
          <xsl:value-of select="'target'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:variable name="数値">
      <xsl:value-of select="format-number((sum(../../項目[starts-with(@name,$item)]/月[@m=$m]) div $unit) * number($mode),$form)"/>
    </xsl:variable>
    <xsl:if test="$数値=''">
      <xsl:value-of select="'　'"/>
    </xsl:if>
    <xsl:value-of select="$数値"/>

  </xsl:template>

  <xsl:template match="月" mode="累計">
    <xsl:param name="form" />
    <xsl:param name="unit" />
    <xsl:param name="item" />
    <xsl:param name="m" />
    <xsl:param name="mode" />
    <xsl:param name="before" />
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="../../../月情報/月[@m=$m]='実績' and $item != '予算'">
          <!-- - 実績-->
          <xsl:value-of select="'actual'"/>
        </xsl:when>
        <xsl:when test="../../../月情報/月[@m=$m]='予測' and $item != '予算'">
          <!-- - 予測-->
          <xsl:value-of select="'yosoku'"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- - 計画-->
          <xsl:value-of select="'target'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:variable name="数値">
      <xsl:value-of select="format-number((sum(../../項目[starts-with(@name,$item)]/月[@m &lt;= $m]) div $unit) * number($mode),$form)"/>
    </xsl:variable>
    <xsl:if test="$数値=''">
      <xsl:value-of select="'　'"/>
    </xsl:if>
    <xsl:value-of select="$数値"/>

  </xsl:template>


  <xsl:template match="予算">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'予算(計画)'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'予算'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="売上高">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'売上高'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'売上'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="売上高" mode="累計">
    <tr>
      <td class='userType' colspan="2" rowspan="2">
        <xsl:value-of select="'売上高'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'売上'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <xsl:call-template name="項目行_累計">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'売上'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <!-- 詳細表示行-->
  <xsl:template match="売上付替" mode="詳細">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' rowspan="3">
        <xsl:value-of select="'売上付替'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'入'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'収入'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'出'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'支出'" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'小　計'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,##0'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <!-- 簡易表示行-->
  <xsl:template match="売上付替">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'売上付替'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="費用付替" mode="詳細">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <!-- 詳細表示行-->
    <tr>
      <td class='userType' rowspan="3">
        <xsl:value-of select="'費用付替'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'入'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'収入'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'出'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'支出'" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'小　計'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,##0'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>

  </xsl:template>
  <!-- 簡易表示行-->

  <xsl:template match="費用付替">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'費用付替'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="-1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="売上原価" mode="詳細">
    <!-- 詳細表示行-->
    <tr>
      <td class='userType' rowspan="5">
        <xsl:value-of select="'売上原価'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'外注費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'外注費'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'仕入費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'仕入費'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'期首棚卸'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'期首棚卸'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'期末棚卸'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'期末棚卸'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'小　計'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,##0'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <!-- 簡易表示行-->
  <xsl:template match="売上原価">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'売上原価'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="要員数">
    <tr>
      <td class='userType' rowspan="2">
        <xsl:value-of select="'要員数'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'社員'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="item" select="'社員'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'パート'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="item" select="'パート'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>


  <xsl:template match="販管費" mode="詳細">
    <!-- 詳細表示行-->
    <tr>
      <td class='userType' rowspan="12">
        <xsl:value-of select="'販管費'"/>
      </td>
      <td class='userType'>
        <xsl:value-of select="'人件費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'人件費'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'雑給'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'雑給'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'広告交際費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'広告交際'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'旅費交通費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'交通費'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'通信費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'通信費'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'荷造発送費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'発送費'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'備品・マシン'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'備品'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'設備・リース費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'設備費'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'家賃等'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'家賃'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'その他'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'その他'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
    <tr>
      <td class='userType'>
        <xsl:value-of select="'EMG間費用'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="'EMG間費用'" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

    <tr>
      <td class='userType'>
        <xsl:value-of select="'小　計'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="販管費">
    <!-- 簡易表示行-->
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'販管費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>

  </xsl:template>

  <xsl:template match="部門固定費">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'部門固定費'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="本社費配賦">
    <xsl:if test="@disp=0">
      <xsl:attribute name="style">
        <xsl:value-of select="'display=none'"/>
      </xsl:attribute>
    </xsl:if>
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'本社費配賦'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="営業外収益">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'営業外収益'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template match="営業外費用">
    <tr>
      <td class='userType' colspan="2">
        <xsl:value-of select="'営業外費用'"/>
      </td>
      <xsl:call-template name="項目行">
        <xsl:with-param name="form" select="'#,###'" />
        <xsl:with-param name="unit" select="1000" />
        <xsl:with-param name="item" select="''" />
        <xsl:with-param name="mode" select="1" />
      </xsl:call-template>
    </tr>
  </xsl:template>


  <!-- *****　集計の行 ****************** -->

  <!-- ########## 売上合計 #########-->
  <xsl:template name="売上合計_詳細">
    <xsl:variable name="売上合計_4-1">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 0])+sum(売上高/*/月[floor(@m div 3) = 0])+sum(売上付替/*/月[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="売上合計_4-2">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 1])+sum(売上高/*/月[floor(@m div 3) = 1])+sum(売上付替/*/月[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="売上合計_4-3">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 2])+sum(売上高/*/月[floor(@m div 3) = 2])+sum(売上付替/*/月[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="売上合計_4-4">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 3])+sum(売上高/*/月[floor(@m div 3) = 3])+sum(売上付替/*/月[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="売上合計_6-1">
      <xsl:value-of select="$売上合計_4-1 + $売上合計_4-2"/>
    </xsl:variable>
    <xsl:variable name="売上合計_6-2">
      <xsl:value-of select="$売上合計_4-3 + $売上合計_4-4"/>
    </xsl:variable>
    <xsl:variable name="売上合計_計">
      <xsl:value-of select="$売上合計_6-1 + $売上合計_6-2"/>
    </xsl:variable>
    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'売上合計'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'月　計'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="売上合計_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$売上合計_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($売上合計_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'四半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="売上合計">
    <!-- 簡易表示行-->
    <xsl:variable name="売上合計_計">
      <xsl:value-of select="sum(予算/*/月)+sum(売上高/*/月)+sum(売上付替/*/月)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'売上合計'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="売上合計_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$売上合計_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($売上合計_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$売上合計_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上合計_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>


  </xsl:template>


  <!-- ########## 売上総損益 #########-->
  <xsl:template name="売上総損益_詳細">
    <xsl:variable name="売上総損益_4-1">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 0])+sum(売上高/*/月[floor(@m div 3) = 0])+sum(売上付替/*/月[floor(@m div 3) = 0])-sum(売上原価/*/月[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="売上総損益_4-2">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 1])+sum(売上高/*/月[floor(@m div 3) = 1])+sum(売上付替/*/月[floor(@m div 3) = 1])-sum(売上原価/*/月[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="売上総損益_4-3">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 2])+sum(売上高/*/月[floor(@m div 3) = 2])+sum(売上付替/*/月[floor(@m div 3) = 2])-sum(売上原価/*/月[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="売上総損益_4-4">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 3])+sum(売上高/*/月[floor(@m div 3) = 3])+sum(売上付替/*/月[floor(@m div 3) = 3])-sum(売上原価/*/月[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="売上総損益_6-1">
      <xsl:value-of select="$売上総損益_4-1 + $売上総損益_4-2"/>
    </xsl:variable>
    <xsl:variable name="売上総損益_6-2">
      <xsl:value-of select="$売上総損益_4-3 + $売上総損益_4-4"/>
    </xsl:variable>
    <xsl:variable name="売上総損益_計">
      <xsl:value-of select="$売上総損益_6-1 + $売上総損益_6-2"/>
    </xsl:variable>
    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'売上総損益'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'月　計'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="売上総損益_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])-sum(../../売上原価/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$売上総損益_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($売上総損益_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'四半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="売上総損益">
    <!-- 簡易表示行-->
    <xsl:variable name="売上総損益_計">
      <xsl:value-of select="sum(予算/*/月)+sum(売上高/*/月)+sum(売上付替/*/月)-sum(売上原価/*/月)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'売上総損益'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="売上総損益_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])-sum(../../売上原価/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$売上総損益_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($売上総損益_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$売上総損益_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($売上総損益_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>


  </xsl:template>


  <!-- ########## 営業利益 #########-->
  <xsl:template name="営業利益_詳細">
    <!-- 詳細表示行-->
    <xsl:variable name="営業利益_4-1">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 0])+sum(売上高/*/月[floor(@m div 3) = 0])+sum(売上付替/*/月[floor(@m div 3) = 0])-sum(売上原価/*/月[floor(@m div 3) = 0])-sum(販管費/*/月[floor(@m div 3) = 0])+sum(費用付替/*/月[floor(@m div 3) = 0])-sum(部門固定費/*/月[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="営業利益_4-2">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 1])+sum(売上高/*/月[floor(@m div 3) = 1])+sum(売上付替/*/月[floor(@m div 3) = 1])-sum(売上原価/*/月[floor(@m div 3) = 1])-sum(販管費/*/月[floor(@m div 3) = 1])+sum(費用付替/*/月[floor(@m div 3) = 1])-sum(部門固定費/*/月[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="営業利益_4-3">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 2])+sum(売上高/*/月[floor(@m div 3) = 2])+sum(売上付替/*/月[floor(@m div 3) = 2])-sum(売上原価/*/月[floor(@m div 3) = 2])-sum(販管費/*/月[floor(@m div 3) = 2])+sum(費用付替/*/月[floor(@m div 3) = 2])-sum(部門固定費/*/月[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="営業利益_4-4">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 3])+sum(売上高/*/月[floor(@m div 3) = 3])+sum(売上付替/*/月[floor(@m div 3) = 3])-sum(売上原価/*/月[floor(@m div 3) = 3])-sum(販管費/*/月[floor(@m div 3) = 3])+sum(費用付替/*/月[floor(@m div 3) = 3])-sum(部門固定費/*/月[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="営業利益_6-1">
      <xsl:value-of select="$営業利益_4-1 + $営業利益_4-2"/>
    </xsl:variable>
    <xsl:variable name="営業利益_6-2">
      <xsl:value-of select="$営業利益_4-3 + $営業利益_4-4"/>
    </xsl:variable>
    <xsl:variable name="営業利益_計">
      <xsl:value-of select="$営業利益_6-1 + $営業利益_6-2"/>
    </xsl:variable>
    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'営業利益'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'月　計'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="営業利益_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])-sum(../../売上原価/*/月[@m=$m])-sum(../../販管費/*/月[@m=$m])+sum(../../費用付替/*/月[@m=$m])-sum(../../部門固定費/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$営業利益_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($営業利益_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'四半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="営業利益">
    <!-- 簡易表示行-->
    <xsl:variable name="営業利益_計">
      <xsl:value-of select="sum(予算/*/月)+sum(売上高/*/月)+sum(売上付替/*/月)-sum(売上原価/*/月)-sum(販管費/*/月)+sum(費用付替/*/月)-sum(部門固定費/*/月)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'営業利益'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="営業利益_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])-sum(../../売上原価/*/月[@m=$m])-sum(../../販管費/*/月[@m=$m])+sum(../../費用付替/*/月[@m=$m])-sum(../../部門固定費/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$営業利益_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($営業利益_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$営業利益_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($営業利益_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <!-- ########## 経常利益 #########-->
  <xsl:template name="経常利益_詳細">
    <!-- 詳細表示行-->
    <xsl:variable name="経常利益_4-1">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 0])+sum(売上高/*/月[floor(@m div 3) = 0])+sum(売上付替/*/月[floor(@m div 3) = 0])-sum(売上原価/*/月[floor(@m div 3) = 0])-sum(販管費/*/月[floor(@m div 3) = 0])+sum(費用付替/*/月[floor(@m div 3) = 0])-sum(部門固定費/*/月[floor(@m div 3) = 0])+sum(営業外収益/*/月[floor(@m div 3) = 0])-sum(営業外費用/*/月[floor(@m div 3) = 0])-sum(本社費配賦/*/月[floor(@m div 3) = 0])"/>
    </xsl:variable>
    <xsl:variable name="経常利益_4-2">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 1])+sum(売上高/*/月[floor(@m div 3) = 1])+sum(売上付替/*/月[floor(@m div 3) = 1])-sum(売上原価/*/月[floor(@m div 3) = 1])-sum(販管費/*/月[floor(@m div 3) = 1])+sum(費用付替/*/月[floor(@m div 3) = 1])-sum(部門固定費/*/月[floor(@m div 3) = 1])+sum(営業外収益/*/月[floor(@m div 3) = 1])-sum(営業外費用/*/月[floor(@m div 3) = 1])-sum(本社費配賦/*/月[floor(@m div 3) = 1])"/>
    </xsl:variable>
    <xsl:variable name="経常利益_4-3">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 2])+sum(売上高/*/月[floor(@m div 3) = 2])+sum(売上付替/*/月[floor(@m div 3) = 2])-sum(売上原価/*/月[floor(@m div 3) = 2])-sum(販管費/*/月[floor(@m div 3) = 2])+sum(費用付替/*/月[floor(@m div 3) = 2])-sum(部門固定費/*/月[floor(@m div 3) = 2])+sum(営業外収益/*/月[floor(@m div 3) = 2])-sum(営業外費用/*/月[floor(@m div 3) = 2])-sum(本社費配賦/*/月[floor(@m div 3) = 2])"/>
    </xsl:variable>
    <xsl:variable name="経常利益_4-4">
      <xsl:value-of select="sum(予算/*/月[floor(@m div 3) = 3])+sum(売上高/*/月[floor(@m div 3) = 3])+sum(売上付替/*/月[floor(@m div 3) = 3])-sum(売上原価/*/月[floor(@m div 3) = 3])-sum(販管費/*/月[floor(@m div 3) = 3])+sum(費用付替/*/月[floor(@m div 3) = 3])-sum(部門固定費/*/月[floor(@m div 3) = 3])+sum(営業外収益/*/月[floor(@m div 3) = 3])-sum(営業外費用/*/月[floor(@m div 3) = 3])-sum(本社費配賦/*/月[floor(@m div 3) = 3])"/>
    </xsl:variable>
    <xsl:variable name="経常利益_6-1">
      <xsl:value-of select="$経常利益_4-1 + $経常利益_4-2"/>
    </xsl:variable>
    <xsl:variable name="経常利益_6-2">
      <xsl:value-of select="$経常利益_4-3 + $経常利益_4-4"/>
    </xsl:variable>
    <xsl:variable name="経常利益_計">
      <xsl:value-of select="$経常利益_6-1 + $経常利益_6-2"/>
    </xsl:variable>

    <tr class='groupType'>
      <td rowspan="3">
        <xsl:value-of select="'経常利益'"/>
      </td>
      <td align="right">
        <xsl:value-of select="'月　計'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="経常利益_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])-sum(../../売上原価/*/月[@m=$m])-sum(../../販管費/*/月[@m=$m])+sum(../../費用付替/*/月[@m=$m])-sum(../../部門固定費/*/月[@m=$m])+sum(../../営業外収益/*/月[@m=$m])-sum(../../営業外費用/*/月[@m=$m])-sum(../../本社費配賦/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$経常利益_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($経常利益_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter' rowspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>
      <td align="right">
        <xsl:value-of select="'四半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_4-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_4-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_4-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_4-2 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_4-3 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_4-3 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="3">
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_4-4 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_4-4 div 1000 ,'#,##0')"/>
      </td>
    </tr>

    <tr class='groupType'>

      <td align="right">
        <xsl:value-of select="'半期　計'"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_6-1 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_6-1 div 1000 ,'#,##0')"/>
      </td>
      <td class="groupTypeData" colspan="6">
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_6-2 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_6-2 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="経常利益">
    <!-- 簡易表示行-->
    <xsl:variable name="経常利益_計">
      <xsl:value-of select="sum(予算/*/月)+sum(売上高/*/月)+sum(売上付替/*/月)-sum(売上原価/*/月)-sum(販管費/*/月)+sum(費用付替/*/月)-sum(部門固定費/*/月)+sum(営業外収益/*/月)-sum(営業外費用/*/月)-sum(本社費配賦/*/月)"/>
    </xsl:variable>
    <tr class='groupType'>
      <td colspan="2">
        <xsl:value-of select="'経常利益'"/>
      </td>
      <xsl:for-each select="月情報/月">
        <xsl:variable name="m">
          <xsl:value-of select="@m"/>
        </xsl:variable>
        <xsl:variable name="経常利益_月">
          <xsl:value-of select="sum(../../予算/*/月[@m=$m])+sum(../../売上高/*/月[@m=$m])+sum(../../売上付替/*/月[@m=$m])-sum(../../売上原価/*/月[@m=$m])-sum(../../販管費/*/月[@m=$m])+sum(../../費用付替/*/月[@m=$m])-sum(../../部門固定費/*/月[@m=$m])+sum(../../営業外収益/*/月[@m=$m])-sum(../../営業外費用/*/月[@m=$m])-sum(../../本社費配賦/*/月[@m=$m])"/>
        </xsl:variable>
        <td class="groupTypeData">
          <xsl:attribute name="style">
            <xsl:if test="$経常利益_月 &lt; 0">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:if>
          </xsl:attribute>
          <xsl:value-of select="format-number($経常利益_月 div 1000 ,'#,##0')"/>
        </td>
      </xsl:for-each>
      <td class='quarter'>
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>

  </xsl:template>


  <xsl:template name="経常利益_累計">
    <tr class='groupType'>
      <td rowspan="2" colspan="2">
        <xsl:value-of select="'経常利益'"/>
        <br/>
        <xsl:value-of select="'(累計)'"/>
      </td>
      <xsl:call-template name="month_LoopX">
        <xsl:with-param name="begin" select="$開始月" />
        <xsl:with-param name="mCnt" select="$月数" />
      </xsl:call-template>
      <td width="70">
        <xsl:attribute name="nowrap" />
        <xsl:value-of select="'合　計'"/>
        </td>
    </tr>

    <tr class='groupType'>
      <!-- １２カ月分の累計を表示-->
      <xsl:call-template name="valueOut_Loop_Sum">
        <xsl:with-param name="element" select="." />
        <xsl:with-param name="item" select="'$item'" />
        <xsl:with-param name="mCnt" select="$月数" />
        <xsl:with-param name="unit" select="'$unit'" />
        <xsl:with-param name="form" select="'$form'" />
      </xsl:call-template>
      <td class='lastTarget'>
        <xsl:variable name="経常利益_計">
          <xsl:value-of select="sum(予算/*/月)+sum(売上高/*/月)+sum(売上付替/*/月)-sum(売上原価/*/月)-sum(販管費/*/月)+sum(費用付替/*/月)-sum(部門固定費/*/月)+sum(営業外収益/*/月)-sum(営業外費用/*/月)-sum(本社費配賦/*/月)"/>
        </xsl:variable>
        <xsl:attribute name="style">
          <xsl:if test="$経常利益_計 &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($経常利益_計 div 1000 ,'#,##0')"/>
      </td>
    </tr>
  </xsl:template>


  <!--　データ(経常利益の月の累計)行の表示　-->
  <xsl:template name="valueOut_Loop_Sum">
    <xsl:param name="mCnt" />
    <xsl:param name="begin" select="1" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="m" select="$begin"/>
    <xsl:param name="sumVal" select="(sum(予算/*/月[@m=0])+sum(売上高/*/月[@m=0])+sum(売上付替/*/月[@m=0])-sum(売上原価/*/月[@m=0])-sum(販管費/*/月[@m=0])+sum(費用付替/*/月[@m=0])-sum(部門固定費/*/月[@m=0])+sum(営業外収益/*/月[@m=0])-sum(営業外費用/*/月[@m=0])-sum(本社費配賦/*/月[@m=0]))" />
    <xsl:param name="unit" />
    <xsl:param name="form"/>
    <xsl:if test="$m &lt; $max">
      <td class="groupTypeData">
        <xsl:attribute name="style">
          <xsl:if test="$sumVal &lt; 0">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="format-number($sumVal div 1000 ,'#,##0')"/>
      </td>
      <xsl:call-template name="valueOut_Loop_Sum">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="m" select="$m + 1" />
        <xsl:with-param name="sumVal" select="$sumVal + (sum(予算/*/月[@m=$m])+sum(売上高/*/月[@m=$m])+sum(売上付替/*/月[@m=$m])-sum(売上原価/*/月[@m=$m])-sum(販管費/*/月[@m=$m])+sum(費用付替/*/月[@m=$m])-sum(部門固定費/*/月[@m=$m])+sum(営業外収益/*/月[@m=$m])-sum(営業外費用/*/月[@m=$m])-sum(本社費配賦/*/月[@m=$m]))" />
        <xsl:with-param name="unit" select="$unit" />
        <xsl:with-param name="form" select="$form" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="month_LoopX">
    <xsl:param name="begin" />
    <xsl:param name="mCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
    <xsl:param name="cnt" select="$begin"/>
    <xsl:if test="$cnt &lt; $max">
      <td class="m" width='50'>
        <xsl:if test="($cnt mod 12)>0">
          <xsl:value-of select="$cnt mod 12"/>
        </xsl:if>
        <xsl:if test="($cnt mod 12)=0">
          <xsl:value-of select="12"/>
        </xsl:if>
        <xsl:value-of select="'月'"/>
      </td>
      <xsl:call-template name="month_LoopX">
        <xsl:with-param name="max" select="$max" />
        <xsl:with-param name="cnt" select="$cnt + 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!--		-->
  <xsl:include href="/Project/home/_inc/sub_cmn.xsl"/>
	
</xsl:stylesheet>
