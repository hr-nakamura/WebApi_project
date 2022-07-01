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
</head>

<body background="bg.gif">
<xsl:apply-templates select="root" />
</body>
</html>

</xsl:template>

<xsl:template match="root">
  <xsl:variable name="mCnt" select="//月数"/>
  <xsl:variable name="yymm" select="//yymm"/>
	<xsl:variable name="D_売上実績" select="//表示項目/売上実績"/>
  <xsl:variable name="D_業務費用" select="//表示項目/業務費用"/>
  <xsl:variable name="D_協力費用" select="//表示項目/協力費用"/>
  <xsl:variable name="D_協力工数" select="//表示項目/協力工数"/>
  <xsl:variable name="D_社員工数" select="//表示項目/社員工数"/>
  <xsl:variable name="D_パート工数" select="//表示項目/パート工数"/>
  <xsl:variable name="D_労務費" select="//表示項目/労務費"/>


  <table ID="DETAIL" class="disp" align="center" border="0" width="1%">
		    <caption style="white-space:nowrap">
          <xsl:value-of select="全体/プロジェクト/名前"/>
          <xsl:value-of select="'　('"/>
          <xsl:value-of select="全体/プロジェクト/pCode"/>
          <xsl:value-of select="')'"/>
        </caption>
	  		<xsl:if test="$D_売上実績 = 1">
					<xsl:apply-templates select="全体" mode="valueOut_name">
						<xsl:with-param name="title" select="'売上実績'" />
						<xsl:with-param name="item" select="'売上実績'" />
						<xsl:with-param name="unit" select="1" />
						<xsl:with-param name="form" select="'#,##0'" />
					</xsl:apply-templates>
		  	</xsl:if>
    <xsl:if test="$D_労務費 = 1">
      <xsl:apply-templates select="全体" mode="valueOut_name">
        <xsl:with-param name="title" select="'労務費'" />
        <xsl:with-param name="item" select="'労務費'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="form" select="'#,##0'" />
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="$D_業務費用 = 1">
      <xsl:apply-templates select="全体" mode="valueOut_name">
        <xsl:with-param name="title" select="'業務費用'" />
        <xsl:with-param name="item" select="'業務費用'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="form" select="'#,##0'" />
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="$D_協力費用 = 1">
            <xsl:apply-templates select="全体" mode="valueOut_name">
              <xsl:with-param name="title" select="'協力費用'" />
              <xsl:with-param name="item" select="'協力費用'" />
              <xsl:with-param name="unit" select="1" />
              <xsl:with-param name="form" select="'#,##0'" />
            </xsl:apply-templates>
          </xsl:if>
          <xsl:if test="$D_協力工数 = 1">
            <xsl:apply-templates select="全体" mode="valueOut_name">
              <xsl:with-param name="title" select="'協力工数'" />
              <xsl:with-param name="item" select="'協力工数'" />
              <xsl:with-param name="unit" select="100" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>
          </xsl:if>
          <xsl:if test="$D_社員工数 = 1">
            <xsl:apply-templates select="全体" mode="valueOut_name">
              <xsl:with-param name="title" select="'社員工数'" />
              <xsl:with-param name="item" select="'社員工数'" />
              <xsl:with-param name="unit" select="100" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>
					<!--<xsl:apply-templates select="全体" mode="valueOut_name">
						<xsl:with-param name="title" select="'社員作業時間'" />
						<xsl:with-param name="item" select="'社員時間'" />
						<xsl:with-param name="unit" select="60" />
						<xsl:with-param name="form" select="'#,##0.00'" />
					</xsl:apply-templates>-->
			  </xsl:if>
          <xsl:if test="$D_パート工数 = 1">
            <xsl:apply-templates select="全体" mode="valueOut_name">
              <xsl:with-param name="title" select="'パート工数'" />
              <xsl:with-param name="item" select="'パート工数'" />
              <xsl:with-param name="unit" select="100" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>
            <!--<xsl:apply-templates select="全体" mode="valueOut_name">
              <xsl:with-param name="title" select="'パート作業時間'" />
              <xsl:with-param name="item" select="'パート時間'" />
              <xsl:with-param name="unit" select="60" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>-->
          </xsl:if>
      	</table>
</xsl:template>


