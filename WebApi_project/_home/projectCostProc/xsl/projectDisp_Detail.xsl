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
<title>�v���W�F�N�g�W�v(�ڍ�)</title>
</head>

<body background="bg.gif">
<xsl:apply-templates select="root" />
</body>
</html>

</xsl:template>

<xsl:template match="root">
  <xsl:variable name="mCnt" select="//����"/>
  <xsl:variable name="yymm" select="//yymm"/>
	<xsl:variable name="D_�������" select="//�\������/�������"/>
  <xsl:variable name="D_�Ɩ���p" select="//�\������/�Ɩ���p"/>
  <xsl:variable name="D_���͔�p" select="//�\������/���͔�p"/>
  <xsl:variable name="D_���͍H��" select="//�\������/���͍H��"/>
  <xsl:variable name="D_�Ј��H��" select="//�\������/�Ј��H��"/>
  <xsl:variable name="D_�p�[�g�H��" select="//�\������/�p�[�g�H��"/>
  <xsl:variable name="D_�J����" select="//�\������/�J����"/>


  <table ID="DETAIL" class="disp" align="center" border="0" width="1%">
		    <caption style="white-space:nowrap">
          <xsl:value-of select="�S��/�v���W�F�N�g/���O"/>
          <xsl:value-of select="'�@('"/>
          <xsl:value-of select="�S��/�v���W�F�N�g/pCode"/>
          <xsl:value-of select="')'"/>
        </caption>
	  		<xsl:if test="$D_������� = 1">
					<xsl:apply-templates select="�S��" mode="valueOut_name">
						<xsl:with-param name="title" select="'�������'" />
						<xsl:with-param name="item" select="'�������'" />
						<xsl:with-param name="unit" select="1" />
						<xsl:with-param name="form" select="'#,##0'" />
					</xsl:apply-templates>
		  	</xsl:if>
    <xsl:if test="$D_�J���� = 1">
      <xsl:apply-templates select="�S��" mode="valueOut_name">
        <xsl:with-param name="title" select="'�J����'" />
        <xsl:with-param name="item" select="'�J����'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="form" select="'#,##0'" />
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="$D_�Ɩ���p = 1">
      <xsl:apply-templates select="�S��" mode="valueOut_name">
        <xsl:with-param name="title" select="'�Ɩ���p'" />
        <xsl:with-param name="item" select="'�Ɩ���p'" />
        <xsl:with-param name="unit" select="1" />
        <xsl:with-param name="form" select="'#,##0'" />
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="$D_���͔�p = 1">
            <xsl:apply-templates select="�S��" mode="valueOut_name">
              <xsl:with-param name="title" select="'���͔�p'" />
              <xsl:with-param name="item" select="'���͔�p'" />
              <xsl:with-param name="unit" select="1" />
              <xsl:with-param name="form" select="'#,##0'" />
            </xsl:apply-templates>
          </xsl:if>
          <xsl:if test="$D_���͍H�� = 1">
            <xsl:apply-templates select="�S��" mode="valueOut_name">
              <xsl:with-param name="title" select="'���͍H��'" />
              <xsl:with-param name="item" select="'���͍H��'" />
              <xsl:with-param name="unit" select="100" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>
          </xsl:if>
          <xsl:if test="$D_�Ј��H�� = 1">
            <xsl:apply-templates select="�S��" mode="valueOut_name">
              <xsl:with-param name="title" select="'�Ј��H��'" />
              <xsl:with-param name="item" select="'�Ј��H��'" />
              <xsl:with-param name="unit" select="100" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>
					<!--<xsl:apply-templates select="�S��" mode="valueOut_name">
						<xsl:with-param name="title" select="'�Ј���Ǝ���'" />
						<xsl:with-param name="item" select="'�Ј�����'" />
						<xsl:with-param name="unit" select="60" />
						<xsl:with-param name="form" select="'#,##0.00'" />
					</xsl:apply-templates>-->
			  </xsl:if>
          <xsl:if test="$D_�p�[�g�H�� = 1">
            <xsl:apply-templates select="�S��" mode="valueOut_name">
              <xsl:with-param name="title" select="'�p�[�g�H��'" />
              <xsl:with-param name="item" select="'�p�[�g�H��'" />
              <xsl:with-param name="unit" select="100" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>
            <!--<xsl:apply-templates select="�S��" mode="valueOut_name">
              <xsl:with-param name="title" select="'�p�[�g��Ǝ���'" />
              <xsl:with-param name="item" select="'�p�[�g����'" />
              <xsl:with-param name="unit" select="60" />
              <xsl:with-param name="form" select="'#,##0.00'" />
            </xsl:apply-templates>-->
          </xsl:if>
      	</table>
</xsl:template>


