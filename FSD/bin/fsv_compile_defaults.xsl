<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v4.3 (http://www.xmlspy.com) by Gary Simons (SIL International) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:axsl="ThisIsAnAliasForXSLT">
	<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
	<xsl:strip-space elements="*"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:include href="fsv_compile_subsumption.xsl"/>
	<xsl:template match="/teiFsd2">
		<axsl:stylesheet version="1.0">
			<axsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
			<xsl:apply-templates select="fsDecl"/>
			<axsl:template match="//fs|*" priority="0">
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
		</axsl:stylesheet>
	</xsl:template>
	<xsl:template match="fsDecl">
		<axsl:template match="//fs[@type='{@type}']" priority="1">
			<axsl:copy>
				<axsl:call-template name="copy-attributes"/>
				<axsl:apply-templates/>
				<xsl:apply-templates select="fDecl"/>
			</axsl:copy>
		</axsl:template>
	</xsl:template>
	<xsl:template match="fDecl">
		<xsl:if test="vDefault">
			<axsl:if test="not(f[@name='{@name}'])">
				<xsl:choose>
					<xsl:when test="vDefault/if">
						<xsl:for-each select="vDefault/if">
							<xsl:variable name="subsumption-test">
								<xsl:apply-templates select="*[1]" mode="subsumption-test"/>
							</xsl:variable>
							<axsl:if test="{$subsumption-test}">
								<axsl:element name="f">
									<axsl:attribute name="name">
										<xsl:value-of select="../../@name"/>
									</axsl:attribute>
									<xsl:copy-of select="*[last()]"/>
								</axsl:element>
							</axsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<axsl:element name="f">
							<axsl:attribute name="name">
								<xsl:value-of select="@name"/>
							</axsl:attribute>
							<xsl:copy-of select="vDefault/*"/>
						</axsl:element>
					</xsl:otherwise>
				</xsl:choose>
			</axsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="fs" mode="subsumption-test">
		<xsl:choose>
			<xsl:when test="name(..)='if'">
				<xsl:text>current()</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>fs</xsl:text>
				<xsl:if test="@type">
					<xsl:text>[@type='</xsl:text>
					<xsl:value-of select="@type"/>
					<xsl:text>']</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates mode="subsumption-test"/>
	</xsl:template>
	<xsl:template match="f" mode="subsumption-test">
		<xsl:text>[f[@name='</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>']/</xsl:text>
		<xsl:apply-templates mode="subsumption-test"/>
		<xsl:text>]</xsl:text>
	</xsl:template>
	<xsl:template match="sym" mode="subsumption-test">
		<xsl:text>sym[@value='</xsl:text>
		<xsl:value-of select="@value"/>
		<xsl:text>']</xsl:text>
	</xsl:template>
	<xsl:template match="plus|minus" mode="subsumption-test">
		<xsl:value-of select="name(.)"/>
	</xsl:template>
</xsl:stylesheet>
