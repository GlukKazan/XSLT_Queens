<?xml version="1.0"?> 

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:redirect="http://xml.apache.org/xalan/redirect"
  extension-element-prefixes="redirect"
  version="1.0">

<xsl:output method="html"/>

  <xsl:template match="/result/position">
    <a href="{concat(. , '.html')}">
      <xsl:value-of select="."/>
    </a><br/>
    <redirect:write select="concat('xml/', . , '.html')">
      <style>
      table {
       display:block;
       margin:10px;
       border:0;
       border-collapse: collapse;
      }
      table tr {
       border:0;
      }
      table tr td {
       border:1px solid #999;
       width:15px;
       height:15px;
       padding: 0;
      }
      .active {
       background: #898989;
      }
      </style>
      <table border="1" style="border-collapse:collapse">
        <xsl:call-template name="line">
          <xsl:with-param name="r" select="."/>
          <xsl:with-param name="s" select="string-length(.)"/>
        </xsl:call-template>
      </table>
    </redirect:write>
  </xsl:template>

  <xsl:template name="line">
    <xsl:param name="r"/>
    <xsl:param name="s"/>
    <xsl:if test="string-length($r) != 0">
      <xsl:variable name="x" select="substring($r,1,1)"/>
      <tr>
        <xsl:call-template name="col">
          <xsl:with-param name="x" select="$x"/>
          <xsl:with-param name="i" select="$s"/>
        </xsl:call-template>
      </tr>
      <xsl:call-template name="line">
        <xsl:with-param name="r" select="substring($r,2)"/>
        <xsl:with-param name="s" select="$s"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="col">
    <xsl:param name="x"/>
    <xsl:param name="i"/>
    <xsl:if test="$i != 0">
      <xsl:choose>
        <xsl:when test="$x = $i"><td class="active"/></xsl:when>
        <xsl:otherwise><td/></xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="col">
        <xsl:with-param name="x" select="$x"/>
        <xsl:with-param name="i" select="$i - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
