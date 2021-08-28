<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:user="mynamespace">
    
<xsl:variable name="modeInfo">
  <xsl:value-of select="/root/modeInfo"/>
  </xsl:variable>
  <xsl:template match="/">
    <html>
	    <body>
        <xsl:apply-templates select="root" />
        <br/>
		<xsl:call-template name="modeOut">
			<xsl:with-param name="mode" select="$modeInfo"/>
		</xsl:call-template>
        </body>
	</html>
</xsl:template>


<xsl:template match="root">
  <xsl:for-each select="列">
    <div class="列" style="display:none">
      <xsl:for-each select="block">
        <div class="block" style="display:none">
          <xsl:if test="@memo !=''">
            <xsl:attribute name="title">
              <xsl:value-of select="@memo"/>
            </xsl:attribute>
          </xsl:if>
          <fieldset>
            <legend>
              <xsl:value-of select="@name"/>
                <!--
                <xsl:value-of select="'('"/>
                <xsl:value-of select="count(menu)"/>
                <xsl:value-of select="')'"/>
                -->
                </legend>
              <xsl:for-each select="menu">
                <div class="content" style="display:none">
                  <xsl:for-each select="*">
                    <xsl:choose>
                      <xsl:when test="translate(name(),'A','a')='a'">
						  <xsl:variable name="mode">
							  <xsl:value-of select="'['"/>
							  <xsl:value-of select="@mode"/>
							  <xsl:value-of select="']'"/>
						  </xsl:variable>
						  <xsl:variable name="test">
							  <xsl:value-of select="'['"/>
							  <xsl:value-of select="@test"/>
							  <xsl:value-of select="']'"/>
						  </xsl:variable>
						  <xsl:if test="contains($modeInfo,$mode) or contains($modeInfo,$test)">
                          <xsl:copy-of select="."/>
                        </xsl:if>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:copy-of select="."/>
                      </xsl:otherwise>
                    </xsl:choose>

                  </xsl:for-each>
                </div>
              </xsl:for-each>
            </fieldset>
        </div>
      </xsl:for-each>
    </div>
  </xsl:for-each>
</xsl:template>

	<xsl:template name="modeOut">
		<xsl:param name="mode"/>
		<div class="modeInfo" style="text-align:left;display:none;">
			<xsl:call-template name="tokenizeString">
				<xsl:with-param name="list" select="$mode"/>
				<xsl:with-param name="delimiter" select="']['"/>
			</xsl:call-template>
		</div>
	</xsl:template>
	<xsl:template name="tokenizeString">
		<xsl:param name="list"/>
		<xsl:param name="delimiter"/>
		<xsl:choose>
			<xsl:when test="contains($list, $delimiter)">
				<xsl:variable name="listLength" select="string-length($list)" />
				<xsl:variable name="listLengthWithoutDelimiters" select="string-length(translate($list, $delimiter,''))" />
				<xsl:variable name="noOfDelimiters" select="($listLength - $listLengthWithoutDelimiters)" />

				<xsl:value-of select="substring-before($list,$delimiter)"/>
				<xsl:if test="$noOfDelimiters > 1">
					<xsl:value-of select="']'"/>
					<br/>
					<xsl:value-of select="'['"/>
				</xsl:if>
				<xsl:if test="$noOfDelimiters = 1"> and </xsl:if>
				<xsl:call-template name="tokenizeString">
					<xsl:with-param name="list" select="substring-after($list,$delimiter)"/>
					<xsl:with-param name="delimiter" select="$delimiter"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$list = ''">
						<xsl:text/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$list"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
  