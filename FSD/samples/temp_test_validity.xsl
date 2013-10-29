<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes" />
<xsl:include href="file:C:\-\Projects\Sgml\TEI\FSD\bin\fsv_tests_core.xsl" />
<xsl:template match="/">
<html>
<head>
<title>Report of feature structure validity</title>
</head>
<body>
<h1>Report of Feature Structure Validity</h1>
<p>This document reports on the validity of the feature structures that occur in the document <a href="Eng_Pronoun_test.xml">Eng_Pronoun_test.xml</a>. They have been tested against the feature structure declarations defined in <a href="Eng_Pronoun.fsd">Eng_Pronoun.fsd</a>. The <i>head</i> elements within the data file have been repeated below as centered headings to help you locate problem feature structures within the orginal document. If the report below contains nothing but headings from your document, than all of the feature structures are valid.</p>
<hr />
<xsl:apply-templates />
</body>
</html>
</xsl:template>
<xsl:template match="//fs[@type='pronoun']" priority="1">
<xsl:if test="current()[f[@name='pron-type']/sym[@value='personal']]">
<xsl:if test="not(current()[f[@name='person']][f[@name='number']])">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'constraint'" />
<xsl:with-param name="arg" select="' [ pron-type: personal  ]'" />
<xsl:with-param name="arg2" select="' [ person:  any; number:  any  ]'" />
<xsl:with-param name="fs" select="." />
</xsl:call-template>
</xsl:if>
</xsl:if>
<xsl:if test="current()[f[@name='person']][f[@name='number']]">
<xsl:if test="not(current()[f[@name='pron-type']/sym[@value='personal']])">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'constraint'" />
<xsl:with-param name="arg" select="' [ person:  any; number:  any  ]'" />
<xsl:with-param name="arg2" select="' [ pron-type: personal  ]'" />
<xsl:with-param name="fs" select="." />
</xsl:call-template>
</xsl:if>
</xsl:if>
<xsl:if test="current()[f[@name='person']/sym[@value='3rd']][f[@name='number']/sym[@value='singular']]">
<xsl:if test="not(current()[f[@name='gender']])">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'constraint'" />
<xsl:with-param name="arg" select="' [ person: 3rd; number: singular  ]'" />
<xsl:with-param name="arg2" select="' [ gender:  any  ]'" />
<xsl:with-param name="fs" select="." />
</xsl:call-template>
</xsl:if>
</xsl:if>
<xsl:if test="current()[f[@name='gender']]">
<xsl:if test="not(current()[f[@name='person']/sym[@value='3rd']][f[@name='number']/sym[@value='singular']])">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'constraint'" />
<xsl:with-param name="arg" select="' [ gender:  any  ]'" />
<xsl:with-param name="arg2" select="' [ person: 3rd; number: singular  ]'" />
<xsl:with-param name="fs" select="." />
</xsl:call-template>
</xsl:if>
</xsl:if>
<xsl:apply-templates />
</xsl:template>
<xsl:template match="//fs[@type='pronoun']/f[@name='pron-type']" priority="1">
<xsl:if test="count(*) &gt; 1">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'multiValue'" />
<xsl:with-param name="arg" select="@name" />
<xsl:with-param name="fs" select=".." />
</xsl:call-template>
</xsl:if>
<xsl:for-each select="*">
<xsl:if test="not(@value='personal' or @value='demonstrative')">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'badValue'" />
<xsl:with-param name="arg" select="../@name" />
<xsl:with-param name="fs" select="../.." />
</xsl:call-template>
</xsl:if>
</xsl:for-each>
</xsl:template>
<xsl:template match="//fs[@type='pronoun']/f[@name='person']" priority="1">
<xsl:if test="count(*) &gt; 1">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'multiValue'" />
<xsl:with-param name="arg" select="@name" />
<xsl:with-param name="fs" select=".." />
</xsl:call-template>
</xsl:if>
<xsl:for-each select="*">
<xsl:if test="not(@value='1st' or @value='2nd' or @value='3rd')">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'badValue'" />
<xsl:with-param name="arg" select="../@name" />
<xsl:with-param name="fs" select="../.." />
</xsl:call-template>
</xsl:if>
</xsl:for-each>
</xsl:template>
<xsl:template match="//fs[@type='pronoun']/f[@name='number']" priority="1">
<xsl:if test="count(*) &gt; 1">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'multiValue'" />
<xsl:with-param name="arg" select="@name" />
<xsl:with-param name="fs" select=".." />
</xsl:call-template>
</xsl:if>
<xsl:for-each select="*">
<xsl:if test="not(@value='singular' or @value='plural')">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'badValue'" />
<xsl:with-param name="arg" select="../@name" />
<xsl:with-param name="fs" select="../.." />
</xsl:call-template>
</xsl:if>
</xsl:for-each>
</xsl:template>
<xsl:template match="//fs[@type='pronoun']/f[@name='gender']" priority="1">
<xsl:if test="count(*) &gt; 1">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'multiValue'" />
<xsl:with-param name="arg" select="@name" />
<xsl:with-param name="fs" select=".." />
</xsl:call-template>
</xsl:if>
<xsl:for-each select="*">
<xsl:if test="not(@value='masculine' or @value='feminine' or @value='neuter')">
<xsl:call-template name="report-error">
<xsl:with-param name="error" select="'badValue'" />
<xsl:with-param name="arg" select="../@name" />
<xsl:with-param name="fs" select="../.." />
</xsl:call-template>
</xsl:if>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