<!--  �w�荀�ڂ̕\�o�́@  -->
<!--�@title:�@�\�̑薼�@  -->
<!--�@unit:�P�ʁ@�@�@�@   -->
<!--�@form:�\���`���@�@   -->
<!--�@item:�������鍀�ږ� -->
<xsl:template match="�S��" mode="valueOut">
	<xsl:param name="year" select="�J�n�N"/>
	<xsl:param name="mm" select="�J�n��"/>
	<xsl:param name="mCnt" select="����"/>
	<xsl:param name="title"/>
	<xsl:param name="item"/>
	<xsl:param name="unit"/>
	<xsl:param name="form"/>
      <thead>
				<tr>
          <th rowspan="2" colspan="2">����</th>
          <th rowspan="2">���v</th>
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
				<xsl:for-each select="�v���W�F�N�g">
					<xsl:variable name="cnt1" select="count(����[@name=$item]/�ڍ�)"/>
					<xsl:for-each select="����[@name=$item]">
						<xsl:for-each select="�ڍ�">
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
								<!--���v-->
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
                        <xsl:value-of select="'�@'"/>
					</td>
					<td class="sum">
						<xsl:value-of select="format-number(sum(�v���W�F�N�g/����[@name=$item]/�ڍ�/*) div $unit,$form)"/>
					</td>
					<xsl:call-template name="valueOut_Loop_Footer">
						<xsl:with-param name="element" select="�v���W�F�N�g/����[@name=$item]" />
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


<!--  �w�荀�ڂ̕\�o��(���ږ��t)�@  -->
<!--�@title:�@�\�̑薼�@  -->
<!--�@unit:�P�ʁ@�@�@�@   -->
<!--�@form:�\���`���@�@   -->
<!--�@item:�������鍀�ږ� -->
<xsl:template match="�S��" mode="valueOut_name">
	<xsl:param name="year" select="�J�n�N"/>
	<xsl:param name="mm" select="�J�n��"/>
	<xsl:param name="mCnt" select="����"/>
	<xsl:param name="title"/>
	<xsl:param name="item"/>
	<xsl:param name="unit"/>
	<xsl:param name="form"/>
      <thead>
				<tr>
					<th rowspan="2">
            <!--<xsl:value-of select="'����'"/>
            <br/>
            <br/>-->
            <big>
              <xsl:value-of select="''"/>
              <xsl:value-of select="$title"/>
              <xsl:value-of select="''"/>
            </big>
            </th>
					<th rowspan="2">�ڍ�</th>
					<th rowspan="2">���v</th>
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
				<xsl:for-each select="�v���W�F�N�g">
          <xsl:variable name="pCode" select="pCode"/>
          <xsl:variable name="pName" select="���O"/>
          <xsl:variable name="cnt1" select="count(����[@name=$item]/�ڍ�)"/>
          <xsl:for-each select="����[@name=$item]">
						<xsl:for-each select="�ڍ�">
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
								<!--���v-->
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
						<xsl:value-of select="'�@'"/>
					</td>
					<td class="sum">
               <xsl:attribute name="nowrap" />
               <xsl:value-of select="format-number(sum(�v���W�F�N�g/����[@name=$item]/�ڍ�/*) div $unit,$form)"/>
					</td>
						<xsl:call-template name="valueOut_Loop_Footer">
							<xsl:with-param name="element" select="�v���W�F�N�g/����[@name=$item]" />
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


