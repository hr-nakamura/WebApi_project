<?xml version="1.0" encoding="utf-8" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:user="mynamespace">

  <xsl:template match="/">
    <html>
      <head>
        <title>プロジェクト</title>
        <link rel="stylesheet" type="text/css" href="cost.css"/>
      </head>

      <body background="bg.gif">
        <xsl:choose>
          <xsl:when test="root/全体/プロジェクト/実績月数=''">
            <xsl:apply-templates select="root/全体/プロジェクト" mode="dummy" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="root/全体/プロジェクト" />
          </xsl:otherwise>
        </xsl:choose>
      </body>
    </html>

  </xsl:template>

  <xsl:template match="プロジェクト" mode="dummy">
    <table cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="L_Title" ID="projectTree"></td>
        </tr>
        <tr>
          <td>
          <hr/>            
          </td>
        </tr>
        <tr>
          <td >
            <xsl:value-of select="'表示できる情報はありません'"/>
            <input type="checkbox" ID="eventInfoCheck" style="display:none;"></input>
          </td>
        </tr>
      </tbody>
  </table>
  </xsl:template>

  <xsl:template match="プロジェクト">
    <xsl:variable name="actualCnt">
      <xsl:value-of select="実績月数"/>
    </xsl:variable>

    <!-- 予測データ -->
    <xsl:variable name="予測_売上">
      <xsl:value-of select="sum(項目[@name='売上' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_社員工数">
      <xsl:value-of select="sum(項目[@name='社員工数' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_パート工数">
      <xsl:value-of select="sum(項目[@name='パート工数' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_協力工数">
      <xsl:value-of select="sum(項目[@name='協力工数' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_工数">
      <xsl:value-of select="$予測_社員工数 + $予測_パート工数 + $予測_協力工数"/>
    </xsl:variable>
    <xsl:variable name="予測_労務費">
      <xsl:value-of select="sum(項目[@name='労務費' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_協力費用">
      <xsl:value-of select="sum(項目[@name='協力費用' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_業務費用">
      <xsl:value-of select="sum(項目[@name='業務費用' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_原価">
      <xsl:value-of select="$予測_労務費+$予測_協力費用+$予測_業務費用"/>
    </xsl:variable>
    <xsl:variable name="予測_利益">
      <xsl:value-of select="$予測_売上 - $予測_原価"/>
    </xsl:variable>
    <xsl:variable name="予測_原価率">
      <xsl:value-of select="$予測_原価 div $予測_売上"/>
    </xsl:variable>

    <!-- 予実データ -->
    <xsl:variable name="予実_売上">
      <xsl:value-of select="sum(項目[@name='売上' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='売上' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_社員工数">
      <xsl:value-of select="sum(項目[@name='社員工数' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='社員工数' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_パート工数">
      <xsl:value-of select="sum(項目[@name='パート工数' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='パート工数' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_協力工数">
      <xsl:value-of select="sum(項目[@name='協力工数' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='協力工数' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_工数">
      <xsl:value-of select="$予実_社員工数 + $予実_パート工数 + $予実_協力工数"/>
    </xsl:variable>
    <xsl:variable name="予実_労務費">
      <xsl:value-of select="sum(項目[@name='労務費' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='労務費' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_協力費用">
      <xsl:value-of select="sum(項目[@name='協力費用' and @mode='実績']/月[@m&lt;$actualCnt])+(sum(項目[@name='協力費用' and @mode='予測']/月[@m&gt;=$actualCnt]))"/>
    </xsl:variable>
    <xsl:variable name="予実_業務費用">
      <xsl:value-of select="sum(項目[@name='業務費用' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='業務費用' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_原価">
      <xsl:value-of select="$予実_労務費+$予実_協力費用+$予実_業務費用"/>
    </xsl:variable>
    <xsl:variable name="予実_利益">
      <xsl:value-of select="$予実_売上 - $予実_原価"/>
    </xsl:variable>
    <xsl:variable name="予実_原価率">
      <xsl:value-of select="$予実_原価 div $予実_売上"/>
    </xsl:variable>

    <!-- 実績データ -->
    <xsl:variable name="実績_売上">
      <xsl:value-of select="sum(項目[@name='売上' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_社員工数">
      <xsl:value-of select="sum(項目[@name='社員工数' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_パート工数">
      <xsl:value-of select="sum(項目[@name='パート工数' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_協力工数">
      <xsl:value-of select="sum(項目[@name='協力工数' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_工数">
      <xsl:value-of select="$実績_社員工数 + $実績_パート工数 + $実績_協力工数"/>
    </xsl:variable>
    <xsl:variable name="実績_労務費">
      <xsl:value-of select="sum(項目[@name='労務費' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_協力費用">
      <xsl:value-of select="sum(項目[@name='協力費用' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_業務費用">
      <xsl:value-of select="sum(項目[@name='業務費用' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_原価">
      <xsl:value-of select="$実績_労務費 + $実績_協力費用 + $実績_業務費用"/>
    </xsl:variable>
    <xsl:variable name="実績_利益">
      <xsl:value-of select="$実績_売上 - $実績_原価"/>
    </xsl:variable>
    <xsl:variable name="実績_原価率">
      <xsl:value-of select="$実績_原価 div $実績_売上"/>
    </xsl:variable>

      <table cellpadding="0" cellspacing="0">
        <tbody>
          <tr>
            <td class="L_Title" colspan="3" ID="projectTree">
              <big>
                <b>
                  <xsl:value-of select="名前"/>
                </b>
              </big>
            </td>
            <td width="50">
              <xsl:value-of select="'　'"/>
            </td>
            <td class="L_Title" colspan="1">
              <xsl:value-of select="客先名"/>
            </td>
            <td width="200">
              <xsl:value-of select="'　'"/>
            </td>
            <td class="L_Title" colspan="1">
               <xsl:value-of select="'実績月：'"/>
               <xsl:value-of select="user:yymmAddStr(//実績月,0)"/>
            </td>
            </tr>
          <tr ID="eventInfo">
            <xsl:attribute name="mode">
              <xsl:choose>
                <xsl:when test="position()=1 or position()=last()">
                  <xsl:value-of select="0"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <td class="L_Item">
              <xsl:value-of select="日付"/>
            </td>
            <td class="L_Item">
              <xsl:value-of select="備考"/>
            </td>
          </tr>
        </tbody>
      <!--</table>
    <br/>
    <table cellpadding="0" cellspacing="0">-->
      <tbody>
        <tr>
          <td>
            <br/>
          </td>
        </tr>
      </tbody>
      <tbody>
        <tr>
          <td valign="top">
            <xsl:call-template name="プロジェクト情報_A"/>
          </td>
          <td valign="top" width="200">
            <xsl:value-of select="''"/>
          </td>
          <td valign="top">
            <xsl:call-template name="プロジェクト情報_B"/>
          </td>
          <td valign="top" width="200">
            <xsl:value-of select="''"/>
          </td>
          <td valign="top">
            <xsl:call-template name="プロジェクト情報_C"/>
          </td>
          <td valign="top" width="200">
            <xsl:value-of select="''"/>
          </td>
          <td valign="top">
            <xsl:call-template name="プロジェクト情報_DList"/>
          </td>
        </tr>
      </tbody>
    </table>
    <br/>
    <table class="disp" cellpadding="0" cellspacing="0">
      <thead>
        <tr>
          <th rowspan="2" width="100">
            <xsl:value-of select="'　'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'売上'"/>
          </th>
          <th colspan="4">
            <xsl:value-of select="'開発工数'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'労務費'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'協力費用'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'業務費用'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'原価'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'利益'"/>
          </th>
          <th rowspan="2">
            <xsl:value-of select="'原価率'"/>
          </th>
        </tr>
        <tr>
        <th>
          <xsl:value-of select="'社員'"/>
        </th>
        <th>
          <xsl:value-of select="'パート'"/>
        </th>
        <th>
          <xsl:value-of select="'協力'"/>
        </th>
        <th>
          <xsl:value-of select="'合計'"/>
        </th>
        </tr>
    </thead>
    <tbody>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'予測'"/>
        </td>
        <td class="num">
          <!-- 売上 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_売上"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 社員工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_社員工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- パート工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_パート工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 協力工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_協力工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 合計工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_社員工数+$予測_パート工数+$予測_協力工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 労務費 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_労務費"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 協力費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_協力費用"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 業務費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_業務費用"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 原価 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_原価"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 利益 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_利益"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 原価率 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予測_原価率"/>
            <xsl:with-param name="unit" select="1"/>
            <xsl:with-param name="form" select="'#%'"/>
          </xsl:call-template>
        </td>
      </tr>
    </tbody>
    <tbody>
      <tr class="selLine">
        <td class="sItem">
          <xsl:value-of select="'実績＋予測'"/>
        </td>
        <td class="num">
          <!-- 売上 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_売上"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 社員工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_社員工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- パート工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_パート工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 協力工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_協力工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 合計工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_社員工数+$予実_パート工数+$予実_協力工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 労務費 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_労務費"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 協力費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_協力費用"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 業務費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_業務費用"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 原価 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_原価"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 利益 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_利益"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 原価率 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$予実_原価率"/>
            <xsl:with-param name="unit" select="1"/>
            <xsl:with-param name="form" select="'#%'"/>
          </xsl:call-template>
        </td>
      </tr>
    </tbody>
    <tbody>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'実績'"/>
        </td>
        <td class="num">
          <!-- 売上 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_売上"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 社員工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_社員工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- パート工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_パート工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 協力工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_協力工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 合計工数 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_社員工数+$実績_パート工数+$実績_協力工数"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 労務費 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_労務費"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 協力費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_協力費用"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 業務費用 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_業務費用"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 原価 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_原価"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 利益 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_利益"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- 原価率 -->
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="$実績_原価率"/>
            <xsl:with-param name="unit" select="1"/>
            <xsl:with-param name="form" select="'#%'"/>
          </xsl:call-template>
        </td>
      </tr>
    </tbody>
  </table>
  </xsl:template>

