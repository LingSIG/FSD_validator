<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v4.3 (http://www.xmlspy.com) by Gary Simons (SIL International) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:axsl="ThisIsAnAliasForXSLT">
	<!--The "bin" parameter is the file path on the user's system of the directory in which this software is located.-->
	<xsl:param name="bin"/>
	<xsl:param name="data" select="'data file'"/>
	<xsl:param name="fsd" select="'FSD file'"/>
	<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>
	<xsl:strip-space elements="*"/>
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:include href="fsv_compile_subsumption.xsl"/>
	<xsl:template match="/teiFsd2">
		<axsl:stylesheet version="1.0">
			<axsl:output method="html" encoding="UTF-8" indent="yes"/>
			<axsl:include>
				<xsl:attribute name="href"><xsl:if test="$bin"><xsl:text>file:</xsl:text><xsl:value-of select="$bin"/></xsl:if><xsl:text>fsv_tests_core.xsl</xsl:text></xsl:attribute>
			</axsl:include>
			<axsl:template match="/">
				<html>
					<head>
						<title>Report of feature structure validity</title>
					</head>
					<body>
						<h1>Report of Feature Structure Validity</h1>
						<p>
							<xsl:text>This document reports on the validity of the feature structures that occur in the document </xsl:text>
							<a href="{$data}">
								<xsl:value-of select="$data"/>
							</a>
							<xsl:text>. They have been tested against the feature structure declarations defined in </xsl:text>
							<a href="{$fsd}">
								<xsl:value-of select="$fsd"/>
							</a>
							<xsl:text>. The </xsl:text>
							<i>head</i>
							<xsl:text> elements within the data file have been repeated below as centered headings to help you locate problem feature structures within the orginal document. If the report below contains nothing but headings from your document, than all of the feature structures are valid.</xsl:text>
						</p>
						<hr/>
						<axsl:apply-templates/>
					</body>
				</html>
			</axsl:template>
			<xsl:apply-templates select="//fDecl|//fsDecl"/>
		</axsl:stylesheet>
	</xsl:template>
	<xsl:template match="fsDecl">
		<axsl:template match="//fs[@type='{@type}']" priority="1">
			<!--Complie the constraints for this fs type-->
			<xsl:apply-templates select="fsConstraints/*"/>
			<axsl:apply-templates/>
		</axsl:template>
	</xsl:template>
	<xsl:template match="bicond | cond">
		<xsl:variable name="subsumption-test1">
			<xsl:apply-templates select="fs[1]" mode="subsumption-test"/>
		</xsl:variable>
		<xsl:variable name="subsumption-test2">
			<xsl:apply-templates select="fs[2]" mode="subsumption-test"/>
		</xsl:variable>
		<xsl:variable name="fs1">
			<xsl:apply-templates select="fs[1]" mode="serialize-fs"/>
		</xsl:variable>
		<xsl:variable name="fs2">
			<xsl:apply-templates select="fs[2]" mode="serialize-fs"/>
		</xsl:variable>
		<axsl:if test="{$subsumption-test1}">
			<axsl:if test="not({$subsumption-test2})">
				<axsl:call-template name="report-error">
					<axsl:with-param name="error" select="'constraint'"/>
					<axsl:with-param name="arg" select="'{$fs1}'"/>
					<axsl:with-param name="arg2" select="'{$fs2}'"/>
					<axsl:with-param name="fs" select="."/>
				</axsl:call-template>
			</axsl:if>
		</axsl:if>
		<!--If the constraint is biconditional, test it the other way around as well.-->
		<xsl:if test="name(.) = 'bicond'">
			<axsl:if test="{$subsumption-test2}">
				<axsl:if test="not({$subsumption-test1})">
					<axsl:call-template name="report-error">
						<axsl:with-param name="error" select="'constraint'"/>
						<axsl:with-param name="arg" select="'{$fs2}'"/>
						<axsl:with-param name="arg2" select="'{$fs1}'"/>
						<axsl:with-param name="fs" select="."/>
					</axsl:call-template>
				</axsl:if>
			</axsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="fDecl">
		<xsl:variable name="value-test">
			<xsl:apply-templates select="vRange" mode="value-test"/>
		</xsl:variable>
		<axsl:template match="//fs[@type='{../@type}']/f[@name='{@name}']" priority="1">
			<xsl:if test="@org='unit' or not(@org)">
				<axsl:if test="count(*) > 1">
					<axsl:call-template name="report-error">
						<axsl:with-param name="error" select="'multiValue'"/>
						<axsl:with-param name="arg" select="@name"/>
						<axsl:with-param name="fs" select=".."/>
					</axsl:call-template>
				</axsl:if>
			</xsl:if>
			<axsl:for-each select="*">
				<axsl:if test="not({$value-test})">
					<axsl:call-template name="report-error">
						<axsl:with-param name="error" select="'badValue'"/>
						<axsl:with-param name="arg" select="../@name"/>
						<axsl:with-param name="fs" select="../.."/>
					</axsl:call-template>
				</axsl:if>
			</axsl:for-each>
		</axsl:template>
	</xsl:template>
	<xsl:template match="fs" mode="value-test">
		<xsl:text>name(.)='fs'</xsl:text>
		<xsl:if test="@type">
			<xsl:text> and @type='</xsl:text>
			<xsl:value-of select="@type"/>
			<xsl:text>'</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="vAlt" mode="value-test">
		<xsl:apply-templates mode="value-test"/>
	</xsl:template>
	<xsl:template match="sym" mode="value-test">
		<xsl:if test="position() != 1">
			<xsl:text> or </xsl:text>
		</xsl:if>
		<xsl:text>@value='</xsl:text>
		<xsl:value-of select="@value"/>
		<xsl:text>'</xsl:text>
	</xsl:template>
	<xsl:template match="plus|minus|str" mode="value-test">
		<xsl:if test="position() != 1">
			<xsl:text> or </xsl:text>
		</xsl:if>
		<xsl:text>name(.)='</xsl:text>
		<xsl:value-of select="name(.)"/>
		<xsl:text>'</xsl:text>
	</xsl:template>
</xsl:stylesheet>
