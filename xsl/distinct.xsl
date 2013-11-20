<?xml version="1.0"?> 

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">

  <xsl:import href="utils.xsl"/>

  <xsl:template match="result">
    <result>
      <xsl:apply-templates/>
    </result>
  </xsl:template>

  <xsl:template match="position">
    <xsl:variable name="l" select="preceding-sibling::*"/>
    <xsl:variable name="a" select="."/>
    <xsl:variable name="b">
      <xsl:call-template name="flip">
        <xsl:with-param name="x" select="$a"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="c">
      <xsl:call-template name="reverse">
        <xsl:with-param name="x" select="$b"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="d">
      <xsl:call-template name="flip">
        <xsl:with-param name="x" select="$c"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="e">
      <xsl:call-template name="rotate">
        <xsl:with-param name="x" select="$a"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="f">
      <xsl:call-template name="flip">
        <xsl:with-param name="x" select="$e"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="g">
      <xsl:call-template name="reverse">
        <xsl:with-param name="x" select="$f"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="h">
      <xsl:call-template name="flip">
        <xsl:with-param name="x" select="$g"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$b = $l"></xsl:when>
      <xsl:when test="$c = $l"></xsl:when>
      <xsl:when test="$d = $l"></xsl:when>
      <xsl:when test="$e = $l"></xsl:when>
      <xsl:when test="$f = $l"></xsl:when>
      <xsl:when test="$g = $l"></xsl:when>
      <xsl:when test="$h = $l"></xsl:when>
      <xsl:otherwise>
        <position>
          <xsl:value-of select="$a"/>
        </position>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
