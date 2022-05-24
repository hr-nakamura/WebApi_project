<?xml version="1.0" encoding="Shift_JIS" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:import href="xsl/sub_cmn.xsl"/>
  
  <!--
  chrome [loadXMLDoc]����̏ꏊ  xsl/sub_cmn.xsl
  IE     [�{��xsl]����̏ꏊ     sub_cmn.xsl
  -->
  
  <xsl:variable name="year">
    <xsl:value-of select="/root/���/@year"/>
  </xsl:variable>
  <xsl:variable name="actual">
    <xsl:value-of select="/root/���/@actual"/>
  </xsl:variable>

  <xsl:template match="/">
    <html>
			<head>
				<title>���x��</title>
			</head>

			<body background="bg.gif">
				<xsl:apply-templates select="root" />
      </body>
		</html>

	</xsl:template>

	<xsl:template match="root/�f�[�^">
    
    
    <xsl:if test="count(*) = 0">
              <xsl:value-of select="'�f�[�^�͂���܂���'"/>

    </xsl:if>

    <xsl:if test="count(*) > 0">
      <table class="table">
        <tbody>
          <xsl:for-each select="*">
             <xsl:call-template name="����">
              <xsl:with-param name="����" select="*"/>
            </xsl:call-template>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>

  </xsl:template>


	<xsl:template name="����">
    <xsl:for-each select="*">
      <xsl:variable name="Cnt" select="count(*)"/>
      <xsl:for-each select="*">
        <tr>
          <xsl:if test="position() = 1">
            <td>
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$Cnt"/>
              </xsl:attribute>
              <xsl:value-of select="../@_name_"/>
            </td>
          </xsl:if>
          <td>
            <xsl:value-of select="'['"/>
            <xsl:value-of select="pCode"/>
            <xsl:value-of select="']'"/>
          </td>
          </tr>
        </xsl:for-each>
    </xsl:for-each>
  </xsl:template>


  <xsl:template name="����1">
    <xsl:param name="����"/>
    <xsl:param name="form" select="'#,###'"/>
    <tr class="sub_line">
      <th>���ޖ�</th>
      <th>�q�於</th>
      <td></td>
      <xsl:call-template name="year_Loop">
        <xsl:with-param name="year" select="$year - 1"/>
        <xsl:with-param name="begin" select="10"/>
        <xsl:with-param name="mCnt" select="12"/>
      </xsl:call-template>
      <td></td>
      <th colspan="2">�q�於</th>
      <th>���ޖ�</th>
    </tr>
    <xsl:for-each select="$����[count(uName/*) &gt; 0]">
      <tr class="sub_line">
        <td colspan="2"></td>
        <td>���@�v</td>
        <xsl:call-template name="month_Loop">
          <xsl:with-param name="begin" select="10"/>
          <xsl:with-param name="mCnt" select="12"/>
        </xsl:call-template>
        <td>���@�v</td>
        <td colspan="3"></td>
      </tr>
      <xsl:variable name="Cnt" select="count(uName/*)"/>
      <xsl:for-each select="uName/*">
        <xsl:variable name="Pos" select="position()"/>
        <xsl:call-template name="�q��">
          <xsl:with-param name="�q��" select="."/>
          <xsl:with-param name="Pos" select="$Pos"/>
          <xsl:with-param name="Cnt" select="$Cnt+2"/>
        </xsl:call-template>
      </xsl:for-each>
      <tr>
        <td class="sub_title">���@�v</td>
        <td class="num">
          <xsl:value-of select="format-number( sum(uName/*/data/��) ,$form)"/>
        </td>
        <xsl:call-template name="���v">
          <xsl:with-param name="data" select="uName/*/data/��"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
        <td class="num">
          <xsl:value-of select="format-number( sum(uName/*/data/��) ,$form)"/>
        </td>
        <td class="sub_title" colspan="2">���@�v</td>
      </tr>
      <tr>
        <td class="sub_title">�݁@�v</td>
        <td></td>
        <xsl:call-template name="�݌v">
          <xsl:with-param name="data" select="uName/*/data/��"/>
          <xsl:with-param name="begin" select="0"/>
          <xsl:with-param name="max" select="12"/>
        </xsl:call-template>
        <td></td>
        <td class="sub_title" colspan="2">�݁@�v</td>
      </tr>

    </xsl:for-each>
    <tr class="sub_line">
      <td colspan="2"></td>
      <td>���@�v</td>
      <xsl:call-template name="month_Loop">
        <xsl:with-param name="begin" select="10"/>
        <xsl:with-param name="mCnt" select="12"/>
      </xsl:call-template>
      <td>���@�v</td>
      <td colspan="3"></td>
    </tr>
    <tr class="sub_line">
      <td colspan="2">���@�� �v</td>
      <td class="num">
        <xsl:value-of select="format-number( sum($����/uName/*/data/��) ,$form)"/>
      </td>
      <xsl:call-template name="���v">
        <xsl:with-param name="data" select="$����/uName/*/data/��"/>
        <xsl:with-param name="begin" select="0"/>
        <xsl:with-param name="max" select="12"/>
      </xsl:call-template>
      <td class="num">
        <xsl:value-of select="format-number( sum($����/uName/*/data/��) ,$form)"/>
      </td>
      <td colspan="3">���@���@�v</td>
    </tr>
    <tr class="sub_line">
      <td colspan="2">���@�� �v</td>
      <td></td>
      <xsl:call-template name="�݌v">
        <xsl:with-param name="data" select="$����/uName/*/data/��"/>
        <xsl:with-param name="begin" select="0"/>
        <xsl:with-param name="max" select="12"/>
      </xsl:call-template>
      <td></td>
      <td colspan="3">���@�݁@�v</td>
    </tr>
  </xsl:template>


	<xsl:template name="���v">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
    <xsl:param name="form" select="'#,##0'" />
		<xsl:if test="$cnt &lt; $max">
			<td class="num">
        <xsl:if test="$cnt &gt;= $actual">
          <xsl:attribute name="class">
            <xsl:value-of select="'yosoku'"/>
          </xsl:attribute> 
        </xsl:if>          
        <xsl:value-of select="format-number( sum($data[@m=$cnt]) ,$form)"/>
			</td>
			<xsl:call-template name="���v">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  	<xsl:template name="�݌v">
    <xsl:param name="data"/>
		<xsl:param name="begin" />
		<xsl:param name="mCnt" />
		<xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
    <xsl:param name="work" select="0"/>
    <xsl:param name="form" select="'#,##0'" />
		<xsl:if test="$cnt &lt; $max">
			<td class="num">
        <xsl:if test="$cnt &gt;= $actual">
          <xsl:attribute name="class">
            <xsl:value-of select="'yosoku'"/>
          </xsl:attribute> 
        </xsl:if>
        <xsl:value-of select="format-number( $work + sum($data[@m=$cnt]) ,$form)"/>
			</td>
			<xsl:call-template name="�݌v">
				<xsl:with-param name="data" select="$data" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work" select="$work + sum($data[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

  
  <xsl:template name="�q��">
    <xsl:param name="�q��"/>
    <xsl:param name="Pos"/>
    <xsl:param name="Cnt"/>
    <xsl:param name="form" select="'#,###'" />
    <tr>
      <xsl:if test="$Pos = 1">
        <td class="onKind">
          <xsl:attribute name="rowspan" >
            <xsl:value-of select="$Cnt"/>
          </xsl:attribute>
          <xsl:attribute name="kind" >
            <xsl:value-of select="$�q��/../../@_name_"/>
          </xsl:attribute>
          <xsl:value-of select="$�q��/../../@_name_"/>
        </td>
      </xsl:if>
      <td>
        <xsl:value-of select="@_name_"/>
      </td>

      <td class="num">
        <xsl:value-of select="format-number( sum($�q��/data/��) ,$form)"/>
      </td>
      <xsl:for-each select="$�q��/data/��">
      <td class="num">
        <xsl:if test="position()-1 &gt;= $actual">
          <xsl:attribute name="class">
            <xsl:value-of select="'yosoku'"/>
          </xsl:attribute> 
        </xsl:if>
        <!--<xsl:if test=". != 0">-->
              <xsl:value-of select="format-number( . ,$form)"/>
			<!--</xsl:if>-->
      </td>
      </xsl:for-each>
      <td class="num">
        <xsl:value-of select="format-number( sum($�q��/data/��) ,$form)"/>
      </td>
      <td class="emg_mark">
        <xsl:call-template name="EMG_mark">
          <xsl:with-param name="mark" select="EMG"/>
        </xsl:call-template>
      </td>
        <td>
          <xsl:value-of select="@_name_"/>
        </td>
      <xsl:if test="$Pos = 1">
        <td class="onKind">
          <xsl:attribute name="rowspan" >
            <xsl:value-of select="$Cnt"/>
          </xsl:attribute>
          <xsl:attribute name="kind" >
            <xsl:value-of select="$�q��/../../@_name_"/>
          </xsl:attribute>
          <xsl:value-of select="$�q��/../../@_name_"/>
        </td>
      </xsl:if>
      </tr>
  </xsl:template>

  <!-- ########################################################### -->

  <!--		-->
  <xsl:template name="EMG_mark">
    <xsl:param name="mark" />
    <xsl:choose>
      <xsl:when test="$mark = 'EM'">
        <xsl:value-of select="' '"/>
      </xsl:when>
      <xsl:when test="$mark = 'ACEL'">
        <xsl:value-of select="'A'"/>
      </xsl:when>
      <xsl:when test="$mark = 'PSL'">
        <xsl:value-of select="'P'"/>
      </xsl:when>
      <xsl:when test="'-'">
        <xsl:value-of select="'-'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'x'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