<!--プロジェクト情報-->
  <xsl:template name="プロジェクト情報_A">
    <table class="disp" cellpadding="0" cellspacing="0" width="180">
      <tbody>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'プロジェクトコード'"/>
        </td>
        <td class="C_Item">
          <xsl:value-of select="pCode"/>
        </td>
      </tr>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'状態'"/>
        </td>
        <td id="editCell" class="C_Item">
          <xsl:attribute name="mode">
            <xsl:value-of select="'状態'"/>
          </xsl:attribute>
          <xsl:attribute name="value">
            <xsl:value-of select="状態"/>
          </xsl:attribute>
          <xsl:apply-templates select="状態"/>
        </td>
      </tr>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'分類名'"/>
        </td>
        <td id="editCell" class="C_Item">
          <xsl:attribute name="mode">
            <xsl:value-of select="'分類名'"/>
          </xsl:attribute>
          <xsl:attribute name="value">
            <xsl:value-of select="分類名"/>
          </xsl:attribute>
          <xsl:value-of select="分類名"/>
        </td>
      </tr>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'PM名'"/>
        </td>
        <td id="editCell" class="C_Item">
          <xsl:attribute name="mode">
            <xsl:value-of select="'PM名'"/>
          </xsl:attribute>
          <xsl:attribute name="value">
            <xsl:value-of select="PMId"/>
          </xsl:attribute>
          <xsl:value-of select="PM名"/>
        </td>
      </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'営業担当'"/>
          </td>
          <td id="editCell" class="C_Item">
            <xsl:attribute name="mode">
              <xsl:value-of select="'営業担当'"/>
            </xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="営業担当ID"/>
            </xsl:attribute>
            <xsl:value-of select="営業担当"/>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
