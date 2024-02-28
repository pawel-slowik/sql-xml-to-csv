<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
>
	<xsl:output indent="no" omit-xml-declaration="yes" method="text"/>

	<xsl:template match="/">

		<!-- header row -->
		<xsl:for-each select="/resultset/row[1]/field">
			<xsl:text>"</xsl:text>
				<xsl:value-of select="str:replace(@name, '&quot;', '\&quot;')"/>
			<xsl:text>"</xsl:text>
			<xsl:if test="position() != last()">
				<xsl:text>,</xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:text>&#xa;</xsl:text>

		<!-- data rows -->
		<xsl:for-each select="/resultset/row">
			<xsl:for-each select="field">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="str:replace(str:replace(., '&quot;', '\&quot;'), '&#xa;', '\n')"/>
				<xsl:text>"</xsl:text>
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>&#xa;</xsl:text>
		</xsl:for-each>

	</xsl:template>

</xsl:stylesheet>
