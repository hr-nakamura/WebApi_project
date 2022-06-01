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
          <xsl:for-each select="�ڕW">
            <xsl:call-template name="�q��">
              <xsl:with-param name="�q��" select="*"/>
            </xsl:call-template>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>

  </xsl:template>



	<xsl:template name="�q��2">
		<xsl:param name="�q��"/>
		<xsl:value-of select="name()"/>
		<xsl:value-of select="count($�q��)"/>
		<xsl:for-each select="$�q��">
			<xsl:value-of select="@_name_"/>
		</xsl:for-each>
	</xsl:template>



	<xsl:template name="�q��">
    <xsl:param name="�q��"/>
    <xsl:param name="form" select="'#,###'"/>
    <tr class="sub_line">
		<th>�O���[�v��</th>
		<th>����</th>
		<xsl:call-template name="year_Loop">
        <xsl:with-param name="year" select="$year - 1"/>
        <xsl:with-param name="begin" select="10"/>
        <xsl:with-param name="mCnt" select="12"/>
      </xsl:call-template>
    </tr>
		<xsl:call-template name="�S�̏W�v">
			<xsl:with-param name="�S��" select="*"/>
		</xsl:call-template>
		
      <xsl:for-each select="*[name() != '�S��' ]">
        <xsl:call-template name="�O���[�v">
          <xsl:with-param name="�O���[�v" select="."/>
         </xsl:call-template>
      </xsl:for-each>

  </xsl:template>

	<xsl:template name="�S�̏W�v">
		<xsl:param name="�S��"/>
		<tr>
			<tr class="sub_line">
				<td rowspan="9">EMG</td>

				<td>��</td>
				<xsl:call-template name="month_Loop">
					<xsl:with-param name="begin" select="10"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<td>�ځ@�W</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$�S��[name() != '�S��']/�ڕW"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>���сE�\��</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$�S��[name() != '�S��']/�\��"/>
        <xsl:with-param name="mCnt" select="12"/>
        <xsl:with-param name="actualCnt" select="$actual"/>
      </xsl:call-template>
		</tr>
		<tr>
			<td>�O�N�x����*</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$�S��[name() = '�S��']/�O�N"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>�݌v[�ڕW](A)</td>
			<xsl:call-template name="item_Loop_�݌v">
				<xsl:with-param name="data" select="$�S��[name() != '�S��']/�ڕW"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>�݌v[���\](B)</td>
			<xsl:call-template name="item_Loop_�݌v">
				<xsl:with-param name="data" select="$�S��[name() != '�S��']/�\��"/>
				<xsl:with-param name="mCnt" select="12"/>
        <xsl:with-param name="actualCnt" select="$actual"/>
      </xsl:call-template>
		</tr>
		<tr>
			<td>�݌v[�O��]*</td>
			<xsl:call-template name="item_Loop_�݌v">
				<xsl:with-param name="data" select="$�S��[name() = '�S��']/�O�N"/>
				<xsl:with-param name="mCnt" select="12"/>
			</xsl:call-template>
		</tr>
		<tr>
			<td>�� (B/A)</td>
			<xsl:call-template name="item_Loop_��">
				<xsl:with-param name="data_A" select="$�S��[name() != '�S��']/�ڕW"/>
				<xsl:with-param name="data_B" select="$�S��[name() != '�S��']/�\��"/>
				<xsl:with-param name="mCnt" select="12"/>
        <xsl:with-param name="actualCnt" select="$actual"/>
      </xsl:call-template>
		</tr>
		<tr>
			<td>�� (B-A)</td>
			<xsl:call-template name="item_Loop_��">
				<xsl:with-param name="data_A" select="$�S��[name() != '�S��']/�ڕW"/>
				<xsl:with-param name="data_B" select="$�S��[name() != '�S��']/�\��"/>
				<xsl:with-param name="mCnt" select="12"/>
        <xsl:with-param name="actualCnt" select="$actual"/>
      </xsl:call-template>
		</tr>
	</xsl:template>

	<xsl:template name="�S��">
		<xsl:param name="�S��"/>
			<tr class="sub_line">
				<td  class="onKind" rowspan="7">
					<xsl:value-of select="@_name_"/>
				</td>
				<td>��</td>
				<xsl:call-template name="month_Loop">
					<xsl:with-param name="begin" select="10"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'�ځ@�W'"/>
				</td>
				<xsl:call-template name="item_Loop">
					<xsl:with-param name="data" select="�ڕW"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'���сE�\��'"/>
				</td>
				<xsl:call-template name="item_Loop">
					<xsl:with-param name="data" select="�\��"/>
					<xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'�݌v[�ڕW] (A)'"/>
				</td>
				<xsl:call-template name="item_Loop_�݌v">
					<xsl:with-param name="data" select="�ڕW"/>
					<xsl:with-param name="mCnt" select="12"/>
				</xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'�݌v[���\] (B)'"/>
				</td>
				<xsl:call-template name="item_Loop_�݌v">
					<xsl:with-param name="data" select="�\��"/>
					<xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'�� (B/A)'"/>
				</td>
				<xsl:call-template name="item_Loop_��">
					<xsl:with-param name="data_A" select="�ڕW"/>
					<xsl:with-param name="data_B" select="�\��"/>
					<xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
			</tr>
			<tr>
				<td>
					<xsl:value-of select="'�� (B-A)'"/>
				</td>
				<xsl:call-template name="item_Loop_��">
					<xsl:with-param name="data_A" select="�ڕW"/>
					<xsl:with-param name="data_B" select="�\��"/>
					<xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
			</tr>

	</xsl:template>
 
  <xsl:template name="�O���[�v">
    <xsl:param name="�O���[�v"/>
	  <xsl:for-each select="$�O���[�v">
		  
	  <tr class="sub_line">
		  <td  class="onKind" rowspan="7">
			  <xsl:value-of select="@_name_"/>
		  </td>
		  <td>��</td>
		  <xsl:call-template name="month_Loop">
			  <xsl:with-param name="begin" select="10"/>
			  <xsl:with-param name="mCnt" select="12"/>
		  </xsl:call-template>
	  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'�ځ@�W'"/>
			  </td>
			  <xsl:call-template name="item_Loop">
				  <xsl:with-param name="data" select="�ڕW"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'���сE�\��'"/>
			  </td>
			  <xsl:call-template name="item_Loop">
				  <xsl:with-param name="data" select="�\��"/>
          <xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'�݌v[�ڕW] (A)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_�݌v">
				  <xsl:with-param name="data" select="�ڕW"/>
				  <xsl:with-param name="mCnt" select="12"/>
			  </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'�݌v[���\] (B)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_�݌v">
				  <xsl:with-param name="data" select="�\��"/>
				  <xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'�� (B/A)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_��">
				  <xsl:with-param name="data_A" select="�ڕW"/>
				  <xsl:with-param name="data_B" select="�\��"/>
				  <xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
		  </tr>
		  <tr>
			  <td>
				  <xsl:value-of select="'�� (B-A)'"/>
			  </td>
			  <xsl:call-template name="item_Loop_��">
				  <xsl:with-param name="data_A" select="�ڕW"/>
				  <xsl:with-param name="data_B" select="�\��"/>
				  <xsl:with-param name="mCnt" select="12"/>
          <xsl:with-param name="actualCnt" select="$actual"/>
        </xsl:call-template>
		  </tr>
	  </xsl:for-each>

  </xsl:template>

	<xsl:template name="item_Loop">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data" />
    <xsl:param name="mCnt" />
    <xsl:param name="actualCnt"/>
    <xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="sum($data/��[@m=$cnt])"/>
			<td class="num">
				<xsl:attribute name="nowrap"/>
        <xsl:if test="$cnt &gt;= $actualCnt">
          <xsl:attribute name="style">
            <xsl:value-of select="'color:blue;background-color:lightgray;'"/>
          </xsl:attribute>
            </xsl:if>
        
        <xsl:if test="$temp &gt; 0">
				<xsl:value-of select="format-number( $temp div 1000 ,$form)"/>
				</xsl:if>
				<xsl:if test="$temp = 0">
					<xsl:text>&#160;</xsl:text>
				</xsl:if>
			</td>
			<xsl:call-template name="item_Loop">
				<xsl:with-param name="data" select="$data" />
        <xsl:with-param name="actualCnt" select="$actualCnt" />
        <xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="item_Loop_�݌v">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data" />
		<xsl:param name="mCnt" />
    <xsl:param name="actualCnt"/>
    <xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:param name="work" select="0"/>
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="sum($data/��[@m=$cnt])"/>
			<td class="num">
				<xsl:attribute name="nowrap"/>
        <xsl:if test="$cnt &gt;= $actualCnt">
          <xsl:attribute name="style">
            <xsl:value-of select="'color:blue;background-color:lightgray;'"/>
          </xsl:attribute>
        </xsl:if>
				<xsl:value-of select="format-number( ($work + $temp) div 1000 ,'#,##0')"/>
			</td>
			<xsl:call-template name="item_Loop_�݌v">
				<xsl:with-param name="data" select="$data" />
        <xsl:with-param name="actualCnt" select="$actualCnt" />
        <xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work" select="$work + sum($data/��[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="item_Loop_��">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data_A" />
		<xsl:param name="data_B" />
		<xsl:param name="mCnt" />
    <xsl:param name="actualCnt"/>
    <xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:param name="work_A" select="0"/>
		<xsl:param name="work_B" select="0"/>
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="($work_B + sum($data_B/��[@m=$cnt])) - ($work_A + sum($data_A/��[@m=$cnt]))"/>
      <xsl:variable name="style1" select="''" />
      <xsl:variable name="style2" select="''" />
      <td class="num">
				<xsl:attribute name="nowrap"/>
        <xsl:if test="$cnt &gt;= $actualCnt">

          <!--<xsl:variable name="style" select="contains($style,'background-color:lightgray;')"/>-->
        </xsl:if>

        <xsl:if test="$temp &lt; 0">
          <!--<xsl:variable name="style" select="substring-after($style,'color:tomato;')"/>-->
        </xsl:if>
        <xsl:attribute name="style">
          <xsl:value-of select="contains($style1, $style2)"/>
        </xsl:attribute>
        <xsl:value-of select="format-number( $temp div 1000 ,'#,##0')"/>
			</td>
			<xsl:call-template name="item_Loop_��">
				<xsl:with-param name="data_A" select="$data_A" />
				<xsl:with-param name="data_B" select="$data_B" />
        <xsl:with-param name="actualCnt" select="$actualCnt" />
        <xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work_A" select="$work_A + sum($data_A/��[@m=$cnt])" />
				<xsl:with-param name="work_B" select="$work_B + sum($data_B/��[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="item_Loop_��">
		<xsl:param name="begin" select="0"/>
		<xsl:param name="data_A" />
		<xsl:param name="data_B" />
		<xsl:param name="mCnt" />
    <xsl:param name="actualCnt" />
    <xsl:param name="max" select="$begin+$mCnt"/>
		<xsl:param name="cnt" select="$begin"/>
		<xsl:param name="form" select="'#,###'" />
		<xsl:param name="work_A" select="0"/>
		<xsl:param name="work_B" select="0"/>
		<xsl:if test="$cnt &lt; $max">
			<xsl:variable name="temp" select="($work_B + sum($data_B/��[@m=$cnt])) div ($work_A + sum($data_A/��[@m=$cnt]))"/>
			<td class="num">
				<xsl:attribute name="nowrap"/>
        <xsl:if test="$cnt &gt;= $actualCnt">
          <xsl:attribute name="style">
            <xsl:value-of select="'color:blue;background-color:lightgray;'"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:choose>
					<xsl:when test="string($temp) = 'NaN'">
						<xsl:text>-&#160;</xsl:text>
					</xsl:when>
					<xsl:when test="string($temp) = 'Infinity'">
						<xsl:text>-&#160;</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number( $temp * 100 ,'##0.0')"/>
						<xsl:value-of select="'%'"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<xsl:call-template name="item_Loop_��">
				<xsl:with-param name="data_A" select="$data_A" />
        <xsl:with-param name="data_B" select="$data_B" />
        <xsl:with-param name="actualCnt" select="$actualCnt" />
        <xsl:with-param name="max" select="$max" />
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="work_A" select="$work_A + sum($data_A/��[@m=$cnt])" />
				<xsl:with-param name="work_B" select="$work_B + sum($data_B/��[@m=$cnt])" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>
