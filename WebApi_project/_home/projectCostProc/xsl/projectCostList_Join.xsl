<?xml version="1.0" encoding="shift_jis" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:user="mynamespace">

  <!--<xsl:value-of select="user:yymmAddStr(201201,-1)"/>-->
  <xsl:variable name="mode" select="'予測'"/>
  <xsl:variable name="plan" select="'予測'"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>プロジェクト</title>
        <link rel="stylesheet" type="text/css" href="cost.css"/>
      </head>

      <body background="bg.gif">
        <xsl:apply-templates select="root"/>

        <br/>
        <hr/>
        <br/>

        <xsl:call-template name="help"/>


      </body>
    </html>

  </xsl:template>

  <xsl:template match="root">
    <table>
      <caption>
        <div>
          <B>
            <br/>
            <xsl:value-of select="題目"/>
            <br/>
            <xsl:value-of select="'新バージョン'"/>
          </B>
          <br/>
          <small>
            <xsl:value-of select="''"/>
            <xsl:value-of select="説明"/>
            <xsl:value-of select="''"/>
            <!--<br/>
            <br/>
            <font style="color:darksalmon">
              <B>
              <xsl:value-of select="'原価率 '"/>
              </B>
              <xsl:value-of select="'： 実績月を過ぎて稼動しているプロジェクトの場合、'"/>
              <br/>
            <xsl:value-of select="'想定工数を作業予定期間の各月に分配しないと確かな数値になりません。'"/>
            </font>-->
          </small>
        </div>
      </caption>
      <tr>
        <td>
          <xsl:apply-templates select="全体">
            <xsl:with-param name="disp" select="-1"/>
          </xsl:apply-templates>
        </td>
      </tr>
      <!--<tr>
        <td>
          <xsl:apply-templates select="全体">
            <xsl:with-param name="disp" select="0"/>
          </xsl:apply-templates>
        </td>
      </tr>
      <tr>
        <td align="center">
          <hr/>
          <small>
            <br/>
            <B>
              <xsl:value-of select="'原価率が計算できないプロジェクト'"/>
            </B>
            <br/>
            <xsl:value-of select="'（コストだけのデータ）'"/>
            <br/>
          </small>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:apply-templates select="全体">
            <xsl:with-param name="disp" select="1"/>
          </xsl:apply-templates>
        </td>
      </tr>
      <tr>
        <td align="center">
          <hr/>
          <small>
            <br/>
            <B>
              <xsl:value-of select="'原価率が計算できないプロジェクト'"/>
            </B>
            <br/>
            <xsl:value-of select="'（売上だけのデータ）'"/>
            <br/>
          </small>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:apply-templates select="全体">
            <xsl:with-param name="disp" select="2"/>
          </xsl:apply-templates>
        </td>
      </tr>-->
    </table>

  </xsl:template>

  <xsl:template match="全体">
    <xsl:param name="disp"/>
    <table class="disp" cellpadding="0" cellspacing="0" width="100%">
      <caption>
            <DIV align="right">
              <xsl:value-of select="'表示数：'"/>
              <xsl:choose>
                <xsl:when test="$disp=0">
                  <xsl:value-of select="count(プロジェクト[原価率[@mode=$mode] > 0])"/>
                </xsl:when>
                <xsl:when test="$disp=1">
                  <xsl:value-of select="count(プロジェクト[売上[@mode=$mode] = 0 and 原価[@mode=$mode] >= 0])"/>
                </xsl:when>
                <xsl:when test="$disp=2">
                  <xsl:value-of select="count(プロジェクト[売上[@mode=$mode] > 0 and 原価[@mode=$mode] = 0])"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="count(プロジェクト)"/>
                </xsl:otherwise>
              </xsl:choose>
            </DIV>
          </caption>
      <thead>
        <xsl:call-template name="HEAD"/>
      </thead>

      <thead>
        <xsl:choose>
          <xsl:when test="$disp=0">
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト[原価率[@mode=$mode] > 0]" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$disp=1">
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト[売上[@mode=$mode] = 0 and 原価[@mode=$mode] >= 0]" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$disp=2">
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト[売上[@mode=$mode] > 0 and 原価[@mode=$mode] = 0]" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </thead>

      <tbody>
        <xsl:choose>
          <xsl:when test="$disp=0">
            <xsl:for-each select="プロジェクト[原価率[@mode=$mode] > 0]">
              <xsl:sort select="原価率[@mode=$mode]" data-type="number" order="descending"/>
              <xsl:apply-templates select=".">
                <xsl:with-param name="pos" select="position()" />
              </xsl:apply-templates>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="$disp=1">
            <xsl:for-each select="プロジェクト[売上[@mode=$mode] = 0 and 原価[@mode=$mode] >= 0]">
              <xsl:sort select="原価率[@mode=$mode]" data-type="number" order="descending"/>
              <xsl:apply-templates select=".">
                <xsl:with-param name="pos" select="position()" />
              </xsl:apply-templates>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="$disp=2">
            <xsl:for-each select="プロジェクト[売上[@mode=$mode] > 0 and 原価[@mode=$mode] = 0]">
              <xsl:sort select="原価率[@mode=$mode]" data-type="number" order="descending"/>
              <xsl:apply-templates select=".">
                <xsl:with-param name="pos" select="position()" />
              </xsl:apply-templates>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="プロジェクト">
              <xsl:sort select="原価率[@mode=$mode]" data-type="number" order="descending"/>
              <xsl:apply-templates select=".">
                <xsl:with-param name="pos" select="position()" />
              </xsl:apply-templates>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </tbody>

      <tfoot>
        <xsl:choose>
          <xsl:when test="$disp=0">
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト[原価率[@mode=$mode] > 0]" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$disp=1">
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト[売上[@mode=$mode] = 0 and 原価[@mode=$mode] >= 0]" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$disp=2">
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト[売上[@mode=$mode] > 0 and 原価[@mode=$mode] = 0]" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="プロジェクト" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </tfoot>
  </table>
  </xsl:template>

  <xsl:template name="HEAD">
    <tr>
      <th rowspan="2">
        <xsl:value-of select="'No'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'string'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'名前'"/>
        </xsl:attribute>
        <xsl:value-of select="'プロジェクト名'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'pNum'"/>
        </xsl:attribute>
        <xsl:value-of select="'コード'"/>
      </th>
      <th rowspan="2">
        <xsl:value-of select="'状'"/>
        <br/>
        <xsl:value-of select="'態'"/>
      </th>
      <th colspan="1">
        <xsl:value-of select="'開始日'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'売上[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'売上'"/>
      </th>
      <th colspan="4">
        <xsl:value-of select="'工数 (予測+実績)'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'合計工数[@mode=$plan]'"/>
        </xsl:attribute>
        <xsl:value-of select="'想定工数'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'労務費[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'労務費'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'協力費用[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'協力費用'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'業務費用[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'業務費用'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'原価[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'原価'"/>
      </th>
      <th rowspan="2" style="padding:2 16 2 16;">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'利益[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'利益'"/>
      </th>
      <th rowspan="2">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'原価率[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'原価率'"/>
      </th>
      <!--<th rowspan="2">
        <xsl:value-of select="'状況'"/>
      </th>-->
    </tr>
    <tr>
      <th>
        <xsl:value-of select="'終了日'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'社員工数[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'社員'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'パート工数[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'パート'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'協力工数[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'協力'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'合計工数[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'合計'"/>
      </th>
    </tr>
  </xsl:template>

  <xsl:template name="FOOT">
    <xsl:param name="project"/>
    <tr>
      <td class="pItem" colspan="5" style="text-align:right">
        <xsl:value-of select="'合計'"/>
      </td>
      <td class="R_Foot">
        <!-- 売上 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/売上[@mode=$mode])"/>
          <xsl:with-param name="unit" select="1000"/>
          <xsl:with-param name="form" select="'#,##0'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 想定工数 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/社員工数[@mode=$mode])"/>
          <xsl:with-param name="unit" select="100"/>
          <xsl:with-param name="form" select="'#,##0.00'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- パート工数 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/パート工数[@mode=$mode])"/>
          <xsl:with-param name="unit" select="100"/>
          <xsl:with-param name="form" select="'#,##0.00'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 協力工数 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/協力工数[@mode=$mode])"/>
          <xsl:with-param name="unit" select="100"/>
          <xsl:with-param name="form" select="'#,##0.00'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 売上 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/合計工数[@mode=$mode])"/>
          <xsl:with-param name="unit" select="100"/>
          <xsl:with-param name="form" select="'#,##0.00'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 売上 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/合計工数[@mode=$plan])"/>
          <xsl:with-param name="unit" select="100"/>
          <xsl:with-param name="form" select="'#,##0.00'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 労務費 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/労務費[@mode=$mode])"/>
          <xsl:with-param name="unit" select="1000"/>
          <xsl:with-param name="form" select="'#,##0'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 協力費用 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/協力費用[@mode=$mode])"/>
          <xsl:with-param name="unit" select="1000"/>
          <xsl:with-param name="form" select="'#,##0'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 業務費用 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/業務費用[@mode=$mode])"/>
          <xsl:with-param name="unit" select="1000"/>
          <xsl:with-param name="form" select="'#,##0'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <!-- 原価 -->
        <xsl:call-template name="value_Out">
          <xsl:with-param name="value" select="sum($project/原価[@mode=$mode])"/>
          <xsl:with-param name="unit" select="1000"/>
          <xsl:with-param name="form" select="'#,##0'"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <xsl:call-template name="利益_計">
          <xsl:with-param name="project" select="$project"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <xsl:call-template name="原価率_計">
          <xsl:with-param name="project" select="$project"/>
        </xsl:call-template>
      </td>
      <!--<td class="R_Foot">
      </td>-->

    </tr>
  </xsl:template>

  <xsl:template name="利益_計">
    <xsl:param name="project" />
    <xsl:variable name="value1" select="sum($project/売上[@mode=$mode])"/>
    <xsl:variable name="value2" select="sum($project/原価[@mode=$mode])"/>
    <xsl:choose>
      <xsl:when test="($value1 -$value2) &gt; 0">
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="style">
          <xsl:value-of select="'color:tomato'"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="format-number( ($value1 - $value2) div 1000 , '#,###' )"/>
  </xsl:template>

  <xsl:template name="原価率_計">
    <xsl:param name="project" />
    <xsl:variable name="value1" select="sum($project/売上[@mode=$mode])"/>
    <xsl:variable name="value2" select="sum($project/原価[@mode=$mode])"/>
    <xsl:choose>
      <xsl:when test="$value1 &gt; 0">
        <xsl:value-of select="format-number( $value2 div $value1 , '##0%' )"/>
      </xsl:when>
      <xsl:when test="$value1 = 0 or $value2 = 0">
        <!--<xsl:value-of select="'['"/>
        <xsl:value-of select="$value1"/>
        <xsl:value-of select="']['"/>
        <xsl:value-of select="$value2"/>
        <xsl:value-of select="']'"/>-->
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="format-number( $value2 div $value1 , '##0%' )"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="プロジェクト">
    <xsl:param name="pos" />
      <tr>
        <td rowspan="2" class="C_Item">
          <xsl:value-of select="$pos"/>
        </td>
        <td rowspan="2" class="corpItem" id="pNum-Cell">
          <xsl:attribute name="pNum">
            <xsl:value-of select="pNum"/>
          </xsl:attribute>
          <xsl:apply-templates select="名前"/>
        </td>
        <td rowspan="2" class="C_Item" id="pCode">
          <xsl:apply-templates select="pCode"/>
        </td>
        <td rowspan="2" class="C_Item">
          <xsl:call-template name="状態">
            <xsl:with-param name="stat" select="状態"/>
          </xsl:call-template>
        </td>
        <td class="C_Item">
          <xsl:apply-templates select="イベント開始"/>
        </td>
        <td rowspan="2" class="num">
          <!-- 売上 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="売上[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 社員工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="社員工数[@mode=$mode]"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- パート工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="パート工数[@mode=$mode]"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 協力工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="協力工数[@mode=$mode]"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 合計工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="合計工数[@mode=$mode]"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 労務費 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="合計工数[@mode=$plan]"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 労務費 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="労務費[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 協力費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="協力費用[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 業務費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="業務費用[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 原価 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="原価[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
           <!--利益--> 
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="利益[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td rowspan="2" class="num">
          <!-- 原価率 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="原価率[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1"/>
            <xsl:with-param name="form" select="'0%'"/>
          </xsl:call-template>
        </td>
        <!--<td rowspan="2" class="C_Item">
          <xsl:apply-templates select="掲示板">
            <xsl:with-param name="pNum" select="pNum"/>
          </xsl:apply-templates>
        </td>-->
      </tr>
      <tr>
        <td class="C_Item">
          <xsl:apply-templates select="イベント終了"/>
        </td>
      </tr>
 </xsl:template>

  <xsl:template match="名前">
    <!--<xsl:value-of select="string-length(.)"/>-->
    <!--<xsl:value-of select="."/>-->
    <!--<br/>-->
    <xsl:attribute name="memo">
      <xsl:value-of select="'【 '"/>
      <xsl:value-of select="../gName"/>
      <xsl:value-of select="' 】　'"/>
      <xsl:value-of select="'['"/>
      <xsl:value-of select="../PM名"/>
      <xsl:value-of select="']　'"/>
      <xsl:value-of select="'['"/>
      <xsl:value-of select="../営業担当"/>
      <xsl:value-of select="']　'"/>
      <xsl:value-of select="'['"/>
      <xsl:value-of select="../分類名"/>
      <xsl:value-of select="']'"/>
    </xsl:attribute>
    <xsl:variable name="sLen" select="64"/>
    <xsl:choose>
      <xsl:when test="string-length(.) &gt; $sLen">
        <xsl:value-of select="substring(., 0, $sLen)"/>
        <br/>
        <xsl:value-of select="substring(., $sLen)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="イベント開始">
    <xsl:choose>
      <xsl:when test=" 日付 != '' ">
        <xsl:value-of select="日付"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'　'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="イベント終了">
    <xsl:variable name="アラート" select="../日付アラート"/>
    <xsl:choose>
      <xsl:when test=" 日付 != '' ">
        <xsl:if test="$アラート=1 or $アラート=2">
          <xsl:attribute name="style">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="日付"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'　'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="value_Out">
    <xsl:param name="value"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
    <xsl:choose>
      <xsl:when test="$value = 0">
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:when test="$value='Infinity'">
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:when test="$value='NaN'">
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:when test="$value=''">
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:when test="$value &lt; 0">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:tomato;'"/>
        </xsl:attribute>
        <xsl:value-of select="format-number($value div $unit,$form)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="format-number($value div $unit,$form)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--*******＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊-->
  <xsl:template match="pCode">
    <xsl:variable name="アラート" select="../日付アラート"/>

    <xsl:attribute name="memo">
      <xsl:value-of select="'最終工数：'"/>
      <xsl:value-of select="../最終日"/>
      <xsl:value-of select="'　'"/>
      <xsl:value-of select="../最終日-勤務"/>
    </xsl:attribute>
    <xsl:choose>
      <xsl:when test="$アラート=2">
        <xsl:attribute name="style">
          <xsl:value-of select="'background-color:pink;'"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$アラート=3">
        <xsl:attribute name="style">
          <xsl:value-of select="'background-color:tomato;'"/>
          <!--<xsl:value-of select="'background-color:tomato;color:white;'"/>-->
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template name="状態">
    <xsl:param name="stat"/>
    <xsl:choose>
      <!-- 引合中-->
      <xsl:when test="$stat=0">
        <xsl:attribute name="title">
          <xsl:value-of select="'引合中'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:green;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'▲'"/>
        </span>
      </xsl:when>
      <!-- 開発中-->
      <xsl:when test="$stat=1">
        <xsl:attribute name="title">
          <xsl:value-of select="'開発中'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:blue;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
        </span>
      </xsl:when>
      <!-- 開発終了-->
      <xsl:when test="$stat=4">
        <xsl:attribute name="title">
          <xsl:value-of select="'開発終了'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
        </span>
      </xsl:when>
      <!-- 終了-->
      <xsl:when test="$stat=5">
        <xsl:attribute name="title">
          <xsl:value-of select="'終了'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'★'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=8">
        <xsl:attribute name="title">
          <xsl:value-of select="'他'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
        <xsl:value-of select="'他'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=9">
        <xsl:attribute name="title">
          <xsl:value-of select="'没'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'×'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=98">
        <xsl:attribute name="title">
          <xsl:value-of select="'◇'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:red;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'◇'"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'　'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="契約">
    <xsl:param name="stat" select="." />
    <xsl:choose>
      <xsl:when test="$stat=0">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'　'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=1">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'　'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="見積">
    <xsl:param name="stat" select="." />
    <xsl:choose>
      <xsl:when test="$stat=0">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'　'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=1">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'　'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="help">
    <table>
      <tr>
        <td>
    <table class="disp">
      <thead>
        <tr>
          <th>
            <xsl:value-of select="'表示'"/>
          </th>
          <th>
            <xsl:value-of select="'説明'"/>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="l_Item">
            <xsl:attribute name="style">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:attribute>
            <xsl:value-of select="'終了日の日付が赤'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'[最終工数]が[終了日]より後に発生'"/>
          </td>
        </tr>
        <tr>
          <td class="l_Item">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:pink;'"/>
            </xsl:attribute>
            <xsl:value-of select="'プロジェクトコードが淡い赤'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'[最終工数]が[終了日]・[実績月]より後に発生'"/>
          </td>
        </tr>
        <tr>
          <td class="l_Item">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:tomato;'"/>
            </xsl:attribute>
            <xsl:value-of select="'プロジェクトコードが赤'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'[最終工数]が[実績月]より後に発生（[終了日]が未設定）'"/>
          </td>
        </tr>
      </tbody>
    </table>
    <hr/>
    <table class="disp">
        <thead>
          <tr>
            <th style="padding:4">
              <xsl:value-of select="'表示'"/>
            </th>
            <th style="padding:4">
              <xsl:value-of select="'説明'"/>
            </th>
          </tr>
        </thead>
        <tbody>
        <tr>
          <td class="c_Item">
            <xsl:call-template name="状態">
              <xsl:with-param name="stat" select="0"/>
            </xsl:call-template>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'引合中'"/>
          </td>
        </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="状態">
                <xsl:with-param name="stat" select="1"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'開発中'"/>
            </td>
          </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="状態">
                <xsl:with-param name="stat" select="4"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'開発終了（作業終了）'"/>
            </td>
          </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="状態">
                <xsl:with-param name="stat" select="5"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'終了（作業・入金処理終了）'"/>
            </td>
          </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="状態">
                <xsl:with-param name="stat" select="9"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'没'"/>
            </td>
          </tr>
        </tbody>
    </table>

        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="掲示板">
    <xsl:param name="pNum"/>
    <div>
      <input type="button" id="memo" value="状況">
        <xsl:attribute name="pNum">
          <xsl:value-of select="$pNum"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="最新 &gt; 0 ">
            <xsl:attribute name="style">
              <xsl:value-of select="'color:tomato;font-weight:bold;'"/>
              <!--<xsl:value-of select="'color:blue;background-color:gainsboro'"/>-->
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:value-of select="最新"/>
              <xsl:value-of select="'/'"/>
              <xsl:value-of select="合計"/>
              <xsl:value-of select="'件'"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="合計 &gt; 0 ">
            <xsl:attribute name="style">
              <xsl:value-of select="'color:royalblue;font-weight:bold;'"/>
              <!--<xsl:value-of select="'color:blue;background-color:gainsboro'"/>-->
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:value-of select="最新"/>
              <xsl:value-of select="'/'"/>
              <xsl:value-of select="合計"/>
              <xsl:value-of select="'件'"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
          </xsl:otherwise>
        </xsl:choose>
      </input>
      <xsl:if test=". &gt; 0 ">
        <span style="display:none">
          <xsl:value-of select="合計"/>
        </span>
      </xsl:if>
    </div>
  </xsl:template>


  <xsl:include href="sub_JScript.xsl"/>

</xsl:stylesheet>