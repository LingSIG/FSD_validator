<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="//fs[@type='GPSG']">
		<xsl:copy>
			<xsl:call-template name="copy-attributes"/>
			<xsl:if test="not(f[@name='INV'])">
				<xsl:element name="f">
					<xsl:attribute name="name">INV</xsl:attribute>
					<xsl:element name="plus"/>
				</xsl:element>
			</xsl:if>
			<xsl:element name="yes"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="//fs[@type='GPSG'][f[@name='VFORM']/sym[@value='INF']][f[@name='SUBJ']/plus]" priority="-1">
		<xsl:copy>
			<xsl:call-template name="copy-attributes"/>
			<xsl:apply-templates/>
			<xsl:element name="yes"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="*">
		<xsl:copy>
			<xsl:call-template name="copy-attributes"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template name="copy-attributes">
		<xsl:for-each select="@*">
			<xsl:copy-of select="."/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
