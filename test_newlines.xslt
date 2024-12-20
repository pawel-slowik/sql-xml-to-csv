<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings"
>
	<xsl:output method="text"/>

	<xsl:template match="/root">
		contains 0A / \n: <xsl:value-of select="contains(., '&#xa;')"/>
		contains 0D / \r: <xsl:value-of select="contains(., '&#xd;')"/>
	</xsl:template>

</xsl:stylesheet>
