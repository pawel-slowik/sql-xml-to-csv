<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
>
	<xsl:param name="column_separator" select="','" />
	<xsl:param name="column_enclosed_by" select="'&quot;'" />

	<xsl:output indent="no" omit-xml-declaration="yes" method="text"/>

	<xsl:template match="/">

		<!-- header row -->
		<xsl:for-each select="((/resultset)|(/mysqldump/database/table_data))/row[1]/field">
			<xsl:value-of select="$column_enclosed_by"/>
			<xsl:value-of select="str:replace(@name, $column_enclosed_by, concat('\', $column_enclosed_by))"/>
			<xsl:value-of select="$column_enclosed_by"/>
			<xsl:if test="position() != last()">
				<xsl:value-of select="$column_separator" />
			</xsl:if>
		</xsl:for-each>
		<xsl:text>&#xa;</xsl:text>

		<!-- data rows -->
		<xsl:for-each select="((/resultset)|(/mysqldump/database/table_data))/row">
			<xsl:for-each select="field">
				<xsl:value-of select="$column_enclosed_by"/>
				<xsl:value-of select="str:replace(str:replace(., $column_enclosed_by, concat('\', $column_enclosed_by)), '&#xa;', '\n')"/>
				<xsl:value-of select="$column_enclosed_by"/>
				<xsl:if test="position() != last()">
					<xsl:value-of select="$column_separator" />
				</xsl:if>
			</xsl:for-each>
			<xsl:text>&#xa;</xsl:text>
		</xsl:for-each>

	</xsl:template>

</xsl:stylesheet>
