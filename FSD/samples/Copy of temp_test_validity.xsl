<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v4.3 (http://www.xmlspy.com) by Gary Simons (SIL International) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:template match="//fs[@type='pronoun']/f[@name='pron-type']" priority="1">
		<xsl:if test="not(sym[@value='personal'] | sym[@value='demonstrative'])">
			<dt>
				<xsl:apply-templates select="." mode="get-full-path"/>
			</dt>
			<dd>
				<p>The value of the feature named <b>pron-type</b> should be: sym[@value='personal'] | sym[@value='demonstrative']</p>
			</dd>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//fs[@type='pronoun']/f[@name='person']" priority="1">
		<xsl:if test="not(sym[@value='1st'] | sym[@value='2nd'] | sym[@value='3rd'])">
			<dt>
				<xsl:apply-templates select="." mode="get-full-path"/>
			</dt>
			<dd>
				<p>The value of the feature named <b>person</b> should be: sym[@value='1st'] | sym[@value='2nd'] | sym[@value='3rd']</p>
			</dd>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//fs[@type='pronoun']/f[@name='number']" priority="1">
		<xsl:if test="not(sym[@value='singular'] | sym[@value='plural'])">
			<dt>
				<xsl:apply-templates select="." mode="get-full-path"/>
			</dt>
			<dd>
				<p>The value of the feature named <b>number</b> should be: sym[@value='singular'] | sym[@value='plural']</p>
			</dd>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//fs[@type='pronoun']/f[@name='gender']" priority="1">
		<xsl:if test="not(sym[@value='masculine'] | sym[@value='feminine'] | sym[@value='neuter'])">
			<dt>
				<xsl:apply-templates select="." mode="get-full-path"/>
			</dt>
			<dd>
				<p>The value of the feature named <b>gender</b> should be: sym[@value='masculine'] | sym[@value='feminine'] | sym[@value='neuter']</p>
			</dd>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//f" priority="0">
		<xsl:call-template name="report-error">
			<xsl:with-param name="fs" select=".."/>
		</xsl:call-template>
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
	<xsl:template match="*" mode="get-full-path">
		<xsl:apply-templates select="parent::*" mode="get-full-path"/>
		<xsl:text>/</xsl:text>
		<xsl:if test="count(. | ../@*) = count(../@*)">@</xsl:if>
		<xsl:value-of select="name()"/>
		<xsl:if test="count(../*[name()=name(current())]) &gt; 1">
			<xsl:text>[</xsl:text>
			<xsl:value-of select="1+count(preceding-sibling::*[name()=name(current())])"/>
			<xsl:text>]</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template match="fs" mode="display-fs">
		<table>
			<xsl:for-each select="f">
				<tr>
					<td>
						<xsl:if test="position()=1">
							<sup>
								<i>
									<xsl:value-of select="../@type"/>
								</i>
							</sup>
							<xsl:text> [</xsl:text>
						</xsl:if>
					</td>
					<td>
						<xsl:value-of select="@name"/>
						<xsl:text>:</xsl:text>
					</td>
					<td>
						<xsl:apply-templates mode="display-fs"/>
					</td>
					<td>
						<xsl:if test="position()=last()">
							<xsl:text>]</xsl:text>
						</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
	<xsl:template match="sym" mode="display-fs">
		<xsl:value-of select="@value"/>
	</xsl:template>
	<xsl:template name="report-error">
		<xsl:param name="error"/>
		<xsl:param name="fs"/>
		<p>
			<xsl:text>In </xsl:text>
			<xsl:apply-templates select="." mode="get-full-path"/>
			<xsl:text>:</xsl:text>
		</p>
		<blockquote>
			<xsl:apply-templates select="$fs" mode="display-fs"/>
		</blockquote>
		<dd>
			<xsl:text>The feature named </xsl:text>
			<b>
				<xsl:value-of select="@name"/>
			</b>
			<xsl:text> is not defined in the FSD.</xsl:text>
		</dd>
	</xsl:template>
</xsl:stylesheet>
