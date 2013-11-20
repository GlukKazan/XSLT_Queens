<?xml version="1.0"?> 

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">

  <xsl:template match="result">
    <result>
      <xsl:apply-templates/>
    </result>
  </xsl:template>

  <xsl:template match="position">
    <position>
      <xsl:value-of select="."/>
    </position>
    <flip>
      <xsl:call-template name="flip">
        <xsl:with-param name="x" select="."/>
      </xsl:call-template>
    </flip>
    <reverse>
      <xsl:call-template name="reverse">
        <xsl:with-param name="x" select="."/>
      </xsl:call-template>
    </reverse>
    <rotate>
      <xsl:call-template name="rotate">
        <xsl:with-param name="x" select="."/>
      </xsl:call-template>
    </rotate>
  </xsl:template>

  <xsl:template name="flip">
    <xsl:param name="x"/>
    <xsl:call-template name="flip_internal">
      <xsl:with-param name="x" select="$x"/>
      <xsl:with-param name="s" select="string-length($x) + 1"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="flip_internal">
    <xsl:param name="x"/>
    <xsl:param name="s"/>
    <xsl:if test="string-length($x) != 0">
      <xsl:value-of select="$s - substring($x,1,1)"/>
      <xsl:call-template name="flip_internal">
        <xsl:with-param name="x" select="substring($x,2)"/>
        <xsl:with-param name="s" select="$s"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- XSLT Cookbook By Sal Mangano http://shop.oreilly.com/product/9780596003722.do -->
  <xsl:template name="reverse">
    <xsl:param name="x"/>
    <xsl:variable name="len" select="string-length($x)"/>
    <xsl:choose>
      <xsl:when test="$len &lt; 2">
        <xsl:value-of select="$x"/>
      </xsl:when>
      <xsl:when test="$len = 2">
        <xsl:value-of select="substring($x,2,1)"/>
        <xsl:value-of select="substring($x,1,1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="mid" select="floor($len div 2)"/>
        <xsl:call-template name="reverse">
          <xsl:with-param name="x" select="substring($x,$mid+1,$mid+1)"/>
        </xsl:call-template>
        <xsl:call-template name="reverse">
          <xsl:with-param name="x" select="substring($x,1,$mid)"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="rotate">
    <xsl:param name="x"/>
    <xsl:call-template name="rotate_internal">
      <xsl:with-param name="x" select="$x"/>
      <xsl:with-param name="i" select="1"/>
      <xsl:with-param name="r"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="rotate_internal">
    <xsl:param name="x"/>
    <xsl:param name="i"/>
    <xsl:param name="r"/>
    <xsl:variable name="p">
      <xsl:call-template name="index-of">
        <xsl:with-param name="input" select="$x"/>
        <xsl:with-param name="substr" select="$i"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$p = 0">
        <xsl:value-of select="$r"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="rotate_internal">
          <xsl:with-param name="x" select="$x"/>
          <xsl:with-param name="i" select="$i + 1"/>
          <xsl:with-param name="r" select="concat($p,$r)"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- XSLT Cookbook By Sal Mangano http://shop.oreilly.com/product/9780596003722.do -->
  <xsl:template name="index-of">
    <xsl:param name="input"/>
    <xsl:param name="substr"/>
    <xsl:choose>
      <xsl:when test="contains($input,$substr)">
        <xsl:value-of select="string-length(substring-before($input,$substr))+1"/>
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