<!--�@�f�[�^�s�̕\���@-->
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
			<xsl:if test="sum(��[@m=$cnt])!=0 or $mode = 0">
				<xsl:value-of select="format-number(sum(��[@m=$cnt]) div $unit,$form)"/>
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


<!--�@�t�b�^�[�s�̕\���@-->
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
			<xsl:value-of select="format-number(sum($element[@name=$item]/*/��[@m=$cnt]) div $unit,$form)"/>
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




  <!--	�N�̕\��	-->
	
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
      <xsl:value-of select="'�N'"/>
    </th>
			<xsl:call-template name="year_Loop">
				<xsl:with-param name="year" select="$year+1" />
				<xsl:with-param name="mCnt" select="$mCnt - $cnt" />
				<xsl:with-param name="cnt" select="12" />
			</xsl:call-template>
	</xsl:if>
</xsl:template>

	
<!--	���̕\��	-->
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
        <xsl:value-of select="'��'"/>
      </xsl:if>
			<xsl:if test="($cnt mod 12)=0">
				<xsl:value-of select="12"/>
        <xsl:value-of select="'��'"/>
      </xsl:if>
		</th>
		<xsl:call-template name="month_Loop">
			<xsl:with-param name="max" select="$max" />
			<xsl:with-param name="cnt" select="$cnt + 1" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>


  <!--�@�\���v���W�F�N�g�̈ꗗ�@-->
  <xsl:template name="projectList">
    <table class="disp" align="center" width="1%">
      <thead>
        <tr>
          <th><xsl:value-of select="'No'"/></th>
          <th><xsl:value-of select="'�v���W�F�N�g��'"/></th>
          <th><xsl:value-of select="'�R�[�h'"/></th>
          <th><xsl:value-of select="'���'"/></th>
          <th><xsl:value-of select="'�z��H��'"/></th>
          <th><xsl:value-of select="'�z�茴��'"/></th>
          <th>
            <xsl:value-of select="'��Ɨ\��'"/>
          </th>
          <th>
            <xsl:value-of select="'�Ј��H��'"/>
          </th>
          <th>
            <xsl:value-of select="'�p�[�g�H��'"/>
          </th>
          <th>
            <xsl:value-of select="'�Ɩ���p'"/>
          </th>
          <th>
            <xsl:value-of select="'���͔�p'"/>
          </th>
          <th>
            <xsl:value-of select="'����\��'"/>
          </th>
          <th>
            <xsl:value-of select="'�������'"/>
          </th>
        </tr>
      </thead>
      <xsl:for-each select="�S��/�v���W�F�N�g">
        <xsl:sort order="ascending"/>
        <tbody>
          <tr>
            <td class="numH">
              <xsl:value-of select="position()"/>
            </td>
            <td class="corpItem">
              <xsl:value-of select="���O"/>
            </td>
            <td class="sItem">
              <xsl:value-of select="pCode"/>
            </td>
            <td class="sItem">
              <xsl:apply-templates select="���" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="�z��H��" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="�z�茴��" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="����[@name='��Ɨ\��']" mode="�H��" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="����[@name='�Ј����ԍH��']" mode="�H��" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="����[@name='�p�[�g���ԍH��']" mode="�H��" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="����[@name='�Ɩ���p']" mode="���z" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="����[@name='���͔�p']" mode="���z" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="����[@name='����\��']" mode="���z" />
            </td>
            <td class="sum">
              <xsl:apply-templates select="����[@name='�������']" mode="���z" />
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
            <xsl:apply-templates select="�S��/�v���W�F�N�g/�z��H��" mode="�H�����v" />
          </td>
          <td class="sum">
            <xsl:value-of select="''"/>
          </td>
          <td class="sum">
            <xsl:apply-templates select="�S��/�v���W�F�N�g/����[@name='��Ɨ\��']" mode="�H�����v" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="�S��/�v���W�F�N�g/����[@name='�Ј����ԍH��']" mode="�H�����v" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="�S��/�v���W�F�N�g/����[@name='�p�[�g���ԍH��']" mode="�H�����v" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="�S��/�v���W�F�N�g/����[@name='�Ɩ���p']" mode="���z���v" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="�S��/�v���W�F�N�g/����[@name='���͔�p']" mode="���z���v" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="�S��/�v���W�F�N�g/����[@name='����\��']" mode="���z���v" />
          </td>
          <td class="sum">
            <xsl:apply-templates select="�S��/�v���W�F�N�g/����[@name='�������']" mode="���z���v" />
          </td>
        </tr>
      </tbody>
  </table>
  </xsl:template>

  <xsl:template match="�z�茴��">
    <xsl:if test=" . > 0 ">
      <xsl:value-of select="format-number(.,'#,###')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="�z��H��">
    <xsl:if test=" . > 0 ">
      <xsl:value-of select="format-number(. div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="�z��H��" mode="�H�����v">
    <xsl:param name="element" select="../.." />
    <xsl:param name="name" select="@name" />
    <xsl:if test="position()=1">
      <xsl:value-of select="format-number(sum($element/�v���W�F�N�g/�z��H��) div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="����" mode="�H�����v">
    <xsl:param name="element" select="../.." />
    <xsl:param name="name" select="@name" />
    <xsl:if test="position()=1">
    <xsl:value-of select="format-number(sum($element/�v���W�F�N�g/����[@name=$name]/�ڍ�/��) div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="����" mode="���z���v">
    <xsl:param name="element" select="../.." />
    <xsl:param name="name" select="@name" />
    <xsl:if test="position()=1">
      <xsl:value-of select="format-number(sum($element/�v���W�F�N�g/����[@name=$name]/�ڍ�/��) div 1,'#,##0')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="����" mode="�H��">
    <xsl:if test=" sum(�ڍ�/��) > 0 ">
      <xsl:value-of select="format-number(sum(�ڍ�/��) div 100,'0.00')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="����" mode="���z">
    <xsl:if test=" sum(�ڍ�/��) > 0 ">
      <xsl:value-of select="format-number(sum(�ڍ�/��) div 1,'#,##0')"/>
    </xsl:if>
  </xsl:template>




  <!--*******������������������������������-->
  <xsl:template match="���">
    <xsl:param name="stat" select="." />
    <xsl:choose>
      <!-- ������-->
      <xsl:when test="$stat=0">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:green;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'��'"/>

      </xsl:when>
      <!-- �J����-->
      <xsl:when test="$stat=1">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:blue;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'��'"/>
      </xsl:when>
      <!-- �J���I��-->
      <xsl:when test="$stat=4">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:gray;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'��'"/>
      </xsl:when>
      <!-- �I��-->
      <xsl:when test="$stat=5">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:gray;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'��'"/>
      </xsl:when>
      <xsl:when test="$stat=-1">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:gray;text-align:center;font-size:smaller;'"/>
        </xsl:attribute>
        <xsl:value-of select="'�~'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'�@'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