<!--営業担当・契約工数・見積工数・社員工数-->
  <xsl:template name="プロジェクト情報_B">
    <xsl:variable name="actualCnt">
      <xsl:value-of select="実績月数"/>
    </xsl:variable>
    <xsl:variable name="予測_社員工数">
      <xsl:value-of select="sum(項目[@name='社員工数' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_パート工数">
      <xsl:value-of select="sum(項目[@name='パート工数' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_協力工数">
      <xsl:value-of select="sum(項目[@name='協力工数' and @mode='予測']/月)"/>
    </xsl:variable>
    <xsl:variable name="予測_工数">
      <xsl:value-of select="$予測_社員工数 + $予測_パート工数 + $予測_協力工数"/>
    </xsl:variable>
    <xsl:variable name="予実_社員工数">
      <xsl:value-of select="sum(項目[@name='社員工数' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='社員工数' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_パート工数">
      <xsl:value-of select="sum(項目[@name='パート工数' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='パート工数' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_協力工数">
      <xsl:value-of select="sum(項目[@name='協力工数' and @mode='実績']/月[@m&lt;$actualCnt])+sum(項目[@name='協力工数' and @mode='予測']/月[@m&gt;=$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="予実_工数">
      <xsl:value-of select="$予実_社員工数 + $予実_パート工数 + $予実_協力工数"/>
    </xsl:variable>
    <xsl:variable name="実績_社員工数">
      <xsl:value-of select="sum(項目[@name='社員工数' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_パート工数">
      <xsl:value-of select="sum(項目[@name='パート工数' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_協力工数">
      <xsl:value-of select="sum(項目[@name='協力工数' and @mode='実績']/月[@m&lt;$actualCnt])"/>
    </xsl:variable>
    <xsl:variable name="実績_工数">
      <xsl:value-of select="$実績_社員工数 + $実績_パート工数 + $実績_協力工数"/>
    </xsl:variable>
    <table class="disp" cellpadding="0" cellspacing="0" width="180">
  <tbody>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'契約工数'"/>
          </td>
          <td class="R_Item">
            <xsl:call-template name="value_Out">
              <xsl:with-param name="value" select="sum(項目[@name='契約工数']/月)"/>
              <xsl:with-param name="unit" select="100"/>
              <xsl:with-param name="form" select="'#,##0.00'"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'見積工数'"/>
          </td>
          <td class="R_Item">
            <xsl:call-template name="value_Out">
              <xsl:with-param name="value" select="sum(項目[@name='見積工数']/月)"/>
              <xsl:with-param name="unit" select="100"/>
              <xsl:with-param name="form" select="'#,##0.00'"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'外部工数'"/>
          </td>
          <td class="R_Item">
            <xsl:call-template name="value_Out">
              <xsl:with-param name="value" select="sum(項目[@name='外部工数']/月)"/>
              <xsl:with-param name="unit" select="100"/>
              <xsl:with-param name="form" select="'#,##0.00'"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'想定工数'"/>
          </td>
          <td class="R_Item">
            <xsl:call-template name="value_Out">
              <xsl:with-param name="value" select="$予測_工数"/>
              <!--<xsl:with-param name="value" select="$予測_社員工数+$予測_パート工数+$予測_協力工数"/>-->
              <xsl:with-param name="unit" select="100"/>
              <xsl:with-param name="form" select="'#,##0.00'"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'予実工数'"/>
          </td>
          <td class="R_Item">
            <xsl:call-template name="value_Out">
              <xsl:with-param name="value" select="$予実_工数"/>
              <xsl:with-param name="unit" select="100"/>
              <xsl:with-param name="form" select="'#,##0.00'"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'実績工数'"/>
          </td>
          <td class="R_Item">
            <xsl:call-template name="value_Out">
              <xsl:with-param name="value" select="$実績_工数"/>
              <!--<xsl:with-param name="value" select="$予測_社員工数+$予測_パート工数+$予測_協力工数"/>-->
              <xsl:with-param name="unit" select="100"/>
              <xsl:with-param name="form" select="'#,##0.00'"/>
            </xsl:call-template>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>

  <!--確度・契約・見積-->
  <xsl:template name="プロジェクト情報_C">
    <table class="disp" cellpadding="0" cellspacing="0" width="150">
      <tbody>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'確度'"/>
        </td>
        <td id="editCell">
          <xsl:attribute name="mode">
            <xsl:value-of select="'確度'"/>
          </xsl:attribute>
            <!--<td id="fix_levelCell">-->
            <xsl:attribute name="value">
            <xsl:value-of select="確度"/>
          </xsl:attribute>
          <xsl:apply-templates select="確度"/>
        </td>
      </tr>
      <tr>
        <td class="sItem">
          <xsl:value-of select="'契約'"/>
        </td>
        <td id="editCell">
          <xsl:attribute name="mode">
            <xsl:value-of select="'契約'"/>
          </xsl:attribute>
          <!--<td id="contractCell">-->
            <xsl:attribute name="value">
            <xsl:apply-templates select="契約"/>
          </xsl:attribute>
          <xsl:apply-templates select="契約"/>
        </td>
      </tr>
        <tr>
          <td class="sItem">
            <xsl:value-of select="'見積'"/>
          </td>
          <td id="editCell">
            <xsl:attribute name="mode">
              <xsl:value-of select="'見積'"/>
            </xsl:attribute>
            <!--<td id="estimateCell">-->
              <xsl:attribute name="value">
              <xsl:apply-templates select="見積"/>
            </xsl:attribute>
            <xsl:apply-templates select="見積"/>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>
  
  <!--イベント情報-->
  <xsl:template name="プロジェクト情報_D">
    <table class="disp" cellpadding="0" cellspacing="0" width="250">
      <tbody>
      <tr>
        <td id="editCell" class="sItem">
          <xsl:attribute name="mode">
            <xsl:value-of select="'イベント'"/>
          </xsl:attribute>
          <xsl:value-of select="'イベント'"/>
        </td>
        <td id="editCell" class="sItem">
          <xsl:attribute name="mode">
            <xsl:value-of select="'イベント'"/>
          </xsl:attribute>
          <xsl:value-of select="'備考'"/>
        </td>
      </tr>
      <tr>
        <td class="L_Item">
          <xsl:value-of select="イベント開始/日付"/>
        </td>
        <td class="L_Item">
          <xsl:value-of select="イベント開始/備考"/>
        </td>
      </tr>
      <tr>
        <td class="L_Item">
          <xsl:value-of select="イベント終了/日付"/>
        </td>
        <td class="L_Item">
          <xsl:value-of select="イベント終了/備考"/>
        </td>
      </tr>
      </tbody>
    </table>
  </xsl:template>
  
  <xsl:template name="プロジェクト情報_DList">
    <table class="disp" cellpadding="0" cellspacing="0" width="250">
      <tbody>
        <tr>
          <td colspan="3" class="sItem">
            <xsl:if test="count(イベント/項目) &lt;= 2">
              <xsl:attribute name="style">
                <xsl:value-of select="'display:none'"/>
              </xsl:attribute>
            </xsl:if>
            <input type="checkbox" ID="eventInfoCheck">展開する</input>
            <xsl:value-of select="' ('"/>
            <xsl:value-of select="count(イベント/項目)"/>
            <xsl:value-of select="')'"/>
          </td>
        </tr>
        <tr id="editCell" class="sItem">
          <xsl:attribute name="mode">
            <xsl:value-of select="'イベント'"/>
          </xsl:attribute>
          <td width="30%">
            <xsl:value-of select="'イベント'"/>
          </td>
          <td width="10%">
            <xsl:value-of select="'コード'"/>
          </td>
          <td width="60%">
            <xsl:value-of select="'備考'"/>
          </td>
        </tr>
        <xsl:for-each select="イベント/項目">
          <tr ID="eventInfo">
            <xsl:attribute name="mode">
              <xsl:choose>
                <xsl:when test="position()=1 or position()=last()">
                  <xsl:value-of select="0"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="1"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <!--<xsl:attribute name="title">
              <xsl:value-of select="@pNum"/>
            </xsl:attribute>-->
            <td class="L_Item">
              <xsl:value-of select="日付"/>
            </td>
            <td class="C_Item">
              <xsl:value-of select="@pCode"/>
            </td>
            <td class="L_Item">
              <xsl:value-of select="備考"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
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
  <xsl:template match="状態">
    <xsl:param name="stat" select="." />
    <xsl:choose>
      <!-- 引合中-->
      <xsl:when test="$stat=0">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:green;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'▲'"/>
        </span>
        <xsl:value-of select="' 引合中'"/>
      </xsl:when>
      <!-- 開発中-->
      <xsl:when test="$stat=1">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:blue;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
        </span>
          <xsl:value-of select="' 開発中'"/>
      </xsl:when>
      <!-- 開発終了-->
      <xsl:when test="$stat=4">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
        </span>
        <xsl:value-of select="' 開発終了'"/>
      </xsl:when>
      <!-- 終了-->
      <xsl:when test="$stat=5">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'★'"/>
        </span>
        <xsl:value-of select="' 終了'"/>
      </xsl:when>
      <xsl:when test="$stat=-1">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'×'"/>
        </span>
        <xsl:value-of select="' 没'"/>
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
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:x-small;color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'　'"/>
      </xsl:when>
      <xsl:when test="$stat=1">
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:x-small;color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
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
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:x-small;color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'　'"/>
      </xsl:when>
      <xsl:when test="$stat=1">
          <xsl:attribute name="style">
            <xsl:value-of select="'font-size:x-small;color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'●'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'　'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="確度">
    <xsl:param name="stat" select="." />
      <xsl:attribute name="style">
        <xsl:value-of select="'font-size:x-small;color:gray;text-align:center;'"/>
      </xsl:attribute>
      <xsl:value-of select="$stat"/>
  </xsl:template>

  <xsl:include href="sub_JScript.xsl"/>

</xsl:stylesheet>