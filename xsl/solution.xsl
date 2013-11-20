<?xml version="1.0"?> 

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">

  <xsl:template match="size">
    <result>
      <xsl:call-template name="queens">
        <xsl:with-param name="r"/>
        <xsl:with-param name="n" select="."/>
        <xsl:with-param name="s" select="."/>
      </xsl:call-template>
    </result>
  </xsl:template>

  <xsl:template name="queens">
    <xsl:param name="r"/>
    <xsl:param name="n"/>
    <xsl:param name="s"/>
    <xsl:choose>
      <xsl:when test="$n = 0">
        <position>
          <xsl:copy-of select="$r"/>
        </position>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="step">
          <xsl:with-param name="r" select="$r"/>
          <xsl:with-param name="n" select="$n"/>
          <xsl:with-param name="v" select="$s"/>
          <xsl:with-param name="s" select="$s"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="step">
    <xsl:param name="r"/>
    <xsl:param name="n"/>
    <xsl:param name="v"/>
    <xsl:param name="s"/>
    <xsl:if test="$v != 0">
      <xsl:variable name="c">
        <xsl:call-template name="check">
          <xsl:with-param name="r" select="$r"/>
          <xsl:with-param name="v" select="$v"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$c != 0">
        <xsl:variable name="l">
          <xsl:value-of select="concat($v,$r)"/> 
        </xsl:variable>
        <xsl:call-template name="queens">
          <xsl:with-param name="r" select="$l"/>
          <xsl:with-param name="n" select="$n - 1"/>
          <xsl:with-param name="s" select="$s"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="step">
        <xsl:with-param name="r" select="$r"/>
        <xsl:with-param name="n" select="$n"/>
        <xsl:with-param name="v" select="$v - 1"/>
        <xsl:with-param name="s" select="$s"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="check">
    <xsl:param name="r"/>
    <xsl:param name="v"/>
    <xsl:if test="contains($r,$v)">0</xsl:if>
  </xsl:template>

</xsl:stylesheet>
