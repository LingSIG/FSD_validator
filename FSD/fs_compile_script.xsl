<?xml version="1.0" encoding="UTF-8"?>
<!-- fs_compile_script.xls
     G. Simons, 14 Sept 2002

     Generates a batch file for validating the feature structures in an XML document
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="utf-8"/>
	<xsl:param name="data"/>
	<xsl:variable name="fsd">
		<xsl:value-of select="document($data)/processing-instruction()[name()='fsd']/@href"/>
	</xsl:variable>
	<xsl:variable name="nl">
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:variable>
	<xsl:variable name="xsl-processor">
		<xsl:text>\msxsl</xsl:text>
	</xsl:variable>
	<xsl:template match="/processing-instruction()[name()='fsd']/@href">
		<xsl:value-of select="$xsl-processor"/>
		<xsl:text>msxsl RRG.xml RRG-Overview.xsl -o </xsl:text>
		<xsl:value-of select="$hisPath"/>
		<xsl:text>\registries.htm</xsl:text>
		<xsl:value-of select="$nl"/>
		<xsl:value-of select="$msxslPath"/>
		<xsl:text>msxsl RRG.xml RRG-Register.xsl -o </xsl:text>
		<xsl:value-of select="$hisPath"/>
		<xsl:value-of select="$sitesPath"/>
		<xsl:text>\register.htm</xsl:text>
		<xsl:value-of select="$nl"/>
		<xsl:apply-templates select="registry/codeSet[webSite]"/>
	</xsl:template>
	<xsl:template match="codeSet">
		<xsl:value-of select="$msxslPath"/>
		<xsl:text>msxsl RRG.xml RRG-Sites.xsl -o </xsl:text>
		<xsl:value-of select="$hisPath"/>
		<xsl:value-of select="$sitesPath"/>
		<xsl:text>\</xsl:text>
		<xsl:value-of select="code"/>
		<xsl:text>.htm codeSet=</xsl:text>
		<xsl:value-of select="code"/>
		<xsl:value-of select="$nl"/>
	</xsl:template>
</xsl:stylesheet>
