<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v4.3 (http://www.xmlspy.com) by Gary Simons (SIL International) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--The "subsumption-test" mode compiles a feature structure into an XPath that implements a subsumption test-->
	<xsl:template match="fs" mode="subsumption-test">
		<xsl:choose>
			<xsl:when test="name(..)!='f'">
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
		<xsl:text>']</xsl:text>
		<xsl:if test="* and name(*)!='any'">
			<xsl:text>/</xsl:text>
			<xsl:apply-templates mode="subsumption-test"/>
		</xsl:if>
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
	<!--The "serialize-fs" mode produces a serialzed string representationi of a feature structure.-->
	<xsl:template match="fs" mode="serialize-fs">
		<xsl:text> [ </xsl:text>
		<xsl:for-each select="f">
			<xsl:if test="position()!=1">
				<xsl:text>; </xsl:text>
			</xsl:if>
			<xsl:value-of select="@name"/>
			<xsl:text>: </xsl:text>
			<xsl:choose>
				<xsl:when test="fs">
					<xsl:value-of select="fs/@type"/>
					<xsl:apply-templates mode="serialize-fs"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="serialize-fs"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:text>  ]</xsl:text>
	</xsl:template>
	<xsl:template match="sym" mode="serialize-fs">
		<xsl:value-of select="@value"/>
	</xsl:template>
	<xsl:template match="plus" mode="serialize-fs">
		<xsl:text> +</xsl:text>
	</xsl:template>
	<xsl:template match="minus" mode="serialize-fs">
		<xsl:text> -</xsl:text>
	</xsl:template>
	<xsl:template match="any" mode="serialize-fs">
		<xsl:text> any</xsl:text>
	</xsl:template>
</xsl:stylesheet>