<!--  指定項目の表出力　  -->
<!--　title:　表の題名　  -->
<!--　unit:単位　　　　   -->
<!--　form:表示形式　　   -->
<!--　item:処理する項目名 -->
<xsl:template match="全体" mode="valueOut">
	<xsl:param name="year" select="開始年"/>
	<xsl:param name="mm" select="開始月"/>
	<xsl:param name="mCnt" select="月数"/>
	<xsl:param name="title"/>
	<xsl:param name="item"/>
	<xsl:param name="unit"/>
	<xsl:param name="form"/>
      <thead>
				<tr>
          <th rowspan="2" colspan="2">項目</th>
          <th rowspan="2">合計</th>
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

			<tbody>
				<xsl:for-each select="プロジェクト">
					<xsl:variable name="cnt1" select="count(項目[@name=$item]/詳細)"/>
					<xsl:for-each select="項目[@name=$item]">
						<xsl:for-each select="詳細">
							<tr>
								<xsl:attribute name="pNum">
									<xsl:value-of select="pNum"/>
								</xsl:attribute>
								<xsl:if test="position()=1">
									<td class="sItem" colspan="2">
										<xsl:attribute name="rowspan">
											<xsl:value-of select="$cnt1"/>
										</xsl:attribute>
                    <xsl:value-of select="$title"/>
                  </td>
								</xsl:if>
								<!--合計-->
								<td class="sum">
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
			</tbody>
      <thead class="dummy_tfoot">
				<tr>
					<td colspan="2">
                        <xsl:attribute name="nowrap" />
                        <xsl:value-of select="'　'"/>
					</td>
					<td class="sum">
						<xsl:value-of select="format-number(sum(プロジェクト/項目[@name=$item]/詳細/*) div $unit,$form)"/>
					</td>
					<xsl:call-template name="valueOut_Loop_Footer">
						<xsl:with-param name="element" select="プロジェクト/項目[@name=$item]" />
						<xsl:with-param name="item" select="$item" />
						<xsl:with-param name="begin" select="0" />
						<xsl:with-param name="mCnt" select="$mCnt" />
						<xsl:with-param name="mode" select="0" />
						<xsl:with-param name="unit" select="$unit" />
						<xsl:with-param name="form" select="$form" />
					</xsl:call-template>
				</tr>
			</thead>
		<!--</table>-->
</xsl:template>


<!--  指定項目の表出力(項目名付)　  -->
<!--　title:　表の題名　  -->
<!--　unit:単位　　　　   -->
<!--　form:表示形式　　   -->
<!--　item:処理する項目名 -->
<xsl:template match="全体" mode="valueOut_name">
	<xsl:param name="year" select="開始年"/>
	<xsl:param name="mm" select="開始月"/>
	<xsl:param name="mCnt" select="月数"/>
	<xsl:param name="title"/>
	<xsl:param name="item"/>
	<xsl:param name="unit"/>
	<xsl:param name="form"/>
      <thead>
				<tr>
					<th rowspan="2">
            <!--<xsl:value-of select="'項目'"/>
            <br/>
            <br/>-->
            <big>
              <xsl:value-of select="''"/>
              <xsl:value-of select="$title"/>
              <xsl:value-of select="''"/>
            </big>
            </th>
					<th rowspan="2">詳細</th>
					<th rowspan="2">合計</th>
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

			<tbody>
				<xsl:for-each select="プロジェクト">
          <xsl:variable name="pCode" select="pCode"/>
          <xsl:variable name="pName" select="名前"/>
          <xsl:variable name="cnt1" select="count(項目[@name=$item]/詳細)"/>
          <xsl:for-each select="項目[@name=$item]">
						<xsl:for-each select="詳細">
							<tr>
								<xsl:attribute name="pNum">
									<xsl:value-of select="pNum"/>
								</xsl:attribute>
								<xsl:if test="position()=1">
									<td class="L_Item" align="left">
										<xsl:attribute name="rowspan">
											<xsl:value-of select="$cnt1"/>
										</xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:value-of select="$pName"/>
                    </xsl:attribute>
                    <xsl:value-of select="'('"/>
                    <xsl:value-of select="$pCode"/>
                    <xsl:value-of select="') '"/>
                    <xsl:value-of select="$pName"/>
                  </td>
								</xsl:if>
								<td class="pItem">
									<xsl:value-of select="@name"/>
								</td>
								<!--合計-->
								<td class="sum">
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
			</tbody>
      <thead class="dummy_tfoot">
				<tr>
					<td colspan="2">
						<xsl:value-of select="'　'"/>
					</td>
					<td class="sum">
               <xsl:attribute name="nowrap" />
               <xsl:value-of select="format-number(sum(プロジェクト/項目[@name=$item]/詳細/*) div $unit,$form)"/>
					</td>
						<xsl:call-template name="valueOut_Loop_Footer">
							<xsl:with-param name="element" select="プロジェクト/項目[@name=$item]" />
							<xsl:with-param name="item" select="$item" />
							<xsl:with-param name="begin" select="0" />
							<xsl:with-param name="mCnt" select="$mCnt" />
							<xsl:with-param name="mode" select="0" />
							<xsl:with-param name="unit" select="$unit" />
							<xsl:with-param name="form" select="$form" />
						</xsl:call-template>
				</tr>
			</thead>
		<!--</table>-->
