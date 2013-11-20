<?xml version="1.0"?> 

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">

  <xsl:import href="solution.xsl"/>

  <xsl:template name="check">
    <xsl:param name="r"/>
    <xsl:param name="v"/>
    <xsl:choose>
      <xsl:when test="contains($r,$v)">0</xsl:when>
      <xsl:otherwise>
        <xsl:variable name="y">
          <xsl:call-template name="additional_check">
            <xsl:with-param name="r" select="$r"/>
            <xsl:with-param name="v" select="$v"/>
            <xsl:with-param name="d" select="1"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$y"/> 
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="additional_check">
    <xsl:param name="r"/>
    <xsl:param name="v"/>
    <xsl:param name="d"/>
    <xsl:if test="$d &lt;= string-length($r)">
      <xsl:variable name="u" select="substring($r,$d,1)"/>
      <xsl:variable name="b">
        <xsl:call-template name="abs">
          <xsl:with-param name="x" select="$v - $u"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$b = $d">0</xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="additional_check">
            <xsl:with-param name="r" select="$r"/>
            <xsl:with-param name="v" select="$v"/>
            <xsl:with-param name="d" select="$d + 1"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template name="abs">
    <xsl:param name="x"/>
    <xsl:choose>
      <xsl:when test="$x &lt; 0">
        <xsl:value-of select="$x * -1"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$x"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
