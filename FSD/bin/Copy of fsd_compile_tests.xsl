<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v4.3 U (http://www.xmlspy.com) by Gary Simons (SIL International) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:axsl="ThisIsAnAliasForXSLT">
	<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
	<xsl:strip-space elements="*"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/teiFsd2">
		<axsl:stylesheet version="1.0">
			<axsl:output method="html" encoding="UTF-8" indent="yes"/>
			<xsl:apply-templates select="//fDecl"/>
			<axsl:template match="//f" priority="0">
				<dt>
					<axsl:apply-templates select="." mode="get-full-path"/>
				</dt>
				<dd>
					<axsl:text>The feature named </axsl:text>
					<b>
						<axsl:value-of select="@name"/>
					</b>
					<axsl:text> is not defined in the FSD.</axsl:text>
				</dd>
				<axsl:copy>
					<axsl:call-template name="copy-attributes"/>
					<axsl:apply-templates/>
				</axsl:copy>
			</axsl:template>
			<axsl:template name="copy-attributes">
				<axsl:for-each select="@*">
					<axsl:copy-of select="."/>
				</axsl:for-each>
			</axsl:template>
			<axsl:template match="*" mode="get-full-path">
				<axsl:apply-templates select="parent::*" mode="get-full-path"/>
				<axsl:text>/</axsl:text>
				<axsl:if test="count(. | ../@*) = count(../@*)">@</axsl:if>
				<axsl:value-of select="name()"/>
				<axsl:if test="count(../*[name()=name(current())]) > 1">
					<axsl:text>[</axsl:text>
					<axsl:value-of select="1+count(preceding-sibling::*[name()=name(current())])"/>
					<axsl:text>]</axsl:text>
				</axsl:if>
			</axsl:template>
		</axsl:stylesheet>
	</xsl:template>
	<xsl:template match="fsDecl"/>
	<xsl:template match="fDecl">
		<xsl:variable name="value-test">
			<xsl:apply-templates select="vRange" mode="value-test"/>
		</xsl:variable>
		<axsl:template match="//fs[@type='{../@type}']/f[@name='{@name}']" priority="1">
			<axsl:if test="not({$value-test})">
				<dt>
					<axsl:apply-templates select="." mode="get-full-path"/>
				</dt>
				<dd>
					<p>
						<xsl:text>The value of the feature named </xsl:text>
						<b>
							<xsl:value-of select="@name"/>
						</b>
						<xsl:text> should be: </xsl:text>
						<xsl:value-of select="$value-test"/>
					</p>
				</dd>
			</axsl:if>
		</axsl:template>
	</xsl:template>
	<xsl:template match="fs" mode="value-test">
		<xsl:text>fs</xsl:text>
		<xsl:if test="@type">
			<xsl:text>[@type='</xsl:text>
			<xsl:value-of select="@type"/>
			<xsl:text>']</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="vAlt" mode="value-test">
		<xsl:apply-templates mode="value-test"/>
	</xsl:template>
	<xsl:template match="sym" mode="value-test">
		<xsl:if test="position() != 1">
			<xsl:text> | </xsl:text>
		</xsl:if>
		<xsl:text>sym[@value='</xsl:text>
		<xsl:value-of select="@value"/>
		<xsl:text>']</xsl:text>
	</xsl:template>
	<xsl:template match="plus|minus|str" mode="value-test">
		<xsl:if test="position() != 1">
			<xsl:text> | </xsl:text>
		</xsl:if>
		<xsl:value-of select="name(.)"/>
	</xsl:template>
</xsl:stylesheet>
