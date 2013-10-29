<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
<xsl:template match="//fs[@type='pronoun']" priority="1">
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
