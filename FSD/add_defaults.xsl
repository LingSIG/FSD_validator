<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
<xsl:template match="//fs[@type='GPSG']" priority="1">
<xsl:copy>
<xsl:call-template name="copy-attributes" />
<xsl:apply-templates />
<xsl:if test="not(f[@name='INV'])">
<xsl:element name="f">
<xsl:attribute name="name">INV</xsl:attribute>
<minus />
</xsl:element>
</xsl:if>
<xsl:if test="not(f[@name='CONJ'])">
<xsl:element name="f">
<xsl:attribute name="name">CONJ</xsl:attribute>
<none />
</xsl:element>
</xsl:if>
<xsl:if test="not(f[@name='COMP'])">
<xsl:if test="current()[f[@name='VFORM']/sym[@value='INF']][f[@name='SUBJ']/plus]">
<xsl:element name="f">
<xsl:attribute name="name">COMP</xsl:attribute>
<sym value="for" />
</xsl:element>
</xsl:if>
</xsl:if>
</xsl:copy>
</xsl:template>
<xsl:template match="//fs[@type='Agreement']" priority="1">
<xsl:copy>
<xsl:call-template name="copy-attributes" />
<xsl:apply-templates />
</xsl:copy>
</xsl:template>
<xsl:template match="//fs|*" priority="0">
<xsl:copy>
<xsl:call-template name="copy-attributes" />
<xsl:apply-templates />
</xsl:copy>
</xsl:template>
<xsl:template name="copy-attributes">
<xsl:for-each select="@*">
<xsl:copy-of select="." />
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
