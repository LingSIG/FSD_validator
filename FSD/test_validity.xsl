<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes" />
<xsl:template match="//fs[@type='GPSG']/f[@name='INV']" priority="1">
<xsl:if test="not(plus | minus)">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<p>The value of the feature named <b>INV</b> should be: plus | minus</p>
</dd>
</xsl:if>
</xsl:template>
<xsl:template match="//fs[@type='GPSG']/f[@name='CONJ']" priority="1">
<xsl:if test="not(sym[@value='and'] | sym[@value='both'] | sym[@value='but'] | sym[@value='either'] | sym[@value='neither'] | sym[@value='nor'] | sym[@value='or'] | sym[@value='NIL'])">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<p>The value of the feature named <b>CONJ</b> should be: sym[@value='and'] | sym[@value='both'] | sym[@value='but'] | sym[@value='either'] | sym[@value='neither'] | sym[@value='nor'] | sym[@value='or'] | sym[@value='NIL']</p>
</dd>
</xsl:if>
</xsl:template>
<xsl:template match="//fs[@type='GPSG']/f[@name='COMP']" priority="1">
<xsl:if test="not(sym[@value='for'] | sym[@value='that'] | sym[@value='whether'] | sym[@value='if'] | sym[@value='NIL'])">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<p>The value of the feature named <b>COMP</b> should be: sym[@value='for'] | sym[@value='that'] | sym[@value='whether'] | sym[@value='if'] | sym[@value='NIL']</p>
</dd>
</xsl:if>
</xsl:template>
<xsl:template match="//fs[@type='GPSG']/f[@name='AGR']" priority="1">
<xsl:if test="not(fs[@type='Agreement'])">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<p>The value of the feature named <b>AGR</b> should be: fs[@type='Agreement']</p>
</dd>
</xsl:if>
</xsl:template>
<xsl:template match="//fs[@type='GPSG']/f[@name='PFORM']" priority="1">
<xsl:if test="not(str)">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<p>The value of the feature named <b>PFORM</b> should be: str</p>
</dd>
</xsl:if>
</xsl:template>
<xsl:template match="//fs[@type='Agreement']/f[@name='PERS']" priority="1">
<xsl:if test="not(sym[@value='1'] | sym[@value='2'] | sym[@value='3'])">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<p>The value of the feature named <b>PERS</b> should be: sym[@value='1'] | sym[@value='2'] | sym[@value='3']</p>
</dd>
</xsl:if>
</xsl:template>
<xsl:template match="//fs[@type='Agreement']/f[@name='NUM']" priority="1">
<xsl:if test="not(sym[@value='sg'] | sym[@value='pl'])">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<p>The value of the feature named <b>NUM</b> should be: sym[@value='sg'] | sym[@value='pl']</p>
</dd>
</xsl:if>
</xsl:template>
<xsl:template match="//f" priority="0">
<dt>
<xsl:apply-templates select="." mode="get-full-path" />
</dt>
<dd>
<xsl:text>The feature named </xsl:text>
<b>
<xsl:value-of select="@name" />
</b>
<xsl:text> is not defined in the FSD.</xsl:text>
</dd>
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
<xsl:template match="*" mode="get-full-path">
<xsl:apply-templates select="parent::*" mode="get-full-path" />
<xsl:text>/</xsl:text>
<xsl:if test="count(. | ../@*) = count(../@*)">@</xsl:if>
<xsl:value-of select="name()" />
<xsl:if test="count(../*[name()=name(current())]) &gt; 1">
<xsl:text>[</xsl:text>
<xsl:value-of select="1+count(preceding-sibling::*[name()=name(current())])" />
<xsl:text>]</xsl:text>
</xsl:if>
</xsl:template>
</xsl:stylesheet>