</xsl:template>


<!--　データ行の表示　-->
<xsl:template name="valueOut_Loop">
	<xsl:param name="begin" />
	<xsl:param name="mCnt" />
	<xsl:param name="max" select="$begin+$mCnt"/>
	<xsl:param name="cnt" select="$begin"/>
	<xsl:param name="mode" />
	<xsl:param name="unit" />
	<xsl:param name="form"/>
	<xsl:if test="$cnt &lt; $max">
		<td class="num">
		<xsl:attribute name="nowrap" />
			<xsl:if test="sum(月[@m=$cnt])!=0 or $mode = 0">
				<xsl:value-of select="format-number(sum(月[@m=$cnt]) div $unit,$form)"/>
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


<!--　フッター行の表示　-->
<xsl:template name="valueOut_Loop_Footer">
	<xsl:param name="begin" />
	<xsl:param name="mCnt" />
	<xsl:param name="max" select="$begin+$mCnt"/>
	<xsl:param name="cnt" select="$begin"/>
	<xsl:param name="element" />
	<xsl:param name="item" />
	<xsl:param name="mode" />
	<xsl:param name="unit" />
	<xsl:param name="form"/>
	<xsl:if test="$cnt &lt; $max">
		<td class="num">
			<xsl:value-of select="format-number(sum($element[@name=$item]/*/月[@m=$cnt]) div $unit,$form)"/>
		</td>
		<xsl:call-template name="valueOut_Loop_Footer">
			<xsl:with-param name="max" select="$max" />
			<xsl:with-param name="cnt" select="$cnt + 1" />
			<xsl:with-param name="element" select="$element" />
			<xsl:with-param name="item" select="$item" />
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
      <xsl:attribute name="nowrap"/>
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
<xsl:template name="month_Loop">
	<xsl:param name="begin" />
	<xsl:param name="mCnt" />
	<xsl:param name="max" select="$begin+$mCnt"/>
	<xsl:param name="cnt" select="$begin"/>
	<xsl:if test="$cnt &lt; $max">
		<th class="m">
      <xsl:attribute name="nowrap"/>
      <xsl:if test="($cnt mod 12)>0">
        <xsl:value-of select="$cnt mod 12"/>
        <xsl:value-of select="'月'"/>
      </xsl:if>
			<xsl:if test="($cnt mod 12)=0">
				<xsl:value-of select="12"/>
        <xsl:value-of select="'月'"/>
      </xsl:if>
		</th>
		<xsl:call-template name="month_Loop">
			<xsl:with-param name="max" select="$max" />
			<xsl:with-param name="cnt" select="$cnt + 1" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>


  <!--　表示プロジェクトの一覧　-->
  <xsl:template name="projectList">
    <table class="disp" align="center" width="1%">
      <thead>
        <tr>
          <th><xsl:value-of select="'No'"/></th>
          <th><xsl:value-of select="'プロジェクト名'"/></th>
          <th><xsl:value-of select="'コード'"/></th>
          <th><xsl:value-of select="'状態'"/></th>
          <th><xsl:value-of select="'想定工数'"/></th>
          <th><xsl:value-of select="'想定原価'"/></th>
          <th>
            <xsl:value-of select="'作業予定'"/>
          </th>
          <th>
            <xsl:value-of select="'社員工数'"/>
          </th>
          <th>
            <xsl:value-of select="'パート工数'"/>
          </th>
          <th>
            <xsl:value-of select="'業務費用'"/>
          </th>
          <th>
            <xsl:value-of select="'協力費用'"/>
          </th>
          <th>
            <xsl:value-of select="'売上予測'"/>
          </th>
          <th>
            <xsl:value-of select="'売上実績'"/>
          </th>
        </tr>
      </thead>
      <xsl:for-each select="全体/プロジェクト">
        <xsl:sort order="ascending"/>
        <tbody>
          <tr>
            <td class="numH">
              <xsl:value-of select="position()"/>
            </td>
            <td class="corpItem">
              <xsl:value-of select="名前"/>
            </td>
            <td class="sItem">
              <xsl:value-of select="pCode"/>
            </td>
            <td class="sItem">
              <xsl:apply-templates select="状態" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="想定工数" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="想定原価" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="項目[@name='作業予定']" mode="工数" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="項目[@name='社員時間工数']" mode="工数" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="項目[@name='パート時間工数']" mode="工数" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="項目[@name='業務費用']" mode="金額" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="項目[@name='協力費用']" mode="金額" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="項目[@name='売上予測']" mode="金額" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="項目[@name='売上実績']" mode="金額" />
            </td>
          </tr>
        </tbody>
      </xsl:for-each>
      <tbody>
        <tr>
          <td class="pItem" colspan="4">
            <xsl:value-of select="''"/>
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/想定工数" mode="工数合計" />
          </td>
          <td class="sum">
            <xsl:value-of select="''"/>
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/項目[@name='作業予定']" mode="工数合計" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/項目[@name='社員時間工数']" mode="工数合計" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/項目[@name='パート時間工数']" mode="工数合計" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/項目[@name='業務費用']" mode="金額合計" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/項目[@name='協力費用']" mode="金額合計" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/項目[@name='売上予測']" mode="金額合計" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="全体/プロジェクト/項目[@name='売上実績']" mode="金額合計" />
          </td>
        </tr>
      </tbody>
  </table>
  </xsl:template>

  <xsl:template match="想定原価">
    <xsl:if test=" . > 0 ">
      <xsl:value-of select="format-number(.,'#,###')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="想定工数">
    <xsl:if test=" . > 0 ">
      <xsl:value-of select="format-number(. div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="想定工数" mode="工数合計">
    <xsl:param name="element" select="../.." />
    <xsl:param name="name" select="@name" />
    <xsl:if test="position()=1">
      <xsl:value-of select="format-number(sum($element/プロジェクト/想定工数) div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="項目" mode="工数合計">
    <xsl:param name="element" select="../.." />
    <xsl:param name="name" select="@name" />
    <xsl:if test="position()=1">
    <xsl:value-of select="format-number(sum($element/プロジェクト/項目[@name=$name]/詳細/月) div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="項目" mode="金額合計">
    <xsl:param name="element" select="../.." />
    <xsl:param name="name" select="@name" />
    <xsl:if test="position()=1">
      <xsl:value-of select="format-number(sum($element/プロジェクト/項目[@name=$name]/詳細/月) div 1,'#,##0')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="項目" mode="工数">
    <xsl:if test=" sum(詳細/月) > 0 ">
      <xsl:value-of select="format-number(sum(詳細/月) div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="項目" mode="金額">
    <xsl:if test=" sum(詳細/月) > 0 ">
      <xsl:value-of select="format-number(sum(詳細/月) div 1,'#,##0')"/>
    </xsl:if>
  </xsl:template>




  <!--*******＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊-->
  <xsl:template match="状態">
    <xsl:param name="stat" select="." />
    <xsl:choose>
      <!-- 引合中-->
      <xsl:when test="$stat=0">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:green;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'▲'"/>

      </xsl:when>
      <!-- 開発中-->
      <xsl:when test="$stat=1">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:blue;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'●'"/>
      </xsl:when>
      <!-- 開発終了-->
      <xsl:when test="$stat=4">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:gray;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'●'"/>
      </xsl:when>
      <!-- 終了-->
      <xsl:when test="$stat=5">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:gray;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'★'"/>
      </xsl:when>
      <xsl:when test="$stat=-1">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:gray;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'×'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'　'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
