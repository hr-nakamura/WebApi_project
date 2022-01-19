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
<link rel="stylesheet" type="text/css" href="pSub.css"/>
</head>

<body background="bg.gif">
	<xsl:apply-templates select="root" />
</body>
</html>

</xsl:template>

<xsl:template match="root">
	<table class="disp" cellpadding="0" cellspacing="0">
<!--
	<caption>
		<xsl:value-of select="�q��/���O"/>
	</caption>
	<caption>
		<xsl:value-of select="�q��/�v���W�F�N�g/pCode"/>
	</caption>
	<caption>
		<xsl:value-of select="�q��/�v���W�F�N�g/pNum"/>
	</caption>
-->
	<caption>
		<xsl:value-of select="�q��/�v���W�F�N�g/���O"/> (<xsl:value-of select="�q��/�v���W�F�N�g/pCode"/>)
	</caption>
	<thead>
			<xsl:apply-templates select="�q��" mode="headerOut">
			</xsl:apply-templates>
	</thead>
	<tbody>
			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'����\��'" />
				<xsl:with-param name="item" select="'����\��'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

    <!--<xsl:apply-templates select="�q��" mode="valueOut">
      <xsl:with-param name="title" select="'�z��H��'" />
      <xsl:with-param name="item" select="'�z��H��'" />
      <xsl:with-param name="unit" select="100" />
      <xsl:with-param name="form" select="'#,##0.00'" />
    </xsl:apply-templates>
    
    <xsl:apply-templates select="�q��" mode="valueOut">
      <xsl:with-param name="title" select="'��Ɨ\��'" />
      <xsl:with-param name="item" select="'��Ɨ\��'" />
      <xsl:with-param name="unit" select="100" />
      <xsl:with-param name="form" select="'#,##0.00'" />
    </xsl:apply-templates>-->
  </tbody>
	<thead>
			<xsl:apply-templates select="�q��" mode="headerOut">
			</xsl:apply-templates>
	</thead>
	<tbody>
			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�������'" />
				<xsl:with-param name="item" select="'�������'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�Ɩ���p'" />
				<xsl:with-param name="item" select="'�Ɩ���p'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'���͉�Ђ̔�p'" />
				<xsl:with-param name="item" select="'���͔�p'" />
				<xsl:with-param name="unit" select="1000" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>

	</tbody>
	<thead>
			<xsl:apply-templates select="�q��" mode="headerOut">
			</xsl:apply-templates>
	</thead>
	<tbody>
			<!--<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�Ј��̍�Ǝ���'" />
				<xsl:with-param name="item" select="'�Ј�����'" />
				<xsl:with-param name="unit" select="60" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�Ј��̍�Ɠ���'" />
				<xsl:with-param name="item" select="'�Ј�����'" />
				<xsl:with-param name="unit" select="1" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>-->

			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�Ј��̍�ƍH��'" />
				<xsl:with-param name="item" select="'�Ј��H��'" />
				<xsl:with-param name="unit" select="100" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>

			<!--<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�p�[�g�E�_��Ј��̍�Ǝ���'" />
				<xsl:with-param name="item" select="'�p�[�g����'" />
				<xsl:with-param name="unit" select="60" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>

			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�p�[�g�E�_��Ј��̍�Ɠ���'" />
				<xsl:with-param name="item" select="'�p�[�g����'" />
				<xsl:with-param name="unit" select="1" />
				<xsl:with-param name="form" select="'#,##0'" />
			</xsl:apply-templates>-->

			<xsl:apply-templates select="�q��" mode="valueOut">
				<xsl:with-param name="title" select="'�p�[�g�E�_��Ј��̍�ƍH��'" />
				<xsl:with-param name="item" select="'�p�[�g�H��'" />
				<xsl:with-param name="unit" select="100" />
				<xsl:with-param name="form" select="'#,##0.00'" />
			</xsl:apply-templates>
		</tbody>
	</table>
</xsl:template>


<!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->
  <!--  �w�荀�ڂ̗�o�́@  -->
    <!--�@title:�@�\�̑薼�@  -->
    <!--�@unit:�P�ʁ@�@�@�@   -->
    <!--�@form:�\���`���@�@   -->
    <!--�@item:�������鍀�ږ� -->
<xsl:template match="�q��" mode="valueOut">
	<xsl:param name="pNum" select="�v���W�F�N�g/pNum"/>
	<xsl:param name="yymm" select="�v���W�F�N�g/yymm"/>
	<xsl:param name="year" select="�J�n�N"/>
	<xsl:param name="mm" select="�J�n��"/>
	<xsl:param name="mCnt" select="����"/>
	<xsl:param name="title"/>
	<xsl:param name="item"/>
	<xsl:param name="unit"/>
	<xsl:param name="form"/>
	<xsl:for-each select="�v���W�F�N�g">
		<xsl:variable name="cnt1" select="count(����[@name=$item]/�ڍ�)"/>
		<xsl:for-each select="����[@name=$item]">
			<xsl:for-each select="�ڍ�">
				<tr>
					<xsl:attribute name="item"><xsl:value-of select="$item"/></xsl:attribute>
					<xsl:attribute name="pNum"><xsl:value-of select="$pNum"/></xsl:attribute>
					<xsl:attribute name="yymm"><xsl:value-of select="$yymm"/></xsl:attribute>
				<td class="sItem">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="$title"/>
        </td>
				<!--��̍��v-->
				<td id="sumCell">
					<xsl:attribute name="nowrap" />
          <xsl:attribute name="value"><xsl:value-of select="sum(*)"/></xsl:attribute>
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
</xsl:template>

<!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->

<!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->
  <!--  �N���̃w�b�_�[�̕\�o�́@  -->
<xsl:template match="�q��" mode="headerOut">
	<xsl:param name="year" select="�J�n�N"/>
	<xsl:param name="mm" select="�J�n��"/>
	<xsl:param name="mCnt" select="����"/>
		<thead>
			<tr>
				<th rowspan="2">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="'���ږ�'"/>
				</th>
				<th  rowspan="2">
					<xsl:attribute name="nowrap" />
					<xsl:value-of select="'���v'"/>
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
			</thead>
	</xsl:template>

<!--�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@-->


<!--�@�f�[�^�s�̕\���@-->
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
		<td id='Cell'>
			<xsl:attribute name="nowrap" />
			<xsl:attribute name="value"><xsl:value-of select="sum(��[@m=$cnt])"/></xsl:attribute>
			<xsl:attribute name="m"><xsl:value-of select="$cnt"/></xsl:attribute>
			<xsl:if test="sum(��[@m=$cnt])>0 or $mode = 0">
				<xsl:value-of select="format-number(sum(��[@m=$cnt]) div $unit,$form)"/>
			</xsl:if>
<!--
			<xsl:if test="sum(��[@m=$cnt])=0 or $mode = 0">
				<xsl:value-of select="'0'"/>
			</xsl:if>
-->
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




  <!--	�N�̕\��	-->
	
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
			<xsl:value-of select="$year"/>�N
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
			<xsl:attribute name="nowrap" />
				<xsl:if test="($cnt mod 12)>0">
					<xsl:value-of select="$cnt mod 12"/>��
				</xsl:if>
				<xsl:if test="($cnt mod 12)=0">
					<xsl:value-of select="12"/>��
				</xsl:if>
			</th>
				<xsl:call-template name="month_Loop">
					<xsl:with-param name="max" select="$max" />
					<xsl:with-param name="cnt" select="$cnt + 1" />
				</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
