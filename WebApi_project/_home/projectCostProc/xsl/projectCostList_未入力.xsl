<?xml version="1.0" encoding="shift_jis" ?>
<!--	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">	-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	xmlns:user="mynamespace">

  <xsl:variable name="NoData-color">background-color:silver;</xsl:variable>
  <xsl:variable name="mode" select="'�\��'"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>�v���W�F�N�g</title>
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
            <xsl:value-of select="���"/>
          </B>
          <br/>
          <small>
            <xsl:value-of select="''"/>
            <xsl:value-of select="����"/>
            <xsl:value-of select="''"/>
            <br/>
            <!--<br/>
            <font style="color:darksalmon">
              <B>
              <xsl:value-of select="'������ '"/>
              </B>
              <xsl:value-of select="'�F ���ь����߂��ĉғ����Ă���v���W�F�N�g�̏ꍇ�A'"/>
              <br/>
            <xsl:value-of select="'�z��H������Ɨ\����Ԃ̊e���ɕ��z���Ȃ��Ɗm���Ȑ��l�ɂȂ�܂���B'"/>
            </font>-->
          </small>
        </div>
      </caption>
      <tr>
        <td>
          <xsl:apply-templates select="�S��" />
        </td>
      </tr>
    </table>

  </xsl:template>

  <xsl:template match="�S��">
    <table class="disp" cellpadding="0" cellspacing="0" width="100%">
      <caption>
            <DIV align="right">
              <xsl:value-of select="'�\�����F'"/>
                  <xsl:value-of select="count(�v���W�F�N�g)"/>
            </DIV>
          </caption>
      <thead>
        <xsl:call-template name="HEAD"/>
      </thead>

      <!--<thead>
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="�v���W�F�N�g" />
            </xsl:call-template>
      </thead>-->

      <tbody>
            <xsl:for-each select="�v���W�F�N�g">
              <xsl:sort select="������[@mode=$mode]" data-type="number" order="descending"/>
              <xsl:apply-templates select=".">
                <xsl:with-param name="pos" select="position()" />
              </xsl:apply-templates>
            </xsl:for-each>
      </tbody>

      <!--<tfoot>
            <xsl:call-template name="FOOT">
              <xsl:with-param name="project" select="�v���W�F�N�g" />
            </xsl:call-template>
      </tfoot>-->
  </table>
  </xsl:template>

  <xsl:template name="HEAD">
    <tr>
      <th>
        <xsl:value-of select="'No'"/>
      </th>
      <th>
        <xsl:value-of select="'�v���W�F�N�g��'"/>
      </th>
      <th>
        <xsl:value-of select="'�R�[�h'"/>
      </th>
      <th>
        <xsl:value-of select="'�O���[�v��'"/>
      </th>
      <th>
        <xsl:value-of select="'��'"/>
        <br/>
        <xsl:value-of select="'��'"/>
      </th>
      <th>
        <xsl:value-of select="'�m'"/>
        <br/>
        <xsl:value-of select="'�x'"/>
      </th>
      <!--<th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'text'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'�z��H�������z/@���R'"/>
        </xsl:attribute>
        <xsl:value-of select="'�H��'"/>
        <br/>
        <xsl:value-of select="'���z'"/>
      </th>-->
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'�J�n��'"/>
        </xsl:attribute>
        <xsl:value-of select="'�J�n��'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'�I����'"/>
        </xsl:attribute>
        <xsl:value-of select="'�I����'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'text'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'���ޖ�'"/>
        </xsl:attribute>
        <xsl:value-of select="'���ޖ�'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'text'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'PM��'"/>
        </xsl:attribute>
        <xsl:value-of select="'�S��PM'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'text'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'�c�ƒS��'"/>
        </xsl:attribute>
        <xsl:value-of select="'�c�ƒS��'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'�z��H��'"/>
        </xsl:attribute>
        <xsl:value-of select="'�z��H��'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'���ύH��'"/>
        </xsl:attribute>
        <xsl:value-of select="'���ύH��'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'�_��H��'"/>
        </xsl:attribute>
        <xsl:value-of select="'�_��H��'"/>
      </th>
      <!--<th style="padding:2 16 2 16;">
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'���v[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'���v'"/>
      </th>
      <th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'������[@mode=$mode]'"/>
        </xsl:attribute>
        <xsl:value-of select="'������'"/>
      </th>-->
      <!--<th>
        <xsl:attribute name="id">
          <xsl:value-of select="'sOrder'"/>
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="'number'"/>
        </xsl:attribute>
        <xsl:attribute name="order_name">
          <xsl:value-of select="'�f����/���v'"/>
        </xsl:attribute>
        <xsl:value-of select="'��'"/>
      </th>-->
    </tr>
  </xsl:template>

  <xsl:template name="FOOT">
    <xsl:param name="project"/>
    <tr>
      <td class="pItem" colspan="5" style="text-align:right">
        <xsl:value-of select="'���v'"/>
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
      </td>
      <td class="R_Foot">
        <xsl:call-template name="���v_�v">
          <xsl:with-param name="project" select="$project"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
        <xsl:call-template name="������_�v">
          <xsl:with-param name="project" select="$project"/>
        </xsl:call-template>
      </td>
      <td class="R_Foot">
      </td>

    </tr>
  </xsl:template>

  <xsl:template name="���v_�v">
    <xsl:param name="project" />
    <xsl:variable name="value1" select="sum($project/����[@mode=$mode])"/>
    <xsl:variable name="value2" select="sum($project/����[@mode=$mode])"/>
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

  <xsl:template name="������_�v">
    <xsl:param name="project" />
    <xsl:variable name="value1" select="sum($project/����[@mode=$mode])"/>
    <xsl:variable name="value2" select="sum($project/����[@mode=$mode])"/>
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

  <xsl:template match="�v���W�F�N�g">
    <xsl:param name="pos" />
      <tr>
        <td class="C_Item">
          <xsl:value-of select="$pos"/>
        </td>
        <td class="corpItem" id="pNum-Cell">
          <xsl:attribute name="pNum">
            <xsl:value-of select="pNum"/>
          </xsl:attribute>
          <xsl:apply-templates select="���O"/>
        </td>
        <td class="C_Item" id="pCode">
          <xsl:apply-templates select="pCode"/>
        </td>
        <td class="L_Item" id="gName">
          <xsl:apply-templates select="gName"/>
        </td>
        <td class="C_Item">
          <xsl:call-template name="���">
            <xsl:with-param name="stat" select="���"/>
          </xsl:call-template>
        </td>
        <td class="C_Item">
          <xsl:apply-templates select="�m�x"/>
        </td>
        <!--<td class="C_Item">
          <xsl:apply-templates select="�z��H�������z"/>
        </td>-->
        <td class="C_Item">
          <xsl:apply-templates select="�C�x���g�J�n"/>
        </td>
        <td class="C_Item">
          <xsl:apply-templates select="�C�x���g�I��"/>
        </td>
        <td class="C_Item">
          <!-- ���ޖ� -->
          <xsl:apply-templates select="���ޖ�"/>
        </td>
        <td class="C_Item">
          <!-- �S��PM -->
          <xsl:apply-templates select="PM��"/>
        </td>
        <td class="C_Item">
          <!-- �c�ƒS�� -->
          <xsl:apply-templates select="�c�ƒS��"/>
        </td>
        <td class="num">
          <!-- �z��H�� -->
          <xsl:call-template name="value_Out_Check">
            <xsl:with-param name="value" select="�z��H��"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- ���ύH�� -->
          <xsl:call-template name="value_Out_Check">
            <xsl:with-param name="value" select="���ύH��"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          <!-- �_��H�� -->
          <xsl:call-template name="value_Out_Check">
            <xsl:with-param name="value" select="�_��H��"/>
            <xsl:with-param name="unit" select="100"/>
            <xsl:with-param name="form" select="'#,##0.00'"/>
          </xsl:call-template>
        </td>
        <!--<td class="num">
          --><!-- ���v --><!--
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="���v[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1000"/>
            <xsl:with-param name="form" select="'#,##0'"/>
          </xsl:call-template>
        </td>
        <td class="num">
          --><!-- ������ --><!--
          <xsl:call-template name="value_Out">
            <xsl:with-param name="value" select="������[@mode=$mode]"/>
            <xsl:with-param name="unit" select="1"/>
            <xsl:with-param name="form" select="'0%'"/>
          </xsl:call-template>
        </td>-->
        <!--<td class="C_Item">
          <xsl:apply-templates select="�f����">
            <xsl:with-param name="pNum" select="pNum"/>
          </xsl:apply-templates>
        </td>-->
      </tr>
 </xsl:template>

  <xsl:template match="���ޖ�">
    <xsl:choose>
      <xsl:when test=". = '���ݒ�' ">
        <xsl:attribute name="style">
          <xsl:value-of select="$NoData-color"/>
        </xsl:attribute>
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�z��H�������z">
    <xsl:attribute name="title">
      <xsl:value-of select="@���R"/>
    </xsl:attribute>
    <xsl:choose>
      <xsl:when test=". = '�K�v' ">
        <xsl:attribute name="style">
          <xsl:value-of select="$NoData-color"/>
        </xsl:attribute>
        <!--<xsl:value-of select="'�v'"/>-->
      </xsl:when>
      <xsl:otherwise>
        <!--<xsl:value-of select="''"/>-->
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="@���R = '�����z' ">
        <xsl:value-of select="'�v1'"/>
      </xsl:when>
      <xsl:when test="@���R = '�J�n���Ⴂ' ">
        <xsl:value-of select="'�v2'"/>
      </xsl:when>
      <xsl:when test="@���R = '�H���Ȃ�' ">
        <xsl:value-of select="'�v3'"/>
      </xsl:when>
      <xsl:when test="@���R = '�����f�[�^' ">
        <xsl:value-of select="'�v4'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="''"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="PM��">
    <xsl:choose>
      <xsl:when test=". = '���ݒ�' ">
        <xsl:attribute name="style">
          <xsl:value-of select="$NoData-color"/>
        </xsl:attribute>
        <xsl:value-of select="''"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�c�ƒS��">
    <xsl:choose>
      <xsl:when test=". = '' ">
        <xsl:attribute name="style">
          <xsl:value-of select="$NoData-color"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="."/>
  </xsl:template>


  <xsl:template match="���O">
    <!--<xsl:value-of select="string-length(.)"/>-->
    <!--<xsl:value-of select="."/>-->
    <!--<br/>-->
    <xsl:attribute name="memo">
      <xsl:value-of select="'�y '"/>
      <xsl:value-of select="../gName"/>
      <xsl:value-of select="' �z�@'"/>
      <xsl:value-of select="'['"/>
      <xsl:value-of select="../PM��"/>
      <xsl:value-of select="']�@'"/>
      <xsl:value-of select="'['"/>
      <xsl:value-of select="../�c�ƒS��"/>
      <xsl:value-of select="']�@'"/>
      <xsl:value-of select="'['"/>
      <xsl:value-of select="../���ޖ�"/>
      <xsl:value-of select="']'"/>
    </xsl:attribute>
    <xsl:variable name="sLen" select="120"/>
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

  <xsl:template match="�C�x���g�J�n">
    <xsl:choose>
      <xsl:when test=" ���t != '' ">
        <xsl:value-of select="���t"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="style">
          <xsl:value-of select="$NoData-color"/>
        </xsl:attribute>
        <xsl:value-of select="'�@'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�C�x���g�I��">
    <xsl:variable name="�A���[�g" select="../���t�A���[�g"/>
    <xsl:choose>
      <xsl:when test=" ���t != '' ">
        <xsl:if test="$�A���[�g=1 or $�A���[�g=2">
          <xsl:attribute name="style">
            <xsl:value-of select="'color:tomato'"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="���t"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="style">
          <xsl:value-of select="$NoData-color"/>
        </xsl:attribute>
        <xsl:value-of select="'�@'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="value_Out_Check">
    <xsl:param name="value"/>
    <xsl:param name="unit"/>
    <xsl:param name="form"/>
    <xsl:choose>
      <xsl:when test="$value = 0 or $value = ''">
        <xsl:attribute name="style">
          <xsl:value-of select="$NoData-color"/>
        </xsl:attribute>
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

  <!--*******������������������������������-->
  <xsl:template match="pCode">
    <xsl:variable name="�A���[�g" select="../���t�A���[�g"/>

    <xsl:attribute name="memo">
      <xsl:value-of select="'�ŏI�H���F'"/>
      <xsl:value-of select="../�ŏI��"/>
    </xsl:attribute>
    <xsl:choose>
      <xsl:when test="$�A���[�g=2">
        <xsl:attribute name="style">
          <xsl:value-of select="'background-color:pink;'"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="$�A���[�g=3">
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

  <xsl:template name="���">
    <xsl:param name="stat"/>
    <xsl:choose>
      <!-- ������-->
      <xsl:when test="$stat=0">
        <xsl:attribute name="title">
          <xsl:value-of select="'������'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:green;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </span>
      </xsl:when>
      <!-- �J����-->
      <xsl:when test="$stat=1">
        <xsl:attribute name="title">
          <xsl:value-of select="'�J����'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:blue;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </span>
      </xsl:when>
      <!-- �J���I��-->
      <xsl:when test="$stat=4">
        <xsl:attribute name="title">
          <xsl:value-of select="'�J���I��'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:blue;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </span>
      </xsl:when>
      <!-- �I��-->
      <xsl:when test="$stat=5">
        <xsl:attribute name="title">
          <xsl:value-of select="'�I��'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=8">
        <xsl:attribute name="title">
          <xsl:value-of select="'��'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
        <xsl:value-of select="'��'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=9">
        <xsl:attribute name="title">
          <xsl:value-of select="'�v'"/>
        </xsl:attribute>
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'�~'"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'�@'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="�m�x">
    <xsl:choose>
      <xsl:when test=".=10">
        <xsl:attribute name="style">
          <xsl:value-of select="'color:gray;text-align:right;'"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="style">
          <xsl:value-of select="'text-align:right;'"/>
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="�_��">
    <xsl:param name="stat" select="." />
    <xsl:choose>
      <xsl:when test="$stat=0">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'�@'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=1">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'�@'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="����">
    <xsl:param name="stat" select="." />
    <xsl:choose>
      <xsl:when test="$stat=0">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'�@'"/>
        </span>
      </xsl:when>
      <xsl:when test="$stat=1">
        <span>
          <xsl:attribute name="style">
            <xsl:value-of select="'color:gray;text-align:center;'"/>
          </xsl:attribute>
          <xsl:value-of select="'��'"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'�@'"/>
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
            <xsl:value-of select="'�\��'"/>
          </th>
          <th>
            <xsl:value-of select="'����'"/>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="l_Item">
            <xsl:attribute name="style">
              <xsl:value-of select="'color:tomato'"/>
            </xsl:attribute>
            <xsl:value-of select="'�I�����̓��t����'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'[�ŏI�H��]��[�I����]����ɔ���'"/>
          </td>
        </tr>
        <tr>
          <td class="l_Item">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:pink;'"/>
            </xsl:attribute>
            <xsl:value-of select="'�v���W�F�N�g�R�[�h���W����'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'[�ŏI�H��]��[�I����]�E[���ь�]����ɔ���'"/>
          </td>
        </tr>
        <tr>
          <td class="l_Item">
            <xsl:attribute name="style">
              <xsl:value-of select="'background-color:tomato;'"/>
            </xsl:attribute>
            <xsl:value-of select="'�v���W�F�N�g�R�[�h����'"/>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'[�ŏI�H��]��[���ь�]����ɔ����i[�I����]�����ݒ�j'"/>
          </td>
        </tr>
      </tbody>
    </table>
    <hr/>
    <table class="disp">
        <thead>
          <tr>
            <th style="padding:4">
              <xsl:value-of select="'�\��'"/>
            </th>
            <th style="padding:4">
              <xsl:value-of select="'����'"/>
            </th>
          </tr>
        </thead>
        <tbody>
        <tr>
          <td class="c_Item">
            <xsl:call-template name="���">
              <xsl:with-param name="stat" select="0"/>
            </xsl:call-template>
          </td>
          <td class="l_Item">
            <xsl:value-of select="'������'"/>
          </td>
        </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="���">
                <xsl:with-param name="stat" select="1"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'�J����'"/>
            </td>
          </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="���">
                <xsl:with-param name="stat" select="4"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'�J���I���i��ƏI���j'"/>
            </td>
          </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="���">
                <xsl:with-param name="stat" select="5"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'�I���i��ƁE���������I���j'"/>
            </td>
          </tr>
          <tr>
            <td class="c_Item">
              <xsl:call-template name="���">
                <xsl:with-param name="stat" select="9"/>
              </xsl:call-template>
            </td>
            <td class="l_Item">
              <xsl:value-of select="'�v'"/>
            </td>
          </tr>
        </tbody>
    </table>

        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="�f����">
    <xsl:param name="pNum"/>
    <div>
      <input type="button" id="memo" value="��">
        <xsl:attribute name="pNum">
          <xsl:value-of select="$pNum"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="�ŐV &gt; 0 ">
            <xsl:attribute name="style">
              <xsl:value-of select="'color:tomato;font-weight:bold;'"/>
              <!--<xsl:value-of select="'color:blue;background-color:gainsboro'"/>-->
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:value-of select="�ŐV"/>
              <xsl:value-of select="'/'"/>
              <xsl:value-of select="���v"/>
              <xsl:value-of select="'��'"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:when test="���v &gt; 0 ">
            <xsl:attribute name="style">
              <xsl:value-of select="'color:royalblue;font-weight:bold;'"/>
              <!--<xsl:value-of select="'color:blue;background-color:gainsboro'"/>-->
            </xsl:attribute>
            <xsl:attribute name="title">
              <xsl:value-of select="�ŐV"/>
              <xsl:value-of select="'/'"/>
              <xsl:value-of select="���v"/>
              <xsl:value-of select="'��'"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
          </xsl:otherwise>
        </xsl:choose>
      </input>
      <xsl:if test=". &gt; 0 ">
        <span style="display:none">
          <xsl:value-of select="���v"/>
        </span>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="���[�����M">
    <xsl:param name="pNum"/>
    <div>
      <input type="button" id="mail" value="�쐬">
        <xsl:attribute name="pNum">
          <xsl:value-of select="$pNum"/>
        </xsl:attribute>
      </input>
    </div>
  </xsl:template>



  <xsl:include href="sub_JScript.xsl"/>

</xsl:stylesheet>