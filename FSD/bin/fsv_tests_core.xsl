<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XML Spy v4.3 (http://www.xmlspy.com) by Gary Simons (SIL International) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="//fs" priority="0">
		<xsl:call-template name="report-error">
			<xsl:with-param name="error" select="'badType'"/>
			<xsl:with-param name="arg" select="@type"/>
			<xsl:with-param name="fs" select="."/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="//f" priority="0">
		<xsl:choose>
			<xsl:when test="@name and not(@name = '')">
				<xsl:call-template name="report-error">
					<xsl:with-param name="error" select="'badName'"/>
					<xsl:with-param name="arg" select="@name"/>
					<xsl:with-param name="fs" select=".."/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="report-error">
					<xsl:with-param name="error" select="'noName'"/>
					<xsl:with-param name="fs" select=".."/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--The "get-full-path" mode generates an XPath expression that uniquely identifies the position of a feature structure within the document.-->
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
	<!--The "display-fs" mode produces a tabular view of a feature structure.-->
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
	<xsl:template match="plus" mode="display-fs">
		<xsl:text> + </xsl:text>
	</xsl:template>
	<xsl:template match="minus" mode="display-fs">
		<xsl:text> - </xsl:text>
	</xsl:template>
	<!--This template is called to generate an error report, which consists of an XPath to identify the location of the fs, the error message, a representation of the offending feature structue, and (in the case of  a constraint violation) a description of the constraint.-->
	<xsl:template name="report-error">
		<xsl:param name="error"/>
		<xsl:param name="arg"/>
		<xsl:param name="arg2"/>
		<xsl:param name="fs"/>
		<h3>
			<xsl:text>In </xsl:text>
			<xsl:apply-templates select="." mode="get-full-path"/>
			<xsl:text>:</xsl:text>
		</h3>
		<xsl:choose>
			<xsl:when test="$error='badType'">
				<blockquote>
					<xsl:text>The feature structure type </xsl:text>
					<i>
						<xsl:value-of select="$arg"/>
					</i>
					<xsl:text> is not defined in the FSD.</xsl:text>
				</blockquote>
			</xsl:when>
			<xsl:when test="$error='badName'">
				<blockquote>
					<xsl:text>The feature named </xsl:text>
					<i>
						<xsl:value-of select="$arg"/>
					</i>
					<xsl:text> is not defined for the current fs type.</xsl:text>
				</blockquote>
			</xsl:when>
			<xsl:when test="$error='noName'">
				<blockquote>
					<xsl:text>A feature has no name.</xsl:text>
				</blockquote>
			</xsl:when>
			<xsl:when test="$error='badName'">
				<blockquote>
					<xsl:text>The feature named </xsl:text>
					<i>
						<xsl:value-of select="$arg"/>
					</i>
					<xsl:text> is not defined for the current fs type.</xsl:text>
				</blockquote>
			</xsl:when>
			<xsl:when test="$error='badValue'">
				<blockquote>
					<xsl:text>The value of the feature named </xsl:text>
					<i>
						<xsl:value-of select="$arg"/>
					</i>
					<xsl:text> is not in the value range defined for it in the FSD.</xsl:text>
				</blockquote>
			</xsl:when>
			<xsl:when test="$error='multiValue'">
				<blockquote>
					<xsl:text>The feature named </xsl:text>
					<i>
						<xsl:value-of select="$arg"/>
					</i>
					<xsl:text> is not allowed to have more than one value.</xsl:text>
				</blockquote>
			</xsl:when>
			<xsl:when test="$error='constraint'">
				<blockquote>
					<xsl:text>The feature structure violates a constraint.</xsl:text>
				</blockquote>
			</xsl:when>
			<xsl:otherwise>
				<blockquote>
					<xsl:text>Unexplained error.</xsl:text>
				</blockquote>
			</xsl:otherwise>
		</xsl:choose>
		<blockquote>
			<xsl:apply-templates select="$fs" mode="display-fs"/>
		</blockquote>
		<xsl:if test="$error='constraint'">
			<blockquote>
				<dt>If the feature structure has:</dt>
				<dd>
					<xsl:value-of select="$arg"/>
				</dd>
				<dt>It must also have:</dt>
				<dd>
					<xsl:value-of select="$arg2"/>
				</dd>
			</blockquote>
		</xsl:if>
	</xsl:template>
	<!--Copy heads to the error report to help give context for the reported errors.-->
	<xsl:template match="head">
		<h2 align="center">
			<xsl:value-of select="."/>
		</h2>
	</xsl:template>
	<!--Suppress output of anything else-->
	<xsl:template match="*">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="@*|text()"/>
</xsl:stylesheet>
